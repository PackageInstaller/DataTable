using System;
using System.Collections.Generic;
using UnityEngine;

public class ResourceCache : IDisposable
{
	public string assetPath;

	private GameObject prefab;

	private List<GameObject> freeObjects = new List<GameObject>();

	private int initialCacheSize;

	private int currentTotalSize;

	private bool isDontDestroy;

	private Dictionary<GameObject, IPoolActive> _poolActives = new Dictionary<GameObject, IPoolActive>();

	public ResourceCache(GameObject inPrefab, int inInitialCacheSize, bool dontDestroy = false)
	{
		assetPath = string.Empty;
		initialCacheSize = inInitialCacheSize;
		prefab = inPrefab;
		if (initialCacheSize > 0)
		{
			CreateResources(initialCacheSize, dontDestroy);
		}
	}

	~ResourceCache()
	{
	}

	public GameObject Get(bool active)
	{
		if (freeObjects.Count == 0)
		{
			if (_poolActives.Count > 0)
			{
				GameObject gameObject = null;
				float num = -2.1474836E+09f;
				bool flag = false;
				foreach (KeyValuePair<GameObject, IPoolActive> poolActive in _poolActives)
				{
					if (poolActive.Value.mSimulatorTime > num)
					{
						num = poolActive.Value.mSimulatorTime;
						gameObject = poolActive.Key;
						flag = poolActive.Value.mReuseOldestGameobject;
					}
				}
				if (gameObject == null || !flag)
				{
					CreateResources(Mathf.Max(1, initialCacheSize), isDontDestroy);
				}
				else
				{
					_poolActives[gameObject].Stop();
					Return(gameObject);
				}
			}
			else
			{
				CreateResources(Mathf.Max(1, initialCacheSize), isDontDestroy);
			}
		}
		if (freeObjects.Count > 0)
		{
			GameObject gameObject2 = freeObjects[0];
			freeObjects.RemoveAt(0);
			_poolActives[gameObject2].SetActive(active);
			return gameObject2;
		}
		return null;
	}

	public void ReturnAll()
	{
		foreach (KeyValuePair<GameObject, IPoolActive> poolActive in _poolActives)
		{
			Return(poolActive.Key);
		}
	}

	public void Return(GameObject inObject)
	{
		if (!(inObject == null) && freeObjects != null && !freeObjects.Contains(inObject))
		{
			if (inObject.transform is RectTransform)
			{
				inObject.transform.SetParent(null, worldPositionStays: false);
			}
			else if (inObject.transform.parent != null)
			{
				inObject.transform.parent = null;
			}
			SetActive(inObject, active: false);
			freeObjects.Add(inObject);
			if (isDontDestroy)
			{
				UnityEngine.Object.DontDestroyOnLoad(inObject);
			}
		}
	}

	public bool HasReturn(GameObject inObject)
	{
		if (freeObjects == null)
		{
			return false;
		}
		return freeObjects.Contains(inObject);
	}

	public void Remove(GameObject inObject)
	{
		if (!(inObject == null) && freeObjects != null)
		{
			_poolActives.Remove(inObject);
			freeObjects.Remove(inObject);
		}
	}

	public bool CheckEmpty()
	{
		if (_poolActives.Count > 0)
		{
			return false;
		}
		if (!string.IsNullOrEmpty(assetPath))
		{
			Asset.pool.RemoveCacheByPath(assetPath, isDontDestroy);
			Asset.Unload(assetPath, isDontDestroy);
		}
		return true;
	}

	public void Dispose()
	{
		prefab = null;
		if (freeObjects != null)
		{
			for (int i = 0; i < freeObjects.Count; i++)
			{
				_poolActives.Remove(freeObjects[i]);
				UnityEngine.Object.Destroy(freeObjects[i]);
			}
			_poolActives.Clear();
			freeObjects.Clear();
			freeObjects = null;
		}
	}

	public void SetActive(GameObject inst, bool active)
	{
		if (_poolActives.TryGetValue(inst, out var value))
		{
			value.SetActive(active);
		}
	}

	internal void CreateResources(int inNumberOfItems, bool dontDestroy = false)
	{
		if (prefab == null)
		{
			Debug.LogError("Can't initialize ResourceCache for resource: ");
			return;
		}
		isDontDestroy = dontDestroy;
		for (int i = 0; i < inNumberOfItems; i++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(prefab);
			PooledAsset pooledAsset = gameObject.GetComponent<PooledAsset>();
			if (pooledAsset == null)
			{
				pooledAsset = gameObject.AddComponent<PooledAsset>();
			}
			pooledAsset.mLinkCache = this;
			pooledAsset.mDontDestroy = dontDestroy;
			IPoolActive component = gameObject.GetComponent<IPoolActive>();
			component.SetActive(active: false);
			_poolActives.Add(gameObject, component);
			currentTotalSize++;
			gameObject.name += currentTotalSize;
			freeObjects.Add(gameObject);
			if (dontDestroy)
			{
				UnityEngine.Object.DontDestroyOnLoad(gameObject);
			}
			PooledAsset.mPoolTable[gameObject] = pooledAsset;
		}
	}
}
