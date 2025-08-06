import struct
import json
import sys
import os
import MasterMap


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

    def read_list_list_float(self) -> list[list[float]]:
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

    def read_list_list_string(self) -> list[list[str]]:
        content = self.read_string()
        if not content: return []
        outer_list = []
        for part in content.split(';'):
            if not part: continue
            outer_list.append([x for x in part.split(',') if x])
        return outer_list

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
        'List<bool>': 'read_list_boolean',
        'List<int>': 'read_list_int',
        'List<string>': 'read_list_string',
        'List<float>': 'read_list_float',
        'List<List<int>>': 'read_list_list_int',
        'List<List<float>>': 'read_list_list_float',
        'List<List<string>>': 'read_list_list_string'
    }
    
    while main_reader.has_more_data():
        try:
            if main_reader.get_position() + 1 > main_reader.get_length(): break
            row_length = main_reader.read_7bit_encoded_int()
            row_data_start = main_reader.get_position()
            if row_length <= 0 or row_data_start + row_length > main_reader.get_length(): break
            row_data = file_data[row_data_start : row_data_start + row_length]
            row_reader = BinaryReader(row_data)
            record = {}
            for field in schema:
                method_name = type_to_method.get(field['type'])
                if not method_name: raise TypeError(f"未知的字段类型: {field['type']}")
                if not row_reader.has_more_data(): break
                record[field['name']] = getattr(row_reader, method_name)()
            if record: records.append(record)
            main_reader.offset = row_data_start + row_length
        except (IndexError, struct.error, ValueError, UnicodeDecodeError) as e:
            print(f"警告: 文件 {schema} 解析时发生错误: {e}")
            break
    return records

def main():
    output_dir = "MasterData"
    os.makedirs(output_dir, exist_ok=True)
    
    all = set()
    success = set()

    for root, _, files in os.walk(sys.argv[1]):
        for filename in files:
            if filename.endswith(".bytes"):
                table_name = os.path.splitext(filename)[0]
                all.add(table_name)
                
                input_path = os.path.join(root, filename)

                if os.path.getsize(input_path) == 0:
                    continue

                schema = MasterMap.MASTER_MAP.get(table_name)
                
                if not schema:
                    continue 
                try:
                    with open(input_path, 'rb') as f:
                        binary_data = f.read()
                    parsed_data = parse(binary_data, schema)
                    if parsed_data and any(parsed_data):
                        output_path = os.path.join(output_dir, f"{table_name}.json")
                        with open(output_path, 'w', encoding='utf-8') as f:
                            json.dump(parsed_data, f, indent=4, ensure_ascii=False)
                        success.add(table_name)
                except Exception as e:
                    print(f"处理文件 '{input_path}' 时发生错误: {e}")
    unprocess = all - success

    if unprocess:
        for table_name in sorted(list(unprocess)):
            if table_name not in MasterMap.MASTER_MAP:
                print(f"{table_name}.bytes 在 MasterMap.py 中无对应 schema")

if __name__ == "__main__":
    main()