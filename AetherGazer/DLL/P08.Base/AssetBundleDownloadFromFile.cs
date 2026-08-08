using System;
using UnityEngine;

public class AssetBundleDownloadFromFile : AssetBundleDownloadOperation
{
	private AssetBundleCreateRequest m_Request;

	private string m_Url;

	protected override bool downloadIsDone
	{
		get
		{
			if (m_Request != null)
			{
				return m_Request.isDone;
			}
			return true;
		}
	}

	public AssetBundleDownloadFromFile(string assetBundleName, string path)
		: base(assetBundleName)
	{
		if (Platform.CheckABEncypt())
		{
			int num = assetBundleName.Length % 16 + 1;
			m_Request = AssetBundle.LoadFromFileAsync(path, 0u, (ulong)num);
		}
		else
		{
			m_Request = AssetBundle.LoadFromFileAsync(path, 0u, 0uL);
		}
		if (m_Request == null)
		{
			throw new ArgumentNullException("AssetBundleDownloadFromFile Request is NULL");
		}
		m_Url = path;
	}

	protected override void FinishDownload()
	{
		if (m_Request.assetBundle == null)
		{
			base.error = $"{base.assetBundleName} is not a valid asset bundle.";
			Debug.Log("========>FinishDownloadError " + base.error);
		}
		else
		{
			base.assetBundle = new LoadedAssetBundle(m_Request.assetBundle);
		}
		m_Request = null;
	}

	public override string GetSourceURL()
	{
		return m_Url;
	}

	public void GetAssetBundleSync()
	{
		if (m_Request == null)
		{
			base.error = $"m_Request is null";
			Debug.Log("========>PreFinishDownloadError " + base.error);
		}
		if (m_Request.assetBundle == null)
		{
			base.error = $"{base.assetBundleName} is not a valid asset bundle.";
			Debug.Log("========>PreFinishDownloadError " + base.error);
		}
		else
		{
			base.assetBundle = new LoadedAssetBundle(m_Request.assetBundle);
		}
	}
}
