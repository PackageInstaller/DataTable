import os
import struct
import json
import hashlib
import requests
import brotli
from MAkeDramaSchema import DATABASE_SCHEMA, ENUM_SCHEMA, TABLE_NAMES


def ror64(val: int, r_bits: int) -> int:
    val &= 0xFFFFFFFFFFFFFFFF
    return ((val >> r_bits) | (val << (64 - r_bits))) & 0xFFFFFFFFFFFFFFFF


def verify_header(v20: int, v25: int, v30: int, val4: int) -> bool:
    part1 = ror64((v25 - 0x5DB4512B69C11BF9) & 0xFFFFFFFFFFFFFFFF, 51)
    part2 = ror64(v20 ^ 0x9E3779B97F4A7C15, 57)
    part3 = ror64(v30 ^ 0x3C79AC492BA7B653, 35)
    part4 = ror64((val4 + 0x1C69B3F74AC4AE35) & 0xFFFFFFFFFFFFFFFF, 21)
    checksum = part1 ^ part2 ^ part3 ^ part4
    return checksum == 0x5BBA323116390A2F


def read_memorypack_string(payload: bytes, offset: int) -> tuple[str | None, int]:
    header = struct.unpack("<i", payload[offset : offset + 4])[0]
    offset += 4

    if header == -1:
        return None, offset

    elif header < -1:
        # UTF-8 编码字符串：
        # 格式: [int: ~utf8_byte_count] [int: utf16_length] [N bytes: utf8 data]
        # header = ~utf8_byte_count，下一 4 字节是 utf16_length（跳过）
        offset += 4  # skip utf16_length
        byte_len = ~header  # 即 -(header + 1)，实际的 UTF-8 字节数
        s = payload[offset : offset + byte_len].decode("utf-8")
        offset += byte_len
        return s, offset

    else:
        #  UTF-16 编码字符串：
        # header 为字符数，实际字节长度为字符数 * 2
        byte_len = header * 2
        # C# string 内存中是标准的 Little-Endian UTF-16 (不带 BOM 标志)
        s = payload[offset : offset + byte_len].decode("utf-16-le")
        offset += byte_len
        return s, offset


def read_field_by_type(payload: bytes, offset: int, field_type: str) -> tuple[any, int]:

    # 数组类型 (如 int[], string[], STAT_TYPE[])
    if field_type.endswith("[]"):
        element_type = field_type[:-2]
        count = struct.unpack("<i", payload[offset : offset + 4])[0]
        offset += 4
        if count == -1:
            return None, offset
        arr = []
        for _ in range(count):
            val, offset = read_field_by_type(payload, offset, element_type)
            arr.append(val)
        return arr, offset

    # 泛型 List 类型 (如 List<int> 或 List<STAT_TYPE>)
    elif field_type.startswith("List<") and field_type.endswith(">"):
        element_type = field_type[5:-1]
        count = struct.unpack("<i", payload[offset : offset + 4])[0]
        offset += 4
        if count == -1:
            return None, offset
        arr = []
        for _ in range(count):
            val, offset = read_field_by_type(payload, offset, element_type)
            arr.append(val)
        return arr, offset

    # 可空类型 Nullable<T> (在 MemoryPack 中，1 字节 hasValue + 如果为真则跟原始 T 字节数据)
    elif field_type.startswith("Nullable<") and field_type.endswith(">"):
        element_type = field_type[9:-1]
        has_value = payload[offset]
        offset += 1
        if has_value:
            return read_field_by_type(payload, offset, element_type)
        else:
            return None, offset

    # 字符串类型
    elif field_type == "string":
        return read_memorypack_string(payload, offset)

    # 扫描已知的枚举，翻译为其在 C# 中的定义明文
    elif field_type in ENUM_SCHEMA:
        underlying_type = ENUM_SCHEMA[field_type].get("__underlying_type", "int")
        # 递归调用以根据其真实的 C# 基类读取对应的字节
        val, offset = read_field_by_type(payload, offset, underlying_type)
        readable_val = ENUM_SCHEMA[field_type].get(val, val)
        return readable_val, offset

    # 标准整数型
    elif field_type in ("int", "int32"):
        val = struct.unpack("<i", payload[offset : offset + 4])[0]
        return val, offset + 4
    elif field_type in ("uint", "uint32"):
        val = struct.unpack("<I", payload[offset : offset + 4])[0]
        return val, offset + 4

    # 短整型
    elif field_type in ("short", "int16"):
        val = struct.unpack("<h", payload[offset : offset + 2])[0]
        return val, offset + 2
    elif field_type in ("ushort", "uint16"):
        val = struct.unpack("<H", payload[offset : offset + 2])[0]
        return val, offset + 2

    # 64位长整型 / System.DateTime (8 字节 unmanaged)
    elif field_type in ("long", "int64", "System.DateTime", "DateTime"):
        val = struct.unpack("<q", payload[offset : offset + 8])[0]
        return val, offset + 8
    elif field_type in ("ulong", "uint64"):
        val = struct.unpack("<Q", payload[offset : offset + 8])[0]
        return val, offset + 8

    # 浮点型
    elif field_type == "float":
        val = struct.unpack("<f", payload[offset : offset + 4])[0]
        return val, offset + 4
    elif field_type == "double":
        val = struct.unpack("<d", payload[offset : offset + 8])[0]
        return val, offset + 8

    # 单字节与布尔
    elif field_type == "byte":
        return payload[offset], offset + 1
    elif field_type == "sbyte":
        val = struct.unpack("<b", payload[offset : offset + 1])[0]
        return val, offset + 1
    elif field_type == "bool":
        return bool(payload[offset]), offset + 1

    # 如果遇到的未知类型首字母是大写的，一般是没扫描到的 C# 枚举，默认读取 4 字节 int32
    if field_type and field_type[0].isupper():
        val = struct.unpack("<i", payload[offset : offset + 4])[0]
        return val, offset + 4

    val = struct.unpack("<i", payload[offset : offset + 4])[0]
    return val, offset + 4


def deserialize_table_to_dict(table_name: str, payload: bytes) -> dict:
    result = {"__tableName": table_name, "__byteLength": len(payload)}

    if table_name in DATABASE_SCHEMA:
        fields = DATABASE_SCHEMA[table_name]
        try:
            count = struct.unpack("<i", payload[0:4])[0]
            if count == -1:
                return {"items": None}

            offset = 4
            items = []
            for _ in range(count):
                member_count = payload[offset]
                offset += 1

                item = {}
                for i in range(member_count):
                    if i < len(fields):
                        field_name, field_type = fields[i]
                        val, offset = read_field_by_type(payload, offset, field_type)
                        item[field_name] = val
                    else:
                        # 未知的额外字段 — 尝试以 int 消费（4 字节）以防止偏移错位
                        # 已知 MemoryPack 不会产生小于 4 字节的字段边界
                        if offset + 4 <= len(payload):
                            offset += 4
                items.append(item)

            result["items"] = items
        except Exception as e:
            result["__parseError"] = f"动态解析失败: {e}"
            result["__uncompressedPayloadHex"] = payload.hex()
    else:
        result["__uncompressedPayloadHex"] = payload.hex()
        result["__status"] = "Missing schema definition in AbyssSchema.py"

    return result


def get_app_version() -> str | None:
    try:
        from google_play_scraper import app as playstore_app

        result = playstore_app(
            app_id="com.wemadeconnect.aos.makedrama.google", lang="en", country="kr"
        )
        version = result.get("version")
        if version:
            print(f"Google Play 版本号: {version}")
            return version
    except Exception as e:
        print(f"Google Play 查询失败: {e}")
    return "1.1.0"


def compute_config_hash(version: str, env_type: str = "LIVE", length: int = 10) -> str:
    input_str = version + env_type + "live_key_76539"
    sha256_hash = hashlib.sha256(input_str.encode("utf-8")).hexdigest()
    return sha256_hash[:length]


def process_pipeline():
    output_dir = "MasterData"
    app_version = get_app_version()
    config_hash = compute_config_hash(app_version)
    print(f"Computed ConfigHash: {config_hash} (version={app_version})")

    os.makedirs(output_dir, exist_ok=True)
    with open(os.path.join(output_dir, ".version"), "w") as f:
        f.write(app_version)

    config_url = f"https://d27ds7moynzi4t.cloudfront.net/{config_hash}/config.json"
    try:
        config_data = requests.get(config_url, timeout=10).json()
    except Exception as e:
        print(f"获取 config.json 失败: {e}")
        return

    master_hash = config_data["MasterHash"]
    master_url = f"https://d27ds7moynzi4t.cloudfront.net/{config_hash}/Master/master_{master_hash}.mpks"

    try:
        data_bytes = requests.get(master_url, timeout=20).content
    except Exception as e:
        print(f"下载 .mpks 失败: {e}")
        return

    file_size = len(data_bytes)

    header_fmt = "<4sIQQQQ8sI"
    magic, version, v20, v25, v30, val4, commit_hash_bytes, pack_count = struct.unpack(
        header_fmt, data_bytes[:52]
    )
    commit_hash = commit_hash_bytes.decode("ascii", errors="ignore").strip()

    if magic != b"MPKS" or version != 2 or not verify_header(v20, v25, v30, val4):
        print("MPKS 文件校验未通过")
        return
    print(f"文件头校验通过，Commit Hash: {commit_hash}")

    sizes = []
    offsets = []
    current_offset = 52 + 4 * pack_count
    for i in range(pack_count):
        idx_offset = 52 + 4 * i
        pack_size = struct.unpack("<I", data_bytes[idx_offset : idx_offset + 4])[0]
        sizes.append(pack_size)
        offsets.append(current_offset)
        current_offset += pack_size

    if current_offset != file_size:
        print("错误: 索引包与总文件大小不对齐")
        return

    json_output_buffer = {}

    for pack_idx in range(pack_count):
        pack_offset = offsets[pack_idx]
        pack_size = sizes[pack_idx]
        pack_end = pack_offset + pack_size

        table_count = struct.unpack("<i", data_bytes[pack_offset : pack_offset + 4])[0]
        current_pos = pack_offset + 4

        for t_i in range(table_count):
            meta_bytes = data_bytes[current_pos : current_pos + 16]
            table_idx, compression_type, payload_size, decompressed_size = (
                struct.unpack("<iiii", meta_bytes)
            )

            if table_idx < len(TABLE_NAMES):
                table_name = TABLE_NAMES[table_idx]
            else:
                table_name = f"unknown_table_{table_idx}"

            payload_start = current_pos + 16
            raw_payload = data_bytes[payload_start : payload_start + payload_size]

            if compression_type == 1:
                decompressed_payload = brotli.decompress(raw_payload)
            else:
                decompressed_payload = raw_payload

            table_dict = deserialize_table_to_dict(table_name, decompressed_payload)
            file_name = f"{table_name}.json"
            json_output_buffer[file_name] = table_dict

            current_pos = payload_start + payload_size

    os.makedirs(output_dir, exist_ok=True)

    for file_name, table_dict in json_output_buffer.items():
        save_path = os.path.join(output_dir, file_name)
        with open(save_path, "w", encoding="utf-8") as f:
            json.dump(table_dict, f, indent=2, ensure_ascii=False)


if __name__ == "__main__":
    process_pipeline()
