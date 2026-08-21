using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class ReadOnlySequenceFormatter<T> : IMessagePackFormatter<ReadOnlySequence<T>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, ReadOnlySequence<T> value, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		writer.WriteArrayHeader(checked((int)value.Length));
		foreach (ReadOnlyMemory<T> item in value)
		{
			ReadOnlySpan<T> span = item.Span;
			for (int i = 0; i < span.Length; i++)
			{
				writer.CancellationToken.ThrowIfCancellationRequested();
				formatterWithVerify.Serialize(ref writer, span[i], options);
			}
		}
	}

	public ReadOnlySequence<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return new ReadOnlySequence<T>(options.Resolver.GetFormatterWithVerify<T[]>().Deserialize(ref reader, options));
	}
}
