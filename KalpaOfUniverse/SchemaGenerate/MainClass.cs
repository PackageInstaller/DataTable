using System.IO;
using dnlib.DotNet;
using Google.Protobuf.Reflection;

namespace DNFBDmp {
	class MainClass {
		private static void Main(string[] args) {
			if (args.Length == 0) {
				Console.WriteLine("Usage:");
				Console.WriteLine("\tDNFBDmp.exe <folder containing DLLs> [output folder] [--merge-infer]");
				Console.WriteLine();
				Console.WriteLine("Example: DNFBDmp.exe dll output");
				Console.WriteLine("  --merge-infer   推断阶段把所有未由嵌入生成的消息类合并为一个 proto（多 message）");
				Console.WriteLine();
				Console.WriteLine("1) 嵌入 FileDescriptorProto：单文件可含多个 message（来自 descriptor）");
				Console.WriteLine("2) 推断：默认每个 C# 消息类一个 .proto；--merge-infer 则合并为 BlackJack.ConfigData_inferred_merged.proto");
				return;
			}

			bool mergeInfer = args.Any(a => string.Equals(a, "--merge-infer", StringComparison.OrdinalIgnoreCase));
			string[] positional = args.Where(a => !string.Equals(a, "--merge-infer", StringComparison.OrdinalIgnoreCase)).ToArray();
			if (positional.Length == 0) {
				Console.WriteLine("缺少 DLL 目录参数。");
				return;
			}

			string outputFolder = positional.Length >= 2 ? positional[1] : "output";
			string inputFolder = positional[0];
			if (!Directory.Exists(inputFolder)) {
				Console.WriteLine($"输入目录不存在: {inputFolder}");
				return;
			}

			ModuleContext modCtx = ModuleDef.CreateModuleContext();
			TypeResolver resolver = new();
			foreach (string file in Directory.GetFiles(inputFolder, "*.dll")) {
				Console.WriteLine($"Loading DLL {file}");
				resolver.add(ModuleDefMD.Load(file, modCtx));
			}

			Directory.CreateDirectory(outputFolder);
			var writtenBaseNames = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
			int ok = 0;

			List<TypeDef> reflectionTypes = resolver.FindProtobufReflectionTypes();
			if (reflectionTypes.Count == 0)
				Console.WriteLine("未找到 BlackJack.ConfigData.*Reflection 类型，跳过嵌入描述符阶段。");
			else {
				Console.WriteLine($"共 {reflectionTypes.Count} 个 Reflection 类型；正在扫描全模块嵌入描述符缓存 …");
				Dictionary<string, FileDescriptorProto> globalCache = ProtobufExtractor.BuildGlobalDescriptorCache(resolver.GetModules());
				Console.WriteLine($"缓存中解析到 {globalCache.Count} 个不同的 FileDescriptorProto（按文件名）。");
				Console.WriteLine("正在从嵌入描述符写入 .proto …");
				foreach (TypeDef refType in reflectionTypes) {
					FileDescriptorProto? proto = ProtobufExtractor.TryExtractDescriptorForReflectionType(refType, globalCache);
					if (proto == null) {
						Console.WriteLine($"  [嵌入] 跳过 {refType.Name}：未找到 FileDescriptorProto。");
						continue;
					}
					string refShortName = refType.Name.String;
					string baseName = !string.IsNullOrEmpty(proto.Name)
						? proto.Name
						: refShortName.Replace("Reflection", "", StringComparison.Ordinal) + ".proto";
					string safe = ProtobufExtractor.SanitizeFileName(baseName);
					if (!safe.EndsWith(".proto", StringComparison.OrdinalIgnoreCase))
						safe += ".proto";
					string outPath = AllocateOutputPath(outputFolder, safe, writtenBaseNames);
					try {
						string text = ProtoFilePrinter.Print(proto);
						File.WriteAllText(outPath, text);
						writtenBaseNames.Add(Path.GetFileName(outPath));
						ok++;
						Console.WriteLine($"  [嵌入] {outPath}");
					} catch (Exception ex) {
						Console.WriteLine($"  [嵌入] 写入 {refType.Name} 失败: {ex.Message}");
					}
				}
			}

			Console.WriteLine();
			List<TypeDef> messageTypes = resolver.FindProtobufMessageTypes();
			var toInfer = messageTypes.Where(mt => !writtenBaseNames.Contains(mt.Name.String + ".proto")).ToList();
			if (mergeInfer) {
				Console.WriteLine($"推断合并模式：将 {toInfer.Count} 个消息类写入 BlackJack.ConfigData_inferred_merged.proto …");
				string? merged = MessageTypeProtoGenerator.TryGenerateProtoMerged(toInfer, resolver);
				if (merged == null) {
					Console.WriteLine("  [推断合并] 无可解析的消息类，跳过。");
				} else {
					string mergedName = "BlackJack.ConfigData_inferred_merged.proto";
					string outPath = AllocateOutputPath(outputFolder, mergedName, writtenBaseNames);
					try {
						File.WriteAllText(outPath, merged);
						writtenBaseNames.Add(Path.GetFileName(outPath));
						ok++;
						Console.WriteLine($"  [推断合并] {outPath}");
					} catch (Exception ex) {
						Console.WriteLine($"  [推断合并] 失败: {ex.Message}");
					}
				}
			} else {
				Console.WriteLine("从消息类 *FieldNumber 推断尚未生成的 .proto（每类一文件）…");
				int infer = 0;
				foreach (TypeDef mt in toInfer) {
					string wantName = mt.Name.String + ".proto";
					string? text = MessageTypeProtoGenerator.TryGenerateProto(mt, resolver);
					if (text == null) {
						Console.WriteLine($"  [推断] 跳过 {mt.Name}：无法解析字段。");
						continue;
					}
					string safe = ProtobufExtractor.SanitizeFileName(wantName);
					string outPath = AllocateOutputPath(outputFolder, safe, writtenBaseNames);
					try {
						File.WriteAllText(outPath, text);
						writtenBaseNames.Add(Path.GetFileName(outPath));
						infer++;
						ok++;
						Console.WriteLine($"  [推断] {outPath}");
					} catch (Exception ex) {
						Console.WriteLine($"  [推断] 写入 {mt.Name} 失败: {ex.Message}");
					}
				}
				Console.WriteLine();
				Console.WriteLine($"完成：嵌入 + 推断共写出 {ok} 个 .proto（其中推断 {infer} 个），目录：{Path.GetFullPath(outputFolder)}");
				return;
			}

			Console.WriteLine();
			Console.WriteLine($"完成：共写出 {ok} 个 .proto，目录：{Path.GetFullPath(outputFolder)}");
		}

		static string AllocateOutputPath(string outputFolder, string safeFileName, HashSet<string> writtenBaseNames) {
			string outPath = Path.Combine(outputFolder, safeFileName);
			if (writtenBaseNames.Contains(Path.GetFileName(outPath))) {
				string stem = Path.GetFileNameWithoutExtension(safeFileName);
				string ext = Path.GetExtension(safeFileName);
				string dir = outputFolder;
				for (int i = 2; ; i++) {
					outPath = Path.Combine(dir, $"{stem}_{i}{ext}");
					if (!writtenBaseNames.Contains(Path.GetFileName(outPath)))
						break;
				}
			}
			return outPath;
		}
	}
}
