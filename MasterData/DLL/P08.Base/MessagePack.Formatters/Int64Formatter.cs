namespace MessagePack.Formatters;

public sealed class Int64Formatter : IMessagePackFormatter<long>, IMessagePackFormatter
{
	public static readonly Int64Formatter Instance = new Int64Formatter();

	private Int64Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, long value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public long Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadInt64();
	}
}
