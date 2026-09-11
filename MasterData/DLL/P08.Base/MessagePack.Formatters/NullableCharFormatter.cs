namespace MessagePack.Formatters;

public sealed class NullableCharFormatter : IMessagePackFormatter<char?>, IMessagePackFormatter
{
	public static readonly NullableCharFormatter Instance = new NullableCharFormatter();

	private NullableCharFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, char? value, MessagePackSerializerOptions options)
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

	public char? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadChar();
	}
}
