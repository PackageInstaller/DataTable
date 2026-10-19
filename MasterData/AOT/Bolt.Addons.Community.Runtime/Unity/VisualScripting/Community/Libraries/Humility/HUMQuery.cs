using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMQuery
{
	public static class Data
	{
		public struct For<T>(IList<T> collection)
		{
			public IList<T> collection = collection;
		}
	}

	public static IEnumerable<T> Each<T>(this Data.For<T> forData, Action<T> action)
	{
		foreach (T item in forData.collection)
		{
			action(item);
		}
		return forData.collection;
	}

	public static Data.For<T> For<T>(this IList<T> collection, Action<IList<T>, int> action)
	{
		for (int i = 0; i < collection.Count; i++)
		{
			action(collection, i);
		}
		return new Data.For<T>(collection);
	}

	public static Data.For<T> For<T>(this IList<T> collection)
	{
		return new Data.For<T>(collection);
	}

	public static TKey[] KeysToArray<TKey, TValue>(this Dictionary<TKey, TValue> dictionary)
	{
		return dictionary.Keys.ToArray();
	}

	public static List<TKey> KeysToList<TKey, TValue>(this Dictionary<TKey, TValue> dictionary)
	{
		return dictionary.Keys.ToList();
	}

	public static TValue[] ValuesToArray<TKey, TValue>(this Dictionary<TKey, TValue> dictionary)
	{
		return dictionary.Values.ToArray();
	}

	public static List<TValue> ValuesToList<TKey, TValue>(this Dictionary<TKey, TValue> dictionary)
	{
		return dictionary.Values.ToList();
	}

	public static TValue Define<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, Dictionary<TKey, TValue> deserializedDictionary, TKey key, Func<TValue, TValue> onCreated, Action<TValue> exists)
	{
		TValue arg = (TValue)HUMValue.Create().New(typeof(TValue));
		if (deserializedDictionary.ContainsKey(key))
		{
			arg = deserializedDictionary[key];
			exists?.DynamicInvoke(arg);
		}
		else
		{
			arg = onCreated(arg);
			dictionary.Add(key, arg);
		}
		return arg;
	}

	public static TValue DefineValueByKey<TValue>(this Dictionary<Type, TValue> dictionary, Dictionary<Type, TValue> deserializedDictionary, Type key, Func<TValue, TValue> onCreated, Action<TValue> exists)
	{
		TValue arg = (TValue)HUMValue.Create().New(key);
		if (deserializedDictionary.ContainsKey(key))
		{
			arg = deserializedDictionary[key];
			exists?.DynamicInvoke(arg);
		}
		else
		{
			arg = onCreated(arg);
			dictionary.Add(key, arg);
		}
		return arg;
	}

	public static void Undefine<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, Dictionary<TKey, TValue> deserializedDictionary, Action<TValue> onRemoved)
	{
		List<TKey> list = deserializedDictionary.Keys.ToList();
		deserializedDictionary.Values.ToList();
		for (int i = 0; i < deserializedDictionary.Count; i++)
		{
			if (!dictionary.ContainsKey(list[i]))
			{
				TValue obj = deserializedDictionary[list[i]];
				deserializedDictionary.Remove(list[i]);
				onRemoved(obj);
			}
		}
	}

	public static void Undefine<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, Dictionary<TKey, TValue> deserializedDictionary, Action<TValue> onRemoved, ref bool isNew)
	{
		if (!isNew)
		{
			List<TKey> list = deserializedDictionary.Keys.ToList();
			deserializedDictionary.Values.ToList();
			for (int i = 0; i < deserializedDictionary.Count; i++)
			{
				if (!dictionary.ContainsKey(list[i]))
				{
					TValue obj = deserializedDictionary[list[i]];
					deserializedDictionary.Remove(list[i]);
					onRemoved(obj);
				}
			}
		}
		isNew = true;
	}

	public static void MergeUnique<T>(this List<T> list, List<T> other)
	{
		for (int i = 0; i < other?.Count; i++)
		{
			if (!list.Contains(other[i]))
			{
				list.Add(other[i]);
			}
		}
	}

	public static void RemoveUnmatched<T>(this List<T> list, List<T> checkList)
	{
		List<T> list2 = new List<T>();
		for (int i = 0; i < list.Count; i++)
		{
			for (int j = 0; j < checkList.Count; j++)
			{
				if (!checkList.Contains(list[i]))
				{
					list2.Add(list[i]);
				}
			}
		}
		for (int k = 0; k < list2.Count; k++)
		{
			list.Remove(list2[k]);
		}
	}

	public static void RemoveUnmatchedTypes<T>(this List<T> list, List<T> checkList)
	{
		List<T> list2 = new List<T>();
		List<Type> list3 = new List<Type>();
		for (int i = 0; i < checkList.Count; i++)
		{
			list3.Add(checkList[i].GetType());
		}
		for (int j = 0; j < list.Count; j++)
		{
			bool flag = false;
			for (int k = 0; k < list3.Count; k++)
			{
				if (list[j].GetType() == list3[k])
				{
					flag = true;
				}
			}
			if (!flag)
			{
				list2.Add(list[j]);
			}
		}
		for (int l = 0; l < list2.Count; l++)
		{
			list.Remove(list2[l]);
		}
	}

	public static void AddNonContainedTypes<T>(this List<T> list, List<T> checkList)
	{
		List<Type> list2 = new List<Type>();
		List<T> list3 = new List<T>();
		for (int i = 0; i < checkList.Count; i++)
		{
			list2.Add(checkList[i].GetType());
		}
		for (int j = 0; j < list.Count; j++)
		{
			bool flag = false;
			for (int k = 0; k < list2.Count; k++)
			{
				if (list[j].GetType() == list2[k])
				{
					flag = true;
				}
			}
			if (!flag)
			{
				list3.Add(checkList[j]);
			}
		}
		for (int l = 0; l < list3.Count; l++)
		{
			list.Add(list3[l]);
		}
	}
}
