using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class LinkedListFormatter<T> : CollectionFormatterBase<T, LinkedList<T>, LinkedList<T>.Enumerator, LinkedList<T>>
{
	protected override void Add(LinkedList<T> collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection.AddLast(value);
	}

	protected override LinkedList<T> Complete(LinkedList<T> intermediateCollection)
	{
		return intermediateCollection;
	}

	protected override LinkedList<T> Create(int count, MessagePackSerializerOptions options)
	{
		return new LinkedList<T>();
	}

	protected override LinkedList<T>.Enumerator GetSourceEnumerator(LinkedList<T> source)
	{
		return source.GetEnumerator();
	}
}
