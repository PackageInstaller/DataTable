using System;
using UnityEngine;

public class AsyncOperationAllAsset<T> : RefCounter where T : UnityEngine.Object
{
	private AssetBundleObject m_ab;

	private AssetBundleRequest m_asset_op;

	private bool m_isABMode;

	private string m_bundleName;

	public T[] m_assets;

	public event Action<T[]> m_asset_compeleted;

	public AssetBundleRequest GetOp()
	{
		return m_asset_op;
	}

	public AsyncOperationAllAsset(string bundleName, AssetBundleObject abObject, bool isABMode)
	{
		m_isABMode = isABMode;
		m_bundleName = bundleName;
		if (isABMode)
		{
			m_ab = abObject;
			m_ab.LoadAsync();
			if (m_ab.m_IsDoneWithChildren)
			{
				OnABCompleted();
				return;
			}
			AssetBundleObject ab = m_ab;
			ab.m_LoadCompeletedEvent = (Action)Delegate.Combine(ab.m_LoadCompeletedEvent, new Action(OnABCompleted));
		}
		else
		{
			OnABCompleted();
		}
	}

	public void OnABCompleted()
	{
		if (m_isABMode)
		{
			AssetBundleObject ab = m_ab;
			ab.m_LoadCompeletedEvent = (Action)Delegate.Remove(ab.m_LoadCompeletedEvent, new Action(OnABCompleted));
			AssetBundle assetBundle = m_ab.GetAssetBundle();
			m_asset_op = assetBundle.LoadAllAssetsAsync();
			m_asset_op.completed += OnAssetCompleted;
		}
		else
		{
			OnAssetCompleted(null);
		}
	}

	private void OnAssetCompleted(AsyncOperation op)
	{
		if (m_isABMode)
		{
			m_assets = m_asset_op.allAssets as T[];
		}
		else if (RefCounter.OnEditorLoadAll != null)
		{
			m_assets = RefCounter.OnEditorLoadAll(m_bundleName, typeof(T)) as T[];
		}
		if (m_asset_compeleted != null)
		{
			m_asset_compeleted(m_assets);
			m_asset_compeleted = null;
		}
	}

	public bool IsDone()
	{
		if (m_isABMode)
		{
			if (!m_ab.m_IsDoneWithChildren)
			{
				return false;
			}
			if (!m_asset_op.isDone)
			{
				return false;
			}
		}
		return true;
	}

	public void Release()
	{
		if (m_isABMode && m_asset_op != null && !m_asset_op.isDone)
		{
			Debug.LogError("无法释放正在异步载入的资源！");
			return;
		}
		if (m_ab != null)
		{
			AssetBundleObject ab = m_ab;
			ab.m_LoadCompeletedEvent = (Action)Delegate.Remove(ab.m_LoadCompeletedEvent, new Action(OnABCompleted));
			m_ab.UnloadAsync();
		}
		m_assets = null;
	}
}
