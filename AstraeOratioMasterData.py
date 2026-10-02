from __future__ import annotations

import base64
import hashlib
import json
import os
import shutil
import subprocess
import xml.etree.ElementTree as ET
import zipfile
from pathlib import Path
from typing import Any, Dict, List, Optional

from Crypto.Cipher import AES

# TableExtract.DecryptAes: AES-256-GCM + PBKDF2(HMAC-SHA256, 100000)
TABLE_PASSWORD = "UIDragCamera_{rev}_QueueExtensions"
TABLE_SALT = "RealTime_{n}"
SALT_MULTIPLIER = 2703


def table_key(table_revision: int) -> bytes:
    password = TABLE_PASSWORD.format(rev=table_revision)
    salt_str = TABLE_SALT.format(n=SALT_MULTIPLIER * table_revision)
    salt = hashlib.sha256(salt_str.encode()).digest()
    return hashlib.pbkdf2_hmac("sha256", password.encode(), salt, 100000, dklen=32)


def decrypt_table_dat(path: Path, table_revision: int) -> bytes:
    """Table.dat = [nonce 12B][GCM tag 16B][ciphertext] -> zip 字节。"""
    return decrypt_table_dat_entry(path.read_bytes(), table_revision)


def decrypt_table_dat_entry(data: bytes, table_revision: int) -> bytes:
    cipher = AES.new(table_key(table_revision), AES.MODE_GCM, nonce=data[:12], mac_len=16)
    return cipher.decrypt_and_verify(data[28:], data[12:28])


_DB_KEY_A = b"k9!v@P2#"
_DB_KEY_B = b"X7zR9w2Q"
_DB_SEED = _DB_KEY_A + _DB_KEY_B


def db_passkey(db_name: str) -> str:
    lowered = db_name.lower()
    raw = lowered.encode("utf-8")
    h = _xxh64(raw, 0)
    text = str(h)
    seed = bytearray(hashlib.sha256(_DB_SEED).digest())
    for i in range(32):
        seed[i] = (seed[i] ^ ((i + ord(db_name[i % len(db_name)])) & 0xFF)) & 0xFF
    payload = text.encode("utf-8")
    out = bytes(seed[j % 32] ^ payload[j] for j in range(len(payload)))
    return base64.b64encode(out).decode()


def _xxh64(data: bytes, seed: int = 0) -> int:
    try:
        import xxhash
        return xxhash.xxh64(data, seed=seed).intdigest()
    except ImportError:
        pass
    P1 = 0x9E3779B185EBCA87
    P2 = 0xC2B2AE3D27D4EB4F
    P3 = 0x165667B19E3779F9
    P4 = 0x85EBCA77C2B2AE63
    P5 = 0x27D4EB2F165667C5
    M = (1 << 64) - 1

    def rotl(x, r):
        return ((x << r) | (x >> (64 - r))) & M

    def round64(acc, val):
        acc = (acc + val * P2) & M
        acc = rotl(acc, 31)
        return (acc * P1) & M

    def merge(acc, val):
        val = round64(0, val)
        acc ^= val
        return (acc * P1 + P4) & M

    n = len(data)
    if n >= 32:
        v1 = (seed + P1 + P2) & M
        v2 = (seed + P2) & M
        v3 = seed & M
        v4 = (seed - P1) & M
        i = 0
        while i + 32 <= n:
            v1 = round64(v1, int.from_bytes(data[i:i + 8], "little"))
            v2 = round64(v2, int.from_bytes(data[i + 8:i + 16], "little"))
            v3 = round64(v3, int.from_bytes(data[i + 16:i + 24], "little"))
            v4 = round64(v4, int.from_bytes(data[i + 24:i + 32], "little"))
            i += 32
        h = (rotl(v1, 1) + rotl(v2, 7) + rotl(v3, 12) + rotl(v4, 18)) & M
        for v in (v1, v2, v3, v4):
            h = merge(h, v)
    else:
        h = (seed + P5) & M
        i = 0
    h = (h + n) & M
    while i + 8 <= n:
        k = round64(0, int.from_bytes(data[i:i + 8], "little"))
        h = ((rotl(h ^ k, 27) * P1) + P4) & M
        i += 8
    if i + 4 <= n:
        h ^= (int.from_bytes(data[i:i + 4], "little") * P1) & M
        h = ((rotl(h & M, 23) * P2) + P3) & M
        i += 4
    while i < n:
        h ^= (data[i] * P5) & M
        h = (rotl(h, 11) * P1) & M
        i += 1
    h ^= h >> 33
    h = (h * P2) & M
    h ^= h >> 29
    h = (h * P3) & M
    h ^= h >> 32
    return h


def decrypt_scenario_db(db_path: Path, db_name: str, out_path: Path) -> bool:
    passkey = db_passkey(db_name)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    if out_path.exists():
        out_path.unlink()
    sql = (
        f"PRAGMA key = '{passkey}';"
        f"ATTACH DATABASE '{out_path.as_posix()}' AS plain KEY '';"
        "SELECT sqlcipher_export('plain');"
        "DETACH plain;"
    )
    tmp = db_path.parent / (db_path.name + ".copy")
    shutil.copy(db_path, tmp)
    r = subprocess.run(["sqlcipher", str(tmp), sql], capture_output=True, text=True, timeout=300)
    tmp.unlink(missing_ok=True)
    ok = out_path.exists() and out_path.stat().st_size > 0
    return ok


def scenario_db_to_json(db_path: Path, out_dir: Path, db_name: str) -> List[Path]:
    import sqlite3
    plain = out_dir.parent / f"{db_name}.sqlite"
    decrypted = decrypt_scenario_db(db_path, db_name, plain)
    if not decrypted:
        return []
    conn = sqlite3.connect(plain)
    cur = conn.cursor()
    tables = [r[0] for r in cur.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name != 'android_metadata'")]
    written = []
    for table in tables:
        cols = [c[1] for c in cur.execute(f'PRAGMA table_info("{table}")')]
        rows = [dict(zip(cols, row)) for row in cur.execute(f'SELECT * FROM "{table}"')]
        doc = {"table": table, "db": db_name, "columns": cols, "rows": rows}
        stem = db_name if len(tables) == 1 else f"{db_name}.{table}"
        dst = out_dir / f"{stem}.json"
        dst.write_text(json.dumps(doc, ensure_ascii=False, indent=2, default=str), encoding="utf-8")
        written.append(dst)
    conn.close()
    plain.unlink(missing_ok=True)
    return written


def extract_tables(zip_data: bytes, out_dir: Path) -> List[Path]:
    import io
    out_dir.mkdir(parents=True, exist_ok=True)
    zf = zipfile.ZipFile(io.BytesIO(zip_data))
    written = []
    for name in sorted(zf.namelist()):
        if name.endswith("/"):
            continue
        dst = out_dir / name
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.write_bytes(zf.read(name))
        written.append(dst)
    return written



def export_catalog(catalog_bin: Path, out_json: Path) -> Optional[Path]:
    here = str(Path(__file__).resolve().parent)
    if here not in os.sys.path:  # noqa: PTH120
        os.sys.path.insert(0, here)  # noqa: PTH120
    try:
        from UnityCatalogReader import UnityCatalogReader
        reader = UnityCatalogReader(str(catalog_bin))
        entries = {}
        for key, locations in reader.resources.items():
            items = []
            for loc in locations:
                item = {"internal_id": loc.internal_id}
                if loc.bundle_name:
                    item["bundle"] = loc.bundle_name
                    item["size"] = loc.bundle_size
                    if loc.hash:
                        item["hash"] = loc.hash
                items.append(item)
            entries[str(key)] = items
        doc = {
            "locator_id": reader.locator_id,
            "build_result_hash": reader.build_result_hash,
            "keys": len(entries),
            "entries": entries,
        }
        out_json.parent.mkdir(parents=True, exist_ok=True)
        out_json.write_text(json.dumps(doc, ensure_ascii=False, indent=2), encoding="utf-8")
        return out_json
    except Exception:
        return None
