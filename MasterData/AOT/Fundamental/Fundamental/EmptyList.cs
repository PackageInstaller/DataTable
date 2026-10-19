using System.Collections.Generic;

namespace Fundamental;

public class EmptyList<T> : List<T>
{
	public static readonly EmptyList<T> Instance = new EmptyList<T>();

	public static readonly T[] Array = new T[0];

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

	public new T this[int index]
	{
		get
		{
			return default;
		}
		set
		{
		}
	}

	private EmptyList()
	{
	}

	public new void Add(T item)
	{
	}

	public new void AddRange(IEnumerable<T> collection)
	{
	}
}
