namespace MessagePack.Formatters;

public sealed class Int16Formatter : IMessagePackFormatter<short>, IMessagePackFormatter
{
	public static readonly Int16Formatter Instance = new Int16Formatter();

	private Int16Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, short value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public short Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadInt16();
	}
}
