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

	public static bool TryAdd<TKey, TValue>(this IDictionary<TKey, TValue> dictionary, TKey key, TValue value)
	{
		if (dictionary == null)
		{
			throw new ArgumentNullException("dictionary");
		}
		if (!dictionary.ContainsKey(key))
		{
			dictionary.Add(key, value);
			return true;
		}
		return false;
	}

	public static bool Remove<TKey, TValue>(this IDictionary<TKey, TValue> dictionary, TKey key, out TValue value)
	{
		if (dictionary == null)
		{
			throw new ArgumentNullException("dictionary");
		}
		if (dictionary.TryGetValue(key, out value))
		{
			dictionary.Remove(key);
			return true;
		}
		value = default(TValue);
		return false;
	}
}
