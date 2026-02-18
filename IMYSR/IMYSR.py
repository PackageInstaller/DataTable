import hashlib
import hmac
import base64
import json
from pathlib import Path
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad


SECRET_KEY = b"dB3aqcLtAmBd"
KEY_BASE = b"RWd3NusabzRc"


def read_7bit(f):
    res = 0
    shift = 0
    while True:
        byte = f.read(1)
        if not byte:
            return None
        b = ord(byte)
        res |= (b & 0x7F) << shift
        if (b & 0x80) == 0:
            break
        shift += 7
    return res


def decrypt_master_file(input_path, output_path, key):
    with open(input_path, "rb") as f:
        l1 = read_7bit(f)
        if l1 is None:
            return
        f.read(l1)
        l2 = read_7bit(f)
        if l2 is None:
            return
        s2_b64 = f.read(l2).decode("utf-8")

    combined_data = base64.b64decode(s2_b64)
    iv = combined_data[:16]
    ciphertext = combined_data[16:]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    decrypted = unpad(cipher.decrypt(ciphertext), AES.block_size)
    json_obj = json.loads(decrypted.decode("utf-8").strip())
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(json_obj, f, indent=4, ensure_ascii=False)

    print(f"[+] 成功: {input_path.name} -> {output_path.name}")


def batch_decrypt(input_folder):
    key = hmac.new(SECRET_KEY, KEY_BASE, hashlib.sha256).digest()
    src_path = Path(input_folder)
    out_path = Path("MasterData")
    out_path.mkdir(exist_ok=True)
    file_list = [p for p in src_path.glob("*") if p.is_file()]
    print(f"[*] 开始解密 {len(file_list)} 个文件到 {out_path.absolute()}...")

    for fp in file_list:
        dest_file = out_path / (fp.name + ".json")
        decrypt_master_file(fp, dest_file, key)


if __name__ == "__main__":
    target_dir = "masterdata"
    batch_decrypt(target_dir)
