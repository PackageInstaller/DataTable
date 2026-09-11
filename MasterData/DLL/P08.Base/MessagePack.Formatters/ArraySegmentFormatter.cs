using System;

namespace MessagePack.Formatters;

public sealed class ArraySegmentFormatter<T> : IMessagePackFormatter<ArraySegment<T>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, ArraySegment<T> value, MessagePackSerializerOptions options)
	{
		if (value.Array == null)
		{
			writer.WriteNil();
		}
		else
		{
			options.Resolver.GetFormatterWithVerify<Memory<T>>().Serialize(ref writer, value, options);
		}
	}

	public ArraySegment<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return default(ArraySegment<T>);
		}
		return new ArraySegment<T>(options.Resolver.GetFormatterWithVerify<T[]>().Deserialize(ref reader, options));
	}
}
