namespace MessagePack.Formatters;

public sealed class NullableForceInt16BlockFormatter : IMessagePackFormatter<short?>, IMessagePackFormatter
{
	public static readonly NullableForceInt16BlockFormatter Instance = new NullableForceInt16BlockFormatter();

	private NullableForceInt16BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, short? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.WriteInt16(value.Value);
		}
	}

	public short? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadInt16();
	}
}
