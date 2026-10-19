using System;
using System.Collections.Generic;
using System.Text;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting.FullSerializer;

public class fsAotCompilationManager
{
	private struct AotCompilation
	{
		public Type Type;

		public fsMetaProperty[] Members;

		public bool IsConstructorPublic;
	}

	private static Dictionary<Type, string> _computedAotCompilations = new Dictionary<Type, string>();

	private static List<AotCompilation> _uncomputedAotCompilations = new List<AotCompilation>();

	public static Dictionary<Type, string> AvailableAotCompilations
	{
		get
		{
			for (int i = 0; i < _uncomputedAotCompilations.Count; i++)
			{
				AotCompilation aotCompilation = _uncomputedAotCompilations[i];
				_computedAotCompilations[aotCompilation.Type] = GenerateDirectConverterForTypeInCSharp(aotCompilation.Type, aotCompilation.Members, aotCompilation.IsConstructorPublic);
			}
			_uncomputedAotCompilations.Clear();
			return _computedAotCompilations;
		}
	}

	public static bool TryToPerformAotCompilation(fsConfig config, Type type, out string aotCompiledClassInCSharp)
	{
		if (fsMetaType.Get(config, type).EmitAotData())
		{
			aotCompiledClassInCSharp = AvailableAotCompilations[type];
			return true;
		}
		aotCompiledClassInCSharp = null;
		return false;
	}

	public static void AddAotCompilation(Type type, fsMetaProperty[] members, bool isConstructorPublic)
	{
		_uncomputedAotCompilations.Add(new AotCompilation
		{
			Type = type,
			Members = members,
			IsConstructorPublic = isConstructorPublic
		});
	}

	private static string GetConverterString(fsMetaProperty member)
	{
		if (member.OverrideConverterType == null)
		{
			return "null";
		}
		return "typeof(" + member.OverrideConverterType.CSharpName(includeNamespace: true) + ")";
	}

	private static string GenerateDirectConverterForTypeInCSharp(Type type, fsMetaProperty[] members, bool isConstructorPublic)
	{
		StringBuilder stringBuilder = new StringBuilder();
		string text = type.CSharpName(includeNamespace: true);
		string text2 = type.CSharpName(includeNamespace: true, ensureSafeDeclarationName: true);
		stringBuilder.AppendLine("using System;");
		stringBuilder.AppendLine("using System.Collections.Generic;");
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("namespace Unity.VisualScripting.Dependencies.FullSerializer {");
		stringBuilder.AppendLine("    partial class fsConverterRegistrar {");
		stringBuilder.AppendLine("        public static Speedup." + text2 + "_DirectConverter Register_" + text2 + ";");
		stringBuilder.AppendLine("    }");
		stringBuilder.AppendLine("}");
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("namespace Unity.VisualScripting.Dependencies.FullSerializer.Speedup {");
		stringBuilder.AppendLine("    public class " + text2 + "_DirectConverter : fsDirectConverter<" + text + "> {");
		stringBuilder.AppendLine("        protected override fsResult DoSerialize(" + text + " model, Dictionary<string, fsData> serialized) {");
		stringBuilder.AppendLine("            var result = fsResult.Success;");
		stringBuilder.AppendLine();
		foreach (fsMetaProperty fsMetaProperty2 in members)
		{
			stringBuilder.AppendLine("            result += SerializeMember(serialized, " + GetConverterString(fsMetaProperty2) + ", \"" + fsMetaProperty2.JsonName + "\", model." + fsMetaProperty2.MemberName + ");");
		}
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("            return result;");
		stringBuilder.AppendLine("        }");
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("        protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref " + text + " model) {");
		stringBuilder.AppendLine("            var result = fsResult.Success;");
		stringBuilder.AppendLine();
		for (int j = 0; j < members.Length; j++)
		{
			fsMetaProperty fsMetaProperty3 = members[j];
			stringBuilder.AppendLine("            var t" + j + " = model." + fsMetaProperty3.MemberName + ";");
			stringBuilder.AppendLine("            result += DeserializeMember(data, " + GetConverterString(fsMetaProperty3) + ", \"" + fsMetaProperty3.JsonName + "\", out t" + j + ");");
			stringBuilder.AppendLine("            model." + fsMetaProperty3.MemberName + " = t" + j + ";");
			stringBuilder.AppendLine();
		}
		stringBuilder.AppendLine("            return result;");
		stringBuilder.AppendLine("        }");
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("        public override object CreateInstance(fsData data, Type storageType) {");
		if (isConstructorPublic)
		{
			stringBuilder.AppendLine("            return new " + text + "();");
		}
		else
		{
			stringBuilder.AppendLine("            return Activator.CreateInstance(typeof(" + text + "), /*nonPublic:*/true);");
		}
		stringBuilder.AppendLine("        }");
		stringBuilder.AppendLine("    }");
		stringBuilder.AppendLine("}");
		return stringBuilder.ToString();
	}
}
