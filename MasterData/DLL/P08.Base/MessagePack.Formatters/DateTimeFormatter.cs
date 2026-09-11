using System;

namespace MessagePack.Formatters;

public sealed class DateTimeFormatter : IMessagePackFormatter<DateTime>, IMessagePackFormatter
{
	public static readonly DateTimeFormatter Instance = new DateTimeFormatter();

	private DateTimeFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, DateTime value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public DateTime Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadDateTime();
	}
}
