import argparse
import json
import os
import struct
import sys
import zlib

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))


def read_u16(buf, off):
    return struct.unpack_from("<H", buf, off)[0]


def read_u32(buf, off):
    return struct.unpack_from("<I", buf, off)[0]


def read_utf(buf, off):
    n = read_u16(buf, off)
    return buf[off + 2 : off + 2 + n].decode("utf-8"), off + 2 + n


def raw_inflate(data):
    return zlib.decompress(data, -15)


def parse_json_combo(dec):
    count = read_u32(dec, 0)
    off = 4
    out = {}
    for _ in range(count):
        name, off = read_utf(dec, off)
        value, off = read_utf(dec, off)
        out[name] = value
    return out


def parse_cfg_entries(dec):
    count = read_u32(dec, 0)
    off = 4
    out = []
    for _ in range(count):
        name, off = read_utf(dec, off)
        size = read_u32(dec, off)
        off += 4
        out.append((name, dec[off : off + size]))
        off += size
    return out


def read_num(buf, off, length):
    v = 0
    for i in range(length):
        v |= buf[off + i] << (8 * i)
    return v, off + length


def parse_table(data):
    pos = 0

    len_type = data[pos]
    pos += 1
    col_count, pos = read_num(data, pos, len_type)

    id_len_type = data[pos]
    pos += 1
    row_count, pos = read_num(data, pos, id_len_type)

    columns = []
    for _ in range(col_count):
        name, pos = read_utf(data, pos)
        columns.append(name)

    rows = []
    for _ in range(row_count):
        row_id, pos = read_num(data, pos, id_len_type)
        field_count, pos = read_num(data, pos, len_type)
        row = {}
        for _ in range(field_count):
            key, pos = read_num(data, pos, len_type)
            value_type = data[pos]
            pos += 1
            if value_type == 0:
                value, pos = read_utf(data, pos)
            elif value_type in (1, 2, 4):
                value, pos = read_num(data, pos, value_type)
            else:
                raise ValueError(f"unknown value type {value_type}")
            col = columns[key] if key < len(columns) else str(key)
            row[col] = value
        rows.append({"id": row_id, **row})
    return {"columns": columns, "rows": rows}


def detect_kind(dec):
    off = 4
    _, off = read_utf(dec, off)
    if off + 2 <= len(dec):
        n = read_u16(dec, off)
        if off + 2 + n <= len(dec):
            try:
                json.loads(dec[off + 2 : off + 2 + n].decode("utf-8"))
                return "json"
            except (ValueError, UnicodeDecodeError):
                pass
    return "cfg"


def safe_rel_path(name):
    parts = [p for p in name.replace("\\", "/").split("/") if p not in ("", ".", "..")]
    return os.path.join(*parts) if parts else "unnamed"


def process_one(path, out_root):
    base = os.path.splitext(os.path.basename(path))[0]
    dest = os.path.join(out_root, base)
    os.makedirs(dest, exist_ok=True)

    data = open(path, "rb").read()
    dec = raw_inflate(data)
    print(f"{base}: {len(data)} -> {len(dec)} bytes (raw inflate)")

    kind = detect_kind(dec)
    if kind == "json":
        entries = parse_json_combo(dec)
        for name, text in entries.items():
            rel = safe_rel_path(name)
            fp = os.path.join(dest, rel + ".json")
            os.makedirs(os.path.dirname(fp), exist_ok=True)
            with open(fp, "w", encoding="utf-8") as f:
                f.write(json.dumps(json.loads(text), ensure_ascii=False, indent=2))
        print(f"  json entries: {len(entries)}")
    else:
        entries = parse_cfg_entries(dec)
        parsed = 0
        for name, blob in entries:
            rel = safe_rel_path(name)
            try:
                table = parse_table(blob)
                fp = os.path.join(dest, rel + ".json")
                os.makedirs(os.path.dirname(fp), exist_ok=True)
                with open(
                    os.path.join(dest, rel + ".json"), "w", encoding="utf-8"
                ) as f:
                    json.dump(table, f, ensure_ascii=False, indent=2)
                parsed += 1
            except Exception as e:
                print(f"  [warn] table {name} not json-parseable: {e}")
        print(f"  cfg tables: {parsed}/{len(entries)}")


def main():
    ap = argparse.ArgumentParser(
        description="Decrypt & deserialize 芙娅之魂 .bin files from a folder"
    )
    ap.add_argument("folders", nargs="+", help="folder(s) containing .bin files")
    args = ap.parse_args()

    out_root = os.path.join(SCRIPT_DIR, "MasterData")
    os.makedirs(out_root, exist_ok=True)

    for folder in args.folders:
        if not os.path.isdir(folder):
            continue
        for root, _dirs, files in os.walk(folder):
            for fname in sorted(files):
                if fname.lower().endswith(".bin"):
                    process_one(os.path.join(root, fname), out_root)


if __name__ == "__main__":
    main()
