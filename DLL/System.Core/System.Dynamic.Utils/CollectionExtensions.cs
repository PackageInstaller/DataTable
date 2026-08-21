using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Runtime.CompilerServices;

namespace System.Dynamic.Utils;

internal static class CollectionExtensions
{
	public static TrueReadOnlyCollection<T> AddFirst<T>(this ReadOnlyCollection<T> list, T item)
	{
		T[] array = new T[list.Count + 1];
		array[0] = item;
		list.CopyTo(array, 1);
		return new TrueReadOnlyCollection<T>(array);
	}

	public static T[] AddFirst<T>(this T[] array, T item)
	{
		T[] array2 = new T[array.Length + 1];
		array2[0] = item;
		array.CopyTo(array2, 1);
		return array2;
	}

	public static T[] AddLast<T>(this T[] array, T item)
	{
		T[] array2 = new T[array.Length + 1];
		array.CopyTo(array2, 0);
		array2[array.Length] = item;
		return array2;
	}

	public static T[] RemoveFirst<T>(this T[] array)
	{
		T[] array2 = new T[array.Length - 1];
		Array.Copy(array, 1, array2, 0, array2.Length);
		return array2;
	}

	public static T[] RemoveLast<T>(this T[] array)
	{
		T[] array2 = new T[array.Length - 1];
		Array.Copy(array, 0, array2, 0, array2.Length);
		return array2;
	}

	public static ReadOnlyCollection<T> ToReadOnly<T>(this IEnumerable<T> enumerable)
	{
		if (enumerable == null)
		{
			return EmptyReadOnlyCollection<T>.Instance;
		}
		if (enumerable is TrueReadOnlyCollection<T> result)
		{
			return result;
		}
		if (enumerable is ReadOnlyCollectionBuilder<T> readOnlyCollectionBuilder)
		{
			return readOnlyCollectionBuilder.ToReadOnlyCollection();
		}
		T[] array = enumerable.ToArray();
		if (array.Length != 0)
		{
			return new TrueReadOnlyCollection<T>(array);
		}
		return EmptyReadOnlyCollection<T>.Instance;
	}

	public static int ListHashCode<T>(this ReadOnlyCollection<T> list)
	{
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		int num = 6551;
		foreach (T item in list)
		{
			num ^= (num << 5) ^ equalityComparer.GetHashCode(item);
		}
		return num;
	}

	public static bool ListEquals<T>(this ReadOnlyCollection<T> first, ReadOnlyCollection<T> second)
	{
		if (first == second)
		{
			return true;
		}
		int count = first.Count;
		if (count != second.Count)
		{
			return false;
		}
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		for (int i = 0; i != count; i++)
		{
			if (!equalityComparer.Equals(first[i], second[i]))
			{
				return false;
			}
		}
		return true;
	}
}
