import os

SRC = "data"
INPLACE = True
DST = "decrypted"

MAGIC = b"FCI\x00"


def calc_hash(name: str) -> int:
    h = 0x01234567
    for ch in name.encode("utf-8"):
        h = (0x89ABCDEF * (ch ^ h)) & 0xFFFFFFFF
    return (0x89ABCDEF * h) & 0xFFFFFFFF


def decrypt(data: bytes, name: str) -> bytes:
    if not data.startswith(MAGIC):
        return data
    payload = bytearray(data[4:])
    kh = calc_hash(name)
    key = [(kh >> (8 * i)) & 0xFF for i in range(4)]
    for i in range(len(payload)):
        payload[i] ^= key[(i + i // 4) % 4]
    return bytes(payload)


def get_name(relpath: str) -> str:
    base = os.path.basename(relpath)
    root, ext = os.path.splitext(base)
    return root


def main() -> None:
    total = encrypted = plain = failed = 0
    for root, _dirs, files in os.walk(SRC):
        for fn in files:
            src = os.path.join(root, fn)
            rel = os.path.relpath(src, SRC)
            with open(src, "rb") as fh:
                raw = fh.read()
            total += 1
            if raw.startswith(MAGIC):
                name = get_name(rel)
                out = decrypt(raw, name)
                encrypted += 1
            else:
                out = raw
                plain += 1
            dst = src if INPLACE else os.path.join(DST, rel)
            if not INPLACE:
                os.makedirs(os.path.dirname(dst), exist_ok=True)
            with open(dst, "wb") as fh:
                fh.write(out)
    print(f"total={total} encrypted={encrypted} plain={plain}")


if __name__ == "__main__":
    main()
