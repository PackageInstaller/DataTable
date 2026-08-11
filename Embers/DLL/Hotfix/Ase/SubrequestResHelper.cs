#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using YooAsset;

namespace Ase;

public class SubrequestResHelper : Singleton<SubrequestResHelper>, ISingletonUpdate
{
	public enum DownloadStatus
	{
		Idle,
		Downloading,
		Paused,
		Retrying,
		Failed,
		Success
	}

	private MultiPackageDownloader downloader;

	private bool isDownloading;

	private long downloadSpeed;

	private float _startTime;

	private float _finishTime;

	private long _lastDownloadedBytes;

	private float _lastSpeedUpdateTime;

	private const float SPEED_UPDATE_INTERVAL = 2f;

	private int _currentRetryCount;

	private const int MAX_RETRY_COUNT = 3;

	private const float RETRY_INTERVAL = 5f;

	private float _lastRetryTime;

	private string _lastError = "";

	private bool _isWaitingRetry;

	private bool _networkTip;

	private bool _networkExceptionPause;

	private GameProcessType _gameProcessType;

	private DownloadStatus _currentStatus;

	private string _statusText = "等待下载";

	public Action<float, long, long, string> EnhancedProgressCallback { get; set; }

	public async UniTask DownSubrequestRes(bool showTips = true, Action<float, long, long> progressCallback = null)
	{
		if (GameEntry.BuiltinData.IsFirstResourceUpdate)
		{
			return;
		}
		_currentRetryCount = 0;
		_lastError = "";
		_currentStatus = DownloadStatus.Downloading;
		UpdateStatusText("准备下载");
		try
		{
			if (downloader != null)
			{
				downloader.CancelDownload();
				downloader = null;
			}
			downloader = new MultiPackageDownloader();
			string[] resourcePackages = ResourcesExtension.ResourcePackages;
			foreach (string customPackageName in resourcePackages)
			{
				ResourceDownloaderOperation val = GameEntry.Resource.CreateResourceDownloader(customPackageName, "downloadRes");
				if (((DownloaderOperation)val).TotalDownloadBytes > 0)
				{
					downloader.AddDownloader((DownloaderOperation)(object)val);
				}
			}
			resourcePackages = ResourcesExtension.AudioResourcePackages;
			foreach (string customPackageName2 in resourcePackages)
			{
				ResourceDownloaderOperation val2 = GameEntry.Resource.CreateResourceDownloader(customPackageName2, "downloadRes");
				if (((DownloaderOperation)val2).TotalDownloadBytes > 0)
				{
					downloader.AddDownloader((DownloaderOperation)(object)val2);
				}
			}
			if (downloader.GetTotalDownloadBytes() > 0)
			{
				_lastDownloadedBytes = 0L;
				_lastSpeedUpdateTime = 0f;
				downloadSpeed = 0L;
				bool flag = showTips;
				if (flag)
				{
					flag = await DownloadAlertDialog(downloader.GetTotalDownloadBytes());
				}
				bool result = flag;
				TDAHandler.Instance.ResourceDownloadReport("background_download_star", FileSizeUtility.ToMb(downloader.GetTotalDownloadBytes()), "Confirm", 0.0, 0.0, "", "立即下载");
				downloader.DownloadUpdateCallback = delegate(long currentDownloadBytes, long totalDownloadBytes, int currentDownloadCount, int totalDownloadCount, float progress)
				{
					UpdateDownloadSpeed(currentDownloadBytes);
					if (_currentStatus == DownloadStatus.Downloading)
					{
						UpdateStatusText($"下载中: {progress * 100f:F1}%");
					}
					if ((progressCallback != null) & result)
					{
						progressCallback(downloader.GetProgress(), currentDownloadBytes, totalDownloadBytes);
					}
				};
				downloader.DownloadErrorCallback = (DownloadError)delegate(DownloadErrorData data)
				{
					//IL_0016: Unknown result type (might be due to invalid IL or missing references)
					//IL_0027: Unknown result type (might be due to invalid IL or missing references)
					//IL_0038: Unknown result type (might be due to invalid IL or missing references)
					_lastError = "文件 " + data.FileName + " 包 " + data.PackageName + " 下载失败: " + data.ErrorInfo;
					Log.Error(_lastError);
				};
				if (result)
				{
					await ExecuteDownloadWithRetry();
					return;
				}
				isDownloading = true;
				_startTime = GetCurrentTime();
				downloader.DownloadAll().ContinueWith(delegate
				{
					isDownloading = false;
					if (downloader.IsAllSucceed())
					{
						_currentStatus = DownloadStatus.Success;
						UpdateStatusText("下载完成");
						_finishTime = GetCurrentTime();
						TDAHandler.Instance.ResourceDownloadReport("background_download_finish", FileSizeUtility.ToMb(downloader.GetTotalDownloadBytes()), "Confirm", downloader.GetCurrentDownloadBytes(), downloadSpeed, "", "立即下载", _startTime.ToString(), (_finishTime - _startTime).ToString());
						GameEntry.BuiltinData.RecordFirstResourceUpdaterStatus(1);
					}
					else
					{
						HandleBackgroundDownloadFailure();
					}
				});
			}
			else
			{
				_currentStatus = DownloadStatus.Success;
				UpdateStatusText("下载完成");
				downloader = null;
			}
		}
		catch (Exception ex)
		{
			_currentStatus = DownloadStatus.Failed;
			Log.Error("下载过程发生异常: " + ex.Message);
			await ShowErrorDialog("下载失败");
		}
	}

	private async UniTask ExecuteDownloadWithRetry()
	{
		while (_currentRetryCount <= 3)
		{
			try
			{
				if (_currentRetryCount > 0)
				{
					_currentStatus = DownloadStatus.Retrying;
					UpdateStatusText($"第{_currentRetryCount}次重试尝试...");
					await ShowRetryDialog();
					await UniTask.Delay(TimeSpan.FromSeconds(5.0));
				}
				UpdateStatusText("开始下载");
				await downloader.DownloadAll();
				if (downloader.IsAllSucceed())
				{
					_currentStatus = DownloadStatus.Success;
					UpdateStatusText("下载完成");
					GameEntry.BuiltinData.RecordFirstResourceUpdaterStatus(1);
					break;
				}
				throw new Exception("下载器报告下载未完全成功");
			}
			catch (Exception ex)
			{
				_currentRetryCount++;
				_lastError = ex.Message;
				if (_currentRetryCount > 3)
				{
					_currentStatus = DownloadStatus.Failed;
					Log.Error($"资源下载失败，已达最大重试次数{3}");
					await ShowFinalErrorDialog();
					break;
				}
			}
		}
	}

	private async void HandleBackgroundDownloadFailure()
	{
		if (_currentRetryCount < 3)
		{
			_currentRetryCount++;
			await UniTask.Delay(TimeSpan.FromSeconds(5.0));
			await DownSubrequestRes(showTips: false);
		}
		else
		{
			_currentStatus = DownloadStatus.Failed;
			UpdateStatusText("下载失败");
			Log.Error("后台下载最终失败");
		}
	}

	private async UniTask ShowErrorDialog(string title)
	{
		if (await AlertDialog.Show(title, "后续资源更新失败", "重试", "取消") == -1)
		{
			_currentRetryCount = 0;
			await DownSubrequestRes(showTips: false);
		}
	}

	private async UniTask ShowRetryDialog()
	{
		if (await AlertDialog.Show("下载重试", "是否继续尝试？", "继续", "取消") != -1)
		{
			throw new OperationCanceledException("用户取消下载重试");
		}
	}

	private async UniTask ShowFinalErrorDialog()
	{
		string message = $"下载失败，已重试{3}次仍无法完成。\n错误信息: {_lastError}\n";
		await AlertDialog.Show("下载失败", message, "确定", null);
	}

	private void UpdateStatusText(string status)
	{
		_statusText = status;
	}

	public void ResumeDownload()
	{
		if (downloader != null && _currentStatus == DownloadStatus.Paused)
		{
			if (_currentRetryCount >= 3)
			{
				_currentRetryCount = 0;
			}
			_currentStatus = DownloadStatus.Downloading;
			isDownloading = true;
			downloader.ResumeDownload();
			UpdateStatusText("下载中");
			_lastDownloadedBytes = downloader.GetCurrentDownloadBytes();
			_lastSpeedUpdateTime = GetCurrentTime();
		}
	}

	public void PauseDownload()
	{
		if (downloader != null && _currentStatus == DownloadStatus.Downloading)
		{
			_currentStatus = DownloadStatus.Paused;
			isDownloading = false;
			downloader.PauseDownload();
			UpdateStatusText("已暂停");
			TDAHandler.Instance.ResourceDownloadReport("background_download_pause", FileSizeUtility.ToMb(downloader.GetTotalDownloadBytes()), "Confirm", downloader.GetCurrentDownloadBytes(), downloadSpeed, "", "立即下载", _startTime.ToString());
			downloadSpeed = 0L;
		}
	}

	public DownloadStatus GetCurrentStatus()
	{
		return _currentStatus;
	}

	public string GetStatusText()
	{
		return _statusText;
	}

	public int GetCurrentRetryCount()
	{
		return _currentRetryCount;
	}

	public int GetMaxRetryCount()
	{
		return 3;
	}

	public void ResetSubrequestResStatus()
	{
		GameEntry.BuiltinData.RecordFirstResourceUpdaterStatus(0);
		_currentStatus = DownloadStatus.Idle;
		UpdateStatusText("等待下载");
	}

	public bool IsProcessing()
	{
		return _currentStatus == DownloadStatus.Downloading;
	}

	public float GetProgress()
	{
		if (downloader != null)
		{
			return downloader.GetProgress();
		}
		return 1f;
	}

	public string GetDownloadStatusInfo(string format)
	{
		if (_currentStatus != DownloadStatus.Downloading)
		{
			return _statusText;
		}
		return string.Format(format, GetProgress() * 100f, (float)downloadSpeed / 1048576f);
	}

	public string GetDownloadSpeedInMBps()
	{
		if (_currentStatus != DownloadStatus.Downloading)
		{
			return _statusText;
		}
		return $"{(float)downloadSpeed / 1048576f:F2}M/s";
	}

	public string GetDownloadSpeedInBytes()
	{
		return $"{downloadSpeed}B/s";
	}

	private void UpdateDownloadSpeed(long currentDownloadBytes)
	{
		float currentTime = GetCurrentTime();
		if (_lastSpeedUpdateTime == 0f)
		{
			_lastDownloadedBytes = currentDownloadBytes;
			_lastSpeedUpdateTime = currentTime;
			return;
		}
		float num = currentTime - _lastSpeedUpdateTime;
		if (num >= 2f)
		{
			long num2 = currentDownloadBytes - _lastDownloadedBytes;
			downloadSpeed = (long)((float)num2 / num);
			_lastDownloadedBytes = currentDownloadBytes;
			_lastSpeedUpdateTime = currentTime;
		}
	}

	private float GetCurrentTime()
	{
		return Time.realtimeSinceStartup;
	}

	private async UniTask<bool> DownloadAlertDialog(long totalDownloadBytes)
	{
		int num = await DownloadModelChooseWindow.Show(totalDownloadBytes, "POPUP");
		if (num == 1)
		{
			TDAHandler.Instance.ResourceDownloadReport("resource_download_pop", FileSizeUtility.ToMb(totalDownloadBytes), "Confirm", 0.0, 0.0, "", "立即下载");
		}
		else
		{
			TDAHandler.Instance.ResourceDownloadReport("resource_download_pop", FileSizeUtility.ToMb(totalDownloadBytes), "Confirm", 0.0, 0.0, "", "后台下载");
		}
		return num == 1;
	}

	public void Update()
	{
		if (Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork)
		{
			if (IsProcessing() && !_networkTip)
			{
				_networkTip = true;
				Toast.ShowInfo("当前网络环境为移动网，请注意流量消耗");
			}
			return;
		}
		if (Application.internetReachability == NetworkReachability.NotReachable)
		{
			if (IsProcessing() && !_networkExceptionPause)
			{
				Toast.ShowInfo("当前网络环境为移动网，请注意流量消耗");
				PauseDownload();
				_networkExceptionPause = true;
			}
			return;
		}
		if (_networkTip)
		{
			_networkTip = false;
		}
		if (_networkExceptionPause)
		{
			ResumeDownload();
			_networkExceptionPause = false;
		}
	}

	public void OnGameProcessChanged(GameProcessType loadingType)
	{
		_gameProcessType = loadingType;
		if (loadingType == GameProcessType.Battle)
		{
			PauseDownload();
		}
		else
		{
			_ = 2;
		}
	}

	public GameProcessType GetCurDownloadGameProcess()
	{
		return _gameProcessType;
	}
}
