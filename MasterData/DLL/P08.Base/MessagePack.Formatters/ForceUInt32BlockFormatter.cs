namespace MessagePack.Formatters;

public sealed class ForceUInt32BlockFormatter : IMessagePackFormatter<uint>, IMessagePackFormatter
{
	public static readonly ForceUInt32BlockFormatter Instance = new ForceUInt32BlockFormatter();

	private ForceUInt32BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, uint value, MessagePackSerializerOptions options)
	{
		writer.WriteUInt32(value);
	}

	public uint Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadUInt32();
	}
}
