using System;
using System.Collections.Generic;
using ACT.Error;
using Cysharp.Threading.Tasks;
using UnityEngine;
using YooAsset;

namespace ACT;

internal class CheckResourceIntegrity : GameLoadingFlowBase
{
	private enum IntegrityCheckStep
	{
		CalculateSize = 1,
		WaitUserConfirm,
		Download,
		Complete
	}

	private YooAssetInitData _initData;

	private string[] _tags;

	private Dictionary<string, ResourceDownloaderOperation> _downloaders;

	private Dictionary<string, long> _packageCurrentBytes;

	private IntegrityCheckStep _currentStep;

	private long _totalDownloadBytes;

	private int _totalDownloadCount;

	private bool _isCalculating;

	private bool _isDownloading;

	private float _lastProgressUpdateTime;

	private long _lastProgressBytes;

	private const float ProgressUpdateInterval = 0.5f;

	internal override EGameLoadingStage Stage => EGameLoadingStage.CheckResourceIntegrity;

	internal override int TotalRetryCount => 0;

	private DownloadData _downloadData => _initData.DownloadData;

	private YooAssetParam _yooAssetParam => _initData.YooAssetParam;

	private Dictionary<AssetType, PackageInfo> _packageInfos => _initData.PackageInfos;

	internal CheckResourceIntegrity(YooAssetInitData initData, string[] tags = null)
	{
		_initData = initData;
		_tags = tags;
	}

	internal override void Init(GameLoadingData data)
	{
		if (_yooAssetParam.PlayMode == EPlayMode.OfflinePlayMode || _yooAssetParam.PlayMode == EPlayMode.EditorSimulateMode)
		{
			_loadState = EGameLoadingState.Succeed;
			return;
		}
		RemoteServices.UseIntegrityCdn = true;
		_currentStep = IntegrityCheckStep.CalculateSize;
		_loadState = EGameLoadingState.Loading;
		if (_downloadData != null)
		{
			_downloadData.SetStage(ProgressStageType.CheckIntegrity);
			_downloadData.Retry = Retry;
		}
	}

	internal override void Retry()
	{
		_loadState = EGameLoadingState.Loading;
		Log("Retry: 从步骤 CalculateSize 重新开始");
		ResetState();
		_downloadData.CurDownloadBytes = 0L;
		_downloadData.DownloadFail = false;
		_downloadData.CanRetry = false;
		_downloadData.DownloadComplete = false;
		_downloadData.AcceptUpdate = false;
		_currentStep = IntegrityCheckStep.CalculateSize;
	}

	private void ResetState()
	{
		_isCalculating = false;
		_isDownloading = false;
		_totalDownloadBytes = 0L;
		_totalDownloadCount = 0;
		_lastProgressUpdateTime = 0f;
		_lastProgressBytes = 0L;
		_downloaders?.Clear();
		_packageCurrentBytes?.Clear();
		if (_downloadData != null)
		{
			StageProgressData stageProgressData = _downloadData.GetStageProgressData(ProgressStageType.CheckIntegrity);
			stageProgressData.TotalBytes = 0L;
			stageProgressData.CurrentBytes = 0L;
			stageProgressData.Percent = 0f;
			stageProgressData.SpeedBytesPerSecond = 0L;
			stageProgressData.IsActive = false;
		}
	}

	internal override void Update()
	{
		if (_loadState == EGameLoadingState.Loading)
		{
			switch (_currentStep)
			{
			case IntegrityCheckStep.CalculateSize:
				CalculateSizeStep();
				break;
			case IntegrityCheckStep.WaitUserConfirm:
				WaitUserConfirmStep();
				break;
			case IntegrityCheckStep.Download:
				DownloadStep();
				break;
			case IntegrityCheckStep.Complete:
				_loadState = EGameLoadingState.Succeed;
				break;
			}
		}
	}

	private void CalculateSizeStep()
	{
		if (!_isCalculating)
		{
			_isCalculating = true;
			CalculateMissingResourcesSize();
		}
	}

	private void CalculateMissingResourcesSize()
	{
		try
		{
			_downloaders = new Dictionary<string, ResourceDownloaderOperation>();
			_totalDownloadBytes = 0L;
			_totalDownloadCount = 0;
			foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in _packageInfos)
			{
				PackageInfo value = packageInfo.Value;
				string packageName = value.PackageName;
				ResourcePackage package = value.Package;
				if (package == null)
				{
					LuminErrorAOT.ReportGameLoadingError("C03-0603", "03", 1);
					continue;
				}
				string[] integrityDownloadTags = GetIntegrityDownloadTags();
				ResourceDownloaderOperation resourceDownloaderOperation = ((integrityDownloadTags == null || integrityDownloadTags.Length <= 0) ? package.CreateResourceDownloader(int.MaxValue, 3) : CreateDownloadTagIntegrityDownloader(packageName, package, integrityDownloadTags));
				if (resourceDownloaderOperation.TotalDownloadCount > 0)
				{
					Log($"Package {packageName} has {resourceDownloaderOperation.TotalDownloadCount} missing files, total size: {resourceDownloaderOperation.TotalDownloadBytes} bytes");
					_downloaders[packageName] = resourceDownloaderOperation;
					_totalDownloadBytes += resourceDownloaderOperation.TotalDownloadBytes;
					_totalDownloadCount += resourceDownloaderOperation.TotalDownloadCount;
				}
			}
			if (_totalDownloadCount > 0)
			{
				Log($"Total missing files: {_totalDownloadCount}, total size: {_totalDownloadBytes} bytes");
				LuminErrorAOT.ReportGameLoadingError("C03-0600", "03", 0, "", retry: false, null, showDialog: false);
				if (_downloadData != null)
				{
					_downloadData.MaxDownloadBytes = _totalDownloadBytes;
					_downloadData.CurDownloadBytes = 0L;
					_downloadData.AcceptUpdate = false;
					_downloadData.CalSizeDone?.Invoke();
				}
				_currentStep = IntegrityCheckStep.WaitUserConfirm;
			}
			else
			{
				Log("All resources are complete, no missing files");
				_currentStep = IntegrityCheckStep.Complete;
			}
		}
		catch (Exception ex)
		{
			Exception(ex);
			_loadState = EGameLoadingState.Failed;
			LuminErrorAOT.ReportGameLoadingError("C03-0601", "03", 0, ex.Message);
		}
		finally
		{
			_isCalculating = false;
		}
	}

	private void WaitUserConfirmStep()
	{
		if (_downloadData != null && _downloadData.AcceptUpdate)
		{
			_currentStep = IntegrityCheckStep.Download;
		}
	}

	private void DownloadStep()
	{
		if (!_isDownloading)
		{
			_isDownloading = true;
			StartDownload().Forget();
		}
	}

	private async UniTaskVoid StartDownload()
	{
		try
		{
			_packageCurrentBytes = new Dictionary<string, long>();
			_lastProgressUpdateTime = 0f;
			_lastProgressBytes = 0L;
			if (_downloadData != null)
			{
				StageProgressData stageProgressData = _downloadData.GetStageProgressData(ProgressStageType.CheckIntegrity);
				stageProgressData.CurrentBytes = 0L;
				stageProgressData.TotalBytes = _downloadData.MaxDownloadBytes;
				stageProgressData.Percent = 0f;
				stageProgressData.SpeedBytesPerSecond = 0L;
				stageProgressData.IsActive = true;
				_downloadData.NotifyStageProgressChanged(ProgressStageType.CheckIntegrity);
			}
			long totalCurrentBytes = 0L;
			int totalCurrentCount = 0;
			foreach (KeyValuePair<string, ResourceDownloaderOperation> downloader2 in _downloaders)
			{
				string packageName = downloader2.Key;
				ResourceDownloaderOperation downloader = downloader2.Value;
				_packageCurrentBytes[packageName] = 0L;
				Log("开始下载Package " + packageName + " 的缺失资源...");
				downloader.DownloadUpdateCallback = (DownloadUpdateData data) =>
				{
					OnDownloadUpdate(packageName, data, ref totalCurrentBytes, ref totalCurrentCount);
				};
				downloader.DownloadErrorCallback = (DownloadErrorData data) =>
				{
					OnDownloadError(packageName, data);
				};
				downloader.BeginDownload();
				await downloader.ToUniTask();
				if (downloader.Status != EOperationStatus.Succeed)
				{
					Error("Failed to download missing resources for package " + packageName);
					_loadState = EGameLoadingState.Failed;
					LuminErrorAOT.ReportGameLoadingError("C01-0602", "01", 0);
					return;
				}
				Log("Package " + packageName + " resource integrity restored successfully");
			}
			if (_downloadData != null)
			{
				_downloadData.CurDownloadBytes = _downloadData.MaxDownloadBytes;
				StageProgressData stageProgressData2 = _downloadData.GetStageProgressData(ProgressStageType.CheckIntegrity);
				stageProgressData2.CurrentBytes = stageProgressData2.TotalBytes;
				stageProgressData2.Percent = 1f;
				stageProgressData2.IsActive = false;
				_downloadData.NotifyStageProgressChanged(ProgressStageType.CheckIntegrity);
			}
			_currentStep = IntegrityCheckStep.Complete;
		}
		catch (Exception ex)
		{
			Exception(ex);
			_loadState = EGameLoadingState.Failed;
			if (_downloadData != null)
			{
				LuminErrorAOT.ReportGameLoadingError("C01-0602", "01", 0, ex.Message);
			}
		}
		finally
		{
			_isDownloading = false;
			Log("已恢复默认CDN配置");
		}
	}

	private string[] GetIntegrityDownloadTags()
	{
		string[] tags = _tags;
		if (tags != null && tags.Length > 0)
		{
			return _tags;
		}
		return _initData.ZipDownloadParam?.IntegrityDownloadTags;
	}

	private ResourceDownloaderOperation CreateDownloadTagIntegrityDownloader(string packageName, ResourcePackage package, string[] tags)
	{
		ResourceDownloaderOperation resourceDownloaderOperation = package.CreateResourceDownloaderByDownloadTags(tags, int.MaxValue, 3);
		if (LuminApplication.LogEnabled)
		{
			Log("[IntegrityDownloadTag] Package=" + packageName + ", Tags=[" + string.Join(",", tags) + "], " + $"Downloader={resourceDownloaderOperation.TotalDownloadCount}/{resourceDownloaderOperation.TotalDownloadBytes}");
		}
		return resourceDownloaderOperation;
	}

	private void OnDownloadUpdate(string packageName, DownloadUpdateData data, ref long totalCurrentBytes, ref int totalCurrentCount)
	{
		_packageCurrentBytes[packageName] = data.CurrentDownloadBytes;
		totalCurrentBytes = 0L;
		foreach (long value in _packageCurrentBytes.Values)
		{
			totalCurrentBytes += value;
		}
		totalCurrentCount = data.CurrentDownloadCount;
		if (_downloadData != null)
		{
			float unscaledTime = Time.unscaledTime;
			if (unscaledTime - _lastProgressUpdateTime >= 0.5f)
			{
				long speedBytesPerSecond = CalculateDownloadSpeed(totalCurrentBytes, unscaledTime);
				_downloadData.CurDownloadBytes = totalCurrentBytes;
				float percent = ((_totalDownloadBytes > 0) ? ((float)totalCurrentBytes / (float)_totalDownloadBytes) : 0f);
				StageProgressData stageProgressData = _downloadData.GetStageProgressData(ProgressStageType.CheckIntegrity);
				stageProgressData.CurrentBytes = totalCurrentBytes;
				stageProgressData.Percent = percent;
				stageProgressData.SpeedBytesPerSecond = speedBytesPerSecond;
				_downloadData.NotifyStageProgressChanged(ProgressStageType.CheckIntegrity);
				_lastProgressBytes = totalCurrentBytes;
				_lastProgressUpdateTime = unscaledTime;
			}
		}
	}

	private long CalculateDownloadSpeed(long currentBytes, float now)
	{
		if (_lastProgressUpdateTime <= 0f)
		{
			return 0L;
		}
		float num = Mathf.Max(now - _lastProgressUpdateTime, float.Epsilon);
		long num2 = Math.Max(0L, currentBytes - _lastProgressBytes);
		if (num2 <= 0)
		{
			return 0L;
		}
		return (long)((float)num2 / num);
	}

	private void OnDownloadError(string packageName, DownloadErrorData data)
	{
		Error("[" + packageName + "] Download error for file " + data.FileName + ": " + data.ErrorInfo);
	}
}
