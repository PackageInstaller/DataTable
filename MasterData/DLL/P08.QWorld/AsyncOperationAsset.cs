using System;
using UnityEngine;

public class AsyncOperationAsset<T> : RefCounter where T : UnityEngine.Object
{
	private AssetBundleObject m_ab;

	private AssetBundleRequest m_asset_op;

	private bool m_isABMode;

	private string m_assetName;

	public T m_asset;

	public event Action<T> m_asset_compeleted;

	public AssetBundleRequest GetOp()
	{
		return m_asset_op;
	}

	public AsyncOperationAsset(string assetName, AssetBundleObject abObject, bool isABMode)
	{
		m_isABMode = isABMode;
		m_assetName = assetName;
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
			m_asset_op = assetBundle.LoadAssetAsync(m_assetName);
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
			m_asset = m_asset_op.asset as T;
		}
		else if (RefCounter.OnEditorLoad != null)
		{
			m_asset = RefCounter.OnEditorLoad(m_assetName, typeof(T)) as T;
		}
		if (m_asset_compeleted != null)
		{
			m_asset_compeleted(m_asset);
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
		m_asset = null;
	}
}
