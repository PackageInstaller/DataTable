using System.Text;

namespace System.Collections.Generic;

public static class KeyValuePair
{
	internal static string PairToString(object key, object value)
	{
		StringBuilder stringBuilder = StringBuilderCache.Acquire();
		stringBuilder.Append('[');
		if (key != null)
		{
			stringBuilder.Append(key);
		}
		stringBuilder.Append(", ");
		if (value != null)
		{
			stringBuilder.Append(value);
		}
		stringBuilder.Append(']');
		return StringBuilderCache.GetStringAndRelease(stringBuilder);
	}
}
[Serializable]
public readonly struct KeyValuePair<TKey, TValue>(TKey key, TValue value)
{
	private readonly TKey key = key;

	private readonly TValue value = value;

	public TKey Key => key;

	public TValue Value => value;

	public override string ToString()
	{
		return KeyValuePair.PairToString(Key, Value);
	}

	public void Deconstruct(out TKey key, out TValue value)
	{
		key = Key;
		value = Value;
	}
}
