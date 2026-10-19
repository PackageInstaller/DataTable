using System;

namespace Sirenix.Serialization;

public sealed class TimeSpanFormatter : MinimalBaseFormatter<TimeSpan>
{
	protected override void Read(ref TimeSpan value, IDataReader reader)
	{
		if (reader.PeekEntry(out var _) == EntryType.Integer)
		{
			reader.ReadInt64(out var value2);
			value = new TimeSpan(value2);
		}
	}

	protected override void Write(ref TimeSpan value, IDataWriter writer)
	{
		writer.WriteInt64(null, value.Ticks);
	}
}
