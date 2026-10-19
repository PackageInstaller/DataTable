using System.Collections.Generic;

namespace Fundamental;

public class EmptyDictionary<TKey, TValue> : Dictionary<TKey, TValue>
{
	public static readonly EmptyDictionary<TKey, TValue> Instance = new EmptyDictionary<TKey, TValue>();

	public new TValue this[TKey key]
	{
		get
		{
			return default;
		}
		set
		{
		}
	}

	private EmptyDictionary()
	{
	}

	public new void Add(TKey key, TValue value)
	{
	}
}
