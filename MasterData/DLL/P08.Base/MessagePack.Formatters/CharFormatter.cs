namespace MessagePack.Formatters;

public sealed class CharFormatter : IMessagePackFormatter<char>, IMessagePackFormatter
{
	public static readonly CharFormatter Instance = new CharFormatter();

	private CharFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, char value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public char Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadChar();
	}
}
