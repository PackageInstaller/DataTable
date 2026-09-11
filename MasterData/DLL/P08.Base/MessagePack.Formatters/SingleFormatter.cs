namespace MessagePack.Formatters;

public sealed class SingleFormatter : IMessagePackFormatter<float>, IMessagePackFormatter
{
	public static readonly SingleFormatter Instance = new SingleFormatter();

	private SingleFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, float value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public float Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadSingle();
	}
}
