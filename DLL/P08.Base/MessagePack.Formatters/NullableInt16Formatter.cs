namespace MessagePack.Formatters;

public sealed class NullableInt16Formatter : IMessagePackFormatter<short?>, IMessagePackFormatter
{
	public static readonly NullableInt16Formatter Instance = new NullableInt16Formatter();

	private NullableInt16Formatter()
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
			writer.Write(value.Value);
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
