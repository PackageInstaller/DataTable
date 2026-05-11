using System.Text;
using dnlib.DotNet;

namespace DNFBDmp {
	/// <summary>
	/// 当无法从嵌入 <c>FileDescriptorProto</c> 还原时，根据 Il2CppInspector / protoc 生成的 C# 消息类上的
	/// <c>public const int XxxFieldNumber = n</c> 与私有后备字段 <c>Xxx_</c> 推断 proto3 消息（字段名 = 常量名去掉 FieldNumber）。
	/// 枚举字段输出为枚举类型名；支持单类型单文件，或 <see cref="TryGenerateProtoMerged"/> 多 message 合并为一文件。
	/// </summary>
	public static class MessageTypeProtoGenerator {
		const string FieldNumberSuffix = "FieldNumber";

		public static bool LooksLikeProtobufMessageType(TypeDef type) {
			if (type.Namespace != "BlackJack.ConfigData")
				return false;
			if (!type.IsClass || type.IsInterface || type.IsEnum)
				return false;
			if (type.Name.EndsWith("Reflection", StringComparison.Ordinal))
				return false;
			if (type.Name.String.StartsWith("<"))
				return false;
			return HasAnyFieldNumberConstant(type);
		}

		static bool HasAnyFieldNumberConstant(TypeDef type) {
			foreach (FieldDef f in type.Fields) {
				if (!f.IsStatic || !f.HasConstant)
					continue;
				if (!f.Name.String.EndsWith(FieldNumberSuffix, StringComparison.Ordinal))
					continue;
				return true;
			}
			return false;
		}

		/// <summary>
		/// 嵌套消息类在 proto 中使用与枚举类似的扁平名，避免与外层同名冲突。
		/// </summary>
		public static string GetMessageProtoName(TypeDef messageType) {
			if (!messageType.IsNested)
				return messageType.Name.String;
			var parts = new List<string>();
			TypeDef? walk = messageType;
			while (walk != null) {
				parts.Add(walk.Name.String);
				walk = walk.DeclaringType;
			}
			parts.Reverse();
			return string.Join("_", parts);
		}

		/// <summary>
		/// 生成单文件单 message 的 proto3 文本；无法解析任何字段时返回 null。
		/// </summary>
		public static string? TryGenerateProto(TypeDef messageType, TypeResolver resolver) {
			var referencedEnums = new HashSet<TypeDef>(TypeEqualityComparer.Instance);
			List<(int number, string protoFieldName, string protoType)>? rows = TryBuildMessageRows(messageType, resolver, referencedEnums);
			if (rows == null || rows.Count == 0)
				return null;
			return ComposeProtoFile(messageType.Namespace ?? "", referencedEnums, new[] { (GetMessageProtoName(messageType), rows) });
		}

		/// <summary>
		/// 将多个消息类合并为同一个 .proto（共享 package，枚举去重，多个顶层 message）。
		/// </summary>
		public static string? TryGenerateProtoMerged(IReadOnlyList<TypeDef> messageTypes, TypeResolver resolver) {
			if (messageTypes.Count == 0)
				return null;
			string package = messageTypes[0].Namespace ?? "";
			var allEnums = new HashSet<TypeDef>(TypeEqualityComparer.Instance);
			var messages = new List<(string msgName, List<(int, string, string)> rows)>();
			foreach (TypeDef mt in messageTypes.OrderBy(t => GetMessageProtoName(t), StringComparer.Ordinal)) {
				List<(int, string, string)>? rows = TryBuildMessageRows(mt, resolver, allEnums);
				if (rows == null || rows.Count == 0)
					continue;
				messages.Add((GetMessageProtoName(mt), rows));
			}
			if (messages.Count == 0)
				return null;
			return ComposeProtoFile(package, allEnums, messages);
		}

		static string ComposeProtoFile(string package, HashSet<TypeDef> referencedEnums, IEnumerable<(string msgName, List<(int number, string protoFieldName, string protoType)> rows)> messages) {
			var sb = new StringBuilder();
			sb.AppendLine("syntax = \"proto3\";");
			sb.AppendLine();
			sb.AppendLine($"package {package};");
			sb.AppendLine();
			foreach (TypeDef enumTd in referencedEnums.OrderBy(t => GetEnumProtoName(t), StringComparer.Ordinal)) {
				string? enumBlock = TryEmitEnumDefinition(enumTd);
				if (enumBlock != null) {
					sb.Append(enumBlock);
					sb.AppendLine();
				}
			}
			bool first = true;
			foreach ((string msgName, var rows) in messages) {
				if (!first)
					sb.AppendLine();
				first = false;
				sb.AppendLine($"message {msgName} {{");
				foreach (var (number, name, ptype) in rows) {
					sb.AppendLine($"  {ptype} {name} = {number};");
				}
				sb.AppendLine("}");
			}
			sb.AppendLine();
			return sb.ToString().Replace("\r\n", "\n");
		}

		static List<(int number, string protoFieldName, string protoType)>? TryBuildMessageRows(TypeDef messageType, TypeResolver resolver, HashSet<TypeDef> referencedEnums) {
			var rows = new List<(int number, string protoFieldName, string protoType)>();
			foreach (FieldDef cf in messageType.Fields) {
				if (!cf.IsStatic || !cf.HasConstant)
					continue;
				string cn = cf.Name.String;
				if (!cn.EndsWith(FieldNumberSuffix, StringComparison.Ordinal))
					continue;
				object? cv = cf.Constant.Value;
				int num;
				if (cv is int ii)
					num = ii;
				else if (cv is long ll) {
					if (ll > int.MaxValue || ll < int.MinValue)
						continue;
					num = (int)ll;
				} else if (cv is short ss)
					num = ss;
				else if (cv is ushort uus)
					num = uus;
				else
					continue;
				if (num <= 0)
					continue;
				string logicalName = cn.Substring(0, cn.Length - FieldNumberSuffix.Length);
				if (logicalName.Length == 0)
					continue;
				string backingName = logicalName + "_";
				FieldDef? inst = FindInstanceField(messageType, backingName);
				if (inst == null) {
					rows.Add((num, logicalName, "bytes"));
					continue;
				}
				string? pt = MapToProtoType(inst.FieldType, resolver, referencedEnums);
				if (pt == null)
					pt = "bytes";
				rows.Add((num, logicalName, pt));
			}
			if (rows.Count == 0)
				return null;
			rows.Sort((a, b) => a.number.CompareTo(b.number));
			return rows;
		}

		/// <summary>
		/// 与消息/字段中引用的类型名一致：顶层用短名，嵌套枚举用 Outer_Inner。
		/// </summary>
		public static string GetEnumProtoName(TypeDef enumType) {
			if (!enumType.IsNested)
				return enumType.Name.String;
			var parts = new List<string>();
			TypeDef? walk = enumType;
			while (walk != null) {
				parts.Add(walk.Name.String);
				walk = walk.DeclaringType;
			}
			parts.Reverse();
			return string.Join("_", parts);
		}

		static string? TryEmitEnumDefinition(TypeDef enumType) {
			if (!enumType.IsEnum)
				return null;
			string name = GetEnumProtoName(enumType);
			var lines = new List<(string member, int value)>();
			foreach (FieldDef f in enumType.Fields) {
				if (f.Name.String == "value__")
					continue;
				if (!f.HasConstant)
					continue;
				object? cv = f.Constant.Value;
				int val;
				if (cv is int i)
					val = i;
				else if (cv is long l) {
					if (l > int.MaxValue || l < int.MinValue)
						continue;
					val = (int)l;
				} else if (cv is short s)
					val = s;
				else if (cv is ushort us)
					val = us;
				else if (cv is byte b)
					val = b;
				else if (cv is sbyte sb)
					val = sb;
				else
					continue;
				lines.Add((f.Name.String, val));
			}
			if (lines.Count == 0)
				return null;
			lines.Sort((a, b) => a.value != b.value ? a.value.CompareTo(b.value) : string.Compare(a.member, b.member, StringComparison.Ordinal));
			var eb = new StringBuilder();
			eb.AppendLine($"enum {name} {{");
			foreach (var (member, value) in lines) {
				eb.AppendLine($"  {member} = {value};");
			}
			eb.AppendLine("}");
			return eb.ToString();
		}

		static FieldDef? FindInstanceField(TypeDef type, string name) {
			foreach (FieldDef f in type.Fields) {
				if (f.IsStatic)
					continue;
				if (f.Name.String == name)
					return f;
			}
			return null;
		}

		static string? MapToProtoType(TypeSig sig, TypeResolver resolver, HashSet<TypeDef> referencedEnums) {
			sig = sig.RemovePinnedAndModifiers();
			if (sig.FullName == "System.String")
				return "string";
			if (sig.FullName == "Google.Protobuf.ByteString")
				return "bytes";
			if (sig is GenericInstSig gi) {
				string gfn = gi.GenericType.FullName;
				if (gfn.StartsWith("Google.Protobuf.Collections.RepeatedField", StringComparison.Ordinal)) {
					if (gi.GenericArguments.Count != 1)
						return null;
					string? inner = MapToProtoType(gi.GenericArguments[0], resolver, referencedEnums);
					if (inner == null)
						return null;
					if (inner.StartsWith("map<") || inner.StartsWith("repeated "))
						return null;
					return "repeated " + inner;
				}
				if (gfn.StartsWith("Google.Protobuf.Collections.MapField", StringComparison.Ordinal)) {
					if (gi.GenericArguments.Count != 2)
						return null;
					string? k = MapToProtoType(gi.GenericArguments[0], resolver, referencedEnums);
					string? v = MapToProtoType(gi.GenericArguments[1], resolver, referencedEnums);
					if (k == null || v == null)
						return null;
					return $"map<{k}, {v}>";
				}
			}
			if (sig is CorLibTypeSig cor) {
				return cor.ElementType switch {
					ElementType.Boolean => "bool",
					ElementType.I1 => "int32",
					ElementType.U1 => "uint32",
					ElementType.I2 => "int32",
					ElementType.U2 => "uint32",
					ElementType.I4 => "int32",
					ElementType.U4 => "uint32",
					ElementType.I8 => "int64",
					ElementType.U8 => "uint64",
					ElementType.R4 => "float",
					ElementType.R8 => "double",
					ElementType.String => "string",
					_ => null,
				};
			}
			try {
				ITypeDefOrRef tdr = sig.ToTypeDefOrRef();
				TypeDef? td = resolver.Find(tdr);
				if (td != null && td.IsEnum) {
					referencedEnums.Add(td);
					return GetEnumProtoName(td);
				}
				if (td != null)
					return GetMessageProtoName(td);
			} catch {
				// 无法解析为 TypeDef/TypeRef 时退回字符串
			}
			return sig.TypeName.Replace("/", ".").Replace("+", ".");
		}
	}
}
