namespace MessagePack.Formatters;

public sealed class ByteFormatter : IMessagePackFormatter<byte>, IMessagePackFormatter
{
	public static readonly ByteFormatter Instance = new ByteFormatter();

	private ByteFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, byte value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public byte Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadByte();
	}
}
