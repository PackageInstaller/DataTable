using System;
using System.Collections.Generic;

namespace MessagePack.Formatters;

[Obsolete("Use InterfaceListFormatter2 instead.")]
public sealed class InterfaceListFormatter<T> : CollectionFormatterBase<T, T[], IList<T>>
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

	protected override IList<T> Complete(T[] intermediateCollection)
	{
		return intermediateCollection;
	}
}
