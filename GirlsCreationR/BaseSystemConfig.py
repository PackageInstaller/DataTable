import io
import base64
import struct
import UnityPy
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from Crypto.Hash import HMAC, SHA256

KEY_BASE = "RWd3NusabzRc"
SECRET_KEY = "dB3aqcLtAmBd"
IV_SIZE = 16

class BinaryReader:
    def __init__(self, stream):
        self._stream = stream

    def read_7bit_encoded_int(self) -> int:
        value = 0
        shift = 0
        while True:
            byte = self._stream.read(1)
            byte_val = ord(byte)
            value |= (byte_val & 0x7F) << shift
            if (byte_val & 0x80) == 0:
                break
            shift += 7
        return value

    def read_string(self) -> str:
        length = self.read_7bit_encoded_int()
        if length == 0:
            return ""
        return self._stream.read(length).decode('utf-8')

class Decryptor:
    def __init__(self, key_base: str, secret_key: str):
        self._aes_key = self._generate_aes_key(key_base, secret_key)

    def _generate_aes_key(self, data_string: str, secret_key_string: str) -> bytes:
        data_bytes = data_string.encode('utf-8')
        secret_key_bytes = secret_key_string.encode('utf-8')
        
        h = HMAC.new(secret_key_bytes, digestmod=SHA256)
        h.update(data_bytes)
        return h.digest()

    def decrypt(self, base64_encrypted_str: str) -> bytes:
        encrypted_data = base64.b64decode(base64_encrypted_str)
        iv = encrypted_data[:IV_SIZE]
        ciphertext = encrypted_data[IV_SIZE:]

        cipher = AES.new(self._aes_key, AES.MODE_CBC, iv)
        decrypted_padded = cipher.decrypt(ciphertext)
        
        return unpad(decrypted_padded, AES.block_size, style='pkcs7')

def extract_config(bundle_path: str) -> bytes:
    bundle = UnityPy.load(bundle_path)
    
    for obj in bundle.objects:
        if obj.type.name == "TextAsset":
            data = obj.read()
            if data.m_Name == "BaseSystemConfig":
                binary_data = data.m_Script.encode('latin-1')
                return binary_data
    
    return b''

def decrypt_config(bundle_path: str):
    binary_data = extract_config(bundle_path)
    stream = io.BytesIO(binary_data)

    decryptor = Decryptor(KEY_BASE, SECRET_KEY)
    config_data = {}

    reader = BinaryReader(stream)
    b64_count = reader.read_string()
    decrypted_count_bytes = decryptor.decrypt(b64_count)
    num_entries = struct.unpack('<i', decrypted_count_bytes)[0]

    for i in range(num_entries):
        b64_key = reader.read_string()
        decrypted_key_bytes = decryptor.decrypt(b64_key)
        key = decrypted_key_bytes.decode('utf-8')

        b64_value = reader.read_string()
        decrypted_value_bytes = decryptor.decrypt(b64_value)
        value = decrypted_value_bytes.decode('utf-8')

        if value == "[BaseSystemEmptyValue]":
            value = ""
        
        config_data[key] = value
        print(f"{key} = {value}")
        
    return config_data

if __name__ == "__main__":
    decrypt_config("68c7fc2368477ad41a45618f013036b4")