namespace MessagePack.Formatters;

public sealed class UInt16Formatter : IMessagePackFormatter<ushort>, IMessagePackFormatter
{
	public static readonly UInt16Formatter Instance = new UInt16Formatter();

	private UInt16Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ushort value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public ushort Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadUInt16();
	}
}
