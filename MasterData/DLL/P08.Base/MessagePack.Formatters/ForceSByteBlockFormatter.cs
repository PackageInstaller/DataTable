namespace MessagePack.Formatters;

public sealed class ForceSByteBlockFormatter : IMessagePackFormatter<sbyte>, IMessagePackFormatter
{
	public static readonly ForceSByteBlockFormatter Instance = new ForceSByteBlockFormatter();

	private ForceSByteBlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, sbyte value, MessagePackSerializerOptions options)
	{
		writer.WriteInt8(value);
	}

	public sbyte Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadSByte();
	}
}
