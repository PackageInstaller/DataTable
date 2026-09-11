namespace System.Collections.Generic;

public static class CollectionExtensions
{
	public static TValue GetValueOrDefault<TKey, TValue>(this IReadOnlyDictionary<TKey, TValue> dictionary, TKey key)
	{
		return dictionary.GetValueOrDefault(key, default(TValue));
	}

	public static TValue GetValueOrDefault<TKey, TValue>(this IReadOnlyDictionary<TKey, TValue> dictionary, TKey key, TValue defaultValue)
	{
		if (dictionary == null)
		{
			throw new ArgumentNullException("dictionary");
		}
		if (!dictionary.TryGetValue(key, out var value))
		{
			return defaultValue;
		}
		return value;
	}
}
