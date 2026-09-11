using System;

namespace MessagePack.Formatters;

public sealed class MemoryFormatter<T> : IMessagePackFormatter<Memory<T>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Memory<T> value, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<ReadOnlyMemory<T>>().Serialize(ref writer, value, options);
	}

	public Memory<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return options.Resolver.GetFormatterWithVerify<T[]>().Deserialize(ref reader, options);
	}
}
