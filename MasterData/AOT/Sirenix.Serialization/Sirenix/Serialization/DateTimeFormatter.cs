using System;

namespace Sirenix.Serialization;

public sealed class DateTimeFormatter : MinimalBaseFormatter<DateTime>
{
	protected override void Read(ref DateTime value, IDataReader reader)
	{
		if (reader.PeekEntry(out var _) == EntryType.Integer)
		{
			reader.ReadInt64(out var value2);
			value = DateTime.FromBinary(value2);
		}
	}

	protected override void Write(ref DateTime value, IDataWriter writer)
	{
		writer.WriteInt64(null, value.ToBinary());
	}
}
