namespace MessagePack.Formatters;

public sealed class NullableForceInt32BlockFormatter : IMessagePackFormatter<int?>, IMessagePackFormatter
{
	public static readonly NullableForceInt32BlockFormatter Instance = new NullableForceInt32BlockFormatter();

	private NullableForceInt32BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, int? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.WriteInt32(value.Value);
		}
	}

	public int? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadInt32();
	}
}
