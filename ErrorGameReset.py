import os
import json
import gzip
import glob
from Cryptodome.Cipher import AES
from Cryptodome.Protocol.KDF import PBKDF2
from Cryptodome.Hash import SHA1
from Cryptodome.Util.Padding import unpad

def decrypt(i, o):
    with open(i, 'rb') as f:
        f.read(4)
        salt_iv = f.read(16)
        enc = f.read()

    dec = unpad((AES.new(PBKDF2("FH`[GBsrAd&%^as*#SDFds",
            salt_iv, dkLen=16, count=10, hmac_hash_module=SHA1),
            AES.MODE_CBC, salt_iv)).decrypt(enc), AES.block_size)

    with open(o, "w", encoding="utf-8") as f:
        json.dump(json.loads((gzip.decompress(dec[10:])).decode('utf-8')), f, indent=4, ensure_ascii=False)


if __name__ == '__main__':
    os.makedirs("MasterData", exist_ok=True)
    for i in glob.glob(os.path.join("cache", "*.d")):
        decrypt(i, os.path.join("MasterData", f"{os.path.splitext(os.path.basename(i))[0]}.json"))
