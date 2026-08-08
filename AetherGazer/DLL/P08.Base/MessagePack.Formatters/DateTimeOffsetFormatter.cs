using System;

namespace MessagePack.Formatters;

public sealed class DateTimeOffsetFormatter : IMessagePackFormatter<DateTimeOffset>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<DateTimeOffset> Instance = new DateTimeOffsetFormatter();

	private DateTimeOffsetFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, DateTimeOffset value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		writer.Write(new DateTime(value.Ticks, DateTimeKind.Utc));
		writer.Write((short)value.Offset.TotalMinutes);
	}

	public DateTimeOffset Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.ReadArrayHeader() != 2)
		{
			throw new MessagePackSerializationException("Invalid DateTimeOffset format.");
		}
		DateTime dateTime = reader.ReadDateTime();
		short num = reader.ReadInt16();
		return new DateTimeOffset(dateTime.Ticks, TimeSpan.FromMinutes(num));
	}
}
