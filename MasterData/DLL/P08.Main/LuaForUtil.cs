using System;
using System.Collections.Generic;
using System.IO;
using BBSCore;
using Cinemachine;
using I18N;
using P08.CriLipsEx;
using RogoDigital;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;
using UnityEngine.U2D;
using UnityEngine.UI;
using YSSDKCore;
using YSToolCore;

public class LuaForUtil
{
	public static bool IsManualAnimatorBlend = true;

	public static Action<string, string> LuaEventTrigger;

	public static Action<SpriteAtlas> atlasLoadAction;

	public static double NowMilliSec => new TimeSpan(DateTime.Now.Ticks).TotalMilliseconds;

	public static void OnLoginSuccess(int channelId, string platformAccount, string roleId, int worldId = 0)
	{
		LuaForSplash.OnLoginSuccess(channelId, platformAccount, roleId, worldId);
	}

	public static void NotifyLuaEvent(string eventName, string data)
	{
		if (LuaEventTrigger != null)
		{
			LuaEventTrigger(eventName, data);
		}
	}

	public static void SetSceneSetting(GameObject go, bool isEnable)
	{
		if (!(go == null))
		{
			SceneSetting component = go.GetComponent<SceneSetting>();
			if ((bool)component)
			{
				component.SetSettingActive(isEnable);
			}
		}
	}

	public static int GetClientVersion()
	{
		return LuaForSplash.GetClientVersion();
	}

	public static string GetVersionName()
	{
		return $"v0.{GetClientVersion()}.{GetResourceVersion()}.{GlobalStaticLoader.battleVersionCode}";
	}

	public static int GetResourceVersion()
	{
		return LuaForSplash.GetResourceVersion();
	}

	public static string GetResourceVersionName()
	{
		return LuaForSplash.GetResourceVersionName();
	}

	public static void UpdateVersionInfo()
	{
		LuaForSplash.UpdateVersionInfo();
	}

	public static int GetBattleVersion()
	{
		return GlobalStaticLoader.battleVersionCode;
	}

	public static void PreLoadAtlas(string atlasPath)
	{
		if (atlasLoadAction == null)
		{
			atlasLoadAction = AtlasHelper.atlasLoadAction;
		}
		if (atlasLoadAction != null)
		{
			SpriteAtlas obj = Asset.Load<SpriteAtlas>(atlasPath);
			atlasLoadAction(obj);
		}
	}

	public static void EnableTposeRenders(GameObject go)
	{
		ComponentTimeline component = go.GetComponent<ComponentTimeline>();
		if (!(component == null))
		{
			component.EnableRenders();
		}
	}

	public static EffectController PlayEffect(Transform target, string effectPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isLoop = false, float timeScale = 1f, float normalize = 0f, float effectKeepTime = 0.5f)
	{
		return CommonEffectClipPlayer.PlayEffect(target, effectPath, "", offset, scale, rotation, forward, isAttach: false, isLoop, timeScale, normalize, effectKeepTime);
	}

	public static EffectController PlayAttachEffect(Transform target, string effectPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isLoop = false, float timeScale = 1f, float normalize = 0f, float effectKeepTime = 0.5f)
	{
		return CommonEffectClipPlayer.PlayEffect(target, effectPath, "", offset, scale, rotation, forward, isAttach: true, isLoop, timeScale, normalize, effectKeepTime);
	}

	public static void StopEffect(EffectController vfx)
	{
		vfx.Stop();
	}

	public static void InitWebView()
	{
		YsToolEvent.Instance.WebViewMsgEvent = delegate(string msg)
		{
			LuaHelper.CallFunction("ReceiveWebViewMessage", msg);
		};
	}

	public static void OpenWebView(string url, bool isNeedCloseBtn = false, Action beforeAction = null, Action closedAction = null, int screenOrientation = -1)
	{
		beforeAction?.Invoke();
		YsToolEvent.Instance.WebViewCloseEvent = delegate
		{
			if (closedAction != null)
			{
				closedAction();
			}
			YsToolEvent.Instance.WebViewCloseEvent = null;
		};
		YsToolSDK.Instance.openWebView(url, isNeedCloseBtn, screenOrientation);
	}

	public static void CallWebView(string webviewFuncName, string callbackTag, string data = "")
	{
		YsToolSDK.Instance.callWebView(webviewFuncName, callbackTag, data);
	}

	public static void InitSavePhoto()
	{
		YsToolEvent.Instance.SavePhotoEvent = delegate(bool isSuccess, string msg)
		{
			LuaHelper.CallFunction("ReceiveSavePhotoMessage", isSuccess, msg);
		};
	}

	public static void SavePhotoToAlbum(string path)
	{
		YsToolSDK.Instance.savePhotoToAlbum(path);
	}

	public static void SetAppIcon(string targetIconAliasName)
	{
		if (GameToSDK.CURRENT_SERVER.IsNotNullOrEmpty() || !(GameToSDK.CURRENT_SERVER != "zh_cn"))
		{
			_ = new string[5] { "com.ys.sdk.ui.YSMixLaunchActivity", "appicon1", "appicon2", "appicon3", "appicon4" };
		}
		else
		{
			_ = new string[5] { "com.mimir.sdk.UAMain", "appicon1", "appicon2", "appicon3", "appicon4" };
		}
		Debug.Log("SetAppIcon" + targetIconAliasName);
		PCLauncherBridge.Instance.SetAppIcon(targetIconAliasName);
	}

	public static void SaveScreenShot(string path)
	{
		bool flag = false;
		try
		{
			string text = Application.persistentDataPath + "/ScreenShot/";
			if (!Directory.Exists(text))
			{
				Directory.CreateDirectory(text);
			}
			text = text + "/screenShot" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".jpg";
			File.Copy(path, text, overwrite: false);
			flag = true;
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.ToString());
			flag = false;
		}
		LuaHelper.CallFunction("ReceiveSavePhotoMessage", flag);
	}

	public static void OpenScreenShotFolder()
	{
		string text = Application.persistentDataPath + "/ScreenShot/";
		if (!Directory.Exists(text))
		{
			Directory.CreateDirectory(text);
		}
		Application.OpenURL("file:///" + text);
	}

	public static bool LinkThirdApp(string appLinkUrl)
	{
		return YsToolSDK.Instance.linkThirdApp(appLinkUrl);
	}

	public static int GetFreeDiskSpace()
	{
		Debug.Log("====>>> win端默认写个20G空间");
		return 20000;
	}

	public static void ShowWeapon(Transform transform, bool enable)
	{
		CharacterRenderController componentInChildren = transform.GetComponentInChildren<CharacterRenderController>();
		if (componentInChildren == null)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < componentInChildren.m_CategoryNames.Count; i++)
		{
			if ("武器" == componentInChildren.m_CategoryNames[i])
			{
				num = i;
				break;
			}
		}
		if (num != -1)
		{
			componentInChildren.SetRendersActiveForceUnsafe(num, enable);
		}
	}

	public static void EnableEyeController(Transform pTransform, bool pEnable)
	{
		EyeController componentInChildren = pTransform.GetComponentInChildren<EyeController>();
		if (!(componentInChildren == null))
		{
			componentInChildren.enabled = pEnable;
		}
	}

	public static CriAtomExPlayback PlayVoiceWithCriLipsync(Transform pTransform, string pSheetName, string pCueName, string pAwbName)
	{
		CriAtomExPlayback criAtomExPlayback = AudioManager.Instance.Play("voice", pSheetName, pCueName, !string.IsNullOrEmpty(pAwbName));
		CriLipsExPlayer componentInChildren = pTransform.GetComponentInChildren<CriLipsExPlayer>();
		if (componentInChildren != null)
		{
			componentInChildren.Play(pSheetName, pCueName, criAtomExPlayback);
		}
		return criAtomExPlayback;
	}

	public static void StopCriLipsync(Transform pTransform)
	{
		if (!(pTransform == null))
		{
			CriLipsExPlayer componentInChildren = pTransform.GetComponentInChildren<CriLipsExPlayer>();
			if (componentInChildren != null)
			{
				componentInChildren.SetBlendShapeWeight(0f, 0f, 0f, 0f, 0f);
				componentInChildren.Stop();
			}
		}
	}

	public static void GetIsMaintainByGMSDK(Action<bool, string> callback)
	{
		LuaForSplash.GetIsMaintainByGMSDK(callback);
	}

	public static void GetUnreadMsg(string baseUrl, string uid, int gameId, Action<int> callback)
	{
		TextAsset textAsset = Resources.Load<TextAsset>("ClientVersion");
		bool flag = null != textAsset;
		if (GameToSDK.CURRENT_SDK_ID == 0 || !flag)
		{
			callback(0);
			return;
		}
		BBSEvent.Instance.UnreadMsgEvent = delegate(UnreadMsgInfo unreadMsgInfo)
		{
			string code = unreadMsgInfo.code;
			if (code.Equals("0"))
			{
				int obj = int.Parse(unreadMsgInfo.data["totalCount"].ToString());
				callback(obj);
			}
			else
			{
				Debug.Log("UnreadMsgResultEventCallBack Error... code: " + code + " message: " + unreadMsgInfo.message);
			}
		};
		if (baseUrl.IsNotNullOrEmpty())
		{
			BBSSDK.Instance.queryUnreadMsgCount(baseUrl, uid, gameId);
		}
	}

	public static void UpdateCameraSetting()
	{
		CameraExtension component = Camera.main.GetComponent<CameraExtension>();
		int num = PlayerPrefs.GetInt("allowHDR");
		component.hdr = num == 1;
		switch (PlayerPrefs.GetInt("allowMSAA"))
		{
		case 2:
			component.msaa = CameraExtension.MsaaQuality.MSAA4x;
			break;
		case 1:
			component.msaa = CameraExtension.MsaaQuality.MSAA2x;
			break;
		default:
			component.msaa = CameraExtension.MsaaQuality.Disabled;
			break;
		}
		switch (PlayerPrefs.GetInt("frame"))
		{
		case 0:
			BattleSimulatorSystem.sTargetRenderFrameRate = 30;
			break;
		case 1:
			BattleSimulatorSystem.sTargetRenderFrameRate = 60;
			break;
		case 2:
			BattleSimulatorSystem.sTargetRenderFrameRate = 120;
			break;
		}
	}

	public static bool IsCheckLuaMemory()
	{
		return false;
	}

	public static void RefreshI18NText(GameObject go)
	{
		I18NTextKeyToValue[] componentsInChildren = go.GetComponentsInChildren<I18NTextKeyToValue>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].RefreshText(componentsInChildren[i].GetI18NKey(), isReWrite: false);
		}
	}

	public static Vector3 GetLastCharPosition(Text textComp)
	{
		TextGenerationSettings generationSettings = textComp.GetGenerationSettings(textComp.rectTransform.rect.size);
		textComp.cachedTextGenerator.Populate(textComp.text, generationSettings);
		if (textComp.cachedTextGenerator.verts.Count < 4)
		{
			return Vector3.left * -9999f;
		}
		IList<UIVertex> verts = textComp.cachedTextGenerator.verts;
		int num = verts.Count / 4 - 1;
		return (Vector2)((verts[num * 4].position + verts[num * 4 + 2].position) / 2f);
	}

	public static void ClearLinePrefixSymbol(Text textComp)
	{
		if (!(textComp == null) && textComp.gameObject.activeInHierarchy)
		{
			textComp.ClearLinePrefixSymbol();
		}
	}

	public static void AddHoverEffect(GameObject obj, bool isAdd)
	{
		HoverEffect component = obj.GetComponent<HoverEffect>();
		if (isAdd && component == null)
		{
			obj.AddComponent<HoverEffect>();
		}
		if (!isAdd && component != null)
		{
			try
			{
				UnityEngine.Object.Destroy(component);
			}
			catch
			{
			}
		}
	}

	public static void ActiveHoverEffect(GameObject obj, bool isActive)
	{
		HoverEffect component = obj.GetComponent<HoverEffect>();
		if (component != null)
		{
			component.ActiveTween(isActive);
		}
	}

	public static bool HasBattleWinPos()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return false;
		}
		if (battleScene.mapConfig == null)
		{
			return false;
		}
		if ((battleScene.mapConfig.SkipWinAction & 1) == 0)
		{
			return true;
		}
		return false;
	}

	public static void EnableAudioSessionRestoration_IOS(bool flag)
	{
		CriAtomEx.EnableAudioSessionRestoration_IOS(flag);
	}

	public static float GetCinemachineVirtualCameraFOV(CinemachineVirtualCamera virtualCamera)
	{
		return virtualCamera.m_Lens.FieldOfView;
	}

	public static void SetCinemachineVirtualCameraFOV(CinemachineVirtualCamera virtualCamera, float fov)
	{
		LensSettings lens = virtualCamera.m_Lens;
		lens.FieldOfView = fov;
		virtualCamera.m_Lens = lens;
	}

	public static void SetVCMNoise(CinemachineVirtualCamera virtualCamera, string noiseAssetPath = "", float amplitudeGain = 0f, float frequencyGain = 0f)
	{
		CinemachineBasicMultiChannelPerlin cinemachineComponent = virtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		if (!noiseAssetPath.IsNotNullOrEmpty())
		{
			cinemachineComponent.m_NoiseProfile = null;
			cinemachineComponent.m_AmplitudeGain = 0f;
			cinemachineComponent.m_FrequencyGain = 0f;
		}
		else
		{
			NoiseSettings noiseProfile = Asset.Load<NoiseSettings>(noiseAssetPath);
			cinemachineComponent.m_NoiseProfile = noiseProfile;
			cinemachineComponent.m_AmplitudeGain = amplitudeGain;
			cinemachineComponent.m_FrequencyGain = frequencyGain;
		}
	}

	public static void SetTimelineSpeed(PlayableDirector director, float speed)
	{
		if (director.playableGraph.IsValid())
		{
			director.playableGraph.GetRootPlayable(0).SetSpeed(speed);
		}
	}

	public static void SetTrailRendererClear(GameObject go)
	{
		TrailRenderer[] componentsInChildren = go.GetComponentsInChildren<TrailRenderer>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return;
		}
		TrailRenderer[] array = componentsInChildren;
		foreach (TrailRenderer trailRenderer in array)
		{
			if (trailRenderer != null)
			{
				trailRenderer.Clear();
			}
		}
	}

	public static void SetAutoChessExportData()
	{
	}

	public static bool HasCueSheet(string name)
	{
		return CriAtom.GetCueSheet(name) != null;
	}

	public static Transform GetRoleAttachPoint(Transform roleRootTrs, string name)
	{
		AttachPointSetup componentInChildren = roleRootTrs.GetComponentInChildren<AttachPointSetup>();
		if ((bool)componentInChildren)
		{
			return componentInChildren.GetAttachPoint(name);
		}
		return null;
	}

	public static void SetNoOperationTime(GameObject go, float time)
	{
		LongTimeNoOperation component = go.GetComponent<LongTimeNoOperation>();
		if (component != null)
		{
			component.maxTimeOffset = time;
		}
	}

	public static void DebugDrawLine(Vector3 from, Vector3 to, Color color, float duration = 0f, bool depthTest = true)
	{
	}
}
