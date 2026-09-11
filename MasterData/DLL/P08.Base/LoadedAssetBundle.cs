using System;
using UnityEngine;

public class LoadedAssetBundle
{
	public AssetBundle m_AssetBundle;

	private int m_ReferencedCount;

	private int m_ManualReferencedCount;

	internal event Action unload;

	internal void OnUnload(bool allUnload = false)
	{
		m_AssetBundle.Unload(allUnload);
		if (unload != null)
		{
			unload();
		}
	}

	public LoadedAssetBundle(AssetBundle assetBundle)
	{
		m_AssetBundle = assetBundle;
		m_ReferencedCount = 1;
		m_ManualReferencedCount = 0;
	}

	public int GetAutoRef()
	{
		return m_ReferencedCount;
	}

	public void SetAutoRef(int refCount)
	{
		m_ReferencedCount = refCount;
	}

	public int GetManualRef()
	{
		return m_ManualReferencedCount;
	}

	public void SetManualRef(int refCount)
	{
		m_ManualReferencedCount = refCount;
	}

	public void IncreaseAutoRef()
	{
		m_ReferencedCount++;
	}

	public void DecreaseAutoRef()
	{
		m_ReferencedCount--;
	}

	public void IncreaseManualRef()
	{
		m_ManualReferencedCount++;
	}

	public void DecreaseManualRef()
	{
		m_ManualReferencedCount--;
	}

	public bool IsUnusedBundle()
	{
		if (m_ManualReferencedCount <= 0)
		{
			return m_ReferencedCount <= 0;
		}
		return false;
	}

	public T GetAsset<T>(string assetName) where T : UnityEngine.Object
	{
		if (m_AssetBundle != null)
		{
			return m_AssetBundle.LoadAsset<T>(assetName);
		}
		return null;
	}

	public void GetAllAssets<T>(ref T[] assetArray) where T : UnityEngine.Object
	{
		if (!(m_AssetBundle != null))
		{
			return;
		}
		string[] allAssetNames = m_AssetBundle.GetAllAssetNames();
		for (int i = 0; i < allAssetNames.Length; i++)
		{
			if (assetArray == null)
			{
				assetArray = new T[allAssetNames.Length];
			}
			assetArray[i] = GetAsset<T>(allAssetNames[i]);
		}
	}
}
