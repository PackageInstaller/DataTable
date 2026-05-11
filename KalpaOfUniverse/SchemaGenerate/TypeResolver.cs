using dnlib.DotNet;

namespace DNFBDmp {
	// This class is just a manual resolver by iterating through the modules
	// and finding the right definition.
	// Maybe there was a way to do it with the module context in dnlib
	// but i couldn't get it to work, i might be dumb.
	public class TypeResolver {
		private List<ModuleDef> modules;

		public TypeResolver() {
			this.modules = [];
		}

		public void add(ModuleDef module) {
			this.modules.Add(module);
		}

		public IReadOnlyList<ModuleDef> GetModules() => this.modules;

		public TypeDef? Find(string fullName, bool isReflectionName) {
			foreach (ModuleDef mod in this.modules) {
				TypeDef td = mod.Find(fullName, isReflectionName);
				if (td != null)
					return td;
			}
			return null;
		}

		public TypeDef? Find(TypeRef typeRef) {
			foreach (ModuleDef mod in this.modules) {
				TypeDef td = mod.Find(typeRef);
				if (td != null)
					return td;
			}
			return null;
		}

		public TypeDef? Find(ITypeDefOrRef typeRef) {
			foreach (ModuleDef mod in this.modules) {
				TypeDef td = mod.Find(typeRef);
				if (td != null)
					return td;
			}
			return null;
		}

		/// <summary>
		/// Google.Protobuf 生成的 <c>*Reflection</c> 静态类（内含 <c>FileDescriptor</c> 的嵌入字节，经 Base64 嵌入）。
		/// </summary>
		public List<TypeDef> FindProtobufReflectionTypes() {
			List<TypeDef> reflectionTypes = [];
			foreach (ModuleDef mod in this.modules) {
				foreach (TypeDef type in EnumerateTypesDepthFirst(mod)) {
					if (type.Namespace != "BlackJack.ConfigData")
						continue;
					if (!type.Name.EndsWith("Reflection", StringComparison.Ordinal))
						continue;
					if (!IsCSharpStaticClass(type))
						continue;
					Console.WriteLine($"找到 Protobuf Reflection 类型: {type.FullName}");
					reflectionTypes.Add(type);
				}
			}
			return reflectionTypes;
		}

		/// <summary>
		/// 带 <c>*FieldNumber</c> 常量的 protoc 风格消息类（用于 IL 无嵌入描述符时从字段推断 .proto）。
		/// </summary>
		public List<TypeDef> FindProtobufMessageTypes() {
			List<TypeDef> list = [];
			foreach (ModuleDef mod in this.modules) {
				foreach (TypeDef type in EnumerateTypesDepthFirst(mod)) {
					if (MessageTypeProtoGenerator.LooksLikeProtobufMessageType(type))
						list.Add(type);
				}
			}
			return list;
		}

		static bool IsCSharpStaticClass(TypeDef type) {
			return type.IsClass && type.IsAbstract && type.IsSealed && !type.IsInterface;
		}

		static IEnumerable<TypeDef> EnumerateTypesDepthFirst(ModuleDef mod) {
			foreach (TypeDef t in mod.Types) {
				foreach (TypeDef x in EnumerateNested(t))
					yield return x;
			}
		}

		static IEnumerable<TypeDef> EnumerateNested(TypeDef type) {
			yield return type;
			foreach (TypeDef nested in type.NestedTypes) {
				foreach (TypeDef x in EnumerateNested(nested))
					yield return x;
			}
		}

		// IFlatbufferObject接口（旧版 FlatBuffer 管线保留，当前入口未使用）
		public List<TypeDef> FindFlatbufferStructs() {
			List<TypeDef> flatbufferStructs = [];
			foreach (ModuleDef mod in this.modules) {
				foreach (TypeDef type in mod.Types) {
					if (type.Namespace != "TBL")
						continue;
					if (!type.IsValueType || type.IsEnum)
						continue;
					bool implementsIFlatbufferObject = false;
					foreach (InterfaceImpl iface in type.Interfaces) {
						if (iface.Interface.Name == "IFlatbufferObject") {
							implementsIFlatbufferObject = true;
							break;
						}
					}
					if (implementsIFlatbufferObject) {
						Console.WriteLine($"找到FlatBuffer结构: {type.FullName}");
						flatbufferStructs.Add(type);
					}
				}
			}
			return flatbufferStructs;
		}

		public MethodDef? FindCreateMethod(TypeDef structType) {
			string createMethodName = $"Create{structType.Name}";
			
			foreach (MethodDef method in structType.Methods) {
				if (method.Name == createMethodName && method.IsStatic && method.IsPublic) {
					return method;
				}
			}
			
			return null;
		}
	}
}