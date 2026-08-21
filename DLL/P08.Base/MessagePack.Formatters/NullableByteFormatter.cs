namespace MessagePack.Formatters;

public sealed class NullableByteFormatter : IMessagePackFormatter<byte?>, IMessagePackFormatter
{
	public static readonly NullableByteFormatter Instance = new NullableByteFormatter();

	private NullableByteFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, byte? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value.Value);
		}
	}

	public byte? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadByte();
	}
}
