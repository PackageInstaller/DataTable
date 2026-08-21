using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ParadoxNotion;

public static class ObjectUtils
{
	public static bool AnyEquals(object a, object b)
	{
		if ((a is UnityEngine.Object || a == null) && (b is UnityEngine.Object || b == null))
		{
			return a as UnityEngine.Object == b as UnityEngine.Object;
		}
		if (a != b && !object.Equals(a, b))
		{
			return a == b;
		}
		return true;
	}

	public static List<T> Shuffle<T>(this List<T> list)
	{
		for (int num = list.Count - 1; num > 0; num--)
		{
			int index = (int)Mathf.Floor(UnityEngine.Random.value * (float)(num + 1));
			T value = list[num];
			list[num] = list[index];
			list[index] = value;
		}
		return list;
	}

	public static bool Is<T>(this object o, out T result)
	{
		if (o is T)
		{
			result = (T)o;
			return true;
		}
		result = default(T);
		return false;
	}

	public static T GetAddComponent<T>(this GameObject gameObject) where T : Component
	{
		if (gameObject == null)
		{
			return null;
		}
		T val = gameObject.GetComponent<T>();
		if (val == null)
		{
			val = gameObject.AddComponent<T>();
		}
		return val;
	}

	public static Component TransformToType(this Component current, Type type)
	{
		if (current != null && type != null && !type.RTIsAssignableFrom(current.GetType()) && (type.RTIsSubclassOf(typeof(Component)) || type.RTIsInterface()))
		{
			current = current.GetComponent(type);
		}
		return current;
	}

	public static IEnumerable<GameObject> FindGameObjectsWithinLayerMask(LayerMask mask, GameObject exclude = null)
	{
		return from x in UnityEngine.Object.FindObjectsOfType<GameObject>()
			where x != exclude && x.IsInLayerMask(mask)
			select x;
	}

	public static bool IsInLayerMask(this GameObject gameObject, LayerMask mask)
	{
		return (int)mask == ((int)mask | (1 << gameObject.layer));
	}
}
