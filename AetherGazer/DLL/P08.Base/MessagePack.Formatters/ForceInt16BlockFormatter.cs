namespace MessagePack.Formatters;

public sealed class ForceInt16BlockFormatter : IMessagePackFormatter<short>, IMessagePackFormatter
{
	public static readonly ForceInt16BlockFormatter Instance = new ForceInt16BlockFormatter();

	private ForceInt16BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, short value, MessagePackSerializerOptions options)
	{
		writer.WriteInt16(value);
	}

	public short Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadInt16();
	}
}
