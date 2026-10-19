using ACT.LocalLoader;
using UnityEngine;

namespace ACT.UI;

public sealed class PreDownloadAssetRunner : MonoBehaviour
{
	private static PreDownloadAssetRunner _instance;

	private DownloadAsset _downloadAsset;

	private DownloadData _downloadData;

	private GameLoadingData _gameLoadingData;

	private MonoLoginWaitClickView _loginWaitClickView;

	private PopupPreDownloadPromptView _promptView;

	private bool _isRunning;

	public static bool IsRunning
	{
		get
		{
			if (_instance != null)
			{
				return _instance._isRunning;
			}
			return false;
		}
	}

	public static bool StartPreDownload(PopupPreDownloadPromptView promptView)
	{
		if (_instance != null)
		{
			Debug.LogWarning("[PreDownloadAssetRunner] Pre-download is already running.");
			return false;
		}
		GameObject gameObject = new GameObject("PreDownloadAssetRunner");
		Object.DontDestroyOnLoad(gameObject);
		if ((_instance = gameObject.AddComponent<PreDownloadAssetRunner>()).BeginDownload(promptView))
		{
			return true;
		}
		Object.Destroy(gameObject);
		return false;
	}

	public static void CancelPreDownload()
	{
		_instance?.Cancel();
	}

	private bool BeginDownload(PopupPreDownloadPromptView promptView)
	{
		if (!GameStart.TryCreatePreDownloadAsset(out _downloadAsset, out _downloadData))
		{
			Debug.LogError("[PreDownloadAssetRunner] Unable to create pre-download asset.");
			return false;
		}
		_loginWaitClickView = Object.FindFirstObjectByType<MonoLoginWaitClickView>();
		if (_loginWaitClickView == null)
		{
			Debug.LogError("[PreDownloadAssetRunner] LoginWaitClickView is not available for pre-download progress.");
			return false;
		}
		_gameLoadingData = new GameLoadingData();
		_promptView = promptView;
		_downloadData.AcceptUpdate = true;
		_isRunning = true;
		GameLoadingData.CurStage = _downloadAsset.LoadingStage;
		_downloadAsset.Initialize(_gameLoadingData);
		GameStart.RegisterBackgroundDownloadData(_downloadData);
		_loginWaitClickView.BeginPreDownloadDisplay(_downloadData);
		Debug.Log("[PreDownloadAssetRunner] Pre-download started.");
		return true;
	}

	private void Update()
	{
		if (_isRunning && _downloadAsset != null)
		{
			if (_downloadAsset.CurrentLoadState == EGameLoadingState.Loading)
			{
				_downloadAsset.Tick();
			}
			if ((_downloadData != null && _downloadData.DownloadComplete) || _downloadAsset.CurrentLoadState == EGameLoadingState.Succeed)
			{
				Complete();
			}
			else if ((_downloadData != null && _downloadData.DownloadFail) || _downloadAsset.CurrentLoadState == EGameLoadingState.Failed)
			{
				Fail();
			}
		}
	}

	private void OnDestroy()
	{
		if (_instance == this)
		{
			_instance = null;
		}
		if (_isRunning && _downloadData != null)
		{
			_downloadData.CancelRequested = true;
		}
		GameStart.UnregisterBackgroundDownloadData(_downloadData);
		_loginWaitClickView?.EndPreDownloadDisplay();
	}

	private void Complete()
	{
		if (_isRunning)
		{
			_isRunning = false;
			Debug.Log("[PreDownloadAssetRunner] Pre-download completed.");
			_loginWaitClickView?.EndPreDownloadDisplay();
			_loginWaitClickView?.MarkPreDownloadCompleted();
			_promptView?.ShowDownloadCompleted();
			ClearDownloadState();
			Object.Destroy(gameObject);
		}
	}

	private void Cancel()
	{
		if (_isRunning)
		{
			_isRunning = false;
			if (_downloadData != null)
			{
				_downloadData.CancelRequested = true;
			}
			Debug.Log("[PreDownloadAssetRunner] Pre-download canceled by user.");
			_loginWaitClickView?.EndPreDownloadDisplay();
			ClearDownloadState();
			Object.Destroy(gameObject);
		}
	}

	private void Fail()
	{
		if (_isRunning)
		{
			_isRunning = false;
			Debug.LogWarning("[PreDownloadAssetRunner] Pre-download failed.");
			_loginWaitClickView?.EndPreDownloadDisplay();
			_promptView?.ShowDownloadCanceled();
			ClearDownloadState();
			Object.Destroy(gameObject);
		}
	}

	private void ClearDownloadState()
	{
		GameStart.UnregisterBackgroundDownloadData(_downloadData);
		_downloadAsset = null;
		_downloadData = null;
		_gameLoadingData = null;
		_loginWaitClickView = null;
		_promptView = null;
	}
}
