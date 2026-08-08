using System;
using System.Collections.Generic;
using UnityEngine;

public class AsyncOperationAssetbundle : RefCounter
{
	protected AssetBundleCreateRequest m_load_op;

	protected string m_abPath;

	private Action<AsyncOperation> m_LoadCompleteEvent;

	private Action<AsyncOperation> m_UnloadCompleteEvent;

	private List<AssetBundleObject> m_waitingObjects;

	public bool m_isUnloading;

	public AsyncOperationAssetbundle(string abPath, Action<AsyncOperation> loadCompleteEventHandler = null, Action<AsyncOperation> unloadCompleteEventHandler = null)
	{
		refCount = 0;
		m_LoadCompleteEvent = loadCompleteEventHandler;
		m_UnloadCompleteEvent = unloadCompleteEventHandler;
		StartOp(abPath);
	}

	public void StartOp(string abPath)
	{
		if (!string.IsNullOrEmpty(abPath) && !(abPath == m_abPath))
		{
			m_abPath = abPath;
			AssetBundleCreateRequest op = AssetBundle.LoadFromFileAsync(abPath, 0u);
			StartOp(op);
		}
	}

	public AssetBundleCreateRequest GetOp()
	{
		return m_load_op;
	}

	private void StartOp(AssetBundleCreateRequest op)
	{
		if (m_load_op != op)
		{
			if (m_load_op != null)
			{
				m_load_op.completed -= OnCompeletedHandler;
			}
			m_load_op = op;
			m_load_op.completed += OnCompeletedHandler;
		}
	}

	private void OnCompeletedHandler(AsyncOperation op)
	{
		if (m_waitingObjects != null)
		{
			for (int i = 0; i < m_waitingObjects.Count; i++)
			{
				if (m_waitingObjects[i] != null)
				{
					m_waitingObjects[i].RemovePendingOp(this);
				}
			}
		}
		if (m_LoadCompleteEvent != null)
		{
			m_LoadCompleteEvent(op);
		}
	}

	public bool IsDone()
	{
		if (m_load_op == null)
		{
			return false;
		}
		return m_load_op.isDone;
	}

	public AssetBundle GetAssetbundle()
	{
		if (m_load_op != null)
		{
			AssetBundleCreateRequest load_op = m_load_op;
			if (load_op.isDone)
			{
				return load_op.assetBundle;
			}
			Debug.LogError("正在获得还未完成资源！");
		}
		return null;
	}

	public void Release(bool v)
	{
		if (refCount <= 0)
		{
			AssetBundle assetbundle = GetAssetbundle();
			m_load_op = null;
			if (assetbundle != null)
			{
				m_isUnloading = true;
				assetbundle.UnloadAsync(v).completed += OnReleaseCompleted;
			}
		}
	}

	public void OnReleaseCompleted(AsyncOperation unloadOP)
	{
		m_isUnloading = false;
		if (refCount > 0)
		{
			Debug.LogError("刚卸载完，又要加载了");
			StartOp(m_abPath);
		}
		if (m_UnloadCompleteEvent != null)
		{
			m_UnloadCompleteEvent(unloadOP);
		}
	}

	internal void Waiting(AssetBundleObject root)
	{
		if (m_waitingObjects == null)
		{
			m_waitingObjects = new List<AssetBundleObject>();
		}
		m_waitingObjects.Add(root);
	}
}
