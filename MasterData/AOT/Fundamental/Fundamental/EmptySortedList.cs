using System.Collections.Generic;

namespace Fundamental;

public class EmptySortedList<TKey, TValue> : SortedList<TKey, TValue>
{
	public static readonly EmptySortedList<TKey, TValue> Instance = new EmptySortedList<TKey, TValue>();

	public new int Capacity
	{
		get
		{
			return 0;
		}
		set
		{
		}
	}

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

	private EmptySortedList()
	{
	}

	public new void Add(TKey key, TValue value)
	{
	}
}
