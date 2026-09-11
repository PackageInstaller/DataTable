namespace MessagePack.Formatters;

public sealed class NullableStringFormatter : IMessagePackFormatter<string>, IMessagePackFormatter
{
	public static readonly NullableStringFormatter Instance = new NullableStringFormatter();

	private NullableStringFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, string value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public string Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadString();
	}
}
