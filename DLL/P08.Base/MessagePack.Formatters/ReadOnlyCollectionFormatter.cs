using System;
using System.Collections.ObjectModel;

namespace MessagePack.Formatters;

public sealed class ReadOnlyCollectionFormatter<T> : CollectionFormatterBase<T, T[], ReadOnlyCollection<T>>
{
	protected override void Add(T[] collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection[index] = value;
	}

	protected override ReadOnlyCollection<T> Complete(T[] intermediateCollection)
	{
		return new ReadOnlyCollection<T>(intermediateCollection);
	}

	protected override T[] Create(int count, MessagePackSerializerOptions options)
	{
		if (count != 0)
		{
			return new T[count];
		}
		return Array.Empty<T>();
	}
}
