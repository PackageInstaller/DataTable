namespace MessagePack.Formatters;

public sealed class NullableFormatter<T> : IMessagePackFormatter<T?>, IMessagePackFormatter where T : struct
{
	public void Serialize(ref MessagePackWriter writer, T? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer, value.Value, options);
		}
	}

	public T? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			reader.ReadNil();
			return null;
		}
		return options.Resolver.GetFormatterWithVerify<T>().Deserialize(ref reader, options);
	}
}
