namespace MessagePack.Formatters;

public sealed class ForceByteBlockFormatter : IMessagePackFormatter<byte>, IMessagePackFormatter
{
	public static readonly ForceByteBlockFormatter Instance = new ForceByteBlockFormatter();

	private ForceByteBlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, byte value, MessagePackSerializerOptions options)
	{
		writer.WriteUInt8(value);
	}

	public byte Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadByte();
	}
}
