using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle.Configs;
using ACT.Config;
using UnityEngine;

namespace ACT.Utility;

public static class CustomExtension
{
	public static bool TryGetConfigByName(this List<OverrideConfigMotion> list, ConfigMotion key, out ConfigMotion configMotion)
	{
		configMotion = null;
		if (list == null || key == null)
		{
			return false;
		}
		foreach (OverrideConfigMotion item in list)
		{
			if (item.key == key)
			{
				configMotion = item.over;
				return true;
			}
		}
		return false;
	}

	public static bool TryGetConfigByName(this ConfigAnimState[] array, string name, out ConfigAnimState config, out int index)
	{
		config = null;
		for (index = 0; index < array.Length; index++)
		{
			ConfigAnimState configAnimState = array[index];
			if (configAnimState.name == name)
			{
				config = configAnimState;
				return true;
			}
		}
		return false;
	}

	public static bool TryGetConfigByName(this ConfigAnimStateMachine[] array, string name, out ConfigAnimStateMachine config)
	{
		config = null;
		foreach (ConfigAnimStateMachine configAnimStateMachine in array)
		{
			if (configAnimStateMachine.name == name)
			{
				config = configAnimStateMachine;
				return true;
			}
		}
		return false;
	}

	public static int GetRandom(this IList<int> list, IList<int> weights)
	{
		int num = weights.Sum();
		int num2 = UnityEngine.Random.Range(0, num);
		int num3 = 0;
		for (int i = 0; i < list.Count; i++)
		{
			num3 += weights[i];
			if (num2 < num3)
			{
				return list[i];
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"not found?{num} {num2} {num3}");
		}
		return list[0];
	}

	public static ItemKv GetRandom(this List<Maybe> list)
	{
		Maybe random = list.GetRandom((Maybe e) => e.weight);
		return new ItemKv(random.id, random.count);
	}

	public static int GetRandom(this List<ItemKv> list)
	{
		return list.GetRandom((ItemKv e) => e.count).id;
	}

	public static int GetRandomIndex<T>(this IList<T> list, Func<T, int> weightSelecter)
	{
		int num = UnityEngine.Random.Range(0, list.Sum(weightSelecter));
		int num2 = 0;
		for (int i = 0; i < list.Count; i++)
		{
			num2 += weightSelecter(list[i]);
			if (num < num2)
			{
				return i;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("没有随机到，随机数为：" + num);
		}
		return 0;
	}

	public static T GetRandom<T>(this IList<T> list, Func<T, int> weightSelecter)
	{
		int num = UnityEngine.Random.Range(0, list.Sum(weightSelecter));
		int num2 = 0;
		for (int i = 0; i < list.Count; i++)
		{
			num2 += weightSelecter(list[i]);
			if (num < num2)
			{
				return list[i];
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("没有随机到，随机数为：" + num);
		}
		return default;
	}

	public static float Height(this AnimationCurve curve)
	{
		if (curve.length == 0)
		{
			return 0f;
		}
		return curve.keys[curve.length - 1].value - curve.keys[0].value;
	}

	public static float NormalizeEvaluate(this AnimationCurve curve, float time)
	{
		return curve.Evaluate(time) / curve.Height();
	}

	public static void Log<T>(this IEnumerable<T> vs, Func<T, object> select = null)
	{
		foreach (T v in vs)
		{
			if (select == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log(v);
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.Log(select(v));
			}
		}
	}

	public static TResult[] SelectAsArray<T, TResult>(this ICollection<T> ts, Func<T, TResult> select)
	{
		TResult[] array = new TResult[ts.Count];
		int num = 0;
		foreach (T t in ts)
		{
			array[num] = select(t);
			num++;
		}
		return array;
	}

	public static List<TResult> SelectAsList<T, TResult>(this ICollection<T> ts, Func<T, TResult> select)
	{
		List<TResult> list = new List<TResult>(ts.Count);
		foreach (T t in ts)
		{
			list.Add(select(t));
		}
		return list;
	}

	public static T GetOrAddComponent<T>(this GameObject uo) where T : Component
	{
		return uo.GetComponent<T>() ?? uo.AddComponent<T>();
	}

	public static bool TryAddComponent<T>(this GameObject uo) where T : Component
	{
		if ((object)uo.GetComponent<T>() == null)
		{
			uo.AddComponent<T>();
			return true;
		}
		return false;
	}

	public static void SetVisible(this CanvasGroup canvasGroup, bool visible)
	{
		if ((bool)canvasGroup)
		{
			canvasGroup.alpha = (visible ? 1f : 0f);
			canvasGroup.interactable = visible;
			canvasGroup.blocksRaycasts = visible;
		}
	}

	public static void AddRange<T>(this ICollection<T> collection, IEnumerable<T> items)
	{
		if (items == null)
		{
			return;
		}
		foreach (T item in items)
		{
			collection.Add(item);
		}
	}

	public static void AddRange<T>(this ICollection<T> collection, IList<T> items)
	{
		if (items != null)
		{
			for (int i = 0; i < items.Count; i++)
			{
				collection.Add(items[i]);
			}
		}
	}

	public static void AddRange<T>(this ICollection<T> collection, List<T> items)
	{
		if (items != null)
		{
			for (int i = 0; i < items.Count; i++)
			{
				collection.Add(items[i]);
			}
		}
	}

	public static void AddRange<T>(this ICollection<T> collection, T[] items)
	{
		if (items != null)
		{
			for (int i = 0; i < items.Length; i++)
			{
				collection.Add(items[i]);
			}
		}
	}

	public static void AddRange<TKey, TValue>(this Dictionary<TKey, TValue> collection, Dictionary<TKey, TValue> items)
	{
		if (items == null)
		{
			return;
		}
		foreach (KeyValuePair<TKey, TValue> item in items)
		{
			collection.Add(item.Key, item.Value);
		}
	}
}
