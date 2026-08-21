namespace MessagePack.Formatters;

public sealed class DoubleFormatter : IMessagePackFormatter<double>, IMessagePackFormatter
{
	public static readonly DoubleFormatter Instance = new DoubleFormatter();

	private DoubleFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, double value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public double Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadDouble();
	}
}
