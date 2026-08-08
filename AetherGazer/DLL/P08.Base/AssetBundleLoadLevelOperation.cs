using UnityEngine;
using UnityEngine.SceneManagement;

public class AssetBundleLoadLevelOperation : AssetBundleLoadOperation
{
	protected string m_AssetBundleName;

	protected string m_LevelName;

	protected LoadSceneMode m_mode;

	private bool m_allowSceneActivation;

	protected string m_DownloadingError;

	protected AsyncOperation m_Request;

	public AssetBundleLoadLevelOperation(string assetbundleName, string levelName, LoadSceneMode mode, bool allowSceneActivation = true)
	{
		m_AssetBundleName = assetbundleName;
		m_LevelName = levelName;
		m_mode = mode;
		m_allowSceneActivation = allowSceneActivation;
	}

	public AssetBundleLoadLevelOperation(string assetbundleName, string levelName, bool isAdditive, bool allowSceneActivation = true)
		: this(assetbundleName, levelName, isAdditive ? LoadSceneMode.Additive : LoadSceneMode.Single, allowSceneActivation)
	{
	}

	public override bool Update()
	{
		if (m_Request != null)
		{
			return false;
		}
		if (AssetManager.GetLoadedAssetBundle(m_AssetBundleName, out m_DownloadingError) != null)
		{
			m_Request = SceneManager.LoadSceneAsync(m_LevelName, m_mode);
			m_Request.allowSceneActivation = true;
			return false;
		}
		return true;
	}

	public override bool IsDone()
	{
		if (m_Request == null && m_DownloadingError != null)
		{
			Debug.LogError(m_DownloadingError);
			return true;
		}
		if (m_Request != null)
		{
			return m_Request.isDone;
		}
		return false;
	}

	public void SetLoadLevelWillActive(bool active)
	{
		m_allowSceneActivation = active;
	}
}
