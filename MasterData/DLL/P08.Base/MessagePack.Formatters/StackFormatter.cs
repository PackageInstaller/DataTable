using System;
using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class StackFormatter<T> : CollectionFormatterBase<T, T[], Stack<T>.Enumerator, Stack<T>>
{
	protected override int? GetCount(Stack<T> sequence)
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

	protected override Stack<T>.Enumerator GetSourceEnumerator(Stack<T> source)
	{
		return source.GetEnumerator();
	}

	protected override Stack<T> Complete(T[] intermediateCollection)
	{
		return new Stack<T>(intermediateCollection);
	}
}
