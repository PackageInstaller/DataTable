using System.Collections.Generic;

public class MultiKeyDictionary<T1, T2, T3> : Dictionary<T1, Dictionary<T2, T3>>
{
	public new Dictionary<T2, T3> this[T1 key]
	{
		get
		{
			if (!ContainsKey(key))
			{
				Add(key, new Dictionary<T2, T3>());
			}
			TryGetValue(key, out var value);
			return value;
		}
	}

	public bool ContainsKey(T1 key1, T2 key2)
	{
		TryGetValue(key1, out var value);
		return value?.ContainsKey(key2) ?? false;
	}
}
