using System.Collections.Concurrent;

namespace MessagePack.Formatters;

public sealed class ConcurrentQueueFormatter<T> : CollectionFormatterBase<T, ConcurrentQueue<T>>
{
	protected override int? GetCount(ConcurrentQueue<T> sequence)
	{
		return sequence.Count;
	}

	protected override void Add(ConcurrentQueue<T> collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection.Enqueue(value);
	}

	protected override ConcurrentQueue<T> Create(int count, MessagePackSerializerOptions options)
	{
		return new ConcurrentQueue<T>();
	}
}
