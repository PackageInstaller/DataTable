using System.Globalization;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class CultureInfoFormatter : MemoryPackFormatter<CultureInfo>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref CultureInfo? value)
	{
		writer.WriteString(value?.Name);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref CultureInfo? value)
	{
		string text = reader.ReadString();
		if (text == null)
		{
			value = null;
		}
		else
		{
			value = CultureInfo.GetCultureInfo(text);
		}
	}
}
