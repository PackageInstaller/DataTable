using System;
using System.Collections.Generic;

namespace Sirenix.Utilities;

public static class ListExtensions
{
	public static void SetLength<T>(ref IList<T> list, int length)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (length < 0)
		{
			throw new ArgumentException("Length must be larger than or equal to 0.");
		}
		if (list.GetType().IsArray)
		{
			if (list.Count != length)
			{
				T[] array = (T[])list;
				Array.Resize(ref array, length);
				list = array;
			}
		}
		else
		{
			while (list.Count < length)
			{
				list.Add(default);
			}
			while (list.Count > length)
			{
				list.RemoveAt(list.Count - 1);
			}
		}
	}

	public static void SetLength<T>(ref IList<T> list, int length, Func<T> newElement)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (length < 0)
		{
			throw new ArgumentException("Length must be larger than or equal to 0.");
		}
		if (newElement == null)
		{
			throw new ArgumentNullException("newElement");
		}
		if (list.GetType().IsArray)
		{
			if (list.Count != length)
			{
				T[] array = (T[])list;
				Array.Resize(ref array, length);
				list = array;
			}
		}
		else
		{
			while (list.Count < length)
			{
				list.Add(newElement());
			}
			while (list.Count > length)
			{
				list.RemoveAt(list.Count - 1);
			}
		}
	}

	public static void SetLength<T>(this IList<T> list, int length)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (length < 0)
		{
			throw new ArgumentException("Length must be larger than or equal to 0.");
		}
		if (list.GetType().IsArray)
		{
			throw new ArgumentException("Cannot use the SetLength extension method on an array. Use Array.Resize or the ListUtilities.SetLength(ref IList<T> list, int length) overload.");
		}
		while (list.Count < length)
		{
			list.Add(default);
		}
		while (list.Count > length)
		{
			list.RemoveAt(list.Count - 1);
		}
	}

	public static void SetLength<T>(this IList<T> list, int length, Func<T> newElement)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (length < 0)
		{
			throw new ArgumentException("Length must be larger than or equal to 0.");
		}
		if (newElement == null)
		{
			throw new ArgumentNullException("newElement");
		}
		if (list.GetType().IsArray)
		{
			throw new ArgumentException("Cannot use the SetLength extension method on an array. Use Array.Resize or the ListUtilities.SetLength(ref IList<T> list, int length) overload.");
		}
		while (list.Count < length)
		{
			list.Add(newElement());
		}
		while (list.Count > length)
		{
			list.RemoveAt(list.Count - 1);
		}
	}
}
