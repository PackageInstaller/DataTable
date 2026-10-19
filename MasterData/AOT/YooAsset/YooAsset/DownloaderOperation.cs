using System.Collections.Generic;
using UnityEngine;

namespace YooAsset;

public abstract class DownloaderOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		Check,
		Loading,
		Done
	}

	public delegate void DownloaderFinish(DownloaderFinishData data);

	public delegate void DownloadUpdate(DownloadUpdateData data);

	public delegate void DownloadError(DownloadErrorData data);

	public delegate void DownloadFileBegin(DownloadFileData data);

	private const int MAX_LOADER_COUNT = 64;

	private readonly string _packageName;

	private readonly int _downloadingMaxNumber;

	private readonly int _failedTryAgain;

	private readonly int _timeout;

	private readonly List<BundleInfo> _bundleInfoList;

	private readonly List<FSDownloadFileOperation> _downloaders = new List<FSDownloadFileOperation>(64);

	private readonly List<FSDownloadFileOperation> _removeList = new List<FSDownloadFileOperation>(64);

	private readonly List<FSDownloadFileOperation> _failedList = new List<FSDownloadFileOperation>(64);

	private bool _isPause;

	private long _lastDownloadBytes;

	private int _lastDownloadCount;

	private long _cachedDownloadBytes;

	private int _cachedDownloadCount;

	private ESteps _steps;

	public int TotalDownloadCount { get; private set; }

	public long TotalDownloadBytes { get; private set; }

	public int CurrentDownloadCount => _lastDownloadCount;

	public long CurrentDownloadBytes => _lastDownloadBytes;

	public DownloaderFinish DownloadFinishCallback { get; set; }

	public DownloadUpdate DownloadUpdateCallback { get; set; }

	public DownloadError DownloadErrorCallback { get; set; }

	public DownloadFileBegin DownloadFileBeginCallback { get; set; }

	internal DownloaderOperation(string packageName, List<BundleInfo> downloadList, int downloadingMaxNumber, int failedTryAgain, int timeout)
	{
		_packageName = packageName;
		_bundleInfoList = downloadList;
		_downloadingMaxNumber = Mathf.Clamp(downloadingMaxNumber, 1, 64);
		_failedTryAgain = failedTryAgain;
		_timeout = timeout;
		SetPackageName(packageName);
		CalculatDownloaderInfo();
	}

	internal override void InternalStart()
	{
		_steps = ESteps.Check;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.Check)
		{
			if (_bundleInfoList == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Download list is null.";
			}
			else
			{
				_steps = ESteps.Loading;
			}
		}
		if (_steps != ESteps.Loading)
		{
			return;
		}
		_removeList.Clear();
		long num = _cachedDownloadBytes;
		foreach (FSDownloadFileOperation downloader in _downloaders)
		{
			downloader.UpdateOperation();
			num += downloader.DownloadedBytes;
			if (downloader.IsDone)
			{
				if (downloader.Status != EOperationStatus.Succeed)
				{
					_removeList.Add(downloader);
					_failedList.Add(downloader);
				}
				else
				{
					_removeList.Add(downloader);
					_cachedDownloadCount++;
					_cachedDownloadBytes += downloader.DownloadedBytes;
				}
			}
		}
		foreach (FSDownloadFileOperation remove in _removeList)
		{
			_downloaders.Remove(remove);
		}
		if (_lastDownloadBytes != num || _lastDownloadCount != _cachedDownloadCount)
		{
			_lastDownloadBytes = num;
			_lastDownloadCount = _cachedDownloadCount;
			Progress = (float)_lastDownloadBytes / (float)TotalDownloadBytes;
			if (DownloadUpdateCallback != null)
			{
				DownloadUpdateData data = new DownloadUpdateData
				{
					PackageName = _packageName,
					Progress = Progress,
					TotalDownloadCount = TotalDownloadCount,
					CurrentDownloadCount = _lastDownloadCount,
					TotalDownloadBytes = TotalDownloadBytes,
					CurrentDownloadBytes = _lastDownloadBytes
				};
				DownloadUpdateCallback(data);
			}
		}
		if (_bundleInfoList.Count > 0 && _failedList.Count == 0)
		{
			if (_isPause)
			{
				return;
			}
			if (_downloaders.Count < _downloadingMaxNumber)
			{
				int index = _bundleInfoList.Count - 1;
				BundleInfo bundleInfo = _bundleInfoList[index];
				FSDownloadFileOperation fSDownloadFileOperation = bundleInfo.CreateDownloader(_failedTryAgain, _timeout);
				fSDownloadFileOperation.StartOperation();
				AddChildOperation(fSDownloadFileOperation);
				_downloaders.Add(fSDownloadFileOperation);
				_bundleInfoList.RemoveAt(index);
				if (DownloadFileBeginCallback != null)
				{
					DownloadFileData data2 = new DownloadFileData
					{
						PackageName = _packageName,
						FileName = bundleInfo.Bundle.BundleName,
						FileSize = bundleInfo.Bundle.FileSize
					};
					DownloadFileBeginCallback(data2);
				}
			}
		}
		if (_downloaders.Count != 0)
		{
			return;
		}
		if (_failedList.Count > 0)
		{
			FSDownloadFileOperation fSDownloadFileOperation2 = _failedList[0];
			string bundleName = fSDownloadFileOperation2.Bundle.BundleName;
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "Failed to download file : " + bundleName;
			if (DownloadErrorCallback != null)
			{
				DownloadErrorData data3 = new DownloadErrorData
				{
					PackageName = _packageName,
					FileName = bundleName,
					ErrorInfo = fSDownloadFileOperation2.Error
				};
				DownloadErrorCallback(data3);
			}
			if (DownloadFinishCallback != null)
			{
				DownloaderFinishData data4 = new DownloaderFinishData
				{
					PackageName = _packageName,
					Succeed = false
				};
				DownloadFinishCallback(data4);
			}
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
			if (DownloadFinishCallback != null)
			{
				DownloaderFinishData data5 = new DownloaderFinishData
				{
					PackageName = _packageName,
					Succeed = true
				};
				DownloadFinishCallback(data5);
			}
		}
	}

	private void CalculatDownloaderInfo()
	{
		if (_bundleInfoList != null)
		{
			TotalDownloadBytes = 0L;
			TotalDownloadCount = _bundleInfoList.Count;
			{
				foreach (BundleInfo bundleInfo in _bundleInfoList)
				{
					TotalDownloadBytes += bundleInfo.Bundle.FileSize;
				}
				return;
			}
		}
		TotalDownloadBytes = 0L;
		TotalDownloadCount = 0;
	}

	public void Combine(DownloaderOperation downloader)
	{
		if (_packageName != downloader._packageName)
		{
			YooLogger.Error("The downloaders have different resource packages !");
			return;
		}
		if (Status != EOperationStatus.None)
		{
			YooLogger.Error("The downloader is running, can not combine with other downloader !");
			return;
		}
		HashSet<string> hashSet = new HashSet<string>();
		foreach (BundleInfo bundleInfo in _bundleInfoList)
		{
			string downloadCombineGUID = bundleInfo.GetDownloadCombineGUID();
			if (!hashSet.Contains(downloadCombineGUID))
			{
				hashSet.Add(downloadCombineGUID);
			}
		}
		foreach (BundleInfo bundleInfo2 in downloader._bundleInfoList)
		{
			string downloadCombineGUID2 = bundleInfo2.GetDownloadCombineGUID();
			if (!hashSet.Contains(downloadCombineGUID2))
			{
				_bundleInfoList.Add(bundleInfo2);
			}
		}
		CalculatDownloaderInfo();
	}

	public void BeginDownload()
	{
		if (_steps == ESteps.None)
		{
			OperationSystem.StartOperation(_packageName, this);
		}
	}

	public void PauseDownload()
	{
		_isPause = true;
	}

	public void ResumeDownload()
	{
		_isPause = false;
	}

	public void CancelDownload()
	{
		if (_steps == ESteps.Done)
		{
			return;
		}
		_steps = ESteps.Done;
		Status = EOperationStatus.Failed;
		Error = "User cancel.";
		foreach (FSDownloadFileOperation downloader in _downloaders)
		{
			downloader.Release();
		}
	}
}
