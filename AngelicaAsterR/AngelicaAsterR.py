import requests
import os
import json
import hashlib
from Crypto.Cipher import AES
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA256
import gzip


def fetch_remote_version_json():
    resp = requests.get("https://api.angelicaaster.net/api/web/version")
    resp.raise_for_status()
    return resp.text

def save_version_json(json_text):
    with open("version.json", "w", encoding="utf-8") as f:
        f.write(json.dumps(json.loads(json_text), indent=4))

def get_local_version():
    if os.path.exists("version.json"):
        with open("version.json", "r", encoding="utf-8") as f:
            return (json.load(f)).get("M")
    return None

def download_bundle(bundle_filename):
    resp = requests.get("https://assets.cdnangelicaaster.net/res/v1/pdUIXVOs6C3p8cM7/" + bundle_filename)
    resp.raise_for_status()
    with open(bundle_filename, "wb") as f:
        f.write(resp.content)
    return bundle_filename

def decrypt_file(encrypted_file_path):
    with open(encrypted_file_path, 'rb') as f:
        enc = f.read()

    key = PBKDF2(
        "LhqMEhM2JGfKGVek46hzwUH7jhtGx5J3",
        enc[-16:],
        dkLen=16,  # AES-128
        count=1010,
        hmac_hash_module=SHA256
    )

    cipher = AES.new(key, AES.MODE_CBC, enc[16:32])
    dec = cipher.decrypt(enc[32:-16])
    dec = dec[:-(dec[-1])]

    with open('MasterData.json', 'w', encoding='utf-8') as f:
        f.write(json.dumps(json.loads(gzip.decompress(dec)), indent=4, ensure_ascii=False))

def main():

    remote_version = json.loads(fetch_remote_version_json())["M"]

    update = False

    if not os.path.exists("MasterData.json"):
        update = True
    elif get_local_version() != remote_version:
        print("版本不匹配. 需要更新")
        update = True
    else:
        print("本地版本已是最新. 无需更新")

    if update:
        save_version_json(fetch_remote_version_json())
        data = download_bundle(hashlib.sha256(("SHJZFF5pupZe6ySTuVYnbzdJKNUNAZHEGP7A_" + remote_version).encode('utf-8')).hexdigest() + ".bundle")
        decrypt_file(data)
        os.remove(data)

if __name__ == "__main__":
    main()
