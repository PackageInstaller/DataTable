import re

def generate_map(cs_file_path: str, output_py_path: str):

    with open(cs_file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    found_enums = set()
    enum_pattern = re.compile(r"public enum (\w+)")
    for enum_match in enum_pattern.finditer(content):
        found_enums.add(enum_match.group(1))

    schema_definitions = {}

    type_mapping = {
        "int": "int", "Int32": "int", "long": "long", "Int64": "long",
        "string": "string", "String": "string", "float": "float", "Single": "float",
        "bool": "bool", "Boolean": "bool", "List<bool>": "List<bool>",
        "List<int>": "List<int>", "List<string>": "List<string>", "List<float>": "List<float>",
        "List<List<int>>": "List<List<int>>", "List<List<float>>": "List<List<float>>",
        "List<List<string>>": "List<List<string>>",
        "ConditionList<List<string>>": "List<List<string>>",
    }
    
    class_pattern = re.compile(
        r"public class (DR\w+)\s*:\s*DataRowBase.*?"
        r"\s*// Properties\s*(.*?)\s*// (?:Constructors|Methods)",
        re.DOTALL | re.IGNORECASE
    )
    prop_pattern = re.compile(r"public\s+(?:override\s+)?([\w<>\[\],. ]+?)\s+([\w\d_]+)\s*{")

    for class_match in class_pattern.finditer(content):
        class_name_dr, properties_block = class_match.groups()
        table_name = class_name_dr[2:] if class_name_dr.startswith("DR") else class_name_dr
        fields = []
        for prop_match in prop_pattern.finditer(properties_block):
            raw_field_type, field_name = prop_match.groups()
            raw_field_type = raw_field_type.strip()
            field_type = None
            
            if raw_field_type in type_mapping:
                field_type = type_mapping[raw_field_type]
            elif raw_field_type in found_enums:
                field_type = "string"
            else:
                list_match = re.match(r"List<(\w+)>", raw_field_type)
                if list_match and list_match.group(1) in found_enums:
                    field_type = "List<int>"
            
            if field_type:
                if not any(f['name'] == field_name for f in fields):
                    fields.append({'name': field_name, 'type': field_type})
            else:
                print(f"警告: 在类 '{class_name_dr}' 中发现未知类型 '{raw_field_type}' (字段: {field_name})。已跳过。")

        if fields:
            schema_definitions[table_name] = fields
            # print(f"[+] 已解析 '{class_name_dr}' -> '{table_name}', 找到 {len(fields)} 个字段。")

    with open(output_py_path, 'w', encoding='utf-8') as f:
        f.write("# 此文件由脚本自动生成，请勿手动修改。\n\nMASTER_MAP = {\n")
        for table_name in sorted(schema_definitions.keys()):
            f.write(f"    '{table_name}': [\n")
            for field in schema_definitions[table_name]:
                f.write(f"        {{'name': '{field['name']}', 'type': '{field['type']}'}},\n")
            f.write("    ],\n")
        f.write("}\n")

if __name__ == "__main__":
    generate_map("types.cs", "MasterMap.py")