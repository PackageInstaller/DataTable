using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Sirenix.Utilities;

public static class LinqExtensions
{
	public static IEnumerable<T> Examine<T>(this IEnumerable<T> source, Action<T> action)
	{
		foreach (T item in source)
		{
			action(item);
			yield return item;
		}
	}

	public static IEnumerable<T> ForEach<T>(this IEnumerable<T> source, Action<T> action)
	{
		foreach (T item in source)
		{
			action(item);
		}
		return source;
	}

	public static IEnumerable<T> ForEach<T>(this IEnumerable<T> source, Action<T, int> action)
	{
		int num = 0;
		foreach (T item in source)
		{
			action(item, num++);
		}
		return source;
	}

	public static IEnumerable<T> Convert<T>(this IEnumerable source, Func<object, T> converter)
	{
		foreach (object item in source)
		{
			yield return converter(item);
		}
	}

	public static ImmutableList<T> ToImmutableList<T>(this IEnumerable<T> source)
	{
		IList<T> list = source as IList<T>;
		if (list == null)
		{
			list = source.ToArray();
		}
		return new ImmutableList<T>(list);
	}

	public static IEnumerable<T> PrependWith<T>(this IEnumerable<T> source, Func<T> prepend)
	{
		yield return prepend();
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependWith<T>(this IEnumerable<T> source, T prepend)
	{
		yield return prepend;
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependWith<T>(this IEnumerable<T> source, IEnumerable<T> prepend)
	{
		foreach (T item in prepend)
		{
			yield return item;
		}
		foreach (T item2 in source)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, bool condition, Func<T> prepend)
	{
		if (condition)
		{
			yield return prepend();
		}
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, bool condition, T prepend)
	{
		if (condition)
		{
			yield return prepend;
		}
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, bool condition, IEnumerable<T> prepend)
	{
		if (condition)
		{
			foreach (T item in prepend)
			{
				yield return item;
			}
		}
		foreach (T item2 in source)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, Func<bool> condition, Func<T> prepend)
	{
		if (condition())
		{
			yield return prepend();
		}
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, Func<bool> condition, T prepend)
	{
		if (condition())
		{
			yield return prepend;
		}
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, Func<bool> condition, IEnumerable<T> prepend)
	{
		if (condition())
		{
			foreach (T item in prepend)
			{
				yield return item;
			}
		}
		foreach (T item2 in source)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, Func<IEnumerable<T>, bool> condition, Func<T> prepend)
	{
		if (condition(source))
		{
			yield return prepend();
		}
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, Func<IEnumerable<T>, bool> condition, T prepend)
	{
		if (condition(source))
		{
			yield return prepend;
		}
		foreach (T item in source)
		{
			yield return item;
		}
	}

	public static IEnumerable<T> PrependIf<T>(this IEnumerable<T> source, Func<IEnumerable<T>, bool> condition, IEnumerable<T> prepend)
	{
		if (condition(source))
		{
			foreach (T item in prepend)
			{
				yield return item;
			}
		}
		foreach (T item2 in source)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> AppendWith<T>(this IEnumerable<T> source, Func<T> append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		yield return append();
	}

	public static IEnumerable<T> AppendWith<T>(this IEnumerable<T> source, T append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		yield return append;
	}

	public static IEnumerable<T> AppendWith<T>(this IEnumerable<T> source, IEnumerable<T> append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		foreach (T item2 in append)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> AppendIf<T>(this IEnumerable<T> source, bool condition, Func<T> append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		if (condition)
		{
			yield return append();
		}
	}

	public static IEnumerable<T> AppendIf<T>(this IEnumerable<T> source, bool condition, T append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		if (condition)
		{
			yield return append;
		}
	}

	public static IEnumerable<T> AppendIf<T>(this IEnumerable<T> source, bool condition, IEnumerable<T> append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		if (!condition)
		{
			yield break;
		}
		foreach (T item2 in append)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> AppendIf<T>(this IEnumerable<T> source, Func<bool> condition, Func<T> append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		if (condition())
		{
			yield return append();
		}
	}

	public static IEnumerable<T> AppendIf<T>(this IEnumerable<T> source, Func<bool> condition, T append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		if (condition())
		{
			yield return append;
		}
	}

	public static IEnumerable<T> AppendIf<T>(this IEnumerable<T> source, Func<bool> condition, IEnumerable<T> append)
	{
		foreach (T item in source)
		{
			yield return item;
		}
		if (!condition())
		{
			yield break;
		}
		foreach (T item2 in append)
		{
			yield return item2;
		}
	}

	public static IEnumerable<T> FilterCast<T>(this IEnumerable source)
	{
		foreach (object item in source)
		{
			if (item is T)
			{
				yield return (T)item;
			}
		}
	}

	public static void AddRange<T>(this HashSet<T> hashSet, IEnumerable<T> range)
	{
		foreach (T item in range)
		{
			hashSet.Add(item);
		}
	}

	public static bool IsNullOrEmpty<T>(this IList<T> list)
	{
		if (list != null)
		{
			return list.Count == 0;
		}
		return true;
	}

	public static void Populate<T>(this IList<T> list, T item)
	{
		int count = list.Count;
		for (int i = 0; i < count; i++)
		{
			list[i] = item;
		}
	}

	public static void AddRange<T>(this IList<T> list, IEnumerable<T> collection)
	{
		if (list is List<T>)
		{
			((List<T>)list).AddRange(collection);
			return;
		}
		foreach (T item in collection)
		{
			list.Add(item);
		}
	}

	public static void Sort<T>(this IList<T> list, Comparison<T> comparison)
	{
		if (list is List<T>)
		{
			((List<T>)list).Sort(comparison);
			return;
		}
		List<T> list2 = new List<T>(list);
		list2.Sort(comparison);
		for (int i = 0; i < list.Count; i++)
		{
			list[i] = list2[i];
		}
	}

	public static void Sort<T>(this IList<T> list)
	{
		if (list is List<T>)
		{
			((List<T>)list).Sort();
			return;
		}
		List<T> list2 = new List<T>(list);
		list2.Sort();
		for (int i = 0; i < list.Count; i++)
		{
			list[i] = list2[i];
		}
	}
}
