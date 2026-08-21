namespace MessagePack.Formatters;

public sealed class NullableDoubleFormatter : IMessagePackFormatter<double?>, IMessagePackFormatter
{
	public static readonly NullableDoubleFormatter Instance = new NullableDoubleFormatter();

	private NullableDoubleFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, double? value, MessagePackSerializerOptions options)
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

	public double? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadDouble();
	}
}
