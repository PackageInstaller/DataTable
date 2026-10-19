using System;
using System.Globalization;

namespace Sirenix.Serialization;

public sealed class DateTimeOffsetFormatter : MinimalBaseFormatter<DateTimeOffset>
{
	protected override void Read(ref DateTimeOffset value, IDataReader reader)
	{
		if (reader.PeekEntry(out var _) == EntryType.String)
		{
			reader.ReadString(out var value2);
			DateTimeOffset.TryParse(value2, out value);
		}
	}

	protected override void Write(ref DateTimeOffset value, IDataWriter writer)
	{
		writer.WriteString(null, value.ToString("O", CultureInfo.InvariantCulture));
	}
}
