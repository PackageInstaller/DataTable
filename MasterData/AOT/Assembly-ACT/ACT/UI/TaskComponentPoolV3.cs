using System;
using System.Collections.Generic;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public sealed class TaskComponentPoolV3<T> where T : Component, ITaskPoolItemV3
{
	private readonly Stack<T> _inactiveItems = new Stack<T>();

	private readonly ImageAssetStation _station;

	private readonly YooAssetReference _assetReference;

	private readonly Transform _cacheRoot;

	public TaskComponentPoolV3(ImageAssetStation station, YooAssetReference assetReference, Transform cacheRoot)
	{
		_station = station;
		_assetReference = assetReference;
		_cacheRoot = cacheRoot;
	}

	public T Get(Transform parent)
	{
		T val;
		if (_inactiveItems.Count > 0)
		{
			val = _inactiveItems.Pop();
			val.transform.SetParent(parent, worldPositionStays: false);
		}
		else
		{
			val = Create(parent);
		}
		val.gameObject.SetActive(value: true);
		return val;
	}

	public void Release(T item)
	{
		item.Unbind();
		item.gameObject.SetActive(value: false);
		item.transform.SetParent(_cacheRoot, worldPositionStays: false);
		_inactiveItems.Push(item);
	}

	public void ClearReferences()
	{
		_inactiveItems.Clear();
	}

	private T Create(Transform parent)
	{
		GameObject gameObject = _station.Instantiate(_assetReference, parent).AsGameObject();
		if (!gameObject)
		{
			throw new InvalidOperationException("任务界面实例化 Prefab 失败: " + _assetReference.GUID);
		}
		T component = gameObject.GetComponent<T>();
		if (!component)
		{
			throw new MissingComponentException("任务 Prefab 缺少组件 " + typeof(T).Name + ": " + _assetReference.GUID);
		}
		return component;
	}
}
