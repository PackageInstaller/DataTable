import re
import os
import sys

def pascal_to_snake(name: str) -> str:
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    name = re.sub('([a-z0-9])([A-Z])', r'\1_\2', name)
    return name.lower()

def map_csharp_type_to_fbs(csharp_type: str, struct_names: set) -> str:
    type_mapping = {
        'int': 'int', 'short': 'short', 'long': 'long',
        'uint': 'uint', 'ushort': 'ushort', 'ulong': 'ulong',
        'float': 'float', 'double': 'double', 'bool': 'bool',
        'byte': 'ubyte', 'sbyte': 'byte', 'string': 'string',
    }
    for k, v in list(type_mapping.items()):
        type_mapping[k.capitalize()] = v
    type_mapping['Single'] = 'float'
    
    if csharp_type in type_mapping: return type_mapping[csharp_type]
    if csharp_type in struct_names: return csharp_type
    array_match = re.match(r'(\w+)\[\]|List<(\w+)>', csharp_type)
    if array_match:
        element_type = array_match.group(1) or array_match.group(2)
        return f"[{map_csharp_type_to_fbs(element_type, struct_names)}]"
    return "string"

def extract_all_struct_definitions(content: str) -> dict:
    struct_definitions = {}
    namespace_pattern = re.compile(r'namespace\s+ProjectA\.Data\s*\{(.*?)\n\}', re.DOTALL)
    namespace_match = namespace_pattern.search(content)
    if not namespace_match: return {}
    
    namespace_content = namespace_match.group(1)
    
    struct_pattern = re.compile(r'public\s+struct\s+(\w+)\s*:\s*IFlatbufferObject(.*?)(?=public struct|\Z)', re.DOTALL)
    
    for struct_match in struct_pattern.finditer(namespace_content):
        struct_name = struct_match.group(1)
        struct_body = struct_match.group(2)
        
        properties = []
        datas_type = None

        prop_block_match = re.search(r'// Properties(.*?)(?:// Methods|\Z)', struct_body, re.DOTALL)
        if prop_block_match:
            prop_pattern = re.compile(r'public\s+([\w\<\>\?\[\]]+)\s+(\w+)\s*(?:\(\s*int\s+j\s*\);|\{)')
            for prop_match in prop_pattern.finditer(prop_block_match.group(1)):
                prop_type = prop_match.group(1).replace('?', '')
                prop_name = prop_match.group(2)
                if prop_name not in ('ByteBuffer', f'GetRootAs{struct_name}'):
                    properties.append((prop_type, prop_name))
        
        if struct_name.endswith("Table"):
            datas_method_match = re.search(r'public\s+([\w\?]+)\s+Datas\(int j\);', struct_body)
            if datas_method_match:
                datas_type = datas_method_match.group(1).replace('?', '')

        struct_definitions[struct_name] = {'properties': properties, 'datas_type': datas_type}
        
    return struct_definitions

def generate_fbs_schema(data_struct_name: str, data_struct_params: list, table_struct_name: str, all_struct_names: set) -> str:
    namespace = "ProjectA.Data"
    
    table_def = f"table {data_struct_name} {{\n"
    prop_names = {p[1] for p in data_struct_params}
    added_snake_names = set()

    for prop_type, prop_name in data_struct_params:
        if prop_name.endswith('Length') and prop_name[:-6] in prop_names:
            continue

        snake_name = pascal_to_snake(prop_name)
        if snake_name in added_snake_names: continue
        added_snake_names.add(snake_name)

        is_array = (prop_name + 'Length' in prop_names)
        fbs_type = f"[{map_csharp_type_to_fbs(prop_type, all_struct_names)}]" if is_array else map_csharp_type_to_fbs(prop_type, all_struct_names)
        table_def += f"  {snake_name}:{fbs_type};\n"
    table_def += "}\n\n"

    wrapper_table_def = f"table {table_struct_name} {{\n  datas:[{data_struct_name}];\n}}\n\n"

    root_type_def = f"root_type {table_struct_name};\n"
    
    return f"namespace {namespace};\n\n{table_def}{wrapper_table_def}{root_type_def}"

def main():
    output_dir = 'Schema'

    with open('types.cs', 'r', encoding='utf-8') as f:
        content = f.read()

    all_definitions = extract_all_struct_definitions(content)
    if not all_definitions:
        print("未能提取到任何 struct。")
        sys.exit(0)
    print(f"成功提取了 {len(all_definitions)} 个 struct 的定义。")

    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    all_struct_names = set(all_definitions.keys())
    
    generated_count = 0
    for struct_name, definition in all_definitions.items():
        if not struct_name.endswith("Table"):
            continue

        data_type_name = definition.get('datas_type')
        if not data_type_name:
            continue
            
        if data_type_name not in all_definitions:
            continue

        data_struct_params = all_definitions[data_type_name]['properties']
        if not data_struct_params:
            continue

        base_name = struct_name[:-5]
        schema_data_name = f"{base_name}Data"

        try:
            schema = generate_fbs_schema(schema_data_name, data_struct_params, struct_name, all_struct_names)
            output_path = os.path.join(output_dir, f"{schema_data_name}.fbs")
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(schema)
            print(f"生成: {output_path}")
            generated_count += 1
        except Exception as e:
            print(f"生成 '{schema_data_name}.fbs' 时出错: {e}")
    
    print(f"\n处理完成！共生成了 {generated_count} 个 schema")

if __name__ == "__main__":
    main()