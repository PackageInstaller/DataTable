using System;
using System.Collections.Generic;
using UnityEngine;

public class AsyncAsset<T> : IPool, IAsyncAsset where T : UnityEngine.Object
{
	public struct AsyncResult
	{
		public AsyncInstantiateOperation<GameObject> op;

		public GameObject gameObject;

		public Action<GameObject> callback;

		public AsyncAsset<GameObject> asset;
	}

	private AssetBundleObject m_abObject;

	private AsyncOperationAsset<T> m_selfOp;

	private string m_assetName;

	private bool m_isABMode;

	private List<GameObject> _runningInstances = new List<GameObject>();

	public List<GameObject> _pool;

	public string GetAssetName()
	{
		return m_assetName;
	}

	public int GetRefCount()
	{
		if (m_selfOp == null)
		{
			return 0;
		}
		return m_selfOp.refCount;
	}

	public T Block()
	{
		if (m_isABMode)
		{
			m_abObject.Block();
		}
		else
		{
			m_selfOp.OnABCompleted();
		}
		return GetAsset();
	}

	public AsyncAsset(string assetName, AssetBundleObject ab, bool isABMode)
	{
		m_abObject = ab;
		m_assetName = assetName;
		m_isABMode = isABMode;
	}

	public bool IsDone()
	{
		return m_selfOp.IsDone();
	}

	public T GetAsset()
	{
		if (m_selfOp == null)
		{
			Debug.LogError("大概率是使用有问题，请检查下是否上层存在引用错误！");
			return null;
		}
		if (m_selfOp.IsDone())
		{
			return m_selfOp.m_asset;
		}
		return m_selfOp.GetOp().asset as T;
	}

	public AsyncOperationAsset<T> LoadAsync()
	{
		if (m_selfOp == null)
		{
			m_selfOp = new AsyncOperationAsset<T>(m_assetName, m_abObject, m_isABMode);
		}
		m_selfOp.IncreaseRefCount();
		return m_selfOp;
	}

	public bool Release()
	{
		if (m_selfOp == null)
		{
			return true;
		}
		if (m_selfOp.DecrementRefCount() <= 0)
		{
			if (m_selfOp.IsDone())
			{
				m_selfOp.Release();
				m_selfOp = null;
				return true;
			}
			Debug.LogError("无法释放正在异步载入的资源！");
		}
		return false;
	}

	private GameObject PoolDequeue()
	{
		int index = _pool.Count - 1;
		GameObject result = _pool[index];
		_pool.RemoveAt(index);
		return result;
	}

	private void PoolEnqueue(GameObject inObject)
	{
		_pool.Add(inObject);
	}

	public bool TryUnloadInstance()
	{
		bool result = false;
		if (typeof(T) != typeof(GameObject))
		{
			return result;
		}
		if (_pool != null && _pool.Count > 0)
		{
			foreach (GameObject item in _pool)
			{
				if (item != null)
				{
					return false;
				}
			}
			_pool.Clear();
			Debug.LogError("出现了大量池化对象为空，有bug请检查写法！！");
		}
		result = _runningInstances.Count == 0;
		for (int i = 0; i < _runningInstances.Count; i++)
		{
			if (_runningInstances[i] != null)
			{
				return false;
			}
		}
		if (_runningInstances.Count > 0)
		{
			_runningInstances.Clear();
			result = true;
		}
		return result;
	}

	public bool HasReturn(GameObject inObject)
	{
		if (_pool == null)
		{
			return false;
		}
		return _pool.Contains(inObject);
	}

	public void ReturnPool(GameObject go)
	{
		if (go == null)
		{
			return;
		}
		if (_pool == null)
		{
			_pool = new List<GameObject>(16);
		}
		if (!_pool.Contains(go))
		{
			if (_runningInstances.Contains(go))
			{
				_runningInstances.Remove(go);
			}
			if (go.transform is RectTransform)
			{
				go.transform.SetParent(null, worldPositionStays: false);
			}
			else if (go.transform.parent != null)
			{
				go.transform.parent = null;
			}
			PooledAssetV2 component = go.GetComponent<PooledAssetV2>();
			if (component != null)
			{
				component.SetActive(active: false);
				PoolEnqueue(go);
			}
			else
			{
				Debug.LogError("返回非poolasset标记对象！");
			}
		}
	}

	public void Remove(GameObject inObject)
	{
		if (_pool != null)
		{
			_pool.Remove(inObject);
		}
	}

	public void Destroy(GameObject go)
	{
	}

	public AsyncResult InstantiateAsync(Transform parent)
	{
		AsyncResult result = default(AsyncResult);
		if (_pool == null || _pool.Count <= 0)
		{
			AsyncInstantiateOperation<GameObject> asyncInstantiateOperation = (result.op = UnityEngine.Object.InstantiateAsync(GetAsset() as GameObject, parent));
			result.gameObject = null;
			asyncInstantiateOperation.completed += OnCompletedHandler;
		}
		else
		{
			GameObject gameObject = PoolDequeue();
			if (gameObject == null)
			{
				int num = 0;
				foreach (GameObject item in _pool)
				{
					if (item == null)
					{
						num++;
					}
				}
				Debug.LogError($"{m_assetName} 的pool对象被意外删除！！！！池子里空对象的数量 {num}/{_pool.Count}");
			}
			result.gameObject = gameObject;
			if (PooledAsset.mPoolTable.TryGetValue(gameObject, out var value))
			{
				value.SetActive(active: true);
			}
			OnCompletedHandler(gameObject);
		}
		result.asset = this as AsyncAsset<GameObject>;
		return result;
	}

	private void OnCompletedHandler(AsyncOperation op)
	{
		UnityEngine.Object[] result = (op as AsyncInstantiateOperation).Result;
		foreach (UnityEngine.Object obj in result)
		{
			_runningInstances.Add(obj as GameObject);
			InitPooledAsset(obj as GameObject);
		}
	}

	public AsyncResult Instantiate(Transform parent)
	{
		AsyncResult result = default(AsyncResult);
		GameObject gameObject = null;
		if (_pool == null || _pool.Count <= 0)
		{
			gameObject = UnityEngine.Object.Instantiate(GetAsset() as GameObject, parent);
		}
		else
		{
			gameObject = PoolDequeue();
			if (gameObject == null)
			{
				int num = 0;
				foreach (GameObject item in _pool)
				{
					if (item == null)
					{
						num++;
					}
				}
				Debug.LogError($"{m_assetName} 的pool对象被意外删除！！！！池子里空对象的数量 {num}/{_pool.Count}");
			}
			PooledAssetV2 component = gameObject.GetComponent<PooledAssetV2>();
			if (component != null)
			{
				component.SetActive(active: true);
				component.transform.parent = parent;
			}
		}
		result.gameObject = gameObject;
		OnCompletedHandler(gameObject);
		result.asset = this as AsyncAsset<GameObject>;
		return result;
	}

	public void Cache(Transform parent)
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(GetAsset() as GameObject, parent);
		PooledAssetV2 pooledAssetV = gameObject.GetComponent<PooledAssetV2>();
		if (pooledAssetV == null)
		{
			pooledAssetV = gameObject.AddComponent<PooledAssetV2>();
		}
		pooledAssetV.mLinkCache = this;
		ReturnPool(gameObject);
	}

	private void OnCompletedHandler(GameObject go)
	{
		_runningInstances.Add(go);
		InitPooledAsset(go);
	}

	private void InitPooledAsset(GameObject go)
	{
		if (go == null)
		{
			Debug.LogError("InitPooledAsset " + m_assetName + " 的对象为空！！！！");
			return;
		}
		if (!go.TryGetComponent<PooledAssetV2>(out var component))
		{
			component = go.AddComponent<PooledAssetV2>();
		}
		component.mLinkCache = this;
	}
}
