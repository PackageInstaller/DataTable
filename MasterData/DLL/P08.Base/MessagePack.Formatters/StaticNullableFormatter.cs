namespace MessagePack.Formatters;

public sealed class StaticNullableFormatter<T> : IMessagePackFormatter<T?>, IMessagePackFormatter where T : struct
{
	private readonly IMessagePackFormatter<T> underlyingFormatter;

	public StaticNullableFormatter(IMessagePackFormatter<T> underlyingFormatter)
	{
		this.underlyingFormatter = underlyingFormatter;
	}

	public void Serialize(ref MessagePackWriter writer, T? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			underlyingFormatter.Serialize(ref writer, value.Value, options);
		}
	}

	public T? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return underlyingFormatter.Deserialize(ref reader, options);
	}
}
