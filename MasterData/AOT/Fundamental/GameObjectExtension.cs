using System.Collections.Generic;
using UnityEngine;

public static class GameObjectExtension
{
	private static Queue<Transform> s_queue = new Queue<Transform>(32);

	public static bool SafeSetActive(this GameObject gameObject, bool active)
	{
		bool result = false;
		if (gameObject.activeSelf != active)
		{
			gameObject.SetActive(active);
			result = true;
		}
		return result;
	}

	public static bool SafeSetLocalScale(this GameObject gameObject, bool active)
	{
		bool result = false;
		Vector3 vector = (active ? Vector3.one : Vector3.zero);
		if (gameObject.transform.localScale != vector)
		{
			gameObject.transform.localScale = vector;
			result = true;
		}
		return result;
	}

	public static Transform FindNode(Transform root, string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return root;
		}
		if (root != null && root.name == name && root.gameObject.activeInHierarchy)
		{
			return root;
		}
		s_queue.Clear();
		s_queue.Enqueue(root);
		while (s_queue.Count > 0)
		{
			Transform transform = s_queue.Dequeue();
			Transform transform2 = transform.Find(name);
			if (transform2 != null && transform2.gameObject.activeInHierarchy)
			{
				s_queue.Clear();
				return transform2;
			}
			for (int i = 0; i < transform.childCount; i++)
			{
				s_queue.Enqueue(transform.GetChild(i));
			}
		}
		return null;
	}

	public static GameObject FindNodeGameObject(Transform root, string name)
	{
		Transform transform = FindNode(root, name);
		if (!(transform != null))
		{
			return null;
		}
		return transform.gameObject;
	}
}
