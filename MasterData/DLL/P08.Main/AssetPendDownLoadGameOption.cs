using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class AssetPendDownLoadGameOption : AssetPendDownLoadOption
{
	private const int MAX_TRY_TIMES = 5;

	private Dictionary<string, DownloadRequest> m_processingRequest = new Dictionary<string, DownloadRequest>();

	public AssetPendDownLoadGameOption(PendType pType, string key, AssetPendDownLoadManager manager)
		: base(pType, key, manager)
	{
		m_processingRequest = new Dictionary<string, DownloadRequest>();
	}

	public override void OnDestroy()
	{
		foreach (KeyValuePair<string, DownloadRequest> item in m_processingRequest)
		{
			item.Value.Pure();
		}
		m_processingRequest.Clear();
	}

	public override void Pause()
	{
		OnPause();
	}

	public override void Cancel()
	{
		OnFailed("Cancel");
	}

	protected override void StartDownload()
	{
		m_processingRequest.Clear();
		foreach (KeyValuePair<string, AssetDownloadInfo> item in m_pendingDownloadDict)
		{
			AssetDownloadInfo value = item.Value;
			if (!m_processingRequest.ContainsKey(value.path))
			{
				DownloadRequest value2 = Asset.StartDownloadWitchCache(value.url, value.path, OnDownloadCallback);
				m_processingRequest[value.path] = value2;
			}
		}
	}

	private void OnDownloadCallback(DownloadRequest www)
	{
		string text = (string)www.userData;
		if (!m_processingRequest.ContainsKey(text))
		{
			return;
		}
		if (www.isDone && string.IsNullOrEmpty(www.GetError()))
		{
			if (File.Exists(text))
			{
				m_currentSize += (ulong)new FileInfo(text).Length;
				if (base.m_totalSize != 0L)
				{
					OnProcess((float)m_currentSize / (float)base.m_totalSize);
				}
			}
			www.Dispose();
			m_processingRequest.Remove(text);
			if (m_processingRequest.Count == 0)
			{
				OnSuccessed();
			}
		}
		else if (!string.IsNullOrEmpty(www.GetError()) && GameMain.IsDiskFull(www.GetError()))
		{
			Debug.LogError("====>>>> 磁盘空间已满");
			string errorInfo = GameMain.ConvertErrorInfo(www.GetError());
			www.Dispose();
			if (!MessageBox.CanCallShow())
			{
				return;
			}
			UnityMainThreadDispatcher.Instance.Enqueue(delegate
			{
				MessageBox.Show("MESSAGE_BOX_TITLE_ERROR".GetGameMainTextString(), errorInfo, delegate
				{
					Debug.LogError("OnDownloadCallback 下载失败");
				});
			});
		}
		else if (www.retryUrlIndex > 5)
		{
			www.Dispose();
			string gameMainTextString = "CHEACK_LOCAL_NETWORK_STATUS_TITLE".GetGameMainTextString();
			OnFailed(gameMainTextString);
		}
		else
		{
			string[] array = GameToSDK.vClientResVersionInfo.AllDownloadUrls();
			string newUrl = array[++www.retryUrlIndex % array.Length] + Path.GetFileName(m_pendingDownloadDict[text].fileName);
			DownloadManager.Instance.TryFixFailedRequest(www, newUrl);
		}
	}

	public override void OnUpdate()
	{
	}

	public override string GetSpeed()
	{
		long downloadSpeed = DownloadManager.Instance.downloadSpeed;
		float num = ((downloadSpeed > 1048576) ? AssetPendDownLoadManager.ConvertSize(downloadSpeed, "MB") : AssetPendDownLoadManager.ConvertSize(downloadSpeed, "KB"));
		string arg = ((downloadSpeed > 1048576) ? "MB" : "KB");
		return $"{num:F2}{arg}";
	}
}
