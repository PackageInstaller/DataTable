using System;
using System.Collections.Concurrent;

namespace MessagePack.Formatters;

public sealed class ConcurrentStackFormatter<T> : CollectionFormatterBase<T, T[], ConcurrentStack<T>>
{
	protected override int? GetCount(ConcurrentStack<T> sequence)
	{
		return sequence.Count;
	}

	protected override void Add(T[] collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection[collection.Length - 1 - index] = value;
	}

	protected override T[] Create(int count, MessagePackSerializerOptions options)
	{
		if (count != 0)
		{
			return new T[count];
		}
		return Array.Empty<T>();
	}

	protected override ConcurrentStack<T> Complete(T[] intermediateCollection)
	{
		return new ConcurrentStack<T>(intermediateCollection);
	}
}
