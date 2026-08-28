"""AMF3 解码器"""
from datetime import datetime
from io import BytesIO
import struct


class AMF3Decoder:
    """
    AMF3 格式解码器

    AMF3 数据类型标记：
    0x00 - Undefined
    0x01 - Null
    0x02 - False
    0x03 - True
    0x04 - Integer
    0x05 - Double
    0x06 - String
    0x07 - XML Document
    0x08 - Date
    0x09 - Array
    0x0A - Object
    0x0B - XML
    0x0C - ByteArray
    """

    UNDEFINED_TYPE = 0x00
    NULL_TYPE = 0x01
    FALSE_TYPE = 0x02
    TRUE_TYPE = 0x03
    INTEGER_TYPE = 0x04
    DOUBLE_TYPE = 0x05
    STRING_TYPE = 0x06
    XML_DOC_TYPE = 0x07
    DATE_TYPE = 0x08
    ARRAY_TYPE = 0x09
    OBJECT_TYPE = 0x0A
    XML_TYPE = 0x0B
    BYTEARRAY_TYPE = 0x0C
    VECTOR_INT_TYPE = 0x0D
    VECTOR_UINT_TYPE = 0x0E
    VECTOR_DOUBLE_TYPE = 0x0F
    VECTOR_OBJECT_TYPE = 0x10
    DICTIONARY_TYPE = 0x11

    def __init__(self, data):
        if isinstance(data, bytes):
            self.stream = BytesIO(data)
        else:
            self.stream = data

        self.string_table = []
        self.object_table = []
        self.trait_table = []

    def read_byte(self):
        b = self.stream.read(1)
        if len(b) == 0:
            raise EOFError("读取到文件末尾")
        return b[0]

    def read_bytes(self, n):
        data = self.stream.read(n)
        if len(data) < n:
            raise EOFError(f"期望读取 {n} 字节，实际只有 {len(data)} 字节")
        return data

    def read_double(self):
        return struct.unpack(">d", self.read_bytes(8))[0]

    def read_u29(self):
        result = 0
        for i in range(4):
            byte = self.read_byte()
            if i < 3:
                result = (result << 7) | (byte & 0x7F)
                if (byte & 0x80) == 0:
                    return result
            else:
                result = (result << 8) | byte
        return result

    def read_element(self):
        type_marker = self.read_byte()

        if type_marker == self.UNDEFINED_TYPE:
            return None
        elif type_marker == self.NULL_TYPE:
            return None
        elif type_marker == self.FALSE_TYPE:
            return False
        elif type_marker == self.TRUE_TYPE:
            return True
        elif type_marker == self.INTEGER_TYPE:
            return self.read_integer()
        elif type_marker == self.DOUBLE_TYPE:
            return self.read_double()
        elif type_marker == self.STRING_TYPE:
            return self.read_string()
        elif type_marker == self.XML_DOC_TYPE:
            return self.read_xml_doc()
        elif type_marker == self.DATE_TYPE:
            return self.read_date()
        elif type_marker == self.ARRAY_TYPE:
            return self.read_array()
        elif type_marker == self.OBJECT_TYPE:
            return self.read_object()
        elif type_marker == self.XML_TYPE:
            return self.read_xml()
        elif type_marker == self.BYTEARRAY_TYPE:
            return self.read_bytearray()
        elif type_marker == self.VECTOR_INT_TYPE:
            return self.read_vector_int(signed=True)
        elif type_marker == self.VECTOR_UINT_TYPE:
            return self.read_vector_int(signed=False)
        elif type_marker == self.VECTOR_DOUBLE_TYPE:
            return self.read_vector_double()
        elif type_marker == self.VECTOR_OBJECT_TYPE:
            return self.read_vector_object()
        elif type_marker == self.DICTIONARY_TYPE:
            return self.read_dictionary()
        else:
            raise ValueError(f"未知的AMF3类型标记: 0x{type_marker:02X}")

    def read_integer(self):
        value = self.read_u29()
        if value & 0x10000000:
            value -= 0x20000000
        return value

    def read_string(self):
        u29 = self.read_u29()

        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.string_table):
                raise ValueError(f"字符串引用越界: {ref}")
            return self.string_table[ref]

        length = u29 >> 1
        if length == 0:
            return ""

        string = self.read_bytes(length).decode("utf-8", errors="replace")
        if string:
            self.string_table.append(string)
        return string

    def read_date(self):
        u29 = self.read_u29()

        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return self.object_table[ref]

        timestamp = self.read_double()
        date_obj = datetime.fromtimestamp(timestamp / 1000.0)
        self.object_table.append(date_obj)
        return date_obj

    def read_array(self):
        u29 = self.read_u29()

        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return self.object_table[ref]

        size = u29 >> 1

        arr = []
        self.object_table.append(arr)

        assoc = {}
        while True:
            key = self.read_string()
            if key == "":
                break
            value = self.read_element()
            assoc[key] = value

        if len(assoc) > 0:
            arr_dict = assoc
            for i in range(size):
                arr_dict[str(i)] = self.read_element()
            self.object_table[-1] = arr_dict
            return arr_dict
        else:
            for i in range(size):
                arr.append(self.read_element())
            return arr

    def read_object(self):
        u29 = self.read_u29()

        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return self.object_table[ref]

        if (u29 & 2) == 0:
            trait_ref = u29 >> 2
            if trait_ref >= len(self.trait_table):
                raise ValueError(f"trait引用越界: {trait_ref}")
            trait = self.trait_table[trait_ref]
        else:
            trait = self._read_trait(u29)
            self.trait_table.append(trait)

        obj = {}
        self.object_table.append(obj)

        if trait["class_name"]:
            obj["__class__"] = trait["class_name"]

        if trait["externalizable"]:
            obj["__data__"] = self.read_element()
            return obj

        for prop_name in trait["properties"]:
            obj[prop_name] = self.read_element()

        if trait["dynamic"]:
            while True:
                key = self.read_string()
                if key == "":
                    break
                value = self.read_element()
                obj[key] = value

        return obj

    def _read_trait(self, u29):
        trait = {}
        trait["externalizable"] = (u29 & 4) != 0
        trait["dynamic"] = (u29 & 8) != 0

        prop_count = u29 >> 4
        trait["class_name"] = self.read_string()
        trait["properties"] = []

        for i in range(prop_count):
            prop_name = self.read_string()
            trait["properties"].append(prop_name)

        return trait

    def read_xml(self):
        u29 = self.read_u29()

        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return self.object_table[ref]

        length = u29 >> 1
        xml_str = self.read_bytes(length).decode("utf-8", errors="replace")
        self.object_table.append(xml_str)
        return xml_str

    def read_xml_doc(self):
        return self.read_xml()

    def read_bytearray(self):
        u29 = self.read_u29()

        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return self.object_table[ref]

        length = u29 >> 1
        byte_array = self.read_bytes(length)
        self.object_table.append(byte_array)
        return byte_array

    def _read_vector_header(self):
        u29 = self.read_u29()
        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return None, self.object_table[ref]
        length = u29 >> 1
        fixed = self.read_byte() != 0
        return (length, fixed), None

    def read_vector_int(self, signed=True):
        header, ref = self._read_vector_header()
        if ref is not None:
            return ref
        length, _fixed = header
        items = []
        self.object_table.append(items)
        fmt = ">i" if signed else ">I"
        for _ in range(length):
            items.append(struct.unpack(fmt, self.read_bytes(4))[0])
        return items

    def read_vector_double(self):
        header, ref = self._read_vector_header()
        if ref is not None:
            return ref
        length, _fixed = header
        items = []
        self.object_table.append(items)
        for _ in range(length):
            items.append(self.read_double())
        return items

    def read_vector_object(self):
        header, ref = self._read_vector_header()
        if ref is not None:
            return ref
        length, _fixed = header
        type_name = self.read_string()
        items = []
        self.object_table.append(items)
        for _ in range(length):
            items.append(self.read_element())
        if type_name:
            return {"__vector__": type_name, "items": items}
        return items

    def read_dictionary(self):
        u29 = self.read_u29()
        if (u29 & 1) == 0:
            ref = u29 >> 1
            if ref >= len(self.object_table):
                raise ValueError(f"对象引用越界: {ref}")
            return self.object_table[ref]
        length = u29 >> 1
        _weak = self.read_byte()
        result = {}
        self.object_table.append(result)
        for _ in range(length):
            key = self.read_element()
            value = self.read_element()
            result[str(key)] = value
        return result


def decode_amf3(data: bytes):
    """解码一份 AMF3 数据。"""
    decoder = AMF3Decoder(data)
    return decoder.read_element()


_AMF3_ROOT_MARKERS = frozenset(
    {
        AMF3Decoder.ARRAY_TYPE,
        AMF3Decoder.OBJECT_TYPE,
        AMF3Decoder.VECTOR_INT_TYPE,
        AMF3Decoder.VECTOR_UINT_TYPE,
        AMF3Decoder.VECTOR_DOUBLE_TYPE,
        AMF3Decoder.VECTOR_OBJECT_TYPE,
        AMF3Decoder.DICTIONARY_TYPE,
    }
)


def try_decode_amf3(data: bytes, *, consume_all: bool = True, max_remain: int = 8):
    """尝试把整段数据当成一份 AMF3 根对象。失败或明显没收完文件时返回 None。"""
    if not data or data[0] not in _AMF3_ROOT_MARKERS:
        return None
    try:
        decoder = AMF3Decoder(data)
        obj = decoder.read_element()
    except Exception:
        return None
    remain = len(data) - decoder.stream.tell()
    if consume_all and remain > max_remain:
        return None
    if obj is None:
        return None
    return obj


def amf3_to_jsonable(obj):
    """把 AMF3 对象转成可 JSON 序列化的结构。"""
    import base64

    if obj is None or isinstance(obj, (bool, int, float, str)):
        return obj
    if isinstance(obj, bytes):
        return {"__bytes_b64__": base64.b64encode(obj).decode("ascii")}
    if isinstance(obj, datetime):
        return obj.isoformat()
    if isinstance(obj, dict):
        return {str(k): amf3_to_jsonable(v) for k, v in obj.items()}
    if isinstance(obj, (list, tuple)):
        return [amf3_to_jsonable(v) for v in obj]
    return str(obj)
