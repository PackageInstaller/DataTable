import hashlib
from Crypto.Cipher import DES
from Crypto.Util.Padding import unpad
import argparse
import os

IV_HEX = "6F9732CD7BDEB92D"
IV_BYTES = bytes.fromhex(IV_HEX)

def get_des_key():
    initial_string = "qdiazawh"

    md5_hasher = hashlib.md5()
    md5_hasher.update(initial_string.encode('utf-8'))
    md5_hex_string = md5_hasher.hexdigest()
    common_key_string = md5_hex_string[-8:]
    des_key_bytes = common_key_string.encode('utf-8')
    return des_key_bytes

def decrypt_file(encrypted_file_path, des_key_bytes, iv_bytes):
    try:
        cipher = DES.new(des_key_bytes, DES.MODE_CBC, iv_bytes)

        with open(encrypted_file_path, 'rb') as f_enc:
            encrypted_data = f_enc.read()

        decrypted_padded_data = cipher.decrypt(encrypted_data)
        decrypted_data = unpad(decrypted_padded_data, DES.block_size)

        with open(encrypted_file_path, 'wb') as f_dec:
            f_dec.write(decrypted_data)

        return True

    except ValueError:
        return False

def decrypt_directory(directory_path):
    des_key = get_des_key()
    
    for root, _, files in os.walk(directory_path):
        for file in files:
            if file.endswith('.lua'):
                file_path = os.path.join(root, file)
                decrypt_file(file_path, des_key, IV_BYTES)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="解密lua")
    parser.add_argument("input_directory")
    args = parser.parse_args()

    decrypt_directory(args.input_directory)
    print("解密完成")