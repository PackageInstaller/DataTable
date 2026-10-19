using System;
using ACT.LocalLoader;
using ACT.UI;
using Bamboo.Chronos;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT;

public class LoadManager : Singleton<LoadManager>
{
	private bool _lastLoadComplete;

	private bool _pendingUnloadUnusedAssets;

	private ILoadProgressHandle _activeHandle;

	private Looper _looper;

	private float _phaseBase;

	private bool _phaseHandoffPending;

	private bool _loadingViewOpened;

	private Action _onLoadingViewOpenComplete;

	private bool _hiddenLoadingView;

	public ILoadProgressHandle ActiveHandle => _activeHandle;

	public bool IsComplete
	{
		get
		{
			if (_activeHandle == null)
			{
				return _lastLoadComplete;
			}
			return _activeHandle.IsDone;
		}
	}

	public bool InLoading
	{
		get
		{
			if (_hiddenLoadingView)
			{
				return true;
			}
			return Singleton<NewUIManager>.instance.LoadingPanel?.gameObject.activeSelf ?? false;
		}
	}

	private bool HasActiveLoadSession
	{
		get
		{
			if (_activeHandle == null && !_hiddenLoadingView)
			{
				return _onLoadingViewOpenComplete != null;
			}
			return true;
		}
	}

	public float DisplayPercent => Singleton<NewUIManager>.instance.LoadingPanel.ProgressPercent / 100f;

	public Func<UniTask> OnProgressDone { get; set; }

	public float LoadProgress
	{
		get
		{
			if (_activeHandle == null)
			{
				return _phaseBase;
			}
			return Mathf.Lerp(_phaseBase, 1f, Mathf.Clamp01(_activeHandle.Progress));
		}
	}

	private bool IsLoadingViewFullyOpened
	{
		get
		{
			MonoLoaderView loadingPanel = Singleton<NewUIManager>.instance.LoadingPanel;
			if (loadingPanel == null || !loadingPanel.gameObject.activeSelf)
			{
				return true;
			}
			if (_loadingViewOpened)
			{
				return !loadingPanel.IsOpenAnimationPlaying;
			}
			return false;
		}
	}

	public override void Init()
	{
		if (!HasActiveLoadSession)
		{
			ResetLoadSessionState();
		}
	}

	public override void UnInit()
	{
		ResetLoadSessionState();
	}

	private void ResetLoadSessionState()
	{
		_activeHandle = null;
		_phaseBase = 0f;
		_phaseHandoffPending = false;
		_loadingViewOpened = false;
		_hiddenLoadingView = false;
		_lastLoadComplete = false;
		_onLoadingViewOpenComplete = null;
		SetLoadingGamepadBlocked(blocked: false);
	}

	private void SetLoadingGamepadBlocked(bool blocked)
	{
		MonoMessageBox.SetGamepadInteractable(!blocked);
	}

	public void StartLoading(LoaderViewData viewData = null, bool isBlack = false, Func<UniTask> onProgressDone = null, ILoadProgressHandle progressHandle = null, bool showLoadingView = true)
	{
		MonoLoaderView loadingPanel = Singleton<NewUIManager>.instance.LoadingPanel;
		_lastLoadComplete = false;
		_hiddenLoadingView = !showLoadingView;
		if (viewData != null)
		{
			loadingPanel.DataContext = viewData;
		}
		loadingPanel.IsBlack = isBlack;
		SetLoadProgressHandle(progressHandle ?? new SceneLoadProgressHandle());
		OnProgressDone = (Func<UniTask>)Delegate.Combine(OnProgressDone, onProgressDone);
		loadingPanel.OnComplete = HandleOnComplete;
		RequestUnloadUnusedAssetsAfterOpenAnimation();
		if (!showLoadingView)
		{
			NotifyLoadingViewOpened();
		}
		else if (loadingPanel.gameObject.activeSelf)
		{
			if (loadingPanel.IsClosing)
			{
				_loadingViewOpened = false;
				loadingPanel.CancelCloseAndReopen();
			}
			else
			{
				NotifyLoadingViewOpened();
			}
		}
		else
		{
			_loadingViewOpened = false;
			loadingPanel.gameObject.SetActive(value: true);
		}
		if (!_looper.IsValid())
		{
			_looper = UpdateTimer.Default.LoopFrame(1, Update);
		}
		SetLoadingGamepadBlocked(blocked: true);
	}

	private void RequestUnloadUnusedAssetsAfterOpenAnimation()
	{
		_pendingUnloadUnusedAssets = true;
	}

	private void ExecutePendingUnloadUnusedAssets()
	{
		if (_pendingUnloadUnusedAssets)
		{
			MonoLoaderView loadingPanel = Singleton<NewUIManager>.instance.LoadingPanel;
			if (!(loadingPanel != null) || !loadingPanel.IsOpenAnimationPlaying)
			{
				_pendingUnloadUnusedAssets = false;
				AssetStationManager.RequestUnloadUnusedUnityAssets();
			}
		}
	}

	private void StopLoading()
	{
		_phaseBase = 0f;
		_phaseHandoffPending = false;
		_hiddenLoadingView = false;
		MonoLoaderView loadingPanel = Singleton<NewUIManager>.instance.LoadingPanel;
		if (loadingPanel.gameObject.activeSelf)
		{
			loadingPanel.CloseLoaderView();
		}
	}

	private async void HandleOnComplete()
	{
		_lastLoadComplete = true;
		if (OnProgressDone != null)
		{
			await OnProgressDone();
		}
		StopLoading();
		SetLoadingGamepadBlocked(blocked: false);
	}

	public void HandoffPhase()
	{
		_phaseBase = Mathf.Clamp01(LoadProgress);
		_phaseHandoffPending = true;
	}

	internal void NotifyLoadingViewOpened()
	{
		_loadingViewOpened = true;
		MonoLoaderView loadingPanel = Singleton<NewUIManager>.instance.LoadingPanel;
		if (loadingPanel != null && loadingPanel.gameObject.activeSelf)
		{
			UniversalRenderPipeline.SetBaseCameraSkip(skip: true);
		}
		_onLoadingViewOpenComplete?.Invoke();
		ExecutePendingUnloadUnusedAssets();
	}

	public async UniTask WaitLoadingViewFullyOpenedAsync()
	{
		await UniTask.NextFrame();
		if (!IsLoadingViewFullyOpened)
		{
			float deadline = Time.realtimeSinceStartup + 1f;
			await UniTask.WaitUntil(() => IsLoadingViewFullyOpened || Time.realtimeSinceStartup >= deadline);
		}
	}

	public void AddLoadingViewOpenCompleteListener(Action listener)
	{
		if (listener != null)
		{
			if (_loadingViewOpened)
			{
				listener();
			}
			else
			{
				_onLoadingViewOpenComplete = (Action)Delegate.Combine(_onLoadingViewOpenComplete, listener);
			}
		}
	}

	public void RemoveLoadingViewOpenCompleteListener(Action listener)
	{
		if (listener != null)
		{
			_onLoadingViewOpenComplete = (Action)Delegate.Remove(_onLoadingViewOpenComplete, listener);
		}
	}

	public void FinishLoading()
	{
		ReleaseActiveHandle();
		ResetLoadSessionState();
		StopLoading();
	}

	private void ReleaseActiveHandle()
	{
		_activeHandle?.Dispose();
		_activeHandle = null;
		if (_looper.IsValid())
		{
			_looper.Cancel();
		}
	}

	private void SetLoadProgressHandle(ILoadProgressHandle handle)
	{
		if (_activeHandle == null)
		{
			if (!_phaseHandoffPending)
			{
				_phaseBase = 0f;
			}
			_phaseHandoffPending = false;
			_activeHandle = handle;
		}
		else if (_phaseHandoffPending)
		{
			_phaseHandoffPending = false;
			_activeHandle = handle;
		}
	}

	private void Update()
	{
		if (_hiddenLoadingView)
		{
			ILoadProgressHandle activeHandle = _activeHandle;
			if (activeHandle != null && activeHandle.IsDone)
			{
				_hiddenLoadingView = false;
				ReleaseActiveHandle();
				HandleOnComplete();
			}
			else if (_activeHandle == null)
			{
				_hiddenLoadingView = false;
			}
		}
		else
		{
			ILoadProgressHandle activeHandle = _activeHandle;
			if (activeHandle != null && activeHandle.CouldDispose)
			{
				ReleaseActiveLoadProgress();
			}
		}
	}

	private void ReleaseActiveLoadProgress()
	{
		FinishLoading();
	}

	public void ReleaseLoadHandle()
	{
		if (_activeHandle is SceneLoadProgressHandle sceneLoadProgressHandle)
		{
			sceneLoadProgressHandle.MarkCouldDispose();
		}
	}
}
