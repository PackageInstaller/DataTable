from __future__ import annotations

import hashlib
import io
import os
import re
import shutil
import struct
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from pathlib import Path
from typing import Any, BinaryIO
from urllib.request import urlopen, Request

import UnityPy
from UnityPy.enums import ClassIDType

RAW_HEX_DATA = (
    "73BFEE92D7FA57C22DA6B9CE349E1804EC302F3F527865CBEB04CF54497F622B"
    "C18DE0673D06B755C1EC9C2BFA03FA7502C3EE82A566E70D400AB7F82A26590C"
    "912B4D3540759D747023544FE44123D93E00B031EC8AA9D74772622647AF133E"
    "8A0A96A27A1EF1E61C779D3B8E143961BEBE5A056FF10B6A371DC9298EF92AFD"
)
CRYPTO2_MASK_LIST = struct.unpack("<16Q", bytes.fromhex(RAW_HEX_DATA))
LUA_MAGIC = b"\x1bLuaT"

BASE_CDN_URL = "https://ctsglobal-cdndown.sbside.com/patchfiles/Android"
VERSION_URL = f"{BASE_CDN_URL}/liveVersion.json"

DOWNLOAD_DIR = Path("downloads")
DECRYPTED_DIR = Path("decrypted_scripts")
MASTERDATA_DIR = Path("MasterData")


def read_string(f: BinaryIO) -> str:
    length = 0
    shift = 0
    while True:
        b = f.read(1)
        if not b:
            raise EOFError("Unexpected EOF while reading string length")
        byte = b[0]
        length |= (byte & 0x7F) << shift
        if (byte & 0x80) == 0:
            break
        shift += 7
    if length == 0:
        return ""
    data = f.read(length)
    if len(data) != length:
        raise EOFError(f"Expected {length} bytes, got {len(data)}")
    return data.decode("utf-8")


def parse_json_node(f: BinaryIO) -> Any:
    type_byte = f.read(1)
    if not type_byte:
        raise EOFError("Unexpected EOF")
    node_type = type_byte[0]

    if node_type == 1:  # JSONArray
        count = struct.unpack("<i", f.read(4))[0]
        return [parse_json_node(f) for _ in range(count)]
    elif node_type == 2:  # JSONObject
        count = struct.unpack("<i", f.read(4))[0]
        obj = {}
        for _ in range(count):
            key = read_string(f)
            value = parse_json_node(f)
            obj[key] = value
        return obj
    elif node_type == 3:  # JSONString
        return read_string(f)
    elif node_type == 4:  # JSONNumber
        return struct.unpack("<d", f.read(8))[0]
    elif node_type == 5:  # JSONNull
        return None
    elif node_type == 6:  # JSONBool
        return f.read(1)[0] != 0
    else:
        raise ValueError(f"Unknown JSON node type: {node_type}")


def parse_patch_info(data: bytes) -> dict:
    f = io.BytesIO(data)
    return parse_json_node(f)


@dataclass
class PatchFileInfo:
    name: str
    md5: str
    size: int

    @classmethod
    def from_array(cls, arr: list) -> "PatchFileInfo":
        """从 JSONArray 解析 PatchFileInfo"""
        if len(arr) >= 3:
            return cls(name=str(arr[0]), md5=str(arr[1]), size=int(arr[2]))
        raise ValueError(f"Invalid PatchFileInfo array: {arr}")


def fetch_url(url: str, timeout: int = 30) -> bytes:
    req = Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urlopen(req, timeout=timeout) as resp:
        return resp.read()


def fetch_json(url: str) -> dict:
    import json

    data = fetch_url(url)
    return json.loads(data)


def get_live_version() -> str:
    data = fetch_json(VERSION_URL)
    version_list = data.get("versionList", [])
    if not version_list:
        raise ValueError("No version found in liveVersion.json")
    return version_list[0]["version"]


def get_patch_info(version: str) -> dict:
    url = f"{BASE_CDN_URL}/{version}/PatchInfo.json"
    print(f"下载 PatchInfo: {url}")
    data = fetch_url(url)
    return parse_patch_info(data)


def derive_keystream(file_path: str) -> bytes:
    name = os.path.splitext(os.path.basename(file_path))[0].lower()
    md5_hex = hashlib.md5(name.encode("utf-8")).hexdigest()
    mask1 = int(md5_hex[0:16], 16)
    mask2 = int(md5_hex[16:32], 16)
    mask3 = int(md5_hex[0:8] + md5_hex[16:24], 16)
    mask4 = int(md5_hex[8:16] + md5_hex[24:32], 16)
    return (
        mask1.to_bytes(8, "little")
        + mask2.to_bytes(8, "little")
        + mask3.to_bytes(8, "little")
        + mask4.to_bytes(8, "little")
    )


def crypto_xor(data: bytearray, size: int, keystream: bytes) -> None:
    if size <= 0:
        return
    aligned = (size // 8) * 8
    if aligned:
        head = bytes(data[:aligned])
        ks = keystream * (aligned // 32 + 1)
        ks = ks[:aligned]
        xored = (int.from_bytes(head, "big") ^ int.from_bytes(ks, "big")).to_bytes(
            aligned, "big"
        )
        data[:aligned] = xored
    if aligned < size:
        chunk_idx = (aligned // 8) % (32 // 8)
        buggy_byte = keystream[chunk_idx * 8]
        for i in range(aligned, size):
            data[i] ^= buggy_byte


def decrypt_bundle(data: bytearray, filename: str) -> bool:
    if bytes(data[:8]) == b"UnityFS\0":
        return True  # 已解密

    head = bytearray(data[:212])
    crypto_xor(head, len(head), derive_keystream(filename))

    if bytes(head[:8]) != b"UnityFS\0":
        return False

    data[:212] = head
    return True


def _byte_swap_low32(v: int) -> int:
    high = v & 0xFFFFFFFF00000000
    b0 = v & 0xFF
    b1 = (v >> 8) & 0xFF
    b2 = (v >> 16) & 0xFF
    b3 = (v >> 24) & 0xFF
    return high | (b2 << 24) | (b3 << 16) | (b0 << 8) | b1


def _bit_swap(v: int) -> int:
    return ((v >> 1) & 0x5555555555555555) | ((v << 1) & 0xAAAAAAAAAAAAAAAA)


def crypto2_decrypt(data: bytearray, size: int) -> None:
    if size <= 0:
        return
    mask_count = len(CRYPTO2_MASK_LIST)
    pos = 0
    mask_idx = 0
    while pos < size:
        mask = CRYPTO2_MASK_LIST[mask_idx]
        remaining = size - pos
        if remaining >= 8:
            v = int.from_bytes(data[pos : pos + 8], "little")
            v = _byte_swap_low32(v)
            v = _bit_swap(v)
            v ^= mask
            data[pos : pos + 8] = v.to_bytes(8, "little")
            pos += 8
        else:
            buggy_byte = mask & 0xFF
            for i in range(remaining):
                data[pos + i] ^= buggy_byte
            pos = size
        mask_idx = (mask_idx + 1) % mask_count


def _c_mod(a: int, b: int) -> int:
    import math

    return int(math.fmod(a, b))


def _shift_char(ch: str, range_val: int) -> str:
    code = ord(ch)
    if "A" <= ch <= "Z":
        min_val, max_val = 65, 90
    elif "a" <= ch <= "z":
        min_val, max_val = 97, 122
    elif "0" <= ch <= "9":
        min_val, max_val = 48, 57
    else:
        return ch

    v10 = _c_mod(range_val, (max_val - min_val))
    if v10 == 0:
        if range_val <= 0:
            v10 = -2 if range_val != 0 else 0
        else:
            v10 = 2

    v11 = v10 + code
    if v11 <= max_val:
        if v11 < min_val:
            v13 = min_val % v11
            v11 = max_val - v13 + 1
    else:
        v12 = v11 % max_val
        v11 = min_val + v12 - 1

    return chr(v11)


def decrypt_filename(encrypted_str: str) -> str:
    if not encrypted_str:
        return ""
    shift = -len(encrypted_str)
    return "".join(_shift_char(c, shift) for c in encrypted_str)


def download_file(
    version: str, file_info: PatchFileInfo, dest_dir: Path, max_retries: int = 3
) -> tuple[str, Path | None]:
    url = f"{BASE_CDN_URL}/{version}/{file_info.name}"
    dest_path = dest_dir / file_info.name
    dest_path.parent.mkdir(parents=True, exist_ok=True)

    last_error = None
    for attempt in range(max_retries):
        try:
            data = fetch_url(url, timeout=180)
            dest_path.write_bytes(data)
            return ("ok", dest_path)
        except Exception as e:
            last_error = e
            if attempt < max_retries - 1:
                import time

                time.sleep(2**attempt)

    return (f"error:{last_error}", None)


def extract_raw_script_data(raw_data: bytes) -> bytes:
    # - m_Name: aligned string (length + data + padding)
    # - m_Script: byte array (length + data)
    pos = 0

    # 读取 m_Name 长度
    name_len = struct.unpack("<I", raw_data[pos : pos + 4])[0]
    pos += 4
    # 跳过 m_Name 数据
    pos += name_len
    # 对齐到 4 字节
    pos = (pos + 3) & ~3

    # 读取 m_Script 长度
    script_len = struct.unpack("<I", raw_data[pos : pos + 4])[0]
    pos += 4
    return raw_data[pos : pos + script_len]


def extract_scripts_from_bundle(
    bundle_path: Path, output_dir: Path
) -> list[tuple[str, Path]]:
    results = []

    try:
        data = bytearray(bundle_path.read_bytes())
        if not decrypt_bundle(data, bundle_path.name):
            return [("error:decrypt_failed", bundle_path)]

        env = UnityPy.load(bytes(data))

        container_map = {}
        for obj in env.objects:
            if obj.type == ClassIDType.AssetBundle:
                try:
                    ab_data = obj.read()
                    if hasattr(ab_data, "m_Container"):
                        container_data = ab_data.m_Container
                        it = (
                            container_data.items()
                            if hasattr(container_data, "items")
                            else container_data
                        )
                        for key, val in it:
                            if isinstance(key, str):
                                if hasattr(val, "asset"):
                                    container_map[val.asset.path_id] = key
                                elif hasattr(val, "second") and hasattr(
                                    val.second, "asset"
                                ):
                                    container_map[val.second.asset.path_id] = key
                except Exception:
                    pass

        for obj in env.objects:
            if obj.type == ClassIDType.TextAsset:
                try:
                    text_data = obj.read()
                    raw_data = obj.get_raw_data()
                    script_data = extract_raw_script_data(raw_data)
                    container_path = container_map.get(obj.path_id, text_data.m_Name)
                    out_path = output_dir / container_path
                    out_path.parent.mkdir(parents=True, exist_ok=True)
                    out_path.write_bytes(script_data)
                    results.append(("ok", out_path))
                except Exception as e:
                    results.append((f"error:extract:{e}", bundle_path))

    except Exception as e:
        results.append((f"error:load:{e}", bundle_path))

    return results


SUFFIX_PATTERN = re.compile(r"(_c\.bytes|_c_bytes|_c|_bytes|\.bytes)$", re.IGNORECASE)


def process_lua_file(filepath: Path, output_dir: Path) -> tuple[str, str]:
    filename = filepath.name
    match = SUFFIX_PATTERN.search(filename)

    if not match:
        return ("skip:no_suffix", str(filepath))

    suffix = match.group(1).lower()
    if suffix != "_c.bytes":
        return ("skip:not_c_bytes", str(filepath))

    core_name = filename[: match.start()]
    if not core_name:
        return ("skip:empty_name", str(filepath))

    decrypted_name = decrypt_filename(core_name)

    try:
        data = bytearray(filepath.read_bytes())
    except OSError as e:
        return (f"error:read:{e}", str(filepath))

    if not data:
        return ("skip:empty", str(filepath))

    if bytes(data[:5]) == LUA_MAGIC:
        pass
    else:
        crypto2_decrypt(data, len(data))
        if bytes(data[:5]) != LUA_MAGIC:
            return ("skip:not_luac", f"{filename} => {decrypted_name} (非 Lua 字节码)")

    luac_name = f"{decrypted_name}.luac"
    lua_name = f"{decrypted_name}.lua"

    luac_path = output_dir / luac_name
    lua_path = output_dir / lua_name

    output_dir.mkdir(parents=True, exist_ok=True)
    luac_path.write_bytes(data)

    try:
        result = subprocess.run(
            ["unluac", str(luac_path), "--rawstring"], capture_output=True, text=True, timeout=60
        )
        if result.returncode == 0:
            lua_path.write_text(result.stdout, encoding="utf-8")
            luac_path.unlink()
            return ("ok", f"{filename} => {lua_path.name}")
        else:
            return ("error:unluac", f"{filepath}: {result.stderr[:100]}")
    except subprocess.TimeoutExpired:
        return ("error:timeout", str(filepath))
    except FileNotFoundError:
        return ("ok:luac_only", f"{filename} => {luac_name}")
    except Exception as e:
        return (f"error:decompile:{e}", str(filepath))


def main():
    version = get_live_version()
    print(f"当前版本: {version}")
    print("获取资源列表...")
    patch_info = get_patch_info(version)
    version_str = patch_info.get("version", "unknown")
    data_list = patch_info.get("data", [])
    print(f"版本: {version_str}")
    print(f"总资源数: {len(data_list)}")
    print("过滤 ab_script 资源...")
    script_files = []
    for item in data_list:
        try:
            info = PatchFileInfo.from_array(item)
            if info.name.startswith("ab_script"):
                script_files.append(info)
        except Exception:
            continue

    print(f"找到 {len(script_files)} 个数据表")
    DOWNLOAD_DIR.mkdir(parents=True, exist_ok=True)

    downloaded = []
    failed = 0

    with ThreadPoolExecutor(max_workers=8) as pool:
        futures = {
            pool.submit(download_file, version, info, DOWNLOAD_DIR): info
            for info in script_files
        }

        for i, future in enumerate(as_completed(futures), 1):
            info = futures[future]
            status, path = future.result()
            if status == "ok" and path:
                downloaded.append(path)
                print(f"[{i}/{len(script_files)}] {info.name}")
            else:
                failed += 1
                print(f"[{i}/{len(script_files)}] 失败: {info.name} - {status}")

    print(f"解密ab并提取lua")
    DECRYPTED_DIR.mkdir(parents=True, exist_ok=True)

    extracted_files = []
    extract_ok = extract_err = 0

    for bundle_path in downloaded:
        results = extract_scripts_from_bundle(bundle_path, DECRYPTED_DIR)
        for status, path in results:
            if status == "ok":
                extract_ok += 1
                extracted_files.append(path)
            else:
                extract_err += 1
                print(f"提取错误: {status} - {path}")

    print(f"提取完成: {extract_ok} 成功, {extract_err} 失败")

    print(f"\n还原文件名、解密并反编译...")
    MASTERDATA_DIR.mkdir(parents=True, exist_ok=True)

    lua_ok = lua_skip = lua_err = 0

    for filepath in DECRYPTED_DIR.rglob("*"):
        if not filepath.is_file():
            continue

        status, msg = process_lua_file(filepath, MASTERDATA_DIR)

        if status == "ok" or status == "ok:luac_only":
            lua_ok += 1
            print(f"{msg}")
        elif status.startswith("skip"):
            lua_skip += 1
        else:
            lua_err += 1
            print(f"错误{status}: {msg}")

    print(f"处理完成: {lua_ok} 成功, {lua_skip} 跳过, {lua_err} 错误")

    shutil.rmtree(DOWNLOAD_DIR, ignore_errors=True)
    shutil.rmtree(DECRYPTED_DIR, ignore_errors=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
