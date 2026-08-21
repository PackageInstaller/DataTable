using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class InterfaceReadOnlyDictionaryFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, Dictionary<TKey, TValue>, IReadOnlyDictionary<TKey, TValue>>
{
	protected override void Add(Dictionary<TKey, TValue> collection, int index, TKey key, TValue value, MessagePackSerializerOptions options)
	{
		collection.Add(key, value);
	}

	protected override IReadOnlyDictionary<TKey, TValue> Complete(Dictionary<TKey, TValue> intermediateCollection)
	{
		return intermediateCollection;
	}

	protected override Dictionary<TKey, TValue> Create(int count, MessagePackSerializerOptions options)
	{
		return new Dictionary<TKey, TValue>(count, options.Security.GetEqualityComparer<TKey>());
	}
}
