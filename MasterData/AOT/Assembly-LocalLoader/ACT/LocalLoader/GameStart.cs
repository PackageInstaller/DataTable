using System;
using System.Collections;
using System.Collections.Generic;
using ACT.UI.AOT;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;
using YooAsset;
using bamboosdk;
using bamboosdk.BamBooSdkJson;

namespace ACT.LocalLoader;

public class GameStart : LuminBambooBridgeListener
{
	public static bool IsGameStart;

	[SerializeField]
	private TMP_Settings tmpSettings;

	public MonoHotUpdate hotUpdateView;

	public MonoMessageBox messageBox;

	public Animator animator;

	public float fakeProgressDuration = 2f;

	public SafeAreaLocal SafeArea;

	public static AssetLoadType AssetLoadType;

	public Canvas selfCanvas;

	public List<SkeletonGraphic> SkeletonGraphics;

	[SerializeField]
	private EventSystem m_EventSystem;

	public LocalAudioManager audioManager;

	public List<TMP_FontAsset> FontAssets;

	public Camera mainCamera;

	public Camera uiCamera;

	private Coroutine m_CoResource;

	private URPShaderLoader m_ShaderLoader;

	private GameLoadingManager _gameLoadingManager;

	private DownloadData _downloadData;

	private GameStartInputController _controller;

	private static DownloadData _backgroundDownloadDataOverride;

	private Coroutine progressCoroutine;

	private float fakeProgressStartTime;

	private bool catLogCatchEnd;

	public const int border = 105;

	public const int _border = 40;

	public const int borderMaxCount = 144;

	public static GameObject EnterGameSpinInstance { get; internal set; }

	public bool inLoginView
	{
		get
		{
			if (!IsInLoginPage)
			{
				return IsInLogoutPage;
			}
			return true;
		}
	}

	public static YooAssetInitData CachedYooAssetInitData { get; private set; }

	internal event Action<string, string, string> ChannelAppUpdateCallback;

	private void OnEnable()
	{
		m_ShaderLoader = new URPShaderLoader();
	}

	public static void RegisterBackgroundDownloadData(DownloadData downloadData)
	{
		_backgroundDownloadDataOverride = downloadData;
	}

	public static void UnregisterBackgroundDownloadData(DownloadData downloadData)
	{
		if (_backgroundDownloadDataOverride == downloadData)
		{
			_backgroundDownloadDataOverride = null;
		}
	}

	public static void ApplyDownloadTagsToCachedInitData(string[] downloadTags, string yooAssetDownloadTag = null)
	{
		if (CachedYooAssetInitData?.ZipDownloadParam == null)
		{
			Debug.LogWarning("[GameStart] CachedYooAssetInitData 未就绪，忽略 ApplyDownloadTagsToCachedInitData");
			return;
		}
		CachedYooAssetInitData.ZipDownloadParam.DownloadTags = downloadTags;
		CachedYooAssetInitData.ZipDownloadParam.IntegrityDownloadTags = (string.IsNullOrWhiteSpace(yooAssetDownloadTag) ? downloadTags : new string[1] { yooAssetDownloadTag });
		DownloadAssetManager.Instance.SetPlayerTags(downloadTags ?? Array.Empty<string>());
		Debug.Log("[GameStart] Applied download tags: [" + string.Join(",", downloadTags ?? Array.Empty<string>()) + "], integrityTag=" + (yooAssetDownloadTag ?? "same"));
	}

	public static void RefreshDownloadTagsFromLocalState()
	{
		ApplyDownloadTagsToCachedInitData(InitAssetTag.BuildDownloadTags());
	}

	internal static DownloadAsset CreateDownloadAssetFromCachedInitData()
	{
		if (CachedYooAssetInitData == null)
		{
			Debug.LogError("[GameStart] CachedYooAssetInitData 为空，无法创建 DownloadAsset");
			return null;
		}
		return new DownloadAsset(CachedYooAssetInitData);
	}

	public static bool TryCreatePreDownloadAsset(out DownloadAsset downloadAsset, out DownloadData downloadData, string[] downloadTags = null)
	{
		downloadAsset = null;
		downloadData = null;
		YooAssetInitData cachedYooAssetInitData = CachedYooAssetInitData;
		if (cachedYooAssetInitData == null || cachedYooAssetInitData.ZipDownloadParam == null || cachedYooAssetInitData.YooAssetParam == null)
		{
			Debug.LogError("[GameStart] YooAsset init data is not ready, unable to create pre-download asset.");
			return false;
		}
		RemoteConfigPreDownload remoteConfigPreDownload = LuminApplication.RemoteConfig?.PreDownload;
		if (remoteConfigPreDownload == null || !remoteConfigPreDownload.HasAnyDiffZipInfos())
		{
			return false;
		}
		PreDownloadPackageStore.PreDownloadTarget preDownloadTarget = PreDownloadPackageStore.CreateTarget(remoteConfigPreDownload);
		string text = preDownloadTarget.ToVersionKey();
		string resPath = LuminApplication.GetResPath();
		if (PreDownloadPackageStore.TryGetStagedTarget(resPath, out var target, out var versionKey) && PreDownloadPackageStore.Compare(preDownloadTarget, target) < 0)
		{
			Debug.LogWarning("[GameStart] 暂存区已存在更新的预下载目标 " + versionKey + "，跳过本次预下载(本次目标 " + text + ")");
			return false;
		}
		PreDownloadPackageStore.PromoteStagedTarget(resPath, preDownloadTarget, PreDownloadPackageStore.CreatePackageZipInfos(remoteConfigPreDownload));
		string[] array = downloadTags ?? cachedYooAssetInitData.ZipDownloadParam.DownloadTags;
		downloadData = new DownloadData
		{
			AcceptUpdate = true
		};
		ZipDownloadParam zipDownloadParam = new ZipDownloadParam
		{
			DllZipDownloadURLs = remoteConfigPreDownload.DiffDllInfos,
			ClientStaticZipDownloadURLs = remoteConfigPreDownload.DiffClientStaticInfos,
			AssetsZipDownloadURLs = remoteConfigPreDownload.DiffAssetInfos,
			RawFileZipDownloadURLs = remoteConfigPreDownload.DiffRawFileInfos,
			DownloadTags = array,
			IntegrityDownloadTags = array,
			WriteVersionInfo = false,
			IsPreDownload = true,
			PreDownloadVersionKey = text
		};
		YooAssetInitData yooAssetInitData = new YooAssetInitData
		{
			DownloadData = downloadData,
			YooAssetParam = cachedYooAssetInitData.YooAssetParam,
			ZipDownloadParam = zipDownloadParam
		};
		yooAssetInitData.InitPackageData();
		downloadAsset = new DownloadAsset(yooAssetInitData);
		return true;
	}

	public static long GetPreDownloadedBytes(string versionKey)
	{
		return PreDownloadPackageStore.GetDownloadedBytes(LuminApplication.GetResPath(), versionKey);
	}

	public static bool HasPreDownloadedPackages(string versionKey)
	{
		if (string.IsNullOrEmpty(versionKey))
		{
			return false;
		}
		return PreDownloadPackageStore.HasStagedPackages(LuminApplication.GetResPath(), versionKey);
	}

	public static string GetStagedPreDownloadVersionKey()
	{
		if (!PreDownloadPackageStore.TryGetStagedTarget(LuminApplication.GetResPath(), out var _, out var versionKey))
		{
			return null;
		}
		return versionKey;
	}

	public static int ComparePreDownloadVersionKeys(string leftVersionKey, string rightVersionKey)
	{
		if (!PreDownloadPackageStore.TryParseVersionKey(leftVersionKey, out var target) || !PreDownloadPackageStore.TryParseVersionKey(rightVersionKey, out var target2))
		{
			return 0;
		}
		return PreDownloadPackageStore.Compare(target, target2);
	}

	private void Start()
	{
		UniversalRenderPipeline.SetBaseCameraSkip(skip: true);
		if (_controller == null)
		{
			_controller = new GameStartInputController();
		}
		_controller.Init(this);
		AnnouncementRedDot.Load();
		hotUpdateView.gameObject.SetActive(value: true);
		IsGameStart = true;
		_downloadData = new DownloadData();
		hotUpdateView.Init(_downloadData);
		_gameLoadingManager = new GameLoadingManager();
		_gameLoadingManager.AddFlow(new InitAppInfo(this));
		_gameLoadingManager.AddFlow(new InitSplash(animator, hotUpdateView));
		_gameLoadingManager.AddFlow(new InitPersistentAudio(audioManager));
		LuminBambooBridgeListener.Default = this;
		_gameLoadingManager.AddFlow(new InitBamBooSdk(this));
		_gameLoadingManager.AddFlow(new CheckWhiteList());
		_gameLoadingManager.AddFlow(new InitAPM(debugMode: false));
		_gameLoadingManager.AddFlow(new InitPlatformSetting());
		_gameLoadingManager.AddFlow(new ReadVersionInfo(_downloadData));
		_gameLoadingManager.AddFlow(new InitRemoteConfig(this, _downloadData, RefreshStartupAnnouncementData));
		_gameLoadingManager.AddFlow(new InitCheckVersion(messageBox));
		YooAssetParam yooAssetParam = new YooAssetParam();
		if (AssetLoadType == AssetLoadType.Offline)
		{
			yooAssetParam.PlayMode = EPlayMode.OfflinePlayMode;
		}
		else
		{
			yooAssetParam.PlayMode = EPlayMode.HostPlayMode;
		}
		ZipDownloadParam zipDownloadParam = new ZipDownloadParam();
		_gameLoadingManager.AddFlow(new InitAssetTag(zipDownloadParam));
		YooAssetInitData yooAssetInitData = new YooAssetInitData
		{
			DownloadData = _downloadData,
			YooAssetParam = yooAssetParam,
			ZipDownloadParam = zipDownloadParam
		};
		yooAssetInitData.InitPackageData();
		CachedYooAssetInitData = yooAssetInitData;
		_gameLoadingManager.AddFlow(new ResolveRemoteConfigUpdate(this, _downloadData, zipDownloadParam, yooAssetInitData));
		_gameLoadingManager.AddFlow(new SelectPackageType(_downloadData, zipDownloadParam));
		_gameLoadingManager.AddFlow(new DownloadAsset(yooAssetInitData));
		_gameLoadingManager.AddFlow(new InitYooAsset(yooAssetInitData));
		_gameLoadingManager.AddFlow(new CheckResourceIntegrity(yooAssetInitData));
		_gameLoadingManager.AddFlow(new ReadGameVersionInfo(this));
		_gameLoadingManager.AddFlow(new InitDll());
		_gameLoadingManager.AddFlow(new InitRender());
		_gameLoadingManager.AddFlow(new InitDebugGUIManager());
		_gameLoadingManager.AddFlow(new InitLuminRuntimeData(HandOverInput));
		_gameLoadingManager.AddFlow(new DestroyGameStart());
	}

	private async void RefreshStartupAnnouncementData()
	{
		try
		{
			await LuminApplication.GmApi.GetAnnouncements(2);
			if ((bool)hotUpdateView)
			{
				hotUpdateView.UpdateNoticeRedDot();
			}
		}
		catch (Exception)
		{
		}
		try
		{
			await LuminApplication.GmApi.GetAnnouncements(1, 4);
			await LuminApplication.GmApi.GetAnnouncements(1, 5);
		}
		catch (Exception)
		{
		}
	}

	private void HandOverInput()
	{
		if (m_EventSystem != null)
		{
			m_EventSystem.enabled = false;
		}
		_controller.Release();
	}

	private void Update()
	{
		_gameLoadingManager?.Update();
	}

	private void OnDestroy()
	{
		_controller.Release();
		ReleaseAsset();
	}

	private void ReleaseAsset()
	{
		if (FontAssets != null)
		{
			foreach (TMP_FontAsset fontAsset in FontAssets)
			{
				if (fontAsset != null)
				{
					Resources.UnloadAsset(fontAsset.atlasTexture);
				}
				Resources.UnloadAsset(fontAsset);
			}
		}
		foreach (SkeletonGraphic skeletonGraphic in SkeletonGraphics)
		{
			SkeletonDataAsset skeletonDataAsset = skeletonGraphic.skeletonDataAsset;
			skeletonGraphic.skeletonDataAsset = null;
			if (!(skeletonDataAsset != null))
			{
				continue;
			}
			AtlasAssetBase[] atlasAssets = skeletonDataAsset.atlasAssets;
			foreach (AtlasAssetBase atlasAssetBase in atlasAssets)
			{
				foreach (Material material in atlasAssetBase.Materials)
				{
					if (material != null && material.mainTexture != null)
					{
						Resources.UnloadAsset(material.mainTexture);
					}
				}
				Resources.UnloadAsset(atlasAssetBase);
			}
			Resources.UnloadAsset(skeletonDataAsset);
		}
	}

	public override void onSwitchAccountSuccess(UserInfo userInfo)
	{
	}

	public override void onSwitchAccountFailed(ErrorMsg errMsg)
	{
	}

	public override void onSwitchAccountCancel()
	{
	}

	public override void onOpenPageSuccess()
	{
	}

	public override void onOpenPageComplete(PageResult pageResult)
	{
	}

	public override void onOpenPageFailed(ErrorMsg errMsg)
	{
	}

	public override void onGuestUpgradeSuccess()
	{
	}

	public override void onGuestUpgradeFailed(ErrorMsg errMsg)
	{
	}

	public override void onBackDownSuccess()
	{
	}

	public override void onSucceed(string infos)
	{
	}

	public override void onFailed(string message)
	{
	}

	public override void onPaySuccess(PayResult payResult)
	{
	}

	public override void onPayFailed(PayResult payResult)
	{
	}

	public override void onPayFailedAndTryAgain(OrderInfo orderInfo)
	{
	}

	public override void onPayCancel(PayResult payResult)
	{
	}

	public override void onNotch(NotchResult notchResult)
	{
	}

	public override void onExtendSuccess(string modName, string jsonRes)
	{
		if (modName == "reqxNotification" || modName == "isShowNotificationLogo")
		{
			LuminBambooBridgeListener.RaiseExtendSucceeded(modName, jsonRes);
		}
		if (modName == "cps")
		{
			try
			{
				JSONNode jSONNode = JSONNode.Parse(jsonRes);
				string appCpsId = jSONNode.get_Item("cps")?.Value ?? "-1";
				string appCpsGroup = jSONNode.get_Item("cpsGroup")?.Value ?? string.Empty;
				LuminApplication.AppCpsId = appCpsId;
				LuminApplication.AppCpsGroup = appCpsGroup;
				SetBBSuperProperties(AotConstValues.TaPublicProperties);
			}
			catch (Exception)
			{
			}
		}
		if (modName == "remainingStorageSpace")
		{
			try
			{
				LuminBambooBridgeListener.LeftDiskSpace = long.Parse(JSONNode.Parse(jsonRes).get_Item("space").Value);
			}
			catch (Exception)
			{
			}
		}
		if (modName == "backgroundDownload")
		{
			HandleBackgroundDownloadSuccess(jsonRes);
		}
		if (modName == "channelAppUpdate")
		{
			try
			{
				JSONNode jSONNode2 = JSONNode.Parse(jsonRes);
				string arg = jSONNode2.get_Item("status")?.Value ?? string.Empty;
				string arg2 = jSONNode2.get_Item("code")?.Value ?? string.Empty;
				string arg3 = jSONNode2.get_Item("msg")?.Value ?? string.Empty;
				ChannelAppUpdateCallback?.Invoke(arg, arg2, arg3);
			}
			catch (Exception ex3)
			{
				ChannelAppUpdateCallback?.Invoke("error", string.Empty, ex3.Message);
			}
		}
	}

	public override void onExtendFailed(string modName, ErrorMsg errMsg)
	{
		if (modName == "backgroundDownload")
		{
			HandleBackgroundDownloadFailure(string.IsNullOrEmpty($"{errMsg}") ? "backgroundDownload failed" : $"{errMsg}");
		}
		else if (modName == "channelAppUpdate")
		{
			string arg = (string.IsNullOrEmpty($"{errMsg}") ? "channelAppUpdate failed" : $"{errMsg}");
			ChannelAppUpdateCallback?.Invoke("error", string.Empty, arg);
		}
	}

	public static void HandleBackgroundDownloadSuccess(string jsonRes)
	{
		Debug.Log($"[GameStart] backgroundDownload callback entry: jsonLength={jsonRes?.Length ?? 0}.");
		try
		{
			DownloadCallbackInfo downloadCallbackInfo = JsonUtility.FromJson<DownloadCallbackInfo>(jsonRes) ?? new DownloadCallbackInfo
			{
				status = 2,
				Message = "backgroundDownload 返回为空"
			};
			Debug.Log($"[GameStart] backgroundDownload callback received: status={downloadCallbackInfo.status}, " + $"taskCount={downloadCallbackInfo.taskArray?.Length ?? 0}, message={downloadCallbackInfo.Message ?? string.Empty}.");
			DispatchBackgroundDownloadCallback(downloadCallbackInfo);
		}
		catch (Exception ex)
		{
			Debug.LogError("[GameStart] backgroundDownload callback parse failed: " + ex.Message);
			DispatchBackgroundDownloadCallback(new DownloadCallbackInfo
			{
				status = 2,
				Message = ex.Message
			});
		}
	}

	public static void HandleBackgroundDownloadFailure(string errorMessage)
	{
		Debug.LogError("[GameStart] backgroundDownload SDK callback failed: " + errorMessage);
		DispatchBackgroundDownloadCallback(new DownloadCallbackInfo
		{
			status = 2,
			Message = errorMessage
		});
	}

	private static void DispatchBackgroundDownloadCallback(DownloadCallbackInfo info)
	{
		GameStart gameStart = LuminBambooBridgeListener.Default as GameStart;
		DownloadData downloadData = _backgroundDownloadDataOverride ?? gameStart?._downloadData;
		string arg;
		if (_backgroundDownloadDataOverride != null)
		{
			arg = "override";
		}
		else
		{
			arg = ((gameStart?._downloadData != null) ? "main" : "none");
		}
		Debug.Log($"[GameStart] backgroundDownload callback dispatch: status={info?.status}, route={arg}, " + $"hasListener={downloadData?.DownloadCallback != null}.");
		downloadData?.DownloadCallback?.Invoke(info);
	}

	public override void onStorageSuccess(string value)
	{
	}

	public override void onStorageFailed(ErrorMsg errMsg)
	{
	}

	public override void onSkuQueryDetailSuccess(string value)
	{
	}

	public override void onSkuQueryDetailFailed(ErrorMsg errMsg)
	{
	}

	public override void onSharedSuccess()
	{
	}

	public override void onSharedCancel()
	{
	}

	public override void onSharedFail(int code, string msg)
	{
	}

	public override void onReferrer(string referrer)
	{
	}

	public override void onLocalNotificationClickSuccess(string notifyId)
	{
	}

	public override void onIsSupportRewardedVideoAd(int status)
	{
	}

	public override void onRewardedVideoAdShow(string type, int status)
	{
	}

	public override void onShareQuery(string openId, string serverId, string roleId)
	{
	}

	public override void onMsgSecCheck(string content, string suggest, int label)
	{
	}

	private IEnumerator FakeProgressBar()
	{
		fakeProgressStartTime = Time.time;
		float startValue = 0f;
		float targetValue = 0.9f;
		hotUpdateView.progressText.SetText("连接中...");
		while (Time.time - fakeProgressStartTime < fakeProgressDuration)
		{
			float t = (Time.time - fakeProgressStartTime) / fakeProgressDuration;
			hotUpdateView.progress.value = Mathf.Lerp(startValue, targetValue, t);
			hotUpdateView.FakeProgress((int)(hotUpdateView.progress.value * 100f));
			yield return null;
		}
		hotUpdateView.progress.value = targetValue;
	}

	private IEnumerator FakeProgressBarOnCatLog()
	{
		fakeProgressStartTime = Time.time;
		float startValue = 0f;
		float targetValue = 0.9f;
		hotUpdateView.progressText.SetText("连接中...");
		float maxWaitTime = fakeProgressDuration * 5f;
		while (!catLogCatchEnd && Time.time - fakeProgressStartTime < maxWaitTime)
		{
			float t = Mathf.Min((Time.time - fakeProgressStartTime) / fakeProgressDuration, 1f);
			hotUpdateView.progress.value = Mathf.Lerp(startValue, targetValue, t);
			hotUpdateView.FakeProgress((int)(hotUpdateView.progress.value * 100f));
			yield return null;
		}
		if (!catLogCatchEnd && Time.time - fakeProgressStartTime >= maxWaitTime)
		{
			catLogCatchEnd = true;
		}
		float num = Time.time - fakeProgressStartTime;
		if (num < fakeProgressDuration)
		{
			float remainingTime = fakeProgressDuration - num;
			float startValueAfterCatLog = hotUpdateView.progress.value;
			float startTimeAfterCatLog = Time.time;
			while (Time.time - startTimeAfterCatLog < remainingTime)
			{
				float t2 = (Time.time - startTimeAfterCatLog) / remainingTime;
				float num2 = Mathf.Lerp(startValueAfterCatLog, targetValue, t2);
				hotUpdateView.progress.value = num2;
				hotUpdateView.FakeProgress((int)(num2 * 100f));
				yield return null;
			}
		}
		hotUpdateView.progress.value = 1f;
		hotUpdateView.FakeProgress(100);
	}

	public void BorderAdjustLocal()
	{
	}

	public static float ReturnLegalSafeAreaDefaultValue()
	{
		float num = ((float)Screen.width - Screen.safeArea.width) / 2f / (float)Screen.width * 1f;
		if (num < 4f / 65f)
		{
			return num;
		}
		return 4f / 65f;
	}

	public static float ReturnLegalSafeAreaYDefaultValue()
	{
		float num = ((float)Screen.height - Screen.safeArea.height) / 2f / (float)Screen.height * 1f;
		if (num < 0.08f)
		{
			return num;
		}
		return 0.08f;
	}

	public static void LoadEnterGameSpin()
	{
		if ((bool)EnterGameSpinInstance)
		{
			return;
		}
		GameObject gameObject = Resources.Load<GameObject>("EnterGameSpine");
		if (gameObject == null)
		{
			Debug.LogError("[GameStart] EnterGameSpine prefab could not be loaded.");
			return;
		}
		EnterGameSpinInstance = UnityEngine.Object.Instantiate(gameObject);
		Canvas component = EnterGameSpinInstance.GetComponent<Canvas>();
		GameStart gameStart = UnityEngine.Object.FindObjectOfType<GameStart>();
		if (component != null && gameStart != null)
		{
			component.renderMode = RenderMode.ScreenSpaceCamera;
			component.worldCamera = gameStart.uiCamera;
		}
	}

	public static void ReleaseEnterGameSpin()
	{
		if ((bool)EnterGameSpinInstance)
		{
			ReleaseEnterGameSpinAssets(EnterGameSpinInstance);
			UnityEngine.Object.Destroy(EnterGameSpinInstance);
			EnterGameSpinInstance = null;
		}
		Resources.UnloadUnusedAssets();
	}

	private static void ReleaseEnterGameSpinAssets(GameObject instance)
	{
		if (instance == null)
		{
			return;
		}
		SkeletonGraphic[] componentsInChildren = instance.GetComponentsInChildren<SkeletonGraphic>(includeInactive: true);
		foreach (SkeletonGraphic obj in componentsInChildren)
		{
			SkeletonDataAsset skeletonDataAsset = obj.skeletonDataAsset;
			obj.skeletonDataAsset = null;
			if (!(skeletonDataAsset != null))
			{
				continue;
			}
			AtlasAssetBase[] atlasAssets = skeletonDataAsset.atlasAssets;
			foreach (AtlasAssetBase atlasAssetBase in atlasAssets)
			{
				if (!(atlasAssetBase != null))
				{
					continue;
				}
				foreach (Material material in atlasAssetBase.Materials)
				{
					if (material != null && material.mainTexture != null)
					{
						Resources.UnloadAsset(material.mainTexture);
					}
				}
				Resources.UnloadAsset(atlasAssetBase);
			}
			Resources.UnloadAsset(skeletonDataAsset);
		}
		Image[] componentsInChildren2 = instance.GetComponentsInChildren<Image>(includeInactive: true);
		foreach (Image image in componentsInChildren2)
		{
			if (image.sprite != null && image.sprite.texture != null)
			{
				Texture2D texture = image.sprite.texture;
				image.sprite = null;
				Resources.UnloadAsset(texture);
			}
		}
		RawImage[] componentsInChildren3 = instance.GetComponentsInChildren<RawImage>(includeInactive: true);
		foreach (RawImage rawImage in componentsInChildren3)
		{
			if (rawImage.texture != null)
			{
				Texture texture2 = rawImage.texture;
				rawImage.texture = null;
				Resources.UnloadAsset(texture2);
			}
		}
		AudioSource[] componentsInChildren4 = instance.GetComponentsInChildren<AudioSource>(includeInactive: true);
		foreach (AudioSource audioSource in componentsInChildren4)
		{
			if (audioSource.clip != null)
			{
				AudioClip clip = audioSource.clip;
				audioSource.Stop();
				audioSource.clip = null;
				Resources.UnloadAsset(clip);
			}
		}
	}
}
