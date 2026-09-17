from __future__ import annotations

import struct
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Tuple

BASE64_TO_CHARS = [
    ' ', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '.'
]

def _build_ulong(u: int) -> str:
    if u == 0:
        return ''
    chars = []
    while True:
        chars.append(BASE64_TO_CHARS[u % 38])
        if u <= 37:
            break
        u //= 38
    chars.reverse()
    return ''.join(chars)

def hash128_to_string(u0: int, u1: int) -> str:
    return _build_ulong(u0) + _build_ulong(u1)

def normalize_bundle_path(bundle_name: str) -> str:
    s = bundle_name
    for p in ('rd_', 'rn_', 'rs_', 'd_', 's_'):
        if s.startswith(p):
            s = s[len(p):]
            break

    known_exts = ('.bundle', '.bytes', '.json', '.usm', '.pck', '.bin', '.lua', '.ab', '.prefab')
    has_ext = any(s.endswith(ext) for ext in known_exts)

    if s.startswith('assets_'):
        s = s[len('assets_'):]
        parts = s.split('_')
        rel_path = '/'.join(parts)
        if not has_ext:
            rel_path += '.bundle'
        return rel_path
    elif not has_ext:
        return f"{s}.bundle"
    return s

@dataclass
class BundleInfo:
    bundle_name: str
    relative_path: str
    pack_res_name: str
    file_offset: int
    file_size: int
    file_crc: int
    is_encrypted: bool
    tags: int
    pack_res_id: int

@dataclass
class ManifestInfo:
    package_name: str
    package_version: str
    file_version: str
    pipeline: str
    asset_count: int
    bundle_count: int
    pack_res_count: int
    bundles: List[BundleInfo] = field(default_factory=list)
    pack_res_names: Dict[int, str] = field(default_factory=dict)
    pack_res_sizes: Dict[int, int] = field(default_factory=dict)

class YooManifestParser:
    @staticmethod
    def _read_str(data: bytes, offset: int) -> Tuple[str, int]:
        str_len = struct.unpack_from('<H', data, offset)[0]
        offset += 2
        s = data[offset : offset + str_len].decode('utf-8', errors='replace')
        return s, offset + str_len

    @classmethod
    def parse(cls, data: bytes) -> ManifestInfo:
        magic = struct.unpack_from('<I', data, 0)[0]
        if magic != 5853007:
            raise ValueError(f"无效的Magic: {magic}")

        offset = 4
        file_version, offset = cls._read_str(data, offset)
        enable_addressable = struct.unpack_from('<?', data, offset)[0]
        offset += 1
        loc_lower = struct.unpack_from('<?', data, offset)[0]
        offset += 1
        inc_guid = struct.unpack_from('<?', data, offset)[0]
        offset += 1
        output_style = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        build_type = struct.unpack_from('<i', data, offset)[0]
        offset += 4

        pipeline, offset = cls._read_str(data, offset)
        pkg_name, offset = cls._read_str(data, offset)
        pkg_ver, offset = cls._read_str(data, offset)
        pkg_note, offset = cls._read_str(data, offset)

        asset_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        offset += asset_cnt * 24

        dep_pool_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        offset += dep_pool_cnt * 4

        bundle_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        bundles_offset = offset
        offset += bundle_cnt * 56

        ref_pool_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        offset += ref_pool_cnt * 4

        hash_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        offset += hash_cnt * 16

        pack_res_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4
        pack_res_offset = offset
        offset += pack_res_cnt * 48

        name_cnt = struct.unpack_from('<i', data, offset)[0]
        offset += 4

        names: List[str] = []
        for _ in range(name_cnt):
            s, offset = cls._read_str(data, offset)
            names.append(s)

        pack_res_names: Dict[int, str] = {}
        pack_res_sizes: Dict[int, int] = {}
        for i in range(pack_res_cnt):
            p = data[pack_res_offset + i * 48 : pack_res_offset + (i + 1) * 48]
            h1_0, h1_1, h2_0, h2_1, p_size, p_uid, p_crc = struct.unpack(
                '<QQQQqII', p
            )
            name1 = hash128_to_string(h1_0, h1_1)
            pack_res_names[i] = name1
            pack_res_sizes[i] = p_size

        bundles: List[BundleInfo] = []
        for i in range(bundle_cnt):
            b = data[bundles_offset + i * 56 : bundles_offset + (i + 1) * 56]
            (
                f_size,
                f_crc,
                name_idx,
                dep_cnt,
                ref_off,
                ref_cnt,
                main_num,
                pack_id,
                f_off,
                unk_flags,
                tags,
                b0,
                b1,
                b2,
                b3,
            ) = struct.unpack('<qIiiiiIIqII4B', b)

            b_name = names[name_idx] if name_idx < len(names) else f'bundle_{i}'
            p_name = pack_res_names.get(pack_id, f'pack_{pack_id}.r')
            is_enc = b0 == 1
            rel_path = normalize_bundle_path(b_name)

            bundles.append(
                BundleInfo(
                    bundle_name=b_name,
                    relative_path=rel_path,
                    pack_res_name=p_name,
                    file_offset=f_off,
                    file_size=f_size,
                    file_crc=f_crc,
                    is_encrypted=is_enc,
                    tags=tags,
                    pack_res_id=pack_id,
                )
            )

        return ManifestInfo(
            package_name=pkg_name,
            package_version=pkg_ver,
            file_version=file_version,
            pipeline=pipeline,
            asset_count=asset_cnt,
            bundle_count=bundle_cnt,
            pack_res_count=pack_res_cnt,
            bundles=bundles,
            pack_res_names=pack_res_names,
            pack_res_sizes=pack_res_sizes,
        )

def load_manifest(file_path: Path | str) -> ManifestInfo:
    with open(file_path, 'rb') as f:
        data = f.read()
    return YooManifestParser.parse(data)
