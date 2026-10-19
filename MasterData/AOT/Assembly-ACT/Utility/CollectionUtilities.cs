using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using Google.Protobuf.Collections;

namespace Utility;

public static class CollectionUtilities
{
	public static T GetValueOrDefault<T>(this T[] arr, int index, T defaultValue)
	{
		if (index < 0 || index >= arr.Length)
		{
			return defaultValue;
		}
		return arr[index];
	}

	public static void ForEach<T>(this IEnumerable<T> col, Action<T> action)
	{
		foreach (T item in col)
		{
			action(item);
		}
	}

	public static void ForEach<T>(this IEnumerable<T> col, Action<int, T> action)
	{
		int num = 0;
		foreach (T item in col)
		{
			action(num, item);
			num++;
		}
	}

	public static IEnumerable<T> WhereNotNull<T>(this IEnumerable<T> col)
	{
		return col.OfType<T>();
	}

	public static ObservableCollection<T> ToObservableCollection<T>(this IEnumerable<T> enumerable)
	{
		ObservableCollection<T> ob = new ObservableCollection<T>();
		enumerable.ForEach((T item) =>
		{
			ob.Add(item);
		});
		return ob;
	}

	public static string ToCollectionString(this IEnumerable e, string separator = ", ", string prefix = "{", string suffix = "}")
	{
		return prefix + string.Join(separator, e) + suffix;
	}

	public static string ToCollectionString(this IEnumerable<object> e, string separator = ", ", string prefix = "{", string suffix = "}")
	{
		return prefix + string.Join(separator, e.Select((object o) => o.ToString())) + suffix;
	}

	public static void AddRange<T>(this ICollection<T> collection, IEnumerable<T> items)
	{
		if (items == null)
		{
			throw new ArgumentNullException("items");
		}
		items.ForEach(collection.Add);
	}

	public static T Find<T>(this ICollection<T> collection, Predicate<T> predicate)
	{
		foreach (T item in collection)
		{
			if (predicate(item))
			{
				return item;
			}
		}
		return default;
	}

	public static void InsertRange(this IList col, int index, IEnumerable range)
	{
		foreach (object item in range)
		{
			col.Insert(index++, item);
		}
	}

	public static void RemoveAll<T>(this Collection<T> col, Predicate<T> predicate)
	{
		col.Where((T i) => predicate(i)).ToList().ForEach((T i) =>
		{
			col.Remove(i);
		});
	}

	public static void Move(this IList col, int oldIndex, int newIndex)
	{
		object value = col[oldIndex];
		col.RemoveAt(oldIndex);
		col.Insert(newIndex, value);
	}

	public static T RandomItem<T>(this IList<T> col)
	{
		int index = new Random().Next(col.Count);
		return col[index];
	}

	public static bool IsEmpty<T>(IEnumerable<T> collection)
	{
		if (collection != null)
		{
			return !collection.Any();
		}
		return true;
	}

	public static bool HasDuplicate<T>(this IEnumerable<T> collection)
	{
		return collection.Distinct().Count() < collection.Count();
	}

	public static void RemoveRange<T>(this Collection<T> collection, IEnumerable<T> toRemove)
	{
		collection.RemoveAll(toRemove.Contains);
	}

	public static void RemoveLast<T>(this IList<T> list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (list.Any())
		{
			list.RemoveAt(list.Count - 1);
		}
	}

	public static void RemoveLast<T>(this Collection<T> list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (list.Any())
		{
			list.RemoveAt(list.Count - 1);
		}
	}

	public static (IEnumerable<T> Satisfied, IEnumerable<T> NotSatisfied) Split<T>(this IEnumerable<T> list, Func<T, bool> predicate)
	{
		IEnumerable<T> enumerable = list.Where(predicate);
		IEnumerable<T> item = list.Except(enumerable);
		return (Satisfied: enumerable, NotSatisfied: item);
	}

	public static IEnumerable CloneItemsAsPossible(this IEnumerable source)
	{
		foreach (object item in source)
		{
			if (item is ICloneable cloneable)
			{
				yield return cloneable.Clone();
			}
			else
			{
				yield return item;
			}
		}
	}

	public static Type GetElementType(this IEnumerable enumerable)
	{
		return enumerable?.GetType().GetGenericArguments().FirstOrDefault();
	}

	public static Type GetElementType(this IList enumerable)
	{
		return enumerable?.GetType().GetGenericArguments().FirstOrDefault();
	}

	public static RepeatedField<T> ToRepeatedField<T>(this IEnumerable<T> source)
	{
		RepeatedField<T> repeatedField = new RepeatedField<T>();
		repeatedField.AddRange(source);
		return repeatedField;
	}
}
