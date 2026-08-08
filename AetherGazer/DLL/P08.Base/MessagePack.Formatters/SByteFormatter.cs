namespace MessagePack.Formatters;

public sealed class SByteFormatter : IMessagePackFormatter<sbyte>, IMessagePackFormatter
{
	public static readonly SByteFormatter Instance = new SByteFormatter();

	private SByteFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, sbyte value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public sbyte Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadSByte();
	}
}
