using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class TimeZoneInfoFormatter : MemoryPackFormatter<TimeZoneInfo>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref TimeZoneInfo? value)
	{
		writer.WriteString(value?.ToSerializedString());
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref TimeZoneInfo? value)
	{
		string text = reader.ReadString();
		if (text == null)
		{
			value = null;
		}
		else
		{
			value = TimeZoneInfo.FromSerializedString(text);
		}
	}
}
