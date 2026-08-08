namespace MessagePack.Formatters;

public sealed class NullableInt32Formatter : IMessagePackFormatter<int?>, IMessagePackFormatter
{
	public static readonly NullableInt32Formatter Instance = new NullableInt32Formatter();

	private NullableInt32Formatter()
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
			writer.Write(value.Value);
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
