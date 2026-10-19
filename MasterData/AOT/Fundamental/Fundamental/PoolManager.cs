using System.Collections.Generic;
using UnityEngine;

namespace Fundamental;

public class PoolManager
{
	private static PoolManager instance;

	public Dictionary<string, List<GameObject>> pool;

	public static PoolManager GetInstance
	{
		get
		{
			if (instance == null)
			{
				instance = new PoolManager();
			}
			return instance;
		}
	}

	private PoolManager()
	{
		pool = new Dictionary<string, List<GameObject>>();
	}

	public void PushObj(string name, GameObject obj)
	{
		if (pool.TryGetValue(name, out var value))
		{
			value.Add(obj);
			return;
		}
		value = new List<GameObject>();
		value.Add(obj);
		pool.Add(name, value);
	}

	public GameObject GetObj(string name)
	{
		if (pool.TryGetValue(name, out var value) && value.Count > 0)
		{
			GameObject result = value[0];
			value.RemoveAt(0);
			return result;
		}
		return null;
	}

	public void Clear()
	{
		foreach (KeyValuePair<string, List<GameObject>> item in pool)
		{
			foreach (GameObject item2 in item.Value)
			{
				Object.Destroy(item2);
			}
			item.Value.Clear();
		}
		pool.Clear();
	}
}
