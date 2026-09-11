using UnityEngine;

public class AsyncAssets<T> : IAsyncAsset where T : Object
{
	private AssetBundleObject m_abObject;

	private AsyncOperationAllAsset<T> m_selfOp;

	private bool m_isABMode;

	public string m_bundleName;

	public T[] Block()
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

	public int GetRefCount()
	{
		if (m_selfOp == null)
		{
			return 0;
		}
		return m_selfOp.refCount;
	}

	public AsyncAssets(string bundleName, AssetBundleObject ab, bool isABMode)
	{
		m_abObject = ab;
		m_isABMode = isABMode;
		m_bundleName = bundleName;
	}

	public bool IsDone()
	{
		return m_selfOp.IsDone();
	}

	public T[] GetAsset()
	{
		if (m_selfOp == null)
		{
			Debug.LogError("大概率是使用有问题，请检查下是否上层存在引用错误！");
			return null;
		}
		if (m_selfOp.IsDone())
		{
			return m_selfOp.m_assets;
		}
		return m_selfOp.GetOp().allAssets as T[];
	}

	public AsyncOperationAllAsset<T> LoadAsync()
	{
		if (m_selfOp == null)
		{
			m_selfOp = new AsyncOperationAllAsset<T>(m_bundleName, m_abObject, m_isABMode);
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

	public string GetAssetName()
	{
		return "";
	}
}
