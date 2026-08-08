namespace MessagePack.Formatters;

public sealed class UInt32Formatter : IMessagePackFormatter<uint>, IMessagePackFormatter
{
	public static readonly UInt32Formatter Instance = new UInt32Formatter();

	private UInt32Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, uint value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public uint Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadUInt32();
	}
}
