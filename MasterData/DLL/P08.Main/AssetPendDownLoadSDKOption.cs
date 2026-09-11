using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using YSDownloadCore;

public class AssetPendDownLoadSDKOption : AssetPendDownLoadOption
{
	private long currentDownloadSpeed;

	private long currentDownloadedSizeBySDK;

	private int sdk_down_load_state;

	private string errorInfo = "";

	private bool paused;

	public AssetPendDownLoadSDKOption(PendType pType, string key, AssetPendDownLoadManager manager)
		: base(pType, key, manager)
	{
		YsDownloadEvent instance = YsDownloadEvent.Instance;
		instance.ProgressEvent = (YsDownloadEvent.ProgressDelegate)Delegate.Combine(instance.ProgressEvent, new YsDownloadEvent.ProgressDelegate(OnSDKDownLoadProgressUpdate));
		YsDownloadEvent instance2 = YsDownloadEvent.Instance;
		instance2.SingleTaskEvent = (YsDownloadEvent.SingleTaskDelegate)Delegate.Combine(instance2.SingleTaskEvent, new YsDownloadEvent.SingleTaskDelegate(OnSDKDownLoadSingleComplete));
		YsDownloadEvent instance3 = YsDownloadEvent.Instance;
		instance3.AllTaskEvent = (YsDownloadEvent.AllTaskDelegate)Delegate.Combine(instance3.AllTaskEvent, new YsDownloadEvent.AllTaskDelegate(OnSDKDownLoadAllTaskComplete));
	}

	public override void OnDestroy()
	{
		YsDownloadEvent instance = YsDownloadEvent.Instance;
		instance.ProgressEvent = (YsDownloadEvent.ProgressDelegate)Delegate.Remove(instance.ProgressEvent, new YsDownloadEvent.ProgressDelegate(OnSDKDownLoadProgressUpdate));
		YsDownloadEvent instance2 = YsDownloadEvent.Instance;
		instance2.SingleTaskEvent = (YsDownloadEvent.SingleTaskDelegate)Delegate.Remove(instance2.SingleTaskEvent, new YsDownloadEvent.SingleTaskDelegate(OnSDKDownLoadSingleComplete));
		YsDownloadEvent instance3 = YsDownloadEvent.Instance;
		instance3.AllTaskEvent = (YsDownloadEvent.AllTaskDelegate)Delegate.Remove(instance3.AllTaskEvent, new YsDownloadEvent.AllTaskDelegate(OnSDKDownLoadAllTaskComplete));
	}

	public override void Pause()
	{
		paused = true;
		YsDownloadSDK.Instance.CancelDownload();
	}

	public override void Cancel()
	{
		paused = false;
		YsDownloadSDK.Instance.CancelDownload();
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
			YsDownloadSDK.Instance.Download(GameToSDK.vClientResVersionInfo.MainDownloadUrl(), Platform.GetDownloadPersistentDataPath(), list.ToArray());
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
