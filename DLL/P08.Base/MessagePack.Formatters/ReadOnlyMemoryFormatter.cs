using System;

namespace MessagePack.Formatters;

public sealed class ReadOnlyMemoryFormatter<T> : IMessagePackFormatter<ReadOnlyMemory<T>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, ReadOnlyMemory<T> value, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		ReadOnlySpan<T> span = value.Span;
		writer.WriteArrayHeader(span.Length);
		for (int i = 0; i < span.Length; i++)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, span[i], options);
		}
	}

	public ReadOnlyMemory<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return options.Resolver.GetFormatterWithVerify<T[]>().Deserialize(ref reader, options);
	}
}
