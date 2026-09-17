from __future__ import annotations

import base64
import io
import shutil
import struct
import warnings
from pathlib import Path
from typing import Optional, Tuple

import UnityPy
from Crypto.Cipher import AES
from UnityPy.helpers import ArchiveStorageManager

MMAP_AES_KEY = base64.b64decode('xiJ5T2OGDzxuGBMuLwiJKv8jWuiREFlcHx4wksgc8pc=')
MMAP_AES_IV = base64.b64decode('l3RWKhiYyfcbSjoK8p7f6w==')
UNITYCN_KEY = bytes.fromhex("7A346C32336268352333356826333231")
CP_MAGIC = 0x1357FEDA
CP_CODEPHIL = b'CODEPHIL'
CP_VM_OP_COUNT = 64
CP_BLOCK_SIZE = 0x40
M32 = 0xFFFFFFFF
OP_SPECS = [
    ('ror', 3470727520, 163, 2), ('xor', 577163939, 218, 53), ('xor', 1624142554, 53, 36),
    ('ror', 214642229, 36, -1), ('ror', 1554655268, 87, 6), ('ror', 2503849559, 190, 1),
    ('dec', 2546144296, 137, 3353450430), ('ror', 1544179593, 40, 3), ('xor', 2546144296, 75, 226),
    ('dec', 3759807261, 226, 1185940043), ('addsub', 4086531042, 29, -108), ('dec', 1872906879, 108, 3759807261),
    ('swap', 2690842988, 127, -1400472762), ('addsub', 1872906879, 70, 15), ('dec', 1608406000, 241, 2894494534),
    ('ror', 623101169, 240, 3), ('ror', 1608406000, 243, 2), ('ror', 3936838387, 234, 5),
    ('xor', 3746693610, 5, 180), ('swap', 812695813, 180, -294363225), ('xor', 2770907060, 167, 206),
    ('dec', 780059481, 206, 4000604071), ('xor', 1025956814, 89, 184), ('addsub', 780059481, 184, 101),
    ('ror', 1788410040, 155, 2), ('dec', 1515250482, 101, 3353450430), ('dec', 371720811, 10, 4000604071),
    ('swap', 1515250482, 184, 617654763), ('swap', 4209559135, 140, 403816668), ('xor', 4209559135, 228, 140),
    ('xor', 3409153094, 15, 108), ('dec', 3136450637, 221, 1185940043), ('addsub', 3409153094, 63, 163),
    ('addsub', 1250284988, 246, 218), ('swap', 1250284988, 178, -1774390099), ('xor', 1904791333, 199, 163),
    ('swap', 1904791333, 141, -737035542), ('swap', 3470727520, 224, 735626248), ('xor', 214642229, 211, 190),
    ('dec', 2894494534, 103, 3759807261), ('addsub', 2894494534, 14, 87), ('dec', 1185940043, 85, 3353450430),
    ('xor', 3936838387, 83, 155), ('addsub', 1544179593, 237, 40), ('swap', 2503849559, 11, -196147493),
    ('dec', 2337775985, 60, 4000604071), ('swap', 2337775985, 87, 347494539), ('dec', 3353450430, 242, 2894494534),
    ('xor', 4086531042, 12, 10), ('addsub', 2770907060, 247, 5), ('addsub', 1025956814, 219, 75),
    ('swap', 577163939, 129, -1587305260), ('ror', 1872906879, 173, 2), ('swap', 1624142554, 46, -1141384021),
    ('ror', 1515250482, 157, 1), ('dec', 4000604071, 74, 1185940043), ('addsub', 3746693610, 105, 226),
    ('ror', 2770907060, 194, 2), ('ror', 812695813, 203, 7), ('ror', 1250284988, 130, 1),
    ('xor', 623101169, 187, 241), ('ror', 1025956814, 250, 4), ('swap', 371720811, 230, 1729007289),
    ('ror', 4209559135, 111, 7)
]

def _read_vector(reader):
    data = reader.read_bytes(0x10)
    key = reader.read_bytes(0x10)
    reader.Position += 1
    return data, key

def _decrypt_key_aes(key: bytes, data: bytes, keybytes: bytes) -> bytes:
    enc = AES.new(keybytes, AES.MODE_ECB).encrypt(key)
    return bytes(x ^ y for x, y in zip(data, enc))

class TuanjieArchiveDecryptor:
    substitute: bytes = bytes(0x10)

    def __init__(self, reader):
        self.unknown_1 = reader.read_u_int()
        self.data, self.key = _read_vector(reader)
        self.data_sig, self.key_sig = _read_vector(reader)
        reader.Position += 8

        keybytes = ArchiveStorageManager.DECRYPT_KEY or UNITYCN_KEY
        data = _decrypt_key_aes(self.key, self.data, keybytes)
        nibbles = [n for b in data for n in (b >> 4, b & 0xF)]
        index = [0] * 0x10
        for i, nibble in enumerate(nibbles[:0x10]):
            index[nibble] = i
        self.index = bytes(index)
        self.substitute = bytes(
            nibbles[0x10 + i * 4 + j] for j in range(4) for i in range(4)
        )

    def decrypt_block(self, data, index):
        offset = 0
        size = len(data)
        data = bytearray(data)
        view = memoryview(data)
        while offset < len(data):
            offset += self.decrypt(view[offset:], index, size - offset)
            index += 1
        return data

    def decrypt_byte(self, view, offset, index):
        b = (
            self.substitute[((index >> 2) & 3) + 4]
            + self.substitute[index & 3]
            + self.substitute[((index >> 4) & 3) + 8]
            + self.substitute[(index % 256 >> 6) + 12]
        )
        view[offset] = (
            (self.index[view[offset] & 0xF] - b) & 0xF
            | 0x10 * (self.index[view[offset] >> 4] - b)
        ) % 256
        return view[offset], offset + 1, index + 1

    def decrypt(self, data, index, remaining):
        offset = 0
        cur_byte, offset, index = self.decrypt_byte(data, offset, index)
        byte_high = cur_byte >> 4
        byte_low = cur_byte & 0xF
        if byte_high == 0xF:
            b = 0xFF
            while b == 0xFF:
                b, offset, index = self.decrypt_byte(data, offset, index)
                byte_high += b
        offset += byte_high
        if offset < remaining:
            _, offset, index = self.decrypt_byte(data, offset, index)
            _, offset, index = self.decrypt_byte(data, offset, index)
            if byte_low == 0xF:
                b = 0xFF
                while b == 0xFF:
                    b, offset, index = self.decrypt_byte(data, offset, index)
        return offset

def install_unitycn(key: Optional[bytes] = None) -> bytes:
    active_key = key or UNITYCN_KEY
    warnings.filterwarnings("ignore", category=UserWarning, module="UnityPy")
    UnityPy.config.FALLBACK_UNITY_VERSION = "2022.3.62f3"
    UnityPy.set_assetbundle_decrypt_key(active_key)
    ArchiveStorageManager.DECRYPT_KEY = active_key
    ArchiveStorageManager.ArchiveStorageDecryptor = TuanjieArchiveDecryptor
    return active_key

def is_bundle_encrypted(path: Path) -> bool:
    if not path.is_file() or path.stat().st_size < 32:
        return False
    with path.open("rb") as f:
        magic = f.read(7)
    if magic != b"UnityFS":
        return False
    with path.open("rb") as f:
        f.seek(12)
        header_data = f.read(64)
    return b"#$" in header_data or b"UnityFS" in header_data

def decrypt_unitycn_file(src: Path, dst: Path) -> str:
    if not src.is_file():
        return "not_found"

    with src.open("rb") as f:
        magic = f.read(7)
    if magic != b"UnityFS":
        if src != dst:
            dst.parent.mkdir(parents=True, exist_ok=True)
            if dst.exists():
                dst.unlink()
            shutil.copy2(src, dst)
        return "raw"

    install_unitycn()
    try:
        env = UnityPy.load(str(src))
        data = env.file.save()
        dst.parent.mkdir(parents=True, exist_ok=True)
        tmp = dst.with_name(dst.name + ".dec.tmp")
        tmp.write_bytes(data)
        tmp.replace(dst)
        return "unitycn"
    except Exception as e:
        if src != dst:
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)
        return f"err: {e}"


def decrypt_lua_raw(data: bytes) -> bytes:
    dec = bytes(b ^ 0x40 for b in data)
    if len(dec) >= 132 and dec[128:132] == b'\x1bLua':
        return dec[128:]
    elif dec.startswith(b'\x1bLua'):
        return dec
    pos = dec.find(b'\x1bLua')
    if pos != -1:
        return dec[pos:]
    return dec

def decrypt_codephil_vm(data: bytes) -> bytes:
    if len(data) < 0x148:
        return data
    magic, body_size = struct.unpack_from('<II', data, 0)
    if magic != CP_MAGIC:
        return data
    if 0x148 + body_size > len(data):
        return data

    key = list(data[8 : 8 + 256])
    ops = list(data[0x108 : 0x108 + 64])
    body = bytearray(data[0x148 : 0x148 + body_size])

    def vm_step(sub_op, block, rem_len):
        name = sub_op[0]
        a1, a2, a3 = sub_op[1], sub_op[2], sub_op[3]
        if name == 'dec':
            t1 = (a1 + (a2 ^ a3)) & M32
            t2 = (key[(t1 & 0xFF)] + t1) & M32
            rem_idx = t2 % rem_len
            key_idx = (t2 + rem_idx) & 0xFF
            block[rem_idx] = (block[rem_idx] - key[key_idx]) & 0xFF
        elif name == 'addsub':
            t1 = (a1 + (a2 ^ a3)) & M32
            t2 = (key[(t1 & 0xFF)] + t1) & M32
            rem_idx = t2 % rem_len
            key_idx = (t2 + rem_idx) & 0xFF
            block[rem_idx] = (block[rem_idx] + key[key_idx]) & 0xFF
        elif name == 'xor':
            t1 = (a1 + (a2 ^ a3)) & M32
            t2 = (key[(t1 & 0xFF)] + t1) & M32
            rem_idx = t2 % rem_len
            key_idx = (t2 + rem_idx) & 0xFF
            block[rem_idx] ^= key[key_idx]
        elif name == 'swap':
            t1 = (a1 + (a2 ^ a3)) & M32
            t2 = (key[(t1 & 0xFF)] + t1) & M32
            i1 = t2 % rem_len
            i2 = (t2 + key[(t2 & 0xFF)]) % rem_len
            block[i1], block[i2] = block[i2], block[i1]
        elif name == 'ror':
            t1 = (a1 + (a2 ^ a3)) & M32
            t2 = (key[(t1 & 0xFF)] + t1) & M32
            rem_idx = t2 % rem_len
            b = block[rem_idx]
            s = a3 & 7
            block[rem_idx] = ((b >> s) | (b << (8 - s))) & 0xFF

    for offset in range(0, body_size, CP_BLOCK_SIZE):
        rem_len = min(CP_BLOCK_SIZE, body_size - offset)
        block = body[offset : offset + rem_len]
        for op in ops:
            sub_op = OP_SPECS[op]
            vm_step(sub_op, block, rem_len)
        body[offset : offset + rem_len] = block

    if bytes(body[:8]) == CP_CODEPHIL:
        return bytes(body[8:])
    return bytes(body)




def decrypt_mmap_keys(enc_keys_blob: bytes) -> bytes:
    from Crypto.Util.Padding import unpad
    cipher = AES.new(MMAP_AES_KEY, AES.MODE_CBC, MMAP_AES_IV)
    return unpad(cipher.decrypt(enc_keys_blob), 16)

def decrypt_mmap_buffer(data: bytes) -> Tuple[int, bytes]:
    if len(data) < 8:
        return 0, data
    ver = int.from_bytes(data[:4], 'little')
    enc_key_len = int.from_bytes(data[4:8], 'little')
    if ver != 1 or enc_key_len != 4112 or len(data) < 8 + enc_key_len:
        return 0, data

    header_len = 8 + enc_key_len
    enc_keys_blob = data[8:header_len]
    mmap_keys = decrypt_mmap_keys(enc_keys_blob)
    expanded_keys = mmap_keys + mmap_keys

    body = data[header_len:]
    body_len = len(body)
    out = bytearray(body_len)
    offset = 0

    while offset < body_len:
        pos = header_len + offset
        in_block_offset = pos & 0xFFF
        chunk_len = min(4096 - in_block_offset, body_len - offset)
        blk_idx = (pos >> 12) & 0xFF
        shift = mmap_keys[blk_idx]
        key_start = shift + in_block_offset
        sub_keys = expanded_keys[key_start : key_start + chunk_len]

        k_int = int.from_bytes(sub_keys, 'big')
        b_int = int.from_bytes(body[offset : offset + chunk_len], 'big')
        out[offset : offset + chunk_len] = (k_int ^ b_int).to_bytes(chunk_len, 'big')
        offset += chunk_len

    return 5, bytes(out)

def decrypt_meta_version(data: bytes) -> bytes:
    if data.startswith(b'CPMV'):
        cpmv_ver = struct.unpack_from('<I', data, 4)[0]
        inner = data[8:]
        if len(inner) >= 4 and struct.unpack_from('<I', inner, 0)[0] == CP_MAGIC:
            return decrypt_codephil_vm(inner)
        return inner
    elif len(data) >= 4 and struct.unpack_from('<I', data, 0)[0] == CP_MAGIC:
        return decrypt_codephil_vm(data)
    return data
