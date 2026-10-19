using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Unity.VisualScripting;

public class ReferenceEqualityComparer : IEqualityComparer<object>
{
	public static readonly ReferenceEqualityComparer Instance = new ReferenceEqualityComparer();

	private ReferenceEqualityComparer()
	{
	}

	bool IEqualityComparer<object>.Equals(object a, object b)
	{
		return a == b;
	}

	int IEqualityComparer<object>.GetHashCode(object a)
	{
		return GetHashCode(a);
	}

	public static int GetHashCode(object a)
	{
		return RuntimeHelpers.GetHashCode(a);
	}
}
public class ReferenceEqualityComparer<T> : IEqualityComparer<T>
{
	public static readonly ReferenceEqualityComparer<T> Instance = new ReferenceEqualityComparer<T>();

	private ReferenceEqualityComparer()
	{
	}

	bool IEqualityComparer<T>.Equals(T a, T b)
	{
		return (object)a == (object)b;
	}

	int IEqualityComparer<T>.GetHashCode(T a)
	{
		return GetHashCode(a);
	}

	public static int GetHashCode(T a)
	{
		return RuntimeHelpers.GetHashCode(a);
	}
}
