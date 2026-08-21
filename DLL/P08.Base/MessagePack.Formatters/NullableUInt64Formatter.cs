namespace MessagePack.Formatters;

public sealed class NullableUInt64Formatter : IMessagePackFormatter<ulong?>, IMessagePackFormatter
{
	public static readonly NullableUInt64Formatter Instance = new NullableUInt64Formatter();

	private NullableUInt64Formatter()
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
			writer.Write(value.Value);
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
