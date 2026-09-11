using System;

namespace MessagePack.Formatters;

public sealed class LazyFormatter<T> : IMessagePackFormatter<Lazy<T>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Lazy<T> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
		}
		else
		{
			options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer, value.Value, options);
		}
	}

	public Lazy<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		try
		{
			IFormatterResolver resolver = options.Resolver;
			T v = resolver.GetFormatterWithVerify<T>().Deserialize(ref reader, options);
			return new Lazy<T>(() => v);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
