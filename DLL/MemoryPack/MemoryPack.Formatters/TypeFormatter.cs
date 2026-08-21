using System;
using System.Text.RegularExpressions;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class TypeFormatter : MemoryPackFormatter<Type>
{
	private static readonly Regex _shortTypeNameRegex = new Regex(", Version=\\d+.\\d+.\\d+.\\d+, Culture=[\\w-]+, PublicKeyToken=(?:null|[a-f0-9]{16})", RegexOptions.Compiled);

	private static Regex ShortTypeNameRegex()
	{
		return _shortTypeNameRegex;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Type? value)
	{
		string text = value?.AssemblyQualifiedName;
		if (text == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		string value2 = ShortTypeNameRegex().Replace(text, "");
		writer.WriteString(value2);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Type? value)
	{
		string text = reader.ReadString();
		if (text == null)
		{
			value = null;
		}
		else
		{
			value = Type.GetType(text, throwOnError: true);
		}
	}
}
