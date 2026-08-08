import re
import struct
from pathlib import Path

M32 = 0xFFFFFFFF

_VM_TEXT = None
CASES = None
# 壳 VM 的 256 个 opcode 实现（IDA Hex-Rays 反编译 sub_1806E11F0 导出，
_VM_PATH = Path(__file__).resolve().parent / "vm_full.txt"


def _load_cases():
    global CASES, _VM_TEXT
    if CASES is None:
        _VM_TEXT = _VM_PATH.read_text(encoding="utf-8")
        CASES = parse_cases(_VM_TEXT)
    return CASES


def ror1(x, n):
    n &= 7
    return ((x >> n) | (x << (8 - n))) & 0xFF


def parse_cases(text):
    cases = {}
    # split on case 0xNN:
    parts = re.split(r"case (0x[0-9A-Fa-f]+|\d+):", text)
    # parts[0] is the prologue; then alternating case-expr, body
    for i in range(1, len(parts) - 1, 2):
        op = int(parts[i], 0)
        body = parts[i + 1]
        # stop at next 'case' (body may contain text beyond, but we sliced per split)
        body = body.split("goto LABEL_262;")[0]
        if "LABEL_6" in body:
            m = re.search(
                r"v11 = (0x[0-9A-Fa-f]+) % a5;\s*v12 = \(unsigned __int8\)a3\[(\d+)\] ([+-]) (0x[0-9A-Fa-f]+|\d+);",
                body,
            )
            assert m, body
            const1 = int(m.group(1), 16)
            kidx = int(m.group(2))
            opc = m.group(3)
            c2 = int(m.group(4), 0)
            cases[op] = ("swap", const1, kidx, opc, c2)
        elif "LABEL_261" in body:
            body2 = body.replace("(*a3", "(a3[0]")
            m = re.search(
                r"v9 = (0x[0-9A-Fa-f]+) % a5;\s*v10 = __ROR1__\(\*\(_BYTE \*\)\(v9 \+ a4\), \(?a3\[(\d+)\](?: ([+-]) (\d+))?\)? & 7\);\s*(?:goto )?LABEL_261[:;]",
                body2,
            )
            if m:
                cases[op] = (
                    "ror",
                    int(m.group(1), 16),
                    int(m.group(2)),
                    m.group(3),
                    int(m.group(4)) if m.group(4) else 0,
                )
                continue
            m = re.search(
                r"v9 = (0x[0-9A-Fa-f]+) % a5;\s*v10 = \*\(_BYTE \*\)\(v9 \+ a4\) \^ a3\[(\d+)\] \^ (0x[0-9A-Fa-f]+|\d+);\s*(?:goto )?LABEL_261[:;]",
                body2,
            )
            assert m, body
            cases[op] = (
                "xor",
                int(m.group(1), 16),
                int(m.group(2)),
                int(m.group(3), 16),
            )
        else:
            # decmove: vA = ((u32)(u8)a3[i] +/- C) % a5; vB = *(BYTE*)(vA+a4)-1; *(BYTE*)(Y%a5+a4) -= vB; *(BYTE*)((u32)vA+a4) = vB;
            m2 = re.search(
                r"v\d+ = \(\(unsigned int\)\(unsigned __int8\)a3\[(\d+)\] ([+-]) (0x[0-9A-Fa-f]+|\d+)\) % a5;\s*v\d+ = \*\(_BYTE \*\)\(v\d+ \+ a4\) - 1;\s*\*\(_BYTE \*\)\((0x[0-9A-Fa-f]+) % a5 \+ a4\) -= v\d+;\s*\*\(_BYTE \*\)\(\(unsigned int\)v\d+ \+ a4\) = v\d+;",
                body,
            )
            if m2:
                cases[op] = (
                    "decmove",
                    int(m2.group(1)),
                    m2.group(2),
                    int(m2.group(3), 0),
                    int(m2.group(4), 16),
                )
                continue
            m = re.search(
                r"\*\(_BYTE \*\)\((0x[0-9A-Fa-f]+) % a5 \+ a4\) ([+-])= ([^;]+);", body
            )
            assert m, body
            p = int(m.group(1), 16)
            sign = m.group(2)
            rhs = m.group(3).strip()
            cases[op] = ("add", p, sign, rhs)
    return cases


def run_vm(prog, key, buf):
    cases = _load_cases()
    n = len(buf)
    for op in prog:
        kind = cases[op]
        if kind[0] == "xor":
            _, p, ki, c = kind
            buf[p % n] ^= key[ki] ^ c
        elif kind[0] == "ror":
            _, p, ki, s, c = kind
            k = key[ki] + c if s == "+" else key[ki] - c
            buf[p % n] = ror1(buf[p % n], k & 7)
        elif kind[0] == "add":
            _, p, sign, rhs = kind
            if "a3[" in rhs:
                m = re.match(r"(.+?)\s*-\s*a3\[(\d+)\]", rhs)
                if m:
                    v = int(m.group(1), 0) - key[int(m.group(2))]
                else:
                    m = re.match(r"a3\[(\d+)\]", rhs)
                    v = key[int(m.group(1))]
            else:
                v = int(rhs, 0)
            if sign == "-":
                v = -v
            buf[p % n] = (buf[p % n] + v) & 0xFF
        elif kind[0] == "swap":
            _, p, ki, s, c = kind
            x = p % n
            k = key[ki] + c if s == "+" else key[ki] - c
            y = (k & M32) % n
            buf[x], buf[y] = buf[y], buf[x]
        elif kind[0] == "decmove":
            _, ki, s, c, y = kind
            k = key[ki] + c if s == "+" else key[ki] - c
            x = (k & M32) % n
            v = (buf[x] - 1) & 0xFF
            sv = v if v < 128 else v - 256
            buf[y % n] = (buf[y % n] - sv) & 0xFF
            buf[x] = v
    return buf


def parse_container(path):
    d = open(path, "rb").read()
    assert d[:4] == b"CDPH", "not a CDPH container"
    key = d[16:272]
    off = 272
    sections = []
    for i in range(8):
        ln = struct.unpack("<I", d[off : off + 4])[0]
        sections.append(d[off + 4 : off + 4 + ln])
        off = (off + 4 + ln + 3) & ~3
    return d, key, sections, off


def decrypt_stream(d, key, prog, base, size, chunk=0x100):
    buf = bytearray(d[base : base + size])
    for i in range(0, len(buf), chunk):
        c = buf[i : i + chunk]
        run_vm(prog, key, c)
        buf[i : i + len(c)] = c
    return bytes(buf)


def decrypt_strings(path, out_path=None):
    d, key, sections, off = parse_container(path)
    # locate metadata root: config dword at 0x474 == a3 from sub_1804D73B0
    meta_root = struct.unpack("<I", d[off + 20 : off + 24])[0]
    # parse stream headers from BSJB root
    verlen = struct.unpack("<I", d[meta_root + 12 : meta_root + 16])[0]
    p = meta_root + 16 + verlen
    _flags, nstreams = struct.unpack("<HH", d[p : p + 4])
    p += 4
    streams = {}
    for _ in range(nstreams):
        so, ss = struct.unpack("<II", d[p : p + 8])
        p += 8
        ne = d.index(b"\0", p)
        name = d[p:ne].decode("latin1")
        p = (ne + 1 + 3) & ~3
        streams[name] = (meta_root + so, ss)
    base, size = streams["#Strings"]
    out = decrypt_stream(d, key, sections[1], base, size, 0x100)
    if out_path:
        open(out_path, "wb").write(out)
    strings = out.split(b"\0")
    return strings, streams


def decrypt_all_streams(path, out_prefix="/tmp/cdph_"):
    d, key, sections, off = parse_container(path)
    meta_root = struct.unpack("<I", d[off + 20 : off + 24])[0]
    verlen = struct.unpack("<I", d[meta_root + 12 : meta_root + 16])[0]
    p = meta_root + 16 + verlen
    _flags, nstreams = struct.unpack("<HH", d[p : p + 4])
    p += 4
    streams = {}
    for _ in range(nstreams):
        so, ss = struct.unpack("<II", d[p : p + 8])
        p += 8
        ne = d.index(b"\0", p)
        name = d[p:ne].decode("latin1")
        p = (ne + 1 + 3) & ~3
        streams[name] = (meta_root + so, ss)
    mapping = {"#Strings": 1, "#Blob": 2, "#US": 3, "#~": 5}
    result = {}
    for name, prog_idx in mapping.items():
        base, size = streams[name]
        result[name] = decrypt_stream(d, key, sections[prog_idx], base, size, 0x100)
        if out_prefix:
            fn = out_prefix + name.lstrip("#").replace("#", "_") + ".bin"
            open(fn, "wb").write(result[name])
    return result, streams


def parse_til_header(til):
    valid = struct.unpack("<Q", til[10:18])[0]
    bits = [i for i in range(64) if (valid >> i) & 1]
    p = 24
    counts = {}
    for b in bits:
        counts[b] = struct.unpack("<I", til[p : p + 4])[0]
        p += 4
    return bits, counts, p


def infer_rows(til, strings, bits, counts, row_off):
    def is_clean(v):
        if v == 0:
            return True
        if v >= len(strings):
            return False
        return strings[v - 1] == 0 and strings[v] != 0

    report = []
    pos = row_off
    for i, b in enumerate(bits):
        n = counts[b]
        report.append((b, n, pos))
        # try candidate row sizes 4..64 even, score clean u32 cells
        best = (0, None)
        for rsz in range(4, 66, 2):
            if pos + n * rsz > len(til):
                continue
            clean = 0
            for r in range(min(n, 40)):
                for c in range(0, rsz - 3, 4):
                    v = struct.unpack(
                        "<I", til[pos + r * rsz + c : pos + r * rsz + c + 4]
                    )[0]
                    if is_clean(v):
                        clean += 1
            if clean > best[0]:
                best = (clean, rsz)
        report[-1] = (b, n, pos, best)
        if best[1]:
            pos += n * best[1]
    return report


def parse_typeref_table(til, strings, base=0x8E, count=462):
    def sstr(v):
        if v >= len(strings):
            return ""
        e = strings.find(b"\0", v)
        return strings[v:e].decode("utf-8", "replace") if e >= 0 else ""

    TAG = {0: "Module", 1: "ModuleRef", 2: "AssemblyRef", 3: "TypeRef"}
    rows = []
    for r in range(count):
        p = base + r * 10
        name, ns = struct.unpack("<II", til[p : p + 8])
        scope = struct.unpack("<H", til[p + 8 : p + 10])[0]
        rows.append(
            {
                "name": sstr(name),
                "namespace": sstr(ns),
                "scope_row": scope >> 2,
                "scope_tag": TAG.get(scope & 3, "?"),
            }
        )
    return rows


# 1cab (P08.FlipCardGame) 26 张表（标准 .NET 表 ID，valid 掩码 0x1e092bb69f57）
TABLE_ROW_SIZES = {
    0: 12,
    1: 10,
    2: 18,
    4: 10,
    6: 18,
    8: 8,
    9: 4,
    10: 12,
    11: 8,
    12: 12,
    15: 8,
    17: 4,
    18: 4,
    20: 10,
    21: 4,
    23: 10,
    24: 6,
    25: 6,
    27: 4,
    29: 6,
    32: 22,
    35: 28,
    41: 4,
    42: 10,
    43: 6,
    44: 4,
}
TABLE_BITS = [
    0,
    1,
    2,
    4,
    6,
    8,
    9,
    10,
    11,
    12,
    15,
    17,
    18,
    20,
    21,
    23,
    24,
    25,
    27,
    29,
    32,
    35,
    41,
    42,
    43,
    44,
]
TABLE_COUNTS = [
    1,
    462,
    1612,
    11482,
    10641,
    8462,
    557,
    4305,
    1857,
    3653,
    9,
    1984,
    3,
    3,
    306,
    965,
    1193,
    656,
    889,
    13,
    1,
    32,
    585,
    49,
    625,
    22,
]


def walk_tables(til):
    """Walk the #~ table rows using TABLE_ROW_SIZES; returns (bit, count, size, start, end).

    Header: reserved(4) major(1) minor(1) heapSizes(1) reserved(1) valid(8) sorted(8),
    counts(26 x u32) @0x18, row data @0x80.
    """
    pos = 0x80
    out = []
    for b, n in zip(TABLE_BITS, TABLE_COUNTS):
        rsz = TABLE_ROW_SIZES.get(b)
        end = pos + n * rsz if rsz else None
        out.append((b, n, rsz, pos, end))
        if rsz:
            pos = end
    return out


if __name__ == "__main__":
    cases = _load_cases()
    missing = [i for i in range(256) if i not in CASES]
    print("cases parsed:", len(CASES), "missing:", [hex(x) for x in missing])
    import struct

    d = open("TextAsset/2265e62a9bb2c85c4ed693cadf8f2c0e.bytes", "rb").read()
    key = d[16:272]
    prog = bytes((~i) & 0xFF for i in range(256))
    buf = bytearray(d[0x460:0x470])
    run_vm(prog, key, buf)
    print("check result:", bytes(buf))
