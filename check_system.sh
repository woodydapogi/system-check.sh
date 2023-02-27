#!/bin/bash
#

echo "###"
echo "# Linux Admin"
echo "###"
echo

TOTAL_RAM=$(free -h | grep Mem | awk '{print $2}')
USED_RAM=$(free -hm | awk NR==2'{print $3 * 10}' | cut -d 'G' -f 1)


TOTAL_DISK=$(df -h | awk NR==2'{print $2}')
USED_DISK=$(df -h | awk NR==2'{print $3}' | cut -d 'G' -f 1)

CPU_SYSTEM=$(iostat | awk NR==4'{print $3}' | cut -d '.' -f 1)

SYSTEM_CHECK=("$USED_RAM" "$USED_DISK" "$CPU_SYSTEM")

#Checking the server's performance.
function system_performance() {
    echo "---"
    echo "Total RAM: $TOTAL_RAM"
    echo "---"
    echo "Total Disk: $TOTAL_DISK"

    echo
    echo "#####"
    echo
    
    #Memory usage check
    if [[ $USED_RAM -ge 100 ]]; then
        echo "Alert: Memory Utilization"
    else
        echo "Memory Usage: ${SYSTEM_CHECK[0]}%"
    fi

    echo "---"

    #Disk usage check
    if [[ $USED_DISK -ge 1000 ]]; then
        echo "Alert: Disk Utilization"
    else
        echo "Disk Usage: ${SYSTEM_CHECK[1]} Gb"
    fi

    echo "---"

    #Checking CPU Utilization.
    if [[ $CPU_SYSTEM -ge 100 ]]; then
        echo "Alert: CPU Utitlization"
    else
        echo "CPU Usage: ${SYSTEM_CHECK[2]}%"
    fi
}
