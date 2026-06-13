import os
import sys
import hashlib

KEY_STRING = "异尘达米拉拉"
md5_hex = hashlib.md5(KEY_STRING.encode("utf-8")).hexdigest()
KEY_BYTES = md5_hex.encode("utf-8")


def decrypt(data: bytes) -> bytes:
    dec = bytearray(len(data))
    kl = len(KEY_BYTES)
    for i in range(len(data)):
        dec[i] = data[i] ^ KEY_BYTES[i % kl]
    return bytes(dec)


def decrypt_file(fp: str):
    with open(fp, "rb") as f:
        data = f.read()
    with open(fp, "wb") as f:
        f.write(decrypt(data))

    print(f"{fp}")


if __name__ == "__main__":
    for root, _, files in os.walk(sys.argv[1]):
        for file in files:
            decrypt_file(os.path.join(root, file))