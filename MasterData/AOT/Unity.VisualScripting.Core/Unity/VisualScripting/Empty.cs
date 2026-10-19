using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class Empty<T>
{
	public static readonly T[] array = new T[0];

	public static readonly List<T> list = new List<T>(0);

	public static readonly HashSet<T> hashSet = new HashSet<T>();
}
