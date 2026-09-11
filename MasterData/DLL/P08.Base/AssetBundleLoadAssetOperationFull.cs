using UnityEngine;

public class AssetBundleLoadAssetOperationFull<T> : AssetBundleLoadAssetOperation<T> where T : Object
{
	protected string m_AssetBundleName;

	protected string m_AssetName;

	protected string m_DownloadingError;

	protected OnVoidHandler<T> m_callback;

	protected AssetBundleRequest m_Request;

	private float m_startTime;

	public AssetBundleLoadAssetOperationFull(string bundleName, string assetName, OnVoidHandler<T> callback)
	{
		m_AssetBundleName = bundleName.ToLower(StringTools.sCultureInfo);
		m_AssetName = assetName;
		m_callback = callback;
		m_startTime = Time.realtimeSinceStartup;
	}

	public override T GetAsset()
	{
		if (m_Request != null && m_Request.isDone)
		{
			return m_Request.asset as T;
		}
		return null;
	}

	public override bool Update()
	{
		if (timeout > 0f)
		{
			timeout -= Time.deltaTime;
		}
		else
		{
			Debug.Log(m_AssetBundleName + " is more thrn 1 minus");
		}
		if (m_Request != null)
		{
			if (!IsDone())
			{
				return true;
			}
			return false;
		}
		if (m_DownloadingError != null)
		{
			return false;
		}
		LoadedAssetBundle loadedAssetBundle = AssetManager.GetLoadedAssetBundle(m_AssetBundleName, out m_DownloadingError);
		if (loadedAssetBundle != null)
		{
			if (m_debug_log)
			{
				Debug.Log("磁盘加载: " + m_AssetBundleName + " cost time:" + (Time.realtimeSinceStartup - m_startTime));
				m_startTime = Time.realtimeSinceStartup;
			}
			m_Request = loadedAssetBundle.m_AssetBundle.LoadAssetAsync(m_AssetName, typeof(T));
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

	public override void Finish()
	{
		if (m_debug_log)
		{
			Debug.Log("资源包解压: " + m_AssetBundleName + " cost time:" + (Time.realtimeSinceStartup - m_startTime));
			m_startTime = Time.realtimeSinceStartup;
		}
		if (m_callback != null)
		{
			m_callback(GetAsset());
		}
		if (m_debug_log)
		{
			Debug.Log("回调: " + m_AssetBundleName + " cost time:" + (Time.realtimeSinceStartup - m_startTime));
		}
	}

	public override string ToString()
	{
		return $"Bundle {m_AssetBundleName} Asset {m_AssetName}";
	}
}
