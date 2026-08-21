import base64
import gzip
import hashlib
import json
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
import msgpack

# RemoteResourceManager::LocalLoadTextBytes
# 还有个gamedata.bytes解出来400m太大了我就不放了
def decrypt(input_path: str, output_path: str):
    hiv = base64.b64decode("ZTg3NjU0MzIxMGFiY2RlZg==")
    key = "simple_xor_key".encode('utf-8')
    fiv = bytearray(len(hiv))
    for i in range(len(hiv)):
        fiv[i] = hiv[i] ^ (key[i % len(key)])
    with open(input_path, 'rb') as f:
        enc = f.read()
    cipher = AES.new(hashlib.sha256("VenusZeus".encode('utf-8')).digest(), AES.MODE_CBC, iv=bytes(fiv))
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(msgpack.unpackb(gzip.decompress(unpad(cipher.decrypt(enc), AES.block_size)), raw=False), f, indent=4, ensure_ascii=False)

if __name__ == '__main__':
    decrypt("tablekeys.bytes", "tablekeys.json")