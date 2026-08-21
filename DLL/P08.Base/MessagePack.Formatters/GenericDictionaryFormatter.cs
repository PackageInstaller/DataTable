using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class GenericDictionaryFormatter<TKey, TValue, TDictionary> : DictionaryFormatterBase<TKey, TValue, TDictionary> where TDictionary : IDictionary<TKey, TValue>, new()
{
	protected override void Add(TDictionary collection, int index, TKey key, TValue value, MessagePackSerializerOptions options)
	{
		collection.Add(key, value);
	}

	protected override TDictionary Create(int count, MessagePackSerializerOptions options)
	{
		return CollectionHelpers<TDictionary, IEqualityComparer<TKey>>.CreateHashCollection(count, options.Security.GetEqualityComparer<TKey>());
	}
}
