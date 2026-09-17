from __future__ import annotations

import os
import shutil
import subprocess
import tempfile
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import requests
from rich.console import Console

from AzurPromiliaCatalog import BundleInfo, ManifestInfo
from AzurPromiliaDecrypt import decrypt_codephil_vm, decrypt_lua_raw

_MMAP_BASE = 4120
_LRGB_MAGIC = b'LRGB1001'
_FIELD_SIZES: Dict = {
    'int':4,'int32':4,'Int32':4,'uint':4,'uint32':4,'UInt32':4,
    'bool':4,'Bool':4,'string':4,
    'float':4,'Float':4,'single':4,'Single':4,
    'long':8,'int64':8,'Int64':8,'ulong':8,'uint64':8,'UInt64':8,
    'double':8,'Double':8,
    'short':2,'Int16':2,'ushort':2,'UInt16':2,
    'byte':1,'Byte':1,'sbyte':1,'SByte':1,
}
console = Console()

def clean_lua_relative_path(bundle_name: str) -> str:
    s = bundle_name
    if s.startswith('rn_'):
        s = s[3:]
    if s.startswith('assets_resourcesassets_lua_64_'):
        s = s[len('assets_resourcesassets_lua_64_'):]
    elif s.startswith('assets_resourcesassets_lua_'):
        s = s[len('assets_resourcesassets_lua_'):]
    elif s.startswith('assets_resourceslang_'):
        s = 'lang/' + s[len('assets_resourceslang_'):]

    ext = '.lua'
    if s.endswith('_lua_bytes'):
        s = s[:-10] + '.lua'
    elif s.endswith('_bytes_bytes'):
        s = s[:-12] + '.bytes'
        ext = '.bytes'
    elif s.endswith('_lua'):
        s = s[:-4] + '.lua'
    elif s.endswith('_bytes'):
        s = s[:-6] + '.bytes'
        ext = '.bytes'

    for prefix in ('configshell_', 'config_', 'src_', 'lang_'):
        if s.startswith(prefix):
            folder = prefix[:-1]
            rest = s[len(prefix):]
            if folder == 'configshell':
                folder = 'configShell'
            s = f"{folder}/{rest}"
            break

    return s

def decompile_lua_worker(task: Tuple[bytes, Path]) -> Tuple[bool, str]:
    bytecode, target_file = task
    try:
        target_file.parent.mkdir(parents=True, exist_ok=True)
        if not bytecode.startswith(b'\x1bLua'):
            with open(target_file, 'wb') as f:
                f.write(bytecode)
            return True, f"Binary saved: {target_file.name}"

        with tempfile.NamedTemporaryFile(suffix='.luac', delete=False) as tf:
            tf.write(bytecode)
            tmp_path = tf.name

        try:
            res = subprocess.run(
                ['unluac', '--rawstring', tmp_path],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False
            )
            if res.returncode == 0 and res.stdout:
                with open(target_file, 'wb') as f:
                    f.write(res.stdout)
                return True, f"Decompiled: {target_file.name}"
            else:
                with open(target_file.with_suffix('.luac'), 'wb') as f:
                    f.write(bytecode)
                err_msg = res.stderr.decode('utf-8', errors='replace').strip()[:100]
                return False, f"unluac warning on {target_file.name}: {err_msg}"
        finally:
            if os.path.exists(tmp_path):
                try:
                    os.remove(tmp_path)
                except OSError:
                    pass

    except Exception as e:
        return False, str(e)


def extract_and_decompile_lua(
    lua_bundles: List[BundleInfo],
    cdn_base: str,
    output_dir: Path,
    max_workers: int = 8,
    limit: int = 0,
    force: bool = False,
) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    targets = lua_bundles[:limit] if limit > 0 else lua_bundles
    console.print(f"[bold cyan]正在检查 Lua 脚本缓存与更新 (总计: {len(targets)} 个)...[/bold cyan]")

    from urllib3.util import Retry
    from requests.adapters import HTTPAdapter
    session = requests.Session()
    retries = Retry(total=3, backoff_factor=0.3, status_forcelist=[500, 502, 503, 504])
    session.mount('https://', HTTPAdapter(max_retries=retries))

    needed_bundles: List[Tuple[BundleInfo, Path]] = []
    skipped = 0
    for b in targets:
        rel = clean_lua_relative_path(b.bundle_name)
        out_path = output_dir / rel
        if not force and (out_path.exists() or out_path.with_suffix('.luac').exists()):
            check_p = out_path if out_path.exists() else out_path.with_suffix('.luac')
            if check_p.stat().st_size > 0:
                skipped += 1
                continue
        needed_bundles.append((b, out_path))

    if skipped > 0:
        console.print(f" [green]✓ 本地已存在 {skipped} 个 Lua 源码，直接复用缓存。[/green]")

    if not needed_bundles:
        console.print("[bold green]所有 Lua 源码均已为最新，无需重复下载反编译。[/bold green]")
        return

    console.print(f"[cyan]需增量下载并反编译: {len(needed_bundles)} 个...[/cyan]")
    tasks_to_decompile: List[Tuple[bytes, Path]] = []

    def download_task(item: Tuple[BundleInfo, Path]):
        b, out_path = item
        url = f"{cdn_base}/{b.pack_res_name}"
        headers = {}
        if b.file_size > 0:
            headers['Range'] = f"bytes={b.file_offset}-{b.file_offset + b.file_size - 1}"
        for _ in range(3):
            try:
                r = session.get(url, headers=headers, timeout=20)
                if r.status_code in (200, 206):
                    clean_bytes = decrypt_lua_raw(r.content)
                    return clean_bytes, out_path
            except Exception:
                pass
        return None, out_path

    with ThreadPoolExecutor(max_workers=max_workers * 2) as t_pool:
        futures = [t_pool.submit(download_task, it) for it in needed_bundles]
        for fut in as_completed(futures):
            c_bytes, out_p = fut.result()
            if c_bytes:
                tasks_to_decompile.append((c_bytes, out_p))

    console.print(f"[green]下载解密完成 ({len(tasks_to_decompile)}/{len(needed_bundles)})，开始并行反编译源码...[/green]")

    success_decomp = 0
    fail_decomp = 0
    with ProcessPoolExecutor(max_workers=max_workers) as executor:
        futures = {executor.submit(decompile_lua_worker, item): item for item in tasks_to_decompile}
        for fut in as_completed(futures):
            ok, msg = fut.result()
            if ok:
                success_decomp += 1
            else:
                fail_decomp += 1

    console.print(f"[bold green]Lua 反编译完成！成功: {success_decomp} 个，警告/原始保存: {fail_decomp} 个。[/bold green]")
    console.print(f"输出目录: [yellow]{output_dir}[/yellow]")


def parse_and_export_azurconfig(dec_body: bytes, out_json_path: Path) -> List[Dict]:
    import struct
    if len(dec_body) < 24:
        return []
    ver, u0, u1, array_ptr = struct.unpack_from('<IQQI', dec_body, 0)
    header_len = 4120
    rel_ptr = array_ptr - header_len
    if rel_ptr < 0 or rel_ptr + 4 > len(dec_body):
        return []
    title_count = int.from_bytes(dec_body[rel_ptr : rel_ptr + 4], 'little')
    tables = []
    curr_offset = rel_ptr + 4
    for idx in range(title_count):
        if curr_offset + 24 > len(dec_body):
            break
        vtype_key, dic_ptr, fp0, fp1 = struct.unpack_from('<IIQQ', dec_body, curr_offset)
        tables.append({
            'index': idx,
            'vtype_key': f'0x{vtype_key:08x}',
            'dic_pointer': dic_ptr,
            'fingerprint': f'{fp0:016x}{fp1:016x}',
        })
        curr_offset += 24

    import json
    with open(out_json_path, 'w', encoding='utf-8') as f:
        json.dump({
            'version': ver,
            'table_count': len(tables),
            'tables': tables
        }, f, indent=2, ensure_ascii=False)
    return tables




import mmap as _mmap


class VStringReader:
    def __init__(self, dec_path: Path):
        self._f  = open(dec_path, 'rb')
        self._mm = _mmap.mmap(self._f.fileno(), 0, access=_mmap.ACCESS_READ)
        import struct as _s
        hash_tb, hash_sp = _s.unpack_from('<2i', self._mm, 0)
        vs_dec = (hash_tb + hash_sp) - _MMAP_BASE
        _, _, vs_osp, _, vs_sc = _s.unpack_from('<5i', self._mm, vs_dec)
        self._osp   = vs_osp
        self._count = vs_sc

    def read(self, key: int) -> str:
        if key <= 0 or key >= self._count:
            return ''
        import struct as _s
        entry_dec = (self._osp + 4 * key) - _MMAP_BASE
        if entry_dec < 0 or entry_dec + 4 > len(self._mm):
            return ''
        v12 = _s.unpack_from('<i', self._mm, entry_dec)[0]
        if v12 == 0:
            return ''
        str_dec = v12 - _MMAP_BASE
        if str_dec < 0 or str_dec + 4 > len(self._mm):
            return ''
        slen = _s.unpack_from('<i', self._mm, str_dec)[0]
        if slen <= 0 or str_dec + 4 + slen > len(self._mm):
            return ''
        return self._mm[str_dec + 4: str_dec + 4 + slen].decode('utf-8', errors='replace')

    def close(self):
        self._mm.close()
        self._f.close()

    def __enter__(self):
        return self

    def __exit__(self, *_):
        self.close()


def _parse_lrgb_field_list(dec_body: bytes, offset: int, length: int) -> List[str]:
    names: List[str] = []
    end = offset + length
    pos = offset
    while pos < end:
        if pos >= len(dec_body):
            break
        marker = dec_body[pos]; pos += 1
        if marker != 0x16:
            continue
        if pos >= end:
            break
        nlen = dec_body[pos]; pos += 1
        if pos + nlen > len(dec_body):
            break
        names.append(dec_body[pos: pos + nlen].decode('utf-8', errors='replace'))
        pos += nlen
    return names


def _parse_single_lrgb_table(
    dec_body: bytes, real_pos: int, vs: VStringReader
) -> Dict:
    import struct as _s
    pos = real_pos
    if dec_body[pos: pos + 8] != _LRGB_MAGIC:
        return {'error': f'bad_magic@{real_pos}: {dec_body[pos:pos+8].hex()}'}
    pos += 8
    col, row, fp_len, fc_len, ft_len, fn_len = _s.unpack_from('>6i', dec_body, pos)
    pos += 24
    pos += 4
    pos += fp_len + fc_len
    type_start = pos; pos += ft_len
    name_start = pos; pos += fn_len

    fnames = _parse_lrgb_field_list(dec_body, name_start, fn_len)
    ftypes = _parse_lrgb_field_list(dec_body, type_start, ft_len)

    if pos + 8 > len(dec_body):
        return {'error': 'truncated_data'}
    row_width    = _s.unpack_from('<i', dec_body, pos)[0]; pos += 4
    key_bytes_len = _s.unpack_from('<i', dec_body, pos)[0]; pos += 4
    actual_rows  = key_bytes_len // 4
    pos += key_bytes_len
    matrix_start = pos

    rows: List[Dict] = []
    for r in range(actual_rows):
        rstart = matrix_start + r * row_width
        if rstart + row_width > len(dec_body):
            break
        rdict: Dict = {}
        fpos = rstart
        for c, fname in enumerate(fnames):
            ftype = ftypes[c] if c < len(ftypes) else 'int'
            base  = ftype.rstrip('[]? ').strip()
            fsz   = _FIELD_SIZES.get(base, 4)
            if fpos + fsz > rstart + row_width:
                break
            raw = dec_body[fpos: fpos + fsz]; fpos += fsz

            if base == 'string':
                vk = _s.unpack_from('<i', raw)[0]
                rdict[fname] = vs.read(vk) if vk > 0 else ''
            elif base in ('int','int32','Int32','uint','uint32','UInt32','bool','Bool'):
                rdict[fname] = _s.unpack_from('<i', raw)[0]
            elif base in ('float','Float','single','Single'):
                rdict[fname] = round(_s.unpack_from('<f', raw)[0], 6)
            elif base in ('long','int64','Int64','ulong','uint64','UInt64'):
                rdict[fname] = _s.unpack_from('<q', raw)[0]
            elif base in ('double','Double'):
                rdict[fname] = _s.unpack_from('<d', raw)[0]
            elif base in ('short','Int16','ushort','UInt16'):
                rdict[fname] = _s.unpack_from('<h', raw)[0]
            elif base in ('byte','Byte','sbyte','SByte'):
                rdict[fname] = raw[0]
            else:
                rdict[fname] = _s.unpack_from('<i', raw)[0] if fsz == 4 else raw.hex()
        rows.append(rdict)

    return {
        'col': col,
        'row': actual_rows,
        'fields': list(zip(fnames, ftypes)),
        'rows': rows,
    }


def parse_and_export_all_tables(
    dec_body: bytes,
    vstring_dec_path: Path,
    out_dir: Path,
) -> Dict[str, int]:
    import struct as _s, json

    if len(dec_body) < 4:
        return {'core': 0, 'chs': 0, 'jp': 0, 'en': 0}

    table_count = _s.unpack_from('<I', dec_body, 0)[0]
    offset = 4
    core_tables: List[Tuple[str, int]] = []
    for i in range(table_count):
        if offset + 4 > len(dec_body): break
        nlen = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
        if offset + nlen > len(dec_body): break
        name = dec_body[offset: offset + nlen].decode('utf-8', errors='replace'); offset += nlen
        if offset + 4 > len(dec_body): break
        spos = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
        core_tables.append((name, spos - 4116))

    lang_tables: Dict[str, List[Tuple[str, int]]] = {}
    if offset + 4 <= len(dec_body):
        lang_sections_count = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
        for s in range(lang_sections_count):
            if offset + 4 > len(dec_body): break
            lname_len = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
            if offset + lname_len > len(dec_body): break
            lname = dec_body[offset: offset + lname_len].decode('utf-8', errors='replace'); offset += lname_len
            if offset + 4 > len(dec_body): break
            st_count = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
            sub: List[Tuple[str, int]] = []
            for t in range(st_count):
                if offset + 4 > len(dec_body): break
                tn_len = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
                if offset + tn_len > len(dec_body): break
                tn = dec_body[offset: offset + tn_len].decode('utf-8', errors='replace'); offset += tn_len
                if offset + 4 > len(dec_body): break
                spos = _s.unpack_from('<I', dec_body, offset)[0]; offset += 4
                sub.append((tn, spos - 4116))
            lang_tables[lname] = sub

    out_dir.mkdir(parents=True, exist_ok=True)
    counts: Dict[str, int] = {'core': 0, 'chs': 0, 'jp': 0, 'en': 0}

    with VStringReader(vstring_dec_path) as vs:
        chs_cache: Dict[str, Dict[int, str]] = {}
        chs_dir = out_dir / "chs"
        chs_dir.mkdir(parents=True, exist_ok=True)
        for tn, rpos in lang_tables.get('chs', []):
            try:
                res = _parse_single_lrgb_table(dec_body, rpos, vs)
                if 'rows' in res:
                    with open(chs_dir / f'{tn}.json', 'w', encoding='utf-8') as f:
                        json.dump(res['rows'], f, indent=2, ensure_ascii=False)
                    chs_cache[tn] = {
                        r['id']: r['value']
                        for r in res['rows']
                        if 'id' in r and 'value' in r and r['value']
                    }
                    counts['chs'] += 1
            except Exception as e:
                console.print(f'  [yellow]多语言表 chs.{tn} 解析异常: {e}[/yellow]')

        for lname in ('jp', 'en'):
            if lname not in lang_tables:
                continue
            ldir = out_dir / lname
            ldir.mkdir(parents=True, exist_ok=True)
            for tn, rpos in lang_tables[lname]:
                try:
                    res = _parse_single_lrgb_table(dec_body, rpos, vs)
                    if 'rows' in res:
                        with open(ldir / f'{tn}.json', 'w', encoding='utf-8') as f:
                            json.dump(res['rows'], f, indent=2, ensure_ascii=False)
                        counts[lname] += 1
                except Exception as e:
                    pass

        for tn, rpos in core_tables:
            try:
                res = _parse_single_lrgb_table(dec_body, rpos, vs)
                if 'rows' in res:
                    c_cache = chs_cache.get(tn)
                    if c_cache:
                        for row in res['rows']:
                            for k, v in list(row.items()):
                                try:
                                    iv = int(v) if isinstance(v, (int, str)) and str(v).isdigit() else None
                                except:
                                    iv = None
                                if iv in c_cache:
                                    row[f'{k}_id'] = v
                                    row[k] = c_cache[iv]
                    with open(out_dir / f'{tn}.json', 'w', encoding='utf-8') as f:
                        json.dump(res['rows'], f, indent=2, ensure_ascii=False)
                    counts['core'] += 1
                elif 'error' in res:
                    console.print(f'  [yellow]业务表 {tn}: {res["error"]}[/yellow]')
            except Exception as e:
                console.print(f'  [red]✗ 业务表 {tn} 导出失败: {e}[/red]')

    summary = {
        'total_tables': sum(counts.values()),
        'core_tables_count': counts['core'],
        'chs_tables_count': counts['chs'],
        'jp_tables_count': counts['jp'],
        'en_tables_count': counts['en'],
        'core_tables': [name for name, _ in core_tables],
        'language_partitions': {k: [name for name, _ in v] for k, v in lang_tables.items()}
    }
    with open(out_dir / 'tables_index.json', 'w', encoding='utf-8') as f:
        json.dump(summary, f, indent=2, ensure_ascii=False)

    return counts


def parse_and_export_table_data(dec_body: bytes, out_json_path: Path) -> List[Dict]:
    import struct, json
    if len(dec_body) < 4:
        return []
    table_count = struct.unpack_from('<I', dec_body, 0)[0]
    tables = []
    offset = 4
    for i in range(table_count):
        if offset + 4 > len(dec_body):
            break
        name_len = struct.unpack_from('<I', dec_body, offset)[0]
        offset += 4
        if offset + name_len > len(dec_body):
            break
        name = dec_body[offset : offset + name_len].decode('utf-8', errors='replace')
        offset += name_len
        if offset + 4 > len(dec_body):
            break
        table_pos = struct.unpack_from('<I', dec_body, offset)[0]
        offset += 4
        tables.append({
            'index': i,
            'name': name,
            'offset': table_pos,
            'hex_offset': f'0x{table_pos:08x}',
        })

    with open(out_json_path, 'w', encoding='utf-8') as f:
        json.dump({
            'total_tables': len(tables),
            'tables': tables
        }, f, indent=2, ensure_ascii=False)
    return tables

_PROTO_MAP: Optional[Dict[int, Tuple[str, str]]] = None
_PROTO_INCLUDES: Optional[Dict[int, str]] = None

def get_proto_metadata() -> Tuple[Dict[int, Tuple[str, str]], Dict[int, str]]:
    global _PROTO_MAP, _PROTO_INCLUDES
    if _PROTO_MAP is not None and _PROTO_INCLUDES is not None:
        return _PROTO_MAP, _PROTO_INCLUDES

    proto_map: Dict[int, Tuple[str, str]] = {}
    proto_includes: Dict[int, str] = {}
    cs_path = Path(__file__).resolve().parent / "cs" / "il2cpp.cs"
    if cs_path.is_file():
        import re
        with open(cs_path, "r", encoding="utf-8") as f:
            curr_class = ""
            pending_tag = None
            for line in f:
                line_s = line.strip()
                m_cls = re.search(r"public class (\w+)", line_s)
                if m_cls:
                    curr_class = m_cls.group(1)
                m_inc = re.search(r"\[ProtoInclude\((\d+),\s*typeof\((\w+)\)\)\]", line_s)
                if m_inc:
                    proto_includes[int(m_inc.group(1))] = m_inc.group(2)
                m_tag = re.search(r"\[ProtoMember\((\d+)\)\]", line_s)
                if m_tag:
                    pending_tag = int(m_tag.group(1))
                    continue
                if pending_tag is not None:
                    m_field = re.search(r"(?:public|private|protected)\s+(?:[\w<>,\s]+?)\s+(\w+)\s*[{;=]", line_s)
                    if m_field:
                        field_name = m_field.group(1)
                        proto_map[pending_tag] = (curr_class, field_name)
                    pending_tag = None

    _PROTO_MAP = proto_map
    _PROTO_INCLUDES = proto_includes
    return _PROTO_MAP, _PROTO_INCLUDES

def parse_protobuf_task(data: bytes, pm: Dict[int, Tuple[str, str]], pi: Dict[int, str], offset: int = 0, end: Optional[int] = None) -> Dict:
    import struct
    if end is None:
        end = len(data)
    obj: Dict = {}
    curr = offset

    def decode_varint(off: int) -> Tuple[int, int]:
        res = 0
        shift = 0
        while off < end:
            b = data[off]
            off += 1
            res |= (b & 0x7f) << shift
            shift += 7
            if not (b & 0x80):
                break
        return res, off

    while curr < end:
        try:
            tag_val, curr = decode_varint(curr)
        except Exception:
            break
        wire = tag_val & 7
        field = tag_val >> 3
        if field == 0:
            break

        if field in pm:
            key = pm[field][1]
        elif field in pi:
            key = f"__type_{pi[field]}"
        else:
            key = f"field_{field}"

        val = None
        if wire == 0:
            try:
                val, curr = decode_varint(curr)
            except Exception:
                break
        elif wire == 1:
            if curr + 8 > end:
                break
            val = struct.unpack_from("<d", data, curr)[0]
            curr += 8
        elif wire == 5:
            if curr + 4 > end:
                break
            val = round(struct.unpack_from("<f", data, curr)[0], 4)
            curr += 4
        elif wire == 2:
            try:
                length, curr = decode_varint(curr)
            except Exception:
                break
            if curr + length > end:
                break
            sub_data = data[curr : curr + length]
            curr += length

            is_sub = False
            if len(sub_data) > 0:
                try:
                    sub_obj = parse_protobuf_task(sub_data, pm, pi, 0, len(sub_data))
                    if sub_obj and isinstance(sub_obj, dict):
                        val = sub_obj
                        is_sub = True
                except Exception:
                    pass
            if not is_sub:
                try:
                    s_str = sub_data.decode("utf-8")
                    if all(c.isprintable() or c in "\r\n\t" for c in s_str):
                        val = s_str
                    else:
                        val = sub_data.hex()
                except UnicodeDecodeError:
                    val = sub_data.hex()
        else:
            break

        if key in obj:
            if not isinstance(obj[key], list):
                obj[key] = [obj[key]]
            obj[key].append(val)
        else:
            obj[key] = val

    return obj

def extract_streaming_configs(
    streaming_bundles: List[BundleInfo],
    cdn_base: str,
    output_dir: Path,
    limit: int = 0,
    force: bool = False,
) -> None:
    import json
    output_dir.mkdir(parents=True, exist_ok=True)
    task_dir = output_dir / "Task"
    task_dir.mkdir(parents=True, exist_ok=True)
    session = requests.Session()

    td_bundle = next((b for b in streaming_bundles if 'table_data' in b.bundle_name.lower()), None)
    if td_bundle:
        raw_path = output_dir / "table_data.bytes"
        dec_path = output_dir / "table_data.dec.bytes"
        json_path = output_dir / "table_data_index.json"

        cached = (
            not force
            and raw_path.is_file()
            and raw_path.stat().st_size == td_bundle.file_size
            and dec_path.is_file()
            and json_path.is_file()
        )
        if cached:
            console.print(f" [green]✓ 总管数据表已存在且为最新:[/green] {raw_path.name} ({raw_path.stat().st_size} bytes)，跳过下载。")
        else:
            console.print(f"[bold cyan]正在提取游戏总管数据表: {td_bundle.bundle_name} ({td_bundle.file_size / (1024*1024):.2f} MB)...[/bold cyan]")
            url = f"{cdn_base}/{td_bundle.pack_res_name}"
            try:
                r = session.get(url, timeout=60)
                if r.status_code in (200, 206):
                    with open(raw_path, 'wb') as f:
                        f.write(r.content)
                    console.print(f" [green]✓ 已保存总管数据表原始文件:[/green] {raw_path.name}")

                    from AzurPromiliaDecrypt import decrypt_mmap_buffer
                    mver, dec_body = decrypt_mmap_buffer(r.content)
                    if mver == 5:
                        with open(dec_path, 'wb') as f:
                            f.write(dec_body)
                        console.print(f"  [bold green]✓ 总管数据表 MMap 解密成功:[/bold green] {dec_path.name} ({len(dec_body)} bytes)")

                        tables = parse_and_export_table_data(dec_body, json_path)
                        console.print(f"  [bold magenta]★ 成功还原游戏数据表目录:[/bold magenta] {json_path.name} (共 {len(tables)} 张表)")
            except Exception as e:
                console.print(f"[red]数据表提取异常: {e}[/red]")

        tables_out_dir = output_dir.parent / "Tables"
        vstring_candidates = [
            f for f in output_dir.glob("*.dec.bytes")
            if f.name.endswith("_vstring_bytes.dec.bytes") or f.name == "vstring.dec.bytes"
        ]
        vstring_dec_file = vstring_candidates[0] if vstring_candidates else None

        need_deserialize = (
            force
            or not (tables_out_dir / "hero.json").is_file()
            or not (tables_out_dir / "tables_index.json").is_file()
        )
        if dec_path.is_file() and vstring_dec_file and vstring_dec_file.is_file():
            if need_deserialize:
                console.print(f"[bold cyan]正在全量反序列化业务与多语言数据表至 {tables_out_dir}...[/bold cyan]")
                dec_body = dec_path.read_bytes()
                counts = parse_and_export_all_tables(dec_body, vstring_dec_file, tables_out_dir)
                console.print(
                    f"  [bold green]全量业务数据表反序列化完成:[/bold green] "
                    f"核心业务表 {counts['core']} 张, 中文多语言表 {counts['chs']} 张, "
                    f"日文多语言表 {counts['jp']} 张, 英文多语言表 {counts['en']} 张 (总计导出 {sum(counts.values())} 张表)"
                )
            else:
                console.print(f" [green]✓ 业务数据表已完整反序列化:[/green] {tables_out_dir} 跳过反序列化。")

    task_bundles = [b for b in streaming_bundles if 'task_ast' in b.bundle_name.lower()]
    if limit > 0:
        task_bundles = task_bundles[:limit]

    pm, pi = get_proto_metadata()
    console.print(f"[cyan]正在检查任务系统决策表更新 (共 {len(task_bundles)} 个文件)...[/cyan]")

    needed_tasks: List[Tuple[BundleInfo, Path]] = []
    skipped_tasks = 0
    for b in task_bundles:
        fname = b.bundle_name
        for p in ('rs_assets_resourcesassets_config_task_ast_', 'rs_'):
            if fname.startswith(p):
                fname = fname[len(p):]
                break
        if fname.endswith('_bin'):
            json_name = fname[:-4] + '.json'
        elif fname.endswith('_bytes'):
            json_name = fname[:-6] + '.json'
        else:
            json_name = fname + '.json'
        target_json = task_dir / json_name
        old_bin = task_dir / fname.replace('_bin', '.bin').replace('_bytes', '.bytes')
        if old_bin.is_file():
            try:
                if not target_json.is_file() or target_json.stat().st_size == 0:
                    data = old_bin.read_bytes()
                    res = parse_protobuf_task(data, pm, pi)
                    with open(target_json, 'w', encoding='utf-8') as f:
                        json.dump(res, f, indent=2, ensure_ascii=False)
                old_bin.unlink()
            except Exception:
                pass

        if not force and target_json.is_file() and target_json.stat().st_size > 0:
            skipped_tasks += 1
            continue
        needed_tasks.append((b, target_json))

    if skipped_tasks > 0:
        console.print(f" [green]✓ 已存在 {skipped_tasks} 个格式化任务 JSON 表，跳过重复下载。[/green]")

    if needed_tasks:
        console.print(f"[cyan]需增量下载并反序列化任务表: {len(needed_tasks)} 个...[/cyan]")
        for b, target_json in needed_tasks:
            url = f"{cdn_base}/{b.pack_res_name}"
            headers = {}
            if b.file_size > 0:
                headers['Range'] = f"bytes={b.file_offset}-{b.file_offset + b.file_size - 1}"
            try:
                r = session.get(url, headers=headers, timeout=20)
                if r.status_code in (200, 206):
                    res = parse_protobuf_task(r.content, pm, pi)
                    with open(target_json, 'w', encoding='utf-8') as f:
                        json.dump(res, f, indent=2, ensure_ascii=False)
            except Exception:
                pass
        console.print(f" [green]✓ 任务决策流配置表已全部反序列化为 JSON 导出至:[/green] {task_dir}")

def extract_behavior_trees(
    nostreaming_bundles: List[BundleInfo],
    cdn_base: str,
    output_dir: Path,
    limit: int = 0,
    force: bool = False,
) -> None:
    bt_bundles = [b for b in nostreaming_bundles if 'world_behaviortree' in b.bundle_name.lower()]
    if limit > 0:
        bt_bundles = bt_bundles[:limit]
    if not bt_bundles:
        return

    output_dir.mkdir(parents=True, exist_ok=True)
    needed_bts = []
    skipped = 0
    for b in bt_bundles:
        fname = b.bundle_name
        for p in ('rn_assets_resourcesassets_config_world_behaviortree_', 'rn_'):
            if fname.startswith(p):
                fname = fname[len(p):]
                break
        fname = fname.replace('_json', '.json')
        target_p = output_dir / fname
        if not force and target_p.is_file() and target_p.stat().st_size > 0:
            skipped += 1
            continue
        needed_bts.append((b, target_p))

    if skipped > 0:
        console.print(f" [green]✓ 世界行为树配置已存在 {skipped} 个，跳过重复下载。[/green]")

    if not needed_bts:
        return

    console.print(f"[cyan]正在增量提取世界行为树配置文件，共 {len(needed_bts)} 个...[/cyan]")
    session = requests.Session()
    for b, target_p in needed_bts:
        url = f"{cdn_base}/{b.pack_res_name}"
        headers = {}
        if b.file_size > 0:
            headers['Range'] = f"bytes={b.file_offset}-{b.file_offset + b.file_size - 1}"
        try:
            r = session.get(url, headers=headers, timeout=20)
            if r.status_code in (200, 206):
                with open(target_p, 'wb') as f:
                    f.write(r.content)
        except Exception:
            pass
    console.print(f" [green]✓ 世界行为树配置提取完成至:[/green] {output_dir}")

def extract_configs(
    config_bundles: List[BundleInfo],
    cdn_base: str,
    output_dir: Path,
    force: bool = False,
) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold cyan]正在提取与检查基础配置表文件: {output_dir}...[/bold cyan]")
    session = requests.Session()
    from AzurPromiliaDecrypt import decrypt_mmap_buffer

    for b in config_bundles:
        clean_name = b.bundle_name
        for prefix in ('rd_', 'rn_', 'rs_'):
            if clean_name.startswith(prefix):
                clean_name = clean_name[len(prefix):]
                break
        raw_file = output_dir / f"{clean_name}.bytes"
        dec_file = output_dir / f"{clean_name}.dec.bytes"

        if not force and raw_file.is_file() and (b.file_size == 0 or raw_file.stat().st_size == b.file_size):
            console.print(f" [green]✓ 本地已存在最新配置表:[/green] {raw_file.name} ({raw_file.stat().st_size} bytes)")
            if not dec_file.is_file() or dec_file.stat().st_size == 0:
                raw_bytes = raw_file.read_bytes()
                mver, dec_body = decrypt_mmap_buffer(raw_bytes)
                if mver == 5:
                    dec_file.write_bytes(dec_body)
                    console.print(f"  [bold green]✓ MMap 解密成功:[/bold green] {dec_file.name}")
                    if 'azurconfig' in clean_name.lower():
                        json_path = output_dir / "azurconfig_tables.json"
                        tables = parse_and_export_azurconfig(dec_body, json_path)
                        console.print(f"  [cyan]✓ 成功导出 113 个配置表目录:[/cyan] {json_path.name}")
            continue

        url = f"{cdn_base}/{b.pack_res_name}"
        headers = {}
        if b.file_size > 0:
            headers['Range'] = f"bytes={b.file_offset}-{b.file_offset + b.file_size - 1}"
        try:
            r = session.get(url, headers=headers, timeout=30)
            if r.status_code in (200, 206):
                with open(raw_file, 'wb') as f:
                    f.write(r.content)
                console.print(f" [green]已保存配置表:[/green] {raw_file.name} ({len(r.content)} bytes)")

                mver, dec_body = decrypt_mmap_buffer(r.content)
                if mver == 5:
                    with open(dec_file, 'wb') as f:
                        f.write(dec_body)
                    console.print(f"  [bold green]✓ MMap 解密成功:[/bold green] {dec_file.name} (Ver: {mver}, {len(dec_body)} bytes)")

                    if 'azurconfig' in clean_name.lower():
                        json_path = output_dir / "azurconfig_tables.json"
                        tables = parse_and_export_azurconfig(dec_body, json_path)
                        console.print(f"  [cyan]✓ 成功导出 113 个配置表目录:[/cyan] {json_path.name} ({len(tables)} 张表)")
        except Exception as e:
            console.print(f"[red]配置表处理失败: {b.bundle_name} -> {e}[/red]")

META_VERSION_FILES = [
    "AzurLoader.mv.bytes",
    "ThirdPart.mv.bytes",
    "AzurFramework.mv.bytes",
    "Assembly-CSharp.mv.bytes",
    "AzurProto.mv.bytes",
]

def extract_meta_versions(cdn_root: str, output_dir: Path, force: bool = False) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold cyan]正在检查 HybridCLR 元数据版本文件: {output_dir}...[/bold cyan]")
    from AzurPromiliaDecrypt import decrypt_meta_version

    session = requests.Session()
    for mv_name in META_VERSION_FILES:
        dest_raw = output_dir / mv_name
        dest_dec = output_dir / mv_name.replace('.mv.bytes', '.dec.mv')

        if not force and dest_raw.is_file() and dest_raw.stat().st_size > 0 and dest_dec.is_file():
            console.print(f" [green]✓ 元数据文件已存在:[/green] {dest_raw.name}，跳过下载。")
            continue

        url = f"{cdn_root}/OriginalMetaVersions/{mv_name}"
        try:
            r = session.get(url, timeout=30)
            if r.status_code == 200:
                with open(dest_raw, 'wb') as f:
                    f.write(r.content)
                dec_data = decrypt_meta_version(r.content)
                with open(dest_dec, 'wb') as f:
                    f.write(dec_data)
                console.print(f" [green]✓ 成功解密元数据:[/green] {dest_dec.name} ({len(dec_data)} bytes)")
            else:
                console.print(f" [dim]未在远端找到 {mv_name} [{r.status_code}][/dim]")
        except Exception as e:
            console.print(f"[red]元数据获取失败: {mv_name} -> {e}[/red]")

def decompile_csharp_dlls(dll_dir: Path, output_dir: Path, force: bool = False) -> None:
    if not dll_dir.exists():
        return
    dlls = list(dll_dir.glob("*.dll"))
    if not dlls:
        return

    output_dir.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold cyan]检查 C# 程序集反编译 (共 {len(dlls)} 个程序集)...[/bold cyan]")

    needed_dlls = []
    for dll_path in dlls:
        target_proj_dir = output_dir / dll_path.stem
        if not force and target_proj_dir.exists() and any(target_proj_dir.glob("*.cs")):
            continue
        needed_dlls.append(dll_path)

    if not needed_dlls:
        console.print(f" [green]✓ 所有 {len(dlls)} 个 C# 程序集均已反编译，跳过。[/green]")
        return

    console.print(f"[bold cyan]正在调用 ilspycmd 反编译 {len(needed_dlls)} 个 C# 程序集...[/bold cyan]")
    for dll_path in needed_dlls:
        target_proj_dir = output_dir / dll_path.stem
        target_proj_dir.mkdir(parents=True, exist_ok=True)
        try:
            cmd = ["ilspycmd", "-p", "-o", str(target_proj_dir), str(dll_path)]
            res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=False)
            if res.returncode == 0:
                console.print(f" [green]✓ 反编译成功:[/green] {dll_path.name} -> {target_proj_dir}")
            else:
                console.print(f" [yellow]ilspycmd 警告: {dll_path.name} ({res.stderr.strip()[:100]})[/yellow]")
        except FileNotFoundError:
            console.print("[yellow]系统未安装 ilspycmd，跳过 C# 反编译。[/yellow]")
            break
        except Exception as e:
            console.print(f"[red]反编译异常: {dll_path.name} -> {e}[/red]")
