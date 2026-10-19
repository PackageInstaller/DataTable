using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

public static class LinqUtility
{
	public static IEnumerable<T> Concat<T>(params IEnumerable[] enumerables)
	{
		foreach (IEnumerable item in enumerables.NotNull())
		{
			foreach (T item2 in item.OfType<T>())
			{
				yield return item2;
			}
		}
	}

	public static IEnumerable<T> DistinctBy<T, TKey>(this IEnumerable<T> items, Func<T, TKey> property)
	{
		return from x in items.GroupBy(property)
			select x.First();
	}

	public static IEnumerable<T> NotNull<T>(this IEnumerable<T> enumerable)
	{
		return enumerable.Where((T i) => i != null);
	}

	public static IEnumerable<T> Yield<T>(this T t)
	{
		yield return t;
	}

	public static HashSet<T> ToHashSet<T>(this IEnumerable<T> enumerable)
	{
		return new HashSet<T>(enumerable);
	}

	public static void AddRange<T>(this ICollection<T> collection, IEnumerable<T> items)
	{
		foreach (T item in items)
		{
			collection.Add(item);
		}
	}

	public static void AddRange(this IList list, IEnumerable items)
	{
		foreach (object item in items)
		{
			list.Add(item);
		}
	}

	public static ICollection<T> AsReadOnlyCollection<T>(this IEnumerable<T> enumerable)
	{
		if (enumerable is ICollection<T>)
		{
			return (ICollection<T>)enumerable;
		}
		return enumerable.ToList().AsReadOnly();
	}

	public static IList<T> AsReadOnlyList<T>(this IEnumerable<T> enumerable)
	{
		if (enumerable is IList<T>)
		{
			return (IList<T>)enumerable;
		}
		return enumerable.ToList().AsReadOnly();
	}

	public static IEnumerable<T> Flatten<T>(this IEnumerable<T> source, Func<T, IEnumerable<T>> childrenSelector)
	{
		IEnumerable<T> enumerable = source;
		foreach (T item in source)
		{
			enumerable = enumerable.Concat(childrenSelector(item).Flatten(childrenSelector));
		}
		return enumerable;
	}

	public static IEnumerable<T> IntersectAll<T>(this IEnumerable<IEnumerable<T>> groups)
	{
		HashSet<T> hashSet = null;
		foreach (IEnumerable<T> group in groups)
		{
			if (hashSet == null)
			{
				hashSet = new HashSet<T>(group);
			}
			else
			{
				hashSet.IntersectWith(group);
			}
		}
		if (hashSet != null)
		{
			return hashSet.AsEnumerable();
		}
		return Enumerable.Empty<T>();
	}

	public static IEnumerable<T> OrderByDependencies<T>(this IEnumerable<T> source, Func<T, IEnumerable<T>> getDependencies, bool throwOnCycle = true)
	{
		List<T> list = new List<T>();
		HashSet<T> hashSet = HashSetPool<T>.New();
		foreach (T item in source)
		{
			OrderByDependenciesVisit(item, hashSet, list, getDependencies, throwOnCycle);
		}
		HashSetPool<T>.Free(hashSet);
		return list;
	}

	private static void OrderByDependenciesVisit<T>(T item, HashSet<T> visited, List<T> sorted, Func<T, IEnumerable<T>> getDependencies, bool throwOnCycle)
	{
		if (!visited.Contains(item))
		{
			visited.Add(item);
			foreach (T item2 in getDependencies(item))
			{
				OrderByDependenciesVisit(item2, visited, sorted, getDependencies, throwOnCycle);
			}
			sorted.Add(item);
		}
		else if (throwOnCycle && !sorted.Contains(item))
		{
			throw new InvalidOperationException("Cyclic dependency.");
		}
	}

	public static IEnumerable<T> OrderByDependers<T>(this IEnumerable<T> source, Func<T, IEnumerable<T>> getDependers, bool throwOnCycle = true)
	{
		Dictionary<T, HashSet<T>> dependencies = new Dictionary<T, HashSet<T>>();
		foreach (T item in source)
		{
			foreach (T item2 in getDependers(item))
			{
				if (!dependencies.ContainsKey(item2))
				{
					dependencies.Add(item2, new HashSet<T>());
				}
				dependencies[item2].Add(item);
			}
		}
		return source.OrderByDependencies((T depender) => dependencies.ContainsKey(depender) ? dependencies[depender] : Enumerable.Empty<T>(), throwOnCycle);
	}

	public static IEnumerable<T> Catch<T>(this IEnumerable<T> source, Action<Exception> @catch)
	{
		Ensure.That("source").IsNotNull(source);
		using IEnumerator<T> enumerator = source.GetEnumerator();
		bool success;
		do
		{
			try
			{
				success = enumerator.MoveNext();
			}
			catch (OperationCanceledException)
			{
				yield break;
			}
			catch (Exception obj)
			{
				@catch?.Invoke(obj);
				success = false;
			}
			if (success)
			{
				yield return enumerator.Current;
			}
		}
		while (success);
	}

	public static IEnumerable<T> Catch<T>(this IEnumerable<T> source, ICollection<Exception> exceptions)
	{
		Ensure.That("exceptions").IsNotNull(exceptions);
		return source.Catch(exceptions.Add);
	}

	public static IEnumerable<T> CatchAsLogError<T>(this IEnumerable<T> source, string message)
	{
		return source.Catch((Exception ex) =>
		{
			Debug.LogError(message + "\n" + ex.ToString());
		});
	}

	public static IEnumerable<T> CatchAsLogWarning<T>(this IEnumerable<T> source, string message)
	{
		return source.Catch((Exception ex) =>
		{
			Debug.LogWarning(message + "\n" + ex.ToString());
		});
	}
}
