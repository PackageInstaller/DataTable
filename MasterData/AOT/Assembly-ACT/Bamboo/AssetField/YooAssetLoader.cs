using System;
using System.Collections.Generic;
using Bamboo.Collections;
using UnityEngine;
using YooAsset;

namespace Bamboo.AssetField;

public class YooAssetLoader : IAssetAdapter
{
	private ResourcePackage _loaderPackage;

	private BMap<string, AssetHandle> _objToAssetHandle;

	public YooAssetLoader(ResourcePackage targetPackage = null)
	{
		if (targetPackage == null)
		{
			targetPackage = YooAssets.TryGetPackage("Assets");
		}
		_objToAssetHandle = BMapPool<string, AssetHandle>.Default.Get();
		_loaderPackage = targetPackage;
	}

	public void Release()
	{
		if (_objToAssetHandle == null || _objToAssetHandle.IsRecycled)
		{
			return;
		}
		foreach (KeyValuePair<string, AssetHandle> item in _objToAssetHandle)
		{
			item.Value.Release();
			_loaderPackage.TryUnloadUnusedAsset(item.Key);
		}
		BMapPool<string, AssetHandle>.Default.Recycle(_objToAssetHandle);
		_objToAssetHandle = null;
	}

	public bool AssetExists(string key)
	{
		if (!string.IsNullOrEmpty(key) && _loaderPackage != null)
		{
			return _loaderPackage.CheckLocationValid(key);
		}
		return false;
	}

	public T Load<T>(string key) where T : UnityEngine.Object
	{
		EnsureAssetHandleMap();
		if (!_loaderPackage.CheckLocationValid(key))
		{
			throw new Exception("加载[" + key + "]为空");
		}
		if (_objToAssetHandle.TryGetValue(key, out var value))
		{
			value.WaitForAsyncComplete();
			return (T)value.AssetObject;
		}
		value = _loaderPackage.LoadAssetSync<T>(key);
		_objToAssetHandle.Add(key, value);
		return (T)value.AssetObject;
	}

	public void LoadAsync<T>(string key, Action<T> callback) where T : UnityEngine.Object
	{
		EnsureAssetHandleMap();
		if (!_loaderPackage.CheckLocationValid(key))
		{
			callback?.Invoke(null);
			throw new Exception("加载[" + key + "]为空");
		}
		AssetHandle assetHandle = _loaderPackage.LoadAssetAsync<T>(key);
		_objToAssetHandle.Add(key, assetHandle);
		assetHandle.Completed += (AssetHandle assetHandle2) =>
		{
			callback?.Invoke((T)assetHandle2.AssetObject);
		};
	}

	public void Unload(string key)
	{
		if (_objToAssetHandle != null && !_objToAssetHandle.IsRecycled && _objToAssetHandle.TryGetValue(key, out var value))
		{
			value.Release();
			_loaderPackage.TryUnloadUnusedAsset(key);
			_objToAssetHandle.Remove(key);
		}
	}

	public void WaitForCommit<T>(string key) where T : UnityEngine.Object
	{
		if (_objToAssetHandle != null && !_objToAssetHandle.IsRecycled && _objToAssetHandle.TryGetValue(key, out var value))
		{
			value.WaitForAsyncComplete();
		}
	}

	private void EnsureAssetHandleMap()
	{
		if (_objToAssetHandle == null || _objToAssetHandle.IsRecycled)
		{
			_objToAssetHandle = BMapPool<string, AssetHandle>.Default.Get();
		}
	}
}
