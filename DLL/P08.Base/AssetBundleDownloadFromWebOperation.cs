using System;
using UnityEngine;
using UnityEngine.Networking;

public class AssetBundleDownloadFromWebOperation : AssetBundleDownloadOperation
{
	private UnityWebRequest m_WWW;

	private string m_Url;

	protected override bool downloadIsDone
	{
		get
		{
			if (m_WWW != null)
			{
				return m_WWW.isDone;
			}
			return true;
		}
	}

	public AssetBundleDownloadFromWebOperation(string assetBundleName, UnityWebRequest www)
		: base(assetBundleName)
	{
		if (www == null)
		{
			throw new ArgumentNullException("www");
		}
		m_Url = www.url;
		m_WWW = www;
	}

	protected override void FinishDownload()
	{
		base.error = m_WWW.error;
		if (!string.IsNullOrEmpty(base.error))
		{
			return;
		}
		if (m_WWW.downloadHandler is DownloadHandlerAssetBundle)
		{
			AssetBundle assetBundle = (m_WWW.downloadHandler as DownloadHandlerAssetBundle).assetBundle;
			if (assetBundle == null)
			{
				base.error = $"{base.assetBundleName} is not a valid asset bundle.";
			}
			else
			{
				base.assetBundle = new LoadedAssetBundle(assetBundle);
			}
		}
		m_WWW.Dispose();
		m_WWW = null;
	}

	public override string GetSourceURL()
	{
		return m_Url;
	}
}
