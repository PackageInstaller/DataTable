using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Pool;

namespace QwStreaming;

public class StreamingCacheGameObject : IStreamingObject, IDisposable
{
	public struct CacheSettings
	{
		public float startClearTimeLeft;

		public float perObjectClearTimeLeft;

		public float noObjectUnloadTimeLeft;
	}

	public struct CacheData
	{
		public StreamingCacheMgr.ECacheCleanJob cleanJob;

		public float nextCleanTime;

		public int allItemCount;

		public int freeItemCount;
	}

	public CacheSettings cacheSettings;

	public CacheData cacheData;

	private ModelInfo _modelInfo;

	private GameObject _template;

	private List<GameObject> _freeItems;

	private GameObject _cacheRoot;

	public ModelInfo modelInfo => _modelInfo;

	public GameObject Take(bool active = true)
	{
		if (_freeItems.Count > 0)
		{
			GameObject gameObject = _freeItems[_freeItems.Count - 1];
			_freeItems.RemoveAt(_freeItems.Count - 1);
			cacheData.freeItemCount = _freeItems.Count;
			gameObject.SetActive(active);
			return gameObject;
		}
		if (_template == null)
		{
			if (_modelInfo.asset == null)
			{
				Streaming.ImmediateLoadModel(_modelInfo);
			}
			_template = _modelInfo.asset as GameObject;
		}
		GameObject result = UnityEngine.Object.Instantiate(_template);
		cacheData.allItemCount++;
		return result;
	}

	public void Return(GameObject item)
	{
		_freeItems.Add(item);
		cacheData.freeItemCount = _freeItems.Count;
		if (_cacheRoot == null)
		{
			_cacheRoot = new GameObject("Cache_" + Path.GetFileName(_modelInfo.assetPath));
		}
		item.transform.SetParent(_cacheRoot.transform);
		item.SetActive(value: false);
		StreamingCacheMgr.RegisterClearJob(this);
	}

	public void Shrink(int count)
	{
		if (count < 0)
		{
			return;
		}
		int count2 = _freeItems.Count;
		if (count > count2)
		{
			count = count2;
		}
		for (int i = 0; i < count; i++)
		{
			GameObject gameObject = _freeItems[count2 - 1 - i];
			List<Renderer> list = CollectionPool<List<Renderer>, Renderer>.Get();
			gameObject.GetComponentsInChildren(list);
			foreach (Renderer item in list)
			{
				Material[] sharedMaterials = item.sharedMaterials;
				foreach (Material material in sharedMaterials)
				{
					if ((bool)material && material.name.Contains("(Instance)"))
					{
						UnityEngine.Object.DestroyImmediate(material);
					}
				}
			}
			CollectionPool<List<Renderer>, Renderer>.Release(list);
			UnityEngine.Object.Destroy(gameObject);
			_freeItems.RemoveAt(count2 - 1 - i);
			cacheData.freeItemCount--;
			cacheData.allItemCount--;
		}
	}

	void IStreamingObject.OnModelLoaded(ModelInfo modelInfo)
	{
		_template = modelInfo.asset as GameObject;
	}

	public void Init(ModelInfo modelInfo)
	{
		Init(modelInfo, new CacheSettings
		{
			startClearTimeLeft = 5f,
			perObjectClearTimeLeft = 2f,
			noObjectUnloadTimeLeft = 10f
		});
	}

	public void Init(ModelInfo modelInfo, CacheSettings settings)
	{
		_modelInfo = modelInfo;
		cacheSettings = settings;
		cacheData = default(CacheData);
		_freeItems = new List<GameObject>();
		Streaming.RequestObject(this, _modelInfo, StreamingLoadMode.Default);
	}

	public void Dispose()
	{
		if (cacheData.allItemCount != 0 && cacheData.freeItemCount != cacheData.allItemCount)
		{
			Debug.LogError("StreamingCacheGameObject 有实例未归还: " + _modelInfo.assetPath);
		}
		foreach (GameObject freeItem in _freeItems)
		{
			UnityEngine.Object.Destroy(freeItem);
		}
		UnityEngine.Object.Destroy(_cacheRoot);
		_cacheRoot = null;
		if (_template != null)
		{
			Streaming.RemoveObject(this, _modelInfo);
		}
		_modelInfo = null;
		_template = null;
		_freeItems.Clear();
		_freeItems = null;
	}
}
