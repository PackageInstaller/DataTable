using System;

namespace MessagePack.Formatters;

public sealed class NullableDateTimeFormatter : IMessagePackFormatter<DateTime?>, IMessagePackFormatter
{
	public static readonly NullableDateTimeFormatter Instance = new NullableDateTimeFormatter();

	private NullableDateTimeFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, DateTime? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value.Value);
		}
	}

	public DateTime? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadDateTime();
	}
}
