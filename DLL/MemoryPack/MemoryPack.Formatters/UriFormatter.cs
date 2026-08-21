using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class UriFormatter : MemoryPackFormatter<Uri>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Uri? value)
	{
		writer.WriteString(value?.OriginalString);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Uri? value)
	{
		string text = reader.ReadString();
		if (text == null)
		{
			value = null;
		}
		else
		{
			value = new Uri(text, UriKind.RelativeOrAbsolute);
		}
	}
}
