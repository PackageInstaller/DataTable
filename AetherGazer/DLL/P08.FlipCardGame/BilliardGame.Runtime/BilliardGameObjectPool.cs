using System;
using System.Collections.Generic;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameObjectPool
{
	private static BilliardGameObjectPool instance;

	private Dictionary<string, Queue<GameObject>> objectPool = new Dictionary<string, Queue<GameObject>>();

	private Dictionary<string, GameObject> prefabPool = new Dictionary<string, GameObject>();

	private GameObject pool;

	public static BilliardGameObjectPool Instance
	{
		get
		{
			if (instance == null)
			{
				instance = new BilliardGameObjectPool();
			}
			return instance;
		}
	}

	public static void Dispose()
	{
		if (instance != null)
		{
			instance.objectPool.Clear();
			instance = null;
			GC.Collect();
		}
	}

	public GameObject GetPrefabByPath(string prefabPath)
	{
		prefabPool.TryGetValue(prefabPath, out var value);
		if (value == null)
		{
			value = Asset.Instantiate(prefabPath);
			string name = value.name.Replace("(Clone)1", string.Empty);
			value.name = name;
			prefabPool.Add(prefabPath, value);
			value.transform.parent = pool.transform;
			value.SetActive(value: false);
		}
		return value;
	}

	public void PreloadBullets(string prefabPath, int count)
	{
		if (pool == null)
		{
			pool = BilliardGameLogicManager.Instance.BulletRootTrs.gameObject;
		}
		GameObject prefabByPath = GetPrefabByPath(prefabPath);
		string name = prefabByPath.name;
		GameObject gameObject = GameObject.Find(name + "Pool");
		if (!gameObject)
		{
			gameObject = new GameObject(name + "Pool");
			gameObject.transform.SetParent(pool.transform);
		}
		for (int i = 0; i < count; i++)
		{
			GameObject gameObject2 = UnityEngine.Object.Instantiate(prefabByPath);
			gameObject2.transform.SetParent(gameObject.transform);
			PushObject(gameObject2);
		}
	}

	public GameObject GetObject(string prefabPath)
	{
		if (pool == null)
		{
			pool = BilliardGameLogicManager.Instance.BulletRootTrs.gameObject;
		}
		GameObject prefabByPath = GetPrefabByPath(prefabPath);
		GameObject gameObject;
		if (!objectPool.ContainsKey(prefabByPath.name) || objectPool[prefabByPath.name].Count == 0)
		{
			gameObject = UnityEngine.Object.Instantiate(prefabByPath);
			PushObject(gameObject);
			GameObject gameObject2 = GameObject.Find(prefabByPath.name + "Pool");
			if (!gameObject2)
			{
				gameObject2 = new GameObject(prefabByPath.name + "Pool");
				gameObject2.transform.SetParent(pool.transform);
			}
			gameObject.transform.SetParent(gameObject2.transform);
		}
		gameObject = objectPool[prefabByPath.name].Dequeue();
		gameObject.SetActive(value: true);
		return gameObject;
	}

	public void PushObject(GameObject prefab)
	{
		string key = prefab.name.Replace("(Clone)", string.Empty);
		if (!objectPool.ContainsKey(key))
		{
			objectPool.Add(key, new Queue<GameObject>());
		}
		objectPool[key].Enqueue(prefab);
		prefab.SetActive(value: false);
	}
}
