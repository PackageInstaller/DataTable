"""从 CDPH 容器重建可加载的 .NET DLL（P08.FlipCardGame.dll）——v3 布局

布局（让 CLI 头落在节内，ilspycmd/System.Reflection.Metadata 才能解析）:
  [0x0000..0x0FFF] PE 头 + CLI 头（节 RVA 0 起，覆盖整个文件）
  [0x1000..]      容器正文（解密后），MethodDef.Rva += 0x1000 指向 IL

解密管线:
  1. IL 代码区 0x14f48..0x10dc14：逐方法体 section7/chunk0x10 解密
  2. 四流整段解密（#Strings/#Blob/#US/#~ = section1/2/3/5, chunk0x100）
  3. TypeDef 表行：section6 逐行解密（chunk=18）
  4. MethodDef.Rva += 0x1000
"""
import os
import struct
import sys

sys.path.insert(0, '/home/rikka/Games/深空之眼')
from cdph_vm import parse_container, run_vm

ASSET = 'TextAsset/1cabbf636215d06aa12521cda5daedfb.bytes'
OUT = 'P08.FlipCardGame.rebuilt.dll'

ROOT = 0x10dc14
CODE_START = 0x14f48
CODE_END = ROOT

STREAMS = {
    '#~':       (0x10dc80, 0x891f0, 'cdph_decrypted_TIL.bin'),
    '#Strings': (0x196e70, 0x42778, 'cdph_decrypted_Strings.bin'),
    '#US':      (0x1d95e8, 0x48008, 'cdph_decrypted_US.bin'),
    '#GUID':    (0x2215f0, 0x10,    None),
    '#Blob':    (0x221600, os.path.getsize('cdph_decrypted_Blob.bin'), 'cdph_decrypted_Blob.bin'),
}


def decrypt_chunked(data, prog, key, chunk=0x10):
    buf = bytearray(data)
    for i in range(0, len(buf), chunk):
        c = buf[i:i + chunk]
        run_vm(prog, key, c)
        buf[i:i + len(c)] = c
    return bytes(buf)


def build_image():
    d, key, sections, off = parse_container(ASSET)
    img = bytearray(d)
    til = open('cdph_decrypted_TIL.bin', 'rb').read()

    # 1) IL 代码区：逐方法体解密（section7, chunk0x10，仅 IL 码，头部明文）
    methods = sorted({struct.unpack_from('<I', til, 0x24474 + i*18)[0] for i in range(10641)})
    methods = [r for r in methods if r]
    for idx, rva in enumerate(methods):
        nxt = methods[idx+1] if idx+1 < len(methods) else CODE_END
        raw = d[rva:nxt]
        if not raw:
            continue
        h = raw[0]
        if (h & 3) == 2:
            cs = h >> 2
            code = bytearray(raw[1:1+cs])
            for i in range(0, len(code), 0x10):
                c = code[i:i+0x10]
                run_vm(sections[7], key, c)
                code[i:i+len(c)] = c
            img[rva+1:rva+1+cs] = code
        elif (h & 3) == 3:
            cs = struct.unpack('<I', raw[4:8])[0]
            code = bytearray(raw[12:12+cs])
            for i in range(0, len(code), 0x10):
                c = code[i:i+0x10]
                run_vm(sections[7], key, c)
                code[i:i+len(c)] = c
            img[rva+12:rva+12+cs] = code

    # 2) 覆盖解密流（#GUID 明文置零；#US 跳过，在 2a 中从原始 img 逐条解密）
    for name, (base, size, src) in STREAMS.items():
        if src:
            data = open(src, 'rb').read()
            img[base:base + size] = data[:size]
        else:
            img[base:base + size] = b'\x00' * size

    # 2b) 更新 metadata root 流头中 #Blob 的 size（blob 修复后变大）
    root = ROOT
    verlen = struct.unpack_from('<I', img, root+12)[0]
    pp = root + 16 + verlen
    flags, nstreams = struct.unpack_from('<HH', img, pp)
    pp += 4
    blob_size = os.path.getsize('cdph_decrypted_Blob.bin')
    for i in range(nstreams):
        off = struct.unpack_from('<I', img, pp)[0]
        # size 字段位于 pp+4
        ne = img.index(b'\0', pp + 8)
        name = img[pp+8:ne].decode('latin1')
        if name == '#Blob':
            struct.pack_into('<I', img, pp + 4, blob_size)
            break
        pp = (ne + 1 + 3) & ~3

    # 3) TypeDef 表行（#~ 内偏移 0x1298，1612 行 x18B）section6 逐行解密
    TD_OFF = 0x10dc80 + 0x1298
    for i in range(1612):
        buf = bytearray(img[TD_OFF + i*18: TD_OFF + (i+1)*18])
        run_vm(sections[6], key, buf)
        img[TD_OFF + i*18: TD_OFF + (i+1)*18] = buf

    # 4) MethodDef.Rva += 0x1000（容器偏移 -> 重建文件偏移）
    for i in range(10641):
        off = 0x10dc80 + 0x24474 + i*18
        rva = struct.unpack_from('<I', img, off)[0]
        if rva:
            struct.pack_into('<I', img, off, rva + 0x1000)
    return bytes(img)


def build_headers(total_len):
    """两节布局：
      .clihdr: RVA 0x200, raw 0x200 —— CLI 头（节内，满足 ilspycmd）
      .text:   RVA 0x1000, raw 0x1000 —— 容器正文（MethodDef.Rva+0x1000 指向 IL）
    """
    hdr = bytearray(0x1000)

    def w16(o, v): struct.pack_into('<H', hdr, o, v)
    def w32(o, v): struct.pack_into('<I', hdr, o, v)

    hdr[0:2] = b'MZ'
    w32(0x3C, 0x80)
    pe = 0x80
    hdr[pe:pe+4] = b'PE\0\0'
    coff = pe + 4
    w16(coff + 0, 0x8664)
    w16(coff + 2, 2)                # 2 个节
    w16(coff + 16, 0xE0)
    w16(coff + 18, 0x0022)
    o = pe + 4 + 20
    w16(o + 0, 0x10B)
    hdr[o + 2] = 9
    w32(o + 4, 0x200000)
    w32(o + 16, 0x1000)
    w32(o + 20, 0x1000)
    w32(o + 28, 0x18000000)
    w32(o + 32, 0x1000)
    w32(o + 36, 0x200)
    w16(o + 40, 6)
    w16(o + 48, 6)
    w32(o + 56, total_len)
    w32(o + 60, 0x200)
    w16(o + 68, 3)
    w16(o + 70, 0x8160)
    w32(o + 72, 0x100000)
    w32(o + 76, 0x1000)
    w32(o + 80, 0x100000)
    w32(o + 84, 0x1000)
    w32(o + 92, 16)
    dd = o + 96
    w32(dd + 14*8 + 0, 0x200)      # COM descriptor -> CLI header RVA
    w32(dd + 14*8 + 4, 0x48)

    # 节表（2 个）
    sh = o + 0xE0
    # .clihdr: RVA 0x200, raw 0x200
    hdr[sh:sh+8] = b'.clihdr\0'
    w32(sh + 8, 0x100)              # VirtualSize
    w32(sh + 12, 0x200)             # VirtualAddress
    w32(sh + 16, 0x100)             # SizeOfRawData
    w32(sh + 20, 0x200)             # PointerToRawData
    w32(sh + 36, 0x40000040)        # READ|INITIALIZED_DATA
    sh += 40
    # .text: RVA 0x1000, raw 0x1000
    hdr[sh:sh+8] = b'.text\0\0\0'
    w32(sh + 8, total_len - 0x1000) # VirtualSize（容器正文）
    w32(sh + 12, 0x1000)            # VirtualAddress
    w32(sh + 16, total_len - 0x1000)# SizeOfRawData
    w32(sh + 20, 0x1000)            # PointerToRawData
    w32(sh + 36, 0x60000020)        # CODE|EXECUTE|READ|WRITE

    # CLI header @文件 0x200（RVA 0x200，在 .clihdr 节内）
    cli = 0x200
    w32(cli + 0, 0x48)
    w16(cli + 4, 2)
    w16(cli + 6, 5)
    w32(cli + 8, ROOT + 0x1000)     # Metadata RVA（容器正文 0x1000 起）
    # metadata 大小 = root 到 #Blob 末尾（blob 修复后变长，动态计算）
    meta_size = (0x221600 + os.path.getsize('cdph_decrypted_Blob.bin') + 3 & ~3) - ROOT
    w32(cli + 12, meta_size)
    w32(cli + 16, 0)
    w32(cli + 20, 0)
    return bytes(hdr)


def main():
    img = build_image()
    total = 0x1000 + len(img)
    hdr = build_headers(total)
    out = bytearray(hdr)
    out += img
    with open(OUT, 'wb') as f:
        f.write(out)
    print('写出', OUT, len(out), 'bytes (body', hex(len(img)), ')')
    return OUT


if __name__ == '__main__':
    main()
