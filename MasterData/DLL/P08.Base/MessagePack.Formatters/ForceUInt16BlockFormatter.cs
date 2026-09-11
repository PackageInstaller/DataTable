namespace MessagePack.Formatters;

public sealed class ForceUInt16BlockFormatter : IMessagePackFormatter<ushort>, IMessagePackFormatter
{
	public static readonly ForceUInt16BlockFormatter Instance = new ForceUInt16BlockFormatter();

	private ForceUInt16BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ushort value, MessagePackSerializerOptions options)
	{
		writer.WriteUInt16(value);
	}

	public ushort Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadUInt16();
	}
}
