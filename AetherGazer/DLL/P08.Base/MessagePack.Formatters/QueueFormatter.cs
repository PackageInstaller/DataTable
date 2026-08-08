using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class QueueFormatter<T> : CollectionFormatterBase<T, Queue<T>, Queue<T>.Enumerator, Queue<T>>
{
	protected override int? GetCount(Queue<T> sequence)
	{
		return sequence.Count;
	}

	protected override void Add(Queue<T> collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection.Enqueue(value);
	}

	protected override Queue<T> Create(int count, MessagePackSerializerOptions options)
	{
		return new Queue<T>(count);
	}

	protected override Queue<T>.Enumerator GetSourceEnumerator(Queue<T> source)
	{
		return source.GetEnumerator();
	}

	protected override Queue<T> Complete(Queue<T> intermediateCollection)
	{
		return intermediateCollection;
	}
}
