using System.Collections.Generic;

public class Int16Comparer : IEqualityComparer<short>
{
	public bool Equals(short x, short y)
	{
		return x == y;
	}

	public int GetHashCode(short obj)
	{
		return obj;
	}
}
