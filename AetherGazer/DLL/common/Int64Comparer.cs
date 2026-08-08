using System.Collections.Generic;

public class Int64Comparer : IEqualityComparer<long>
{
	public bool Equals(long x, long y)
	{
		return x == y;
	}

	public int GetHashCode(long obj)
	{
		return (int)obj;
	}
}
