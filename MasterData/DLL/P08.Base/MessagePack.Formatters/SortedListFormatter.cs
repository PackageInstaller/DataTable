using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class SortedListFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, SortedList<TKey, TValue>>
{
	protected override void Add(SortedList<TKey, TValue> collection, int index, TKey key, TValue value, MessagePackSerializerOptions options)
	{
		collection.Add(key, value);
	}

	protected override SortedList<TKey, TValue> Create(int count, MessagePackSerializerOptions options)
	{
		return new SortedList<TKey, TValue>(count);
	}
}
