using System.Collections.Generic;

namespace Ase.Serializing.Helping;

public class Comparers
{
	public static bool EqualityCompare<T>(T a, T b)
	{
		return EqualityComparer<T>.Default.Equals(a, b);
	}

	public static bool IsDefault<T>(T t)
	{
		return t.Equals(default(T));
	}

	public static bool IsEqualityCompareDefault<T>(T a)
	{
		return EqualityComparer<T>.Default.Equals(a, default(T));
	}
}
