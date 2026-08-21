namespace MessagePack.Formatters;

public sealed class NullableForceByteBlockFormatter : IMessagePackFormatter<byte?>, IMessagePackFormatter
{
	public static readonly NullableForceByteBlockFormatter Instance = new NullableForceByteBlockFormatter();

	private NullableForceByteBlockFormatter()
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
			writer.WriteUInt8(value.Value);
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
