using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class AssetBundleObject
{
	public string m_abPath;

	public string m_bundleName;

	public string[] m_abDepPath;

	public AssetBundleManifest m_manifest;

	public AssetBundleObject[] m_childrens;

	private List<AsyncOperationAssetbundle> m_pendingOps;

	public static Dictionary<string, AssetBundleObject> s_bundleObjects = new Dictionary<string, AssetBundleObject>();

	public static Dictionary<string, string> s_bundleFilePath = new Dictionary<string, string>();

	public Action m_LoadCompeletedEvent;

	public AsyncOperationAssetbundle m_selfOP;

	public bool m_IsDoneWithChildren;

	public void Block()
	{
		if (m_pendingOps == null || m_pendingOps.Count == 0)
		{
			return;
		}
		int num = m_pendingOps.Count - 1;
		while (num >= 0 && m_pendingOps.Count != 0)
		{
			if (num < m_pendingOps.Count)
			{
				_ = m_pendingOps[num].GetOp().assetBundle;
			}
			num--;
		}
	}

	public static string GetBundleFilePath(string bundleName)
	{
		if (!s_bundleFilePath.TryGetValue(bundleName, out var value))
		{
			string text = Platform.GetDownloadPersistentDataPath() + bundleName;
			if (!File.Exists(text))
			{
				text = Platform.GetDownloadPath() + bundleName;
			}
			value = text;
			s_bundleFilePath.Add(bundleName, value);
		}
		return value;
	}

	public AssetBundleObject(string bundleName, AssetBundleManifest manifest)
	{
		m_abPath = GetBundleFilePath(bundleName);
		m_bundleName = bundleName;
		m_manifest = manifest;
		m_abDepPath = ((manifest != null) ? manifest.GetAllDependencies(bundleName) : new string[0]);
		m_IsDoneWithChildren = false;
		m_childrens = new AssetBundleObject[m_abDepPath.Length];
	}

	public void RemovePendingOp(AsyncOperationAssetbundle op)
	{
		if (m_pendingOps == null)
		{
			Debug.LogError(m_abPath + " dont has pending ops!!!");
			return;
		}
		if (!op.IsDone())
		{
			Debug.LogError("ab op is not done!!");
			return;
		}
		m_pendingOps.Remove(op);
		if (m_pendingOps == null || m_pendingOps.Count <= 0)
		{
			m_IsDoneWithChildren = true;
			if (m_LoadCompeletedEvent != null)
			{
				m_LoadCompeletedEvent();
			}
		}
	}

	public void AddPendingOp(AsyncOperationAssetbundle op)
	{
		if (m_pendingOps == null)
		{
			m_pendingOps = new List<AsyncOperationAssetbundle>();
		}
		if (op.IsDone())
		{
			Debug.LogError("op is done, dot add it to pending list!");
		}
		else
		{
			m_pendingOps.Add(op);
		}
	}

	public AssetBundle GetAssetBundle()
	{
		if (m_selfOP != null)
		{
			return m_selfOP.GetAssetbundle();
		}
		return null;
	}

	public string[] GetDepPaths(string bundlePath)
	{
		return m_manifest.GetAllDependencies(bundlePath);
	}

	public bool IsDone()
	{
		if (!m_selfOP.IsDone())
		{
			return false;
		}
		for (int i = 0; i < m_childrens.Length; i++)
		{
			if (!m_childrens[i].IsDone())
			{
				return false;
			}
		}
		return true;
	}

	public AsyncOperationAssetbundle LoadAsync()
	{
		m_IsDoneWithChildren = false;
		AsyncOperationAssetbundle result = LoadAsyncInternal(this);
		if (m_pendingOps == null || m_pendingOps.Count <= 0)
		{
			m_IsDoneWithChildren = true;
			if (m_LoadCompeletedEvent != null)
			{
				m_LoadCompeletedEvent();
			}
		}
		return result;
	}

	protected AsyncOperationAssetbundle LoadAsyncInternal(AssetBundleObject root)
	{
		if (m_selfOP == null)
		{
			m_selfOP = new AsyncOperationAssetbundle(m_abPath);
		}
		m_selfOP.IncreaseRefCount();
		if (!m_selfOP.IsDone())
		{
			m_selfOP.Waiting(root);
			root.AddPendingOp(m_selfOP);
		}
		for (int i = 0; i < m_abDepPath.Length; i++)
		{
			AssetBundleObject value = m_childrens[i];
			if (value == null)
			{
				if (!s_bundleObjects.TryGetValue(m_abDepPath[i], out value))
				{
					value = new AssetBundleObject(m_abDepPath[i], m_manifest);
					s_bundleObjects.Add(m_abDepPath[i], value);
				}
				m_childrens[i] = value;
			}
			value.LoadAsyncInternal(root);
		}
		return m_selfOP;
	}

	public void UnloadAsync()
	{
		if (m_selfOP == null)
		{
			return;
		}
		if (!m_selfOP.IsDone())
		{
			Debug.LogError("正在卸载未加载完成的资源！");
			return;
		}
		for (int i = 0; i < m_childrens.Length; i++)
		{
			if (m_childrens[i] != null)
			{
				m_childrens[i].UnloadAsync();
			}
		}
		m_selfOP.DecrementRefCount();
		m_selfOP.Release(v: true);
		if (m_selfOP.refCount <= 0)
		{
			s_bundleObjects.Remove(m_bundleName);
		}
	}
}
