#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public static class CollectionUtility
{
	private static System.Random rng = new System.Random();

	public static bool IsNullOrEmpty<T>(this ICollection<T> collection)
	{
		if (collection != null)
		{
			return collection.Count == 0;
		}
		return true;
	}

	public static T Pop<T>(this List<T> list, int index = 0)
	{
		T result = list[index];
		list.RemoveAt(index);
		return result;
	}

	public static void Shuffle<T>(this IList<T> list)
	{
		int num = list.Count;
		while (num > 1)
		{
			num--;
			int index = rng.Next(num + 1);
			T value = list[index];
			list[index] = list[num];
			list[num] = value;
		}
	}

	public static void Shuffle<T>(this IList<T> list, BaseEntity baseEntity)
	{
		if (baseEntity == null)
		{
			Log.Error("Shuffle Err: entity is null");
			return;
		}
		int num = list.Count;
		while (num > 1)
		{
			num--;
			int index = baseEntity.RandomInt(0, num + 1);
			T value = list[index];
			list[index] = list[num];
			list[num] = value;
		}
	}

	public static void Foreach<T>(this LinkedList<T> List, Action<LinkedListNode<T>> action)
	{
		LinkedListNode<T> linkedListNode = List.First;
		if (linkedListNode != null)
		{
			while (linkedListNode != null)
			{
				LinkedListNode<T> obj = linkedListNode;
				linkedListNode = linkedListNode.Next;
				action(obj);
			}
		}
	}

	public static T GetValue<T>(this List<T> list, ref int index)
	{
		T result = list[index];
		index++;
		if (index >= list.Count)
		{
			index = 0;
		}
		return result;
	}

	public static T GetRandomValue<T>(this List<T> list)
	{
		if (list.Count <= 0)
		{
			return default(T);
		}
		return list[UnityEngine.Random.Range(0, list.Count)];
	}

	public static Vector3 ToVector3(this List<float> list)
	{
		if (list.Count <= 0)
		{
			return Vector3.zero;
		}
		if (list.Count >= 3)
		{
			return new Vector3(list[0], list[1], list[2]);
		}
		if (list.Count == 2)
		{
			return new Vector3(list[0], list[1], 0f);
		}
		return new Vector3(list[0], 0f, 0f);
	}

	public static Vector2 ToVector2(this List<float> list)
	{
		if (list.Count <= 0)
		{
			return Vector3.zero;
		}
		if (list.Count >= 2)
		{
			return new Vector2(list[0], list[1]);
		}
		return new Vector2(list[0], 0f);
	}

	public static int IndexOf<T>(this IEnumerable<T> collection, Func<T, bool> predicate)
	{
		int num = 0;
		foreach (T item in collection)
		{
			if (predicate(item))
			{
				return num;
			}
			num++;
		}
		return -1;
	}

	public static void ShellSort<Collider>(this Collider[] list, Comparison<Collider> compareBiggerFunc)
	{
		int num = list.Length;
		int num2;
		for (num2 = 1; num2 < num / 3; num2 = 3 * num2 + 1)
		{
		}
		while (num2 >= 1)
		{
			for (int i = num2; i < num; i++)
			{
				Collider val = list[i];
				int num3 = i;
				while (num3 >= num2 && compareBiggerFunc(list[num3 - num2], val) > 0)
				{
					list[num3] = list[num3 - num2];
					num3 -= num2;
				}
				list[num3] = val;
			}
			num2 /= 3;
		}
	}

	public static bool HasCommonWith<T>(this ICollection<T> first, ICollection<T> second, IEqualityComparer<T> comparer = null)
	{
		if (first == null || second == null || first.Count == 0 || second.Count == 0)
		{
			return false;
		}
		ICollection<T> collection = ((first.Count <= second.Count) ? first : second);
		ICollection<T> collection2 = ((first.Count > second.Count) ? first : second);
		HashSet<T> hashSet = new HashSet<T>(collection, comparer ?? EqualityComparer<T>.Default);
		foreach (T item in collection2)
		{
			if (hashSet.Contains(item))
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsEqualIgnoreOrder<T>(this List<T> list1, List<T> list2, IEqualityComparer<T> comparer = null)
	{
		if (list1.Count != list2.Count)
		{
			return false;
		}
		Dictionary<T, int> dictionary = new Dictionary<T, int>(comparer ?? EqualityComparer<T>.Default);
		foreach (T item in list1)
		{
			if (!dictionary.ContainsKey(item))
			{
				dictionary[item] = 0;
			}
			dictionary[item]++;
		}
		foreach (T item2 in list2)
		{
			if (!dictionary.ContainsKey(item2))
			{
				return false;
			}
			dictionary[item2]--;
			if (dictionary[item2] < 0)
			{
				return false;
			}
		}
		return true;
	}

	public static bool IsEqual<T>(this IList<T> first, IList<T> second, IEqualityComparer<T> comparer = null)
	{
		if (first == null || second == null)
		{
			return false;
		}
		if (first.Count != second.Count)
		{
			return false;
		}
		return first.SequenceEqual(second, comparer ?? EqualityComparer<T>.Default);
	}
}
