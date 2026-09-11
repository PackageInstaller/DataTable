using UnityEngine;
using UnityEngine.SceneManagement;

public class AsyncScene : IAsyncAsset
{
	private AsyncOperationScene m_SelfOp;

	private LoadSceneMode m_mode;

	private bool m_allowSceneActivation = true;

	private AssetBundleManifest m_manifest;

	private string m_scenePath;

	private string m_bundleName;

	public string GetAssetName()
	{
		return m_scenePath;
	}

	public int GetRefCount()
	{
		if (m_SelfOp == null)
		{
			return 0;
		}
		return m_SelfOp.refCount;
	}

	public AsyncScene(string scenePath, string bundleName, LoadSceneMode mode, bool allowSceneActivation, AssetBundleManifest manifest = null)
	{
		m_mode = mode;
		m_scenePath = scenePath;
		m_bundleName = bundleName;
		m_allowSceneActivation = allowSceneActivation;
		m_manifest = manifest;
	}

	public bool IsDone()
	{
		return m_SelfOp.IsDone();
	}

	public void SetActive(bool isActive)
	{
		m_SelfOp.SetActive(isActive);
	}

	public AsyncOperationScene LoadAsync()
	{
		if (m_SelfOp == null)
		{
			m_SelfOp = new AsyncOperationScene(m_scenePath, m_bundleName, m_mode, m_allowSceneActivation, m_manifest);
		}
		m_SelfOp.IncreaseRefCount();
		return m_SelfOp;
	}

	public bool Release()
	{
		if (m_SelfOp == null)
		{
			return true;
		}
		Debug.Log(GetAssetName() + ":" + m_SelfOp.refCount);
		if (m_SelfOp.DecrementRefCount() <= 0)
		{
			if (m_SelfOp.IsDone())
			{
				m_SelfOp.Release();
				m_SelfOp = null;
				return true;
			}
			Debug.LogError("无法释放正在异步载入的资源！");
		}
		return false;
	}
}
