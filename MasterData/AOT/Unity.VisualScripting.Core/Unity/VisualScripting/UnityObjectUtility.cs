using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

public static class UnityObjectUtility
{
	public static bool IsDestroyed(this UnityEngine.Object target)
	{
		if ((object)target != null)
		{
			return target == null;
		}
		return false;
	}

	public static bool IsUnityNull(this object obj)
	{
		if (obj != null)
		{
			if (obj is UnityEngine.Object)
			{
				return (UnityEngine.Object)obj == null;
			}
			return false;
		}
		return true;
	}

	public static string ToSafeString(this UnityEngine.Object uo)
	{
		if ((object)uo == null)
		{
			return "(null)";
		}
		if (!UnityThread.allowsAPI)
		{
			return uo.GetType().Name;
		}
		if (uo == null)
		{
			return "(Destroyed)";
		}
		try
		{
			return uo.name;
		}
		catch (Exception ex)
		{
			return "(" + ex.GetType().Name + " in ToString: " + ex.Message + ")";
		}
	}

	public static string ToSafeString(this object obj)
	{
		if (obj == null)
		{
			return "(null)";
		}
		if (obj is UnityEngine.Object uo)
		{
			return uo.ToSafeString();
		}
		try
		{
			return obj.ToString();
		}
		catch (Exception ex)
		{
			return "(" + ex.GetType().Name + " in ToString: " + ex.Message + ")";
		}
	}

	public static T AsUnityNull<T>(this T obj) where T : UnityEngine.Object
	{
		if (obj == null)
		{
			return null;
		}
		return obj;
	}

	public static bool TrulyEqual(UnityEngine.Object a, UnityEngine.Object b)
	{
		if (a != b)
		{
			return false;
		}
		if (a == null != (b == null))
		{
			return false;
		}
		return true;
	}

	public static IEnumerable<T> NotUnityNull<T>(this IEnumerable<T> enumerable) where T : UnityEngine.Object
	{
		return enumerable.Where((T i) => i != null);
	}

	public static IEnumerable<T> FindObjectsOfTypeIncludingInactive<T>()
	{
		for (int i = 0; i < SceneManager.sceneCount; i++)
		{
			Scene sceneAt = SceneManager.GetSceneAt(i);
			if (!sceneAt.isLoaded)
			{
				continue;
			}
			GameObject[] rootGameObjects = sceneAt.GetRootGameObjects();
			foreach (GameObject gameObject in rootGameObjects)
			{
				T[] componentsInChildren = gameObject.GetComponentsInChildren<T>(includeInactive: true);
				for (int k = 0; k < componentsInChildren.Length; k++)
				{
					yield return componentsInChildren[k];
				}
			}
		}
	}
}
