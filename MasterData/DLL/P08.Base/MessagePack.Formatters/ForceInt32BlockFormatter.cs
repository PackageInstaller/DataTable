namespace MessagePack.Formatters;

public sealed class ForceInt32BlockFormatter : IMessagePackFormatter<int>, IMessagePackFormatter
{
	public static readonly ForceInt32BlockFormatter Instance = new ForceInt32BlockFormatter();

	private ForceInt32BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, int value, MessagePackSerializerOptions options)
	{
		writer.WriteInt32(value);
	}

	public int Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadInt32();
	}
}
