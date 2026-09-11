namespace MessagePack.Formatters;

public class NilFormatter : IMessagePackFormatter<Nil>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<Nil> Instance = new NilFormatter();

	private NilFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, Nil value, MessagePackSerializerOptions options)
	{
		writer.WriteNil();
	}

	public Nil Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return reader.ReadNil();
	}
}
