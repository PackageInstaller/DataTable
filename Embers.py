import argparse
import concurrent.futures
import shutil
import struct
import subprocess
import json
import sys
import time
import os
from pathlib import Path

import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

import MasterMap


console = Console()


# ── CDN 配置（kiifstudio，2026-08-11 抓包） ───────────────

CDN_BASE = "https://ab.kiifstudio.com/ASH_1.6_FORMAL"
CDN_PLATFORM = "Android"
CDN_USER_AGENT = "UnityPlayer/2021.3.32f1c1 (UnityWebRequest/1.0, libcurl/8.1.1-DEV)"

PACKAGE_VERSIONS = {
    "Story": "1.0.4",
    "HotCode": "1.0.27",
    "Paradoxs": "1.0.7",
    "Audio": "1.0.4",
    "DataTables": "1.0.8",
    "Scenes": "1.0.0",
    "DefaultPackage": "1.0.13",
}
ALL_PACKAGES = list(PACKAGE_VERSIONS.keys())
DATATABLES_ONLY_PACKAGES = ["DataTables", "HotCode"]

# 输出目录布局：清单与下载资产分开
MANIFEST_DIR = "Manifests"
BUNDLE_DIR = "Bundles"


def _cdn_url(package: str, version: str, file_name: str) -> str:
    return f"{CDN_BASE}/{CDN_PLATFORM}/{package}/{version}/{file_name}"


def _manifest_path(output_dir: Path, package: str, version: str) -> Path:
    return output_dir / MANIFEST_DIR / f"{package}_{version}.bytes"


def _bundle_path(output_dir: Path, bundle_name: str) -> Path:
    return output_dir / BUNDLE_DIR / bundle_name_to_path(bundle_name)


def bundle_name_to_path(bundle_name: str) -> str:
    """bundle 名 -> 逻辑路径：下划线转目录分隔符，保留扩展名。

    例如 ``datatables_assets_art_datatables.bundle``
    -> ``datatables/assets/art/datatables.bundle``
    """
    if not bundle_name:
        return ""
    if "." in bundle_name:
        name_part, ext_part = bundle_name.rsplit(".", 1)
        return name_part.replace("_", os.sep) + "." + ext_part
    return bundle_name.replace("_", os.sep)


def _http_get(url: str, session: requests.Session, timeout: int = 30) -> bytes:
    last_err = None
    for attempt in range(3):
        try:
            resp = session.get(url, headers={"User-Agent": CDN_USER_AGENT}, timeout=(5, timeout))
            resp.raise_for_status()
            return resp.content
        except Exception as e:  # noqa: BLE001
            last_err = e
            time.sleep(1.5 * (attempt + 1))
    raise RuntimeError(f"下载失败: {url}: {last_err}")


def _download_file(
    url: str,
    target: Path,
    expected_size: int,
    session: requests.Session,
    chunk: int = 256 * 1024,
    connect_timeout: int = 5,
    read_timeout: int = 30,
    attempt_deadline: float = 600.0,
) -> bool:
    """断点续传：大小正确则跳过，.part 续传，读超时/网络错误自动重试。

    requests 的 (connect, read) 双超时保证任何卡死的连接最多等 read_timeout
    秒就会报错，不会再出现无限挂起。
    """
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.is_file() and target.stat().st_size == expected_size:
        return True
    tmp = target.with_suffix(target.suffix + ".part")

    last_err = None
    for attempt in range(3):
        attempt_start = time.monotonic()
        offset = tmp.stat().st_size if tmp.is_file() else 0
        if offset > expected_size:
            tmp.unlink(missing_ok=True)
            offset = 0
        headers = {"User-Agent": CDN_USER_AGENT}
        if offset:
            headers["Range"] = f"bytes={offset}-"
        try:
            resp = session.get(
                url,
                headers=headers,
                stream=True,
                timeout=(connect_timeout, read_timeout),
            )
            with resp:
                if resp.status_code == 206 and offset:
                    mode = "ab"
                elif resp.status_code == 200:
                    mode = "wb"
                    offset = 0
                else:
                    resp.raise_for_status()
                    return False
                with open(tmp, mode) as f:
                    for data in resp.iter_content(chunk_size=chunk):
                        if time.monotonic() - attempt_start > attempt_deadline:
                            raise requests.exceptions.ReadTimeout(
                                f"{target.name} 单次尝试超过 {attempt_deadline:.0f}s"
                            )
                        if data:
                            f.write(data)
            if tmp.stat().st_size == expected_size:
                tmp.replace(target)
                return True
            # 大小不匹配：清掉残片，下一轮重下
            last_err = f"size mismatch {tmp.stat().st_size} != {expected_size}"
            tmp.unlink(missing_ok=True)
        except requests.exceptions.RequestException as e:
            last_err = e
            # 保留 .part，下轮续传
        except OSError as e:
            last_err = e
        time.sleep(1.0 * (attempt + 1))
    console.print(f"[red]下载失败: {target.name} ({last_err})[/red]")
    return False


class _ManifestBuf:
    """YooAsset 清单二进制读取器（v2025.9.30，小端）。"""

    def __init__(self, data: bytes):
        self.d = data
        self.i = 0

    def _take(self, n: int) -> bytes:
        v = self.d[self.i:self.i + n]
        self.i += n
        return v

    def u8(self) -> int:
        return self._take(1)[0]

    def u16(self) -> int:
        return struct.unpack("<H", self._take(2))[0]

    def u32(self) -> int:
        return struct.unpack("<I", self._take(4))[0]

    def i32(self) -> int:
        return struct.unpack("<i", self._take(4))[0]

    def i64(self) -> int:
        return struct.unpack("<q", self._take(8))[0]

    def utf8(self) -> str:
        n = self.u16()
        if n == 0:
            return ""
        return self._take(n).decode("utf-8")

    def utf8_arr(self):
        return [self.utf8() for _ in range(self.u16())]

    def i32_arr(self):
        return [self.i32() for _ in range(self.u16())]


def parse_manifest(data: bytes):
    """解析 YooAsset 2025.9.30 清单，返回 (package, version, bundles)。"""
    b = _ManifestBuf(data)
    if b.u32() != 0x594F4F:
        raise ValueError("不是有效的 YooAsset 清单 (签名不匹配)")
    ver = b.utf8()
    if ver != "2025.9.30":
        raise ValueError(f"不支持的清单版本: {ver}")
    enable_addressable = b.u8() != 0
    b.u8()  # support_extensionless
    b.u8()  # location_to_lower
    b.u8()  # include_asset_guid
    replace_asset_path_with_address = b.u8() != 0
    b.i32()  # output_name_style
    b.i32()  # build_bundle_type
    b.utf8()  # build_pipeline
    package = b.utf8()
    version = b.utf8()
    b.utf8()  # package_note

    asset_count = b.i32()
    for _ in range(asset_count):
        b.utf8()  # address
        b.utf8()  # asset_path
        b.utf8()  # asset_guid
        b.utf8_arr()  # asset_tags
        b.i32()  # bundle_id
        b.i32_arr()  # depend_bundle_ids

    bundles = []
    bundle_count = b.i32()
    for _ in range(bundle_count):
        bundle = {
            "name": b.utf8(),
            "unity_crc": b.u32(),
            "file_hash": b.utf8(),
            "file_crc": b.u32(),
            "file_size": b.i64(),
            "encrypted": b.u8() != 0,
            "tags": b.utf8_arr(),
            "depend_bundle_ids": b.i32_arr(),
        }
        bundles.append(bundle)
    return package, version, bundles


def download_package(package: str, output_dir: Path, jobs: int) -> dict:
    """下载单个包（清单 + bundle），返回 bundle 列表。"""
    version = PACKAGE_VERSIONS[package]

    manifest_path = _manifest_path(output_dir, package, version)
    if not manifest_path.is_file():
        manifest_path.parent.mkdir(parents=True, exist_ok=True)
        session = requests.Session()
        manifest_path.write_bytes(
            _http_get(_cdn_url(package, version, f"{package}_{version}.bytes"), session)
        )
    package_name, package_version, bundles = parse_manifest(manifest_path.read_bytes())
    console.print(f"[bold cyan][{package}][/bold cyan] 版本 {package_version}，bundle {len(bundles)} 个")

    tasks = []
    for b in bundles:
        url = _cdn_url(package, version, f"{b['file_hash']}.bundle")
        rel = bundle_name_to_path(b["name"])
        if not rel:
            raise ValueError(f"{package}: bundle 名称为空: {b}")
        tasks.append((url, _bundle_path(output_dir, b["name"]), b["file_size"]))

    total = len(tasks)
    if total == 0:
        return bundles

    session = requests.Session()
    progress = Progress(
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
        TextColumn("({task.completed}/{task.total})"),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    )

    pending = list(tasks)
    with progress:
        for round_no in range(4):  # 首次 + 最多 3 轮重试
            if not pending:
                break
            task_id = progress.add_task(
                description=f"[{package}] 第 {round_no + 1} 轮",
                total=len(pending),
            )
            failed = []

            def worker(url, target, size):
                ok = _download_file(url, target, size, session)
                progress.update(
                    task_id,
                    advance=1,
                    description=f"[{package}] {target.name[:24]}",
                )
                if not ok:
                    failed.append((url, target, size))

            with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as pool:
                futures = [pool.submit(worker, *t) for t in pending]
                for fut in concurrent.futures.as_completed(futures):
                    fut.result()
            progress.remove_task(task_id)
            if failed:
                console.print(
                    f"[yellow][{package}] 第 {round_no + 1} 轮有 {len(failed)} 个失败，重试...[/yellow]"
                )
            pending = failed

    if pending:
        names = ", ".join(str(t[1].name) for t in pending[:10])
        raise RuntimeError(f"[{package}] {len(pending)} 个 bundle 下载失败: {names}")
    return bundles


def extract_datatables(output_dir: Path, dest_dir: Path) -> int:
    """从已下载的 DataTables bundle 提取全部 TextAsset 到 dest_dir。"""
    import UnityPy

    manifest_path = _manifest_path(output_dir, "DataTables", "1.0.8")
    _, _, bundles = parse_manifest(manifest_path.read_bytes())
    dest_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    for b in bundles:
        bundle_path = _bundle_path(output_dir, b["name"])
        if not bundle_path.is_file():
            console.print(f"[red]缺少 DataTables bundle: {bundle_path}[/red]")
            continue
        env = UnityPy.load(str(bundle_path))
        for obj in env.objects:
            if obj.type.name != "TextAsset":
                continue
            d = obj.read()
            name = getattr(d, "m_Name", None) or str(obj.path_id)
            raw = d.m_Script
            if isinstance(raw, str):
                raw = raw.encode("utf-8", "surrogateescape")
            (dest_dir / f"{name}.bytes").write_bytes(raw)
            count += 1
    console.print(f"[bold green]数据表提取完成: {count} 个 -> {dest_dir}[/bold green]")
    return count


def extract_codes(output_dir: Path) -> Path:
    """从 HotCode bundle 提取 DLL/PDB 原文件到 DLL/ 目录。"""
    import UnityPy

    manifest_path = _manifest_path(output_dir, "HotCode", "1.0.27")
    _, _, bundles = parse_manifest(manifest_path.read_bytes())
    dll_dir = output_dir / "DLL"
    dll_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    for b in bundles:
        bundle_path = _bundle_path(output_dir, b["name"])
        if not bundle_path.is_file():
            continue
        env = UnityPy.load(str(bundle_path))
        for obj in env.objects:
            if obj.type.name != "TextAsset":
                continue
            d = obj.read()
            name = getattr(d, "m_Name", None) or "asset"
            raw = d.m_Script
            if isinstance(raw, str):
                raw = raw.encode("utf-8", "surrogateescape")
            if raw[:2] == b"MZ" or name.lower().endswith((".dll", ".pdb")):
                (dll_dir / name).write_bytes(raw)
                count += 1
    console.print(f"[bold green]DLL/PDB 提取完成: {count} 个文件 -> {dll_dir}[/bold green]")
    return dll_dir


def decompile_dlls(dll_dir: Path):
    """反编译 DLL/ 下所有 DLL，源码按 DLL 名建子目录，原件保留。"""
    dlls = sorted(dll_dir.glob("*.dll"))
    if not dlls:
        console.print("[yellow]没有找到 DLL[/yellow]")
        return
    if shutil.which("ilspycmd") is None:
        console.print("[yellow]未安装 ilspycmd，已保留原始 DLL，跳过反编译[/yellow]")
        return
    for dll in dlls:
        out = dll_dir / dll.stem
        if out.exists():
            console.print(f"跳过已反编译 {dll.name}")
            continue
        try:
            subprocess.run(
                ["ilspycmd", "-p", "-o", str(out), str(dll)],
                check=True, capture_output=True, timeout=600,
            )
            console.print(f"[green]反编译完成:[/green] {dll.name}")
        except Exception as e:  # noqa: BLE001
            console.print(f"[red]反编译 {dll.name} 失败: {e}[/red]")


def run_download(packages, output_dir: Path, jobs: int) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    for package in packages:
        t0 = time.time()
        download_package(package, output_dir, jobs)
        console.print(f"[bold green][{package}] 完成 ({time.time() - t0:.1f}s)[/bold green]")


def parse_directory(input_dir: Path, output_dir: str) -> None:
    """扫描 input_dir 下所有 .bytes 并导出 JSON 到 output_dir。"""
    os.makedirs(output_dir, exist_ok=True)
    all_tables = set()
    success = set()

    for root, _, files in os.walk(input_dir):
        for filename in files:
            if not filename.endswith(".bytes"):
                continue
            table_name = os.path.splitext(filename)[0]
            all_tables.add(table_name)
            input_path = os.path.join(root, filename)
            if os.path.getsize(input_path) == 0:
                continue
            schema = MasterMap.MASTER_MAP.get(table_name)
            if not schema:
                continue
            try:
                with open(input_path, "rb") as f:
                    binary_data = f.read()
                parsed_data = parse(binary_data, schema)
                if parsed_data and any(parsed_data):
                    output_path = os.path.join(output_dir, f"{table_name}.json")
                    with open(output_path, "w", encoding="utf-8") as f:
                        json.dump(parsed_data, f, indent=4, ensure_ascii=False)
                    success.add(table_name)
            except Exception as e:
                console.print(f"[red]处理文件 '{input_path}' 时发生错误: {e}[/red]")

    unprocess = all_tables - success
    if unprocess:
        for table_name in sorted(unprocess):
            if table_name not in MasterMap.MASTER_MAP:
                console.print(f"[yellow]{table_name}.bytes 在 MasterMap.py 中无对应 schema[/yellow]")


def decrypt_all(encrypted_data: bytes) -> bytes:
    """AesXorEncryption.DecryptAllData：行长度种子 + LCG 密钥流异或。"""
    if not encrypted_data:
        return encrypted_data
    n = len(encrypted_data)
    num = 0x9E3779B9  # 2654435769
    for _ in range(8):
        num = ((num << 1) | (num >> 31)) & 0xFFFFFFFF
        num ^= n
    out = bytearray(n)
    for i in range(n):
        out[i] = encrypted_data[i] ^ (num & 0xFF)
        num = (num * 1103515245 + 12345) & 0xFFFFFFFF
    return bytes(out)


class BinaryReader:
    def __init__(self, data: bytes, offset: int = 0):
        self.data = data
        self.offset = offset

    def read_byte(self) -> int:
        val = self.data[self.offset]
        self.offset += 1
        return val

    def read_boolean(self) -> bool:
        return self.read_byte() != 0

    def read_single(self) -> float:
        val = struct.unpack('<f', self.data[self.offset:self.offset+4])[0]
        self.offset += 4
        return val
        
    def read_long(self) -> int:
        value, shift = 0, 0
        while True:
            byte = self.read_byte()
            value |= (byte & 0x7F) << shift
            if (byte & 0x80) == 0:
                break
            shift += 7
            if shift >= 70:
                raise ValueError("7位编码长格式错误")
        if value >= (1 << 63):   # C# long 为有符号，-1 编码成 10 字节
            value -= 1 << 64
        return value

    def read_7bit_encoded_int(self) -> int:
        value = 0
        shift = 0
        while True:
            byte = self.read_byte()
            value |= (byte & 0x7F) << shift
            if (byte & 0x80) == 0:
                break
            shift += 7
            if shift >= 35:
                raise ValueError("7位编码长格式错误")
        return value

    def read_string(self) -> str:
        length = self.read_7bit_encoded_int()
        if length <= 0: return ""
        string_bytes = self.data[self.offset:self.offset+length]
        self.offset += length
        return string_bytes.decode('utf-8', errors='ignore')

    def read_list_int(self) -> list[int]:
        content = self.read_string()
        if not content:
            return []
        try:
            return [int(x) for x in content.split(',') if x]
        except ValueError:
            return []

    def read_list_float(self) -> list[float]:
        content = self.read_string()
        if not content:
            return []
        try:
            return [float(x) for x in content.split(',') if x]
        except ValueError:
            return []

    def read_list_boolean(self) -> list[bool]:
        content = self.read_string()
        if not content:
            return []
        return [x.lower() == 'true' or x == '1' for x in content.split(',') if x]

    def read_list_string(self) -> list[str]:
        content = self.read_string()
        if not content:
            return []
        if content.startswith('|') and content.endswith('|'):
            return content.strip('|').split('|')
        else:
            return content.split(',')

    def read_list_list_int(self) -> list[list[int]]:
        content = self.read_string()
        if not content: return []
        return [[int(num) for num in part.split(',') if num] for part in content.split('|') if part]

    def read_list_list_float(self) -> list[list[float]]:   # ';' 分组 (SemicolonList)
        content = self.read_string()
        if not content: return []
        outer_list = []
        for part in content.split(';'):
            if not part: continue
            try:
                outer_list.append([float(x) for x in part.split(',') if x])
            except ValueError:
                continue
        return outer_list

    def read_list_list_string(self) -> list[list[str]]:    # ';' 分组 (SemicolonList)
        content = self.read_string()
        if not content: return []
        outer_list = []
        for part in content.split(';'):
            if not part: continue
            outer_list.append([x for x in part.split(',') if x])
        return outer_list

    def read_list_list_int_pipe(self) -> list[list[int]]:
        content = self.read_string()
        if not content: return []
        return [[int(num) for num in part.split(',') if num] for part in content.split('|') if part]

    def read_list_list_float_pipe(self) -> list[list[float]]:   # '|' 分组 (ReadListFloatList)
        content = self.read_string()
        if not content: return []
        outer_list = []
        for part in content.split('|'):
            if not part: continue
            try:
                outer_list.append([float(x) for x in part.split(',') if x])
            except ValueError:
                continue
        return outer_list

    def read_list_list_string_pipe(self) -> list[list[str]]:    # '|' 分组 (ReadListStringList)
        content = self.read_string()
        if not content: return []
        outer_list = []
        for part in content.split('|'):
            if not part: continue
            outer_list.append([x for x in part.split(',') if x])
        return outer_list

    def read_condition_list_string(self) -> list[list[str]]:    # '&' 或 '|' 分组 (ConditionList)
        content = self.read_string()
        if not content: return []
        if '&' in content:
            sep = '&'
        elif '|' in content:
            sep = '|'
        else:
            sep = None
        if sep:
            parts = [p for p in content.split(sep) if p]
        else:
            parts = [content]
        return [[x for x in part.split(',') if x] for part in parts]

    def get_position(self):
        return self.offset

    def get_length(self):
        return len(self.data)
        
    def has_more_data(self) -> bool:
        return self.offset < len(self.data)

def parse(file_data: bytes, schema: list) -> list[dict]:
    main_reader = BinaryReader(file_data)
    records = []
    
    type_to_method = {
        'int': 'read_7bit_encoded_int',
        'long': 'read_long',
        'string': 'read_string',
        'float': 'read_single',
        'bool': 'read_boolean',
        'enum': 'read_string',
        'List<bool>': 'read_list_boolean',
        'List<int>': 'read_list_int',
        'List<string>': 'read_list_string',
        'List<float>': 'read_list_float',
        'List<enum>': 'read_list_string',
        'List<List<int>>': 'read_list_list_int',
        'List<List<float>>': 'read_list_list_float_pipe',
        'List<List<string>>': 'read_list_list_string_pipe',
        'SemicolonList<List<float>>': 'read_list_list_float',
        'SemicolonList<List<string>>': 'read_list_list_string',
        'ConditionList<List<string>>': 'read_condition_list_string',
    }
    
    while main_reader.has_more_data():
        try:
            if main_reader.get_position() + 1 > main_reader.get_length(): break
            row_length = main_reader.read_7bit_encoded_int()
            row_data_start = main_reader.get_position()
            if row_length <= 0 or row_data_start + row_length > main_reader.get_length(): break
            row_data = file_data[row_data_start : row_data_start + row_length]
            row_reader = BinaryReader(row_data)
            if isinstance(schema, dict) and schema.get('encrypted'):
                row_data = decrypt_all(row_data)
                row_reader = BinaryReader(row_data)
            record = {}
            field_list = schema['fields'] if isinstance(schema, dict) else schema
            for field in field_list:
                method_name = type_to_method.get(field['type'])
                if not method_name: raise TypeError(f"未知的字段类型: {field['type']}")
                if not row_reader.has_more_data(): break
                record[field['name']] = getattr(row_reader, method_name)()
            if record: records.append(record)
            main_reader.offset = row_data_start + row_length
        except (IndexError, struct.error, ValueError, UnicodeDecodeError) as e:
            console.print(f"[yellow]警告: 文件 {schema} 解析时发生错误: {e}[/yellow]")
            break
    return records

def main():
    parser = argparse.ArgumentParser(
        prog="Embers.py",
        description="《灰烬》数据表下载/解密/导出工具",
    )
    parser.add_argument(
        "input_dir",
        nargs="?",
        default="DataTables",
        help="数据表 .bytes 目录（默认 DataTables）",
    )
    parser.add_argument(
        "--download",
        action="store_true",
        help="先下载 CDN 资源：默认数据表+全资产",
    )
    parser.add_argument(
        "--datatables-only",
        action="store_true",
        help="只数据表模式：自动下载 DataTables 数据包和 HotCode 代码包，并反编译 DLL",
    )
    parser.add_argument(
        "-o",
        "--output",
        default="Download",
        help="下载输出目录（默认 Download）",
    )
    parser.add_argument(
        "-j",
        "--jobs",
        type=int,
        default=8,
        help="并发下载数（默认 8）",
    )
    args = parser.parse_args()

    if args.datatables_only:
        args.download = True
        packages = list(DATATABLES_ONLY_PACKAGES)
        console.print("[bold]下载模式: 仅数据表 + Codes[/bold]")
    elif args.download:
        packages = list(ALL_PACKAGES)
        console.print("[bold]下载模式: 数据表 + 全资产[/bold]")

    if args.download:
        run_download(packages, Path(args.output), max(1, args.jobs))

        table_dir = Path(args.input_dir)
        extract_datatables(Path(args.output), table_dir)

        if args.datatables_only:
            dll_dir = extract_codes(Path(args.output))
            decompile_dlls(dll_dir)

    parse_directory(Path(args.input_dir), "MasterData")
    console.print("[bold green]数据表导出完成 -> MasterData/[/bold green]")

if __name__ == "__main__":
    main()
