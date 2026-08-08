namespace MessagePack.Formatters;

public sealed class ForceUInt64BlockFormatter : IMessagePackFormatter<ulong>, IMessagePackFormatter
{
	public static readonly ForceUInt64BlockFormatter Instance = new ForceUInt64BlockFormatter();

	private ForceUInt64BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ulong value, MessagePackSerializerOptions options)
	{
		writer.WriteUInt64(value);
	}

	public ulong Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadUInt64();
	}
}
