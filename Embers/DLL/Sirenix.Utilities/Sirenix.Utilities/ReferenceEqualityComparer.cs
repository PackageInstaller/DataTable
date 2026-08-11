using System;
using System.Collections.Generic;

namespace Sirenix.Utilities;

public class ReferenceEqualityComparer<T> : IEqualityComparer<T> where T : class
{
	public static readonly ReferenceEqualityComparer<T> Default = new ReferenceEqualityComparer<T>();

	public bool Equals(T x, T y)
	{
		return x == y;
	}

	public int GetHashCode(T obj)
	{
		try
		{
			return obj.GetHashCode();
		}
		catch (NullReferenceException)
		{
			return -1;
		}
	}
}
