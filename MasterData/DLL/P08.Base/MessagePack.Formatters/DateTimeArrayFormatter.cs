using System;

namespace MessagePack.Formatters;

public sealed class DateTimeArrayFormatter : IMessagePackFormatter<DateTime[]>, IMessagePackFormatter
{
	public static readonly DateTimeArrayFormatter Instance = new DateTimeArrayFormatter();

	private DateTimeArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, DateTime[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			writer.Write(value[i]);
		}
	}

	public DateTime[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<DateTime>();
		}
		DateTime[] array = new DateTime[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadDateTime();
		}
		return array;
	}
}
