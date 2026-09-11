using System.Collections.Generic;
using UnityEngine;

public class AssetObjectPool
{
	private Dictionary<GameObject, ResourceCache> pool = new Dictionary<GameObject, ResourceCache>();

	private Dictionary<GameObject, ResourceCache> dontDestroypool = new Dictionary<GameObject, ResourceCache>();

	private Dictionary<string, GameObject> cachePrefabs = new Dictionary<string, GameObject>();

	private Dictionary<string, GameObject> dontDestroyCachePrefabs = new Dictionary<string, GameObject>();

	private ResourceCache TryGetCache(GameObject prefab, int size, bool isDontDestroy = false)
	{
		if (dontDestroypool.TryGetValue(prefab, out var value))
		{
			return value;
		}
		if (pool.TryGetValue(prefab, out value))
		{
			if (isDontDestroy)
			{
				value.Dispose();
				value = new ResourceCache(prefab, size, isDontDestroy);
				dontDestroypool.Add(prefab, value);
			}
			return value;
		}
		if (!isDontDestroy)
		{
			value = new ResourceCache(prefab, size);
			pool.Add(prefab, value);
		}
		else
		{
			value = new ResourceCache(prefab, size, isDontDestroy);
			dontDestroypool.Add(prefab, value);
		}
		return value;
	}

	public GameObject GetOrCreate(GameObject prefab, bool active = false, bool isDontDestroy = false)
	{
		if (prefab == null)
		{
			return null;
		}
		Debug.Log("GetOrCreate prefab == " + prefab.name);
		ResourceCache resourceCache = TryGetCache(prefab, 1, isDontDestroy);
		if (resourceCache != null)
		{
			return resourceCache.Get(active);
		}
		return Object.Instantiate(prefab);
	}

	public bool SetAssetPath(string path, bool isDontDestroy)
	{
		Dictionary<string, GameObject> obj = (isDontDestroy ? dontDestroyCachePrefabs : cachePrefabs);
		GameObject value = null;
		if (!obj.TryGetValue(path, out value))
		{
			Debug.LogError("path:" + path + " prefab is empty!!!!");
			return false;
		}
		if (!(isDontDestroy ? dontDestroypool : pool).TryGetValue(value, out var value2))
		{
			Debug.LogError("path:" + path + " cache is empty!!!!");
			return false;
		}
		if (value2 != null)
		{
			value2.assetPath = path;
			return true;
		}
		return false;
	}

	public bool RemoveCacheByPath(string path, bool isDontDestroy)
	{
		Dictionary<string, GameObject> dictionary = (isDontDestroy ? dontDestroyCachePrefabs : cachePrefabs);
		GameObject value = null;
		if (!dictionary.TryGetValue(path, out value))
		{
			return false;
		}
		dictionary.Remove(path);
		Dictionary<GameObject, ResourceCache> dictionary2 = (isDontDestroy ? dontDestroypool : pool);
		if (!dictionary2.TryGetValue(value, out var _))
		{
			return false;
		}
		return dictionary2.Remove(value);
	}

	public GameObject GetOrCreate(string path, bool active = false, bool isDontDestroy = false)
	{
		GameObject value = null;
		if (!dontDestroyCachePrefabs.TryGetValue(path, out value) && !cachePrefabs.TryGetValue(path, out value))
		{
			value = Asset.Load<GameObject>(path, isDontDestroy);
			if (value == null)
			{
				Debug.LogError("1 path:" + path + " prefab is empty!!!!");
				return null;
			}
			(isDontDestroy ? dontDestroyCachePrefabs : cachePrefabs)[path] = value;
		}
		return TryGetCache(value, 1, isDontDestroy)?.Get(active);
	}

	public void Cache(GameObject prefab, int size = 1, bool donDestroy = false)
	{
		if (!(prefab == null))
		{
			PooledAsset component = prefab.GetComponent<PooledAsset>();
			if (component != null)
			{
				Object.DestroyImmediate(component, allowDestroyingAssets: true);
				component = null;
			}
			TryGetCache(prefab, size, donDestroy);
		}
	}

	public void Cache(string path, int size = 1, bool isDontDestroy = false)
	{
		Dictionary<string, GameObject> dictionary = (isDontDestroy ? dontDestroyCachePrefabs : cachePrefabs);
		GameObject value = null;
		if (!dictionary.TryGetValue(path, out value))
		{
			value = Asset.Load<GameObject>(path, isDontDestroy);
			if (value == null)
			{
				Debug.LogError("2 path:" + path + " prefab is empty!!!!");
				return;
			}
			dictionary.Add(path, value);
		}
		TryGetCache(value, size, isDontDestroy);
	}

	public void Cache(string path, GameObject prefab, int size = 1, bool isDontDestroy = false)
	{
		if (prefab == null || string.IsNullOrEmpty(path))
		{
			Debug.LogError("3 path:" + path + " prefab is empty!!!!");
			return;
		}
		(isDontDestroy ? dontDestroyCachePrefabs : cachePrefabs)[path] = prefab;
		TryGetCache(prefab, size, isDontDestroy);
	}

	public void RemoveDontDestroyCache(string path)
	{
		if (!dontDestroyCachePrefabs.TryGetValue(path, out var value))
		{
			return;
		}
		Asset.Unload(path, isDontDestroy: true);
		dontDestroyCachePrefabs.Remove(path);
		if (dontDestroypool.TryGetValue(value, out var value2))
		{
			dontDestroypool.Remove(value);
			if (value2 != null)
			{
				value2.ReturnAll();
				value2.Dispose();
			}
		}
	}

	public void RemovePrefabCache(string path)
	{
		if (cachePrefabs.TryGetValue(path, out var _))
		{
			cachePrefabs.Remove(path);
		}
	}

	public void MoveToDontDestroyCache(string path)
	{
		GameObject value = null;
		if (!cachePrefabs.TryGetValue(path, out value))
		{
			Debug.LogError("path:" + path + " prefab is no cache!!!!");
			return;
		}
		if (dontDestroypool.ContainsKey(value))
		{
			Debug.LogError("path:" + path + " prefab is already in dont destroy!!!!");
			return;
		}
		dontDestroypool.Add(value, pool[value]);
		pool.Remove(value);
	}

	public void ReturnAll()
	{
		foreach (KeyValuePair<GameObject, ResourceCache> item in dontDestroypool)
		{
			item.Value.ReturnAll();
		}
		foreach (KeyValuePair<GameObject, ResourceCache> item2 in pool)
		{
			item2.Value.ReturnAll();
		}
	}

	public void Destroy()
	{
		foreach (KeyValuePair<GameObject, ResourceCache> item in dontDestroypool)
		{
			item.Value.ReturnAll();
		}
		Debug.Log("==============>>>Destroy cache Pool");
		Dictionary<GameObject, ResourceCache>.Enumerator enumerator2 = pool.GetEnumerator();
		while (enumerator2.MoveNext())
		{
			enumerator2.Current.Value.Dispose();
		}
		pool.Clear();
		cachePrefabs.Clear();
	}
}
