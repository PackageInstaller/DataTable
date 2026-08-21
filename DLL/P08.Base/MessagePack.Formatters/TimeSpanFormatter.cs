using System;

namespace MessagePack.Formatters;

public sealed class TimeSpanFormatter : IMessagePackFormatter<TimeSpan>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<TimeSpan> Instance = new TimeSpanFormatter();

	private TimeSpanFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, TimeSpan value, MessagePackSerializerOptions options)
	{
		writer.Write(value.Ticks);
	}

	public TimeSpan Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return new TimeSpan(reader.ReadInt64());
	}
}
