namespace MessagePack.Formatters;

public sealed class ForceInt64BlockFormatter : IMessagePackFormatter<long>, IMessagePackFormatter
{
	public static readonly ForceInt64BlockFormatter Instance = new ForceInt64BlockFormatter();

	private ForceInt64BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, long value, MessagePackSerializerOptions options)
	{
		writer.WriteInt64(value);
	}

	public long Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadInt64();
	}
}
