import hashlib
from Crypto.Cipher import DES
from Crypto.Util.Padding import unpad
import os
from sys import argv


def get_des_key():

    md5_hasher = hashlib.md5()
    md5_hasher.update("qdiazawh".encode('utf-8'))
    md5_hex_string = md5_hasher.hexdigest()
    common_key_string = md5_hex_string[-8:]

    return common_key_string.encode('utf-8')

def dec(path, key, iv):

    cipher = DES.new(key, DES.MODE_CBC, iv)

    with open(path, 'rb') as f_enc:
        enc= f_enc.read()

    with open(path, 'wb') as f_dec:
        f_dec.write(unpad(cipher.decrypt(enc), DES.block_size))


def decrypt(path):
    des_key = get_des_key()
    
    for root, _, files in os.walk(path):
        for file in files:
            if file.endswith('.lua'):
                file_path = os.path.join(root, file)
                dec(file_path, des_key, bytes.fromhex("6F9732CD7BDEB92D"))

if __name__ == "__main__":
    decrypt(argv[1])