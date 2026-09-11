namespace MessagePack.Formatters;

public sealed class NullableInt64Formatter : IMessagePackFormatter<long?>, IMessagePackFormatter
{
	public static readonly NullableInt64Formatter Instance = new NullableInt64Formatter();

	private NullableInt64Formatter()
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
			writer.Write(value.Value);
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
