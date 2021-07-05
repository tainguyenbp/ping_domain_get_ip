#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PATH_FILE_DOMAIN="$CURRENT_DIR/domain.csv"
PATH_FILE_DOMAIN_IP='domain_ip.log'

function delete_line_empty_file_csv(){

		sed -i /^$/d "$PATH_FILE_SERVER"

}


function check_file_and_run_script() {
  echo "domain_name, ip" > "$PATH_FILE_DOMAIN_IP"
  value_line_csv=0
  delete_line_empty_file_csv
  while read -r domain_name;
  do
        if [ $value_line_csv != 0 ]
                then
                        ip=`ping -c 1 -W 0.1 "$domain" | grep "PING" | awk '{print $3}' | sed 's/(//' | sed 's/)//' | sed 's/://'`
                        echo "$domain_name, $ip" >> $PATH_FILE_DOMAIN_IP
        fi
        value_line_csv=$(($value_line_csv + 1))
  done < $PATH_FILE_DOMAIN
}

check_file_and_run_script
