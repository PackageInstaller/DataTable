namespace MessagePack.Formatters;

public sealed class IgnoreFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		writer.WriteNil();
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		reader.Skip();
		return default(T);
	}
}
