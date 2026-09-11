using System;
using System.Collections.Generic;

namespace MessagePack.Formatters;

[Obsolete("Use InterfaceCollectionFormatter2 instead.")]
public sealed class InterfaceCollectionFormatter<T> : CollectionFormatterBase<T, T[], ICollection<T>>
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

	protected override ICollection<T> Complete(T[] intermediateCollection)
	{
		return intermediateCollection;
	}
}
