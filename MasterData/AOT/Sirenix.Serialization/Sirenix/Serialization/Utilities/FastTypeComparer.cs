using System;
using System.Collections.Generic;

namespace Sirenix.Serialization.Utilities;

public class FastTypeComparer : IEqualityComparer<Type>
{
	public static readonly FastTypeComparer Instance = new FastTypeComparer();

	public bool Equals(Type x, Type y)
	{
		if ((object)x == y)
		{
			return true;
		}
		return x == y;
	}

	public int GetHashCode(Type obj)
	{
		return obj.GetHashCode();
	}
}
