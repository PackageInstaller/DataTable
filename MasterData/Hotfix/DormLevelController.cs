#define LOG_ERROR
#define LOG_WARNING
#define LOG_TRACE
#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using DG.Tweening;
using Nova.Hotfix;
using Pathfinding;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using XLua;

public class DormLevelController : DynamicLevelController
{
	private enum DormDragState
	{
		None,
		DraggingCamera,
		DraggingRole,
		DraggingFurObj
	}

	[Flags]
	private enum DormInputCap
	{
		None = 0,
		CameraPan = 1,
		CameraRotate = 2,
		CameraZoom = 4,
		PlayerMove = 8,
		PickActor = 0x10,
		PickFurObj = 0x20
	}

	public enum InteractiveType
	{
		Player2Actor,
		Player2Obj
	}

	private enum DormPostProcessState
	{
		Unknown = -1,
		None,
		Default,
		InteractFocus,
		View,
		ViewTop,
		Edit,
		SwitchActor,
		Visitor
	}

	private class PpsNode
	{
		public GameObject go;

		public Volume volume;

		public float restWeight;

		public Tweener tween;
	}

	private struct SwitchActorPoseSnapshot
	{
		public DormActor actor;

		public Vector3 position;

		public float yaw;

		public DormFurObj interactFurObj;

		public DormFurObjInteractivePoint interactPoint;
	}

	private DormLevelLoadParam levelLoadParam;

	private DormActor.DormMode dormMode;

	private bool applyingLuaModeOnLevelLoad;

	private NavmeshCut[] navmeshCuts;

	private GameObject _rvoSimulatorGO;

	private DormCameraConfigureData cameraConfigDefault;

	private DormCameraConfigureData cameraConfigEdit;

	private DormCameraConfigureData cameraConfigView;

	private DormCameraConfigureData cameraConfigSwitchActor;

	private DormRoom dormRoomData;

	private GameObject actorParentNode;

	private List<DormActor> listActor = new List<DormActor>();

	private static readonly Type dormActorType = typeof(DormActor);

	private const string SPAWN_POINT_NODE_NAME = "spawnpoint";

	private bool _hasSceneSpawnPoint;

	private Vector3 _sceneSpawnPointPos;

	private float _sceneSpawnPointYaw;

	private DormActor _pendingElevatorActor;

	private DormFurObj _pendingElevatorObj;

	private DormFurObjInteractivePoint _pendingElevatorPoint;

	private bool _elevatorWaitingRoomChoice;

	private bool _elevatorExitPending;

	private bool _elevatorFlowNotified;

	private Coroutine _elevatorCoroutine;

	private const string DORM_JOYSTICK_PREFAB_LOAD_COMPLETE = "DormJoystickPrefabLoadComplete";

	private const string DORM_SWICH_MODE = "DormSwicthMode";

	private const string DORM_LUA_CREATE_FURNITURE = "DORM_LUA_CREATE_FURNITURE";

	private const string DORM_LUA_UNSELECT_FURNITURE = "DORM_LUA_UNSELECT_FURNITURE";

	private const string DORM_LUA_ROTATE_FURNITURE = "DORM_LUA_ROTATE_FURNITURE";

	private const string DORM_LUA_CANCEL_FURNITURE = "DORM_LUA_CANCEL_FURNITURE";

	private const string DORM_LUA_DELETE_FURNITURE = "DORM_LUA_DELETE_FURNITURE";

	private const string DORM_LUA_SAVE_ROOM = "DORM_LUA_SAVE_ROOM";

	private const string DORM_LUA_SAVE_ROOM_SUCC = "DORM_LUA_SAVE_ROOM_SUCC";

	private const string DORM_LUA_ABANDON_SAVE_ROOM = "DORM_LUA_ABANDON_SAVE_ROOM";

	private const string DORM_LUA_CLEAR_ROOM = "DORM_LUA_CLEAR_ROOM";

	private const string DORM_LUA_APPLY_PRESET = "DORM_LUA_APPLY_PRESET";

	private const string DORM_LUA_BUTTON_DORM_INTERACTIVE_HUD = "BUTTON_DORM_INTERACTIVE_HUD";

	private const string DORM_LUA_HIDE_FLOOR_FUR = "DORM_LUA_HIDE_FLOOR_FUR";

	private const string DORM_LUA_HIDE_WALL_FUR = "DORM_LUA_HIDE_WALL_FUR ";

	private const string DORM_LUA_SELECT_SCENE_CALLBACK = "DORM_LUA_SELECT_SCENE_CALLBACK";

	private const string DORM_LUA_SWITCH_ACTOR_CALLBACK = "DORM_LUA_SWITCH_ACTOR_CALLBACK";

	private const string DORM_LUA_SELECT_ACTOR_CALLBACK = "DORM_LUA_SELECT_ACTOR_CALLBACK";

	private const string DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK = "DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK";

	private const string DORM_LUA_REFRESH_SCENE = "DORM_LUA_REFRESH_SCENE";

	private const string DORM_LUA_SET_UI_HIDDEN = "DORM_LUA_SET_UI_HIDDEN";

	private const string DORM_CS2LUA_SHOW_SELECT_ROME_UI = "DORM_CS2LUA_SHOW_SELECT_ROME_UI";

	private const string DORM_CS2LUA_SWITCH_NEW_ROOM = "DORM_CS2LUA_SWITCH_NEW_ROOM";

	private const string DORM_CS2LUA_CLOSE_INTERACTIVE_ICON = "DORM_CS2LUA_CLOSE_INTERACTIVE_ICON";

	private const string DORM_CS2LUA_ENTER_CHAR_ACTIVE = "DORM_CS2LUA_ENTER_CHAR_ACTIVE";

	private bool _interactiveIconShowing;

	private DormActor _interactTargetActor;

	private DormDragState dragState;

	private DormActor dragActor;

	private DormFurObj hoverFurniture;

	private DormFurObj draggingFromFurObj;

	private Vector3 draggingFromPos;

	private const float DRAG_TRIGGER_PIXELS = 20f;

	private DormActor pendingDragActor;

	private Vector2 pendingDragStartScreenPos;

	private float pendingDragStartTime;

	private Vector2 _lastPressDownScreenPos;

	private bool _pointerDraggedSincePressDown;

	private DormInputCap _blockedInputCaps;

	private List<long> playerEnterRngObjs = new List<long>();

	private Dictionary<long, DormFurObj> enInteractiveObjDic = new Dictionary<long, DormFurObj>();

	private List<DormFurObj> _interactCandidates = new List<DormFurObj>();

	private bool _interactivePrevShowedHud;

	private bool _lastInMoveCone;

	private DormActor _focusActor;

	private bool _focusUseActorOnly;

	private DormActor _noticedActor;

	private const float CELL_OCCUPIED_BY_ACTOR_RADIUS = 0.5f;

	private static readonly int InteractOcclusionMask = 267264;

	private const string POST_PROCESS_ROOT_NAME = "==== PostProcessing ====";

	private const string PPS_DEFAULT_NODE_NAME = "PPS_Default";

	private const string PPS_INTERACT_FOCUS_NODE_NAME = "PPS_InteractFocus";

	private const string PPS_VIEW_NODE_NAME = "PPS_View";

	private const string PPS_VIEW_TOP_NODE_NAME = "PPS_ViewTop";

	private const string PPS_EDIT_NODE_NAME = "PPS_Edit";

	private const string PPS_SWITCH_ACTOR_NODE_NAME = "PPS_SwitchActor";

	private const string PPS_VISITOR_NODE_NAME = "PPS_Visitor";

	private PpsNode _ppsDefault;

	private PpsNode _ppsInteractFocus;

	private PpsNode _ppsView;

	private PpsNode _ppsViewTop;

	private PpsNode _ppsEdit;

	private PpsNode _ppsSwitchActor;

	private PpsNode _ppsVisitor;

	private DormPostProcessState _appliedPostProcessState = DormPostProcessState.Unknown;

	private bool _viewTopZoomReached;

	private DormRoomInfo roomInfo;

	private DormRoomInfo roomInfoToSave;

	private FurniturePresetInfo presetInfo;

	private DormRoomObj objCurRoom;

	private DormFurObj objCurFur;

	private Camera camera;

	private Ray ray;

	private RaycastHit hit;

	private DormFurObj objFur_RaycastHit;

	private Collider colWall;

	private bool bHasHit;

	private bool isDraggingFurObj;

	private bool bFurObjHudVisible;

	private bool bFurObjHudEnableUpdatePos;

	private Vector3Int v3iLastSnapped = Vector3Int.left;

	private int nPreviousID;

	private const int MOWANG_ROLE_ID_MALE = 9101;

	private const int MOWANG_ROLE_ID_FEMALE = 9100;

	private const string SWITCH_NODE_NAME = "==== SwitchNode ====";

	private const string ACTOR_POINTS_NODE_NAME = "---- ActorPoints ----";

	private const string CAMERA_BEACON_NODE_NAME = "---- CameraBeaconPosition ----";

	private readonly List<Transform> _switchActorPoints = new List<Transform>();

	private Transform _switchCameraBeacon;

	private bool _switchNodeCached;

	private DormActor[] _switchPointOccupants;

	private DormActor.DormMode _modeBeforeSwitchActor;

	private readonly List<SwitchActorPoseSnapshot> _switchActorPoseSnapshots = new List<SwitchActorPoseSnapshot>();

	private const string BORN_TIMELINE_SCENE_PATH = "DormLevel/001/DormLevel_001_Born";

	private const string BORN_TIMELINE_MALE = "DormBorn_Male";

	private const string BORN_TIMELINE_FEMALE = "DormBorn_Female";

	private const string CAMERA_TRACK_NAME = "CAMERA";

	private const string ACTOR_TRACK_NAME = "ACTOR";

	private const string DORM_CS2LUA_BORN_TIMELINE_DONE = "DORM_CS2LUA_BORN_TIMELINE_DONE";

	private PlayableDirector _bornDirector;

	private GameObject _bornTimelineNodeGo;

	private DormActor _bornPerformActor;

	private Transform _bornPerformAnimatorTrans;

	private Vector3 _bornPerformAnimatorLocalPos;

	private Quaternion _bornPerformAnimatorLocalRot;

	private Transform _hideNode;

	public List<DormActor> Actors => listActor;

	public bool IsElevatorFlowActive { get; private set; }

	public bool IsInteractingWithActor
	{
		get
		{
			if (!_interactiveIconShowing)
			{
				return null != _interactTargetActor;
			}
			return true;
		}
	}

	private DormPlayerController playerController => MonoSingleton<DormPlayerController>.Instance;

	private DormCameraController cameraController => SceneSingleton<DormCameraController>.Instance;

	public bool IsInputRestricted => _blockedInputCaps != DormInputCap.None;

	private Camera CAM
	{
		get
		{
			if (camera == null)
			{
				camera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			}
			return camera;
		}
	}

	public override void Load(Action callback = null)
	{
		base.Load(callback);
		ParseLevelData();
		if (levelLoadParam == null)
		{
			NovaLogger.Error("levelLoadParam为空!");
			callback?.Invoke();
			return;
		}
		dormRoomData = Singleton<HotfixDataController>.Instance.GetDormRoom(levelLoadParam.DormRoomId);
		if (dormRoomData == null)
		{
			NovaLogger.Error($"没有找到ID为{levelLoadParam.DormRoomId}的后宅房间数据[DormRoom]!");
			callback?.Invoke();
			return;
		}
		int num = ((levelLoadParam.DormRoomSceneId > 0) ? levelLoadParam.DormRoomSceneId : dormRoomData.SceneRes);
		DormRoomScene dormRoomScene = Singleton<HotfixDataController>.Instance.GetDormRoomScene(num);
		if (dormRoomScene == null)
		{
			NovaLogger.Error($"没有找到ID为{num}的后宅房间场景数据[DormRoomScene]!");
			callback?.Invoke();
			return;
		}
		scenePath = "Assets/AssetBundles/" + dormRoomScene.SceneRes;
		if (string.IsNullOrEmpty(scenePath))
		{
			NovaLogger.Error(dormRoomScene.SceneRes + "后宅房间场景的[SceneRes]路径为空!");
			callback?.Invoke();
			return;
		}
		MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
		{
			LevelLoadProcessUpdate(sceneName, process);
			return true;
		});
		InitEventListener();
		InitCameraConfigs();
	}

	private void InitNavigation()
	{
		AstarPath active = AstarPath.active;
		if (null == active)
		{
			NovaLogger.Error("没有找到导航组件!");
			return;
		}
		MeshFilter componentInChildren = active.GetComponentInChildren<MeshFilter>();
		MeshCollider componentInChildren2 = active.GetComponentInChildren<MeshCollider>();
		if (null == componentInChildren || null == componentInChildren2)
		{
			NovaLogger.Error(active.gameObject.name + "没有找到导航MeshFilter子节点!");
			return;
		}
		DormRoomSize dormRoomSize = Singleton<HotfixDataController>.Instance.GetDormRoomSize(dormRoomData.RoomSizeType);
		if (dormRoomSize == null)
		{
			NovaLogger.Error($"[DormRoomSize]表中没有找到{dormRoomData.RoomSizeType}类型的数据！");
			return;
		}
		string text = "Assets/AssetBundles/" + dormRoomSize.NavigationMesh + ".FBX";
		Mesh mesh = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, text, typeof(Mesh)) as Mesh;
		if (null == mesh)
		{
			NovaLogger.Error("没有加载到导航mesh资源:" + text);
			return;
		}
		componentInChildren.sharedMesh = null;
		componentInChildren.sharedMesh = mesh;
		componentInChildren2.sharedMesh = null;
		componentInChildren2.sharedMesh = mesh;
		componentInChildren2.transform.position = new Vector3(dormRoomSize.L, 0f, dormRoomSize.W) * 0.5f;
		RecastGraph recastGraph = active.data.recastGraph;
		if (recastGraph == null)
		{
			NovaLogger.Error("AstarPath 上没有找到 RecastGraph!");
			return;
		}
		Physics.SyncTransforms();
		active.Scan(recastGraph);
		SceneSingleton<DormCameraController>.Instance.SetDragRngCenter(componentInChildren2.transform.position);
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		try
		{
			LevelLoadCompleteInitialize(sceneName);
		}
		catch (Exception arg)
		{
			NovaLogger.Error($"[后宅]关卡加载完成后的初始化抛异常，场景[{sceneName}]:{arg}");
		}
		finally
		{
			base.LevelLoadComplete(sceneName);
		}
	}

	private void LevelLoadCompleteInitialize(string sceneName)
	{
		Scene sceneByName = BundleHandler.GetSceneByName(sceneName);
		GameRenderUtils.SetupSceneRenderingSetting(sceneByName);
		CacheSceneSpawnPoint(sceneByName);
		InitNavigation();
		ResetSwitchNodeCache();
		InitPostProcessNodes(sceneByName);
		SwitchRoom(roomInfo);
		applyingLuaModeOnLevelLoad = true;
		try
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("OnEvent_DormLevelLoadComplete");
		}
		finally
		{
			applyingLuaModeOnLevelLoad = false;
		}
		InitActors();
		SceneSingleton<DormCameraController>.Instance.CameraControlEnable();
		InitInputControl();
		SwitchDormMode(dormMode);
		if (!TryRunElevatorExitFlowAfterReload())
		{
			InitElevatorDoorNaviCut();
		}
		PlayBornTimeline(sceneByName);
	}

	private void InitCameraConfigs()
	{
		DormRoom dormRoom = Singleton<HotfixDataController>.Instance.GetDormRoom(levelLoadParam.DormRoomId);
		if (dormRoom != null)
		{
			DormRoomSize dormRoomSize = Singleton<HotfixDataController>.Instance.GetDormRoomSize(dormRoom.RoomType);
			if (dormRoomSize != null)
			{
				cameraConfigDefault = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Dorm/Configs/CameraConfigs/" + dormRoomSize.CameraConfigDefault + ".asset", typeof(DormCameraConfigureData)) as DormCameraConfigureData;
				cameraConfigEdit = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Dorm/Configs/CameraConfigs/" + dormRoomSize.CameraConfigEdit + ".asset", typeof(DormCameraConfigureData)) as DormCameraConfigureData;
				cameraConfigView = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Dorm/Configs/CameraConfigs/" + dormRoomSize.CameraConfigView + ".asset", typeof(DormCameraConfigureData)) as DormCameraConfigureData;
				cameraConfigSwitchActor = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Dorm/Configs/CameraConfigs/" + dormRoomSize.CameraConfigSwitch + ".asset", typeof(DormCameraConfigureData)) as DormCameraConfigureData;
			}
		}
	}

	public void SwitchDormMode(DormActor.DormMode dormMode)
	{
		if (this.dormMode == DormActor.DormMode.Visitor && dormMode != DormActor.DormMode.Visitor && dormMode != DormActor.DormMode.Default && !applyingLuaModeOnLevelLoad)
		{
			NovaLogger.Warning($"[Dorm] 访客模式下禁止切到 {dormMode}，已忽略(仅允许切回 Default 退出访客)。");
			return;
		}
		DormActor.DormMode dormMode2 = this.dormMode;
		SetBlockedInputCaps(DormInputCap.None);
		EndPointerDragInProgress();
		CloseInteractiveIconIfShowing();
		if (dormMode2 == DormActor.DormMode.View && (dormMode == DormActor.DormMode.Edit || dormMode == DormActor.DormMode.SwitchActor))
		{
			SceneSingleton<DormCameraController>.Instance.SaveViewCameraState();
		}
		else if (dormMode == DormActor.DormMode.Default || dormMode == DormActor.DormMode.Visitor)
		{
			SceneSingleton<DormCameraController>.Instance.DiscardViewCameraState();
		}
		if (this.dormMode == DormActor.DormMode.SwitchActor && dormMode != DormActor.DormMode.SwitchActor)
		{
			ExitSwitchActorFlow();
		}
		if (dormMode2 != DormActor.DormMode.SwitchActor && dormMode == DormActor.DormMode.SwitchActor)
		{
			CaptureActorPosesBeforeSwitchActor();
		}
		if ((this.dormMode != DormActor.DormMode.View && this.dormMode != DormActor.DormMode.Default) || (dormMode != DormActor.DormMode.View && dormMode != DormActor.DormMode.Default))
		{
			InterruptAllInteractionsToEndForModeSwitch();
		}
		this.dormMode = dormMode;
		ActorSwitchDormMode(dormMode);
		switch (dormMode)
		{
		case DormActor.DormMode.Default:
			SceneSingleton<DormCameraController>.Instance.OverrideCameraConfig(cameraConfigDefault);
			break;
		case DormActor.DormMode.Visitor:
			SceneSingleton<DormCameraController>.Instance.OverrideCameraConfig(cameraConfigDefault);
			break;
		case DormActor.DormMode.View:
			SceneSingleton<DormCameraController>.Instance.BindFocusObjectDefault();
			if (!SceneSingleton<DormCameraController>.Instance.hasViewCameraSnapshot)
			{
				SceneSingleton<DormCameraController>.Instance.CenterBeaconToDragRngCenter();
			}
			SceneSingleton<DormCameraController>.Instance.OverrideCameraConfig(cameraConfigView);
			SceneSingleton<DormCameraController>.Instance.RestoreViewCameraState();
			break;
		case DormActor.DormMode.Edit:
			SceneSingleton<DormCameraController>.Instance.BindFocusObjectDefault();
			SceneSingleton<DormCameraController>.Instance.CenterBeaconToDragRngCenter();
			SceneSingleton<DormCameraController>.Instance.OverrideCameraConfig(cameraConfigEdit);
			break;
		case DormActor.DormMode.SwitchActor:
			SceneSingleton<DormCameraController>.Instance.OverrideCameraConfig(cameraConfigSwitchActor);
			break;
		}
		SwitchRoomMode(dormMode);
		if (dormMode == DormActor.DormMode.SwitchActor)
		{
			EnterSwitchActorFlow();
		}
		if (dormMode2 == DormActor.DormMode.SwitchActor && dormMode != DormActor.DormMode.SwitchActor)
		{
			ResumeInteractionsAfterSwitchActorExit();
		}
		SceneSingleton<DormAudioListenerController>.Instance?.SwitchDormMode(dormMode);
		RefreshPostProcessState();
		MonoSingleton<LuaManager>.Instance?.FireEvent("DormGuide_ModeApplied", (int)dormMode);
	}

	protected override void UnloadLevelComplete(Action unloadCallback = null)
	{
		base.UnloadLevelComplete(unloadCallback);
	}

	public override void LevelStart()
	{
		base.LevelStart();
		EnsureRVOSimulator();
		ForceUpdateNavCuts();
	}

	public void EnsureRVOSimulator()
	{
		if (!(RVOSimulator.active != null) && !(_rvoSimulatorGO != null))
		{
			_rvoSimulatorGO = new GameObject("DormRVOSimulator");
			_rvoSimulatorGO.SetActive(value: false);
			DeterministicRVOSimulator deterministicRVOSimulator = _rvoSimulatorGO.AddComponent<DeterministicRVOSimulator>();
			deterministicRVOSimulator.workerThreads = ThreadCount.None;
			deterministicRVOSimulator.movementPlane = MovementPlane.XZ;
			deterministicRVOSimulator.desiredSimulationFPS = 20;
			_rvoSimulatorGO.SetActive(value: true);
		}
	}

	private void ReleaseRVOSimulator()
	{
		if (_rvoSimulatorGO != null)
		{
			UnityEngine.Object.Destroy(_rvoSimulatorGO);
			_rvoSimulatorGO = null;
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		CloseInteractiveIconIfShowing();
		SceneSingleton<DormCameraController>.Instance.ExitFocus();
		ResetPostProcessCache();
		SceneSingleton<DormCameraController>.Instance.CameraControlDisable();
		SceneSingleton<DormCameraController>.Instance.DiscardViewCameraState();
		ClearInputControl();
		ClearEventListener();
		_blockedInputCaps = DormInputCap.None;
		DestroyAllActors();
		ReleaseRVOSimulator();
		if (playerEnterRngObjs != null)
		{
			for (int num = playerEnterRngObjs.Count - 1; num >= 0; num--)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("DEACTIVE_DORM_INTERACTIVE_HUD", playerEnterRngObjs.get_Item(num));
			}
			playerEnterRngObjs.Clear();
		}
	}

	public override void LevelFinish()
	{
		base.LevelFinish();
		DestroyRoom();
	}

	public void ForceUpdateNavCuts()
	{
		AstarPath.active?.navmeshUpdates?.ForceUpdate();
		AstarPath.active?.FlushGraphUpdates();
	}

	private void Update()
	{
		RVOSimulator.active?.GetSimulator().Update();
		UpdateInteractive();
		UpdateInteractFocus();
		UpdatePostProcessViewTop();
		UpdateActors();
		if (Input.GetKeyDown(KeyCode.P))
		{
			EventFromLua_RefreshScene(null);
		}
	}

	private void InitActors()
	{
		if (Actors != null && Actors.Count != 0)
		{
			return;
		}
		List<DormRoleInfo> listRoleInfo = levelLoadParam.listRoleInfo;
		if (listRoleInfo == null || listRoleInfo.Count == 0)
		{
			return;
		}
		ClearSpawnReservations();
		for (int i = 0; i < listRoleInfo.Count; i++)
		{
			DormRoleInfo dormRoleInfo = listRoleInfo.get_Item(i);
			SpawnActor(dormRoleInfo.RoleId, dormRoleInfo.SkinId, (DormActor actor) =>
			{
				listActor.Add(actor);
				if (!(actor is DormPlayer) || !TrySpawnActorAtSceneSpawnPoint(actor))
				{
					SpawnActorToRandomCell(actor);
				}
				actor.Spawn();
				if (actor is DormPlayer)
				{
					MonoSingleton<DormPlayerController>.Instance.InitDormPlayer(actor as DormPlayer);
				}
			});
		}
	}

	private void CacheSceneSpawnPoint(Scene scene)
	{
		_hasSceneSpawnPoint = false;
		if (levelLoadParam != null && levelLoadParam.bIsGuide)
		{
			Transform transform = FindSpawnPointNode(scene);
			if (!(null == transform))
			{
				_hasSceneSpawnPoint = true;
				_sceneSpawnPointPos = transform.position;
				_sceneSpawnPointYaw = transform.eulerAngles.y;
				NovaLogger.Trace($"[Dorm]场景[{scene.name}]找到出生点节点[{transform.name}]：位置{_sceneSpawnPointPos}，朝向 y={_sceneSpawnPointYaw:F1}。");
			}
		}
	}

	public bool TryGetSceneSpawnPoint(out Vector3 pos, out float yaw)
	{
		pos = _sceneSpawnPointPos;
		yaw = _sceneSpawnPointYaw;
		return _hasSceneSpawnPoint;
	}

	private bool TrySpawnActorAtSceneSpawnPoint(DormActor actor)
	{
		if (!_hasSceneSpawnPoint || null == actor)
		{
			return false;
		}
		actor.SyncMovementLocation(new TSVector2(_sceneSpawnPointPos.x, _sceneSpawnPointPos.z), _sceneSpawnPointPos.y);
		actor.SyncRotation(_sceneSpawnPointYaw);
		return true;
	}

	private static Transform FindSpawnPointNode(Scene scene)
	{
		if (!scene.IsValid())
		{
			return null;
		}
		GameObject[] rootGameObjects = scene.GetRootGameObjects();
		for (int i = 0; i < rootGameObjects.Length; i++)
		{
			if (rootGameObjects[i].name.ToLowerInvariant().Equals("spawnpoint"))
			{
				return rootGameObjects[i].transform;
			}
		}
		for (int j = 0; j < rootGameObjects.Length; j++)
		{
			Transform transform = rootGameObjects[j].transform;
			int childCount = transform.childCount;
			for (int k = 0; k < childCount; k++)
			{
				Transform child = transform.GetChild(k);
				if (child.name.ToLowerInvariant().Equals("spawnpoint"))
				{
					return child;
				}
			}
		}
		return null;
	}

	private void RefreshScene()
	{
		if (IsElevatorFlowActive)
		{
			NovaLogger.Debug("[Dorm] 刷新场景：电梯流程进行中，忽略本次刷新。");
			return;
		}
		CloseInteractiveIconIfShowing();
		bool flag = dormMode == DormActor.DormMode.View;
		if (flag)
		{
			SceneSingleton<DormCameraController>.Instance.SaveViewCameraState();
		}
		InterruptAllInteractionsToEndForModeSwitch();
		if (playerEnterRngObjs != null)
		{
			for (int num = playerEnterRngObjs.Count - 1; num >= 0; num--)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("DEACTIVE_DORM_INTERACTIVE_HUD", playerEnterRngObjs.get_Item(num));
			}
			playerEnterRngObjs.Clear();
		}
		_noticedActor = null;
		if (null != objCurRoom && objCurRoom.ListFurObj != null)
		{
			IReadOnlyList<DormFurObj> listFurObj = objCurRoom.ListFurObj;
			for (int i = 0; i < listFurObj.Count; i++)
			{
				listFurObj.get_Item(i)?.ResetInteractiveState();
			}
		}
		InitElevatorDoorNaviCut();
		ForceUpdateNavCuts();
		ClearSpawnReservations();
		for (int j = 0; j < listActor.Count; j++)
		{
			DormActor dormActor = listActor.get_Item(j);
			if (!(null == dormActor))
			{
				dormActor.ResetToSpawnState();
				SpawnActorToRandomCell(dormActor);
				dormActor.Spawn();
			}
		}
		if (flag)
		{
			SceneSingleton<DormCameraController>.Instance.RestoreViewCameraState();
		}
	}

	private void SetNewActorOnStage(int actorID, int skinID)
	{
		int pointIndex = AcquireStagePointIndex();
		if (pointIndex < 0)
		{
			NovaLogger.Error($"选角上场失败：站位点已满，角色 {actorID} 无法上场。");
			return;
		}
		DormActor dormActor = FindActorByRoleId(actorID);
		if (null != dormActor)
		{
			PlaceActorAtStagePoint(dormActor, pointIndex);
			return;
		}
		SpawnActor(actorID, skinID, (DormActor newActor) =>
		{
			listActor.Add(newActor);
			newActor.SwitchDormMode(DormActor.DormMode.SwitchActor);
			PlaceActorAtStagePoint(newActor, pointIndex);
		});
	}

	private void RemoveActorOnStage(int actorID)
	{
		DormActor dormActor = FindActorByRoleId(actorID);
		if (null == dormActor)
		{
			NovaLogger.Warning($"选角下场：未找到角色 {actorID}。");
			return;
		}
		if (dormActor is DormPlayer)
		{
			NovaLogger.Error($"魔王不可下场(actorID={actorID})。");
			return;
		}
		ReleaseStagePointByActor(dormActor);
		dormActor.StopIdleShowAnim();
		dormActor.Hide();
	}

	private void SpawnActor(int actorID, int skinId, Action<DormActor> callback)
	{
		DormRole dormRole = Singleton<HotfixDataController>.Instance.GetDormRole(actorID);
		if (dormRole == null)
		{
			NovaLogger.Error($"后宅角色没有找到数据:{actorID}");
			return;
		}
		DormRoleSkin dormRoleSkin = Singleton<HotfixDataController>.Instance.GetDormRoleSkin(skinId);
		if (dormRoleSkin == null)
		{
			NovaLogger.Error($"后宅角色{actorID}皮肤没有找到数据:{skinId}");
			return;
		}
		string modelSD = dormRoleSkin.ModelSD;
		if (string.IsNullOrEmpty(modelSD))
		{
			NovaLogger.Error($"后宅角色{actorID}皮肤{skinId}模型路径为空!");
			return;
		}
		string text = "Assets/AssetBundles/" + modelSD + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, text, typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			NovaLogger.Error($"后宅角色{actorID}皮肤{skinId}模型路径{text}加载模型出错!");
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject);
		if (null == gameObject2)
		{
			NovaLogger.Error($"后宅角色{actorID}皮肤{skinId}模型路径{text}实例化模型出错!");
			return;
		}
		DormActor dormActor = null;
		dormActor = ((dormRole.RoleType != 0) ? gameObject2.AddOrGetComponent<DormActor>() : gameObject2.AddOrGetComponent<DormPlayer>());
		dormActor.LoadData(dormRole, dormRoleSkin);
		callback?.Invoke(dormActor);
	}

	private void DestroyAllActors()
	{
		ClearActorReferencesBeforeDestroy();
		for (int num = listActor.Count - 1; num >= 0; num--)
		{
			DormActor dormActor = listActor.get_Item(num);
			if (null != dormActor)
			{
				UnityEngine.Object.Destroy(dormActor.gameObject);
			}
		}
		listActor.Clear();
		ActorEntities?.Clear();
		MonoSingleton<DormPlayerController>.Instance?.InitDormPlayer(null);
	}

	private void ClearActorReferencesBeforeDestroy()
	{
		if (null != _noticedActor)
		{
			_noticedActor = null;
		}
		enInteractiveObjDic?.Clear();
		if (_switchPointOccupants != null)
		{
			Array.Clear(_switchPointOccupants, 0, _switchPointOccupants.Length);
		}
		_pendingElevatorActor = null;
		_pendingElevatorObj = null;
		_pendingElevatorPoint = null;
	}

	public void ActorHideAll()
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).Hide();
		}
	}

	public void ActorShowAll()
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).Visible();
		}
	}

	public void ActorRestoreAllAfterReload()
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).RestoreVisibleAndLogic();
		}
	}

	public void ActorStopAllLogic()
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).StopLogic();
		}
	}

	public void ActorResumeAllLogic()
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).ResumeLogic();
		}
	}

	private void ActorRelocateAllOntoNavmesh()
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).RelocateOntoNavmesh();
		}
	}

	private void ActorSwitchDormMode(DormActor.DormMode dormMode)
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			listActor.get_Item(i).SwitchDormMode(dormMode);
		}
	}

	private DormActor GetActorByEntityID(long entityID)
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			DormActor dormActor = listActor.get_Item(i);
			if (dormActor.id == entityID)
			{
				return dormActor;
			}
		}
		return null;
	}

	private DormActor GetActorById(long uid)
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			DormActor dormActor = listActor.get_Item(i);
			if (null != dormActor && dormActor.id == uid)
			{
				return dormActor;
			}
		}
		return null;
	}

	public override void RegisterEntity(DynamicSimpleEntity entity)
	{
		base.RegisterEntity(entity);
		if (dormActorType.IsInstanceOfType(entity))
		{
			if (!ActorEntities.Contains(entity))
			{
				ActorEntities.Add(entity);
			}
			else
			{
				_logger.LogError("重复注册后宅角色类型实体:" + entity.gameObject.name);
			}
		}
	}

	public override void UnRegisterEntity(DynamicSimpleEntity entity)
	{
		base.UnRegisterEntity(entity);
		if (dormActorType.IsInstanceOfType(entity))
		{
			if (ActorEntities.Contains(entity))
			{
				ActorEntities.Remove(entity);
			}
			else
			{
				_logger.LogError("重复销毁后宅角色类型实体:" + entity.gameObject.name);
			}
		}
	}

	private void UpdateActors()
	{
	}

	public void RunElevatorEnterFlow(DormActor actor, DormFurObj obj, DormFurObjInteractivePoint point, bool placeAtStartImmediately)
	{
		if (!(null == actor) && !(null == obj) && point != null)
		{
			_pendingElevatorActor = actor;
			_pendingElevatorObj = obj;
			_pendingElevatorPoint = point;
			_elevatorWaitingRoomChoice = false;
			IsElevatorFlowActive = true;
			_elevatorFlowNotified = true;
			MonoSingleton<LuaManager>.Instance.FireEvent("DORM_CS2LUA_SHOW_SELECT_ROME_UI", 0);
			StartElevatorCoroutine(ElevatorEnterFlow(placeAtStartImmediately));
		}
	}

	public bool TryRunElevatorExitFlowAfterReload()
	{
		if (!_elevatorExitPending)
		{
			return false;
		}
		_elevatorExitPending = false;
		DormPlayer dormPlayer = ((MonoSingleton<DormPlayerController>.Instance != null) ? MonoSingleton<DormPlayerController>.Instance.Player : null);
		DormFurObj dormFurObj = FindElevatorInCurRoom();
		if (null == dormPlayer || null == dormFurObj)
		{
			return false;
		}
		DormFurObjInteractivePoint freeInteractivePoint = dormFurObj.GetFreeInteractivePoint(0L);
		if (freeInteractivePoint == null || null == freeInteractivePoint.target_by_anim_end || null == freeInteractivePoint.target_by_anim_start)
		{
			return false;
		}
		if (enInteractiveObjDic == null)
		{
			enInteractiveObjDic = new Dictionary<long, DormFurObj>();
		}
		enInteractiveObjDic.set_Item(dormPlayer.id, dormFurObj);
		freeInteractivePoint.bindEntityID = dormPlayer.id;
		_pendingElevatorActor = dormPlayer;
		_pendingElevatorObj = dormFurObj;
		_pendingElevatorPoint = freeInteractivePoint;
		_elevatorWaitingRoomChoice = false;
		Transform target_by_anim_end = freeInteractivePoint.target_by_anim_end;
		dormPlayer.SyncMovementLocation(new TSVector2(target_by_anim_end.position.x, target_by_anim_end.position.z), 0);
		dormPlayer.SyncRotation(target_by_anim_end.eulerAngles.y);
		dormPlayer.ResetStateForElevatorReentry();
		DormInteractiveContext ctx = new DormInteractiveContext
		{
			furObj = dormFurObj,
			point = freeInteractivePoint,
			placeAtStartImmediately = false,
			isExitFlow = true
		};
		dormPlayer.DoInteractiveWithObject(ctx);
		return true;
	}

	private void InitElevatorDoorNaviCut()
	{
		DormFurObj dormFurObj = FindElevatorInCurRoom();
		if (null != dormFurObj)
		{
			SetElevatorDoorNaviCut(dormFurObj, blocked: true);
		}
	}

	private void SetElevatorDoorNaviCut(DormFurObj elevator, bool blocked)
	{
		if (!(null == elevator) && blocked)
		{
			elevator.EnableAnimNaviCut(blocked);
			ForceUpdateNavCuts();
		}
	}

	private DormFurObj FindElevatorInCurRoom()
	{
		if (null == objCurRoom)
		{
			return null;
		}
		IReadOnlyList<DormFurObj> listFurObj = objCurRoom.ListFurObj;
		if (listFurObj == null)
		{
			return null;
		}
		for (int i = 0; i < listFurObj.Count; i++)
		{
			DormFurObj dormFurObj = listFurObj.get_Item(i);
			if (null != dormFurObj && dormFurObj.IsElevator)
			{
				return dormFurObj;
			}
		}
		return null;
	}

	public void RunElevatorExitFlow(DormActor actor, DormFurObj obj, DormFurObjInteractivePoint point)
	{
		if (!(null == actor) && !(null == obj) && point != null)
		{
			_pendingElevatorActor = actor;
			_pendingElevatorObj = obj;
			_pendingElevatorPoint = point;
			StartElevatorCoroutine(ElevatorExitFlow());
		}
	}

	private IEnumerator ElevatorExitFlow()
	{
		DormActor actor = _pendingElevatorActor;
		DormFurObj obj = _pendingElevatorObj;
		Transform startTr = _pendingElevatorPoint?.target_by_anim_start;
		if (null == actor || null == obj || null == startTr)
		{
			EndElevatorFlowFallback();
			yield break;
		}
		actor.EnableMovment();
		obj.PlayOpenAnim();
		yield return new WaitForSeconds(1f);
		SetElevatorDoorNaviCut(obj, blocked: false);
		yield return ElevatorMoveInOrOut(actor, startTr);
		NotifyElevatorActorWalkedOut();
		obj.PlayCloseAnim();
		yield return new WaitForSeconds(1f);
		SetElevatorDoorNaviCut(obj, blocked: true);
		ReleaseElevatorOccupy();
		actor.InterWithObjeComplete();
		IsElevatorFlowActive = false;
		_elevatorCoroutine = null;
	}

	public void OnElevatorRoomChoice(bool choseRoom)
	{
		if (_elevatorWaitingRoomChoice)
		{
			_elevatorWaitingRoomChoice = false;
			StartElevatorCoroutine(choseRoom ? ElevatorChooseRoomFlow() : ElevatorCancelFlow());
		}
	}

	private void StartElevatorCoroutine(IEnumerator routine)
	{
		DormPlayerController instance = MonoSingleton<DormPlayerController>.Instance;
		if (!(null == instance))
		{
			if (_elevatorCoroutine != null)
			{
				instance.StopCoroutine(_elevatorCoroutine);
			}
			_elevatorCoroutine = instance.StartCoroutine(routine);
		}
	}

	private IEnumerator ElevatorMoveStep(DormActor actor, Transform targetTr, Action onStuck = null)
	{
		if (!(null == actor) && !(null == targetTr))
		{
			Vector3 targetPos = targetTr.position;
			float targetYaw = targetTr.eulerAngles.y;
			bool arrived = false;
			actor.MoveTo(targetPos, () =>
			{
				arrived = true;
			}, onStuck);
			float elapsed = 0f;
			while (!arrived && elapsed < 3f)
			{
				yield return null;
				elapsed += Time.deltaTime;
			}
			if (!arrived)
			{
				actor.StopMove();
				actor.SyncMovementLocation(new TSVector2(targetPos.x, targetPos.z), 0);
				actor.SyncRotation(targetYaw);
			}
		}
	}

	private IEnumerator ElevatorMoveInOrOut(DormActor actor, Transform targetTr)
	{
		yield return ElevatorGlideStep(actor, targetTr);
	}

	private IEnumerator ElevatorGlideStep(DormActor actor, Transform targetTr)
	{
		if (!(null == actor) && !(null == targetTr))
		{
			Vector3 targetPos = targetTr.position;
			actor.StopMove();
			actor.DisableMovment();
			actor.SetAvoidanceSimulationEnabled(enable: false);
			actor.PlayWalk();
			Transform tr = actor.transform;
			Vector3 dest = new Vector3(targetPos.x, tr.position.y, targetPos.z);
			Vector3 forward = dest - tr.position;
			forward.y = 0f;
			float targetYaw = ((forward.sqrMagnitude > 0.0001f) ? Quaternion.LookRotation(forward).eulerAngles.y : tr.eulerAngles.y);
			Quaternion targetRot = Quaternion.Euler(0f, targetYaw, 0f);
			float speed = Mathf.Max(1.2f, 0.01f);
			float budget = Vector3.Distance(tr.position, dest) / speed * 2f + 1f;
			float elapsed = 0f;
			while (elapsed < budget && (tr.position - dest).sqrMagnitude > 0.0001f)
			{
				tr.position = Vector3.MoveTowards(tr.position, dest, speed * Time.deltaTime);
				tr.rotation = Quaternion.RotateTowards(tr.rotation, targetRot, 360f * Time.deltaTime);
				elapsed += Time.deltaTime;
				yield return null;
			}
			actor.SyncMovementLocation(new TSVector2(targetPos.x, targetPos.z), 0);
			actor.SyncRotation(targetYaw);
			actor.EnableMovment();
			actor.SetAvoidanceSimulationEnabled(enable: true);
			actor.PlayIdle();
		}
	}

	private IEnumerator ElevatorEnterFlow(bool placeAtStartImmediately)
	{
		DormActor actor = _pendingElevatorActor;
		DormFurObj obj = _pendingElevatorObj;
		DormFurObjInteractivePoint pendingElevatorPoint = _pendingElevatorPoint;
		Transform target_by_anim_start = pendingElevatorPoint.target_by_anim_start;
		Transform endTr = pendingElevatorPoint.target_by_anim_end;
		if (null == actor || null == obj || null == target_by_anim_start || null == endTr)
		{
			EndElevatorFlowFallback();
			yield break;
		}
		actor.EnableMovment();
		if (placeAtStartImmediately)
		{
			actor.SyncMovementLocation(new TSVector2(target_by_anim_start.position.x, target_by_anim_start.position.z), 0);
			actor.SyncRotation(target_by_anim_start.eulerAngles.y);
		}
		else
		{
			Vector3 startPos = target_by_anim_start.position;
			yield return ElevatorMoveStep(actor, target_by_anim_start, () =>
			{
				ClearActorsNearInteractStart(actor, startPos, 1.5f);
			});
		}
		obj.PlayOpenAnim();
		yield return new WaitForSeconds(1f);
		SetElevatorDoorNaviCut(obj, blocked: false);
		yield return ElevatorMoveInOrOut(actor, endTr);
		_elevatorWaitingRoomChoice = true;
		MonoSingleton<LuaManager>.Instance.FireEvent("DORM_CS2LUA_SHOW_SELECT_ROME_UI", 1);
		_elevatorCoroutine = null;
	}

	private IEnumerator ElevatorChooseRoomFlow()
	{
		DormFurObj pendingElevatorObj = _pendingElevatorObj;
		if (null != pendingElevatorObj)
		{
			pendingElevatorObj.PlayCloseAnim();
		}
		yield return new WaitForSeconds(1f);
		_elevatorExitPending = true;
		MonoSingleton<LuaManager>.Instance.FireEvent("DORM_CS2LUA_SWITCH_NEW_ROOM");
		ReleaseElevatorOccupy();
		_elevatorCoroutine = null;
	}

	private IEnumerator ElevatorCancelFlow()
	{
		DormActor actor = _pendingElevatorActor;
		DormFurObj obj = _pendingElevatorObj;
		Transform transform = _pendingElevatorPoint?.target_by_anim_start;
		if (null == actor || null == obj || null == transform)
		{
			EndElevatorFlowFallback();
			yield break;
		}
		actor.EnableMovment();
		yield return ElevatorMoveInOrOut(actor, transform);
		NotifyElevatorActorWalkedOut();
		obj.PlayCloseAnim();
		yield return new WaitForSeconds(1f);
		SetElevatorDoorNaviCut(obj, blocked: true);
		ReleaseElevatorOccupy();
		actor.InterWithObjeComplete();
		IsElevatorFlowActive = false;
		_elevatorCoroutine = null;
	}

	private void ReleaseElevatorOccupy()
	{
		if (_pendingElevatorPoint != null)
		{
			_pendingElevatorPoint.bindEntityID = 0L;
		}
		if (null != _pendingElevatorActor)
		{
			if (enInteractiveObjDic != null)
			{
				enInteractiveObjDic.Remove(_pendingElevatorActor.id);
			}
			_pendingElevatorActor.BeginFurnitureInteractCooldown();
		}
		ClearElevatorContext();
	}

	private void NotifyElevatorActorWalkedOut()
	{
		if (_elevatorFlowNotified)
		{
			_elevatorFlowNotified = false;
			MonoSingleton<LuaManager>.Instance.FireEvent("DORM_CS2LUA_SHOW_SELECT_ROME_UI", 2);
		}
	}

	private void EndElevatorFlowFallback()
	{
		DormActor pendingElevatorActor = _pendingElevatorActor;
		NotifyElevatorActorWalkedOut();
		ReleaseElevatorOccupy();
		if (null != pendingElevatorActor)
		{
			pendingElevatorActor.InterWithObjeComplete();
		}
		IsElevatorFlowActive = false;
		_elevatorCoroutine = null;
	}

	private void ClearElevatorContext()
	{
		_pendingElevatorActor = null;
		_pendingElevatorObj = null;
		_pendingElevatorPoint = null;
		_elevatorWaitingRoomChoice = false;
	}

	private void InitEventListener()
	{
		EventDispatchManager instance = Singleton<EventDispatchManager>.Instance;
		if (instance != null)
		{
			instance.AddEventListener("DormJoystickPrefabLoadComplete", DormJoystickPrefabLoadComplete);
			instance.AddEventListener("DormSwicthMode", DormSwicthMode);
			instance.AddEventListener("DORM_LUA_CREATE_FURNITURE", EventFromLua_CreateFurniture);
			instance.AddEventListener("DORM_LUA_UNSELECT_FURNITURE", EventFromLua_UnselectFurniture);
			instance.AddEventListener("DORM_LUA_ROTATE_FURNITURE", EventFromLua_RotateFurniture);
			instance.AddEventListener("DORM_LUA_CANCEL_FURNITURE", EventFromLua_CancelFurniture);
			instance.AddEventListener("DORM_LUA_DELETE_FURNITURE", EventFromLua_DeleteFurniture);
			instance.AddEventListener("DORM_LUA_SAVE_ROOM", EventFromLua_SaveRoom);
			instance.AddEventListener("DORM_LUA_SAVE_ROOM_SUCC", EventFromLua_SaveRoomSucc);
			instance.AddEventListener("DORM_LUA_ABANDON_SAVE_ROOM", EventFromLua_AbandonSaveRoom);
			instance.AddEventListener("DORM_LUA_CLEAR_ROOM", EventFromLua_ClearRoom);
			instance.AddEventListener("DORM_LUA_APPLY_PRESET", EventFromLua_ApplyPreset);
			instance.AddEventListener("BUTTON_DORM_INTERACTIVE_HUD", EventFromLua_DormInteractiveBtn);
			instance.AddEventListener("DORM_LUA_HIDE_FLOOR_FUR", EventFromLua_HideFloorFur);
			instance.AddEventListener("DORM_LUA_HIDE_WALL_FUR ", EventFromLua_HideWallFur);
			instance.AddEventListener("DORM_LUA_SELECT_SCENE_CALLBACK", EventFromLua_SwitchRoomCallback);
			instance.AddEventListener("DORM_LUA_SWITCH_ACTOR_CALLBACK", EventFromLua_SwitchActorCallback);
			instance.AddEventListener("DORM_LUA_SELECT_ACTOR_CALLBACK", EventFromLua_SelectInterActorCallback);
			instance.AddEventListener("DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK", EventFromLua_InterWithActorCallback);
			instance.AddEventListener("DORM_LUA_REFRESH_SCENE", EventFromLua_RefreshScene);
			instance.AddEventListener("DORM_LUA_SET_UI_HIDDEN", EventFromLua_SetUIHidden);
		}
	}

	private void ClearEventListener()
	{
		EventDispatchManager instance = Singleton<EventDispatchManager>.Instance;
		if (instance != null)
		{
			instance.RemoveEventListener("DormJoystickPrefabLoadComplete", DormJoystickPrefabLoadComplete);
			instance.RemoveEventListener("DormSwicthMode", DormSwicthMode);
			instance.RemoveEventListener("DORM_LUA_CREATE_FURNITURE", EventFromLua_CreateFurniture);
			instance.RemoveEventListener("DORM_LUA_UNSELECT_FURNITURE", EventFromLua_UnselectFurniture);
			instance.RemoveEventListener("DORM_LUA_ROTATE_FURNITURE", EventFromLua_RotateFurniture);
			instance.RemoveEventListener("DORM_LUA_CANCEL_FURNITURE", EventFromLua_CancelFurniture);
			instance.RemoveEventListener("DORM_LUA_DELETE_FURNITURE", EventFromLua_DeleteFurniture);
			instance.RemoveEventListener("DORM_LUA_SAVE_ROOM", EventFromLua_SaveRoom);
			instance.RemoveEventListener("DORM_LUA_SAVE_ROOM_SUCC", EventFromLua_SaveRoomSucc);
			instance.RemoveEventListener("DORM_LUA_ABANDON_SAVE_ROOM", EventFromLua_AbandonSaveRoom);
			instance.RemoveEventListener("DORM_LUA_CLEAR_ROOM", EventFromLua_ClearRoom);
			instance.RemoveEventListener("DORM_LUA_APPLY_PRESET", EventFromLua_ApplyPreset);
			instance.RemoveEventListener("BUTTON_DORM_INTERACTIVE_HUD", EventFromLua_DormInteractiveBtn);
			instance.RemoveEventListener("DORM_LUA_HIDE_FLOOR_FUR", EventFromLua_HideFloorFur);
			instance.RemoveEventListener("DORM_LUA_HIDE_WALL_FUR ", EventFromLua_HideWallFur);
			instance.RemoveEventListener("DORM_LUA_SELECT_SCENE_CALLBACK", EventFromLua_SwitchRoomCallback);
			instance.RemoveEventListener("DORM_LUA_SWITCH_ACTOR_CALLBACK", EventFromLua_SwitchActorCallback);
			instance.RemoveEventListener("DORM_LUA_SELECT_ACTOR_CALLBACK", EventFromLua_SelectInterActorCallback);
			instance.RemoveEventListener("DORM_LUA_INTERACTIVE_WITH_ACTOR_CALLBACK", EventFromLua_InterWithActorCallback);
			instance.RemoveEventListener("DORM_LUA_REFRESH_SCENE", EventFromLua_RefreshScene);
			instance.RemoveEventListener("DORM_LUA_SET_UI_HIDDEN", EventFromLua_SetUIHidden);
		}
	}

	private void DormJoystickPrefabLoadComplete(IEvent ievent)
	{
		Debug.LogError("joy stick load complete");
		MonoSingleton<DormPlayerController>.Instance.InitInputControl();
	}

	private void DormSwicthMode(IEvent ievent)
	{
		if (ievent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
			{
				DormActor.DormMode dormMode = (DormActor.DormMode)intValue;
				SwitchDormMode(dormMode);
			}
		}
	}

	private void EventFromLua_SetUIHidden(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data })
		{
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(data.get_Item((object)1).ToString(), out intValue))
			{
				SetBlockedInputCaps((DormInputCap)intValue);
			}
		}
	}

	private void EventFromLua_DormInteractiveBtn(IEvent ievent)
	{
		if (!(ievent is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable luaTable = generalEvent.data as LuaTable;
		if (!CommonHelper.TryParseStringParamToInt(luaTable.get_Item((object)1).ToString(), out var intValue) || !CommonHelper.TryParseStringParamToInt(luaTable.get_Item((object)2).ToString(), out var intValue2))
		{
			return;
		}
		if (intValue2 == 1)
		{
			if (!(null == objCurRoom))
			{
				DormFurObj furObjByEntityID = objCurRoom.GetFurObjByEntityID(intValue);
				DormPlayer player = MonoSingleton<DormPlayerController>.Instance.Player;
				if (null != furObjByEntityID && null != player && furObjByEntityID.CanInteractBy(player))
				{
					ActorDoInteractiveWithFurObj(player, furObjByEntityID);
				}
			}
		}
		else
		{
			DormActor actorByEntityID = GetActorByEntityID(intValue);
			if (!(null == actorByEntityID))
			{
				ActorStopInteractiveWithFurObj(actorByEntityID);
				actorByEntityID.PlayInteractiveBehaviour();
			}
		}
	}

	private void EventFromLua_SwitchRoomCallback(IEvent evt)
	{
		if (evt is GeneralEvent generalEvent && bool.TryParse((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var result))
		{
			OnElevatorRoomChoice(result);
		}
	}

	private void EventFromLua_SwitchActorCallback(IEvent evt)
	{
		if (!(evt is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable luaTable = generalEvent.data as LuaTable;
		if (!bool.TryParse(luaTable.get_Item((object)1).ToString(), out var result) || !CommonHelper.TryParseStringParamToInt(luaTable.get_Item((object)2).ToString(), out var intValue))
		{
			return;
		}
		if (result)
		{
			if (CommonHelper.TryParseStringParamToInt(luaTable.get_Item((object)3).ToString(), out var intValue2))
			{
				SetNewActorOnStage(intValue, intValue2);
			}
		}
		else
		{
			RemoveActorOnStage(intValue);
		}
	}

	public void CloseInteractiveIconIfShowing()
	{
		if (_interactiveIconShowing)
		{
			_interactiveIconShowing = false;
			MonoSingleton<LuaManager>.Instance.FireEvent("DORM_CS2LUA_CLOSE_INTERACTIVE_ICON");
		}
		else if (null == _interactTargetActor && null == _focusActor)
		{
			return;
		}
		CancelInteractTarget();
	}

	private void CancelInteractTarget()
	{
		if (null != _interactTargetActor)
		{
			_interactTargetActor.ReleaseInteractIconHold();
			_interactTargetActor = null;
		}
		EndActorInteractFocus();
	}

	private void EventFromLua_SelectInterActorCallback(IEvent evt)
	{
		if (!HasInputCap(DormInputCap.PickActor) || !(evt is GeneralEvent generalEvent) || !long.TryParse((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var result))
		{
			return;
		}
		DormActor actorByEntityID = GetActorByEntityID(result);
		if (null == actorByEntityID || actorByEntityID.IsInteractionUninterruptible)
		{
			return;
		}
		DormPlayer player = MonoSingleton<DormPlayerController>.Instance.Player;
		if (enInteractiveObjDic.TryGetValue(actorByEntityID.id, out var value) && null != value)
		{
			ActorStopInteractiveWithFurObj(actorByEntityID);
			if (null == player || !TryPlaceActorNearPosition(actorByEntityID, player.transform.position))
			{
				TryPlaceActorNearFurniture(actorByEntityID, value);
			}
		}
		_interactiveIconShowing = true;
		_interactTargetActor = actorByEntityID;
		actorByEntityID.HoldByInteractIcon();
		if (null != player)
		{
			player.RequestTurnToFace(actorByEntityID.transform.position);
			Vector3 worldPos = CalcInteractFocusPoint(player.transform.position, actorByEntityID.transform.position);
			SceneSingleton<DormCameraController>.Instance.EnterFocus(worldPos, 0.4f, 0.5f, 0.01f, 11f, 2f, ignoreFollowDeadzone: true, lockPoseFromEntry: false, smoothEase: true, -0.1f);
			SceneSingleton<DormCameraController>.Instance.UpdateFocusSideView(enable: true, player.transform.position, actorByEntityID.transform.position, 58f);
			BeginActorInteractFocus(actorByEntityID);
		}
	}

	public void SelectActorInViewMode(DormActor actor, bool notifyLua = true)
	{
		if (!(null == actor) && !actor.IsLogicStopped && !actor.IsInteractionUninterruptible)
		{
			if (enInteractiveObjDic.TryGetValue(actor.id, out var value) && null != value)
			{
				ActorStopInteractiveWithFurObj(actor);
				TryPlaceActorNearFurniture(actor, value);
			}
			if (null != _interactTargetActor && _interactTargetActor != actor)
			{
				_interactTargetActor.ReleaseInteractIconHold();
			}
			_interactiveIconShowing = true;
			_interactTargetActor = actor;
			actor.HoldByInteractIconFaceCamera();
			SceneSingleton<DormCameraController>.Instance.EnterFocus(actor.transform.position, 0.75f, 0.5f, 0.01f, -1f, 2f, ignoreFollowDeadzone: true, lockPoseFromEntry: true, smoothEase: true, 0.8f, 10f, keepPointOnExit: true, singleBlend: true);
			BeginActorInteractFocus(actor, focusActorOnly: true);
			if (notifyLua)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("DORM_CS2LUA_ENTER_CHAR_ACTIVE", actor.transform, 0, actor.RoleId, actor.id);
			}
		}
	}

	private void EventFromLua_InterWithActorCallback(IEvent evt)
	{
		if (!(evt is GeneralEvent generalEvent) || !long.TryParse((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var result))
		{
			return;
		}
		if (result == 0L)
		{
			_interactiveIconShowing = false;
			CancelInteractTarget();
			return;
		}
		DormActor actorByEntityID = GetActorByEntityID(result);
		if (!(null == actorByEntityID))
		{
			actorByEntityID.StopTimelineAnimation();
			actorByEntityID.PlayBubbleEmoji("Assets/AssetBundles/FX/Dorm/Emoji/Bubble/fx_dorm_bubble_shy_1.prefab");
			actorByEntityID.PlayEmojiFX("Assets/AssetBundles/FX/Dorm/Emoji/Effect/fx_dorm_effect_love.prefab");
			actorByEntityID.PlayFacialExpression(SDFacialExpression.Shy, 2f, 0.01f);
		}
	}

	public bool TrySwitchSelectedActorInViewMode(DormActor actor)
	{
		if (dormMode != DormActor.DormMode.View)
		{
			return false;
		}
		if (!HasInputCap(DormInputCap.PickActor))
		{
			return false;
		}
		if (_pointerDraggedSincePressDown)
		{
			return false;
		}
		if (null == actor)
		{
			return false;
		}
		if (actor == _interactTargetActor)
		{
			return true;
		}
		if (actor.IsLogicStopped || actor.IsInteractionUninterruptible)
		{
			return false;
		}
		SelectActorInViewMode(actor, notifyLua: false);
		return _interactTargetActor == actor;
	}

	private void EventFromLua_RefreshScene(IEvent evt)
	{
		RefreshScene();
	}

	private bool HasInputCap(DormInputCap cap)
	{
		return (_blockedInputCaps & cap) == 0;
	}

	private void SetBlockedInputCaps(DormInputCap blocked)
	{
		if (_blockedInputCaps == blocked)
		{
			return;
		}
		DormInputCap dormInputCap = blocked & ~_blockedInputCaps;
		_blockedInputCaps = blocked;
		if (dormInputCap == DormInputCap.None)
		{
			return;
		}
		if ((dormInputCap & DormInputCap.PickActor) != 0)
		{
			CloseInteractiveIconIfShowing();
		}
		if ((dormInputCap & DormInputCap.PlayerMove) != 0)
		{
			playerController?.OnMovementInput(movmentHasInput: false, Vector2.zero);
		}
		if (null != cameraController)
		{
			if ((dormInputCap & DormInputCap.CameraPan) != 0)
			{
				cameraController.UpdateCameraShiftValue(camerShiftHasInput: false, Vector2.zero);
			}
			if ((dormInputCap & DormInputCap.CameraRotate) != 0)
			{
				cameraController.UpdateCameraRotateByDrag(hasInput: false, Vector2.zero, 0f);
			}
		}
		if ((dormInputCap & (DormInputCap.PickActor | DormInputCap.PickFurObj)) != 0)
		{
			EndPointerDragInProgress();
		}
	}

	private void EndPointerDragInProgress()
	{
		pendingDragActor = null;
		if (dragState == DormDragState.DraggingRole && null != dragActor)
		{
			if (null != draggingFromFurObj)
			{
				ActorResumeInteractiveWithFurObj(dragActor, draggingFromFurObj);
			}
			else if (!TryPlaceActorAtPosition(dragActor, draggingFromPos))
			{
				dragActor.OnStopDrag();
			}
			dragActor.DeactiveHighlightDisplay();
			draggingFromFurObj = null;
			dragActor = null;
		}
		if (null != hoverFurniture)
		{
			hoverFurniture.SetAllInteractivePointVisible(bVisible: false);
			hoverFurniture = null;
		}
		dragState = DormDragState.None;
	}

	private void InitInputControl()
	{
		if (null != playerController)
		{
			DormPlayerController dormPlayerController = playerController;
			dormPlayerController.onMove = (Action<Vector2>)Delegate.Combine(dormPlayerController.onMove, new Action<Vector2>(OnMove));
			DormPlayerController dormPlayerController2 = playerController;
			dormPlayerController2.onPressDown = (Action<Vector2>)Delegate.Combine(dormPlayerController2.onPressDown, new Action<Vector2>(OnPressDown));
			DormPlayerController dormPlayerController3 = playerController;
			dormPlayerController3.onPress = (Action<Vector2>)Delegate.Combine(dormPlayerController3.onPress, new Action<Vector2>(OnPress));
			DormPlayerController dormPlayerController4 = playerController;
			dormPlayerController4.onPressUp = (Action<Vector2>)Delegate.Combine(dormPlayerController4.onPressUp, new Action<Vector2>(OnPressUp));
			DormPlayerController dormPlayerController5 = playerController;
			dormPlayerController5.onClick = (Action<Vector2>)Delegate.Combine(dormPlayerController5.onClick, new Action<Vector2>(OnClick));
			DormPlayerController dormPlayerController6 = playerController;
			dormPlayerController6.onInputLogicUpdate = (Action<bool, Vector2>)Delegate.Combine(dormPlayerController6.onInputLogicUpdate, new Action<bool, Vector2>(OnInputLogicUpdate));
			DormPlayerController dormPlayerController7 = playerController;
			dormPlayerController7.onZoomInput = (Action<bool, float>)Delegate.Combine(dormPlayerController7.onZoomInput, new Action<bool, float>(OnZoomInput));
			DormPlayerController dormPlayerController8 = playerController;
			dormPlayerController8.onFinger1Input = (Action<bool, Vector2>)Delegate.Combine(dormPlayerController8.onFinger1Input, new Action<bool, Vector2>(OnFinger1Input));
			playerController.InitInputControl();
		}
	}

	private void ClearInputControl()
	{
		if (null != playerController)
		{
			DormPlayerController dormPlayerController = playerController;
			dormPlayerController.onMove = (Action<Vector2>)Delegate.Remove(dormPlayerController.onMove, new Action<Vector2>(OnMove));
			DormPlayerController dormPlayerController2 = playerController;
			dormPlayerController2.onPressDown = (Action<Vector2>)Delegate.Remove(dormPlayerController2.onPressDown, new Action<Vector2>(OnPressDown));
			DormPlayerController dormPlayerController3 = playerController;
			dormPlayerController3.onPress = (Action<Vector2>)Delegate.Remove(dormPlayerController3.onPress, new Action<Vector2>(OnPress));
			DormPlayerController dormPlayerController4 = playerController;
			dormPlayerController4.onPressUp = (Action<Vector2>)Delegate.Remove(dormPlayerController4.onPressUp, new Action<Vector2>(OnPressUp));
			DormPlayerController dormPlayerController5 = playerController;
			dormPlayerController5.onClick = (Action<Vector2>)Delegate.Remove(dormPlayerController5.onClick, new Action<Vector2>(OnClick));
			DormPlayerController dormPlayerController6 = playerController;
			dormPlayerController6.onInputLogicUpdate = (Action<bool, Vector2>)Delegate.Remove(dormPlayerController6.onInputLogicUpdate, new Action<bool, Vector2>(OnInputLogicUpdate));
			DormPlayerController dormPlayerController7 = playerController;
			dormPlayerController7.onZoomInput = (Action<bool, float>)Delegate.Remove(dormPlayerController7.onZoomInput, new Action<bool, float>(OnZoomInput));
			DormPlayerController dormPlayerController8 = playerController;
			dormPlayerController8.onFinger1Input = (Action<bool, Vector2>)Delegate.Remove(dormPlayerController8.onFinger1Input, new Action<bool, Vector2>(OnFinger1Input));
		}
		pendingDragActor = null;
		dragActor = null;
		draggingFromFurObj = null;
		hoverFurniture = null;
		dragState = DormDragState.None;
	}

	private void OnZoomInput(bool zoomHasInput, float zoomInput)
	{
		if (!(null == cameraController) && HasInputCap(DormInputCap.CameraZoom))
		{
			DormDragState dormDragState = dragState;
			if (dormDragState != DormDragState.DraggingRole && dormDragState != DormDragState.DraggingFurObj && dormMode == DormActor.DormMode.View)
			{
				SceneSingleton<DormCameraController>.Instance.UpdateCameraDepthByPinch(zoomHasInput, zoomInput);
			}
		}
	}

	private void OnFinger1Input(bool finger1HasInput, Vector2 finger1InputDirection)
	{
		DormDragState dormDragState = dragState;
		if (dormDragState == DormDragState.DraggingRole || dormDragState == DormDragState.DraggingFurObj || null == cameraController)
		{
			return;
		}
		switch (dormMode)
		{
		case DormActor.DormMode.Default:
		case DormActor.DormMode.Visitor:
			if (HasInputCap(DormInputCap.CameraRotate))
			{
				dragState = DormDragState.DraggingCamera;
				SceneSingleton<DormCameraController>.Instance.UpdateCameraRotateByDrag(finger1HasInput, finger1InputDirection, 0f);
			}
			break;
		case DormActor.DormMode.View:
		case DormActor.DormMode.Edit:
			if (HasInputCap(DormInputCap.CameraPan) && !(pendingDragActor != null))
			{
				dragState = DormDragState.DraggingCamera;
				SceneSingleton<DormCameraController>.Instance.UpdateCameraShiftValue(finger1HasInput, finger1InputDirection);
			}
			break;
		}
	}

	private void OnInputLogicUpdate(bool movmentHasInput, Vector2 movmentInputDirection)
	{
		switch (dormMode)
		{
		case DormActor.DormMode.Default:
		case DormActor.DormMode.Visitor:
			if (HasInputCap(DormInputCap.PlayerMove))
			{
				if (movmentHasInput)
				{
					CloseInteractiveIconIfShowing();
				}
				bool bWalk = movmentHasInput && IsInteractableInMoveCone(movmentInputDirection);
				playerController.OnMovementInput(movmentHasInput, movmentInputDirection, bWalk);
			}
			break;
		case DormActor.DormMode.View:
		case DormActor.DormMode.Edit:
			break;
		}
	}

	private void OnPressDown(Vector2 screenPosition)
	{
		_lastPressDownScreenPos = screenPosition;
		_pointerDraggedSincePressDown = false;
		if (EventSystem.current.IsPointerOverGameObject())
		{
			return;
		}
		objFur_RaycastHit = null;
		ray = CAM.ScreenPointToRay(screenPosition);
		switch (dormMode)
		{
		case DormActor.DormMode.Default:
			if (HasInputCap(DormInputCap.PickActor))
			{
				CloseInteractiveIconIfShowing();
			}
			break;
		case DormActor.DormMode.View:
			if (HasInputCap(DormInputCap.PickActor))
			{
				CloseInteractiveIconIfShowing();
				if (Physics.Raycast(ray, out hit, 100f, 1 << DormConstValue.LAYER_ACTOR) && hit.collider.TryGetComponent<DormActor>(out var component))
				{
					pendingDragActor = component;
					pendingDragStartScreenPos = screenPosition;
					pendingDragStartTime = Time.unscaledTime;
				}
			}
			break;
		case DormActor.DormMode.Edit:
			if (HasInputCap(DormInputCap.PickFurObj))
			{
				if (Physics.Raycast(ray, out hit, 100f, 1 << DormConstValue.LAYER_FURNITURE) && DormUtil.TryGetFurObjByCollider(hit.collider, out var _))
				{
					dragState = DormDragState.DraggingFurObj;
				}
				OnInputDown_SwitchTargetFurObj(screenPosition);
			}
			break;
		}
	}

	private void OnMove(Vector2 screenPosition)
	{
	}

	public bool TryPickActorAtLastPressDown(out DormActor actor)
	{
		actor = null;
		if (null == CAM)
		{
			return false;
		}
		if (!Physics.Raycast(CAM.ScreenPointToRay(_lastPressDownScreenPos), out var hitInfo, 100f, 1 << DormConstValue.LAYER_ACTOR))
		{
			return false;
		}
		return hitInfo.collider.TryGetComponent<DormActor>(out actor);
	}

	private void OnPress(Vector2 screenPosition)
	{
		if (!_pointerDraggedSincePressDown && (screenPosition - _lastPressDownScreenPos).sqrMagnitude >= 400f)
		{
			_pointerDraggedSincePressDown = true;
		}
		ray = CAM.ScreenPointToRay(screenPosition);
		switch (dormMode)
		{
		case DormActor.DormMode.View:
		{
			if (!HasInputCap(DormInputCap.PickActor))
			{
				break;
			}
			if (null != playerController && playerController.IsMultiTouch)
			{
				pendingDragActor = null;
				break;
			}
			if (dragState != DormDragState.DraggingRole && pendingDragActor != null)
			{
				if (pendingDragActor.IsInteractionUninterruptible)
				{
					pendingDragActor = null;
					break;
				}
				bool flag = (screenPosition - pendingDragStartScreenPos).sqrMagnitude >= 400f;
				bool flag2 = Time.unscaledTime - pendingDragStartTime >= 0.3f;
				if (!(flag | flag2))
				{
					break;
				}
				dragActor = pendingDragActor;
				dragState = DormDragState.DraggingRole;
				draggingFromFurObj = (enInteractiveObjDic.TryGetValue(dragActor.id, out var value) ? value : null);
				draggingFromPos = dragActor.transform.position;
				dragActor.OnStartDrag();
				pendingDragActor = null;
			}
			if (dragState != DormDragState.DraggingRole || null == dragActor)
			{
				break;
			}
			if (TryGetDragFollowPoint(ray, out var result))
			{
				dragActor.OnDrag(new TSVector2(result.x, result.z), result.y + 0.2f);
			}
			UpdateDragEdgeScroll(screenPosition);
			if (objCurRoom != null && objCurRoom.TryGetFloorFurnitureByWorldPos(dragActor.transform.position, out var furObj) && furObj.CalcFloorCapacity && furObj.CanInteractBy(dragActor))
			{
				if (hoverFurniture != furObj)
				{
					if (hoverFurniture != null)
					{
						hoverFurniture.SetAllInteractivePointVisible(bVisible: false);
					}
					hoverFurniture = furObj;
				}
				furObj.GetInteractivePoint(dragActor.transform);
			}
			else if (hoverFurniture != null)
			{
				hoverFurniture.SetAllInteractivePointVisible(bVisible: false);
				hoverFurniture = null;
			}
			break;
		}
		case DormActor.DormMode.Edit:
			if (HasInputCap(DormInputCap.PickFurObj))
			{
				OnInputPress_DragTargetFurObj(screenPosition);
			}
			break;
		case DormActor.DormMode.Default:
			break;
		}
	}

	private void OnPressUp(Vector2 screenPosition)
	{
		ray = CAM.ScreenPointToRay(screenPosition);
		switch (dormMode)
		{
		case DormActor.DormMode.View:
		{
			if (!HasInputCap(DormInputCap.PickActor))
			{
				break;
			}
			if (dragState != DormDragState.DraggingRole)
			{
				if (pendingDragActor != null)
				{
					SelectActorInViewMode(pendingDragActor);
					pendingDragActor = null;
				}
				break;
			}
			if (null == dragActor)
			{
				return;
			}
			bool flag = false;
			if (objCurRoom != null && objCurRoom.TryGetFloorFurnitureByWorldPos(dragActor.transform.position, out var furObj) && furObj != null && furObj.CalcFloorCapacity && furObj.CanInteractBy(dragActor))
			{
				if (furObj == draggingFromFurObj)
				{
					ActorResumeInteractiveWithFurObj(dragActor, furObj);
				}
				else if (furObj.IsElevator)
				{
					ActorStopInteractiveWithFurObj(dragActor);
					ActorDoInteractiveWithFurObj(dragActor, furObj, placeAtStartImmediately: true);
				}
				else
				{
					ActorStopInteractiveWithFurObj(dragActor);
					ActorDoInteractiveWithFurObjOrFallback(dragActor, furObj, draggingFromPos);
				}
				flag = true;
			}
			if (!flag)
			{
				ActorStopInteractiveWithFurObj(dragActor);
				Vector3 position = dragActor.transform.position;
				if ((!(objCurRoom != null) || !objCurRoom.TryGetFloorFurnitureByWorldPos(position, out var furObj2) || !(furObj2 != null) || !furObj2.IsElevator || !TryPlaceActorAtPosition(dragActor, draggingFromPos)) && (!IsCellOccupiedByOtherActor(position, dragActor, 0.7f) || (!TryPlaceActorNearPosition(dragActor, position, 2, 0, 0.7f) && !TryPlaceActorAtPosition(dragActor, draggingFromPos))))
				{
					bool flag2 = !dragActor.CheckPositionWalkable(new Vector3(position.x, 0f, position.z));
					dragActor.OnStopDrag();
					if (flag2)
					{
						dragActor.RelocateOntoNavmesh();
					}
				}
			}
			dragActor.DeactiveHighlightDisplay();
			cameraController?.UpdateCameraShiftValue(camerShiftHasInput: false, Vector2.zero);
			draggingFromFurObj = null;
			break;
		}
		case DormActor.DormMode.Edit:
			if (HasInputCap(DormInputCap.PickFurObj))
			{
				OnInputPressUp_EndDragTargetFurObj(screenPosition);
			}
			break;
		}
		dragState = DormDragState.None;
	}

	private void OnClick(Vector2 screenPosition)
	{
	}

	private bool TryGetDragFollowPoint(Ray ray, out Vector3 result)
	{
		result = default;
		if (null == dragActor)
		{
			return false;
		}
		if (Mathf.Abs(ray.direction.y) < 0.0001f)
		{
			return false;
		}
		float num = (0f - ray.origin.y) / ray.direction.y;
		if (num <= 0f)
		{
			return false;
		}
		Vector3 vector = ray.origin + ray.direction * num;
		if (objCurRoom != null && objCurRoom.IsWorldPosInFloorRange(vector))
		{
			result = vector;
			return true;
		}
		return dragActor.TryGetNearestWalkablePoint(vector, out result);
	}

	private void UpdateDragEdgeScroll(Vector2 screenPosition)
	{
		if (null == cameraController)
		{
			return;
		}
		float num = 0.1f;
		if (num <= 0f)
		{
			return;
		}
		num = Mathf.Clamp(num, 0f, 0.5f);
		float num2 = Screen.width;
		float num3 = Screen.height;
		if (!(num2 <= 0f) && !(num3 <= 0f))
		{
			float num4 = num2 * num;
			float num5 = num3 * num;
			float num6 = 0f;
			if (screenPosition.x < num4)
			{
				num6 = (0f - (num4 - screenPosition.x)) / num4;
			}
			else if (screenPosition.x > num2 - num4)
			{
				num6 = (screenPosition.x - (num2 - num4)) / num4;
			}
			float num7 = 0f;
			if (screenPosition.y < num5)
			{
				num7 = (0f - (num5 - screenPosition.y)) / num5;
			}
			else if (screenPosition.y > num3 - num5)
			{
				num7 = (screenPosition.y - (num3 - num5)) / num5;
			}
			if (num6 == 0f && num7 == 0f)
			{
				cameraController.UpdateCameraShiftValue(camerShiftHasInput: false, Vector2.zero);
				return;
			}
			Vector2 cameraShiftValue = -new Vector2(num6, num7) * 500f * Time.deltaTime;
			cameraController.UpdateCameraShiftValue(camerShiftHasInput: true, cameraShiftValue);
		}
	}

	private void OnPlayerInteractiveRangeObjEnter(long entityID)
	{
		playerEnterRngObjs.Add(entityID);
		NovaLogger.Debug($"[Dorm] 交互物进入魔王范围 insID={entityID}, 当前范围内数量={playerEnterRngObjs.Count}");
	}

	private void OnPlayerInteractiveRangeObjExit(long entityID)
	{
		playerEnterRngObjs.Remove(entityID);
		NovaLogger.Debug($"[Dorm] 交互物离开魔王范围 insID={entityID}, 当前范围内数量={playerEnterRngObjs.Count}");
	}

	private bool IsInteractableInMoveCone(Vector2 moveDir)
	{
		bool flag = CalcInteractableInMoveCone(moveDir, out var hitEntityID);
		if (flag != _lastInMoveCone)
		{
			_lastInMoveCone = flag;
			NovaLogger.Debug(string.Format("[Dorm] 魔王前进锥形检测变化 -> {0}, 半角={1}°, 范围内数量={2}", flag ? $"命中交互物(Walk) insID={hitEntityID}" : "无(Run)", DormConfigs.moveSlowConeHalfAngle, playerEnterRngObjs?.Count ?? 0));
		}
		return flag;
	}

	private bool CalcInteractableInMoveCone(Vector2 moveDir, out long hitEntityID)
	{
		hitEntityID = 0L;
		if (playerEnterRngObjs == null || playerEnterRngObjs.Count <= 0)
		{
			return false;
		}
		if (moveDir.sqrMagnitude < 1E-06f)
		{
			return false;
		}
		moveDir.Normalize();
		DormPlayer player = playerController.Player;
		if (null == player)
		{
			return false;
		}
		Vector3 position = player.transform.position;
		float moveSlowConeHalfAngle = DormConfigs.moveSlowConeHalfAngle;
		for (int i = 0; i < playerEnterRngObjs.Count; i++)
		{
			long num = playerEnterRngObjs.get_Item(i);
			if (!TryGetMoveSlowTargetPosition(num, out var position2))
			{
				continue;
			}
			Vector2 to = new Vector2(position2.x - position.x, position2.z - position.z);
			if (!(to.sqrMagnitude < 1E-06f))
			{
				to.Normalize();
				if (Vector2.Angle(moveDir, to) <= moveSlowConeHalfAngle)
				{
					hitEntityID = num;
					return true;
				}
			}
		}
		return false;
	}

	private bool TryGetMoveSlowTargetPosition(long entityID, out Vector3 position)
	{
		position = Vector3.zero;
		DormActor actorByEntityID = GetActorByEntityID(entityID);
		if (null != actorByEntityID)
		{
			position = actorByEntityID.transform.position;
			return true;
		}
		if (null == objCurRoom)
		{
			return false;
		}
		DormFurObj furObjByEntityID = objCurRoom.GetFurObjByEntityID(entityID);
		if (null == furObjByEntityID)
		{
			return false;
		}
		if (furObjByEntityID.IsFlatDecor || !furObjByEntityID.CanDoInteractived)
		{
			return false;
		}
		position = furObjByEntityID.transform.position;
		return true;
	}

	public static Vector3 CalcInteractFocusPoint(Vector3 playerPos, Vector3 actorPos)
	{
		return Vector3.Lerp(playerPos, actorPos, Mathf.Clamp01(0.75f));
	}

	public void BeginActorInteractFocus(DormActor actor, bool focusActorOnly = false)
	{
		_focusActor = actor;
		_focusUseActorOnly = focusActorOnly;
		RefreshPostProcessState();
	}

	public void EndActorInteractFocus()
	{
		_focusActor = null;
		SceneSingleton<DormCameraController>.Instance.ExitFocus();
		RefreshPostProcessState();
	}

	private void UpdateInteractFocus()
	{
		if (null == _focusActor)
		{
			return;
		}
		if (_focusActor.FSMState != DormActor.DormActorState.Noticed)
		{
			EndActorInteractFocus();
			return;
		}
		if (_focusUseActorOnly)
		{
			SceneSingleton<DormCameraController>.Instance.UpdateFocusPoint(_focusActor.transform.position);
			return;
		}
		DormPlayer player = playerController.Player;
		if (null != player)
		{
			Vector3 position = player.transform.position;
			Vector3 position2 = _focusActor.transform.position;
			SceneSingleton<DormCameraController>.Instance.UpdateFocusPoint(CalcInteractFocusPoint(position, position2));
			SceneSingleton<DormCameraController>.Instance.UpdateFocusSideView(enable: true, position, position2, 58f);
		}
	}

	private void UpdateNoticedActor()
	{
		if (null != _noticedActor && _noticedActor.IsNoticedByPlayerBusy)
		{
			if (!IsActorInPlayerRange(_noticedActor))
			{
				NovaLogger.Debug($"[Dorm] 注目-角色离开交互范围, 打断: {_noticedActor.name}(ins={_noticedActor.GetInstanceID()})");
				_noticedActor.CancelNoticeByPlayer();
				_noticedActor = null;
			}
			return;
		}
		DormPlayer player = playerController.Player;
		DormActor dormActor = ((null != player && player.IsMoving) ? FindNearestNoticeableActorInCone() : null);
		if (dormActor != _noticedActor)
		{
			NovaLogger.Debug(string.Format("[Dorm] 魔王注目角色变化: {0} -> {1}, 触发距离={2}m, 半角={3}°", (_noticedActor == null) ? "无" : (_noticedActor.name + $"(ins={_noticedActor.GetInstanceID()})"), (dormActor == null) ? "无" : (dormActor.name + $"(ins={dormActor.GetInstanceID()})"), 2f, DormConfigs.moveSlowConeHalfAngle));
			if (null != _noticedActor)
			{
				_noticedActor.CancelNoticeByPlayer();
			}
			_noticedActor = dormActor;
			if (null != _noticedActor)
			{
				_noticedActor.NoticeByPlayer();
			}
		}
	}

	private bool IsActorInPlayerRange(DormActor actor)
	{
		if (null == actor || playerEnterRngObjs == null)
		{
			return false;
		}
		return playerEnterRngObjs.Contains(actor.id);
	}

	private DormActor FindNearestNoticeableActorInCone()
	{
		if (playerEnterRngObjs == null || playerEnterRngObjs.Count <= 0)
		{
			return null;
		}
		DormPlayer player = playerController.Player;
		if (null == player)
		{
			return null;
		}
		Vector3 forward = player.transform.forward;
		Vector2 vector = new Vector2(forward.x, forward.z);
		if (vector.sqrMagnitude < 1E-06f)
		{
			return null;
		}
		vector.Normalize();
		Vector3 position = player.transform.position;
		float moveSlowConeHalfAngle = DormConfigs.moveSlowConeHalfAngle;
		float num = 2f * 2f;
		DormActor result = null;
		float num2 = float.MaxValue;
		for (int i = 0; i < playerEnterRngObjs.Count; i++)
		{
			DormActor actorByEntityID = GetActorByEntityID(playerEnterRngObjs.get_Item(i));
			if (!(null == actorByEntityID) && (actorByEntityID.CanBeNoticedByPlayer || !(actorByEntityID != _noticedActor)))
			{
				Vector2 vector2 = new Vector2(actorByEntityID.transform.position.x - position.x, actorByEntityID.transform.position.z - position.z);
				float sqrMagnitude = vector2.sqrMagnitude;
				if (!(sqrMagnitude < 1E-06f) && !(sqrMagnitude > num) && !(Vector2.Angle(vector, vector2.normalized) > moveSlowConeHalfAngle) && sqrMagnitude < num2)
				{
					num2 = sqrMagnitude;
					result = actorByEntityID;
				}
			}
		}
		return result;
	}

	private bool ActorStopInteractiveWithFurObj(DormActor actor)
	{
		if (enInteractiveObjDic.TryGetValue(actor.id, out var value))
		{
			if (!value.ReleaseInteractivePoint(actor.id))
			{
				return false;
			}
			value.InterruptInteraction();
			actor.StopInteractiveWithObject();
			enInteractiveObjDic.Remove(actor.id);
			return true;
		}
		return false;
	}

	private void ActorDoInteractiveWithFurObj(DormActor actor, DormFurObj obj, bool placeAtStartImmediately = false, DormFurObjInteractivePoint preferPoint = null)
	{
		if (null == actor || null == obj)
		{
			return;
		}
		DormFurObjInteractivePoint dormFurObjInteractivePoint = ((preferPoint != null && !preferPoint.IsUsing) ? preferPoint : (PickInteractivePointAvoidingActors(actor, obj, actor.id) ?? obj.GetInteractivePoint(actor.transform)));
		if (dormFurObjInteractivePoint == null)
		{
			return;
		}
		if (obj.IsElevator)
		{
			if (!placeAtStartImmediately && dormFurObjInteractivePoint.target_by_anim_start != null)
			{
				ClearActorsNearInteractStart(actor, dormFurObjInteractivePoint.target_by_anim_start.position, 1.5f);
			}
			DormInteractiveContext ctx = new DormInteractiveContext
			{
				furObj = obj,
				point = dormFurObjInteractivePoint,
				placeAtStartImmediately = placeAtStartImmediately
			};
			obj.StartInteraction(actor, ctx, null);
		}
		else
		{
			if (null != dormFurObjInteractivePoint.target_by_anim_start)
			{
				ClearActorsNearInteractStart(actor, dormFurObjInteractivePoint.target_by_anim_start.position, 0.8f);
			}
			Action onComplete = () =>
			{
				obj.ReleaseInteractivePoint(actor.id);
				enInteractiveObjDic.Remove(actor.id);
				actor.BeginFurnitureInteractCooldown();
			};
			DormInteractiveContext ctx2 = new DormInteractiveContext
			{
				furObj = obj,
				point = dormFurObjInteractivePoint,
				placeAtStartImmediately = placeAtStartImmediately
			};
			obj.StartInteraction(actor, ctx2, onComplete);
		}
		if (actor is DormPlayer)
		{
			for (int num = playerEnterRngObjs.Count - 1; num >= 0; num--)
			{
				long num2 = playerEnterRngObjs.get_Item(num);
				MonoSingleton<LuaManager>.Instance.FireEvent("DEACTIVE_DORM_INTERACTIVE_HUD", num2);
				OnPlayerInteractiveRangeObjExit(num2);
			}
		}
		if (enInteractiveObjDic == null)
		{
			enInteractiveObjDic = new Dictionary<long, DormFurObj>();
		}
		if (enInteractiveObjDic.TryAdd(actor.id, obj))
		{
			obj.BindInteractivePoint(dormFurObjInteractivePoint, actor.id);
			obj.SwitchToInteractive();
		}
	}

	private void ClearActorsNearInteractStart(DormActor mover, Vector3 startPos, float radius)
	{
		List<DynamicSimpleEntity> actorEntities = ModuleController<DormModuleController>.Instance.ActorEntities;
		if (actorEntities == null)
		{
			return;
		}
		float num = radius * radius;
		for (int i = 0; i < actorEntities.Count; i++)
		{
			DormActor dormActor = actorEntities.get_Item(i) as DormActor;
			if (!(null == dormActor) && dormActor.id != mover.id)
			{
				Vector3 position = dormActor.transform.position;
				float num2 = position.x - startPos.x;
				float num3 = position.z - startPos.z;
				if (!(num2 * num2 + num3 * num3 > num))
				{
					dormActor.RequestMoveAwayFrom(startPos);
				}
			}
		}
	}

	private void InterruptAllInteractionsToEndForModeSwitch()
	{
		if (enInteractiveObjDic == null || enInteractiveObjDic.Count == 0)
		{
			return;
		}
		List<long> list = new List<long>(enInteractiveObjDic.Keys);
		for (int i = 0; i < list.Count; i++)
		{
			DormActor actorById = GetActorById(list.get_Item(i));
			if (null != actorById)
			{
				InterruptActorInteractionToEnd(actorById);
			}
		}
	}

	private void InterruptActorInteractionToEnd(DormActor actor)
	{
		if (!(null == actor) && enInteractiveObjDic != null && enInteractiveObjDic.TryGetValue(actor.id, out var value) && !(null == value))
		{
			actor.EnableMovment();
			DormFurObjInteractivePoint interactivePointByBindEntity = value.GetInteractivePointByBindEntity(actor.id);
			if (interactivePointByBindEntity != null)
			{
				value.ReleaseInteractivePoint(actor.id);
				value.PlaceActorAtPointEnd(actor, interactivePointByBindEntity);
			}
			enInteractiveObjDic.Remove(actor.id);
			value.InterruptInteraction();
			actor.DiscardInteractiveCompleteCallback();
			actor.LeaveInteractiveToNone();
		}
	}

	public void InterruptPlayerInteractionByInput(DormActor actor)
	{
		InterruptActorInteractionToEnd(actor);
		actor.InterWithObjeComplete();
	}

	private void ActorResumeInteractiveWithFurObj(DormActor actor, DormFurObj obj)
	{
		if (!(null == actor) && !(null == obj))
		{
			Action onComplete = () =>
			{
				obj.ReleaseInteractivePoint(actor.id);
				enInteractiveObjDic.Remove(actor.id);
				actor.BeginFurnitureInteractCooldown();
			};
			if (!obj.ResumeInteraction(actor, onComplete))
			{
				ActorDoInteractiveWithFurObjOrFallback(actor, obj);
			}
			else
			{
				enInteractiveObjDic.set_Item(actor.id, obj);
			}
		}
	}

	private void ActorDoInteractiveWithFurObjOrFallback(DormActor actor, DormFurObj obj, Vector3? fallbackToPos = null)
	{
		if (null == actor || null == obj)
		{
			return;
		}
		if (!obj.CanInteractBy(actor))
		{
			PlaceActorAfterFallbackFailed(actor, obj, fallbackToPos);
			return;
		}
		DormFurObjInteractivePoint interactivePoint = obj.GetInteractivePoint(actor.transform);
		if (interactivePoint != null)
		{
			ActorDoInteractiveWithFurObj(actor, obj);
		}
		else
		{
			PlaceActorAfterFallbackFailed(actor, obj, fallbackToPos);
		}
	}

	private void PlaceActorAfterFallbackFailed(DormActor actor, DormFurObj obj, Vector3? fallbackToPos)
	{
		if (!TryPlaceActorNearFurniture(actor, obj) && (!fallbackToPos.HasValue || !TryPlaceActorAtPosition(actor, fallbackToPos.Value)))
		{
			actor.OnStopDrag();
		}
	}

	private bool TryPlaceActorAtPosition(DormActor actor, Vector3 position)
	{
		if (null == actor)
		{
			return false;
		}
		if (!actor.TryGetNearestWalkablePoint(position, out var result))
		{
			return false;
		}
		actor.SyncMovementLocation(new TSVector2(result.x, result.z), result.y);
		actor.OnStopDrag();
		return true;
	}

	private bool TryPlaceActorNearFurniture(DormActor actor, DormFurObj obj)
	{
		if (null == actor || null == obj || null == objCurRoom)
		{
			return false;
		}
		List<Vector3> aroundCells = DormUtil.GetAroundCells(obj, objCurRoom);
		if (aroundCells == null || aroundCells.Count == 0)
		{
			return false;
		}
		for (int num = aroundCells.Count - 1; num > 0; num--)
		{
			int num2 = UnityEngine.Random.Range(0, num + 1);
			int index = num;
			List<Vector3> list = aroundCells;
			int index2 = num2;
			Vector3 vector = aroundCells.get_Item(num2);
			Vector3 vector2 = aroundCells.get_Item(num);
			Vector3 vector3;
			aroundCells.set_Item(index, vector3 = vector);
			list.set_Item(index2, vector3 = vector2);
		}
		for (int i = 0; i < aroundCells.Count; i++)
		{
			Vector3 vector4 = aroundCells.get_Item(i);
			if (!IsCellOccupiedByOtherActor(vector4, actor, 0.7f) && actor.CheckPositionWalkable(vector4))
			{
				actor.SyncMovementLocation(new TSVector2(vector4.x, vector4.z), vector4.y);
				actor.OnStopDrag();
				return true;
			}
		}
		return false;
	}

	private bool TryPlaceActorNearPosition(DormActor actor, Vector3 targetPos, int maxRing = 2, int minRing = 1, float occupiedRadius = 0.5f)
	{
		if (!TryFindFreeCellNearPosition(actor, targetPos, maxRing, minRing, occupiedRadius, out var result))
		{
			return false;
		}
		actor.SyncMovementLocation(new TSVector2(result.x, result.z), result.y);
		actor.OnStopDrag();
		return true;
	}

	public bool TryGetFreeCellNearActor(DormActor actor, out Vector3 result)
	{
		result = default;
		if (null == actor)
		{
			return false;
		}
		return TryFindFreeCellNearPosition(actor, actor.transform.position, 2, 1, 0.7f, out result);
	}

	private bool TryFindFreeCellNearPosition(DormActor actor, Vector3 targetPos, int maxRing, int minRing, float occupiedRadius, out Vector3 result)
	{
		result = default;
		if (null == actor || null == objCurRoom)
		{
			return false;
		}
		if (!objCurRoom.TryGetFloorCellIndexByWorldPos(targetPos, out var l, out var w))
		{
			return false;
		}
		if (minRing < 0)
		{
			minRing = 0;
		}
		Vector3 position = actor.transform.position;
		for (int i = minRing; i <= maxRing; i++)
		{
			bool flag = false;
			Vector3 vector = default;
			float num = float.MaxValue;
			for (int j = -i; j <= i; j++)
			{
				for (int k = -i; k <= i; k++)
				{
					if (Mathf.Max(Mathf.Abs(j), Mathf.Abs(k)) != i)
					{
						continue;
					}
					int l2 = l + j;
					int w2 = w + k;
					if (objCurRoom.CheckCellCanPutChar(l2, w2) && objCurRoom.TryGetCellWorldPos(l2, w2, out var worldPos) && actor.CheckPositionWalkable(worldPos) && !IsCellOccupiedByOtherActor(worldPos, actor, occupiedRadius))
					{
						float num2 = worldPos.x - position.x;
						float num3 = worldPos.z - position.z;
						float num4 = num2 * num2 + num3 * num3;
						if (num4 < num)
						{
							num = num4;
							vector = worldPos;
							flag = true;
						}
					}
				}
			}
			if (flag)
			{
				result = vector;
				return true;
			}
		}
		return false;
	}

	private bool IsCellOccupiedByOtherActor(Vector3 cellPos, DormActor self, float radius = 0.5f)
	{
		List<DormActor> actors = Actors;
		if (actors == null)
		{
			return false;
		}
		float num = radius * radius;
		for (int i = 0; i < actors.Count; i++)
		{
			DormActor dormActor = actors.get_Item(i);
			if (!(null == dormActor) && !(dormActor == self) && !dormActor.isHide)
			{
				Vector3 position = dormActor.transform.position;
				float num2 = position.x - cellPos.x;
				float num3 = position.z - cellPos.z;
				if (num2 * num2 + num3 * num3 < num)
				{
					return true;
				}
			}
		}
		return false;
	}

	private DormFurObjInteractivePoint PickInteractivePointAvoidingActors(DormActor actor, DormFurObj obj, long forEntityID)
	{
		if (null == actor || null == obj)
		{
			return null;
		}
		DormFurObjInteractivePoint[] interactivePoints = obj.InteractivePoints;
		if (interactivePoints == null)
		{
			return null;
		}
		Vector3 position = actor.transform.position;
		DormFurObjInteractivePoint result = null;
		float num = float.MaxValue;
		foreach (DormFurObjInteractivePoint dormFurObjInteractivePoint in interactivePoints)
		{
			if (dormFurObjInteractivePoint == null || !dormFurObjInteractivePoint.IsFreeFor(forEntityID))
			{
				continue;
			}
			Transform target_by_design_start = dormFurObjInteractivePoint.target_by_design_start;
			if (!(null == target_by_design_start) && !IsCellOccupiedByOtherActor(target_by_design_start.position, actor, 0.7f))
			{
				float num2 = target_by_design_start.position.x - position.x;
				float num3 = target_by_design_start.position.z - position.z;
				float num4 = num2 * num2 + num3 * num3;
				if (num4 < num)
				{
					num = num4;
					result = dormFurObjInteractivePoint;
				}
			}
		}
		return result;
	}

	public List<DormFurObj> QueryInteractableFurnituresForActor(DormActor actor)
	{
		List<DormFurObj> list = new List<DormFurObj>();
		if (null == actor || null == objCurRoom)
		{
			return list;
		}
		IReadOnlyList<DormFurObj> listFurObj = objCurRoom.ListFurObj;
		if (listFurObj == null)
		{
			return list;
		}
		for (int i = 0; i < listFurObj.Count; i++)
		{
			DormFurObj dormFurObj = listFurObj.get_Item(i);
			if (!(null == dormFurObj) && dormFurObj.gameObject.activeSelf && dormFurObj.CanDoInteractived && dormFurObj.CanInteractBy(actor))
			{
				list.Add(dormFurObj);
			}
		}
		return list;
	}

	public bool TryPickInteractableFurnitureForActor(DormActor actor, out DormFurObj furniture, out Vector3 walkTarget)
	{
		furniture = null;
		walkTarget = default;
		if (null == actor || null == objCurRoom)
		{
			return false;
		}
		actor.ReleaseFurnitureInteractReservation();
		if (actor.IsFurnitureInteractOnCooldown)
		{
			return false;
		}
		IReadOnlyList<DormFurObj> listFurObj = objCurRoom.ListFurObj;
		if (listFurObj == null || listFurObj.Count == 0)
		{
			return false;
		}
		_interactCandidates.Clear();
		for (int i = 0; i < listFurObj.Count; i++)
		{
			DormFurObj dormFurObj = listFurObj.get_Item(i);
			if (!(null == dormFurObj) && dormFurObj.gameObject.activeSelf && dormFurObj.CanDoInteractived && !dormFurObj.IsElevator && dormFurObj.CanInteractBy(actor) && PickInteractivePointAvoidingActors(actor, dormFurObj, actor.id) != null)
			{
				_interactCandidates.Add(dormFurObj);
			}
		}
		if (_interactCandidates.Count == 0)
		{
			return false;
		}
		furniture = _interactCandidates.get_Item(UnityEngine.Random.Range(0, _interactCandidates.Count));
		DormFurObjInteractivePoint dormFurObjInteractivePoint = PickInteractivePointAvoidingActors(actor, furniture, actor.id) ?? furniture.GetFreeInteractivePoint(actor.id);
		if (dormFurObjInteractivePoint == null || null == dormFurObjInteractivePoint.target_by_design_start)
		{
			furniture = null;
			return false;
		}
		actor.ReserveFurnitureInteractPoint(furniture, dormFurObjInteractivePoint);
		walkTarget = dormFurObjInteractivePoint.target_by_design_start.position;
		return true;
	}

	public bool ActorBeginInteractWithFurniture(DormActor actor, DormFurObj furniture)
	{
		if (null == actor || null == furniture)
		{
			return false;
		}
		if (!furniture.CanInteractBy(actor))
		{
			actor.ReleaseFurnitureInteractReservation();
			return false;
		}
		actor.TryConsumeFurnitureInteractReservation(furniture, out var point);
		if (point == null || point.IsUsing)
		{
			point = PickInteractivePointAvoidingActors(actor, furniture, actor.id) ?? furniture.GetFreeInteractivePoint(actor.id);
		}
		if (point == null)
		{
			NovaLogger.Debug($"[Dorm] 漫游交互放弃：家具交互点已被占满 actor={actor.name}(id={actor.id}) fur={furniture.FurId}");
			return false;
		}
		ActorDoInteractiveWithFurObj(actor, furniture, placeAtStartImmediately: false, point);
		return true;
	}

	private bool IsInteractTargetOccluded(Vector3 playerPos, Vector3 targetPos, GameObject targetRoot)
	{
		if (!DormConfigs.interactOcclusionCheck)
		{
			return false;
		}
		float y = playerPos.y + DormConfigs.interactOcclusionRayHeight;
		Vector3 vector = new Vector3(playerPos.x, y, playerPos.z);
		Vector3 vector2 = new Vector3(targetPos.x, y, targetPos.z) - vector;
		float magnitude = vector2.magnitude;
		if (magnitude <= Mathf.Epsilon)
		{
			return false;
		}
		RaycastHit[] array = Physics.RaycastAll(vector, vector2 / magnitude, magnitude, InteractOcclusionMask, QueryTriggerInteraction.Ignore);
		for (int i = 0; i < array.Length; i++)
		{
			Transform transform = array[i].transform;
			if (!(transform == null) && (!(targetRoot != null) || !transform.IsChildOf(targetRoot.transform)) && (!DormUtil.TryGetFurObjByCollider(array[i].collider, out var obj) || !obj.IsFlatDecor))
			{
				return true;
			}
		}
		return false;
	}

	private void UpdateInteractive()
	{
		if (Time.frameCount % 15 != 0 || null == objCurRoom)
		{
			return;
		}
		DormPlayer player = playerController.Player;
		List<DormActor> actors = Actors;
		IReadOnlyList<DormFurObj> listFurObj = objCurRoom.ListFurObj;
		if (!(null != player) || actors == null || enInteractiveObjDic.ContainsKey(player.id) || IsElevatorFlowActive)
		{
			return;
		}
		Vector2 b = new Vector2(player.transform.position.x, player.transform.position.z);
		bool flag = HasInputCap(DormInputCap.PickActor) && (dormMode == DormActor.DormMode.Default || dormMode == DormActor.DormMode.Visitor);
		if (flag)
		{
			if (dormMode == DormActor.DormMode.Default)
			{
				for (int i = 0; i < actors.Count; i++)
				{
					DormActor dormActor = actors.get_Item(i);
					if (null == dormActor || dormActor.isHide)
					{
						continue;
					}
					long id = dormActor.id;
					if (id == player.id)
					{
						continue;
					}
					if (Vector2.Distance(new Vector2(dormActor.transform.position.x, dormActor.transform.position.z), b) < 2f && !IsInteractTargetOccluded(player.transform.position, dormActor.transform.position, dormActor.gameObject))
					{
						if (!playerEnterRngObjs.Contains(id))
						{
							OnPlayerInteractiveRangeObjEnter(id);
							MonoSingleton<LuaManager>.Instance.FireEvent("ACTIVE_DORM_INTERACTIVE_HUD", dormActor.transform, 0, dormActor.RoleId, dormActor.id);
						}
					}
					else if (playerEnterRngObjs.Contains(id))
					{
						OnPlayerInteractiveRangeObjExit(id);
						MonoSingleton<LuaManager>.Instance.FireEvent("DEACTIVE_DORM_INTERACTIVE_HUD", id);
					}
				}
			}
			if (listFurObj != null)
			{
				for (int j = 0; j < listFurObj.Count; j++)
				{
					DormFurObj dormFurObj = listFurObj.get_Item(j);
					if (!dormFurObj.gameObject.activeSelf)
					{
						continue;
					}
					float num = Vector2.Distance(new Vector2(dormFurObj.transform.position.x, dormFurObj.transform.position.z), b);
					long id2 = dormFurObj.id;
					if (num < 2f && !IsInteractTargetOccluded(player.transform.position, dormFurObj.transform.position, dormFurObj.gameObject))
					{
						if (!playerEnterRngObjs.Contains(id2))
						{
							OnPlayerInteractiveRangeObjEnter(id2);
							bool a = dormFurObj.CanInteractBy(player) && dormFurObj.HasFreeInteractivePoint && dormFurObj.CanDoInteractived;
							MonoSingleton<LuaManager>.Instance.FireEvent("ACTIVE_DORM_INTERACTIVE_HUD", dormFurObj, 1, dormFurObj.FurId, dormFurObj.id, a);
						}
					}
					else if (playerEnterRngObjs.Contains(id2))
					{
						OnPlayerInteractiveRangeObjExit(id2);
						MonoSingleton<LuaManager>.Instance.FireEvent("DEACTIVE_DORM_INTERACTIVE_HUD", id2);
					}
				}
			}
			if (dormMode == DormActor.DormMode.Default)
			{
				UpdateNoticedActor();
			}
		}
		else if (_interactivePrevShowedHud)
		{
			if (_interactiveIconShowing)
			{
				_interactiveIconShowing = false;
				CancelInteractTarget();
			}
			if (null != _noticedActor)
			{
				_noticedActor.CancelNoticeByPlayer();
				_noticedActor = null;
			}
			for (int num2 = playerEnterRngObjs.Count - 1; num2 >= 0; num2--)
			{
				long num3 = playerEnterRngObjs.get_Item(num2);
				MonoSingleton<LuaManager>.Instance.FireEvent("DEACTIVE_DORM_INTERACTIVE_HUD", num3);
				OnPlayerInteractiveRangeObjExit(num3);
			}
		}
		_interactivePrevShowedHud = flag;
	}

	private void InitPostProcessNodes(Scene scene)
	{
		ResetPostProcessCache();
		CachePostProcessNodes(scene);
		if (HasAnyPostProcessNode())
		{
			UpdateViewTopZoomFlag();
			ApplyPostProcessState(ResolvePostProcessState(), immediate: true);
		}
	}

	private void ResetPostProcessCache()
	{
		KillPpsNodeTween(_ppsDefault);
		KillPpsNodeTween(_ppsInteractFocus);
		KillPpsNodeTween(_ppsView);
		KillPpsNodeTween(_ppsViewTop);
		KillPpsNodeTween(_ppsEdit);
		KillPpsNodeTween(_ppsSwitchActor);
		KillPpsNodeTween(_ppsVisitor);
		_ppsDefault = null;
		_ppsInteractFocus = null;
		_ppsView = null;
		_ppsViewTop = null;
		_ppsEdit = null;
		_ppsSwitchActor = null;
		_ppsVisitor = null;
		_viewTopZoomReached = false;
		_appliedPostProcessState = DormPostProcessState.Unknown;
	}

	private void CachePostProcessNodes(Scene scene)
	{
		if (!scene.IsValid())
		{
			return;
		}
		GameObject[] rootGameObjects = scene.GetRootGameObjects();
		Transform transform = null;
		for (int i = 0; i < rootGameObjects.Length; i++)
		{
			if (rootGameObjects[i].name == "==== PostProcessing ====")
			{
				transform = rootGameObjects[i].transform;
				break;
			}
		}
		if (!(null == transform))
		{
			_ppsDefault = CreatePpsNode(transform, "PPS_Default");
			_ppsInteractFocus = CreatePpsNode(transform, "PPS_InteractFocus");
			_ppsView = CreatePpsNode(transform, "PPS_View");
			_ppsViewTop = CreatePpsNode(transform, "PPS_ViewTop");
			_ppsEdit = CreatePpsNode(transform, "PPS_Edit");
			_ppsSwitchActor = CreatePpsNode(transform, "PPS_SwitchActor");
			_ppsVisitor = CreatePpsNode(transform, "PPS_Visitor");
		}
	}

	private static PpsNode CreatePpsNode(Transform root, string nodeName)
	{
		Transform transform = root.Find(nodeName);
		if (null == transform)
		{
			return null;
		}
		PpsNode ppsNode = new PpsNode
		{
			go = transform.gameObject
		};
		ppsNode.volume = transform.GetComponent<Volume>();
		if (null != ppsNode.volume)
		{
			ppsNode.restWeight = ppsNode.volume.weight;
		}
		return ppsNode;
	}

	private bool HasAnyPostProcessNode()
	{
		if (!IsPpsNodeValid(_ppsDefault) && !IsPpsNodeValid(_ppsInteractFocus) && !IsPpsNodeValid(_ppsView) && !IsPpsNodeValid(_ppsViewTop) && !IsPpsNodeValid(_ppsEdit) && !IsPpsNodeValid(_ppsSwitchActor))
		{
			return IsPpsNodeValid(_ppsVisitor);
		}
		return true;
	}

	private static bool IsPpsNodeValid(PpsNode node)
	{
		if (node != null)
		{
			return null != node.go;
		}
		return false;
	}

	private static void KillPpsNodeTween(PpsNode node)
	{
		if (node != null && node.tween != null)
		{
			node.tween.Kill();
			node.tween = null;
		}
	}

	private static bool IsCameraFocusing()
	{
		DormCameraController instance = SceneSingleton<DormCameraController>.Instance;
		if (null != instance)
		{
			return instance.IsFocusing;
		}
		return false;
	}

	private bool UpdateViewTopZoomFlag()
	{
		if (dormMode != DormActor.DormMode.View)
		{
			if (!_viewTopZoomReached)
			{
				return false;
			}
			_viewTopZoomReached = false;
			return true;
		}
		if (IsCameraFocusing())
		{
			return false;
		}
		float currentZoomNormalized = SceneSingleton<DormCameraController>.Instance.CurrentZoomNormalized;
		bool flag = (_viewTopZoomReached ? (currentZoomNormalized >= 0.85f) : (currentZoomNormalized >= 0.95f));
		if (flag == _viewTopZoomReached)
		{
			return false;
		}
		_viewTopZoomReached = flag;
		return true;
	}

	private DormPostProcessState ResolvePostProcessState()
	{
		if (dormMode == DormActor.DormMode.Default)
		{
			if (!IsCameraFocusing())
			{
				return DormPostProcessState.Default;
			}
			return DormPostProcessState.InteractFocus;
		}
		if (dormMode == DormActor.DormMode.View)
		{
			if (!IsCameraFocusing() && _viewTopZoomReached)
			{
				return DormPostProcessState.ViewTop;
			}
			return DormPostProcessState.View;
		}
		return dormMode switch
		{
			DormActor.DormMode.Edit => DormPostProcessState.Edit, 
			DormActor.DormMode.SwitchActor => DormPostProcessState.SwitchActor, 
			DormActor.DormMode.Visitor => DormPostProcessState.Visitor, 
			_ => DormPostProcessState.None, 
		};
	}

	private void RefreshPostProcessState()
	{
		if (HasAnyPostProcessNode())
		{
			UpdateViewTopZoomFlag();
			ApplyPostProcessState(ResolvePostProcessState(), immediate: false);
		}
	}

	private void UpdatePostProcessViewTop()
	{
		if (dormMode == DormActor.DormMode.View && HasAnyPostProcessNode() && UpdateViewTopZoomFlag())
		{
			ApplyPostProcessState(ResolvePostProcessState(), immediate: false);
		}
	}

	private void ApplyPostProcessState(DormPostProcessState state, bool immediate)
	{
		if (state != _appliedPostProcessState)
		{
			_appliedPostProcessState = state;
			SetPpsNodeActive(_ppsDefault, state == DormPostProcessState.Default, immediate);
			SetPpsNodeActive(_ppsInteractFocus, state == DormPostProcessState.InteractFocus, immediate);
			SetPpsNodeActive(_ppsView, state == DormPostProcessState.View, immediate: true);
			SetPpsNodeActive(_ppsViewTop, state == DormPostProcessState.ViewTop, immediate: true);
			SetPpsNodeActive(_ppsEdit, state == DormPostProcessState.Edit, immediate: true);
			SetPpsNodeActive(_ppsSwitchActor, state == DormPostProcessState.SwitchActor, immediate: true);
			SetPpsNodeActive(_ppsVisitor, state == DormPostProcessState.Visitor, immediate: true);
		}
	}

	private static void SetPpsNodeActive(PpsNode node, bool active, bool immediate)
	{
		if (!IsPpsNodeValid(node))
		{
			return;
		}
		KillPpsNodeTween(node);
		Volume volume = node.volume;
		if ((null == volume) | immediate)
		{
			if (null != volume)
			{
				volume.weight = (active ? node.restWeight : 0f);
			}
			node.go.SetActive(active);
		}
		else if (active)
		{
			if (!node.go.activeSelf)
			{
				volume.weight = 0f;
				node.go.SetActive(value: true);
			}
			node.tween = volume.DOWeightTo(node.restWeight, 0.5f);
		}
		else
		{
			if (!node.go.activeSelf)
			{
				return;
			}
			node.tween = volume.DOWeightTo(0f, 0.5f).OnComplete(() =>
			{
				node.tween = null;
				if (null != node.go)
				{
					node.go.SetActive(value: false);
				}
			});
		}
	}

	public bool TryGetRandomEmptyFloorCellWorldPos(out Vector3 worldPos, bool reserve = false)
	{
		worldPos = default;
		if (null != objCurRoom)
		{
			return objCurRoom.TryGetRandomEmptyFloorCellWorldPos(out worldPos, reserve);
		}
		return false;
	}

	public void ClearSpawnReservations()
	{
		objCurRoom?.ClearSpawnReservations();
	}

	public void SpawnActorToRandomCell(DormActor actor)
	{
		if (!(null == actor))
		{
			Vector3 result;
			if (TryGetRandomEmptyFloorCellWorldPos(out var worldPos, reserve: true))
			{
				actor.SyncMovementLocation(new TSVector2(worldPos.x, worldPos.z), 0);
			}
			else if (actor.TryGetRandomWalkablePointInScene(out result))
			{
				actor.SyncMovementLocation(new TSVector2(result.x, result.z), result.y);
			}
		}
	}

	private void DestroyRoom()
	{
		bHasHit = (isDraggingFurObj = false);
		objCurFur = (objFur_RaycastHit = null);
		SwitchRoom(null);
		roomInfo = null;
		presetInfo = null;
	}

	private void OnInputDown_SwitchTargetFurObj(Vector2 screenPosition)
	{
		if (!EventSystem.current.IsPointerOverGameObject())
		{
			objFur_RaycastHit = null;
			ray = CAM.ScreenPointToRay(screenPosition);
			bHasHit = Physics.Raycast(ray, out hit, 100f, 1 << DormConstValue.LAYER_FURNITURE);
			if (bHasHit && hit.collider != null)
			{
				DormUtil.TryGetFurObjByCollider(hit.collider, out objFur_RaycastHit);
			}
			isDraggingFurObj = objFur_RaycastHit != null;
			SwitchFur(objFur_RaycastHit);
		}
	}

	private void OnInputPress_DragTargetFurObj(Vector2 screenPosition)
	{
		if (EventSystem.current.IsPointerOverGameObject() || !isDraggingFurObj)
		{
			return;
		}
		ray = CAM.ScreenPointToRay(screenPosition);
		bHasHit = Physics.Raycast(ray, out hit, 100f, 1 << DormConstValue.LAYER_FLOOR_WALL);
		if (!bHasHit || !(hit.collider != null))
		{
			return;
		}
		bool bSetToSnapPos = false;
		if (objCurFur.IsOnWall && DormUtil.TryGetFurObjByCollider(hit.collider, out var obj) && obj != null && obj.Type == HotfixEnum.DormFurType.Wall)
		{
			if (colWall == null)
			{
				colWall = hit.collider;
			}
			else if (colWall != hit.collider)
			{
				bSetToSnapPos = true;
				v3iLastSnapped = Vector3Int.left;
				objCurFur.SetRotate(bClockwise: true);
				colWall = hit.collider;
			}
		}
		objCurFur.Follow(hit.point);
		int num = SnapAndCheck(objCurFur, bSetToSnapPos);
		if (num == 0 || num == 1)
		{
			Event2Lua_SetFurHud(objCurFur, bVisible: false, bEnableUpdatePos: false);
		}
	}

	private void OnInputPressUp_EndDragTargetFurObj(Vector2 screenPosition)
	{
		if (!EventSystem.current.IsPointerOverGameObject())
		{
			isDraggingFurObj = false;
			colWall = null;
			objCurFur?.SetPos(v3iLastSnapped);
			Event2Lua_SetFurHud(objCurFur, bVisible: true, bEnableUpdatePos: false);
		}
	}

	private void ParseLevelData()
	{
		LuaTable luaTable = MonoSingleton<GameController>.Instance.dynamicModuleParams as LuaTable;
		MonoSingleton<GameController>.Instance.dynamicModuleParams = null;
		if (luaTable == null)
		{
			return;
		}
		int length = luaTable.Length;
		if (length <= 0)
		{
			return;
		}
		LuaTable value = null;
		luaTable.Get<int, LuaTable>(1, out value);
		if (value == null)
		{
			return;
		}
		int length2 = value.Length;
		if (length2 <= 0)
		{
			return;
		}
		int value2 = 0;
		int value3 = 0;
		value.Get<int, int>(1, out value2);
		switch ((EDataType)value2)
		{
		case EDataType.RoomData:
		{
			roomInfo = new DormRoomInfo();
			value.Get<int, int>(2, out value3);
			roomInfo.DormRoomId = (uint)value3;
			value.Get<int, int>(3, out value3);
			int num2 = value3;
			if (num2 <= 0 || length - 1 != num2)
			{
				break;
			}
			levelLoadParam = new DormLevelLoadParam();
			levelLoadParam.DormRoomId = (int)roomInfo.DormRoomId;
			if (levelLoadParam.listRoleInfo == null)
			{
				levelLoadParam.listRoleInfo = new List<DormRoleInfo>();
			}
			levelLoadParam.listRoleInfo.Clear();
			LuaTable value4 = null;
			value.Get<int, LuaTable>(4, out value4);
			if (value4 != null && value4.Length > 0)
			{
				int length3 = value4.Length;
				LuaTable value5 = null;
				int value6 = 0;
				bool value7 = false;
				for (int j = 1; j <= length3; j++)
				{
					value4.Get<int, LuaTable>(j, out value5);
					value5.Get<int, int>(1, out var value8);
					value5.Get<int, int>(2, out value6);
					value5.Get<int, bool>(3, out value7);
					DormRoleInfo dormRoleInfo = new DormRoleInfo();
					dormRoleInfo.RoleId = value8;
					dormRoleInfo.SkinId = value6;
					dormRoleInfo.IsVisit = value7;
					levelLoadParam.listRoleInfo.Add(dormRoleInfo);
				}
			}
			levelLoadParam.bIsMoWangMale = IsMoWangMale(levelLoadParam.listRoleInfo);
			int value9 = 0;
			if (length2 >= 5)
			{
				value.Get<int, int>(5, out value9);
			}
			levelLoadParam.DormRoomSceneId = value9;
			bool value10 = false;
			if (length2 >= 6)
			{
				value.Get<int, bool>(6, out value10);
			}
			levelLoadParam.bIsGuide = value10;
			roomInfo.FurnitureList = new FurnitureInfo[num2];
			for (int k = 2; k <= length; k++)
			{
				FurnitureInfo furnitureInfo2 = new FurnitureInfo();
				luaTable.Get<int, LuaTable>(k, out value);
				length2 = value.Length;
				if (length2 == 5)
				{
					value.Get<int, int>(1, out value3);
					furnitureInfo2.FurnitureId = (uint)value3;
					value.Get<int, int>(2, out value3);
					furnitureInfo2.X = (uint)value3;
					value.Get<int, int>(3, out value3);
					furnitureInfo2.Y = (uint)value3;
					value.Get<int, int>(4, out value3);
					furnitureInfo2.Z = (uint)value3;
					value.Get<int, int>(5, out value3);
					furnitureInfo2.Rotation = (uint)value3;
				}
				roomInfo.FurnitureList[k - 2] = furnitureInfo2;
			}
			break;
		}
		case EDataType.PresetData:
		{
			presetInfo = new FurniturePresetInfo();
			value.Get<int, int>(2, out value3);
			presetInfo.DormType = (uint)value3;
			value.Get<int, int>(3, out value3);
			presetInfo.BuildId = (uint)value3;
			value.Get<int, int>(4, out value3);
			int num = value3;
			if (num <= 0 || length - 1 != num)
			{
				break;
			}
			presetInfo.FurnitureList = new FurnitureInfo[num];
			for (int i = 2; i <= length; i++)
			{
				FurnitureInfo furnitureInfo = new FurnitureInfo();
				luaTable.Get<int, LuaTable>(i, out value);
				length2 = value.Length;
				if (length2 == 5)
				{
					value.Get<int, int>(1, out value3);
					furnitureInfo.FurnitureId = (uint)value3;
					value.Get<int, int>(2, out value3);
					furnitureInfo.X = (uint)value3;
					value.Get<int, int>(3, out value3);
					furnitureInfo.Y = (uint)value3;
					value.Get<int, int>(4, out value3);
					furnitureInfo.Z = (uint)value3;
					value.Get<int, int>(5, out value3);
					furnitureInfo.Rotation = (uint)value3;
				}
				presetInfo.FurnitureList[i - 2] = furnitureInfo;
			}
			break;
		}
		}
	}

	private static bool IsMoWangMale(List<DormRoleInfo> listRole)
	{
		if (listRole != null)
		{
			for (int i = 0; i < listRole.Count; i++)
			{
				if (9101 == listRole.get_Item(i).RoleId)
				{
					return true;
				}
				if (9100 == listRole.get_Item(i).RoleId)
				{
					return false;
				}
			}
		}
		NovaLogger.Error($"后宅角色列表里没有魔王角色({9101}/{9100})，性别按女处理!");
		return false;
	}

	private void SwitchRoom(DormRoomInfo roomInfo)
	{
		if (objCurRoom != null)
		{
			objCurRoom.ClearRoom();
			UnityEngine.Object.DestroyImmediate(objCurRoom.gameObject);
			objCurRoom = null;
		}
		if (roomInfo != null)
		{
			GameObject gameObject = new GameObject(roomInfo.DormRoomId.ToString(), typeof(DormRoomObj));
			gameObject.transform.parent = GameObject.Find("==== Room ====").transform;
			gameObject.transform.localPosition = Vector3.zero + DormConstValue.V3_ZERO_OFFSET;
			gameObject.transform.localRotation = Quaternion.identity;
			gameObject.transform.localScale = Vector3.one;
			objCurRoom = gameObject.GetComponent<DormRoomObj>();
			objCurRoom.Init(roomInfo);
		}
		ForceUpdateNavCuts();
		ActorRelocateAllOntoNavmesh();
	}

	public void SwitchRoomMode(DormActor.DormMode eMode)
	{
		objCurRoom?.SwitchToEditMode(eMode == DormActor.DormMode.Edit);
	}

	private void SwitchFur(DormFurObj objFur)
	{
		if (objFur == objCurFur)
		{
			return;
		}
		bool flag = true;
		if (objCurFur != null)
		{
			flag = TryLandToRoomCell(objCurFur);
		}
		if (!DormConstValue.FORCE_LEGAL || flag)
		{
			objCurFur?.SwitchToIdle();
			objCurFur = objFur;
			v3iLastSnapped = Vector3Int.left;
			if (objCurFur != null)
			{
				objCurFur.SwitchToDecorate();
				objCurRoom.ChangeCells(objCurFur, bSet: false);
				objCurRoom.RemoveFurObj(objCurFur, bVisible: true);
				SnapAndCheck(objCurFur, bSetToSnapPos: false);
			}
			SetFloorWallDotLine();
			Event2Lua_SwitchFurniture();
		}
	}

	private int SnapAndCheck(DormFurObj objFur, bool bSetToSnapPos, bool bRotateCheck = false)
	{
		if (objFur == null)
		{
			return -1;
		}
		Vector3Int vector3Int = objCurRoom.SnapToRoomCell(objFur, bRotateCheck);
		if (!bSetToSnapPos && vector3Int == v3iLastSnapped)
		{
			return -2;
		}
		v3iLastSnapped = vector3Int;
		if (bSetToSnapPos)
		{
			objFur.SetPos(vector3Int);
		}
		bool flag = objCurRoom.CheckCells(objFur, vector3Int, EColorType.Both);
		objCurRoom.CheckIllegalFurObjs(objFur);
		if (!flag)
		{
			return 0;
		}
		return 1;
	}

	private bool TryLandToRoomCell(DormFurObj objFur)
	{
		if (objFur == null)
		{
			return true;
		}
		int num = SnapAndCheck(objFur, bSetToSnapPos: true);
		if (num == 1)
		{
			objFur.MarkLanded();
			objCurRoom.ResetCellColor(objFur);
			objCurRoom.ChangeCells(objFur, bSet: true);
			objCurRoom.AddFurObj(objFur);
		}
		return num == 1;
	}

	private void SetFloorWallDotLine()
	{
		bool dotLine = objCurFur != null && !objCurFur.IsOnWall;
		bool dotLine2 = objCurFur != null && objCurFur.IsOnWall;
		foreach (DormFurObj item in objCurRoom.ListFurObj)
		{
			if (item.Type == HotfixEnum.DormFurType.Floor)
			{
				item.SetDotLine(dotLine);
			}
			if (item.Type == HotfixEnum.DormFurType.Wall)
			{
				item.SetDotLine(dotLine2);
			}
		}
	}

	public int GetCurRoomUsedCellNum()
	{
		objCurRoom.CheckFloorCapacity(null);
		if (!(objCurRoom != null))
		{
			return 0;
		}
		return objCurRoom.CUR_NUM;
	}

	public long[] GetFurEntityId(int nFurId)
	{
		List<long> list = new List<long>();
		if (objCurRoom != null)
		{
			foreach (DormFurObj item in objCurRoom.ListFurObj)
			{
				if (item.FurId == nFurId && !list.Contains(item.id))
				{
					list.Add(item.id);
				}
			}
		}
		return list.ToArray();
	}

	public Transform[] GetFurRootBubbleTrans(int nFurId)
	{
		List<Transform> list = new List<Transform>();
		if (objCurRoom != null)
		{
			foreach (DormFurObj item in objCurRoom.ListFurObj)
			{
				if (item.FurId == nFurId && !list.Contains(item.Root_Bubble))
				{
					list.Add(item.Root_Bubble);
				}
			}
		}
		return list.ToArray();
	}

	private void EventFromLua_CreateFurniture(IEvent evt)
	{
		if (DormConstValue.FORCE_LEGAL && objCurFur != null && !TryLandToRoomCell(objCurFur))
		{
			return;
		}
		GeneralEvent generalEvent = (GeneralEvent)evt;
		if (generalEvent == null)
		{
			return;
		}
		long num = (long)generalEvent.data;
		int oldFixedId = 0;
		DormFurObj dormFurObj = objCurRoom.CreateDormFurObj((uint)num, out oldFixedId);
		if (dormFurObj != null)
		{
			dormFurObj.IsNewCreate = true;
			SwitchFur(dormFurObj);
			Event2Lua_SetFurHud(objCurFur, bVisible: true, bEnableUpdatePos: false);
			if (dormFurObj.FixedType != HotfixEnum.DormFurFixedType.None && nPreviousID == 0 && oldFixedId != 0)
			{
				nPreviousID = oldFixedId;
			}
		}
	}

	private void EventFromLua_UnselectFurniture(IEvent evt)
	{
		if (objCurFur != null && objCurFur.IsNewCreate)
		{
			objCurFur.MarkLanded();
		}
		SwitchFur(null);
		nPreviousID = 0;
	}

	private void EventFromLua_RotateFurniture(IEvent evt)
	{
		if (!(objCurFur == null))
		{
			bool rotate = true;
			GeneralEvent generalEvent = (GeneralEvent)evt;
			if (generalEvent != null)
			{
				rotate = (bool)generalEvent.data;
			}
			objCurFur.SetRotate(rotate);
			if (objCurFur.IsOnWall)
			{
				Vector3Int roomPos = objCurFur.RoomPos;
				objCurFur.SetPos(roomPos.z, roomPos.y, roomPos.x);
			}
			colWall = null;
			SnapAndCheck(objCurFur, bSetToSnapPos: true, bRotateCheck: true);
			if (objCurFur.IsOnWall)
			{
				Event2Lua_SetFurHud(objCurFur, bVisible: true, bEnableUpdatePos: true);
			}
		}
	}

	private void EventFromLua_CancelFurniture(IEvent evt)
	{
		if (objCurFur == null)
		{
			return;
		}
		int[] array = new int[2];
		if (objCurFur.IsNewCreate)
		{
			objCurFur.IsNewCreate = false;
			array[0] = 1;
			if (objCurFur.FixedType == HotfixEnum.DormFurFixedType.None)
			{
				objCurRoom.RemoveFurObj(objCurFur, bVisible: false);
				objCurRoom.ResetCellColor(objCurFur);
				objCurFur = null;
				v3iLastSnapped = Vector3Int.left;
				SetFloorWallDotLine();
				Event2Lua_SwitchFurniture();
				array[1] = 0;
			}
			else
			{
				objCurRoom.ResetCellColor(objCurFur);
				DormFurObj dormFurObj = objCurRoom.RevertToPreviousFurObj(nPreviousID, objCurFur);
				if (dormFurObj != null)
				{
					dormFurObj.IsNewCreate = false;
				}
				objCurFur = null;
				v3iLastSnapped = Vector3Int.left;
				SetFloorWallDotLine();
				Event2Lua_SwitchFurniture();
				array[1] = nPreviousID;
				nPreviousID = 0;
			}
		}
		else
		{
			objCurFur.SetToLastLanded();
			SwitchFur(null);
			array[0] = 0;
			array[1] = 0;
		}
		MonoSingleton<GameController>.Instance.dynamicModuleParams = array;
	}

	private void EventFromLua_DeleteFurniture(IEvent evt)
	{
		if (!(objCurFur == null) && objCurFur.FixedType == HotfixEnum.DormFurFixedType.None)
		{
			objCurRoom.RemoveFurObj(objCurFur, bVisible: false);
			objCurRoom.ResetCellColor(objCurFur);
			objCurRoom.CheckIllegalFurObjs(null);
			objCurFur = null;
			v3iLastSnapped = Vector3Int.left;
			SetFloorWallDotLine();
			Event2Lua_SwitchFurniture();
		}
	}

	private void EventFromLua_SaveRoom(IEvent evt)
	{
		SwitchFur(null);
		List<FurnitureInfo> list = new List<FurnitureInfo>();
		ERoomSaveCheckResult eRoomSaveCheckResult = objCurRoom.CheckToSave(ref list);
		int count = list.Count;
		int[] array = new int[((eRoomSaveCheckResult != ERoomSaveCheckResult.Success || count <= 0) ? 1 : (count + 1)) * 5];
		array[0] = 3;
		array[1] = (int)eRoomSaveCheckResult;
		array[2] = count;
		array[3] = 0;
		array[4] = 0;
		if (eRoomSaveCheckResult == ERoomSaveCheckResult.Success && count > 0)
		{
			for (int i = 0; i < count; i++)
			{
				FurnitureInfo furnitureInfo = list.get_Item(i);
				array[(i + 1) * 5] = (int)furnitureInfo.FurnitureId;
				array[(i + 1) * 5 + 1] = (int)furnitureInfo.X;
				array[(i + 1) * 5 + 2] = (int)furnitureInfo.Y;
				array[(i + 1) * 5 + 3] = (int)furnitureInfo.Z;
				array[(i + 1) * 5 + 4] = (int)furnitureInfo.Rotation;
			}
		}
		roomInfoToSave = null;
		if (eRoomSaveCheckResult == ERoomSaveCheckResult.Success)
		{
			if (objCurRoom.CheckNeedSave())
			{
				roomInfoToSave = new DormRoomInfo();
				roomInfoToSave.DormRoomId = roomInfo.DormRoomId;
				roomInfoToSave.FurnitureList = list.ToArray();
			}
			else
			{
				array[1] = 4;
			}
		}
		MonoSingleton<GameController>.Instance.dynamicModuleParams = array;
	}

	private void EventFromLua_SaveRoomSucc(IEvent evt)
	{
		if (roomInfoToSave != null)
		{
			roomInfo = roomInfoToSave;
			roomInfoToSave = null;
		}
		objCurRoom.CloneCells();
		ForceUpdateNavCuts();
		ClearSpawnReservations();
		for (int i = 0; i < listActor.Count; i++)
		{
			DormActor dormActor = listActor.get_Item(i);
			if (!(null == dormActor))
			{
				SpawnActorToRandomCell(dormActor);
			}
		}
	}

	private void EventFromLua_AbandonSaveRoom(IEvent evt)
	{
		SwitchFur(null);
		SwitchRoom(roomInfo);
		objCurRoom?.MarkEditMode(b: true, bDoCloneCell: true);
	}

	private void EventFromLua_ClearRoom(IEvent evt)
	{
		SwitchFur(null);
		DormRoomInfo dormRoomInfo = new DormRoomInfo();
		dormRoomInfo.DormRoomId = roomInfo.DormRoomId;
		SwitchRoom(dormRoomInfo);
		objCurRoom?.MarkEditMode(b: true, bDoCloneCell: false);
	}

	private void EventFromLua_ApplyPreset(IEvent evt)
	{
		SwitchFur(null);
		ParseLevelData();
		if (presetInfo == null || !(objCurRoom != null) || (long)objCurRoom.Type != presetInfo.DormType || presetInfo.FurnitureList == null)
		{
			return;
		}
		List<FurnitureInfo> listFurInfo = new List<FurnitureInfo>(presetInfo.FurnitureList);
		if (listFurInfo != null && listFurInfo.Count > 0)
		{
			objCurRoom.AppendFurnitures(ref listFurInfo, bIsDefault: false, bApplyPreset: true);
		}
		presetInfo = null;
		int count = objCurRoom.dictApplyPresetResult.Keys.Count;
		if (count > 0)
		{
			int[] array = new int[(count + 1) * 2];
			array[0] = 4;
			array[1] = count;
			List<int> list = objCurRoom.dictApplyPresetResult.Keys.ToList();
			List<int> list2 = objCurRoom.dictApplyPresetResult.Values.ToList();
			for (int i = 0; i < count; i++)
			{
				array[(i + 1) * 2] = list.get_Item(i);
				array[(i + 1) * 2 + 1] = list2.get_Item(i);
			}
			MonoSingleton<GameController>.Instance.dynamicModuleParams = array;
			objCurRoom.dictApplyPresetResult.Clear();
		}
	}

	private void EventFromLua_HideFloorFur(IEvent evt)
	{
		GeneralEvent generalEvent = (GeneralEvent)evt;
		if (generalEvent != null)
		{
			bool bVisible = (bool)generalEvent.data;
			objCurRoom.HideFur(bIsFloorFurObj: true, bVisible, objCurFur);
		}
	}

	private void EventFromLua_HideWallFur(IEvent evt)
	{
		GeneralEvent generalEvent = (GeneralEvent)evt;
		if (generalEvent != null)
		{
			bool bVisible = (bool)generalEvent.data;
			objCurRoom.HideFur(bIsFloorFurObj: false, bVisible, objCurFur);
		}
	}

	private void Event2Lua_SwitchFurniture()
	{
		bool a = objCurRoom.CheckFloorCapacity(null);
		MonoSingleton<LuaManager>.Instance?.FireEvent("DORM_CS_SWITCH_FURNITURE", objCurFur, (!(objCurFur == null)) ? objCurFur.FurId : 0, objCurRoom.CUR_NUM, objCurRoom.MAX_NUM, a);
	}

	private void Event2Lua_SetFurHud(DormFurObj obj, bool bVisible, bool bEnableUpdatePos)
	{
		if (!(obj == null) && (bFurObjHudVisible != bVisible || bFurObjHudEnableUpdatePos != bEnableUpdatePos))
		{
			bFurObjHudVisible = bVisible;
			bFurObjHudEnableUpdatePos = bEnableUpdatePos;
			MonoSingleton<LuaManager>.Instance?.FireEvent("DORM_CS_SET_FUR_HUD", bVisible, bEnableUpdatePos);
		}
	}

	private void CaptureActorPosesBeforeSwitchActor()
	{
		_switchActorPoseSnapshots.Clear();
		for (int i = 0; i < listActor.Count; i++)
		{
			DormActor dormActor = listActor.get_Item(i);
			if (!(null == dormActor))
			{
				SwitchActorPoseSnapshot item = new SwitchActorPoseSnapshot
				{
					actor = dormActor,
					position = dormActor.transform.position,
					yaw = dormActor.transform.eulerAngles.y
				};
				if (enInteractiveObjDic != null && enInteractiveObjDic.TryGetValue(dormActor.id, out var value) && null != value)
				{
					item.interactFurObj = value;
					item.interactPoint = value.GetInteractivePointByBindEntity(dormActor.id);
				}
				_switchActorPoseSnapshots.Add(item);
			}
		}
	}

	private bool HasActorPoseSnapshot(DormActor actor)
	{
		if (null == actor)
		{
			return false;
		}
		for (int i = 0; i < _switchActorPoseSnapshots.Count; i++)
		{
			if (_switchActorPoseSnapshots.get_Item(i).actor == actor)
			{
				return true;
			}
		}
		return false;
	}

	private void ToggleSwitchActorModeForTest()
	{
		if (dormMode == DormActor.DormMode.SwitchActor)
		{
			SwitchDormMode(_modeBeforeSwitchActor);
			return;
		}
		_modeBeforeSwitchActor = dormMode;
		SwitchDormMode(DormActor.DormMode.SwitchActor);
	}

	private void ResetSwitchNodeCache()
	{
		_switchNodeCached = false;
		_switchActorPoints.Clear();
		_switchCameraBeacon = null;
		_switchActorPoseSnapshots.Clear();
	}

	private bool EnsureSwitchNodeCached()
	{
		if (_switchNodeCached)
		{
			return _switchActorPoints.Count > 0;
		}
		_switchNodeCached = true;
		_switchActorPoints.Clear();
		_switchCameraBeacon = null;
		GameObject gameObject = GameObject.Find("==== SwitchNode ====");
		if (null == gameObject)
		{
			NovaLogger.Error("未找到场景节点 ==== SwitchNode ====");
			return false;
		}
		Transform transform = gameObject.transform.Find("---- ActorPoints ----");
		if (null == transform)
		{
			NovaLogger.Error("未找到 ==== SwitchNode ====/---- ActorPoints ----");
			return false;
		}
		for (int i = 0; i < transform.childCount; i++)
		{
			_switchActorPoints.Add(transform.GetChild(i));
		}
		_switchPointOccupants = new DormActor[_switchActorPoints.Count];
		Transform switchCameraBeacon = gameObject.transform.Find("---- CameraBeaconPosition ----");
		_switchCameraBeacon = switchCameraBeacon;
		return _switchActorPoints.Count > 0;
	}

	private int AcquireStagePointIndex()
	{
		if (_switchPointOccupants == null)
		{
			return -1;
		}
		for (int i = 0; i < _switchPointOccupants.Length; i++)
		{
			if (null == _switchPointOccupants[i])
			{
				return i;
			}
		}
		return -1;
	}

	private bool ReleaseStagePointByActor(DormActor actor)
	{
		if (_switchPointOccupants == null || null == actor)
		{
			return false;
		}
		for (int i = 0; i < _switchPointOccupants.Length; i++)
		{
			if (_switchPointOccupants[i] == actor)
			{
				_switchPointOccupants[i] = null;
				return true;
			}
		}
		return false;
	}

	private void PlaceActorAtStagePoint(DormActor actor, int pointIndex)
	{
		Transform transform = _switchActorPoints.get_Item(pointIndex);
		actor.Visible();
		actor.SyncMovementLocation(new TSVector2(transform.position.x, transform.position.z), transform.position.y);
		actor.SyncRotation(transform.eulerAngles.y);
		_switchPointOccupants[pointIndex] = actor;
		actor.PlayIdle();
	}

	private DormActor FindActorByRoleId(int roleId)
	{
		for (int i = 0; i < listActor.Count; i++)
		{
			if (null != listActor.get_Item(i) && listActor.get_Item(i).RoleId == roleId)
			{
				return listActor.get_Item(i);
			}
		}
		return null;
	}

	private void EnterSwitchActorFlow()
	{
		if (!EnsureSwitchNodeCached())
		{
			return;
		}
		StopAllFurnitureInteractions();
		SetFloorFurnitureActive(active: false);
		Array.Clear(_switchPointOccupants, 0, _switchPointOccupants.Length);
		for (int i = 0; i < listActor.Count; i++)
		{
			DormActor dormActor = listActor.get_Item(i);
			if (!(null == dormActor) && !(dormActor is DormPlayer))
			{
				int num = AcquireStagePointIndex();
				if (num < 0)
				{
					break;
				}
				PlaceActorAtStagePoint(dormActor, num);
			}
		}
		if (null != _switchCameraBeacon)
		{
			SceneSingleton<DormCameraController>.Instance.BindFocusObject(_switchCameraBeacon.gameObject, groundBased: false);
		}
	}

	private void ExitSwitchActorFlow()
	{
		SetFloorFurnitureActive(active: true);
		if (_switchPointOccupants != null)
		{
			for (int i = 0; i < _switchPointOccupants.Length; i++)
			{
				if (null != _switchPointOccupants[i])
				{
					_switchPointOccupants[i].StopIdleShowAnim();
					_switchPointOccupants[i].Hide();
				}
			}
		}
		for (int num = listActor.Count - 1; num >= 0; num--)
		{
			DormActor dormActor = listActor.get_Item(num);
			if (!(null == dormActor) && !(dormActor is DormPlayer) && !IsActorOnStage(dormActor))
			{
				listActor.RemoveAt(num);
				UnityEngine.Object.Destroy(dormActor.gameObject);
			}
		}
		RestoreActorPosesForSwitchActorExit();
		if (_switchPointOccupants != null)
		{
			Array.Clear(_switchPointOccupants, 0, _switchPointOccupants.Length);
		}
	}

	private void RestoreActorPosesForSwitchActorExit()
	{
		for (int i = 0; i < _switchActorPoseSnapshots.Count; i++)
		{
			SwitchActorPoseSnapshot switchActorPoseSnapshot = _switchActorPoseSnapshots.get_Item(i);
			DormActor actor = switchActorPoseSnapshot.actor;
			if (!(null == actor))
			{
				actor.SyncMovementLocation(new TSVector2(switchActorPoseSnapshot.position.x, switchActorPoseSnapshot.position.z), switchActorPoseSnapshot.position.y);
				actor.SyncRotation(switchActorPoseSnapshot.yaw);
			}
		}
		ClearSpawnReservations();
		for (int j = 0; j < listActor.Count; j++)
		{
			DormActor dormActor = listActor.get_Item(j);
			if (!(null == dormActor) && !(dormActor is DormPlayer) && !HasActorPoseSnapshot(dormActor))
			{
				SpawnActorToRandomCell(dormActor);
				dormActor.Spawn();
			}
		}
	}

	private void ResumeInteractionsAfterSwitchActorExit()
	{
		for (int i = 0; i < _switchActorPoseSnapshots.Count; i++)
		{
			SwitchActorPoseSnapshot switchActorPoseSnapshot = _switchActorPoseSnapshots.get_Item(i);
			if (!(null == switchActorPoseSnapshot.actor) && !(null == switchActorPoseSnapshot.interactFurObj) && !switchActorPoseSnapshot.interactFurObj.IsElevator)
			{
				ActorDoInteractiveWithFurObj(switchActorPoseSnapshot.actor, switchActorPoseSnapshot.interactFurObj, placeAtStartImmediately: true, switchActorPoseSnapshot.interactPoint);
			}
		}
		_switchActorPoseSnapshots.Clear();
	}

	private bool IsActorOnStage(DormActor actor)
	{
		if (_switchPointOccupants == null || null == actor)
		{
			return false;
		}
		for (int i = 0; i < _switchPointOccupants.Length; i++)
		{
			if (_switchPointOccupants[i] == actor)
			{
				return true;
			}
		}
		return false;
	}

	private void StopAllFurnitureInteractions()
	{
		if (enInteractiveObjDic == null || enInteractiveObjDic.Count == 0)
		{
			return;
		}
		List<long> list = new List<long>(enInteractiveObjDic.Keys);
		for (int i = 0; i < list.Count; i++)
		{
			DormActor actorById = GetActorById(list.get_Item(i));
			if (null != actorById)
			{
				ActorStopInteractiveWithFurObj(actorById);
			}
		}
	}

	private void SetFloorFurnitureActive(bool active)
	{
		if (null == objCurRoom)
		{
			return;
		}
		IReadOnlyList<DormFurObj> listFurObj = objCurRoom.ListFurObj;
		if (listFurObj == null)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < listFurObj.Count; i++)
		{
			DormFurObj dormFurObj = listFurObj.get_Item(i);
			if (null != dormFurObj && dormFurObj.Type == HotfixEnum.DormFurType.OnFloor)
			{
				dormFurObj.gameObject.SetActive(active);
				flag = true;
			}
		}
		if (flag)
		{
			ForceUpdateNavCuts();
		}
	}

	private void PlayBornTimeline(Scene scene)
	{
		if (null != _bornDirector)
		{
			FinishBornTimeline(_bornDirector, bNotifyLua: false, bSuccess: false);
		}
		if (levelLoadParam == null || !levelLoadParam.bIsGuide)
		{
			return;
		}
		bool bIsMoWangMale = levelLoadParam.bIsMoWangMale;
		string text = (bIsMoWangMale ? "DormBorn_Male" : "DormBorn_Female");
		GameObject gameObject = LoadBornTimelineAsset(text, out var sAssetPath);
		if (null == gameObject)
		{
			NovaLogger.Error("后宅出生演出:加载不到演出预制体[" + sAssetPath + "]，演出跳过!");
			NotifyBornTimelineDone(bSuccess: false);
			return;
		}
		GameObject gameObject2 = new GameObject("__BornTimeline_" + text);
		gameObject2.SetActive(value: false);
		if (scene.IsValid())
		{
			SceneManager.MoveGameObjectToScene(gameObject2, scene);
		}
		gameObject2.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
		GameObject gameObject3 = UnityEngine.Object.Instantiate(gameObject, gameObject2.transform, worldPositionStays: false);
		gameObject3.transform.localPosition = Vector3.zero;
		gameObject3.transform.localRotation = Quaternion.identity;
		if (!gameObject3.TryGetComponent<PlayableDirector>(out var component))
		{
			NovaLogger.Error("后宅出生演出:预制体[" + sAssetPath + "]根节点上没有 PlayableDirector 组件，无法播放!");
			UnityEngine.Object.Destroy(gameObject2);
			NotifyBornTimelineDone(bSuccess: false);
			return;
		}
		BindBornCameraTrack(component, text);
		BindBornActorTrack(component, text);
		_bornDirector = component;
		_bornTimelineNodeGo = gameObject2;
		gameObject2.SetActive(value: true);
		component.Stop();
		component.time = 0.0;
		component.Evaluate();
		component.stopped += OnBornTimelineStopped;
		component.Play();
		GameObject[] rootGameObjects = scene.GetRootGameObjects();
		foreach (GameObject gameObject4 in rootGameObjects)
		{
			if (gameObject4.name == "==== Environment ====")
			{
				_hideNode = gameObject4.transform.Find("Hide");
				if (_hideNode != null)
				{
					_hideNode.gameObject.SetActive(value: false);
				}
				break;
			}
		}
		NovaLogger.Trace(string.Format("后宅出生演出:播放{0}(魔王性别{1})，时长{2:F2}s。", text, bIsMoWangMale ? "男" : "女", component.duration));
	}

	private static GameObject LoadBornTimelineAsset(string sPlayName, out string sAssetPath)
	{
		string text = "Assets/AssetBundles/DormLevel/001/DormLevel_001_Born";
		sAssetPath = text + "/" + sPlayName + ".prefab";
		return MonoSingleton<SceneLoaderController>.Instance.LoadAsset(text, sAssetPath, typeof(GameObject)) as GameObject;
	}

	private void OnBornTimelineStopped(PlayableDirector director)
	{
		FinishBornTimeline(director, bNotifyLua: true, bSuccess: true);
	}

	private void FinishBornTimeline(PlayableDirector director, bool bNotifyLua, bool bSuccess)
	{
		if (null != director)
		{
			director.stopped -= OnBornTimelineStopped;
		}
		if (null != _bornPerformAnimatorTrans)
		{
			_bornPerformAnimatorTrans.localPosition = _bornPerformAnimatorLocalPos;
			_bornPerformAnimatorTrans.localRotation = _bornPerformAnimatorLocalRot;
			_bornPerformAnimatorTrans = null;
		}
		if (null != _bornTimelineNodeGo)
		{
			UnityEngine.Object.Destroy(_bornTimelineNodeGo);
			_bornTimelineNodeGo = null;
		}
		if (null != _bornPerformActor)
		{
			_bornPerformActor.ResetToSpawnState();
			_bornPerformActor = null;
		}
		_bornDirector = null;
		if (_hideNode != null)
		{
			_hideNode.gameObject.SetActive(value: true);
		}
		if (bSuccess)
		{
			NovaLogger.Trace("后宅出生演出:播放结束，已销毁演出实例并交还魔王控制权。");
		}
		else
		{
			NovaLogger.Trace("后宅出生演出:未播完即收尾（打断或失败）。");
		}
		if (bNotifyLua)
		{
			NotifyBornTimelineDone(bSuccess);
		}
	}

	private static void NotifyBornTimelineDone(bool bSuccess)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("DORM_CS2LUA_BORN_TIMELINE_DONE", bSuccess);
	}

	private static void BindBornCameraTrack(PlayableDirector director, string sTimelineName)
	{
		CinemachineBrain mainCameraBrain = MonoSingleton<GameCameraStackManager>.Instance.mainCameraBrain;
		if (null == mainCameraBrain)
		{
			NovaLogger.Error("后宅出生演出:主相机上没有 CinemachineBrain，" + sTimelineName + "的镜头无法接管画面!");
		}
		else if (!director.SetGenericBinding("CAMERA", mainCameraBrain))
		{
			NovaLogger.Error("后宅出生演出:" + sTimelineName + "里找不到名为[CAMERA]的相机轨道，镜头不会接管画面!请把该 timeline 的 Cinemachine 轨道改名为 CAMERA(项目约定)。");
		}
	}

	private void BindBornActorTrack(PlayableDirector director, string sTimelineName)
	{
		Animator animator = director.GetGenericBinding("ACTOR") as Animator;
		if (null == animator)
		{
			NovaLogger.Error("后宅出生演出:" + sTimelineName + "里找不到名为[ACTOR]的角色轨道(或其绑定不是 Animator)，演出角色无法改绑到真魔王。请把该 timeline 的 Animation 轨道改名为 ACTOR(项目约定)。");
			return;
		}
		DormPlayer dormPlayer = MonoSingleton<DormPlayerController>.Instance?.Player;
		if (null == dormPlayer)
		{
			NovaLogger.Error("后宅出生演出:拿不到魔王实例，" + sTimelineName + "只能用预制体自带的模型播。");
			return;
		}
		Animator animator2 = dormPlayer.animator;
		if (null == animator2)
		{
			NovaLogger.Error("后宅出生演出:魔王身上没有 Animator，" + sTimelineName + "只能用预制体自带的模型播。");
		}
		else if (!(animator == animator2))
		{
			dormPlayer.SuspendForPerform();
			_bornPerformActor = dormPlayer;
			MovePerformActorTo(dormPlayer, animator2.transform, animator.transform);
			_bornPerformAnimatorTrans = animator2.transform;
			_bornPerformAnimatorLocalPos = animator2.transform.localPosition;
			_bornPerformAnimatorLocalRot = animator2.transform.localRotation;
			director.SetGenericBinding("ACTOR", animator2);
			animator.gameObject.SetActive(value: false);
		}
	}

	private void MovePerformActorTo(DormActor actor, Transform actorAnimatorTrans, Transform bornAnimatorTrans)
	{
		if (TryGetSceneSpawnPoint(out var pos, out var yaw))
		{
			actor.SyncMovementLocation(new TSVector2(pos.x, pos.z), pos.y);
			actor.SyncRotation(yaw);
			NovaLogger.Trace($"后宅出生演出:魔王已对准场景出生点 {pos}(朝向 y={yaw:F1})。");
			return;
		}
		Vector3 vector = bornAnimatorTrans.position - actorAnimatorTrans.position;
		Vector3 vector2 = actor.transform.position + vector;
		float num = actor.transform.eulerAngles.y + Mathf.DeltaAngle(actorAnimatorTrans.eulerAngles.y, bornAnimatorTrans.eulerAngles.y);
		actor.SyncMovementLocation(new TSVector2(vector2.x, vector2.z), vector2.y);
		actor.SyncRotation(num);
		NovaLogger.Trace($"后宅出生演出:场景没铺 spawnpoint，按自带模型反推把魔王搬到 {vector2}(朝向 y={num:F1})。");
	}
}
