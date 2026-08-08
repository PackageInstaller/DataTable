using System.Collections.Concurrent;

namespace MessagePack.Formatters;

public sealed class ConcurrentDictionaryFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, ConcurrentDictionary<TKey, TValue>>
{
	protected override void Add(ConcurrentDictionary<TKey, TValue> collection, int index, TKey key, TValue value, MessagePackSerializerOptions options)
	{
		collection.TryAdd(key, value);
	}

	protected override ConcurrentDictionary<TKey, TValue> Create(int count, MessagePackSerializerOptions options)
	{
		return new ConcurrentDictionary<TKey, TValue>(options.Security.GetEqualityComparer<TKey>());
	}
}
