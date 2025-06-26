import requests
import os
import json
import hashlib
from Crypto.Cipher import AES
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA256
import gzip

VERSION_API_URL = "https://api.angelicaaster.net/api/web/version"
ASSET_BASE_URL = "https://assets.cdnangelicaaster.net/res/v1/pdUIXVOs6C3p8cM7/"
PBKDF2_KEY = "LhqMEhM2JGfKGVek46hzwUH7jhtGx5J3"
BUNDLE_PREFIX = "SHJZFF5pupZe6ySTuVYnbzdJKNUNAZHEGP7A_"


def fetch_remote_version_json():
    resp = requests.get(VERSION_API_URL)
    resp.raise_for_status()
    return resp.text

def save_version_json(json_text):
    with open("version.json", "w", encoding="utf-8") as f:
        f.write(json.dumps(json.loads(json_text), indent=4))

def get_local_version():
    if os.path.exists("version.json"):
        with open("version.json", "r", encoding="utf-8") as f:
            try:
                local_json = json.load(f)
                return local_json.get("M")
            except Exception as e:
                print(f"[!] 读取本地 version.json 出错: {e}")
                return None
    return None

def compute_bundle_filename(version):
    full_string = BUNDLE_PREFIX + version
    sha256_hash = hashlib.sha256(full_string.encode('utf-8')).hexdigest()
    filename = sha256_hash + ".bundle"
    return filename

def download_bundle(bundle_filename):
    url = ASSET_BASE_URL + bundle_filename
    resp = requests.get(url)
    resp.raise_for_status()
    with open(bundle_filename, "wb") as f:
        f.write(resp.content)
    return bundle_filename

def decrypt_file(encrypted_file_path):
    with open(encrypted_file_path, 'rb') as f:
        encrypted_data = f.read()

    iv = encrypted_data[16:32]  # IV
    encrypted_content = encrypted_data[32:-16]
    salt = encrypted_data[-16:]  # 盐

    key = PBKDF2(
        PBKDF2_KEY,
        salt,
        dkLen=16,  # AES-128
        count=1010,
        hmac_hash_module=SHA256
    )

    cipher = AES.new(key, AES.MODE_CBC, iv)
    decrypted_data = cipher.decrypt(encrypted_content)
    padding_length = decrypted_data[-1]
    decrypted_data = decrypted_data[:-padding_length]
    decompressed_data = gzip.decompress(decrypted_data)
    json_data = json.loads(decompressed_data)
    formatted_json = json.dumps(json_data, indent=4, ensure_ascii=False)

    with open('MasterData.json', 'w', encoding='utf-8') as f:
        f.write(formatted_json)

    print("[+] 解密并保存 MasterData.json")


def main():
    local_version = get_local_version()
    print(f"[*] 本地版本: {local_version}")

    remote_json_text = fetch_remote_version_json()
    remote_version = json.loads(remote_json_text)["M"]
    print(f"[*] 远端版本: {remote_version}")

    need_update = False

    if not os.path.exists("MasterData.json"):
        print("[!] MasterData.json 不存在. 需要下载.")
        need_update = True
    elif local_version != remote_version:
        print("[!] 版本不匹配. 需要更新.")
        need_update = True
    else:
        print("[+] 本地版本已是最新. 无需更新.")

    if need_update:
        save_version_json(remote_json_text)
        bundle_filename = compute_bundle_filename(remote_version)
        downloaded_bundle = download_bundle(bundle_filename)
        decrypt_file(downloaded_bundle)
        os.remove(downloaded_bundle)

if __name__ == "__main__":
    main()
