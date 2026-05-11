using System.Text;
using System.Text.RegularExpressions;
using dnlib.DotNet;
using dnlib.DotNet.Emit;
using Google.Protobuf.Reflection;

namespace DNFBDmp {
	public static class ProtobufExtractor {
		/// <summary>
		/// 扫描整个模块（所有类型、所有方法）中能通过 Base64→FileDescriptorProto 的嵌入串，按 proto 文件名索引。
		/// 用于 IL2CPP 存根等场景下 .cctor 无 IL，但 #US 与其它方法里仍保留 ldstr 的情况。
		/// </summary>
		public static Dictionary<string, FileDescriptorProto> BuildGlobalDescriptorCache(IEnumerable<ModuleDef> modules) {
			var cache = new Dictionary<string, FileDescriptorProto>(StringComparer.OrdinalIgnoreCase);
			foreach (ModuleDef mod in modules) {
				foreach (TypeDef type in EnumerateAllTypes(mod)) {
					foreach (MethodDef method in type.Methods) {
						if (!method.HasBody)
							continue;
						foreach (Instruction instr in method.Body.Instructions) {
							if (instr.OpCode.Code != Code.Ldstr)
								continue;
							var s = (string)instr.Operand!;
							if (s.Length < 40)
								continue;
							TryAddParsedProto(cache, s);
						}
						foreach (string block in ExtractBase64StringsFromMethod(method)) {
							TryAddParsedProto(cache, block);
						}
					}
				}
			}
			return cache;
		}

		static void TryAddParsedProto(Dictionary<string, FileDescriptorProto> cache, string candidate) {
			FileDescriptorProto? p = TryParseFileDescriptorProto(candidate);
			if (p == null || string.IsNullOrEmpty(p.Name))
				return;
			if (!cache.ContainsKey(p.Name))
				cache[p.Name] = p;
		}

		static IEnumerable<TypeDef> EnumerateAllTypes(ModuleDef mod) {
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

		/// <summary>
		/// 从单个 *Reflection 类型提取：优先 .cctor，再其它静态方法；再尝试静态 byte[] 字段（FieldRVA）。
		/// </summary>
		public static FileDescriptorProto? TryExtractDescriptorForReflectionType(TypeDef refType, Dictionary<string, FileDescriptorProto>? globalCache) {
			foreach (MethodDef m in OrderReflectionMethods(refType)) {
				if (!m.HasBody)
					continue;
				foreach (string s in ExtractBase64StringsFromMethod(m)) {
					FileDescriptorProto? p = TryParseFileDescriptorProto(s);
					if (p != null)
						return p;
				}
			}
			foreach (FieldDef f in refType.Fields) {
				if (!f.IsStatic)
					continue;
				byte[]? raw = TryReadFieldRvaBytes(f);
				if (raw == null || raw.Length < 16)
					continue;
				FileDescriptorProto? p = TryParseFileDescriptorProtoFromBytes(raw);
				if (p != null)
					return p;
			}
			if (globalCache != null) {
				string expectedName = refType.Name.String.Replace("Reflection", "", StringComparison.Ordinal) + ".proto";
				if (globalCache.TryGetValue(expectedName, out FileDescriptorProto? hit))
					return hit;
				foreach (var kv in globalCache) {
					if (string.Equals(kv.Key, expectedName, StringComparison.OrdinalIgnoreCase))
						return kv.Value;
				}
			}
			return null;
		}

		static IEnumerable<MethodDef> OrderReflectionMethods(TypeDef refType) {
			MethodDef? cctor = refType.FindStaticConstructor();
			if (cctor != null)
				yield return cctor;
			foreach (MethodDef m in refType.Methods) {
				if (cctor != null && m == cctor)
					continue;
				if (m.Name == ".cctor")
					continue;
				yield return m;
			}
		}

		static byte[]? TryReadFieldRvaBytes(FieldDef f) {
			if (!f.HasFieldRVA)
				return null;
			try {
				object? iv = f.InitialValue;
				if (iv is byte[] b)
					return b;
			} catch {
				// ignore
			}
			return null;
		}

		public static List<string> ExtractBase64StringsFromMethod(MethodDef? method) {
			var results = new List<string>();
			if (method?.Body == null)
				return results;
			var stack = new Stack<string>();
			foreach (Instruction instr in method.Body.Instructions) {
				switch (instr.OpCode.Code) {
					case Code.Ldstr:
						stack.Push((string)instr.Operand!);
						break;
					case Code.Call:
					case Code.Callvirt:
						if (instr.Operand is not IMethod m)
							break;
						if (IsConvertFromBase64String(m)) {
							if (stack.Count >= 1)
								results.Add(stack.Pop());
							break;
						}
						if (IsStringConcat(m)) {
							int n = SafeGetParamCount(m);
							if (n >= 2 && n <= 12) {
								if (stack.Count < n)
									break;
								var parts = new string[n];
								for (int i = n - 1; i >= 0; i--)
									parts[i] = stack.Pop();
								stack.Push(string.Concat(parts));
							}
						}
						break;
				}
			}
			if (results.Count > 0)
				return results;
			return ExtractViaLdstrWindows(method);
		}

		static List<string> ExtractViaLdstrWindows(MethodDef method) {
			var ldstrs = new List<string>();
			foreach (Instruction instr in method.Body!.Instructions) {
				if (instr.OpCode.Code == Code.Ldstr)
					ldstrs.Add((string)instr.Operand!);
			}
			if (ldstrs.Count == 0)
				return [];
			for (int start = 0; start < ldstrs.Count; start++) {
				var sb = new StringBuilder();
				for (int i = start; i < ldstrs.Count; i++) {
					sb.Append(ldstrs[i]);
					string candidate = sb.ToString();
					if (candidate.Length < 32)
						continue;
					if (TryParseFileDescriptorProto(candidate) != null)
						return new List<string> { candidate };
				}
			}
			return [];
		}

		static int SafeGetParamCount(IMethod m) {
			try {
				return m.MethodSig.GetParamCount();
			} catch {
				return -1;
			}
		}

		static bool IsConvertFromBase64String(IMethod m) {
			if (m.Name != "FromBase64String")
				return false;
			if (SafeGetParamCount(m) != 1)
				return false;
			if (m.DeclaringType is ITypeDefOrRef tdr) {
				if (tdr.Namespace == "System" && tdr.Name == "Convert")
					return true;
			}
			try {
				string? fn = m.DeclaringType?.FullName;
				if (fn == "System.Convert")
					return true;
				if (fn != null && fn.EndsWith("System.Convert", StringComparison.Ordinal))
					return true;
			} catch {
				// ignore
			}
			return false;
		}

		static bool IsStringConcat(IMethod m) {
			if (m.Name != "Concat")
				return false;
			bool typeOk = false;
			if (m.DeclaringType is ITypeDefOrRef tdr) {
				if (tdr.Namespace == "System" && tdr.Name == "String")
					typeOk = true;
			}
			if (!typeOk) {
				try {
					string? fn = m.DeclaringType?.FullName;
					typeOk = fn == "System.String" || fn == "string";
				} catch {
					return false;
				}
			}
			if (!typeOk)
				return false;
			int n = SafeGetParamCount(m);
			return n >= 2 && n <= 12;
		}

		public static FileDescriptorProto? TryParseFileDescriptorProtoFromBytes(byte[] bytes) {
			try {
				return FileDescriptorProto.Parser.ParseFrom(bytes);
			} catch {
				return null;
			}
		}

		public static FileDescriptorProto? TryParseFileDescriptorProto(string b64) {
			if (string.IsNullOrEmpty(b64))
				return null;
			byte[] bytes;
			try {
				bytes = Convert.FromBase64String(b64);
			} catch (FormatException) {
				try {
					bytes = Convert.FromBase64String(Regex.Replace(b64, @"\s+", ""));
				} catch {
					return null;
				}
			}
			return TryParseFileDescriptorProtoFromBytes(bytes);
		}

		public static string SanitizeFileName(string name) {
			foreach (char c in Path.GetInvalidFileNameChars())
				name = name.Replace(c, '_');
			return string.IsNullOrEmpty(name) ? "unnamed.proto" : name;
		}
	}
}
