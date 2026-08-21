using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class SortedDictionaryFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, SortedDictionary<TKey, TValue>, SortedDictionary<TKey, TValue>.Enumerator, SortedDictionary<TKey, TValue>>
{
	protected override void Add(SortedDictionary<TKey, TValue> collection, int index, TKey key, TValue value, MessagePackSerializerOptions options)
	{
		collection.Add(key, value);
	}

	protected override SortedDictionary<TKey, TValue> Complete(SortedDictionary<TKey, TValue> intermediateCollection)
	{
		return intermediateCollection;
	}

	protected override SortedDictionary<TKey, TValue> Create(int count, MessagePackSerializerOptions options)
	{
		return new SortedDictionary<TKey, TValue>();
	}

	protected override SortedDictionary<TKey, TValue>.Enumerator GetSourceEnumerator(SortedDictionary<TKey, TValue> source)
	{
		return source.GetEnumerator();
	}
}
