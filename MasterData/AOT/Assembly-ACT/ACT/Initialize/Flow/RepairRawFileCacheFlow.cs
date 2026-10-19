using System;
using System.Collections;
using System.Collections.Generic;
using ACT.LocalLoader;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.UI;
using YooAsset;
using bamboosdk;

namespace ACT.Initialize.Flow;

internal sealed class RepairRawFileCacheFlow : RuntimeLoadFlow
{
	private const int DownloadConcurrency = 4;

	private const int DownloadRetryCount = 1;

	private const int DownloadIdleTimeoutSeconds = 30;

	private const double DownloadTotalTimeoutSeconds = 180.0;

	private const long ExtraDiskSpaceRequired = 3221225472L;

	private const long ProgressTotal = 1000L;

	private const long CacheCheckProgress = 200L;

	private static readonly string[] DefaultDownloadTags = new string[1] { "Preload" };

	private MonoHotUpdate _monoHotUpdate;

	private MonoMessageBox _startupMessageBox;

	private EventSystem _startupEventSystem;

	private InputSystemUIInputModule _startupInputModule;

	private InputActionMap _startupUIActions;

	private readonly Dictionary<InputAction, bool> _startupActionStates = new Dictionary<InputAction, bool>();

	private bool _eventSystemWasEnabled;

	private bool _inputModuleWasEnabled;

	private bool _sendNavigationEvents;

	private bool _gamepadWasInteractable;

	private bool _cursorWasVisible;

	private CursorLockMode _cursorLockMode;

	public bool Aborted { get; private set; }

	public RepairRawFileCacheFlow()
		: base("RepairRawFileCache")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1000L);
		RepairWithRetryAsync().Forget();
	}

	protected override void OnComplete()
	{
		UpdateProgressUI();
		WaitInitializer.onUpdate -= UpdateProgressUI;
		base.OnComplete();
	}

	private async UniTask RepairWithRetryAsync()
	{
		_ = 2;
		try
		{
			while (true)
			{
				try
				{
					if (!(await RepairRawFilesAsync()))
					{
						AbortRepair();
						return;
					}
				}
				catch (Exception arg)
				{
					Debug.LogError($"[RepairRawFileCache] 启动资源修复失败: {arg}");
					goto IL_00ae;
				}
				break;
				IL_00ae:
				if (!(await WaitForRetryAsync()))
				{
					AbortRepair();
					return;
				}
				await UniTask.NextFrame();
			}
		}
		finally
		{
			ReleaseStartupInput();
		}
		WaitInitializer.AddBatch(WaitInitializer.Total - WaitInitializer.Current);
	}

	private async UniTask<bool> RepairRawFilesAsync()
	{
		YooAssetInitData initData = GameStart.CachedYooAssetInitData;
		if (initData == null || initData.YooAssetParam?.PlayMode != EPlayMode.HostPlayMode)
		{
			return true;
		}
		InitializeProgressUI();
		ResourcePackage package = YooAssets.TryGetPackage("RawFile");
		if (package == null || package.InitializeStatus != EOperationStatus.Succeed || !package.PackageValid)
		{
			throw new InvalidOperationException("RawFile package or active manifest is not ready.");
		}
		IEnumerator repair = RawFileCacheRecovery.RepairStartupCache(package, UpdateCacheCheckProgress);
		try
		{
			while (repair.MoveNext())
			{
				await UniTask.NextFrame();
			}
		}
		finally
		{
			IDisposable disposable = repair as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		ZipDownloadParam zipDownloadParam = initData.ZipDownloadParam;
		string[] array = zipDownloadParam?.IntegrityDownloadTags;
		if (array == null || array.Length == 0)
		{
			array = zipDownloadParam?.DownloadTags;
		}
		if (array == null || array.Length == 0)
		{
			array = DefaultDownloadTags;
		}
		ResourceDownloaderOperation downloader = package.CreateResourceDownloaderByDownloadTags(array, 4, 1, 30);
		if (downloader.TotalDownloadCount == 0)
		{
			return true;
		}
		Debug.Log($"[RepairRawFileCache] 补下载: count={downloader.TotalDownloadCount}, bytes={downloader.TotalDownloadBytes}");
		try
		{
			SetProgressText("等待确认修复资源...");
			if (!(await WaitForDownloadConfirmationAsync(downloader)))
			{
				return false;
			}
			SetProgressText("正在修复资源...");
			double deadline = Time.realtimeSinceStartupAsDouble + 180.0;
			downloader.BeginDownload();
			while (!downloader.IsDone)
			{
				if (Time.realtimeSinceStartupAsDouble >= deadline)
				{
					throw new TimeoutException("RawFile repair exceeded its total download deadline.");
				}
				float value = ((downloader.TotalDownloadBytes > 0) ? ((float)((double)downloader.CurrentDownloadBytes / (double)downloader.TotalDownloadBytes)) : ((float)downloader.CurrentDownloadCount / (float)downloader.TotalDownloadCount));
				UpdateProgress(200 + (long)(Mathf.Clamp01(value) * 799f));
				await UniTask.NextFrame();
			}
			if (Time.realtimeSinceStartupAsDouble >= deadline)
			{
				throw new TimeoutException("RawFile repair exceeded its total download deadline.");
			}
			if (downloader.Status != EOperationStatus.Succeed)
			{
				throw new InvalidOperationException("RawFile repair download failed: " + downloader.Error);
			}
			return true;
		}
		finally
		{
			if (!downloader.IsDone)
			{
				downloader.CancelDownload();
			}
		}
	}

	private async UniTask<bool> WaitForDownloadConfirmationAsync(ResourceDownloaderOperation downloader)
	{
		long downloadBytes = Math.Max(0L, downloader.TotalDownloadBytes);
		long requiredBytes = checked(downloadBytes + 3221225472u);
		string downloadDescription = "需要下载 " + FormatBytes(downloadBytes) + " 资源。";
		bool confirmed = false;
		while (true)
		{
			long num = await GetAvailableDiskSpaceAsync();
			Debug.Log($"[RepairRawFileCache] 空间检查: download={downloadBytes}, required={requiredBytes}, available={num}");
			if (num < 0)
			{
				if (!(await ShowMessageAsync("无法检测存储空间", downloadDescription, "重新检测")))
				{
					return false;
				}
			}
			else if (num < requiredBytes)
			{
				if (!(await ShowMessageAsync("存储空间不足", downloadDescription, "重新检测")))
				{
					return false;
				}
			}
			else
			{
				if (confirmed)
				{
					return true;
				}
				if (!(await ShowMessageAsync("资源修复", downloadDescription + "\n是否确认修复？", "下载修复")))
				{
					break;
				}
				confirmed = true;
			}
			await UniTask.NextFrame();
		}
		return false;
	}

	private static UniTask<long> GetAvailableDiskSpaceAsync()
	{
		return QueryMobileDiskSpaceAsync();
	}

	private static async UniTask<long> QueryMobileDiskSpaceAsync()
	{
		LuminBambooBridgeListener.LeftDiskSpace = -1L;
		try
		{
			BamBooSdk.getInstance().getExtend("remainingStorageSpace", string.Empty);
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[RepairRawFileCache] 无法请求可用空间: " + ex.Message);
			return -1L;
		}
		double deadline = Time.realtimeSinceStartupAsDouble + 5.0;
		while (LuminBambooBridgeListener.LeftDiskSpace < 0 && Time.realtimeSinceStartupAsDouble < deadline)
		{
			await UniTask.NextFrame();
		}
		return LuminBambooBridgeListener.LeftDiskSpace;
	}

	private static string FormatBytes(long bytes)
	{
		if (bytes >= 1073741824)
		{
			return $"{(double)bytes / 1073741824.0:0.00} GB";
		}
		if (bytes >= 1048576)
		{
			return $"{(double)bytes / 1048576.0:0.00} MB";
		}
		if (bytes >= 1024)
		{
			return $"{(double)bytes / 1024.0:0.00} KB";
		}
		return $"{bytes} B";
	}

	private void InitializeProgressUI()
	{
		_monoHotUpdate = UnityEngine.Object.FindFirstObjectByType<MonoHotUpdate>();
		if (!(_monoHotUpdate == null) && !(_monoHotUpdate.progress == null))
		{
			_monoHotUpdate.SetCanvasActive(active: true);
			_monoHotUpdate.SetProgressBarActive(active: true);
			SetProgressText("正在检查资源...");
			if ((bool)_monoHotUpdate.progressNum)
			{
				_monoHotUpdate.progressNum.SetText(string.Empty);
			}
			WaitInitializer.onUpdate -= UpdateProgressUI;
			WaitInitializer.onUpdate += UpdateProgressUI;
			UpdateProgressUI();
		}
	}

	private void UpdateProgressUI()
	{
		if (!(_monoHotUpdate == null) && !(_monoHotUpdate.progress == null))
		{
			float num = Mathf.Clamp01(WaitInitializer.percent);
			_monoHotUpdate.progress.value = num;
			if ((bool)_monoHotUpdate.percentText)
			{
				float p = Mathf.Floor(num * 100f) / 100f;
				_monoHotUpdate.percentText.SetText(MonoHotUpdate.ToPercentage(p, 0));
			}
		}
	}

	private void SetProgressText(string text)
	{
		if (_monoHotUpdate != null && (bool)_monoHotUpdate.progressText)
		{
			_monoHotUpdate.progressText.SetText(text);
		}
	}

	private void UpdateCacheCheckProgress(float percent)
	{
		UpdateProgress((long)(Mathf.Clamp01(percent) * 200f));
	}

	private void UpdateProgress(long current)
	{
		long num = Math.Min(current, 999L);
		if (num > WaitInitializer.Current)
		{
			WaitInitializer.AddBatch(num - WaitInitializer.Current);
		}
	}

	private UniTask<bool> WaitForRetryAsync()
	{
		SetProgressText("资源修复失败，请重试或退出游戏");
		return ShowMessageAsync("资源修复失败", "下载失败，请重试或退出游戏。", "重试");
	}

	private void AbortRepair()
	{
		Aborted = true;
		WaitInitializer.onUpdate -= UpdateProgressUI;
		Application.Quit();
	}

	private UniTask<bool> ShowMessageAsync(string title, string content, string confirmText)
	{
		UniTaskCompletionSource<bool> completion = new UniTaskCompletionSource<bool>();
		bool flag = false;
		try
		{
			if (InitializeStartupInput())
			{
				_startupMessageBox.Init(new MonoMessageBox.Message
				{
					titleText = title,
					content = content,
					btn1Text = confirmText,
					btn2Text = "退出",
					callBack = () =>
					{
						completion.TrySetResult(result: true);
					},
					callBack2 = () =>
					{
						completion.TrySetResult(result: false);
					},
					isShowSingle = false
				});
				flag = _startupMessageBox.isActiveAndEnabled;
			}
		}
		catch (Exception arg)
		{
			Debug.LogError($"[RepairRawFileCache] 无法显示修复提示: {arg}");
		}
		if (!flag)
		{
			completion.TrySetResult(result: false);
		}
		return completion.Task;
	}

	private bool InitializeStartupInput()
	{
		if (_startupMessageBox != null)
		{
			return true;
		}
		GameStart gameStart = ((_monoHotUpdate != null) ? _monoHotUpdate.gameStart : null);
		if (gameStart == null || gameStart.messageBox == null)
		{
			return false;
		}
		EventSystem componentInChildren = gameStart.GetComponentInChildren<EventSystem>(includeInactive: true);
		InputSystemUIInputModule componentInChildren2 = gameStart.GetComponentInChildren<InputSystemUIInputModule>(includeInactive: true);
		InputActionMap inputActionMap = componentInChildren2?.actionsAsset?.FindActionMap("UI");
		if (componentInChildren == null || componentInChildren2 == null || inputActionMap == null)
		{
			return false;
		}
		_startupMessageBox = gameStart.messageBox;
		_startupEventSystem = componentInChildren;
		_startupInputModule = componentInChildren2;
		_startupUIActions = inputActionMap;
		_eventSystemWasEnabled = componentInChildren.enabled;
		_inputModuleWasEnabled = componentInChildren2.enabled;
		_sendNavigationEvents = componentInChildren.sendNavigationEvents;
		_gamepadWasInteractable = GameStartMessageBtnSelector.GamepadInteractable;
		_cursorWasVisible = Cursor.visible;
		_cursorLockMode = Cursor.lockState;
		foreach (InputAction action in inputActionMap.actions)
		{
			_startupActionStates.Add(action, action.enabled);
		}
		componentInChildren.sendNavigationEvents = false;
		componentInChildren2.enabled = true;
		componentInChildren.enabled = true;
		inputActionMap.actionTriggered += OnStartupUIAction;
		inputActionMap.Enable();
		GameStartMessageBtnSelector.SetGamepadInteractable(interactable: true);
		Cursor.lockState = CursorLockMode.None;
		Cursor.visible = true;
		return true;
	}

	private void OnStartupUIAction(InputAction.CallbackContext context)
	{
		if (_startupMessageBox == null || !_startupMessageBox.isActiveAndEnabled)
		{
			return;
		}
		GameStartMessageBtnSelector btnSelector = _startupMessageBox.btnSelector;
		if (btnSelector == null || !GameStartMessageBtnSelector.GamepadInteractable)
		{
			return;
		}
		if (context.performed)
		{
			btnSelector.UpdateDevice(context.control.device);
		}
		if (context.canceled)
		{
			if (context.action.name == "Next")
			{
				btnSelector.SelectNext();
			}
			else if (context.action.name == "Prev")
			{
				btnSelector.SelectPrev();
			}
		}
		else if (context.performed && (context.action.name == "Confirm" || context.action.name == "Back") && !context.ReadValueAsButton())
		{
			if (context.action.name == "Confirm")
			{
				btnSelector.ClickCurrentByGamepad();
			}
			else
			{
				_startupMessageBox.OnClick2();
			}
		}
	}

	private void ReleaseStartupInput()
	{
		if (_startupUIActions == null)
		{
			return;
		}
		_startupUIActions.actionTriggered -= OnStartupUIAction;
		if (_startupMessageBox != null)
		{
			_startupMessageBox.gameObject.SetActive(value: false);
		}
		if (_startupEventSystem != null)
		{
			_startupEventSystem.enabled = _eventSystemWasEnabled;
			_startupEventSystem.sendNavigationEvents = _sendNavigationEvents;
		}
		if (_startupInputModule != null)
		{
			_startupInputModule.enabled = _inputModuleWasEnabled;
		}
		foreach (KeyValuePair<InputAction, bool> startupActionState in _startupActionStates)
		{
			if (startupActionState.Value)
			{
				startupActionState.Key.Enable();
			}
			else
			{
				startupActionState.Key.Disable();
			}
		}
		_startupActionStates.Clear();
		GameStartMessageBtnSelector.SetGamepadInteractable(_gamepadWasInteractable);
		Cursor.lockState = _cursorLockMode;
		Cursor.visible = _cursorWasVisible;
		_startupUIActions = null;
		_startupMessageBox = null;
	}
}
