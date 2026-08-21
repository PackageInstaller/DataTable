"""
从热更程序集（HybridCLR Hotfix.dll）反编译出的 DR*.cs 生成 MasterMap.py。

数据行类（Ase.DR*) 的字段顺序和读取方式以 ParseDataRow(byte[], int, int, object)
方法体为准。每张表是否加密（行数据先经 AesXorEncryption.DecryptAllData 解密）
也由该方法体判断。

用法：
    python3 GenerateMasterMap.py                       # 自动：从 CDN API 下载 Hotfix.dll 并处理
    python3 GenerateMasterMap.py hotfix_src            # 指定反编译源码目录
    python3 GenerateMasterMap.py Hotfix.dll            # 直接用 ilspycmd 反编译 DLL
"""

import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.request
from pathlib import Path


# ── CDN API（kiifstudio） ───────────────────────────────

CDN_BASE = "https://ab.kiifstudio.com/ASH_1.6_FORMAL"
CDN_PLATFORM = "Android"
HOTCODE_VERSION = "1.0.27"
CDN_USER_AGENT = "UnityPlayer/2021.3.32f1c1 (UnityWebRequest/1.0, libcurl/8.1.1-DEV)"


def _fetch(url: str, timeout: int = 60) -> bytes:
    last_err = None
    for attempt in range(3):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": CDN_USER_AGENT})
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                return resp.read()
        except Exception as e:  # noqa: BLE001
            last_err = e
            time.sleep(1.5 * (attempt + 1))
    raise RuntimeError(f"下载失败: {url}: {last_err}")


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
        return "" if n == 0 else self._take(n).decode("utf-8")

    def utf8_arr(self):
        return [self.utf8() for _ in range(self.u16())]

    def i32_arr(self):
        return [self.i32() for _ in range(self.u16())]


def parse_manifest(data: bytes):
    """解析 YooAsset 2025.9.30 清单，返回 (package, version, bundles)。"""
    b = _ManifestBuf(data)
    if b.u32() != 0x594F4F:
        raise ValueError("不是有效的 YooAsset 清单 (签名不匹配)")
    if b.utf8() != "2025.9.30":
        raise ValueError("不支持的清单版本，仅支持 2025.9.30")
    b.u8(); b.u8(); b.u8(); b.u8()
    b.u8()  # replace_asset_path_with_address
    b.i32(); b.i32()
    b.utf8()  # build_pipeline
    package = b.utf8()
    version = b.utf8()
    b.utf8()  # package_note

    asset_count = b.i32()
    for _ in range(asset_count):
        b.utf8(); b.utf8(); b.utf8()
        b.utf8_arr(); b.i32(); b.i32_arr()

    bundles = []
    bundle_count = b.i32()
    for _ in range(bundle_count):
        name = b.utf8()
        b.u32()  # unity_crc
        file_hash = b.utf8()
        b.u32()  # file_crc
        file_size = b.i64()
        encrypted = b.u8() != 0
        b.utf8_arr()  # tags
        b.i32_arr()  # depend_bundle_ids
        bundles.append({
            "name": name,
            "file_hash": file_hash,
            "file_size": file_size,
            "encrypted": encrypted,
        })
    return package, version, bundles


def download_hotfix_dll(work_dir: str) -> str:
    """从 CDN API 下载 HotCode 清单 + hotfix bundle，提取 Hotfix.dll。"""
    work = Path(work_dir)
    work.mkdir(parents=True, exist_ok=True)

    manifest_name = f"HotCode_{HOTCODE_VERSION}.bytes"
    manifest_url = f"{CDN_BASE}/{CDN_PLATFORM}/HotCode/{HOTCODE_VERSION}/{manifest_name}"
    print(f"[*] 下载清单 {manifest_url}")
    manifest_data = _fetch(manifest_url)
    (work / manifest_name).write_bytes(manifest_data)

    package, version, bundles = parse_manifest(manifest_data)
    print(f"[*] 清单: {package} {version}，bundle {len(bundles)} 个")
    hotfix_bundle = None
    for b in bundles:
        if "hotfix" in b["name"].lower():
            hotfix_bundle = b
            break
    if not hotfix_bundle:
        raise RuntimeError(f"清单中找不到 hotfix bundle: {[b['name'] for b in bundles]}")

    bundle_url = (
        f"{CDN_BASE}/{CDN_PLATFORM}/HotCode/{HOTCODE_VERSION}/"
        f"{hotfix_bundle['file_hash']}.bundle"
    )
    print(f"[*] 下载 bundle {hotfix_bundle['name']} ({hotfix_bundle['file_size']} B)")
    bundle_data = _fetch(bundle_url, timeout=120)
    if len(bundle_data) != hotfix_bundle["file_size"]:
        raise RuntimeError(
            f"bundle 大小不匹配: {len(bundle_data)} != {hotfix_bundle['file_size']}"
        )
    bundle_path = work / "hotfix.bundle"
    bundle_path.write_bytes(bundle_data)

    try:
        import UnityPy
    except ImportError:
        raise RuntimeError("需要 UnityPy: pip install UnityPy") from None

    env = UnityPy.load(str(bundle_path))
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        d = obj.read()
        name = getattr(d, "m_Name", None) or ""
        raw = d.m_Script
        if isinstance(raw, str):
            raw = raw.encode("utf-8", "surrogateescape")
        if name.lower() == "hotfix.dll" or (raw[:2] == b"MZ" and name.lower().endswith(".dll")):
            dll_path = work / "Hotfix.dll"
            dll_path.write_bytes(raw)
            print(f"[*] 提取 {name} ({len(raw)} B) -> {dll_path}")
            return str(dll_path)
    raise RuntimeError("bundle 中未找到 Hotfix.dll")


# BinaryReader / BinaryExtension 读取方法 -> 导出类型
READER_TO_TYPE = {
    "Read7BitEncodedInt32": "int",
    "Read7BitEncodedInt64": "long",
    "ReadString": "string",
    "ReadSingle": "float",
    "ReadBoolean": "bool",
    "ReadListInt": "List<int>",
    "ReadListFloat": "List<float>",
    "ReadListBool": "List<bool>",
    "ReadListString": "List<string>",
    "ReadListIntList": "List<List<int>>",                 # '|' 分组
    "ReadListFloatList": "List<List<float>>",             # '|' 分组
    "ReadListStringList": "List<List<string>>",           # '|' 分组
    "ReadListsSemicolonStringList": "SemicolonList<List<string>>",   # ';' 分组
    "ReadListsSemicolonFloatList": "SemicolonList<List<float>>",     # ';' 分组
    "ReadListsConditionStringList": "ConditionList<List<string>>",   # '&'/'|' 分组
    "ReadEnum": "enum",                                   # 二进制里存的是枚举名字符串
    "ReadListEnum": "List<enum>",                         # 逗号分隔的枚举名
}

# 孤儿表（游戏加载名单 Global.DataTableNames 之外、无对应 DR 类）结构复用：
# 这些 .bytes 为明文，字段结构与现有 DR 类完全一致（逐行解析到 EOF 验证）。
# Sheet1 没有任何现有 schema 能解析，保持无 schema。
REUSE_MAP = {
    "ActivityRewardUI": "SceneryNote",
    "ActivityTxt": "ErrorCode",
    "MainCopy": "CopyMain",
    "SkinAssociationEffect": "Material",
    "SkinAssociationSound": "Material",
    "SummonedSkin": "Emoticon",
}


ASSIGN_RE = re.compile(
    r"^\s*(\w+)\s*=\s*"
    r"(?:BinaryExtension\.([A-Za-z0-9_]+)\(binaryReader\)"
    r"|binaryReader\.([A-Za-z0-9_]+)(?:<[^>]*>)?\(\))\s*;"
)

PARSE_METHOD_RE = re.compile(
    r"ParseDataRow\(byte\[\] dataRowBytes, int startIndex, int length, object userData\)\s*(.*?)\n\s*GeneratePropertyArray\(\);",
    re.DOTALL,
)


def parse_dr_file(path: str):
    """解析单个 DR*.cs，返回 (table_name, encrypted, [field...])。"""
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    base = os.path.basename(path)
    class_name = re.match(r"(DR\w+)\.cs$", base)
    if not class_name:
        return None
    table_name = class_name.group(1)[2:]

    m = PARSE_METHOD_RE.search(content)
    if not m:
        raise ValueError(f"{path}: 找不到 ParseDataRow(byte[]) 方法体")
    body = m.group(1)

    encrypted = "AesXorEncryption.DecryptAllData" in body
    fields = []
    for line in body.splitlines():
        am = ASSIGN_RE.match(line)
        if not am:
            continue
        field_name, reader_binary, reader_inst = am.groups()
        reader = reader_binary or reader_inst
        if reader not in READER_TO_TYPE:
            raise ValueError(f"{path}: 未知读取方法 {reader} (字段 {field_name})")
        if field_name == "m_Id":
            field_name = "Id"
        if not any(f["name"] == field_name for f in fields):
            fields.append({"name": field_name, "type": READER_TO_TYPE[reader]})

    if not fields:
        raise ValueError(f"{path}: 未解析到任何字段")
    return table_name, encrypted, fields


def decompile_with_ilspycmd(dll_path: str, out_dir: str):
    subprocess.run(
        ["ilspycmd", "-p", "-o", out_dir, dll_path],
        check=True,
    )


def auto_generate(output_py_path: str):
    """自动模式：从 CDN API 下载 Hotfix.dll -> 反编译 -> 生成 MasterMap.py。"""
    work = tempfile.mkdtemp(prefix="hotfix_work_")
    src = tempfile.mkdtemp(prefix="hotfix_src_")
    try:
        dll = download_hotfix_dll(work)
        print(f"[*] 使用 ilspycmd 反编译 {dll} -> {src}")
        decompile_with_ilspycmd(dll, src)
        generate_map(src, output_py_path)
    finally:
        shutil.rmtree(work, ignore_errors=True)
        shutil.rmtree(src, ignore_errors=True)


def generate_map(source: str, output_py_path: str):
    """source 可以是反编译源码目录，或 Hotfix.dll 路径。"""
    if source.lower().endswith(".dll"):
        tmp = tempfile.mkdtemp(prefix="hotfix_src_")
        print(f"[*] 使用 ilspycmd 反编译 {source} -> {tmp}")
        decompile_with_ilspycmd(source, tmp)
        source = tmp

    dr_dir = os.path.join(source, "Ase") if os.path.isdir(os.path.join(source, "Ase")) else source
    dr_files = sorted(
        os.path.join(dr_dir, fn)
        for fn in os.listdir(dr_dir)
        if re.match(r"DR\w+\.cs$", fn)
    )
    if not dr_files:
        raise FileNotFoundError(f"在 {dr_dir} 中找不到 DR*.cs")

    schema_definitions = {}
    for path in dr_files:
        table_name, encrypted, fields = parse_dr_file(path)
        schema_definitions[table_name] = {"encrypted": encrypted, "fields": fields}
        # print(f"[+] {table_name}: encrypted={encrypted}, fields={len(fields)}")

    # 复用已有 DR 字段的孤儿表（明文）
    for table_name, source_table in REUSE_MAP.items():
        if table_name in schema_definitions:
            continue
        source = schema_definitions.get(source_table)
        if not source:
            print(f"警告: 复用源表 '{source_table}' 不存在，跳过 {table_name}")
            continue
        schema_definitions[table_name] = {
            "encrypted": False,
            "fields": [dict(f) for f in source["fields"]],
        }
        print(f"[+] {table_name} 复用 {source_table} 字段（明文）")

    with open(output_py_path, "w", encoding="utf-8") as f:
        f.write("# 此文件由脚本自动生成，请勿手动修改。\n\nMASTER_MAP = {\n")
        for table_name in sorted(schema_definitions.keys()):
            info = schema_definitions[table_name]
            f.write(f"    '{table_name}': {{\n")
            f.write(f"        'encrypted': {str(info['encrypted'])},\n")
            f.write("        'fields': [\n")
            for field in info["fields"]:
                f.write(f"            {{'name': '{field['name']}', 'type': '{field['type']}'}},\n")
            f.write("        ],\n")
            f.write("    },\n")
        f.write("}\n")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        generate_map(sys.argv[1], "MasterMap.py")
    else:
        auto_generate("MasterMap.py")
