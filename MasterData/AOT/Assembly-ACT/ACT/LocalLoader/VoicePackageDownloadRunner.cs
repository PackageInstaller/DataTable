using System;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.LocalLoader;

public sealed class VoicePackageDownloadRunner : MonoBehaviour
{
	private DownloadAsset _downloadAsset;

	private DownloadData _downloadData;

	private GameLoadingData _gameLoadingData;

	private Action<bool> _onComplete;

	private bool _isRunning;

	private bool _isEditorMockDownload;

	private bool _hasOpenedProcessView;

	private float _editorMockElapsedSeconds;

	private int _editorMockProcessOpenFrame;

	public bool IsRunning => _isRunning;

	public bool BeginDownload(string downloadTag, Action<bool> onComplete)
	{
		if (_isRunning)
		{
			return false;
		}
		if (string.IsNullOrWhiteSpace(downloadTag))
		{
			Debug.LogError("[VoicePackageDownloadRunner] Download tag is null or empty.");
			return false;
		}
		YooAssetInitData cachedYooAssetInitData = GameStart.CachedYooAssetInitData;
		if (cachedYooAssetInitData == null || cachedYooAssetInitData.ZipDownloadParam == null || cachedYooAssetInitData.YooAssetParam == null)
		{
			Debug.LogError("[VoicePackageDownloadRunner] YooAsset init data is not ready.");
			return false;
		}
		ZipInfo[] array = LuminApplication.RemoteConfig?.FullRawFileInfos;
		if (array == null || array.Length == 0)
		{
			Debug.LogError("[VoicePackageDownloadRunner] Full raw-file voice package config is unavailable.");
			return false;
		}
		_downloadData = new DownloadData();
		DownloadData downloadData = _downloadData;
		downloadData.CalSizeDone = (Action)Delegate.Combine(downloadData.CalSizeDone, new Action(OnCalSizeDone));
		GameStart.RegisterBackgroundDownloadData(_downloadData);
		ZipDownloadParam zipDownloadParam = new ZipDownloadParam();
		zipDownloadParam.DllZipDownloadURLs = null;
		zipDownloadParam.ClientStaticZipDownloadURLs = null;
		zipDownloadParam.AssetsZipDownloadURLs = null;
		zipDownloadParam.RawFileZipDownloadURLs = array;
		zipDownloadParam.DownloadTags = new string[1] { downloadTag };
		zipDownloadParam.IntegrityDownloadTags = new string[1] { downloadTag };
		zipDownloadParam.WriteVersionInfo = false;
		zipDownloadParam.UsePreDownloadedPackages = false;
		zipDownloadParam.Source = RemoteConfigZipSource.Normal;
		ZipDownloadParam zipDownloadParam2 = zipDownloadParam;
		YooAssetInitData yooAssetInitData = new YooAssetInitData
		{
			DownloadData = _downloadData,
			YooAssetParam = cachedYooAssetInitData.YooAssetParam,
			ZipDownloadParam = zipDownloadParam2,
			PackageInfos = cachedYooAssetInitData.PackageInfos
		};
		yooAssetInitData.InitPackageData();
		_gameLoadingData = new GameLoadingData();
		_downloadAsset = new DownloadAsset(yooAssetInitData);
		_onComplete = onComplete;
		_isRunning = true;
		_hasOpenedProcessView = false;
		SetCheckingProgress("正在检查语音包资源");
		Debug.Log($"[VoicePackageDownloadRunner] Starting voice package download: tag={downloadTag}, rawZipCount={array.Length}.");
		OnCalSizeDone();
		return true;
	}

	public bool BeginEditorMockDownload(Action<bool> onComplete)
	{
		if (_isRunning)
		{
			return false;
		}
		_downloadData = new DownloadData
		{
			AcceptUpdate = true,
			MaxDownloadBytes = 134217728L
		};
		_onComplete = onComplete;
		_isRunning = true;
		_hasOpenedProcessView = false;
		_isEditorMockDownload = true;
		_editorMockElapsedSeconds = 0f;
		_editorMockProcessOpenFrame = Time.frameCount + 2;
		SetCheckingProgress("正在准备模拟下载");
		Debug.Log("[VoicePackageDownloadRunner] Editor mock download started.");
		return true;
	}

	public void Cancel()
	{
		Cancel(notifyCompletion: true);
	}

	public void Cancel(bool notifyCompletion)
	{
		if (_downloadData != null)
		{
			_downloadData.CancelRequested = true;
		}
		Complete(success: false, notifyCompletion);
	}

	private void Update()
	{
		if (_isEditorMockDownload)
		{
			if (Time.frameCount >= _editorMockProcessOpenFrame)
			{
				if (_editorMockProcessOpenFrame != 0)
				{
					_editorMockProcessOpenFrame = 0;
					Debug.Log("[VoicePackageDownloadRunner] Opening editor mock download process view.");
					OnCalSizeDone();
				}
				else
				{
					UpdateEditorMockDownload();
				}
			}
		}
		else
		{
			if (!_isRunning || _downloadAsset == null)
			{
				return;
			}
			if (_downloadAsset.CurrentLoadState == EGameLoadingState.None)
			{
				GameLoadingData.CurStage = _downloadAsset.LoadingStage;
				_downloadAsset.Initialize(_gameLoadingData);
			}
			if (_downloadAsset.CurrentLoadState == EGameLoadingState.Loading)
			{
				_downloadAsset.Tick();
			}
			if (_isRunning)
			{
				if ((_downloadData != null && _downloadData.DownloadFail) || _downloadAsset.CurrentLoadState == EGameLoadingState.Failed)
				{
					Complete(success: false);
				}
				else if ((_downloadData != null && _downloadData.DownloadComplete) || _downloadAsset.CurrentLoadState == EGameLoadingState.Succeed)
				{
					Complete(success: true);
				}
			}
		}
	}

	private void OnDestroy()
	{
		Cancel(notifyCompletion: false);
	}

	private void OnCalSizeDone()
	{
		if (_isRunning && _downloadData != null && !_hasOpenedProcessView)
		{
			_downloadData.AcceptUpdate = true;
			_hasOpenedProcessView = true;
			if (!Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPDOWNLOADPROCESS, new PopupDownloadProcessViewData
			{
				downloadData = _downloadData,
				onCancel = OnCancelDownload
			}).IsValid)
			{
				Debug.LogError("[VoicePackageDownloadRunner] Failed to open the download process view.");
				_hasOpenedProcessView = false;
				Complete(success: false);
			}
		}
	}

	private void SetCheckingProgress(string stageName)
	{
		if (_downloadData != null)
		{
			_downloadData.SetEditorMockStage(ProgressStageType.Download);
			StageProgressData stageProgressData = _downloadData.GetStageProgressData(ProgressStageType.Download);
			stageProgressData.StageName = stageName;
			stageProgressData.Percent = 0f;
			stageProgressData.CurrentBytes = 0L;
			stageProgressData.TotalBytes = 0L;
			stageProgressData.SpeedBytesPerSecond = 0L;
			stageProgressData.IsActive = true;
			_downloadData.NotifyEditorMockStageProgressChanged(ProgressStageType.Download);
		}
	}

	private void OnCancelDownload()
	{
		Complete(success: false);
	}

	private void Complete(bool success, bool notifyCompletion = true)
	{
		if (_isRunning)
		{
			FinishComplete(success, notifyCompletion);
		}
	}

	private void FinishComplete(bool success, bool notifyCompletion)
	{
		if (!_isRunning)
		{
			return;
		}
		_isRunning = false;
		if (_downloadData != null)
		{
			DownloadData downloadData = _downloadData;
			downloadData.CalSizeDone = (Action)Delegate.Remove(downloadData.CalSizeDone, new Action(OnCalSizeDone));
			GameStart.UnregisterBackgroundDownloadData(_downloadData);
		}
		PopupDownloadProcessView popupDownloadProcessView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_POPUPDOWNLOADPROCESS) as PopupDownloadProcessView;
		if (popupDownloadProcessView != null)
		{
			if (success)
			{
				popupDownloadProcessView.ShowComplete();
			}
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPDOWNLOADPROCESS);
		}
		Action<bool> onComplete = _onComplete;
		_downloadAsset = null;
		_downloadData = null;
		_gameLoadingData = null;
		_onComplete = null;
		_isEditorMockDownload = false;
		_hasOpenedProcessView = false;
		_editorMockElapsedSeconds = 0f;
		_editorMockProcessOpenFrame = 0;
		if (notifyCompletion)
		{
			onComplete?.Invoke(success);
		}
	}

	private void UpdateEditorMockDownload()
	{
		if (!_isRunning || _downloadData == null)
		{
			return;
		}
		if (_downloadData.CancelRequested)
		{
			Complete(success: false);
			return;
		}
		_editorMockElapsedSeconds += Time.unscaledDeltaTime;
		if (_editorMockElapsedSeconds < 0.8f)
		{
			SetEditorMockProgress(ProgressStageType.Download, "模拟下载语音包", _editorMockElapsedSeconds / 0.8f, 0, 0, 134217728L, 16777216L);
		}
		else if (_editorMockElapsedSeconds < 1.2f)
		{
			SetEditorMockProgress(ProgressStageType.CheckIntegrity, "模拟校验资源", (_editorMockElapsedSeconds - 0.8f) / 0.4f, 0, 0, 0L, 0L);
		}
		else if (_editorMockElapsedSeconds < 2f)
		{
			float num = (_editorMockElapsedSeconds - 1.2f) / 0.8f;
			SetEditorMockProgress(ProgressStageType.Extract, "模拟解压语音包", num, Mathf.CeilToInt(num * 3f), 3, 0L, 0L);
		}
		else
		{
			_downloadData.DownloadComplete = true;
			Debug.Log("[VoicePackageDownloadRunner] Editor mock download completed.");
			Complete(success: true);
		}
	}

	private void SetEditorMockProgress(ProgressStageType stage, string stageName, float percent, int currentCount = 0, int totalCount = 0, long totalBytes = 0L, long speedBytesPerSecond = 0L)
	{
		_downloadData.SetEditorMockStage(stage);
		StageProgressData stageProgressData = _downloadData.GetStageProgressData(stage);
		stageProgressData.StageName = stageName;
		stageProgressData.Percent = Mathf.Clamp01(percent);
		stageProgressData.CurrentCount = currentCount;
		stageProgressData.TotalCount = totalCount;
		stageProgressData.TotalBytes = totalBytes;
		stageProgressData.CurrentBytes = ((totalBytes > 0) ? ((long)((float)totalBytes * stageProgressData.Percent)) : 0);
		stageProgressData.SpeedBytesPerSecond = speedBytesPerSecond;
		stageProgressData.IsActive = true;
		_downloadData.NotifyEditorMockStageProgressChanged(stage);
	}
}
