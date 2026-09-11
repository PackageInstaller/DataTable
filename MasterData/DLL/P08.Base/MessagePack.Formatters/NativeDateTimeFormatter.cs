using System;

namespace MessagePack.Formatters;

public sealed class NativeDateTimeFormatter : IMessagePackFormatter<DateTime>, IMessagePackFormatter
{
	public static readonly NativeDateTimeFormatter Instance = new NativeDateTimeFormatter();

	public void Serialize(ref MessagePackWriter writer, DateTime value, MessagePackSerializerOptions options)
	{
		long value2 = value.ToBinary();
		writer.Write(value2);
	}

	public DateTime Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return DateTime.FromBinary(reader.ReadInt64());
	}
}
