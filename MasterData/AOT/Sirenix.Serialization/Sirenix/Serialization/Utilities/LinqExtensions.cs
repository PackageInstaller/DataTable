using System;
using System.Collections.Generic;

namespace Sirenix.Serialization.Utilities;

internal static class LinqExtensions
{
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

	public static IEnumerable<T> Append<T>(this IEnumerable<T> source, IEnumerable<T> append)
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
}
