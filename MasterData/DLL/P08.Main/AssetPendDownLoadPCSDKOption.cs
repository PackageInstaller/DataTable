using System;
using System.Collections.Generic;
using System.IO;
using PCYsDownload;
using UnityEngine;
using YSDownloadCore;

public class AssetPendDownLoadPCSDKOption : AssetPendDownLoadOption
{
	private long currentDownloadSpeed;

	private long currentDownloadedSizeBySDK;

	private int sdk_down_load_state;

	private string errorInfo = "";

	private bool paused;

	private PCDownLoadManagerHotfix _downloadMgr
	{
		get
		{
			if (GameMain.isUseNewHotFix)
			{
				_ = YsDownloadSDK.Instance;
			}
			return PCDownLoadManagerHotfix.GetInstance() ?? PCDownLoadManagerHotfix.Create();
		}
	}

	public AssetPendDownLoadPCSDKOption(PendType pType, string key, AssetPendDownLoadManager manager)
		: base(pType, key, manager)
	{
		PCDownLoadManagerHotfix downloadMgr = _downloadMgr;
		downloadMgr.ProgressEvent = (PCDownLoadManagerHotfix.ProgressDelegate)Delegate.Combine(downloadMgr.ProgressEvent, new PCDownLoadManagerHotfix.ProgressDelegate(OnSDKDownLoadProgressUpdate));
		PCDownLoadManagerHotfix downloadMgr2 = _downloadMgr;
		downloadMgr2.SingleTaskEvent = (PCDownLoadManagerHotfix.SingleTaskDelegate)Delegate.Combine(downloadMgr2.SingleTaskEvent, new PCDownLoadManagerHotfix.SingleTaskDelegate(OnSDKDownLoadSingleComplete));
		PCDownLoadManagerHotfix downloadMgr3 = _downloadMgr;
		downloadMgr3.AllTaskEvent = (PCDownLoadManagerHotfix.AllTaskDelegate)Delegate.Combine(downloadMgr3.AllTaskEvent, new PCDownLoadManagerHotfix.AllTaskDelegate(OnSDKDownLoadAllTaskComplete));
	}

	public override void OnDestroy()
	{
		PCDownLoadManagerHotfix downloadMgr = _downloadMgr;
		downloadMgr.ProgressEvent = (PCDownLoadManagerHotfix.ProgressDelegate)Delegate.Remove(downloadMgr.ProgressEvent, new PCDownLoadManagerHotfix.ProgressDelegate(OnSDKDownLoadProgressUpdate));
		PCDownLoadManagerHotfix downloadMgr2 = _downloadMgr;
		downloadMgr2.SingleTaskEvent = (PCDownLoadManagerHotfix.SingleTaskDelegate)Delegate.Remove(downloadMgr2.SingleTaskEvent, new PCDownLoadManagerHotfix.SingleTaskDelegate(OnSDKDownLoadSingleComplete));
		PCDownLoadManagerHotfix downloadMgr3 = _downloadMgr;
		downloadMgr3.AllTaskEvent = (PCDownLoadManagerHotfix.AllTaskDelegate)Delegate.Remove(downloadMgr3.AllTaskEvent, new PCDownLoadManagerHotfix.AllTaskDelegate(OnSDKDownLoadAllTaskComplete));
	}

	public override void Pause()
	{
		paused = true;
		_downloadMgr.CancelDonload();
	}

	public override void Cancel()
	{
		paused = false;
		_downloadMgr.CancelDonload();
	}

	private void OnSDKDownLoadProgressUpdate(long currentOffset, int totalCount, int completedCount, int failedCount, string downloadSpeedStr)
	{
		currentDownloadedSizeBySDK = currentOffset;
		long.TryParse(downloadSpeedStr, out currentDownloadSpeed);
	}

	private void OnSDKDownLoadSingleComplete(int result, string filePath, long size, string urlFileName, string msg)
	{
		if (result == 0 && string.IsNullOrEmpty(msg))
		{
			m_currentSize += (ulong)size;
			if (base.m_totalSize != 0L)
			{
				OnProcess(m_currentSize / base.m_totalSize);
			}
		}
	}

	private void OnSDKDownLoadAllTaskComplete(int result, string msg)
	{
		if (result == 0)
		{
			sdk_down_load_state = 1;
		}
		else if (!string.IsNullOrEmpty(msg) && GameMain.IsDiskFull(msg))
		{
			Debug.LogError("====>>>> 热更下载资源,磁盘空间已满");
			errorInfo = GameMain.ConvertErrorInfo(msg);
			if (MessageBox.CanCallShow())
			{
				UnityMainThreadDispatcher.Instance.Enqueue(delegate
				{
					MessageBox.Show("MESSAGE_BOX_TITLE_ERROR".GetGameMainTextString(), errorInfo, delegate
					{
						Debug.LogError("OnSDKDownLoadAllTaskComplete 下载失败");
					});
				});
			}
			sdk_down_load_state = 2;
		}
		else if (!string.IsNullOrEmpty(msg) && msg == "cancel")
		{
			if (paused)
			{
				errorInfo = "User pause download";
				sdk_down_load_state = 3;
				paused = false;
			}
			else
			{
				errorInfo = "User cancel download";
				sdk_down_load_state = 2;
			}
		}
		else
		{
			errorInfo = "CHEACK_LOCAL_NETWORK_STATUS_TITLE";
			sdk_down_load_state = 2;
		}
	}

	protected override void StartDownload()
	{
		List<string> list = new List<string>();
		sdk_down_load_state = 0;
		foreach (KeyValuePair<string, AssetDownloadInfo> item in m_pendingDownloadDict)
		{
			AssetDownloadInfo value = item.Value;
			string sdkPath = value.sdkPath;
			list.Add($"{sdkPath},{value.size},{Path.GetFileName(value.fileName)}");
		}
		if (0 < list.Count)
		{
			_downloadMgr.Download(GameToSDK.vClientResVersionInfo.MainDownloadUrl(), Platform.GetDownloadPersistentDataPath(), list.ToArray());
		}
		else
		{
			OnSuccessed();
		}
	}

	public override void OnUpdate()
	{
		if (1 == sdk_down_load_state)
		{
			OnSuccessed();
		}
		else if (2 == sdk_down_load_state)
		{
			OnFailed(errorInfo);
		}
		else if (3 == sdk_down_load_state)
		{
			OnPause();
		}
		sdk_down_load_state = 0;
	}

	public override string GetSpeed()
	{
		long num = currentDownloadSpeed;
		float num2 = ((num > 1048576) ? AssetPendDownLoadManager.ConvertSize(num, "MB") : AssetPendDownLoadManager.ConvertSize(num, "KB"));
		string arg = ((num > 1048576) ? "MB" : "KB");
		return $"{num2:F2}{arg}";
	}
}
