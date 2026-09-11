namespace MessagePack.Formatters;

public sealed class UInt64Formatter : IMessagePackFormatter<ulong>, IMessagePackFormatter
{
	public static readonly UInt64Formatter Instance = new UInt64Formatter();

	private UInt64Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ulong value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public ulong Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadUInt64();
	}
}
