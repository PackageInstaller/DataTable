namespace MessagePack.Formatters;

public sealed class BooleanFormatter : IMessagePackFormatter<bool>, IMessagePackFormatter
{
	public static readonly BooleanFormatter Instance = new BooleanFormatter();

	private BooleanFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, bool value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public bool Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadBoolean();
	}
}
