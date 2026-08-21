using System;
using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class InterfaceReadOnlyCollectionFormatter<T> : CollectionFormatterBase<T, T[], IReadOnlyCollection<T>>
{
	protected override void Add(T[] collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection[index] = value;
	}

	protected override T[] Create(int count, MessagePackSerializerOptions options)
	{
		if (count != 0)
		{
			return new T[count];
		}
		return Array.Empty<T>();
	}

	protected override IReadOnlyCollection<T> Complete(T[] intermediateCollection)
	{
		return intermediateCollection;
	}
}
