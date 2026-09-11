namespace MessagePack.Formatters;

public sealed class Int32Formatter : IMessagePackFormatter<int>, IMessagePackFormatter
{
	public static readonly Int32Formatter Instance = new Int32Formatter();

	private Int32Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, int value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public int Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadInt32();
	}
}
