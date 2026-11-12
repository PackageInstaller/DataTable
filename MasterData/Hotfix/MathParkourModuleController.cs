using System;
using System.Collections;
using Cinemachine;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;
using XLua;

public class MathParkourModuleController : ModuleController<MathParkourModuleController>
{
	[SerializeField]
	private MathParkourLevelController levelController;

	[Header("Camera Config:")]
	[BlackList]
	public Camera closeupCamera;

	[BlackList]
	public Camera hudCamera;

	[Space]
	[BlackList]
	public CinemachineBlendDefinition.Style mainCameraBlendStyle = CinemachineBlendDefinition.Style.EaseInOut;

	[BlackList]
	public float mainCameraBlendTime;

	private GameObject travelerDarkOverlay;

	private Camera travelerDarkOverlayCamera;

	private bool isTravelerRescueCameraEnabled;

	private bool originCloseupCameraEnabled;

	private int originCloseupCameraCullingMask;

	private bool originCloseupCameraClearDepth;

	protected int _cameraControlEnableRC;

	public const string EventBuffItemCollected = "MathParkour_BuffItemCollected";

	public const string EventBuffAdded = "MathParkour_BuffAdded";

	public const string EventBuffRemoved = "MathParkour_BuffRemoved";

	public const string EventUseBuff = "MathParkour_UseBuff";

	public const string EventHudDataChanged = "MathParkour_HudDataChanged";

	public const string EventLevelEnd = "MathParkour_LevelEnd";

	public const string EventBossEncountered = "MathParkour_BossEncountered";

	public const string EventClearObs = "MATHPARKOUR_CLEAR_THE_SCENE";

	public const string EventGamePause = "MATHPARKOUR_PAUSE_STATE_CHANGED";

	public const string EventGameStart = "MATHPARKOUR_START";

	public const string EventAddScore = "MathParkour_AddScore";

	public const string EventBuffConsumed = "MathParkour_BuffConsumed";

	public const string EventSetQteSpeed = "MathParkour_SetQteSpeed";

	public const string EventRestart = "MathParkour_Restart";

	public const string EventNextLevel = "MathParkour_NextLevel";

	public const string EventCastAssistSkill = "MathParkour_CastAssistSkill";

	public const string EventEnterLevel = "MathParkour_EnterLevel";

	public const string EventStartLevel = "MATHPARKOUR_STARTLEVEL";

	public const string EventBlockInput = "MathParkour_BlockInput";

	public const string EventGM_AddHp = "MathParkour_GM_AddHp";

	public const string EventGM_AddScore = "MathParkour_GM_AddScore";

	public const string EventGM_AddBuff = "MathParkour_GM_AddBuff";

	public const string EventGM_RemoveBuff = "MathParkour_GM_RemoveBuff";

	public const string EventGM_AddObjEffect = "MathParkour_GM_AddObjEffect";

	[BlackList]
	public bool cameraControlEnabled => _cameraControlEnableRC > 0;

	public override void OnEnter(Action flowCallback)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("EnterMathParkour");
		SetupCameraStack();
		InitEventListener();
		StartCoroutine(CompleteEnterAfterFirstFrame(flowCallback));
	}

	private IEnumerator CompleteEnterAfterFirstFrame(Action flowCallback)
	{
		yield return new WaitForEndOfFrame();
		flowCallback?.Invoke();
	}

	public override void OnExit(Action flowCallback)
	{
		GameRenderUtils.ResetSceneRenderingSetting(isExit: true);
		flowCallback?.Invoke();
		ClearEventListener();
		UnSetupCameraStack();
	}

	public override void OnAfterEnter()
	{
		levelController.EnterLevel();
	}

	[BlackList]
	public CinemachineBlendDefinition VirtualCameraBlendOverride(ICinemachineCamera fromVcam, ICinemachineCamera toVcam, CinemachineBlendDefinition defaultBlend, MonoBehaviour owner)
	{
		if (!cameraControlEnabled)
		{
			return new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		}
		return defaultBlend;
	}

	public void SetupCameraStack()
	{
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		Camera mainCamera = instance.mainCamera;
		Camera uiCamera = instance.uiCamera;
		_ = instance.mainCameraAdditionalCameraData;
		closeupCamera.GetUniversalAdditionalCameraData();
		instance.SetupMainCameraRender();
		instance.SetCameraMode(mainCamera, GameCameraStackManager.CameraMode.MainMaster);
		instance.InsertCameraToCameraStack(closeupCamera, 0, GameCameraStackManager.CameraMode.MainSlave);
		instance.SetCameraMode(uiCamera, GameCameraStackManager.CameraMode.UISlave);
		instance.InsertCameraToCameraStack(hudCamera, 1, GameCameraStackManager.CameraMode.UIMaster);
		instance.SetMainCameraBrainDefaultBlendSetting(mainCameraBlendStyle, mainCameraBlendTime);
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Combine(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(VirtualCameraBlendOverride));
	}

	[BlackList]
	public void UnSetupCameraStack()
	{
		DisableTravelerRescueCameraInternal();
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		if (!(instance == null))
		{
			closeupCamera.GetUniversalAdditionalCameraData().volumeTrigger = null;
			instance.RemoveCameraFromCameraStack(closeupCamera);
			instance.RemoveCameraFromCameraStack(hudCamera);
			instance.DisableMainCameraBrainDefaultBlendSetting();
			CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Remove(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(VirtualCameraBlendOverride));
		}
	}

	public void EnableTravelerRescueCameraInternal()
	{
		DisableTravelerRescueCameraInternal();
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		Camera camera = ((instance != null) ? instance.mainCamera : null);
		if (closeupCamera == null || camera == null)
		{
			Debug.LogWarning("[MathParkour] 未配置旅人解救演出的主相机或叠加相机。", this);
			return;
		}
		instance.SetCameraMode(camera, GameCameraStackManager.CameraMode.MainSlave);
		instance.SetCameraMode(closeupCamera, GameCameraStackManager.CameraMode.MainMaster);
		originCloseupCameraEnabled = closeupCamera.enabled;
		originCloseupCameraCullingMask = closeupCamera.cullingMask;
		UniversalAdditionalCameraData universalAdditionalCameraData = closeupCamera.GetUniversalAdditionalCameraData();
		originCloseupCameraClearDepth = universalAdditionalCameraData.clearDepth;
		closeupCamera.transform.SetPositionAndRotation(camera.transform.position, camera.transform.rotation);
		closeupCamera.cullingMask = 67108864;
		universalAdditionalCameraData.clearDepth = true;
		closeupCamera.enabled = true;
		travelerDarkOverlayCamera = CreateTravelerDarkOverlayCamera(camera);
		travelerDarkOverlay = CreateTravelerDarkOverlay(travelerDarkOverlayCamera);
		isTravelerRescueCameraEnabled = true;
	}

	public void DisableTravelerRescueCameraInternal()
	{
		if (isTravelerRescueCameraEnabled)
		{
			if (closeupCamera != null)
			{
				closeupCamera.enabled = originCloseupCameraEnabled;
				closeupCamera.cullingMask = originCloseupCameraCullingMask;
				closeupCamera.GetUniversalAdditionalCameraData().clearDepth = originCloseupCameraClearDepth;
			}
			if (travelerDarkOverlay != null)
			{
				UnityEngine.Object.Destroy(travelerDarkOverlay);
			}
			if (travelerDarkOverlayCamera != null)
			{
				MonoSingleton<GameCameraStackManager>.Instance?.RemoveCameraFromCameraStack(travelerDarkOverlayCamera);
				UnityEngine.Object.Destroy(travelerDarkOverlayCamera.gameObject);
			}
			GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
			if (instance != null && closeupCamera != null)
			{
				Camera mainCamera = instance.mainCamera;
				instance.SetCameraMode(mainCamera, GameCameraStackManager.CameraMode.MainMaster);
				instance.SetCameraMode(closeupCamera, GameCameraStackManager.CameraMode.MainSlave);
			}
			travelerDarkOverlay = null;
			travelerDarkOverlayCamera = null;
			isTravelerRescueCameraEnabled = false;
		}
	}

	private Camera CreateTravelerDarkOverlayCamera(Camera mainCamera)
	{
		Camera component = new GameObject("MathParkourTravelerDarkOverlayCamera", typeof(Camera)).GetComponent<Camera>();
		component.CopyFrom(mainCamera);
		component.clearFlags = CameraClearFlags.Depth;
		component.cullingMask = 32;
		MonoSingleton<GameCameraStackManager>.Instance.InsertCameraToCameraStack(component);
		return component;
	}

	private GameObject CreateTravelerDarkOverlay(Camera overlayCamera)
	{
		GameObject gameObject = new GameObject("MathParkourTravelerDarkOverlay", typeof(Canvas), typeof(CanvasScaler), typeof(GraphicRaycaster));
		Canvas component = gameObject.GetComponent<Canvas>();
		component.renderMode = RenderMode.ScreenSpaceCamera;
		component.worldCamera = overlayCamera;
		component.planeDistance = overlayCamera.nearClipPlane + 0.01f;
		gameObject.transform.SetLayerRecursively(5);
		GameObject gameObject2 = new GameObject("DarkImage", typeof(RectTransform), typeof(Image));
		gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
		Image component2 = gameObject2.GetComponent<Image>();
		component2.color = new Color(0f, 0f, 0f, 0.6f);
		component2.raycastTarget = false;
		RectTransform rectTransform = (RectTransform)gameObject2.transform;
		rectTransform.anchorMin = Vector2.zero;
		rectTransform.anchorMax = Vector2.one;
		rectTransform.offsetMin = Vector2.zero;
		rectTransform.offsetMax = Vector2.zero;
		return gameObject;
	}

	private void InitEventListener()
	{
		EventDispatchManager instance = Singleton<EventDispatchManager>.Instance;
		if (instance != null)
		{
			instance.AddEventListener("MATHPARKOUR_PAUSE_STATE_CHANGED", OnGamePauseStateChanged);
			instance.AddEventListener("MathParkour_SetQteSpeed", OnSetQteSpeed);
			instance.AddEventListener("MathParkour_BuffAdded", OnBuffAdded);
			instance.AddEventListener("MathParkour_BuffRemoved", OnBuffRemoved);
			instance.AddEventListener("MATHPARKOUR_CLEAR_THE_SCENE", OnClearObstacles);
			instance.AddEventListener("MATHPARKOUR_START", OnGameStart);
			instance.AddEventListener("MathParkour_Restart", OnRestart);
			instance.AddEventListener("MathParkour_NextLevel", OnNextLevel);
			instance.AddEventListener("MATHPARKOUR_STARTLEVEL", OnStartLevel);
			instance.AddEventListener("MathParkour_GM_AddHp", OnGM_AddHp);
			instance.AddEventListener("MathParkour_GM_AddScore", OnGM_AddScore);
			instance.AddEventListener("MathParkour_GM_AddBuff", OnGM_AddBuff);
			instance.AddEventListener("MathParkour_GM_RemoveBuff", OnGM_RemoveBuff);
			instance.AddEventListener("MathParkour_GM_AddObjEffect", OnGM_AddObjEffect);
		}
	}

	private void ClearEventListener()
	{
		EventDispatchManager instance = Singleton<EventDispatchManager>.Instance;
		if (instance != null)
		{
			instance.RemoveEventListener("MATHPARKOUR_PAUSE_STATE_CHANGED", OnGamePauseStateChanged);
			instance.RemoveEventListener("MathParkour_SetQteSpeed", OnSetQteSpeed);
			instance.RemoveEventListener("MathParkour_BuffAdded", OnBuffAdded);
			instance.RemoveEventListener("MathParkour_BuffRemoved", OnBuffRemoved);
			instance.RemoveEventListener("MATHPARKOUR_CLEAR_THE_SCENE", OnClearObstacles);
			instance.RemoveEventListener("MATHPARKOUR_START", OnGameStart);
			instance.RemoveEventListener("MathParkour_Restart", OnRestart);
			instance.RemoveEventListener("MathParkour_NextLevel", OnNextLevel);
			instance.RemoveEventListener("MATHPARKOUR_STARTLEVEL", OnStartLevel);
			instance.RemoveEventListener("MathParkour_GM_AddHp", OnGM_AddHp);
			instance.RemoveEventListener("MathParkour_GM_AddScore", OnGM_AddScore);
			instance.RemoveEventListener("MathParkour_GM_AddBuff", OnGM_AddBuff);
			instance.RemoveEventListener("MathParkour_GM_RemoveBuff", OnGM_RemoveBuff);
			instance.RemoveEventListener("MathParkour_GM_AddObjEffect", OnGM_AddObjEffect);
		}
	}

	private void OnGamePauseStateChanged(IEvent ievent)
	{
		if (!(ievent is GeneralEvent { data: LuaTable data }))
		{
			return;
		}
		data.Get<int, object>(1, out var value);
		if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
		{
			switch (intValue)
			{
			case 1:
				levelController?.PauseGameplay();
				break;
			case 0:
				levelController?.ResumeGameplay();
				break;
			}
		}
	}

	private void OnSetQteSpeed(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<float, object>(1f, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToFloat(value.ToString(), out var floatValue))
			{
				levelController?.SetQteSpeed(floatValue);
			}
		}
	}

	private void OnBuffAdded(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<int, object>(1, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
			{
				levelController?.AddBuff(intValue);
			}
		}
	}

	private void OnBuffRemoved(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<int, object>(1, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
			{
				levelController?.RemoveBuff(intValue);
			}
		}
	}

	private void OnClearObstacles(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<int, object>(1, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
			{
				levelController?.UseBoom(intValue);
			}
		}
	}

	private void OnGameStart(IEvent ievent)
	{
		levelController?.StartGame();
	}

	private void OnRestart(IEvent ievent)
	{
		levelController?.Restart();
	}

	private void OnNextLevel(IEvent ievent)
	{
		levelController?.GoNextLevel();
	}

	private void OnStartLevel(IEvent ievent)
	{
		levelController?.StartLevelGame();
	}

	private void OnGM_AddHp(IEvent ievent)
	{
		if (!(ievent is GeneralEvent { data: LuaTable data }))
		{
			return;
		}
		data.Get<int, object>(1, out var value);
		if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
		{
			MathParkourPlayerController mathParkourPlayerController = levelController?.GetPlayerController();
			if (!(mathParkourPlayerController == null))
			{
				mathParkourPlayerController.SetHp(mathParkourPlayerController.GetHp() + intValue);
				levelController?.TryEndLevelIfPlayerDead();
			}
		}
	}

	private void OnGM_AddScore(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<int, object>(1, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
			{
				levelController?.AddScore(intValue);
			}
		}
	}

	private void OnGM_AddBuff(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<int, object>(1, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffItemCollected", intValue);
			}
		}
	}

	private void OnGM_RemoveBuff(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			data.Get<int, object>(1, out var value);
			if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffRemoved", intValue);
			}
		}
	}

	private void OnGM_AddObjEffect(IEvent ievent)
	{
		if (!(ievent is GeneralEvent { data: LuaTable data }))
		{
			return;
		}
		data.Get<int, object>(1, out var value);
		if (value != null && StringParamHelper.TryParseStringParamToInt(value.ToString(), out var intValue))
		{
			data.Get<int, object>(2, out var value2);
			if (value2 != null && StringParamHelper.TryParseStringParamToInt(value2.ToString(), out var intValue2))
			{
				levelController?.AddObjEffect(intValue, intValue2);
			}
		}
	}
}
