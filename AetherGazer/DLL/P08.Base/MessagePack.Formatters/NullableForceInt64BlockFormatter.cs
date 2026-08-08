namespace MessagePack.Formatters;

public sealed class NullableForceInt64BlockFormatter : IMessagePackFormatter<long?>, IMessagePackFormatter
{
	public static readonly NullableForceInt64BlockFormatter Instance = new NullableForceInt64BlockFormatter();

	private NullableForceInt64BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, long? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.WriteInt64(value.Value);
		}
	}

	public long? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadInt64();
	}
}
