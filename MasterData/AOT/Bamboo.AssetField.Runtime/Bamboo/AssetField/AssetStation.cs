using System;
using System.Collections.Generic;
using UnityEngine;

namespace Bamboo.AssetField;

public class AssetStation
{
	private readonly int _id;

	private readonly AssetStation _parent;

	private readonly AssetLoader _assetLoader;

	private readonly Dictionary<string, int> _assetIDCountMap = new Dictionary<string, int>();

	private readonly HashSet<AssetStation> _mountStations = new HashSet<AssetStation>();

	private readonly List<AssetLoadHandle> _assetLoadHandles = new List<AssetLoadHandle>();

	private readonly Dictionary<GameObject, AssetLoadHandle> _instancesByObject = new Dictionary<GameObject, AssetLoadHandle>();

	private readonly Dictionary<string, Action> _instanceObjectActions = new Dictionary<string, Action>();

	private bool _isActive;

	private bool _keepCacheInSelf;

	public int ID => _id;

	internal AssetStation(int id, AssetStation parent, AssetLoader assetLoader)
	{
		_id = id;
		_parent = parent;
		_assetLoader = assetLoader;
	}

	public bool Has(string assetID)
	{
		return _assetLoader.Has(assetID);
	}

	internal void AddCounting(string assetID)
	{
		if (_assetIDCountMap.ContainsKey(assetID))
		{
			Dictionary<string, int> assetIDCountMap = _assetIDCountMap;
			int value = assetIDCountMap[assetID] + 1;
			assetIDCountMap[assetID] = value;
		}
		else
		{
			_assetIDCountMap[assetID] = 1;
		}
	}

	private void DecreaseCounting(string assetID)
	{
		if (_assetIDCountMap.TryGetValue(assetID, out var value))
		{
			if (--value == 0)
			{
				_assetIDCountMap.Remove(assetID);
			}
			else
			{
				_assetIDCountMap[assetID] = value;
			}
		}
	}

	public bool AssetExists(string assetID)
	{
		return _assetLoader.AssetExists(assetID);
	}

	public bool TryGetAsset<T>(string assetID, out T asset) where T : UnityEngine.Object
	{
		if (_assetIDCountMap.ContainsKey(assetID) && _assetLoader.TryGetAssetCount(assetID, out var assetCount))
		{
			asset = assetCount.Asset as T;
			return asset != null;
		}
		asset = null;
		return false;
	}

	public AssetLoadHandle Load<T>(string assetID) where T : UnityEngine.Object
	{
		AddCounting(assetID);
		AssetLoadHandle assetLoadHandle;
		try
		{
			assetLoadHandle = _assetLoader.Load<T>(assetID);
		}
		catch (Exception)
		{
			DecreaseCounting(assetID);
			throw;
		}
		if (assetLoadHandle.State == LoadState.Failed)
		{
			DecreaseCounting(assetID);
			return assetLoadHandle;
		}
		_assetLoadHandles.Add(assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle LoadAsync<T>(string assetID, Action<AssetLoadHandle> callback = null) where T : UnityEngine.Object
	{
		AddCounting(assetID);
		AssetLoadHandle assetLoadHandle = _assetLoader.LoadAsync<T>(assetID, callback);
		_assetLoadHandles.Add(assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle Instantiate(string assetID)
	{
		AssetLoadHandle assetLoadHandle = Load<GameObject>(assetID);
		GameObject gameObject = assetLoadHandle.AsGameObject();
		if (null == gameObject)
		{
			return assetLoadHandle;
		}
		GameObject key = (GameObject)(assetLoadHandle.Result = UnityEngine.Object.Instantiate(gameObject));
		_instancesByObject.Add(key, assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle Instantiate(string assetID, Vector3 position, Quaternion rotation)
	{
		AssetLoadHandle assetLoadHandle = Load<GameObject>(assetID);
		GameObject gameObject = assetLoadHandle.AsGameObject();
		if (null == gameObject)
		{
			return assetLoadHandle;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, position, rotation);
		assetLoadHandle.HandleOption.Result = gameObject2;
		_instancesByObject.Add(gameObject2, assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle Instantiate(string assetID, Transform parent, bool instantiateInWorldSpace = false)
	{
		AssetLoadHandle assetLoadHandle = Load<GameObject>(assetID);
		GameObject gameObject = assetLoadHandle.AsGameObject();
		if (null == gameObject)
		{
			return assetLoadHandle;
		}
		GameObject key = (GameObject)(assetLoadHandle.Result = UnityEngine.Object.Instantiate(gameObject, parent, instantiateInWorldSpace));
		_instancesByObject.Add(key, assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle Instantiate(string assetID, Vector3 position, Quaternion rotation, Transform parent)
	{
		AssetLoadHandle assetLoadHandle = Load<GameObject>(assetID);
		GameObject gameObject = assetLoadHandle.AsGameObject();
		if (null == gameObject)
		{
			return assetLoadHandle;
		}
		GameObject key = (GameObject)(assetLoadHandle.Result = UnityEngine.Object.Instantiate(gameObject, position, rotation, parent));
		_instancesByObject.Add(key, assetLoadHandle);
		return assetLoadHandle;
	}

	public AssetLoadHandle InstantiateAsync(string assetID, Action<AssetLoadHandle> callback = null)
	{
		return LoadAsync<GameObject>(assetID, (AssetLoadHandle result) =>
		{
			if (_instanceObjectActions.ContainsKey(assetID))
			{
				_instanceObjectActions[assetID]?.Invoke();
			}
			else
			{
				GameObject gameObject = result.AsGameObject();
				if (null == gameObject)
				{
					callback?.Invoke(result);
				}
				else
				{
					GameObject key = (GameObject)(result.Result = UnityEngine.Object.Instantiate(gameObject));
					_instancesByObject.Add(key, result);
					callback?.Invoke(result);
				}
			}
		});
	}

	public AssetLoadHandle InstantiateAsync(string assetID, Vector3 position, Quaternion rotation, Action<AssetLoadHandle> callback = null)
	{
		return LoadAsync<GameObject>(assetID, (AssetLoadHandle result) =>
		{
			if (_instanceObjectActions.ContainsKey(assetID))
			{
				_instanceObjectActions[assetID]?.Invoke();
			}
			else
			{
				GameObject gameObject = result.AsGameObject();
				if (null == gameObject)
				{
					callback?.Invoke(result);
				}
				else
				{
					GameObject key = (GameObject)(result.Result = UnityEngine.Object.Instantiate(gameObject, position, rotation));
					_instancesByObject.Add(key, result);
					callback?.Invoke(result);
				}
			}
		});
	}

	public AssetLoadHandle InstantiateAsync(string assetID, Transform parent, bool instantiateInWorldSpace = false, Action<AssetLoadHandle> callback = null)
	{
		return LoadAsync<GameObject>(assetID, (AssetLoadHandle result) =>
		{
			if (_instanceObjectActions.ContainsKey(assetID))
			{
				_instanceObjectActions[assetID]?.Invoke();
			}
			else
			{
				GameObject gameObject = result.AsGameObject();
				if (null == gameObject)
				{
					callback?.Invoke(result);
				}
				else
				{
					GameObject key = (GameObject)(result.Result = UnityEngine.Object.Instantiate(gameObject, parent, instantiateInWorldSpace));
					_instancesByObject.Add(key, result);
					callback?.Invoke(result);
				}
			}
		});
	}

	public AssetLoadHandle InstantiateAsync(string assetID, Vector3 position, Quaternion rotation, Transform parent, Action<AssetLoadHandle> callback = null)
	{
		return LoadAsync<GameObject>(assetID, (AssetLoadHandle result) =>
		{
			if (_instanceObjectActions.ContainsKey(assetID))
			{
				_instanceObjectActions[assetID]?.Invoke();
			}
			else
			{
				GameObject gameObject = result.AsGameObject();
				if (null == gameObject)
				{
					callback?.Invoke(result);
				}
				else
				{
					GameObject key = (GameObject)(result.Result = UnityEngine.Object.Instantiate(gameObject, position, rotation, parent));
					_instancesByObject.Add(key, result);
					callback?.Invoke(result);
				}
			}
		});
	}

	public void ReleaseInstance(GameObject gameObject)
	{
		if (_instancesByObject.ContainsKey(gameObject))
		{
			_assetLoadHandles.Remove(_instancesByObject[gameObject]);
			Release(_instancesByObject[gameObject]);
			_instancesByObject.Remove(gameObject);
			UnityEngine.Object.Destroy(gameObject);
		}
	}

	public void ReleaseInstance(AssetLoadHandle handle)
	{
		if (!AssetLoadHandleExtensions.IsValid(handle))
		{
			Debug.LogError("AssetLoadHandle is null,请检查代码是不是卸载了不需要卸载的东西");
		}
		else if (handle.State == LoadState.Loading)
		{
			handle.State = LoadState.Release;
			handle.ReleaseCompleted += ReleaseInstanceWithHandle;
		}
		else
		{
			ReleaseInstanceWithHandle(handle);
		}
	}

	public void DestroyAllGameObject()
	{
		foreach (GameObject item in new List<GameObject>(_instancesByObject.Keys))
		{
			Release(_instancesByObject[item]);
			UnityEngine.Object.Destroy(item);
		}
		_instancesByObject.Clear();
	}

	public void Release(AssetLoadHandle handle, bool showError = true)
	{
		if (!AssetLoadHandleExtensions.IsValid(handle))
		{
			if (showError)
			{
				Debug.LogError("AssetLoadHandle is null,请检查代码是不是卸载了不需要卸载的东西");
			}
		}
		else if (handle.State == LoadState.Loading)
		{
			handle.State = LoadState.Release;
			handle.ReleaseCompleted += ReleaseHandle;
		}
		else
		{
			ReleaseHandle(handle);
		}
	}

	public void Release(string assetID, bool showError = true)
	{
		if (string.IsNullOrEmpty(assetID))
		{
			if (showError)
			{
				Debug.LogError("assetID is null or empty");
			}
			return;
		}
		for (int num = _assetLoadHandles.Count - 1; num >= 0; num--)
		{
			AssetLoadHandle handle = _assetLoadHandles[num];
			if (AssetLoadHandleExtensions.IsValid(handle) && !(handle.AssetID != assetID))
			{
				GameObject gameObject = handle.AsGameObject();
				if (!(gameObject != null) || !_instancesByObject.ContainsKey(gameObject))
				{
					Release(handle, showError);
					return;
				}
			}
		}
		if (showError)
		{
			Debug.LogError("AssetStation Release failed, handle not found. assetID = " + assetID);
		}
	}

	public void UnloadAll()
	{
		foreach (AssetLoadHandle assetLoadHandle in _assetLoadHandles)
		{
			AssetLoadHandle current = assetLoadHandle;
			if (current.State == LoadState.Loading)
			{
				current.HandleOption.State = LoadState.Release;
				current.ReleaseCompleted += UnloadReleasedHandle;
			}
			else if (current.State != LoadState.Release)
			{
				_assetLoader.Unload(current);
			}
		}
		_assetLoadHandles.Clear();
		_assetIDCountMap.Clear();
		foreach (GameObject item in new List<GameObject>(_instancesByObject.Keys))
		{
			UnityEngine.Object.Destroy(item);
		}
		_instancesByObject.Clear();
	}

	internal void ReleaseInstanceWithHandle(AssetLoadHandle handle)
	{
		GameObject gameObject = handle.AsGameObject();
		if (gameObject == null)
		{
			ReleaseHandle(handle);
			return;
		}
		if (!_instancesByObject.TryGetValue(gameObject, out var value))
		{
			ReleaseHandle(handle);
			return;
		}
		ReleaseHandle(value);
		_instancesByObject.Remove(gameObject);
		UnityEngine.Object.Destroy(gameObject);
	}

	private void UnloadReleasedHandle(AssetLoadHandle handle)
	{
		_assetLoader.Unload(handle);
	}

	internal void ReleaseHandle(AssetLoadHandle handle)
	{
		if (handle.CanUse && !string.IsNullOrEmpty(handle.AssetID) && _assetIDCountMap.TryGetValue(handle.AssetID, out var value))
		{
			if (--value == 0)
			{
				_assetIDCountMap.Remove(handle.AssetID);
			}
			else
			{
				_assetIDCountMap[handle.AssetID] = value;
			}
			_assetLoadHandles.Remove(handle);
			_assetLoader.Unload(handle);
		}
	}

	public bool AssetIDIsValid(AssetID assetID)
	{
		if (assetID == null)
		{
			Debug.LogError("AssetID is null");
			return false;
		}
		if (!assetID.IsValid())
		{
			Debug.LogError("AssetID is not valid");
			return false;
		}
		return true;
	}

	public bool Has(AssetID assetID)
	{
		if (AssetIDIsValid(assetID))
		{
			return Has(assetID.GUID);
		}
		return false;
	}

	public AssetLoadHandle Load<T>(AssetID assetID) where T : UnityEngine.Object
	{
		if (AssetIDIsValid(assetID))
		{
			return Load<T>(assetID.GUID);
		}
		return default;
	}

	public AssetLoadHandle LoadAsync<T>(AssetID assetID, Action<AssetLoadHandle> callback = null) where T : UnityEngine.Object
	{
		if (AssetIDIsValid(assetID))
		{
			return LoadAsync<T>(assetID.GUID, callback);
		}
		return default;
	}

	public AssetLoadHandle Instantiate(AssetID assetID)
	{
		if (AssetIDIsValid(assetID))
		{
			return Instantiate(assetID.GUID);
		}
		return default;
	}

	public AssetLoadHandle Instantiate(AssetID assetID, Vector3 position, Quaternion rotation)
	{
		if (AssetIDIsValid(assetID))
		{
			return Instantiate(assetID.GUID, position, rotation);
		}
		return default;
	}

	public AssetLoadHandle Instantiate(AssetID assetID, Transform parent, bool instantiateInWorldSpace = false)
	{
		if (AssetIDIsValid(assetID))
		{
			return Instantiate(assetID.GUID, parent, instantiateInWorldSpace);
		}
		return default;
	}

	public AssetLoadHandle Instantiate(AssetID assetID, Vector3 position, Quaternion rotation, Transform parent)
	{
		if (AssetIDIsValid(assetID))
		{
			return Instantiate(assetID.GUID, position, rotation, parent);
		}
		return default;
	}

	public AssetLoadHandle InstantiateAsync(AssetID assetID, Action<AssetLoadHandle> callback = null)
	{
		if (AssetIDIsValid(assetID))
		{
			return InstantiateAsync(assetID.GUID, callback);
		}
		return default;
	}

	public AssetLoadHandle InstantiateAsync(AssetID assetID, Vector3 position, Quaternion rotation, Action<AssetLoadHandle> callback = null)
	{
		if (AssetIDIsValid(assetID))
		{
			return InstantiateAsync(assetID.GUID, position, rotation, callback);
		}
		return default;
	}

	public AssetLoadHandle InstantiateAsync(AssetID assetID, Transform parent, bool instantiateInWorldSpace = false, Action<AssetLoadHandle> callback = null)
	{
		if (AssetIDIsValid(assetID))
		{
			return InstantiateAsync(assetID.GUID, parent, instantiateInWorldSpace, callback);
		}
		return default;
	}

	public AssetLoadHandle InstantiateAsync(AssetID assetID, Vector3 position, Quaternion rotation, Transform parent, Action<AssetLoadHandle> callback = null)
	{
		if (AssetIDIsValid(assetID))
		{
			return InstantiateAsync(assetID.GUID, position, rotation, parent, callback);
		}
		return default;
	}
}
