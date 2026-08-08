namespace MessagePack.Formatters;

public sealed class NullableForceUInt64BlockFormatter : IMessagePackFormatter<ulong?>, IMessagePackFormatter
{
	public static readonly NullableForceUInt64BlockFormatter Instance = new NullableForceUInt64BlockFormatter();

	private NullableForceUInt64BlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ulong? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.WriteUInt64(value.Value);
		}
	}

	public ulong? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadUInt64();
	}
}
