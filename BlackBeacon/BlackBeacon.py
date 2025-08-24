import lzma
import sys
import os
import io

KEY = (
        "8974EA6638CFDBE0F3ED0B283621D6BC31296082D9CCF432B107A03450171E7A"
        "0338C54D7354A3ABBA68632FC9F2290A89241C2AA427A7F65F4739C65C309285"
        "C11E5B9DA9411DA6321750DD2A0D9FFEBB240C6DF4EF1D55A3AAB9A85EB1E4A4"
        "3324EFC4D0F95DCBA5520BCECC4CE1DE371B9A4E02BBCF1B4DFDFD87912FA37"
        "1C732145A644943BF6D5A12C0B0F4619974E179F78D8B02BF38F32A38B69E22"
        "2EFC149B1C696275CDE3562E9D5BB456C2F23DA1BBDDC5C063442AA9B51A637"
        "DC35581A5F06AE064E870576E75DB9FC19938D35515C539DCCD5C2431268D45"
        "9AC45C1796E67DC745AE7E552B81C7346C02D53A1FA69B1DF16E6F4EBBD46A752769"
    )

def rc4(key: bytes, data: bytes) -> bytes:
    b = list(range(256))
    j = 0
    for i in range(256):
        j = (j + b[i] + key[i % len(key)]) % 256
        b[i], b[j] = b[j], b[i]
    i = j = 0
    r = bytearray()
    for c in data:
        i = (i + 1) % 256
        j = (j + b[i]) % 256
        b[i], b[j] = b[j], b[i]
        r.append(c ^ (b[(b[i] + b[j]) % 256]))
    return bytes(r)

def unpack(data: bytes, od: str):
    s = io.BytesIO(data)
    cnt = 0
    
    while s.tell() < len(data):
        eb = s.read(4)
        if len(eb) < 4:
            break
        es = int.from_bytes(eb, 'big')
        fb = bytearray()
        while (c := s.read(1)) != b'\x00':
            if not c: break
            fb.extend(c)
        if not fb: 
            continue
        op = os.path.join(od, fb.decode('utf-8'))
        os.makedirs(os.path.dirname(op), exist_ok=True)
        with open(op, 'wb') as f:
            f.write(s.read(es - (len(fb) + 1)))
        cnt += 1
    print(f"{cnt}")

if __name__ == "__main__":
    od = os.path.join("MasterData", os.path.splitext(os.path.basename(sys.argv[1]))[0])
    with open(sys.argv[1], 'rb') as f:
        enc = f.read()
    com = rc4(bytes.fromhex(KEY), enc)
    s = com[0:4]
    print(f"{(s[0] << 24) | (s[2] << 16) | (s[1] << 8) | s[3]}")
    props = com[4:9]
    # SetDecoderProperties
    filters = [{'id': lzma.FILTER_LZMA1, 'lc': props[0] % 9, 'lp': (props[0] // 9) % 5, 'pb': props[0] // 45, 'dict_size': int.from_bytes(props[1:5], 'little')}]
    if not os.path.exists(od):
        os.makedirs(od)
    # 头部总共9个字节，之后就是纯LZMA压缩数据
    unpack((lzma.LZMADecompressor(format=lzma.FORMAT_RAW, filters=filters)).decompress(com[9:]), od)