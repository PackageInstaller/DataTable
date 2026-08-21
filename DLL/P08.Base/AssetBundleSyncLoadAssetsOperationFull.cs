using System;
using UnityEngine;

public class AssetBundleSyncLoadAssetsOperationFull<T> : AssetBundleLoadAssetsOperation<T> where T : UnityEngine.Object
{
	protected string m_AssetBundleName;

	protected string m_DownloadingError;

	protected OnVoidHandler<T[]> m_callback;

	protected AssetBundle m_bundle;

	private float m_startTime;

	public override string ToString()
	{
		return $"Bundle {m_AssetBundleName}";
	}

	public AssetBundleSyncLoadAssetsOperationFull(string bundleName, OnVoidHandler<T[]> callback)
	{
		m_AssetBundleName = bundleName.ToLower(StringTools.sCultureInfo);
		m_callback = callback;
		m_startTime = Time.realtimeSinceStartup;
	}

	public override T[] GetAssets()
	{
		if (m_bundle != null)
		{
			return m_bundle.LoadAllAssets<T>();
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
			bool flag = true;
			float num = 0f;
			int num2 = 0;
			bool flag2 = false;
			Debug.Log(m_AssetBundleName + " is more thrn 1 minus(progress: " + num + " assets num: " + num2 + ":" + flag2 + ") IsNull " + flag);
		}
		if (m_bundle != null)
		{
			if (!IsDone())
			{
				return true;
			}
			return false;
		}
		LoadedAssetBundle loadedAssetBundle = AssetManager.GetLoadedAssetBundle(m_AssetBundleName, out m_DownloadingError);
		if (!string.IsNullOrEmpty(m_DownloadingError))
		{
			Debug.LogError(m_AssetBundleName + " @DownloadingError " + m_DownloadingError);
			return false;
		}
		if (loadedAssetBundle != null)
		{
			if (m_debug_log)
			{
				Debug.Log("磁盘加载: " + m_AssetBundleName + " cost time:" + (Time.realtimeSinceStartup - m_startTime));
				m_startTime = Time.realtimeSinceStartup;
			}
			try
			{
				m_bundle = loadedAssetBundle.m_AssetBundle;
			}
			catch (Exception ex)
			{
				Debug.LogError("System.Exception =====> " + ex.Message);
				throw ex;
			}
		}
		return true;
	}

	public override bool IsDone()
	{
		if (m_bundle == null && m_DownloadingError != null)
		{
			Debug.LogError(m_DownloadingError);
			return true;
		}
		return m_bundle != null;
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
			m_callback(GetAssets());
		}
		if (m_debug_log)
		{
			Debug.Log("回调: " + m_AssetBundleName + " cost time:" + (Time.realtimeSinceStartup - m_startTime));
		}
	}
}
