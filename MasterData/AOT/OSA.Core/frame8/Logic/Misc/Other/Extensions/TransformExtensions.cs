using System;
using System.Collections.Generic;
using UnityEngine;

namespace frame8.Logic.Misc.Other.Extensions;

public static class TransformExtensions
{
	public static void GetComponentAtPath<T>(this Transform transform, string path, out T foundComponent) where T : Component
	{
		Transform transform2 = null;
		if (path == null)
		{
			foreach (Transform item in transform)
			{
				T component = item.GetComponent<T>();
				if (component != null)
				{
					foundComponent = component;
					return;
				}
			}
		}
		else
		{
			transform2 = transform.Find(path);
		}
		if (transform2 == null)
		{
			foundComponent = null;
		}
		else
		{
			foundComponent = transform2.GetComponent<T>();
		}
	}

	public static T GetComponentAtPath<T>(this Transform transform, string path) where T : Component
	{
		transform.GetComponentAtPath<T>(path, out var foundComponent);
		return foundComponent;
	}

	public static Transform[] GetChildren(this Transform tr)
	{
		int childCount = tr.childCount;
		Transform[] array = new Transform[childCount];
		for (int i = 0; i < childCount; i++)
		{
			array[i] = tr.GetChild(i);
		}
		return array;
	}

	public static List<Transform> GetChildrenExcept(this Transform tr, Func<Transform, bool> except)
	{
		int childCount = tr.childCount;
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < childCount; i++)
		{
			Transform child = tr.GetChild(i);
			if (except == null || !except(child))
			{
				list.Add(child);
			}
		}
		return list;
	}

	public static List<T> GetComponentsInDirectChildren<T>(this Transform tr) where T : Component
	{
		List<T> list = new List<T>();
		Transform[] children = tr.GetChildren();
		for (int i = 0; i < children.Length; i++)
		{
			T component = children[i].GetComponent<T>();
			if ((bool)component)
			{
				list.Add(component);
			}
		}
		return list;
	}

	public static void GetEnoughChildrenToFitInArray(this Transform tr, Transform[] array)
	{
		int num = array.Length;
		for (int i = 0; i < num; i++)
		{
			array[i] = tr.GetChild(i);
		}
	}

	public static List<Transform> GetDescendants(this Transform tr)
	{
		return tr.GetDescendantsExcept(null);
	}

	public static List<Transform> GetDescendantsExcept(this Transform tr, Func<Transform, bool> except)
	{
		IList<Transform> list = ((except != null) ? tr.GetChildrenExcept(except) : tr.GetDescendants());
		List<Transform> list2 = new List<Transform>();
		for (int i = 0; i < list.Count; i++)
		{
			Transform transform = list[i];
			if (except == null || !except(transform))
			{
				list2.Add(transform);
			}
		}
		int count = list.Count;
		for (int j = 0; j < count; j++)
		{
			List<Transform> descendantsExcept = list[j].GetDescendantsExcept(except);
			list2.AddRange(descendantsExcept);
		}
		return list2;
	}

	public static bool IsAncestorOf(this Transform tr, Transform other)
	{
		if (tr == null)
		{
			throw new ArgumentNullException("tr");
		}
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		while ((bool)(other = other.parent))
		{
			if (other == tr)
			{
				return true;
			}
		}
		return false;
	}

	public static void GetDescendantsAndRelativePaths(this Transform tr, ref Dictionary<Transform, string> mapDescendantToPath)
	{
		tr.GetDescendantsAndRelativePaths("", ref mapDescendantToPath);
	}

	private static void GetDescendantsAndRelativePaths(this Transform tr, string currentPath, ref Dictionary<Transform, string> mapDescendantToPath)
	{
		Transform[] children = tr.GetChildren();
		int num = children.Length;
		for (int i = 0; i < num; i++)
		{
			Transform transform = children[i];
			string text = currentPath + "/" + transform.name;
			mapDescendantToPath[transform] = text;
			transform.GetDescendantsAndRelativePaths(text, ref mapDescendantToPath);
		}
	}

	public static int GetNumberOfAncestors(this Transform tr)
	{
		int num = 0;
		while ((bool)(tr = tr.parent))
		{
			num++;
		}
		return num;
	}
}
