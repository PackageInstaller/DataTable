using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Sound;
using ACT.Timeline;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.Collections;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using EasyCharacterMovement;
using Fundamental;
using PathFinding2D.Runtime.Models;
using Pb;
using Runtime.Archive;
using Runtime.Battle.ChaseBattle;
using Runtime.Model;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.EnhancedTouch;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.UI;
using UnityEngine.InputSystem.Users;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Profiling;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class MonoECS : MonoBehaviour
{
	public enum CompositeMode
	{
		Unknown,
		NoComposite,
		OneModifier
	}

	private class InputDeviceData
	{
		public readonly InputDevice InputDevice;

		public double LastInputTime;

		public InputDeviceData(InputDevice device, double updateTime = 0.0)
		{
			InputDevice = device;
			LastInputTime = updateTime;
		}
	}

	public enum PromptIconDeviceType
	{
		Unknown,
		KeyboardAndMouse,
		Gamepad
	}

	[Serializable]
	internal struct BindingOverrideListJson
	{
		public List<BindingOverrideJson> bindings;
	}

	[Serializable]
	internal struct BindingOverrideJson
	{
		public string action;
	}

	public static class InputGroup
	{
		public static string UI = "UI";

		public static string Player = "Player";

		public static string StateObject = "StateObject";
	}

	[Flags]
	public enum PlayerTag
	{
		Battle = 1,
		Interacting = 2,
		Timeline = 4,
		MovingPath = 8,
		BackTrace = 0x10,
		CameraMoving = 0x20,
		TeleportMove = 0x40,
		TeleportRespawnAndTpMove = 0x80,
		PathSwitchMove = 0x100,
		CharacterUltraTimeline = 0x200
	}

	public enum ControlType
	{
		Character,
		Robot,
		OreCar
	}

	private struct PlayerSyncData
	{
		public readonly CharacterStatusSyncData[] CharacterStatuses;

		public Vector3 Position { get; private set; }

		public int BattleCharacterId { get; private set; }

		public int CharacterStatusCount { get; private set; }

		public PlayerSyncData(int teamSize)
		{
			Position = Vector3.zero;
			BattleCharacterId = 0;
			CharacterStatusCount = 0;
			CharacterStatuses = new CharacterStatusSyncData[teamSize];
		}

		public void SetBattleCharacterId(int characterId)
		{
			BattleCharacterId = characterId;
		}

		public void SetInitialPosition(Vector3 spawnPosition)
		{
			Position = spawnPosition;
		}

		public void UpdatePosition(Vector3 position)
		{
			Position = position;
		}

		public void AddCharacterStatus(in CharacterStatusSyncData status)
		{
			if (CharacterStatusCount < CharacterStatuses.Length)
			{
				CharacterStatuses[CharacterStatusCount++] = status;
			}
		}

		public void ResetCharacterStatuses()
		{
			CharacterStatusCount = 0;
		}
	}

	private readonly struct CharacterStatusSyncData(int characterId, int hp, float exPower, float assistPower, float energyPower)
	{
		public readonly int CharacterId = characterId;

		public readonly int Hp = hp;

		public readonly float ExPower = exPower;

		public readonly float AssistPower = assistPower;

		public readonly float EnergyPower = energyPower;
	}

	public struct FlexibleParams
	{
		public Shape shape;

		public Vector2 size;

		public Vector3 boxSize;

		public Vector3 offest;

		public AbilityEntityType type;

		public TrajectoryTag tag;

		public string ignoreEnvironmentCollisionTag;

		public bool checkEnvAndResolve;

		public int hp;

		public bool showUI;

		public bool cantBeAttack;

		public FilterEntityType beHitFilter;

		public bool destroyOtherBulletOnBeHit;

		public Vector3 aimPos;

		public Quaternion aimRotation;

		public ConfigTrajectory trajectory;

		public ConfigTrajectoryObject configTrajectoryObject;

		public TrajectoryMovementPattern movementPattern;

		public float OverlapThreshold;

		public float VelocityOverlapDistance;

		public UnityAction<Entity> onCreate;

		public Action<Entity> onDie;
	}

	public struct LaserParams
	{
		public AllianceCondition alliance;

		public FilterEntityType filterEntityType;

		public FilterCantBeAttackType filterCantBeAttackType;

		public bool canBeAttack;

		public ConfigAction[] onTriggerEnter;

		public ConfigAction[] onTriggerStay;

		public ConfigAction[] onTriggerExit;

		public Vector2 size;

		public Entity owner;

		public Ability ability;

		public YooAssetReference effectAsset;

		public Vector3 posOffset;

		public Vector3 directionOffset;

		public float maxLength;

		public float runtimeLength;

		public float radius;

		public LayerMask colliderLayer;
	}

	protected uint m_IDIncreaser;

	protected uint m_TriggerGroupId;

	private EntityLocal _entityLocal;

	private EntityFactory _factory;

	[SerializeField]
	private MouseCursorEffectSetting _cursorEffectSetting = new MouseCursorEffectSetting();

	public Action<Entity> onClawAction;

	[SerializeField]
	private ButtonPromptTextureBindingConfig _buttonPromptTextureBindingConfig;

	[SerializeField]
	private ButtonBindingPathConfig _buttonBindingPathConfig;

	private static readonly Keyboard PromptKeyboard = new Keyboard();

	private const string GamepadNorthButton = "gamepad/north";

	private const string GamepadEastButton = "gamepad/east";

	private const string GamepadSouthButton = "gamepad/south";

	private const string GamepadWestButton = "gamepad/west";

	private static readonly Dictionary<string, string> SwitchProControllerBindingReverseMap = new Dictionary<string, string>
	{
		{ "gamepad/north", "gamepad/west" },
		{ "gamepad/west", "gamepad/north" },
		{ "gamepad/south", "gamepad/east" },
		{ "gamepad/east", "gamepad/south" }
	};

	private ACTInputActions _inputActions;

	private Dictionary<InputDevice, InputDeviceData> _activeInputDeviceMap;

	private List<InputDeviceData> _deviceDataCache;

	private bool _activeDeviceIsChanged;

	private bool _refreshInputDevicePairingInLateUpdate;

	private bool _inputDeviceChangeSubscribed;

	private readonly HashSet<InputDevice> _pendingInvalidInputDevices = new HashSet<InputDevice>();

	private readonly Dictionary<InputDevice, int> _deviceAddedFrame = new Dictionary<InputDevice, int>();

	private readonly HashSet<InputDevice> _switchProMirrorDevices = new HashSet<InputDevice>();

	private const int SwitchProMirrorConnectionFrameWindow = 10;

	private const double SwitchProMirrorUpdateTimeWindow = 0.01;

	private bool _pairingRetryPending;

	private bool _inputDevicePairingBlocked;

	private bool _applicationFocusChangeSubscribed;

	private int _focusRestoreFrame = -1;

	private bool _inputModeFocusLocked;

	private DeviceInputMode _focusInputMode;

	private InputDevice _focusActiveInputDevice;

	private static readonly MethodInfo DeferBindingResolutionMethod = typeof(InputActionRebindingExtensions).GetMethod("DeferBindingResolution", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, Type.EmptyTypes, null);

	private static readonly PropertyInfo NativeDeviceIdProperty = typeof(InputDevice).GetProperty("nativeDeviceId", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);

	private static bool _deferBindingResolutionUnavailableLogged;

	private List<Type> _ignoredDeviceType;

	public readonly UnityEvent<DeviceInputMode> onInputModeChange = new UnityEvent<DeviceInputMode>();

	private DeviceInputMode _inputMode;

	public readonly UnityEvent<ScreenSizeMode> onScreenSizeChange = new UnityEvent<ScreenSizeMode>();

	private int _lastScreenWidth;

	private int _lastScreenHeight;

	private Dictionary<string, InputActionMap> _actionMaps;

	private Dictionary<string, InputAction> _actionDict;

	private Dictionary<Guid, Action<InputAction.CallbackContext>> _callbackBinding;

	private List<InputAction> _allActions;

	private InputAction _inputActionUINavigate;

	private InputAction _inputActionPlayerMove;

	[SerializeField]
	private int LargeSizeScreenFactor = 7;

	private static readonly MethodInfo InputModuleResetPointersMethod = typeof(InputSystemUIInputModule).GetMethod("ResetPointers", BindingFlags.Instance | BindingFlags.NonPublic, null, Type.EmptyTypes, null);

	private static bool _resetInputModulePointersUnavailableLogged;

	private readonly Dictionary<InputAction, InputActionReference> _inputActionRefDict = new Dictionary<InputAction, InputActionReference>();

	private const string OnDeviceRemoved = "[InputPairing] On InputSystem Device Removed: {0}";

	private const string OnDeviceConnect = "[InputPairing] On InputSystem Device Connect: {0}";

	private ReadOnlyArray<InputDevice> knownDevices;

	private static readonly Comparison<InputDeviceData> _deviceComparison = SortDeviceData;

	private const string BindingPathPatten = "\\<(\\w+)\\>\\/(.+)";

	private const string GuideBindingPathPatten = "guide_";

	private const string GuideMoveLeftBindingPath = "guide_move_left";

	private const string GuideMoveRightBindingPath = "guide_move_right";

	private const string GuideMoveUpBindingPath = "guide_move_up";

	private const string GuideMoveDownBindingPath = "guide_move_down";

	private const string GuideGamepadLeftStickLeft = "gamepad_leftstickleft";

	private const string GuideGamepadLeftStickRight = "gamepad_leftstickright";

	private const string GuideGamepadLeftStickUp = "gamepad_leftstickup";

	private const string GuideGamepadLeftStickDown = "gamepad_leftstickdown";

	private const string GuideKeyboardMoveLeftAction = "Move/Left";

	private const string GuideKeyboardMoveRightAction = "Move/Right";

	private const string GuideKeyboardMoveUpAction = "Move/Up";

	private const string GuideKeyboardMoveDownAction = "Move/Down";

	private const string Keyboard = "keyboard";

	private const string Gamepad = "gamepad";

	private int m_PauseInputRef;

	private int _pauseUIInputRef;

	private static readonly Type FloatType = typeof(float);

	private int curLevel = 3;

	private static MonoECS _instance;

	private ServerNetworkController _serverNetworkController = new ServerNetworkController();

	[SerializeField]
	[Range(10f, 500f)]
	private float _maxStaticSceneBlockClipDistance = 100f;

	[SerializeField]
	[Range(1f, 25f)]
	private float _updateStaticSceneBlockDistance = 5f;

	[Range(1f, 500f)]
	public float _gcInterval = 5f;

	[Range(1f, 10000f)]
	public int _gcCountLimit = 1000;

	private bool m_Running;

	private bool m_NeedChange;

	private bool m_RunningTarget;

	private bool m_CouldPause;

	private int m_PauseRef;

	public int m_PauseInteractRef;

	private CustomSampler[] m_FixedUpdateSystemMarkers;

	public RuleManager ruleManager;

	public CheckPointManager checkPointManager;

	public RaidListenerManager raidListenerManager;

	public DamageStatisticsManager damageStatisticsManager;

	public ChTimeStatisticsManager chTimeStatisticsManager;

	public ReviewPromptManager reviewPromptManager;

	public AIContextManager aiContextManager;

	public OnceCollectionManager onceCollectionManager;

	public TriggerManager triggerManager;

	public GameObject playerWrapPrefab;

	private static readonly WaitForFixedUpdate WaitForFixedUpdate = new WaitForFixedUpdate();

	private const int m_Count = 3;

	private int m_Timer;

	private string _aid;

	private int _playerLevel;

	public const string BATTLE_PREFAB_PRE = "BattlePrefab/";

	public const int teamEntityCount = 3;

	private PlayState m_PlayState;

	public ActionList<PlayState, PlayState> playerStateChange = new ActionList<PlayState, PlayState>();

	[HideInInspector]
	public AudioEventReference audioBattleMusic;

	private PlayerTag m_PlayerTag;

	public Action onStartWorld;

	public const string cantBeAttackAbility = "Rogueability_list_assistSkill_wudi";

	private int m_initMask;

	private List<Renderer> characterRender = new List<Renderer>();

	private ControlType m_ControlType;

	private Dictionary<SceneRootType, GameObject> rootDic = new Dictionary<SceneRootType, GameObject>();

	private Transform _rootsParent;

	private static readonly SceneRootType[] AllRootTypes = (SceneRootType[])Enum.GetValues(typeof(SceneRootType));

	private static readonly int WeaponAnimExit = Animator.StringToHash("weaponAnimExit");

	private const float AutoSyncInterval = 2f;

	public long pingTimeOffset;

	private bool isSyncCharacterStatus;

	private PlayerSyncData _playerSyncData = new PlayerSyncData(3);

	private SyncGameInfoReq _lastSyncedComparableRequest;

	private static readonly HashSet<SceneStatus> DisableSyncSceneStatus = new HashSet<SceneStatus> { SceneStatus.Lounge };

	public bool IsLoadSubScene;

	private Looper loopframe;

	private System.DateTime dungeonStartTime;

	private System.DateTime characterTutorialStartTime;

	private ACT.World.MapArea mainWorldPartitionbeforeEnter;

	public int openCharacterViewType = -1;

	private List<Entity> m_tgMonsters = new List<Entity>();

	private System.DateTime trainingGroundEnterTime;

	private bool _teamLoadCompleted;

	public static string DummyTag = "Hitable";

	public Entity mainEntity
	{
		get
		{
			if (localPlayer != null && localPlayer.battleEntity.IsValid)
			{
				return localPlayer.battleEntity;
			}
			return default;
		}
	}

	public EntityLocal entityLocal => _entityLocal;

	public int MainEntityCharacterId
	{
		get
		{
			if (!localPlayer.battleEntity.IsValid)
			{
				return int.MinValue;
			}
			return localPlayer.battleEntity.GetCompCharacter().characterSource.Id();
		}
	}

	public EntityId mainEntityId
	{
		get
		{
			if (localPlayer.battleEntity.IsValid)
			{
				return localPlayer.battleEntity.Id;
			}
			return EntityId.Invalid;
		}
	}

	public int battleEntityIndex => localPlayer.battleEntityIndex;

	public bool ispc => GameLoader.IsPCMode;

	public bool hideCursor => GameLoader.NeedHideCursor;

	public InputDevice activeInputDevice { get; private set; }

	public DeviceInputMode InputMode
	{
		get
		{
			return _inputMode;
		}
		private set
		{
			if (!object.Equals(value, _inputMode))
			{
				_inputMode = value;
				onInputModeChange?.Invoke(value);
			}
		}
	}

	public ScreenSizeMode DeviceScreenType { get; private set; }

	public string ScreenInfo { get; private set; }

	public InputActionAsset inputActionAsset { get; private set; }

	public PlayerInput playerInput { get; private set; }

	public InputSystemUIInputModule inputModule { get; private set; }

	public EventSystem eventSystem { get; private set; }

	public bool IsAppInFocus { get; private set; }

	public UnityEvent<ReadOnlyArray<InputDevice>> OnActiveDeviceChange { get; } = new UnityEvent<ReadOnlyArray<InputDevice>>();

	public bool couldInput
	{
		get
		{
			return Singleton<GameManager>.instance.ecsManager.systemInput.CouldInput;
		}
		private set
		{
			Singleton<GameManager>.instance.ecsManager.systemInput.CouldInput = value;
		}
	}

	public static MonoECS instance => _instance;

	public float MaxStaticSceneBlockClipDistance => _maxStaticSceneBlockClipDistance;

	public float UpdateStaticSceneBlockDistance => _updateStaticSceneBlockDistance;

	private bool CouldControlEntity => GameManager.inputSystem?.CouldInput ?? false;

	public bool running
	{
		get
		{
			return m_Running;
		}
		protected set
		{
			if (!m_CouldPause)
			{
				m_Running = true;
				GameManager.timeSystem.ChangeLogicSpeed(pause: false);
			}
			else if (value != m_RunningTarget)
			{
				if (value == m_Running)
				{
					m_NeedChange = false;
				}
				else
				{
					m_NeedChange = true;
				}
				m_RunningTarget = value;
				GameManager.timeSystem.ChangeLogicSpeed(!m_RunningTarget);
			}
		}
	}

	public bool couldPause
	{
		get
		{
			return m_CouldPause;
		}
		set
		{
			if (value != m_CouldPause)
			{
				m_CouldPause = value;
				if (!m_CouldPause)
				{
					running = true;
				}
				else if (m_PauseRef > 0)
				{
					running = false;
				}
			}
		}
	}

	public MPPlayer localPlayer { get; protected set; }

	public PlayState playState
	{
		get
		{
			return m_PlayState;
		}
		set
		{
			if (m_PlayState != value)
			{
				playerStateChange?.Invoke(m_PlayState, value);
				m_PlayState = value;
			}
		}
	}

	public SceneStatus sceneStatus
	{
		get
		{
			return G.localPlayer.Profile.SceneStatus;
		}
		set
		{
			G.localPlayer.Profile.SceneStatus = value;
			SceneChangeEvt evt = Singleton<EventManager>.instance.GetEvt<SceneChangeEvt>();
			evt.newScene = value;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Scene_Change, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public SceneStatus clientSceneStatus { get; private set; }

	public bool IsTimelineTP => TPToPositionSignalAction.IsTimelineTP;

	public bool isStartWorld { get; private set; }

	public ControlType PlayerControlType
	{
		get
		{
			return m_ControlType;
		}
		set
		{
			m_ControlType = value;
			ControlTypeChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ControlTypeChangeEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ControlType_Change, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public bool IsPlayingVibration { get; set; }

	public bool CouldLoadScene
	{
		get
		{
			if (IsPlayingVibration)
			{
				return false;
			}
			if (instance.InPlayerTag(PlayerTag.CameraMoving))
			{
				return false;
			}
			if (instance.InPlayerTag(PlayerTag.Timeline))
			{
				return instance.IsTimelineTP;
			}
			return true;
		}
	}

	private bool ShouldUseMainWorldPositionForSync => IsInTrainingground;

	private bool ShouldSyncTeleportPathCenter
	{
		get
		{
			if (!Singleton<TeleportMoveManager>.instance.ForcePathCenterSync)
			{
				return instance.HasAnyPlayerTag(PlayerTag.TeleportMove | PlayerTag.TeleportRespawnAndTpMove);
			}
			return true;
		}
	}

	public bool IsNotInMain => sceneStatus != SceneStatus.Main;

	public bool IsInAbyss => sceneStatus == SceneStatus.Abyss;

	public bool IsInRogue => sceneStatus == SceneStatus.Rogue;

	public bool IsInTrainingground => sceneStatus == SceneStatus.Trainingground;

	public bool IsInTemple => sceneStatus == SceneStatus.Temple;

	public List<Entity> TgMonsters => m_tgMonsters;

	public event Action<bool> OnApplicationFocusChanged;

	public uint GetNewTriggerGroupId()
	{
		m_TriggerGroupId++;
		return m_TriggerGroupId;
	}

	private void ChangeLogicSpeed(bool pause)
	{
		GameManager.timeSystem.ChangeLogicSpeed(pause);
	}

	private void InitECS()
	{
		Singleton<GameManager>.instance.ecsManager.InitSystems();
	}

	public Entity GetEntity(EntityId id)
	{
		return GameManager.entities.GetEntity(id);
	}

	public bool IsMainEntity(Entity entity)
	{
		if (entity.IsValid)
		{
			return entity == mainEntity;
		}
		return false;
	}

	private void InitInput()
	{
		playerInput = GetComponent<PlayerInput>();
		inputModule = GetComponent<InputSystemUIInputModule>();
		eventSystem = GetComponent<EventSystem>();
		EnhancedTouchSupport.Enable();
		InputSystem.settings.shortcutKeysConsumeInput = false;
		InitInputActions(inputModule, playerInput);
		CheckScreenSizeChange();
		BindInputActions();
		SetActionMapEnable(InputGroup.UI, enable: true);
		SetActionMapEnable(InputGroup.Player, enable: true);
		InitPointCursor();
	}

	public void InitPointCursor()
	{
		Singleton<GameInputActionManager>.instance.InitCursor(ispc, hideCursor, _cursorEffectSetting, playerInput);
	}

	public bool IsGamePadMode()
	{
		return InputMode != DeviceInputMode.KeyboardAndMouse;
	}

	public ButtonBindingPathConfig.ButtonBindingPath GetInputBindingPath(string inputActionName, ButtonBindingPathConfig.ButtonBindingSolution solution)
	{
		return _buttonBindingPathConfig.GetButtonBindingPath(inputActionName, solution);
	}

	private PromptIconDeviceType GetInputDeviceType()
	{
		return InputMode switch
		{
			DeviceInputMode.KeyboardAndMouse => PromptIconDeviceType.KeyboardAndMouse, 
			DeviceInputMode.Gamepad => PromptIconDeviceType.Gamepad, 
			_ => PromptIconDeviceType.Unknown, 
		};
	}

	internal InputDevice GetPromptIconDevice()
	{
		if (InputMode == DeviceInputMode.Gamepad)
		{
			return activeInputDevice;
		}
		if (InputMode == DeviceInputMode.KeyboardAndMouse)
		{
			return PromptKeyboard;
		}
		return null;
	}

	private static string CorrectPromptIconBindingKeyNameByActiveDevice(string bindingName)
	{
		if (!string.IsNullOrEmpty(bindingName) && IsSwitchProDevice(instance.GetPromptIconDevice()) && SwitchProControllerBindingReverseMap.TryGetValue(bindingName, out var value))
		{
			bindingName = value;
		}
		return bindingName;
	}

	public void GetInputBindingIcon(string bindingName, OnButtonPromptTextureLoaded onGetInputDeviceButtonIcon)
	{
		_buttonPromptTextureBindingConfig?.GetInputDeviceButtonIconAsync(bindingName, GetPromptIconDevice(), onGetInputDeviceButtonIcon);
	}

	public bool GetInputDeviceButtonBindingKeyName(string bindingAction, out string bindingKeyName)
	{
		bindingKeyName = null;
		if (string.IsNullOrEmpty(bindingAction))
		{
			return false;
		}
		if (CorrectGuideBindingPath(bindingAction, out var type, out bindingKeyName))
		{
			return true;
		}
		bindingAction = bindingAction.Trim();
		string inputActionName = bindingAction.Split("/", 2).LastOrDefault();
		PromptIconDeviceType inputDeviceType = GetInputDeviceType();
		GetPromptIconDevice();
		ButtonBindingPathConfig.ButtonBindingPath buttonBindingPath = null;
		buttonBindingPath = ((inputDeviceType != PromptIconDeviceType.Gamepad) ? GetInputBindingPath(inputActionName, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1) : GetInputBindingPath(inputActionName, ButtonBindingPathConfig.ButtonBindingSolution.Gamepad));
		string text = string.Empty;
		if (buttonBindingPath != null)
		{
			InputAction inputAction = _inputActions.FindAction(buttonBindingPath.InputActionPath);
			if (buttonBindingPath.InputBindingIndex < inputAction.bindings.Count)
			{
				text = inputAction.bindings[buttonBindingPath.InputBindingIndex].effectivePath;
			}
			else
			{
				Debug.LogError($"ACTInputAction 中 \"{buttonBindingPath.InputActionPath}\" 配置错误!!! 提示图标的绑定索引 '{buttonBindingPath.InputBindingIndex}' 超出该Action的绑定数量，请检查配置!!!!");
				text = inputAction.bindings[0].effectivePath;
			}
		}
		GameInputActionManager.ActionKeyBindingInfo bindingInfo = null;
		if (string.IsNullOrEmpty(text))
		{
			if (!Singleton<GameInputActionManager>.instance.TryGetInputActionKeyBindingInfo(inputDeviceType, bindingAction, out bindingInfo))
			{
				return false;
			}
			bindingKeyName = bindingInfo.GetKeyBinding(-1);
		}
		else
		{
			CorrectBindingPath(text, out type, out bindingKeyName);
		}
		if (inputDeviceType == PromptIconDeviceType.Gamepad)
		{
			bindingKeyName = CorrectPromptIconBindingKeyNameByActiveDevice(bindingKeyName);
		}
		return true;
	}

	public bool TryGetInputActionKeyBindingInfo(string bindingAction, out GameInputActionManager.ActionKeyBindingInfo bindingInfo)
	{
		bindingInfo = null;
		return TryGetInputActionKeyBindingInfo(GetInputDeviceType(), bindingAction, out bindingInfo);
	}

	public bool CheckInputActionIsModifierMode(string bindingAction)
	{
		return CheckInputActionIsModifierMode(GetInputDeviceType(), bindingAction);
	}

	public bool TryGetInputActionKeyBindingInfo(PromptIconDeviceType deviceType, string bindingAction, out GameInputActionManager.ActionKeyBindingInfo bindingInfo)
	{
		bindingInfo = null;
		return Singleton<GameInputActionManager>.instance.TryGetInputActionKeyBindingInfo(deviceType, bindingAction, out bindingInfo);
	}

	public bool CheckInputActionIsModifierMode(PromptIconDeviceType deviceType, string bindingAction)
	{
		if (Singleton<GameInputActionManager>.instance.TryGetInputActionKeyBindingInfo(deviceType, bindingAction, out var bindingInfo))
		{
			return bindingInfo.GetMode() == CompositeMode.OneModifier;
		}
		return false;
	}

	public void GetInputDeviceButtonIconAsync(string bindingAction, OnButtonPromptTextureLoaded onGetInputDeviceButtonIcon)
	{
		InputDevice promptIconDevice = GetPromptIconDevice();
		if (!GetInputDeviceButtonBindingKeyName(bindingAction, out var bindingKeyName))
		{
			onGetInputDeviceButtonIcon?.Invoke(success: false, null, promptIconDevice);
		}
		else
		{
			GetKeyIconAsync(bindingKeyName, promptIconDevice, onGetInputDeviceButtonIcon);
		}
	}

	public void GetKeyIconAsync(string bindingPath, OnButtonPromptTextureLoaded onGetInputDeviceButtonIcon)
	{
		GetKeyIconAsync(bindingPath, GetPromptIconDevice(), onGetInputDeviceButtonIcon);
	}

	public void GetKeyIconAsync(string bindingPath, InputDevice device, OnButtonPromptTextureLoaded onGetInputDeviceButtonIcon)
	{
		_buttonPromptTextureBindingConfig?.GetInputDeviceButtonIconAsync(bindingPath, device, onGetInputDeviceButtonIcon);
	}

	public bool TryGetInputAction(string actionName, out InputAction action)
	{
		return _actionDict.TryGetValue(actionName, out action);
	}

	private void CheckScreenSizeChange()
	{
		if (Screen.width != _lastScreenWidth || Screen.height != _lastScreenHeight)
		{
			_lastScreenWidth = Screen.width;
			_lastScreenHeight = Screen.height;
			float dpi = Screen.dpi;
			float num = Mathf.Sqrt(Mathf.Pow((float)_lastScreenWidth / dpi, 2f) + Mathf.Pow((float)_lastScreenHeight / dpi, 2f));
			ScreenInfo = $"[Screen:{_lastScreenWidth}x{_lastScreenHeight} @ dpi:{dpi}] => inch: {num}";
			ScreenSizeMode screenSizeMode = ((!(num > (float)LargeSizeScreenFactor)) ? ScreenSizeMode.SmallScreen : ScreenSizeMode.LargeScreen);
			if (DeviceScreenType != screenSizeMode)
			{
				DeviceScreenType = screenSizeMode;
				onScreenSizeChange?.Invoke(screenSizeMode);
			}
		}
	}

	private void InitInputActions(InputSystemUIInputModule inputModule, PlayerInput playerInput)
	{
		ACTInputActions aCTInputActions = (_inputActions = new ACTInputActions());
		inputActionAsset = aCTInputActions.asset;
		if (ispc)
		{
			_inputActions.UI.Point.wantsInitialStateCheck = true;
		}
		_activeInputDeviceMap = new Dictionary<InputDevice, InputDeviceData>();
		_deviceDataCache = new List<InputDeviceData>();
		_pendingInvalidInputDevices.Clear();
		_deviceAddedFrame.Clear();
		_switchProMirrorDevices.Clear();
		_pairingRetryPending = false;
		_inputDevicePairingBlocked = false;
		inputModule.actionsAsset = aCTInputActions.asset;
		inputModule.move = null;
		inputModule.submit = null;
		inputModule.cancel = null;
		SetInputModuleBindingActive(active: true);
		inputModule.ActivateModule();
		inputModule.pointerBehavior = UIPointerBehavior.SingleMouseOrPenButMultiTouchAndTrack;
		playerInput.actions = aCTInputActions.asset;
		playerInput.uiInputModule = inputModule;
		playerInput.notificationBehavior = PlayerNotifications.InvokeUnityEvents;
		playerInput.ActivateInput();
		Dictionary<string, InputAction> dictionary = new Dictionary<string, InputAction>();
		foreach (InputActionMap actionMap in _inputActions.asset.actionMaps)
		{
			string text = actionMap.name;
			foreach (InputAction action in actionMap.actions)
			{
				string key = text + "/" + action.name;
				dictionary[key] = action;
			}
			actionMap.actionTriggered += OnActionTrigger;
			actionMap.Enable();
		}
		InitAutoDisableActions(dictionary);
		_ignoredDeviceType = new List<Type> { typeof(UnityEngine.InputSystem.Sensor) };
		SubscribeInputDeviceChange();
		SubscribeApplicationFocusChange();
		RefreshInputDevicePairing();
		RefreshActionMapDevice();
	}

	private void InitAutoDisableActions(Dictionary<string, InputAction> actionDict)
	{
		actionDict.Remove("UI/Navigate", out _inputActionUINavigate);
		actionDict.Remove("Player/Move", out _inputActionPlayerMove);
		actionDict.Remove("UI/Point");
		actionDict.Remove("UI/Click");
		actionDict.Remove("UI/MiddleClick");
		actionDict.Remove("UI/RightClick");
		actionDict.Remove("UI/ScrollWheel");
		actionDict.Remove("UI/ScrollViewRightStickControl");
		actionDict.Remove("UI/GM");
		actionDict.Remove("UI/GMConsole");
		actionDict.Remove("Guide/ClickFinshGuideStep");
		actionDict.Remove("Guide/ClickSkipGuide");
		actionDict.Remove("UI/GamePadNavigate");
		actionDict.Remove("UI/RightStickNavigate");
		_allActions = actionDict.Values.ToList();
	}

	internal void SetPlayerInputMapActive(bool active)
	{
		if (active)
		{
			_inputActionPlayerMove.Enable();
			_inputActionUINavigate.Disable();
		}
		else
		{
			_inputActionPlayerMove.Disable();
			_inputActionUINavigate.Enable();
			Singleton<GameInputActionManager>.instance.ResetCurrentPlayerInput();
		}
	}

	internal void UpdateActiveInputActions(HashSet<InputAction> activeActions)
	{
		foreach (InputAction allAction in _allActions)
		{
			if (activeActions.Contains(allAction))
			{
				allAction.Enable();
			}
			else
			{
				allAction.Disable();
			}
		}
	}

	internal void SetInputModuleBindingActive(bool active)
	{
		inputModule.point = (active ? GetOrCreateInputActionRef(_inputActions.UI.Point) : null);
		inputModule.leftClick = (active ? GetOrCreateInputActionRef(_inputActions.UI.Click) : null);
		inputModule.middleClick = (active ? GetOrCreateInputActionRef(_inputActions.UI.MiddleClick) : null);
		inputModule.rightClick = (active ? GetOrCreateInputActionRef(_inputActions.UI.RightClick) : null);
		inputModule.scrollWheel = GetOrCreateInputActionRef(_inputActions.UI.ScrollWheel);
	}

	internal bool SetUIMousePointerActive(bool active)
	{
		SetInputModuleBindingActive(active);
		EnsureUIPointActionEnabled();
		if (active)
		{
			return true;
		}
		return ResetInputModulePointerStates();
	}

	private void EnsureUIPointActionEnabled()
	{
		InputAction inputAction = _inputActions?.UI.Point;
		if (inputAction != null && !inputAction.enabled)
		{
			inputAction.Enable();
		}
	}

	private bool ResetInputModulePointerStates()
	{
		if (inputModule == null)
		{
			return false;
		}
		if (InputModuleResetPointersMethod == null)
		{
			if (!_resetInputModulePointersUnavailableLogged)
			{
				_resetInputModulePointersUnavailableLogged = true;
				Debug.LogError("InputSystemUIInputModule.ResetPointers 不存在，指针状态无法清理，鼠标 hover 只能靠调用方兜底；请检查 Input System 版本。");
			}
			return false;
		}
		InputModuleResetPointersMethod.Invoke(inputModule, null);
		return true;
	}

	public InputActionReference GetOrCreateInputActionRef(InputAction action)
	{
		if (!_inputActionRefDict.TryGetValue(action, out var value))
		{
			value = InputActionReference.Create(action);
			_inputActionRefDict[action] = value;
		}
		return value;
	}

	private void OnActionTrigger(InputAction.CallbackContext ctx)
	{
		if (!ctx.performed || !Application.isFocused || IsSyntheticPointerInput(ctx))
		{
			return;
		}
		InputControl control = ctx.control;
		if (control == null)
		{
			return;
		}
		InputDevice device = control.device;
		if (control.EvaluateMagnitude() < 0.5f || !IsUsableInputDevice(device) || !_activeInputDeviceMap.TryGetValue(device, out var value))
		{
			return;
		}
		double num = ctx.time;
		if (double.IsNaN(num) || double.IsInfinity(num))
		{
			num = Time.realtimeSinceStartupAsDouble;
		}
		if (device is Touchscreen)
		{
			value.LastInputTime = num - 0.10000000149011612;
		}
		else
		{
			value.LastInputTime = num;
		}
		_inputModeFocusLocked = false;
		if (!IsInputModeChangeBlockedByGuide())
		{
			if (device is Gamepad)
			{
				ChangeInputMode(DeviceInputMode.Gamepad, device);
			}
			else if (device is Keyboard || device is Mouse)
			{
				ChangeInputMode(DeviceInputMode.KeyboardAndMouse, device);
			}
		}
	}

	private void SubscribeApplicationFocusChange()
	{
		Application.focusChanged -= HandleApplicationFocusChanged;
		Application.focusChanged += HandleApplicationFocusChanged;
		IsAppInFocus = Application.isFocused;
		_applicationFocusChangeSubscribed = true;
		_focusRestoreFrame = -1;
		_inputModeFocusLocked = false;
		_focusInputMode = DeviceInputMode.Unknown;
		_focusActiveInputDevice = null;
	}

	private void UnsubscribeApplicationFocusChange()
	{
		if (_applicationFocusChangeSubscribed)
		{
			Application.focusChanged -= HandleApplicationFocusChanged;
			_applicationFocusChangeSubscribed = false;
			_focusRestoreFrame = -1;
			_inputModeFocusLocked = false;
			_focusInputMode = DeviceInputMode.Unknown;
			_focusActiveInputDevice = null;
		}
	}

	private void HandleApplicationFocusChanged(bool hasFocus)
	{
		IsAppInFocus = hasFocus;
		try
		{
			OnApplicationFocusChanged?.Invoke(hasFocus);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		if (!hasFocus)
		{
			_focusRestoreFrame = -1;
			_inputModeFocusLocked = true;
			_focusInputMode = InputMode;
			_focusActiveInputDevice = activeInputDevice;
			return;
		}
		_focusRestoreFrame = Time.frameCount;
		if (_inputModeFocusLocked && !IsInputModeChangeBlockedByGuide() && (_focusActiveInputDevice == null || IsUsableInputDevice(_focusActiveInputDevice)))
		{
			ChangeInputMode(_focusInputMode, _focusActiveInputDevice);
		}
		RefreshPointerInputOnFocusRestore();
		_refreshInputDevicePairingInLateUpdate = true;
	}

	private void RefreshPointerInputOnFocusRestore()
	{
		if (ispc)
		{
			InputAction inputAction = _inputActions?.UI.Point;
			if (inputAction != null && inputAction.enabled && inputModule?.point?.action == inputAction)
			{
				inputAction.Disable();
				inputAction.Enable();
			}
		}
	}

	private bool IsSyntheticPointerInput(InputAction.CallbackContext context)
	{
		if (_inputActions == null || context.action != _inputActions.UI.Point)
		{
			return false;
		}
		InputDevice inputDevice;
		if (_focusRestoreFrame == Time.frameCount)
		{
			inputDevice = context.control?.device;
			if (!(inputDevice is Mouse mouse))
			{
				if (!(inputDevice is Touchscreen touchscreen))
				{
					if (inputDevice is Pen pen)
					{
						return !pen.tip.isPressed;
					}
					return true;
				}
				return !touchscreen.primaryTouch.press.isPressed;
			}
			return mouse.delta.ReadValue().sqrMagnitude <= 0.0001f;
		}
		inputDevice = context.control?.device;
		if (!(inputDevice is Mouse mouse2))
		{
			if (!(inputDevice is Touchscreen touchscreen2))
			{
				if (inputDevice is Pen pen2)
				{
					return !pen2.tip.isPressed;
				}
				return false;
			}
			return !touchscreen2.primaryTouch.press.isPressed;
		}
		return mouse2.delta.ReadValue().sqrMagnitude <= 0.0001f;
	}

	private void SubscribeInputDeviceChange()
	{
		InputSystem.onDeviceChange -= HandleActiveInputDeviceChange;
		InputSystem.onDeviceChange += HandleActiveInputDeviceChange;
		_inputDeviceChangeSubscribed = true;
	}

	private void UnsubscribeInputDeviceChange()
	{
		if (_inputDeviceChangeSubscribed)
		{
			InputSystem.onDeviceChange -= HandleActiveInputDeviceChange;
			_inputDeviceChangeSubscribed = false;
		}
	}

	private void HandleActiveInputDeviceChange(InputDevice device, InputDeviceChange changeType)
	{
		switch (changeType)
		{
		case InputDeviceChange.Added:
		case InputDeviceChange.Reconnected:
		case InputDeviceChange.Enabled:
			if (device != null)
			{
				_pendingInvalidInputDevices.Remove(device);
				_deviceAddedFrame[device] = Time.frameCount;
				if (changeType == InputDeviceChange.Reconnected && _activeInputDeviceMap != null && _activeInputDeviceMap.TryGetValue(device, out var value2))
				{
					value2.LastInputTime = double.MinValue;
				}
			}
			_refreshInputDevicePairingInLateUpdate = true;
			break;
		case InputDeviceChange.Removed:
		case InputDeviceChange.Disconnected:
		case InputDeviceChange.Disabled:
			if (device != null)
			{
				_pendingInvalidInputDevices.Add(device);
				_deviceAddedFrame.Remove(device);
				_switchProMirrorDevices.Remove(device);
				if (_activeInputDeviceMap != null && _activeInputDeviceMap.TryGetValue(device, out var value))
				{
					value.LastInputTime = double.MinValue;
				}
			}
			_activeDeviceIsChanged = true;
			_refreshInputDevicePairingInLateUpdate = true;
			if (activeInputDevice == null || !IsUsableInputDevice(activeInputDevice) || _pendingInvalidInputDevices.Contains(activeInputDevice))
			{
				ApplyFallbackInputMode();
			}
			break;
		}
	}

	private static IDisposable DeferBindingResolution()
	{
		if (DeferBindingResolutionMethod != null)
		{
			try
			{
				if (DeferBindingResolutionMethod.Invoke(null, null) is IDisposable result)
				{
					return result;
				}
			}
			catch (Exception ex)
			{
				if (LuminApplication.LogEnabled && !_deferBindingResolutionUnavailableLogged)
				{
					Debug.LogWarning("[InputPairing] Failed to defer binding resolution: " + ex.GetType().Name + ": " + ex.Message);
					_deferBindingResolutionUnavailableLogged = true;
				}
			}
		}
		if (LuminApplication.LogEnabled && !_deferBindingResolutionUnavailableLogged)
		{
			Debug.LogWarning("[InputPairing] Input System DeferBindingResolution is unavailable; continuing without deferred resolution");
			_deferBindingResolutionUnavailableLogged = true;
		}
		return null;
	}

	private void RefreshInputDevicePairing()
	{
		if (_activeInputDeviceMap == null)
		{
			return;
		}
		if (playerInput == null)
		{
			_pairingRetryPending = true;
			if (!_inputDevicePairingBlocked && LuminApplication.LogEnabled)
			{
				LogInputPairing("Skip device pairing: playerInput is null");
			}
			_inputDevicePairingBlocked = true;
			return;
		}
		InputUser user = playerInput.user;
		if (!playerInput.isActiveAndEnabled || !user.valid)
		{
			_pairingRetryPending = true;
			if (!_inputDevicePairingBlocked && LuminApplication.LogEnabled)
			{
				LogInputPairing($"Skip device pairing: playerInputActive={playerInput.isActiveAndEnabled}, userValid={user.valid}, deviceSnapshotCount={InputSystem.devices.Count}");
			}
			_inputDevicePairingBlocked = true;
			return;
		}
		_inputDevicePairingBlocked = false;
		Dictionary<InputDevice, InputDeviceData> activeInputDeviceMap = _activeInputDeviceMap;
		Dictionary<InputDevice, InputDeviceData> dictionary = new Dictionary<InputDevice, InputDeviceData>();
		List<InputDevice> preferredInputSystemDevices = GetPreferredInputSystemDevices();
		bool containsGamepad = ContainsGamepad(preferredInputSystemDevices);
		foreach (InputDevice item in preferredInputSystemDevices)
		{
			if (item == null || !item.added || !item.enabled || _pendingInvalidInputDevices.Contains(item) || IsIgnoredDevice(item, containsGamepad))
			{
				continue;
			}
			if (!activeInputDeviceMap.TryGetValue(item, out var value))
			{
				value = new InputDeviceData(item, (item is Touchscreen) ? 1f : 0f);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogFormat("[InputPairing] On InputSystem Device Connect: {0}", item.displayName);
				}
			}
			dictionary.Add(item, value);
		}
		InputDevice[] array = _pendingInvalidInputDevices.ToArray();
		bool flag = dictionary.Count == 0 && activeInputDeviceMap.Count > 0 && preferredInputSystemDevices.Count == 0 && array.Length == 0;
		Dictionary<InputDevice, InputDeviceData> dictionary2 = (flag ? activeInputDeviceMap : dictionary);
		if (dictionary.Count == 0 && LuminApplication.LogEnabled)
		{
			LogInputPairing(flag ? "No active device candidate in an empty snapshot; keep current device cache and pairing" : "No active device candidate; preserve pairing unless an explicit invalid-device event was received");
		}
		foreach (KeyValuePair<InputDevice, InputDeviceData> item2 in activeInputDeviceMap)
		{
			if (!dictionary2.ContainsKey(item2.Key) && LuminApplication.LogEnabled && item2.Key != null)
			{
				Debug.LogFormat("[InputPairing] On InputSystem Device Removed: {0}", item2.Key.displayName);
			}
		}
		_pairingRetryPending = false;
		List<InputDevice> list = SnapshotPairedDevices(user);
		if (LuminApplication.LogEnabled)
		{
			LogInputPairing($"Sync start: candidateCount={dictionary2.Count}, pairedCount={list.Count}, keptPreviousMap={flag}");
		}
		InputDevice[] array2;
		if (!flag)
		{
			using (DeferBindingResolution())
			{
				array2 = array;
				foreach (InputDevice device in array2)
				{
					TryUnpairInvalidDevice(ref user, device);
				}
				foreach (KeyValuePair<InputDevice, InputDeviceData> item3 in dictionary2)
				{
					if (!IsDevicePaired(user.pairedDevices, item3.Key))
					{
						TryPairDevice(ref user, item3.Key);
					}
				}
			}
		}
		_activeInputDeviceMap = dictionary2;
		List<InputDevice> list2 = SnapshotPairedDevices(user);
		List<InputDevice> pairedActiveDevices = GetPairedActiveDevices(activeInputDeviceMap, list);
		List<InputDevice> pairedActiveDevices2 = GetPairedActiveDevices(dictionary2, list2);
		_activeDeviceIsChanged |= IsActiveInputDeviceMapChanged(activeInputDeviceMap, dictionary2) || IsDeviceListChanged(pairedActiveDevices, pairedActiveDevices2);
		_pairingRetryPending |= HasUnpairedActiveDevice(dictionary2, list2) || HasPendingInvalidPairedDevice(list2);
		if (_pairingRetryPending && LuminApplication.LogEnabled)
		{
			LogInputPairing($"Pairing remains pending: candidateCount={dictionary2.Count}, pairedCount={list2.Count}");
		}
		array2 = array;
		foreach (InputDevice inputDevice in array2)
		{
			if (inputDevice == null || !IsDevicePaired(list2, inputDevice))
			{
				_pendingInvalidInputDevices.Remove(inputDevice);
			}
		}
		if (LuminApplication.LogEnabled)
		{
			LogInputPairing($"Sync complete: candidateCount={dictionary2.Count}, pairedCount={list2.Count}, keptPreviousMap={flag}");
		}
	}

	private void TryUnpairInvalidDevice(ref InputUser user, InputDevice device)
	{
		if (device == null || !IsDevicePaired(user.pairedDevices, device))
		{
			return;
		}
		try
		{
			user.UnpairDevice(device);
			if (LuminApplication.LogEnabled)
			{
				LogInputPairing("Unpaired invalid device: " + device.displayName);
			}
		}
		catch (Exception ex)
		{
			_pendingInvalidInputDevices.Add(device);
			_pairingRetryPending = true;
			if (LuminApplication.LogEnabled)
			{
				LogInputPairing($"Unpair failed: device={device.displayName}, userValid={user.valid}, exception={ex.GetType().Name}: {ex.Message}");
			}
		}
	}

	private void TryPairDevice(ref InputUser user, InputDevice device)
	{
		if (device == null || !device.added || !device.enabled)
		{
			if (device != null)
			{
				_pendingInvalidInputDevices.Add(device);
			}
			return;
		}
		try
		{
			user = InputUser.PerformPairingWithDevice(device, user);
			if (IsDevicePaired(user.pairedDevices, device))
			{
				if (LuminApplication.LogEnabled)
				{
					LogInputPairing("Paired device: " + device.displayName);
				}
				return;
			}
			_pairingRetryPending = true;
			if (LuminApplication.LogEnabled)
			{
				LogInputPairing($"Pairing pending: device={device.displayName}, userValid={user.valid}");
			}
		}
		catch (Exception ex)
		{
			_pairingRetryPending = true;
			if (LuminApplication.LogEnabled)
			{
				LogInputPairing($"Pair failed: device={device.displayName}, userValid={user.valid}, exception={ex.GetType().Name}: {ex.Message}");
			}
		}
	}

	private static List<InputDevice> SnapshotPairedDevices(InputUser user)
	{
		List<InputDevice> list = new List<InputDevice>();
		if (!user.valid)
		{
			return list;
		}
		foreach (InputDevice pairedDevice in user.pairedDevices)
		{
			if (pairedDevice != null)
			{
				list.Add(pairedDevice);
			}
		}
		return list;
	}

	private List<InputDevice> GetPairedActiveDevices(Dictionary<InputDevice, InputDeviceData> activeInputDeviceMap, IReadOnlyList<InputDevice> pairedDevices)
	{
		List<InputDevice> list = new List<InputDevice>();
		if (activeInputDeviceMap == null)
		{
			return list;
		}
		foreach (KeyValuePair<InputDevice, InputDeviceData> item in activeInputDeviceMap)
		{
			if (IsUsableInputDevice(item.Key) && IsDevicePaired(pairedDevices, item.Key))
			{
				list.Add(item.Key);
			}
		}
		return list;
	}

	private List<InputDevice> GetUsableActiveDevices(Dictionary<InputDevice, InputDeviceData> activeInputDeviceMap)
	{
		List<InputDevice> list = new List<InputDevice>();
		if (activeInputDeviceMap == null)
		{
			return list;
		}
		foreach (KeyValuePair<InputDevice, InputDeviceData> item in activeInputDeviceMap)
		{
			if (IsUsableInputDevice(item.Key))
			{
				list.Add(item.Key);
			}
		}
		return list;
	}

	private bool HasUnpairedActiveDevice(Dictionary<InputDevice, InputDeviceData> activeInputDeviceMap, IReadOnlyList<InputDevice> pairedDevices)
	{
		if (activeInputDeviceMap == null)
		{
			return false;
		}
		foreach (KeyValuePair<InputDevice, InputDeviceData> item in activeInputDeviceMap)
		{
			if (IsUsableInputDevice(item.Key) && !IsDevicePaired(pairedDevices, item.Key))
			{
				return true;
			}
		}
		return false;
	}

	private bool HasPendingInvalidPairedDevice(IReadOnlyList<InputDevice> pairedDevices)
	{
		foreach (InputDevice pendingInvalidInputDevice in _pendingInvalidInputDevices)
		{
			if (IsDevicePaired(pairedDevices, pendingInvalidInputDevice))
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsDevicePaired(IReadOnlyList<InputDevice> pairedDevices, InputDevice device)
	{
		if (device == null)
		{
			return false;
		}
		for (int i = 0; i < pairedDevices.Count; i++)
		{
			if (pairedDevices[i] == device)
			{
				return true;
			}
		}
		return false;
	}

	private bool IsUsableInputDevice(InputDevice device)
	{
		if (device != null && device.added && device.enabled)
		{
			return !_pendingInvalidInputDevices.Contains(device);
		}
		return false;
	}

	private static bool IsDeviceListChanged(IReadOnlyList<InputDevice> previousDevices, IReadOnlyList<InputDevice> currentDevices)
	{
		if (previousDevices.Count != currentDevices.Count)
		{
			return true;
		}
		for (int i = 0; i < currentDevices.Count; i++)
		{
			if (!IsDevicePaired(previousDevices, currentDevices[i]))
			{
				return true;
			}
		}
		return false;
	}

	private void LogInputPairing(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[InputPairing] " + message);
		}
	}

	private bool IsActiveInputDeviceMapChanged(Dictionary<InputDevice, InputDeviceData> previousInputDeviceMap, Dictionary<InputDevice, InputDeviceData> activeInputDeviceMap)
	{
		if (previousInputDeviceMap.Count != activeInputDeviceMap.Count)
		{
			return true;
		}
		foreach (KeyValuePair<InputDevice, InputDeviceData> item in activeInputDeviceMap)
		{
			if (!previousInputDeviceMap.ContainsKey(item.Key))
			{
				return true;
			}
		}
		return false;
	}

	private bool ContainsGamepad(IReadOnlyList<InputDevice> allDevice)
	{
		for (int num = allDevice.Count - 1; num >= 0; num--)
		{
			InputDevice inputDevice = allDevice[num];
			if (inputDevice is Gamepad item && inputDevice.added && inputDevice.enabled && !_pendingInvalidInputDevices.Contains(item))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsIgnoredDevice(InputDevice device, bool containsGamepad)
	{
		if (device == null)
		{
			return true;
		}
		if ((device is Keyboard) & containsGamepad)
		{
			return true;
		}
		Type type = device.GetType();
		foreach (Type item in _ignoredDeviceType)
		{
			if (item.IsAssignableFrom(type))
			{
				return true;
			}
		}
		return false;
	}

	private static List<InputDevice> SnapshotInputSystemDevices()
	{
		List<InputDevice> list = new List<InputDevice>();
		foreach (InputDevice device in InputSystem.devices)
		{
			list.Add(device);
		}
		return list;
	}

	internal static bool IsSwitchProDevice(InputDevice device)
	{
		if (device != null)
		{
			string product = device.description.product;
			if (product == null)
			{
				return false;
			}
			return product.IndexOf("Pro Controller", StringComparison.OrdinalIgnoreCase) >= 0;
		}
		return false;
	}

	private List<InputDevice> GetPreferredInputSystemDevices()
	{
		List<InputDevice> list = SnapshotInputSystemDevices();
		List<InputDevice> list2 = list.Where(IsSwitchProDevice).ToList();
		_switchProMirrorDevices.Clear();
		if (list2.Count == 0)
		{
			return list;
		}
		foreach (InputDevice item in list)
		{
			if (IsLikelyVirtualXInputDevice(item) && IsSameConnectionWindowAsSwitchPro(item, list2))
			{
				_switchProMirrorDevices.Add(item);
			}
		}
		return GetPreferredInputDevices(list.Where((InputDevice device) => !_switchProMirrorDevices.Contains(device)).ToList());
	}

	private static bool IsXInputDevice(InputDevice device)
	{
		if (device != null)
		{
			return string.Equals(device.layout, "XInputControllerWindows", StringComparison.Ordinal);
		}
		return false;
	}

	private static bool IsLikelyVirtualXInputDevice(InputDevice device)
	{
		if (!IsXInputDevice(device))
		{
			return false;
		}
		InputDeviceDescription description = device.description;
		if (string.Equals(description.interfaceName, "XInput", StringComparison.OrdinalIgnoreCase) && string.IsNullOrEmpty(description.manufacturer) && string.IsNullOrEmpty(description.product) && string.IsNullOrEmpty(description.serial))
		{
			return GetNativeDeviceId(device) == 0;
		}
		return false;
	}

	private bool IsSameConnectionWindowAsSwitchPro(InputDevice xInputDevice, IReadOnlyList<InputDevice> switchProDevices)
	{
		if (!IsLikelyVirtualXInputDevice(xInputDevice))
		{
			return false;
		}
		bool flag = _deviceAddedFrame.TryGetValue(xInputDevice, out var value);
		for (int i = 0; i < switchProDevices.Count; i++)
		{
			InputDevice inputDevice = switchProDevices[i];
			if ((_deviceAddedFrame.TryGetValue(inputDevice, out var value2) & flag) && Mathf.Abs(value - value2) <= 10)
			{
				return true;
			}
			bool flag2 = _deviceAddedFrame.ContainsKey(inputDevice);
			if ((!flag || !flag2) && xInputDevice.lastUpdateTime > 0.0 && inputDevice.lastUpdateTime > 0.0 && Math.Abs(xInputDevice.lastUpdateTime - inputDevice.lastUpdateTime) <= 0.01)
			{
				return true;
			}
		}
		return false;
	}

	private static List<InputDevice> GetPreferredInputDevices(IReadOnlyList<InputDevice> devices)
	{
		List<InputDevice> list = new List<InputDevice>(devices.Count);
		for (int i = 0; i < devices.Count; i++)
		{
			InputDevice inputDevice = devices[i];
			if (inputDevice == null || !(inputDevice is Gamepad))
			{
				list.Add(inputDevice);
				continue;
			}
			int num = FindDuplicateGamepad(list, inputDevice);
			if (num < 0)
			{
				list.Add(inputDevice);
				continue;
			}
			InputDevice current = list[num];
			if (IsPreferredGamepad(inputDevice, current))
			{
				list[num] = inputDevice;
			}
		}
		return list;
	}

	private static int FindDuplicateGamepad(IReadOnlyList<InputDevice> devices, InputDevice candidate)
	{
		for (int i = 0; i < devices.Count; i++)
		{
			if (devices[i] is Gamepad first && AreSamePhysicalGamepad(first, candidate))
			{
				return i;
			}
		}
		return -1;
	}

	private static bool AreSamePhysicalGamepad(InputDevice first, InputDevice second)
	{
		if (first == null || second == null || !(first is Gamepad) || !(second is Gamepad))
		{
			return false;
		}
		InputDeviceDescription description = first.description;
		InputDeviceDescription description2 = second.description;
		if (!string.IsNullOrEmpty(description.serial) && !string.IsNullOrEmpty(description2.serial))
		{
			return string.Equals(description.serial, description2.serial, StringComparison.Ordinal);
		}
		int nativeDeviceId = GetNativeDeviceId(first);
		int nativeDeviceId2 = GetNativeDeviceId(second);
		if (nativeDeviceId != 0)
		{
			return nativeDeviceId == nativeDeviceId2;
		}
		return false;
	}

	private static int GetNativeDeviceId(InputDevice device)
	{
		if (device == null || NativeDeviceIdProperty == null)
		{
			return 0;
		}
		try
		{
			return (NativeDeviceIdProperty.GetValue(device) is int num) ? num : 0;
		}
		catch
		{
			return 0;
		}
	}

	private static string GetDeviceUsages(InputDevice device)
	{
		if (device == null || device.usages.Count == 0)
		{
			return string.Empty;
		}
		string[] array = new string[device.usages.Count];
		for (int i = 0; i < device.usages.Count; i++)
		{
			array[i] = device.usages[i].ToString();
		}
		return string.Join(",", array);
	}

	private static bool IsPreferredGamepad(InputDevice candidate, InputDevice current)
	{
		bool flag = IsSwitchProDevice(candidate);
		bool flag2 = IsSwitchProDevice(current);
		if (flag)
		{
			return !flag2;
		}
		return false;
	}

	internal string GetInputDeviceFilterDiagnostics()
	{
		List<InputDevice> list = SnapshotInputSystemDevices();
		List<InputDevice> preferredInputSystemDevices = GetPreferredInputSystemDevices();
		string arg = activeInputDevice?.displayName ?? "<none>";
		List<string> list2 = new List<string> { $"[InputDeviceFilter] total={list.Count}, preferred={preferredInputSystemDevices.Count}, activeInputDevice={arg}" };
		int num = Enumerable.Count(list, IsSwitchProDevice);
		int num2 = Enumerable.Count(preferredInputSystemDevices, IsSwitchProDevice);
		int num3 = 0;
		for (int i = 0; i < list.Count; i++)
		{
			for (int j = i + 1; j < list.Count; j++)
			{
				if (AreSamePhysicalGamepad(list[i], list[j]))
				{
					num3++;
				}
			}
		}
		string text = (((num == 0 || num2 > 0) && preferredInputSystemDevices.Count <= list.Count) ? "PASS" : "FAIL");
		list2.Add($"  verify switchPro={num}, keptSwitchPro={num2}, " + $"samePhysicalGamepadPairs={num3}, " + "result=" + text);
		for (int k = 0; k < list.Count; k++)
		{
			InputDevice inputDevice = list[k];
			if (inputDevice != null)
			{
				InputDeviceDescription description = inputDevice.description;
				string text2 = (preferredInputSystemDevices.Contains(inputDevice) ? "KEEP" : "DROP");
				string arg2 = (IsLikelyVirtualXInputDevice(inputDevice) ? " likelyVirtualXInput=true" : string.Empty);
				string arg3 = (_deviceAddedFrame.TryGetValue(inputDevice, out var value) ? $" addedFrame={value}" : " addedFrame=<unknown>");
				list2.Add("  " + text2 + " " + $"id={inputDevice.deviceId}, native={GetNativeDeviceId(inputDevice)}, type={inputDevice.GetType().Name}, " + "layout=" + inputDevice.layout + ", name=" + inputDevice.displayName + ", interface=" + description.interfaceName + ", manufacturer=" + description.manufacturer + ", product=" + description.product + ", serial=" + description.serial + ", capabilities=" + description.capabilities + ", usages=" + GetDeviceUsages(inputDevice) + ", " + $"synthetic={inputDevice.synthetic}, remote={inputDevice.remote}, " + $"canRunInBackground={inputDevice.canRunInBackground}, " + $"lastUpdateTime={inputDevice.lastUpdateTime:F6}{arg2}{arg3}");
			}
		}
		list2.Add($"  paired={playerInput?.user.pairedDevices.Count ?? 0}, map={_activeInputDeviceMap?.Count ?? 0}");
		return string.Join("\n", list2);
	}

	private void UpdateInputDeviceStatus()
	{
		if (RefreshActionMapDevice())
		{
			Singleton<GameInputActionManager>.instance.RefreshAllInputActionBindings();
		}
		CheckInputDeviceChanged();
		CheckScreenSizeChange();
	}

	private void LateTickInputStatus()
	{
		if (_inputDevicePairingBlocked)
		{
			if (playerInput == null || !playerInput.isActiveAndEnabled || !playerInput.user.valid)
			{
				return;
			}
			_inputDevicePairingBlocked = false;
			_refreshInputDevicePairingInLateUpdate = true;
		}
		if (_refreshInputDevicePairingInLateUpdate)
		{
			_refreshInputDevicePairingInLateUpdate = false;
			RefreshInputDevicePairing();
			UpdateInputDeviceStatus();
		}
	}

	private bool RefreshActionMapDevice()
	{
		if (!_activeDeviceIsChanged || _activeInputDeviceMap == null || _inputActions == null || playerInput == null || !playerInput.isActiveAndEnabled || !playerInput.user.valid)
		{
			return false;
		}
		_activeDeviceIsChanged = false;
		List<InputDevice> usableActiveDevices = GetUsableActiveDevices(_activeInputDeviceMap);
		InputDevice[] array = new InputDevice[usableActiveDevices.Count];
		int num = 0;
		foreach (InputDevice item in usableActiveDevices)
		{
			array[num] = item;
			num++;
		}
		ReadOnlyArray<InputDevice> readOnlyArray = new ReadOnlyArray<InputDevice>(array);
		using (DeferBindingResolution())
		{
			foreach (InputActionMap actionMap in _inputActions.asset.actionMaps)
			{
				actionMap.devices = readOnlyArray;
			}
			_inputActions.devices = readOnlyArray;
		}
		try
		{
			OnActiveDeviceChange?.Invoke(readOnlyArray);
			ReportDevicesChanged(readOnlyArray);
		}
		catch
		{
		}
		return true;
	}

	private bool IsMouseOrKeyboard(InputDevice device)
	{
		string text = device.name;
		return text == "Keyboard" || text == "Mouse" || text == "OnScreenControlNode";
	}

	private void ReportDevicesChanged(ReadOnlyArray<InputDevice> devices)
	{
		foreach (InputDevice device in devices)
		{
			if (device is Gamepad && knownDevices.All((InputDevice kd) => kd.displayName != device.displayName))
			{
				GameController evt = EventTrackSolver.Instance.GetEvt<GameController>();
				evt.status = 1;
				evt.brand = device.description.manufacturer;
				evt.controllerMode = device.GetType().Name;
				EventTrackSolver.Instance.Dispatch(evt);
			}
		}
		foreach (InputDevice device2 in knownDevices)
		{
			if (device2 is Gamepad && devices.All((InputDevice d) => d.displayName != device2.displayName))
			{
				GameController evt2 = EventTrackSolver.Instance.GetEvt<GameController>();
				evt2.status = 2;
				evt2.brand = device2.description.manufacturer;
				evt2.controllerMode = device2.GetType().Name;
				EventTrackSolver.Instance.Dispatch(evt2);
			}
		}
		knownDevices = devices;
	}

	private void CheckInputDeviceChanged()
	{
		if (!Application.isFocused || _inputModeFocusLocked || IsInputModeChangeBlockedByGuide() || _activeInputDeviceMap == null || playerInput == null || !playerInput.isActiveAndEnabled || !playerInput.user.valid)
		{
			return;
		}
		_deviceDataCache.Clear();
		foreach (KeyValuePair<InputDevice, InputDeviceData> item in _activeInputDeviceMap)
		{
			if (IsUsableInputDevice(item.Key))
			{
				_deviceDataCache.Add(item.Value);
			}
		}
		if (_deviceDataCache.Count <= 0)
		{
			ApplyFallbackInputMode();
			return;
		}
		_deviceDataCache.Sort(_deviceComparison);
		RefreshDeviceInputMode();
	}

	private static int SortDeviceData(InputDeviceData dataA, InputDeviceData dataB)
	{
		return dataB.LastInputTime.CompareTo(dataA.LastInputTime);
	}

	private bool ContainedActiveDevice<T>()
	{
		foreach (InputDeviceData item in _deviceDataCache)
		{
			if (item.InputDevice is T)
			{
				return true;
			}
		}
		return false;
	}

	private void RefreshDeviceInputMode()
	{
		InputDevice deviceAt = GetDeviceAt(_deviceDataCache, 0);
		DeviceInputMode deviceInputMode = DeviceInputMode.Unknown;
		if ((deviceAt is Keyboard && ContainedActiveDevice<Mouse>()) || (deviceAt is Mouse && ContainedActiveDevice<Keyboard>()))
		{
			deviceInputMode = DeviceInputMode.KeyboardAndMouse;
		}
		else if (deviceAt is Touchscreen)
		{
			deviceInputMode = DeviceInputMode.TouchScreen;
		}
		else if (deviceAt is Gamepad)
		{
			deviceInputMode = DeviceInputMode.Gamepad;
		}
		if (deviceInputMode == DeviceInputMode.Unknown)
		{
			ApplyFallbackInputMode();
		}
		else
		{
			ChangeInputMode(deviceInputMode, deviceAt);
		}
	}

	private static bool IsInputModeChangeBlockedByGuide()
	{
		if (Singleton<GameState>.HasInstance())
		{
			return Singleton<GameState>.instance.InGuiding;
		}
		return false;
	}

	private void ApplyFallbackInputMode()
	{
		if (!IsInputModeChangeBlockedByGuide())
		{
			activeInputDevice = null;
			InputMode = ((!ispc) ? DeviceInputMode.TouchScreen : DeviceInputMode.KeyboardAndMouse);
		}
	}

	internal void ChangeInputMode(DeviceInputMode mode, InputDevice device)
	{
		if (!IsInputModeChangeBlockedByGuide())
		{
			activeInputDevice = device;
			InputMode = mode;
		}
	}

	private InputDevice GetDeviceAt(List<InputDeviceData> deviceList, int index)
	{
		if (index >= 0 && index < deviceList.Count)
		{
			InputDevice inputDevice = deviceList[index].InputDevice;
			if (inputDevice != null)
			{
				return inputDevice;
			}
		}
		return null;
	}

	private void BindInputActions()
	{
		Dictionary<string, Action<InputAction.CallbackContext>> dictionary = new Dictionary<string, Action<InputAction.CallbackContext>>();
		_actionMaps = new Dictionary<string, InputActionMap>();
		_actionDict = new Dictionary<string, InputAction>();
		_callbackBinding = new Dictionary<Guid, Action<InputAction.CallbackContext>>();
		foreach (InputActionMap actionMap in playerInput.actions.actionMaps)
		{
			_actionMaps[actionMap.name] = actionMap;
			foreach (InputAction action in actionMap.actions)
			{
				_actionDict[actionMap.name + "/" + action.name] = action;
				if (dictionary.TryGetValue(action.name, out var value))
				{
					_callbackBinding[action.id] = value;
					action.started += OnActionEventPreform;
					action.performed += OnActionEventPreform;
					action.canceled += OnActionEventPreform;
				}
			}
		}
	}

	internal void RefreshInputActionBindings(params InputAction[] inputActions)
	{
		Singleton<GameInputActionManager>.instance.RefreshInputActionBindings(inputActions);
		onInputModeChange?.Invoke(InputMode);
	}

	private static bool CorrectGuideBindingPath(string bindingPath, out PromptIconDeviceType type, out string path)
	{
		type = PromptIconDeviceType.Unknown;
		path = null;
		if (!bindingPath.StartsWith("guide_", StringComparison.OrdinalIgnoreCase))
		{
			return false;
		}
		if (instance.IsGamePadMode())
		{
			switch (bindingPath)
			{
			case "guide_move_left":
				path = "gamepad_leftstickleft";
				break;
			case "guide_move_right":
				path = "gamepad_leftstickright";
				break;
			case "guide_move_up":
				path = "gamepad_leftstickup";
				break;
			case "guide_move_down":
				path = "gamepad_leftstickdown";
				break;
			default:
				path = null;
				return false;
			}
			type = PromptIconDeviceType.Gamepad;
			goto IL_013d;
		}
		switch (bindingPath)
		{
		case "guide_move_left":
			path = "Move/Left";
			break;
		case "guide_move_right":
			path = "Move/Right";
			break;
		case "guide_move_up":
			path = "Move/Up";
			break;
		case "guide_move_down":
			path = "Move/Down";
			break;
		default:
			path = null;
			return false;
		}
		ButtonBindingPathConfig.ButtonBindingPath inputBindingPath = instance.GetInputBindingPath(path, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1);
		if (inputBindingPath != null)
		{
			InputAction inputAction = instance.inputActionAsset.FindAction(inputBindingPath.InputActionPath);
			if (inputAction != null)
			{
				type = PromptIconDeviceType.KeyboardAndMouse;
				CorrectBindingPath(inputAction.bindings[inputBindingPath.InputBindingIndex].effectivePath, out var _, out path);
				goto IL_013d;
			}
		}
		return false;
		IL_013d:
		return true;
	}

	public static bool CorrectBindingPath(string bindingPath, out PromptIconDeviceType type, out string path)
	{
		type = PromptIconDeviceType.Unknown;
		path = string.Empty;
		Match match = Regex.Match(bindingPath, "\\<(\\w+)\\>\\/(.+)");
		if (!match.Success)
		{
			return false;
		}
		string text = match.Groups[1].Value.ToLower();
		string text2 = match.Groups[2].Value.ToLower().Replace("/", "");
		if (!(text == "keyboard"))
		{
			if (text == "gamepad")
			{
				type = PromptIconDeviceType.Gamepad;
				if (text2.StartsWith("button"))
				{
					string text3 = text2;
					text2 = text3.Substring(6, text3.Length - 6);
				}
			}
		}
		else
		{
			type = PromptIconDeviceType.KeyboardAndMouse;
			if (int.TryParse(text2, out var _))
			{
				text2 = "digit" + text2;
			}
		}
		path = text + "/" + text2;
		return true;
	}

	public void SaveInputBindingOverride()
	{
		string value = inputActionAsset.SaveBindingOverridesAsJson();
		ServerPlayerPrefs.SetString("InputBindingOverride", value);
		ServerPlayerPrefs.Save();
	}

	public void LoadInputBindingOverride()
	{
		inputActionAsset.RemoveAllBindingOverrides();
		string text = ServerPlayerPrefs.GetString("InputBindingOverride", string.Empty);
		if (!string.IsNullOrEmpty(text))
		{
			inputActionAsset.LoadBindingOverridesFromJson(text);
			RefreshOverrideActionBindings(text);
		}
	}

	private void RefreshOverrideActionBindings(string inputOverrideJson)
	{
		BindingOverrideListJson bindingOverrideListJson = JsonUtility.FromJson<BindingOverrideListJson>(inputOverrideJson);
		List<InputAction> list = new List<InputAction>();
		foreach (BindingOverrideJson binding in bindingOverrideListJson.bindings)
		{
			InputAction inputAction = _inputActions.FindAction(binding.action);
			if (inputAction != null)
			{
				list.Add(inputAction);
			}
		}
		if (list.Count > 0)
		{
			Singleton<GameInputActionManager>.instance.RefreshInputActionBindings(list);
		}
	}

	protected void ReleaseInput()
	{
		UnsubscribeApplicationFocusChange();
		UnsubscribeInputDeviceChange();
		_refreshInputDevicePairingInLateUpdate = false;
		_pendingInvalidInputDevices.Clear();
		_deviceAddedFrame.Clear();
		_switchProMirrorDevices.Clear();
		_pairingRetryPending = false;
		_inputDevicePairingBlocked = false;
		_inputModeFocusLocked = false;
		_focusInputMode = DeviceInputMode.Unknown;
		_focusActiveInputDevice = null;
	}

	private void TickInputStatus()
	{
		UpdateInputDeviceStatus();
		Singleton<GameInputActionManager>.instance.Update(Time.deltaTime);
	}

	private void OnActionEventPreform(InputAction.CallbackContext context)
	{
		if (_callbackBinding.TryGetValue(context.action.id, out var value))
		{
			value(context);
		}
	}

	private void SetActionMapEnable(string mapName, bool enable)
	{
		if (_actionMaps.TryGetValue(mapName, out var value))
		{
			(enable ? new Action(value.Enable) : new Action(value.Disable))();
		}
	}

	public void PushPauseInput(bool includeUI = false)
	{
		m_PauseInputRef++;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"PushPauseInput : {m_PauseInputRef}");
		}
		if (m_PauseInputRef > 0)
		{
			couldInput = false;
			if (mainEntity.IsValid && mainEntity.TryGetCompInput(out CompInput component))
			{
				component?.ResetDir();
				Singleton<GameManager>.instance.ecsManager.systemBehave.ResetInput(mainEntity);
			}
		}
	}

	public void PopPauseInput(bool includeUI = false)
	{
		if (m_PauseInputRef != 0)
		{
			m_PauseInputRef--;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"PopPauseInput : {m_PauseInputRef}");
			}
			if (m_PauseInputRef == 0)
			{
				couldInput = true;
			}
		}
	}

	public void ResetInput()
	{
		m_PauseInputRef = 0;
		couldInput = true;
	}

	public void PushPauseUIInput()
	{
		_pauseUIInputRef++;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"---------------_pauseUIInputRef: {_pauseUIInputRef}");
		}
		if (_pauseUIInputRef == 1)
		{
			Singleton<NewUIManager>.instance.ExternalActiveInput = false;
			PushPauseControlInput();
		}
	}

	public void PopPauseUIInput()
	{
		if (_pauseUIInputRef != 0)
		{
			_pauseUIInputRef--;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"---------------_pauseUIInputRef: {_pauseUIInputRef}");
			}
			if (_pauseUIInputRef == 0)
			{
				Singleton<NewUIManager>.instance.ExternalActiveInput = true;
				PopPauseControlInput();
			}
		}
	}

	private void PushPauseControlInput()
	{
		Singleton<GameInputActionManager>.instance.SetActive(active: false);
	}

	private void PopPauseControlInput()
	{
		Singleton<GameInputActionManager>.instance.SetActive(active: true);
	}

	public void PushPauseAllInput()
	{
		PushPauseInput();
		PushPauseUIInput();
	}

	public void PopPauseAllInput()
	{
		PopPauseInput();
		PopPauseUIInput();
	}

	public void SetActionMap(string map, bool value)
	{
		if (value)
		{
			playerInput.actions.FindActionMap(map)?.Enable();
		}
		else
		{
			playerInput.actions.FindActionMap(map)?.Disable();
		}
	}

	public void ClearMainEntityInput()
	{
		if (mainEntity.IsValid)
		{
			mainEntity.GetCompInput()?.Clear();
			Singleton<GameManager>.instance.ecsManager.systemBehave.ResetInput(mainEntity);
		}
	}

	private void HandleButton<T>(bool handle, T value, ref ButtonState state)
	{
		if (!handle)
		{
			return;
		}
		bool currentFramePressed = false;
		if (value is InputAction.CallbackContext callbackContext)
		{
			if (callbackContext.valueType == FloatType)
			{
				currentFramePressed = callbackContext.ReadValue<float>() > 0.5f;
			}
			state.currentFramePressed = currentFramePressed;
		}
	}

	public void OnGM(InputAction.CallbackContext value)
	{
	}

	[Conditional("UNITY_EDITOR")]
	public void OnAddTimeScale(bool value)
	{
		if (curLevel < 6)
		{
			curLevel++;
		}
	}

	[Conditional("UNITY_EDITOR")]
	public void OnMinusTimeScale(bool value)
	{
		if (curLevel > 0)
		{
			curLevel--;
		}
	}

	[Conditional("UNITY_EDITOR")]
	private void CalculateTimeScale()
	{
		Time.timeScale = ((curLevel < 3) ? Mathf.Lerp(0.1f, 1f, (float)curLevel / 3f) : Mathf.Lerp(1f, 2f, (float)(curLevel - 3) / 3f));
	}

	public void AddNetworkdListener()
	{
		_serverNetworkController.AddNetworkListener();
	}

	public void RemoveNetworkListener()
	{
		_serverNetworkController.RemoveNetworkListener();
	}

	internal Vector2 GetLocalPlayerViewSpacePos()
	{
		Vector2 result = new Vector2(0.5f, 0.5f);
		if (localPlayer == null || !localPlayer.battleEntity.IsValid || Camera.main == null)
		{
			return result;
		}
		Vector3 colliderPosition = localPlayer.battleEntity.GetCompTransform().colliderPosition;
		return Camera.main.WorldToViewportPoint(colliderPosition);
	}

	public void PushPause()
	{
		m_PauseRef++;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"Pause ref {m_PauseRef}");
		}
		if (m_PauseRef > 0)
		{
			running = false;
		}
	}

	public void PopPause()
	{
		if (m_PauseRef != 0)
		{
			m_PauseRef--;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"Pause ref {m_PauseRef}");
			}
			if (m_PauseRef == 0)
			{
				running = true;
			}
		}
	}

	public void ClearPause()
	{
		m_PauseRef = 0;
		if (m_PauseRef == 0)
		{
			running = true;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.PopPause, null);
		}
	}

	private void SetAllPlayerInputActiveState(bool active)
	{
		bool value = !active;
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Switch1Character", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Switch2Character", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Switch3Character", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Dodge", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Jump", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/Vibrate", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/RegularAttack", value);
		Singleton<GameInputActionManager>.instance.SetActionDisabled("Player/SkillAttack", value);
	}

	public void InputActive(InputKey key, bool value)
	{
		if (key == InputKey.all)
		{
			SetAllPlayerInputActiveState(value);
		}
		else
		{
			Singleton<GameInputActionManager>.instance.SetInputActive(key, value);
		}
	}

	public void DispatchUpdateOperateEffectBtnEvt(CustomUICompType customUICompType, bool active)
	{
		UpdateOperateBtnActiveEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateOperateBtnActiveEvt>();
		evt.customUICompType = customUICompType;
		evt.active = active;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtn_UpdateBtnEffectActive, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void PushPauseInteract()
	{
		m_PauseInteractRef++;
	}

	public void PopPauseInteract()
	{
		m_PauseInteractRef--;
	}

	private void Start()
	{
		m_Running = (m_RunningTarget = true);
		m_CouldPause = true;
		_entityLocal = new EntityLocal();
		InitECS();
		InitializeRoots();
		InitInput();
		ruleManager = new RuleManager();
		checkPointManager = new CheckPointManager();
		aiContextManager = new AIContextManager();
		onceCollectionManager = new OnceCollectionManager();
		onceCollectionManager.Init();
		raidListenerManager = new RaidListenerManager();
		damageStatisticsManager = new DamageStatisticsManager();
		chTimeStatisticsManager = new ChTimeStatisticsManager();
		chTimeStatisticsManager.Bind();
		reviewPromptManager = new ReviewPromptManager();
		triggerManager = new TriggerManager();
		StartCoroutine(CoPostFixedUpdate());
	}

	private void FixedUpdate()
	{
		if (m_NeedChange)
		{
			GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
			if (m_RunningTarget)
			{
				DoStartOrResume();
				evt.IsInState = false;
				Singleton<GameManager>.instance.audioManager.PauseBus(AudioBusType.Battle, pause: false);
			}
			else
			{
				DoEndOrPause();
				evt.IsInState = true;
				Singleton<GameManager>.instance.audioManager.PauseBus(AudioBusType.Battle, pause: true);
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnUIStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		if (Model<InteractModel>.HasInstance())
		{
			Model<InteractModel>.Interface.FixedUpdate();
		}
		Singleton<InteractTipManager>.instance.FixedUpdate();
		reviewPromptManager.Tick();
		GameManager.FixedUpdate();
	}

	private IEnumerator CoPostFixedUpdate()
	{
		while (true)
		{
			yield return WaitForFixedUpdate;
			GameManager.LateFixedUpdate();
		}
	}

	private void Update()
	{
		try
		{
			GameManager.Update();
			UpdatePlayerSyncData();
			UpdatePlayerLevelChange();
			TickInputStatus();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private void UpdatePlayerLevelChange()
	{
		int playerLevel = SystemUnlockManager.playerLevel;
		string sDKAccountId = LuminApplication.SDKAccountId;
		if (playerLevel != _playerLevel || !(sDKAccountId == _aid))
		{
			_playerLevel = playerLevel;
			_aid = sDKAccountId;
			string userLevel = $"{sDKAccountId} ({playerLevel})";
			LuminApplication.APM.GPM.SetUserLevel(userLevel);
		}
	}

	private void LateUpdate()
	{
		LateTickInputStatus();
		GameManager.LateUpdate();
		Singleton<GameInputActionManager>.instance.LateUpdate();
	}

	public void BttleStateChange(PlayState pre, PlayState now)
	{
		GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
		if (pre == PlayState.UnBattle && now != PlayState.UnBattle)
		{
			evt.IsInState = true;
		}
		if (pre != PlayState.UnBattle && now == PlayState.UnBattle)
		{
			evt.IsInState = false;
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnBattleStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtStateChange evt2 = abilitySystem.GetEvt<EvtStateChange>(default, null);
		evt2.now = now;
		evt2.pre = pre;
		evt2.mainEntity = localPlayer.battleEntity;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	public bool InPlayerTag(PlayerTag tag)
	{
		return (m_PlayerTag & tag) == tag;
	}

	public bool HasAnyPlayerTag(PlayerTag tags)
	{
		return (m_PlayerTag & tags) != 0;
	}

	public void SetPlayerTag(PlayerTag tag)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"Add Player Tag : {tag}");
		}
		m_PlayerTag |= tag;
	}

	public void RemovePlayerTag(PlayerTag tag)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"Remove Player Tag : {tag}");
		}
		m_PlayerTag &= ~tag;
	}

	public void ClearPlayerTag()
	{
		m_PlayerTag = (PlayerTag)0;
	}

	private void Awake()
	{
		_instance = this;
	}

	private void OnDestroy()
	{
	}

	internal void SpawnBehave(Entity eb, bool faceLeft)
	{
		GameManager.physicsSystem.OnSpawn(eb, faceLeft);
		GameManager.behaveSystem.OnSpawn(eb);
		ConfigCharacter config = eb.GetConfig();
		if (config.animationSchema == AnimationSchema.LookAtCamera)
		{
			faceLeft = false;
		}
		if (faceLeft && config.animationSchema == AnimationSchema.LockRotation)
		{
			eb.SetBool("born_left", value: true);
		}
	}

	internal void TryRemoveBehave(Entity eb)
	{
		eb.GetCompBehave()?.SetOnRemove();
	}

	internal void SetBehaveActive(Entity eb, bool value)
	{
		CompBehave compBehave = eb.GetCompBehave();
		if (compBehave.IsLogicAvailable())
		{
			OnLogicAvailable(eb);
		}
		else
		{
			compBehave.OnLogicAvailable += OnLogicAvailable;
		}
		void OnLogicAvailable(Entity entity)
		{
			entity.SetActive(value);
		}
	}

	internal void RobotActive(bool value, bool effect = true)
	{
		Entity robotEntity = localPlayer.robotEntity;
		if (robotEntity.GetModel().activeSelf == value)
		{
			return;
		}
		if (value)
		{
			robotEntity.GetCompPhysics().characterMovement.collider.enabled = true;
			robotEntity.Teleport(localPlayer.battleEntity.GetCompTransform().physicsPosition + robotEntity.GetRootTransform().TransformDirection(GameUtility.robotOffset));
			robotEntity.GetModelTrans().localRotation = localPlayer.battleEntity.GetCompPhysics().faceDirRot;
		}
		else
		{
			robotEntity.GetCompPhysics().characterMovement.collider.enabled = false;
			robotEntity.Teleport(Vector3.zero);
		}
		SetBehaveActive(robotEntity, value);
		robotEntity.GetModelTrans().gameObject.SetActive(value);
		if (!effect)
		{
			return;
		}
		Transform modelTrans = robotEntity.GetModelTrans();
		SystemEffect effectSystem = GameManager.effectSystem;
		if (value)
		{
			if (GameLoader.meta.robotShowReferenceAssetID.RuntimeKeyIsValid())
			{
				effectSystem.FireEffect(GameLoader.meta.robotShowReferenceAssetID, modelTrans.position, Quaternion.identity);
			}
		}
		else if (GameLoader.meta.robotHideReferenceAssetID.RuntimeKeyIsValid())
		{
			effectSystem.FireEffect(GameLoader.meta.robotHideReferenceAssetID, modelTrans.position, Quaternion.identity);
		}
	}

	internal void SetMonsterBehaveActive(Entity eb, bool value)
	{
		eb.GetRoot().SetActive(value);
		eb.SetActive(value);
	}

	public void ToggleAllAI(bool run)
	{
		GameManager.aiSystem.ToggleAll(run);
	}

	private void DoEndOrPause()
	{
		Singleton<GameManager>.instance.ecsManager.DoEndOrPause();
		m_NeedChange = false;
		m_Running = false;
		ToggleAllAI(run: false);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PushPause, null);
	}

	private void DoStartOrResume()
	{
		Singleton<GameManager>.instance.ecsManager.DoStartOrResume();
		m_NeedChange = false;
		m_Running = true;
		ToggleAllAI(run: true);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PopPause, null);
	}

	internal void EntityDieAnimStart(Entity behave)
	{
		if (behave == mainEntity)
		{
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_BATTLEMAIN);
		}
	}

	public void CoRemoveTeamCharacter(int characterId)
	{
		CoRemoveTeamCharacter(G.localPlayer.GetCharacter(characterId));
	}

	public void CoRemoveTeamCharacter(Character character)
	{
		if (character != null && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			GameManager.cameraSystem.DestroyCharacterVCam(entity.Id);
			ReleaseCharacterBattleEntity(entity);
		}
	}

	internal void StartWorld()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("MonoECS StartWorld");
		}
		if (localPlayer == null)
		{
			MPPlayer mPPlayer = (localPlayer = new MPPlayer());
		}
		OperationManager.StartOperation(new InitGameOperation());
	}

	public void SetStartWorldState(bool state)
	{
		isStartWorld = state;
	}

	public void CleanupOnDestroy()
	{
		m_Running = true;
		triggerManager?.ClearWorldTriggers();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ClearHatred, null);
	}

	public async UniTask DestroyWorld()
	{
		OperationManager.StartOperation(new DestroyGameOption());
	}

	public float GetStaticModelBlockGCInterval()
	{
		return _gcInterval;
	}

	public int GetFrameStaticModelBlockGCCount()
	{
		return _gcCountLimit;
	}

	internal void SetUpMapData()
	{
		if (Singleton<GameManager>.instance.worldManager.ActiveWorldId == 3 && Model<MapModel>.HasInstance() && !Model<MapModel>.Interface.MainWorldDataInitFinish)
		{
			Model<MapModel>.Interface.MainWorldDataInit();
		}
	}

	public bool CharacterRecovery()
	{
		int num = 0;
		List<Character> list = new List<Character>();
		if (sceneStatus == SceneStatus.Main)
		{
			int mainTeamIdx = G.localPlayer.teamInfo.MainTeamIdx;
			PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[mainTeamIdx];
			num = ((localPlayer != null) ? localPlayer.GetNormalRuntimeBattleIndex(presetTeam.BattleCharacterIdx) : presetTeam.BattleCharacterIdx);
			for (int i = 0; i < presetTeam.CharacterIds.Count; i++)
			{
				if (presetTeam.CharacterIds[i] != 0)
				{
					CharacterDataHelper.TryGetBagCharacterById(presetTeam.CharacterIds[i], out var character);
					list.Add(character);
				}
			}
		}
		else
		{
			List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
			if (curTeamCharacters != null)
			{
				list.AddRange(curTeamCharacters);
				num = TeamInfoExtension.GetTeamInfo().BattleCharacterIdx;
			}
		}
		int count = list.Count;
		bool flag = false;
		int num2 = -1;
		int num3 = 0;
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j] != null && list[j].Id != 0)
			{
				if (list[j].Status.Hp == 0)
				{
					if (num == j)
					{
						flag = true;
					}
					num3++;
				}
				else
				{
					num2 = j;
				}
			}
			else
			{
				num3++;
			}
		}
		if (num3 == count)
		{
			if (sceneStatus != SceneStatus.Main)
			{
				if (G.localPlayer.Profile.SceneStatus == SceneStatus.Raid)
				{
					G.service.LeaveRaid((bool r) =>
					{
					});
				}
				else if (G.localPlayer.Profile.SceneStatus == SceneStatus.Abyss)
				{
					G.service.LeaveAbyss((bool r) =>
					{
					});
				}
				else if (G.localPlayer.Profile.SceneStatus == SceneStatus.Temple)
				{
					G.service.LeaveTemple((bool r) =>
					{
					});
				}
				sceneStatus = SceneStatus.Main;
				return CharacterRecovery();
			}
			for (int num4 = 0; num4 < list.Count; num4++)
			{
				if (list[num4] != null && list[num4].Id != 0)
				{
					Character character2 = list[num4];
					character2.Status.Hp = RuntimeConfigs.data.game.hpSync;
					character2.Status.EnergyPower = 0f;
					character2.Status.ExPower = 0f;
					character2.Status.SpecialEnergyPower = 0f;
					character2.Status.AssistPower = 0f;
				}
			}
			return true;
		}
		if ((num2 >= 0) & flag)
		{
			localPlayer.battleEntityIndex = num2;
		}
		return false;
	}

	public bool IsInTeam(Entity behave)
	{
		for (int i = 0; i < 3; i++)
		{
			if (localPlayer.GetTeamCharacter(i) == behave)
			{
				return true;
			}
		}
		return false;
	}

	public void ResetPosition()
	{
		int activeChunkId = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = mainEntity.GetCompPhysics().lastGroundPoint,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		TeleportUtility.TeleportWithNone(activeChunkId, teleportParams).Forget();
	}

	public async UniTask WaitLoaderState()
	{
		if (!Singleton<LoadManager>.instance.InLoading || Singleton<LoadManager>.instance.IsComplete)
		{
			await UniTask.CompletedTask;
			return;
		}
		await UniTask.WaitUntil(() => Singleton<LoadManager>.instance.IsComplete);
	}

	public async void ChangeCharacter(int index)
	{
		UIState viewState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_BATTLEMAIN);
		if (viewState != UIState.Opened)
		{
			await UniTask.WaitUntil(() => viewState == UIState.Opened);
		}
		Entity last = mainEntity;
		Entity teamCharacter = localPlayer.GetTeamCharacter(index);
		if (sceneStatus == SceneStatus.Rogue)
		{
			RogueAssistSkill(teamCharacter, index);
		}
		else
		{
			ChangeCharacter(last, teamCharacter);
		}
	}

	public async void ChangeCharacter(Entity entity)
	{
		UIState viewState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_BATTLEMAIN);
		if (viewState != UIState.Opened)
		{
			await UniTask.WaitUntil(() => viewState == UIState.Opened);
		}
		Entity last = mainEntity;
		if (sceneStatus == SceneStatus.Rogue)
		{
			RogueAssistSkill(entity, 1);
		}
		else
		{
			ChangeCharacter(last, entity);
		}
	}

	public void SwitchButton(int index)
	{
		Entity teamCharacter = localPlayer.GetTeamCharacter(index);
		if (teamCharacter.IsValid && !(teamCharacter == mainEntity) && teamCharacter.IsAlive() && Mathf.Approximately(teamCharacter.GetChangeCd(), 0f) && !InPlayerTag(PlayerTag.BackTrace))
		{
			ChangeCharacter(index);
		}
	}

	public void EntityDither(Entity entity, float duration, bool isShow)
	{
		AniPartControl aniControl = entity.GetMono().aniControl;
		if (!(aniControl == null))
		{
			if (isShow)
			{
				entity.ShowRoot();
				PlayDitherVisible(aniControl, entity, duration, null);
				return;
			}
			entity.HideRoot();
			aniControl.PlayHidden(AniPartControl.PartType.Dither, duration, entity, null, reset: true);
			CompBehave? compBehave = entity.GetCompBehave();
			compBehave.InvokeOnInactive();
			compBehave.ClearOnInteract();
		}
	}

	public void EntityDitherPure(Entity entity, float duration, bool isShow)
	{
		AniPartControl aniControl = entity.GetMono().aniControl;
		if (!(aniControl == null))
		{
			if (isShow)
			{
				entity.ShowRoot();
				PlayDitherVisible(aniControl, entity, duration, null);
			}
			else
			{
				entity.HideRoot();
				aniControl.PlayHidden(AniPartControl.PartType.Dither, duration, entity, null, reset: true);
			}
		}
	}

	public void EntityDitherPureCallback(Entity entity, float duration, bool isShow, Action callback)
	{
		AniPartControl aniControl = entity.GetMono().aniControl;
		if (!(aniControl == null))
		{
			if (isShow)
			{
				PlayDitherVisible(aniControl, entity, duration, callback);
			}
			else
			{
				aniControl.PlayHidden(AniPartControl.PartType.Dither, duration, entity, callback, reset: true);
			}
		}
	}

	public void EntityDitherResetVisible(Entity entity)
	{
		AniPartControl aniPartControl = entity.GetMono()?.aniControl;
		if (!(aniPartControl == null))
		{
			aniPartControl.ResetVisibilityToVisible(AniPartControl.PartType.Dither);
		}
	}

	private static void PlayDitherVisible(AniPartControl ani, Entity entity, float duration, Action callback)
	{
		ani.PlayVisible(AniPartControl.PartType.Dither, duration, entity, callback, reset: true);
	}

	public void EntityDissolve(Entity entity, float duration, bool isShow, bool isChangeRoot = true)
	{
		AniPartControl aniPartControl = entity.GetMono()?.aniControl;
		if (aniPartControl == null)
		{
			return;
		}
		if (isShow)
		{
			if (isChangeRoot)
			{
				entity.ShowRoot();
			}
			aniPartControl.PlayVisible(AniPartControl.PartType.Dissolve, duration, entity, null, reset: true);
		}
		else
		{
			if (isChangeRoot)
			{
				entity.HideRoot();
			}
			aniPartControl.PlayHidden(AniPartControl.PartType.Dissolve, duration, entity, null, reset: true);
		}
	}

	public void EntityEnableBodyPart(Entity entity, bool enable)
	{
		MonoBodyPart[] bodyParts = entity.GetMono().bodyParts;
		foreach (MonoBodyPart monoBodyPart in bodyParts)
		{
			monoBodyPart.SetRuntimeActive(enable && !monoBodyPart.parryOnly);
		}
	}

	public async UniTask FireChangeEffect(Entity entity, YooAssetReference effect, float delayTime, bool isConnect = false, Vector3 p = default(Vector3), Transform endPos = null, Transform startPos = null, bool noOwner = false)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(delayTime));
		SystemEffect effectSystem = GameManager.effectSystem;
		if (isConnect)
		{
			effectSystem.FireConnectEffect(effect, p, Quaternion.identity, endPos, startPos);
			return;
		}
		if (noOwner)
		{
			effectSystem.FireEffect(effect, entity.GetRootTransform().position, Quaternion.identity);
			return;
		}
		EffectPoint point = default;
		EffectPoint point2 = default;
		point.continueouslyFollow = true;
		point.rotateFollowLogicDir = false;
		point.offset = Vector3.zero;
		point.useOwnerRot = false;
		point.oriRotX = 0f;
		point.oriRotY = 0f;
		point.oriRotZ = 0f;
		point.aimTarget = false;
		point.type = EffectPoint.EffectPointType.Character;
		SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
		{
			target = FindTargetResult.EntityOnly(entity),
			patternAssetID = effect,
			removeWhenMotionExit = false,
			timescale = TimeScale.NoScale,
			type = EffectDataType.Point,
			point1 = point,
			point2 = point2,
			removeWhenStop = false,
			changeScale = false,
			effectRangeEnum = EffectRangeEnum.none,
			transformScaleMulBase = Vector3.zero,
			modelType = EffectModelType.Small,
			isChangeWithEntity = false,
			initRotation = default,
			isAttach = false
		};
		effectSystem.FireEffect(effectParams);
	}

	private async UniTask HideCharacter(Entity entity, float delayTime, float transitionTime)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(delayTime));
		EntityDissolve(entity, transitionTime, isShow: false);
	}

	public void ChangeCharacter(Entity last, Entity next)
	{
		SystemAssist assistSystem = GameManager.assistSystem;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		SystemBehave behaveSystem = GameManager.behaveSystem;
		ConfigCharacter config = next.GetConfig();
		if (!next.IsAlive() || (next.InTag(MotionTag_backUp.SynergySkill) && next.IsActive()))
		{
			return;
		}
		(bool, bool) tuple = assistSystem.CanRemain(last, next);
		bool item = tuple.Item1;
		bool item2 = tuple.Item2;
		bool flag = last.InTag(MotionTag_backUp.SynergySkill);
		if (flag)
		{
			last.GetCompPhysics().SetRootTransformOffset(new Vector3(0f, 0f, 0.6f));
		}
		bool flag2 = flag || (item & item2);
		SwitchSkillPosData switchSkillPosData = abilitySystem.GetSwitchSkillPosData();
		bool flag3 = assistSystem.TryAssist(last, next, switchSkillPosData);
		CompPhysics.NormalSwitchMotionSnapshot snapshot = ((playState == PlayState.UnBattle && !flag3) ? last.GetCompPhysics().CaptureNormalSwitchMotionSnapshot() : default(CompPhysics.NormalSwitchMotionSnapshot));
		BattleCharacterChangeEvt evt = Singleton<EventManager>.instance.GetEvt<BattleCharacterChangeEvt>();
		evt.lastEb = last;
		evt.newEb = next;
		evt.index = localPlayer.IndexOfTeamCharacter(last);
		evt.switchSkill = flag3;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.BeforeBattleCharacterChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		if (flag3)
		{
			if (item)
			{
				assistSystem.TriggerRemain(last, item2);
			}
			abilitySystem.ChangeCharacterInheritAbility(last, next);
			if (config.UseSwitchSkillCharacterOffset && switchSkillPosData.uncrossableOffsetX == 0f)
			{
				bool flag4 = last.GetMotionBool("InAir") && config.UseAirSwitchSkillCharacterOffset;
				Vector2 airSwitchSkillCharacterOffset = config.AirSwitchSkillCharacterOffset;
				Vector2 switchSkillCharacterOffset = config.SwitchSkillCharacterOffset;
				Vector2 vector = (flag4 ? airSwitchSkillCharacterOffset : switchSkillCharacterOffset);
				EvtSetSwitchPosBaseOnCharacter evt2 = abilitySystem.GetEvt<EvtSetSwitchPosBaseOnCharacter>(next, null);
				evt2.mainEntity = next;
				evt2.beforeEntity = last;
				evt2.configPos = vector;
				evt2.target = switchSkillPosData.target;
				abilitySystem.FireEvt(evt2);
				abilitySystem.ReleaseEvt(evt2);
			}
			else
			{
				bool flag5 = switchSkillPosData.target.GetMotionBool("InAir") && config.UseAirOffset;
				Vector2 airSwitchSkillOffset = config.AirSwitchSkillOffset;
				Vector2 switchSkillOffset = config.switchSkillOffset;
				Vector2 vector2 = (flag5 ? airSwitchSkillOffset : switchSkillOffset);
				EvtSetSwitchPos evt3 = abilitySystem.GetEvt<EvtSetSwitchPos>(next, null);
				evt3.mainEntity = next;
				evt3.beforeEntity = last;
				evt3.configPos = vector2;
				evt3.data = switchSkillPosData;
				abilitySystem.FireEvt(evt3);
				abilitySystem.ReleaseEvt(evt3);
			}
			ShowNewCharacter(next);
			SetChangeParam(last, next, switchSkill: true);
			if (!flag2)
			{
				HideOldCharacter(last);
			}
			YooAssetReference effectAssetID = GameLoader.meta.switchSkillChangeCharacter.show.effectAssetID;
			if (effectAssetID.IsValid())
			{
				FireChangeEffect(next, effectAssetID, GameLoader.meta.switchSkillChangeCharacter.show.delayTime, isConnect: false, default, null, null, noOwner: true).Forget();
			}
			AudioEventReference audioSoundEvent = GameLoader.meta.switchSkillChangeCharacter.show.audioSoundEvent;
			if (!audioSoundEvent.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
				{
					attachTarget = next.GetRootTransform()
				});
			}
			State state = behaveSystem.FindAttackMotionState(next, "attack_switch_in");
			behaveSystem.ForcedChangeToMotionState(next, state);
			EvtSwitchSKill evt4 = abilitySystem.GetEvt<EvtSwitchSKill>(next, null);
			evt4.mainEntity = next;
			abilitySystem.FireEvt(evt4);
			abilitySystem.ReleaseEvt(evt4);
		}
		else
		{
			if (last.InTag(MotionTag_backUp.ForbidSwitch))
			{
				return;
			}
			if (item)
			{
				assistSystem.TriggerRemain(last, item2);
			}
			abilitySystem.ChangeCharacterInheritAbility(last, next);
			if (playState == PlayState.Battle)
			{
				if (TrySetSwitchPos(last, next))
				{
					YooAssetReference effectAssetID2 = GameLoader.meta.battleChangeCharacter.show.effectAssetID;
					if (effectAssetID2.IsValid())
					{
						FireChangeEffect(next, effectAssetID2, GameLoader.meta.battleChangeCharacter.show.delayTime, isConnect: false, default, null, null, noOwner: true).Forget();
					}
					AudioEventReference audioSoundEvent2 = GameLoader.meta.battleChangeCharacter.show.audioSoundEvent;
					if (!audioSoundEvent2.IsNull())
					{
						Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent2, new AudioPlayOptions
						{
							attachTarget = next.GetRootTransform()
						});
					}
				}
				else if (!GameLoader.meta.switchOutSoundEvent.IsNull())
				{
					Singleton<GameManager>.instance.audioManager.PlaySound(GameLoader.meta.switchOutSoundEvent, new AudioPlayOptions
					{
						attachTarget = next.GetRootTransform()
					});
				}
			}
			else
			{
				CompTransform compTransform = last.GetCompTransform();
				Vector3 physicsPosition = compTransform.physicsPosition;
				next.GetCompTransform().SetPositionImmediately(physicsPosition);
				next.SetFaceDir(compTransform.FaceDir);
			}
			ShowNewCharacter(next);
			SetChangeParam(last, next, switchSkill: false);
			if (!flag2)
			{
				HideOldCharacter(last);
			}
			if (playState != PlayState.UnBattle)
			{
				if (next.TryGetCompPhysics(out CompPhysics component))
				{
					component.rawVelocity = Vector3.zero;
				}
				State state2 = behaveSystem.FindMotionState(next, "normal_switch_in");
				behaveSystem.ForcedChangeToMotionState(next, state2);
			}
			else
			{
				RestoreUnBattleNormalSwitchMotion(last, next, snapshot);
				FixRoleAirSwitchWeaponVisibility(next);
			}
		}
		abilitySystem.ReleaseSwitchSkillPosData(switchSkillPosData);
		FireChangeEvt(last, next, flag3, isResurgence: false);
		config.stateChangeActions?.TriggerCustomStateChangeAction(last.GetCompMotion().layer0Peak.state.value.stateType, next.GetCompMotion().layer0Peak.state.value.stateType, next, StateChangeActionType.SwitchBehave);
		next.GetCompHatred().battleStartTimeStamp = TimeManager.LocalTime.NowTimestamp;
		last.GetCompHatred().battleStartTimeStamp = 0L;
	}

	private Vector3 GetCenterPos(Entity behave)
	{
		return behave.GetRootTransform().position + behave.GetCompPhysics().characterMovement.height / 2f * Vector3.up;
	}

	private bool TrySetSwitchSkillPos(Entity before, Entity after, int level)
	{
		ConfigCharacter config = after.GetConfig();
		Vector2 lvOffset = (((object)config != null && config.assistSkills?.Length > 0) ? config.assistSkills[level - 1].positionOffset : Vector2.zero);
		bool setGround = (object)config != null && config.assistSkills?.Length > 0 && config.assistSkills[level - 1].setGround;
		return TrySetSwitchPosInternal(before, after, config.switchSkillForwardBounds, config.switchSkillBackBounds, lvOffset, setGround);
	}

	private bool TrySetSwitchPos(Entity before, Entity after)
	{
		ConfigCharacter config = after.GetConfig();
		return TrySetSwitchPosInternal(before, after, config.forwardBounds, config.backBounds, config.AirSwitchOffset, config.switchOffset);
	}

	private bool TrySetSwitchPosInternal(Entity before, Entity after, TargetBounds forwardBounds, TargetBounds backBounds, Vector2 airOffset, Vector2 groundOffset)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		SwitchSkillPosData switchSkillPosData = abilitySystem.GetSwitchSkillPosData();
		EvtFindSwitchPos evt = abilitySystem.GetEvt<EvtFindSwitchPos>(after, null);
		evt.mainEntity = after;
		evt.beforeEntity = before;
		evt.forwardBounds = forwardBounds;
		evt.backBounds = backBounds;
		evt.data = switchSkillPosData;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		bool isValid = switchSkillPosData.target.IsValid;
		ConfigCharacter config = after.GetConfig();
		if (config.UseBattleCharacterOffset && switchSkillPosData.uncrossableOffsetX == 0f)
		{
			bool flag = before.GetMotionBool("InAir") && config.UseAirBattleCharacterOffset;
			Vector2 airBattleCharacterOffset = config.AirBattleCharacterOffset;
			Vector2 battleCharacterOffset = config.BattleCharacterOffset;
			Vector2 vector = (flag ? airBattleCharacterOffset : battleCharacterOffset);
			EvtSetSwitchPosBaseOnCharacter evt2 = abilitySystem.GetEvt<EvtSetSwitchPosBaseOnCharacter>(after, null);
			evt2.mainEntity = after;
			evt2.beforeEntity = before;
			evt2.configPos = vector;
			evt2.target = switchSkillPosData.target;
			abilitySystem.FireEvt(evt2);
			abilitySystem.ReleaseEvt(evt2);
		}
		else if (isValid)
		{
			Vector2 vector2 = ((switchSkillPosData.target.GetMotionBool("InAir") && after.GetConfig().UseAirOffset) ? airOffset : groundOffset);
			EvtSetSwitchPos evt3 = abilitySystem.GetEvt<EvtSetSwitchPos>(after, null);
			evt3.mainEntity = after;
			evt3.beforeEntity = before;
			evt3.configPos = vector2;
			evt3.data = switchSkillPosData;
			abilitySystem.FireEvt(evt3);
			abilitySystem.ReleaseEvt(evt3);
		}
		else
		{
			CompTransform compTransform = before.GetCompTransform();
			Vector3 physicsPosition = compTransform.physicsPosition;
			after.GetCompTransform().SetPositionImmediately(physicsPosition);
			after.SetFaceDir(compTransform.FaceDir);
		}
		abilitySystem.ReleaseSwitchSkillPosData(switchSkillPosData);
		return isValid;
	}

	private bool TrySetSwitchPosInternal(Entity before, Entity after, TargetBounds forwardBounds, TargetBounds backBounds, Vector2 lvOffset, bool setGround)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		SwitchSkillPosData switchSkillPosData = abilitySystem.GetSwitchSkillPosData();
		EvtFindSwitchPos evt = abilitySystem.GetEvt<EvtFindSwitchPos>(after, null);
		evt.mainEntity = after;
		evt.beforeEntity = before;
		evt.forwardBounds = forwardBounds;
		evt.backBounds = backBounds;
		evt.data = switchSkillPosData;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		Vector3 vector = (before.IsFaceRight() ? new Vector3(lvOffset.x, lvOffset.y, 0f) : new Vector3(0f - lvOffset.x, lvOffset.y, 0f));
		CompTransform compTransform = before.GetCompTransform();
		CompPhysics compPhysics = before.GetCompPhysics();
		Vector3 vector2 = compTransform.physicsPosition + vector;
		if (setGround)
		{
			CharacterMovement characterMovement = compPhysics.characterMovement;
			compPhysics.ExternalComputeGroundDistance(capsuleCenter: characterMovement.height * 0.5f * Vector3.up, characterPosition: characterMovement.position, height: characterMovement.height, radius: characterMovement.radius, rotation: compTransform.rotation, sweepDistance: 20f, castDistance: 20f, outGroundResult: out var outGroundResult, groundDistanceLayerMask: BattleConsts.enviromentMask);
			float num = (outGroundResult.hitGround ? outGroundResult.GetDistanceToGround() : 0f);
			vector2 += new Vector3(0f, 0f - num, 0f);
		}
		Vector3 direction = Vector3.right * (before.IsFaceRight() ? 1 : (-1));
		float radius = after.GetCompPhysics().characterMovement.radius;
		if (Physics.Raycast(vector2 + new Vector3(before.IsFaceRight() ? (0f - radius) : radius, 0f, 0f), direction, out var _, 2f, BattleConsts.enviromentMask))
		{
			float x = (before.IsFaceRight() ? (0f - radius) : radius);
			vector2 += new Vector3(x, 0f, 0f);
		}
		if (0 != 0)
		{
			EvtSetSwitchPos evt2 = abilitySystem.GetEvt<EvtSetSwitchPos>(after, null);
			evt2.mainEntity = after;
			evt2.beforeEntity = before;
			evt2.configPos = vector2;
			evt2.data = switchSkillPosData;
			abilitySystem.FireEvt(evt2);
			abilitySystem.ReleaseEvt(evt2);
		}
		else
		{
			after.GetCompTransform().SetPositionImmediately(vector2);
			after.SetFaceDir(compTransform.FaceDir);
		}
		abilitySystem.ReleaseSwitchSkillPosData(switchSkillPosData);
		return false;
	}

	private void ShowNewCharacter(Entity entity)
	{
		EntityDissolve(entity, GameLoader.meta.battleChangeCharacter.show.transitionTime, isShow: true);
		EntityDitherPure(entity, 0f, isShow: true);
		EntityEnableBodyPart(entity, enable: true);
	}

	private void HideOldCharacter(Entity before)
	{
		if (playState == PlayState.Battle)
		{
			YooAssetReference effectAssetID = GameLoader.meta.battleChangeCharacter.hide.effectAssetID;
			if (effectAssetID.IsValid())
			{
				FireChangeEffect(before, effectAssetID, GameLoader.meta.battleChangeCharacter.hide.delayTime, isConnect: false, default, null, null, noOwner: true).Forget();
			}
		}
		CompSound compSound = before.GetCompSound();
		if (compSound != null)
		{
			CompMotion compMotion = before.GetCompMotion();
			if (compMotion != null && compMotion.curMotionState != MotionState.Idle)
			{
				compSound.StopCurSound();
			}
		}
		SetBehaveActive(before, value: false);
		HideCharacter(before, GameLoader.meta.battleChangeCharacter.delayHideTime, GameLoader.meta.battleChangeCharacter.hide.transitionTime).Forget();
		EntityDitherPure(before, 0f, isShow: false);
		GameManager.behaveSystem.SetMotionMustDo(before);
		ResetEffect(before, isBack: true);
		before.SetBool("isActive", value: false);
		before.SetBool("WallClimb", value: false);
		GameObject weaponModel = before.GetMono().weaponModel;
		if ((object)weaponModel != null)
		{
			Animator component = weaponModel.GetComponent<Animator>();
			if (component != null)
			{
				component.SetTrigger(WeaponAnimExit);
			}
		}
	}

	private void FireChangeEvt(Entity before, Entity now, bool switchSkill, bool isResurgence)
	{
		BattleCharacterChangeEvt evt = Singleton<EventManager>.instance.GetEvt<BattleCharacterChangeEvt>();
		evt.lastEb = before;
		evt.newEb = now;
		evt.index = localPlayer.IndexOfTeamCharacter(before);
		evt.switchSkill = switchSkill;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.BattleCharacterChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtBattleChange evt2 = abilitySystem.GetEvt<EvtBattleChange>(now, null);
		evt2.next = now;
		evt2.last = before;
		evt2.mainEntity = now;
		ref EvtBattleChange.ChangeCharacterSource source = ref evt2.source;
		EvtBattleChange.ChangeCharacterSource changeCharacterSource;
		if (isResurgence)
		{
			changeCharacterSource = EvtBattleChange.ChangeCharacterSource.Die;
		}
		else
		{
			changeCharacterSource = (switchSkill ? EvtBattleChange.ChangeCharacterSource.PlayerAssistChange : EvtBattleChange.ChangeCharacterSource.PlayerChange);
		}
		source = changeCharacterSource;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
		SwitchRoleEvt evt3 = EventTrackSolver.Instance.GetEvt<SwitchRoleEvt>();
		evt3.switchInRole = now;
		evt3.switchOffRole = before;
		evt3.isAssist = switchSkill;
		EventTrackSolver.Instance.Dispatch(evt3);
	}

	private void SetChangeParam(Entity before, Entity now, bool switchSkill)
	{
		Renderer[] componentsInChildren = before.GetRootTransform().GetComponentsInChildren<Renderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.layer = 6;
		}
		before.GetCompTime().ClearSpeedTimer(TimeType.Witch);
		CompMotion? compMotion = before.GetCompMotion();
		compMotion.ResetTrigger(compMotion.lastConflictTrigger);
		compMotion.ChangeRestBool();
		SystemCamera cameraSystem = GameManager.cameraSystem;
		cameraSystem.ShowCharacterVCam(show: false, before.Id);
		cameraSystem.ShowCharacterVCam(show: true, now.Id, now);
		before.GetCompBehave().StartChangeCD(CoreUtils.GetChangeCD);
		before.SetBool("isControlled", value: false);
		CompPhysics compPhysics = now.GetCompPhysics();
		CompPhysics compPhysics2 = before.GetCompPhysics();
		compPhysics.characterMovement.ReplacePlatform(compPhysics2.characterMovement.movingPlatform);
		compPhysics2.characterMovement.SetPlatformAsNull();
		compPhysics.ClearPath();
		compPhysics.SetConstZ(compPhysics2.GetConstZ);
		CompTransform? compTransform = now.GetCompTransform();
		CompTransform compTransform2 = before.GetCompTransform();
		compTransform.physicsRotateDegree = compTransform2.physicsRotateDegree;
		SetBehaveActive(now, value: true);
		ResetEffect(now, isBack: false);
		if (!switchSkill && playState == PlayState.UnBattle && GameLoader.meta.switchOutReferenceAssetID.IsValid())
		{
			EffectPoint point = default;
			EffectPoint point2 = default;
			point.continueouslyFollow = true;
			point.rotateFollowLogicDir = false;
			point.offset = Vector3.zero;
			point.useOwnerRot = false;
			point.oriRotX = 0f;
			point.oriRotY = 0f;
			point.oriRotZ = 0f;
			point.aimTarget = false;
			point.type = EffectPoint.EffectPointType.Character;
			SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
			{
				target = FindTargetResult.EntityOnly(now),
				patternAssetID = GameLoader.meta.switchOutReferenceAssetID,
				removeWhenMotionExit = false,
				timescale = TimeScale.NoScale,
				type = EffectDataType.Point,
				point1 = point,
				point2 = point2,
				removeWhenStop = false,
				changeScale = false,
				effectRangeEnum = EffectRangeEnum.none,
				transformScaleMulBase = Vector3.zero,
				modelType = EffectModelType.Small,
				isChangeWithEntity = false,
				initRotation = default,
				isAttach = false
			};
			GameManager.effectSystem.FireEffect(effectParams);
		}
		if (!switchSkill && playState == PlayState.UnBattle && !GameLoader.meta.switchOutSoundEvent.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(GameLoader.meta.switchOutSoundEvent, new AudioPlayOptions
			{
				attachTarget = now.GetRootTransform()
			});
		}
		CompMotion? compMotion2 = now.GetCompMotion();
		CompMotion compMotion3 = before.GetCompMotion();
		compMotion2.SetBool("isActive", b: true);
		compMotion2.SetBool("isControlled", b: true);
		compMotion2.ReplaceMotionCount(before);
		compMotion3.RecoverMotionCount();
		compPhysics.SetMovementMode(compPhysics2.state);
		compTransform.compensationProgress = 1f;
		localPlayer.battleEntityIndex = localPlayer.IndexOfTeamCharacter(now);
		MPPlayer.local.SwitchCharacter(localPlayer.battleEntityIndex);
		if (localPlayer.robotEntity.IsValid)
		{
			localPlayer.robotEntity.GetCompProduct().caster = mainEntity;
		}
	}

	private void RestoreUnBattleNormalSwitchMotion(Entity before, Entity now, CompPhysics.NormalSwitchMotionSnapshot snapshot)
	{
		CompPhysics compPhysics = now.GetCompPhysics();
		SystemBehave behaveSystem = GameManager.behaveSystem;
		if (snapshot.isValid && compPhysics.PrepareNormalSwitchMotionRestore(in snapshot))
		{
			State state = behaveSystem.FindMotionState(now, snapshot.stateName);
			if (state != null && now.GetConfigMotion(state) != null)
			{
				behaveSystem.ForcedChangeToMotionState(now, state, snapshot.normalizedTime);
				compPhysics.RestoreNormalSwitchMotion(in snapshot);
				return;
			}
			compPhysics.AbortNormalSwitchMotionRestore();
		}
		CompMotion compMotion = before.GetCompMotion();
		bool flag = compMotion.layer0Peak != null && (compMotion.layer0Peak.state.value.name == "preRun" || compMotion.layer0Peak.state.value.name == "run" || compMotion.layer0Peak.state.value.name == "runTurn");
		int num;
		if (!snapshot.isValid)
		{
			if (before.GetMotionBool("InAir") || compMotion.curMotionState == MotionState.Jump)
			{
				num = 1;
				goto IL_0122;
			}
			num = ((before.GetCompPhysics().state == ACTMovementMode.Falling) ? 1 : 0);
		}
		else
		{
			num = (snapshot.isInAir ? 1 : 0);
		}
		if (num != 0)
		{
			goto IL_0122;
		}
		string text = (flag ? "run" : "normal_switch_in");
		goto IL_0127;
		IL_0122:
		text = "falling heavy";
		goto IL_0127;
		IL_0127:
		string text2 = text;
		State state2 = behaveSystem.FindMotionState(now, text2);
		behaveSystem.ForcedChangeToMotionState(now, state2);
		if (num != 0)
		{
			compPhysics.InheritAirSwitchPhysicsFrom(before.GetCompPhysics());
			compPhysics.SetMovementMode(ACTMovementMode.Falling);
			compPhysics.PauseGroundConstraint();
		}
	}

	private static void FixRoleAirSwitchWeaponVisibility(Entity entity)
	{
		CompPhysics compPhysics = entity.GetCompPhysics();
		if (entity.GetMotionBool("InAir") || entity.GetCompMotion().curMotionState == MotionState.Jump || compPhysics.state == ACTMovementMode.Falling)
		{
			AniPartControl aniPartControl = entity.GetMono()?.aniControl;
			if (!(aniPartControl == null))
			{
				aniPartControl.ResetVisibilityToVisible(AniPartControl.PartType.Dissolve);
				aniPartControl.PlayHidden(AniPartControl.PartType.WeaponDissolve, 0f, entity, null, reset: true);
			}
		}
	}

	public void ForceToIdle(Entity entityBehave)
	{
		entityBehave.SetBool("IsDead", value: false);
		SystemBehave behaveSystem = GameManager.behaveSystem;
		bool motionBool = entityBehave.GetMotionBool("Change");
		behaveSystem.ForcedChangeToMotionState(entityBehave, motionBool ? "born_c" : "born");
	}

	public void ShowCharacter(Entity entityBehave, bool show, bool isLeft, float degree, Vector3 pos, float z)
	{
		ForceToIdle(entityBehave);
		ResetEffect(entityBehave, isBack: true);
		CompPhysics compPhysics = entityBehave.GetCompPhysics();
		CompTransform compTransform = entityBehave.GetCompTransform();
		CompMotion? compMotion = entityBehave.GetCompMotion();
		CompBehave compBehave = entityBehave.GetCompBehave();
		if (show)
		{
			compPhysics.ClearPath();
			compPhysics.SetConstZ(z);
			compTransform.compensationProgress = 1f;
			compBehave.Root.transform.position = pos;
			compTransform.physicsRotateDegree = degree;
			entityBehave.SetFaceLeft(isLeft);
		}
		compTransform.InitPosition(pos);
		compMotion.ResetTrigger(compMotion.lastConflictTrigger);
		compPhysics.lastFramePathLocalVelocity = (compPhysics.velocity = Vector3.zero);
		compPhysics.characterMovement.rigidbody.velocity = Vector3.zero;
		compBehave.ChangeCD = 0f;
		compMotion.SetBool("isControlled", show);
		compMotion.SetBool("isActive", show);
		compMotion.RecoverMotionCount();
		SetBehaveActive(entityBehave, show);
		EntityDissolve(entityBehave, 0f, show);
		EntityDitherPure(entityBehave, 0f, show);
	}

	public void ResetEffect(Entity entity, bool isBack)
	{
		CompEffect compEffect = entity.GetCompEffect();
		for (int num = compEffect.myEffects.Count - 1; num >= 0; num--)
		{
			compEffect.myEffects[num].SyncEffectActiveOrNot(!isBack);
		}
	}

	public void RogueAssistSkill(Entity next, int index)
	{
		List<RogueBagItemData> rogueBagByType = Model<RogueNewModel>.Interface.GetRogueBagByType(2);
		int num = 0;
		foreach (RogueBagItemData item in rogueBagByType)
		{
			if (item.RogueItem.Position == index - 1)
			{
				num = item.RogueItem.ItemId;
			}
		}
		if (num == 0)
		{
			return;
		}
		int num2 = CoreUtils.GetData(num, RuntimeConfigs.data.rogueAssistCharacters)?.tier ?? 1;
		if (next.IsAlive() && next.GetConfig().assistSkills != null && GameManager.assistSystem.TryRogueAssist(mainEntity, next))
		{
			GameManager.abilitySystem.ChangeCharacterInheritAbility(mainEntity, next);
			TrySetSwitchSkillPos(mainEntity, next, num2);
			SetAssitRoleParam(mainEntity, next, num2);
			EntityDissolve(next, GameLoader.meta.switchSkillChangeCharacter.show.transitionTime, isShow: true);
			EntityDitherPure(next, 0f, isShow: true);
			if (GameLoader.meta.switchSkillChangeCharacter.show.effectAssetID.IsValid())
			{
				FireChangeEffect(next, GameLoader.meta.switchSkillChangeCharacter.show.effectAssetID, GameLoader.meta.switchSkillChangeCharacter.show.delayTime, isConnect: false, default, null, null, noOwner: true).Forget();
			}
			AudioEventReference audioSoundEvent = GameLoader.meta.switchSkillChangeCharacter.show.audioSoundEvent;
			if (!audioSoundEvent.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
				{
					attachTarget = next.GetRootTransform()
				});
			}
			ConfigCharacter config = next.GetConfig();
			string text = (((object)config != null && config.assistSkills?.Length > 0) ? config.assistSkills[num2 - 1].motionName : "attack_switch_in");
			SystemBehave behaveSystem = GameManager.behaveSystem;
			State state = behaveSystem.FindAttackMotionState(next, text);
			if (state == null)
			{
				Debug.LogError("找不到援护技动作：" + text);
				HideCharacter(next, 3f, GameLoader.meta.switchSkillChangeCharacter.hide.transitionTime).Forget();
				return;
			}
			behaveSystem.ForcedChangeToMotionState(next, state);
			SystemAbility abilitySystem = GameManager.abilitySystem;
			EvtAssistSKill evt = abilitySystem.GetEvt<EvtAssistSKill>(next, null);
			evt.mainEntity = mainEntity;
			evt.index = localPlayer.IndexOfTeamCharacter(next);
			evt.level = num2;
			abilitySystem.FireEvt(evt);
			abilitySystem.ReleaseEvt(evt);
			next.GetCompBehave().EntityTags.AddTag(EntityTag.IgnoreTrap);
			next.GetCompAbility().AddAbility(next, "Rogueability_list_assistSkill_wudi", AbilitySource.None, default, 1);
			HideCharacter(next, 3f, GameLoader.meta.switchSkillChangeCharacter.hide.transitionTime).Forget();
		}
	}

	private void SetAssitRoleParam(Entity before, Entity now, int level)
	{
		CompPhysics compPhysics = now.GetCompPhysics();
		CompPhysics compPhysics2 = before.GetCompPhysics();
		Renderer[] componentsInChildren = before.GetRoot().GetComponentsInChildren<Renderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.layer = 6;
		}
		ConfigCharacter config = now.GetConfig();
		float defaultDuration = (((object)config != null && config.assistSkills?.Length > 0) ? config.assistSkills[level - 1].CD : 1f);
		now.GetCompBehave().StartChangeCD(defaultDuration);
		compPhysics.ClearPath();
		compPhysics.SetConstZ(compPhysics2.GetConstZ);
		CompTransform compTransform = now.GetCompTransform();
		CompTransform compTransform2 = before.GetCompTransform();
		compTransform.physicsRotateDegree = compTransform2.physicsRotateDegree;
		compPhysics.characterMovement.velocity = compPhysics2.characterMovement.velocity;
		compPhysics.rawVelocity = compPhysics2.rawVelocity;
		SetBehaveActive(now, value: true);
		ResetEffect(now, isBack: false);
		now.GetCompMotion().ReplaceMotionCount(before);
		compPhysics.SetMovementMode(compPhysics2.state);
		compTransform.compensationProgress = 1f;
	}

	private static void SetCameraVolumeLayerMask(Camera cam, int layer)
	{
		if (!(cam == null))
		{
			UniversalAdditionalCameraData component = cam.GetComponent<UniversalAdditionalCameraData>();
			if (component != null)
			{
				component.volumeLayerMask = 1 << layer;
			}
		}
	}

	public async void HideScene(bool state)
	{
		Camera component = GameUtility.mainCamera.GetComponent<Camera>();
		if (state)
		{
			characterRender.Clear();
			m_initMask = component.cullingMask;
			Renderer[] componentsInChildren = mainEntity.GetRoot().GetComponentsInChildren<Renderer>();
			foreach (Renderer renderer in componentsInChildren)
			{
				characterRender.Add(renderer);
				renderer.gameObject.layer = 16;
			}
			component.cullingMask = 65536;
			SetCameraVolumeLayerMask(component, 16);
			return;
		}
		component.cullingMask = m_initMask;
		SetCameraVolumeLayerMask(component, 0);
		foreach (Renderer item in characterRender)
		{
			item.gameObject.layer = 6;
		}
	}

	public async void HideScene(Entity entityRef, bool state)
	{
		Camera component = GameUtility.mainCamera.GetComponent<Camera>();
		if (state)
		{
			characterRender.Clear();
			m_initMask = component.cullingMask;
			Renderer[] componentsInChildren = entityRef.GetRoot().GetComponentsInChildren<Renderer>();
			foreach (Renderer renderer in componentsInChildren)
			{
				characterRender.Add(renderer);
				renderer.gameObject.layer = 16;
			}
			component.cullingMask = 65536;
			SetCameraVolumeLayerMask(component, 16);
			return;
		}
		component.cullingMask = m_initMask;
		SetCameraVolumeLayerMask(component, 0);
		foreach (Renderer item in characterRender)
		{
			item.gameObject.layer = 6;
		}
	}

	public void ChangeListener()
	{
		if (!GameUtility.mainCamera)
		{
			return;
		}
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = GameUtility.mainCamera.GetComponent<CinemachineBrain>().ActiveVirtualCamera as CinemachineVirtualCameraBase;
		if (cinemachineVirtualCameraBase != null && cinemachineVirtualCameraBase.isListener)
		{
			Singleton<GameManager>.instance.audioManager.SetListener(cinemachineVirtualCameraBase.gameObject, 1);
		}
		else if (localPlayer != null)
		{
			GameObject model = mainEntity.GetModel();
			if ((object)model != null)
			{
				Singleton<GameManager>.instance.audioManager.SetListener(model, 0);
			}
		}
	}

	private void InitializeRoots()
	{
		EnsureRootsParent();
		SceneRootType[] allRootTypes = AllRootTypes;
		foreach (SceneRootType sceneRootType in allRootTypes)
		{
			if (!rootDic.TryGetValue(sceneRootType, out var value) || value == null)
			{
				rootDic[sceneRootType] = CreateRootGO(sceneRootType);
			}
		}
	}

	private void ReleaseRoots()
	{
		foreach (KeyValuePair<SceneRootType, GameObject> item in rootDic)
		{
			if (item.Value != null)
			{
				UnityEngine.Object.Destroy(item.Value);
			}
		}
		rootDic.Clear();
		if (_rootsParent != null)
		{
			UnityEngine.Object.Destroy(_rootsParent.gameObject);
			_rootsParent = null;
		}
	}

	private void EnsureRootsParent()
	{
		if (_rootsParent == null)
		{
			GameObject gameObject = new GameObject("GRoot");
			_rootsParent = gameObject.transform;
		}
	}

	private GameObject CreateRootGO(SceneRootType type)
	{
		GameObject gameObject = new GameObject(type.ToString());
		gameObject.transform.SetParent(_rootsParent, worldPositionStays: false);
		return gameObject;
	}

	public GameObject GetRoot(SceneRootType type)
	{
		EnsureRootsParent();
		if (!rootDic.TryGetValue(type, out var value) || value == null)
		{
			value = CreateRootGO(type);
			rootDic[type] = value;
		}
		return value;
	}

	public async UniTaskVoid CoSynchronizationTime()
	{
		if (isSyncCharacterStatus)
		{
			return;
		}
		isSyncCharacterStatus = true;
		await UniTask.WaitUntil(() => isStartWorld);
		float pingInterval = 7.5f;
		float nextPingTime = 0f;
		CoSyncCharacterStatus().Forget();
		while (isStartWorld)
		{
			if (Time.unscaledTime >= nextPingTime)
			{
				G.service.PingMessage();
				nextPingTime = Time.unscaledTime + pingInterval;
			}
			await UniTask.DelayFrame(1);
		}
		isSyncCharacterStatus = false;
	}

	public void ResetPingMessage(long offset)
	{
		pingTimeOffset = offset;
	}

	private async UniTaskVoid CoSyncCharacterStatus()
	{
		if (GameUtility.gameLoader.mode != GameLoader.GameMode.Network)
		{
			return;
		}
		await UniTask.WaitUntil(() => isStartWorld);
		float nextSyncTime = Time.unscaledTime + 2f;
		while (isStartWorld)
		{
			if (Time.unscaledTime < nextSyncTime)
			{
				await UniTask.DelayFrame(1);
				continue;
			}
			nextSyncTime = Time.unscaledTime + 2f;
			if (CanAutoSyncPlayerInfo())
			{
				SyncPassiveGameInfos();
			}
			await UniTask.DelayFrame(1);
		}
	}

	private bool CanAutoSyncPlayerInfo()
	{
		if (!running || G.localPlayer.Profile.SceneStatus != sceneStatus)
		{
			return false;
		}
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		if (topActivePanel != null && topActivePanel.UIType == UI_TYPE.UI_BATTLEMAIN && !IsInTrainingground && !IsInTemple && !IsInAbyss && !IsLoadSubScene)
		{
			return !IsInRogue;
		}
		return false;
	}

	private void UpdatePlayerSyncData()
	{
		if (localPlayer != null && (!Model<TrialCharacterModel>.HasInstance() || !Model<TrialCharacterModel>.Interface.IsTrialMode))
		{
			CollectPlayerPositionSyncData(localPlayer.battleEntity);
			CollectCharacterStatusSyncData();
		}
	}

	private void CollectPlayerPositionSyncData(Entity battleEntity)
	{
		if (battleEntity.IsValid && battleEntity.TryGetCompPhysics(out CompPhysics component))
		{
			_playerSyncData.UpdatePosition(component.SyncPosition);
		}
	}

	public void InitializePlayerSyncPosition(Vector3 spawnPosition)
	{
		_playerSyncData.SetInitialPosition(spawnPosition);
	}

	private void CollectCharacterStatusSyncData()
	{
		ACT.Config.Game game = RuntimeConfigs.data?.game;
		if (game == null)
		{
			return;
		}
		_playerSyncData.ResetCharacterStatuses();
		int hpSync = game.hpSync;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid && teamCharacter.TryGetCompAbility(out CompAbility component) && teamCharacter.TryGetCompCharacter(out CompCharacter component2) && component2.characterSource != null)
			{
				int hp = Mathf.CeilToInt((float)component.hp * 1f / (float)component.maxHP * (float)hpSync);
				_playerSyncData.AddCharacterStatus(new CharacterStatusSyncData(component2.characterSource.Id(), hp, component.CurrentUltimateSkillValue, component.AssistValue, component.EnergyValue));
			}
		}
		Entity teamBattleEntity = localPlayer.TeamBattleEntity;
		if (teamBattleEntity.IsValid && teamBattleEntity.TryGetCompCharacter(out CompCharacter component3) && component3.characterSource != null)
		{
			_playerSyncData.SetBattleCharacterId(component3.characterSource.Id());
		}
	}

	private PBVector3 GetSyncTargetPosition()
	{
		if (Model<TrialCharacterModel>.HasInstance() && Model<TrialCharacterModel>.Interface.IsTrialMode && Model<TrialCharacterModel>.Interface.NormalSyncPosition != null)
		{
			return Model<TrialCharacterModel>.Interface.NormalSyncPosition.Clone();
		}
		Vector3 me;
		if (ShouldSyncTeleportPathCenter)
		{
			me = Singleton<TeleportMoveManager>.instance.PathCenter;
		}
		else
		{
			me = ((!ShouldUseMainWorldPositionForSync) ? _playerSyncData.Position : Model<TrainingGroundModel>.Interface.MainWorldBattleCharaPostion);
		}
		return me.ToPB();
	}

	private CharacterSyncInfo CreateCharacterSyncInfo()
	{
		if (Model<TrialCharacterModel>.HasInstance() && Model<TrialCharacterModel>.Interface.IsTrialMode && Model<TrialCharacterModel>.Interface.NormalCharacterSyncInfo != null)
		{
			return Model<TrialCharacterModel>.Interface.NormalCharacterSyncInfo.Clone();
		}
		CharacterSyncInfo characterSyncInfo = new CharacterSyncInfo
		{
			BattleCharacterId = _playerSyncData.BattleCharacterId
		};
		for (int i = 0; i < _playerSyncData.CharacterStatusCount; i++)
		{
			CharacterStatusSyncData characterStatusSyncData = _playerSyncData.CharacterStatuses[i];
			characterSyncInfo.Cs.Add(characterStatusSyncData.CharacterId, new CharacterStatus
			{
				Hp = characterStatusSyncData.Hp,
				ExPower = characterStatusSyncData.ExPower,
				AssistPower = characterStatusSyncData.AssistPower,
				EnergyPower = characterStatusSyncData.EnergyPower
			});
		}
		return characterSyncInfo;
	}

	private MapViewRecordParam GetMapViewRecordParam()
	{
		if (!Model<MapModel>.HasInstance())
		{
			return null;
		}
		try
		{
			MapViewRecordParam mapViewRecordParam = Model<MapModel>.Interface.GetMapViewRecordParam();
			if (mapViewRecordParam != null && mapViewRecordParam.Areas.Count > 0)
			{
				return mapViewRecordParam.Clone();
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("获取地图视野日志信息时发生异常:\n" + ex);
		}
		return null;
	}

	public SyncGameInfoReq GetSyncGameInfoReq()
	{
		return new SyncGameInfoReq
		{
			CharacterInfo = CreateCharacterSyncInfo(),
			MapViewRecordParam = GetMapViewRecordParam(),
			ChunkId = Singleton<GameManager>.instance.worldManager.ActiveChunkId,
			Wid = Singleton<GameManager>.instance.worldManager.ActiveWorldId,
			Position = GetSyncTargetPosition()
		};
	}

	public void SyncGameInfos()
	{
		if (RuntimeConfigs.data?.game == null)
		{
			return;
		}
		try
		{
			SyncGameInfoReq syncGameInfoReq = GetSyncGameInfoReq();
			ApplyLocalSyncSnapshot(syncGameInfoReq);
			SendSyncGameInfo(syncGameInfoReq, CreateComparableRequest(syncGameInfoReq));
			ClearSyncedMapViewRecord();
		}
		catch (Exception ex)
		{
			Debug.LogError("主动同步游戏信息时发生异常:\n" + ex);
		}
	}

	private void SyncPassiveGameInfos()
	{
		if (RuntimeConfigs.data?.game == null || !CanPassiveSyncPlayerInfo())
		{
			return;
		}
		try
		{
			SyncGameInfoReq syncGameInfoReq = GetSyncGameInfoReq();
			if (ShouldSendPassiveSyncGameInfo(syncGameInfoReq, out var comparableRequest))
			{
				ApplyLocalSyncSnapshot(syncGameInfoReq);
				SendSyncGameInfo(syncGameInfoReq, comparableRequest);
				ClearSyncedMapViewRecord();
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("被动同步游戏信息时发生异常:\n" + ex);
		}
	}

	private void ClearSyncedMapViewRecord()
	{
		if (Model<MapModel>.HasInstance())
		{
			Model<MapModel>.Interface.ClearAllMapViewRecordParam();
		}
	}

	private bool CanPassiveSyncPlayerInfo()
	{
		if (DisableSyncSceneStatus.Contains(sceneStatus) || (Singleton<EnvironmentInfoManager>.instance.environmentState & EnvironmentState.ForbideSyncGameInfo) > EnvironmentState.None || Singleton<GameState>.instance.BattleFormState == BattleFormState.Seal || Singleton<ChaseBattleManager>.instance.IsInChaseBattle || Singleton<GameState>.instance.RunningState != GameRunningState.Playing || (Singleton<ArchiveManager>.HasInstance() && Singleton<ArchiveManager>.instance.IsManualArchiving) || Model<InteractModel>.Interface.ElevatorRunningInSide || instance.InPlayerTag(PlayerTag.PathSwitchMove))
		{
			return false;
		}
		return true;
	}

	private bool ShouldSendPassiveSyncGameInfo(SyncGameInfoReq syncInfo, out SyncGameInfoReq comparableRequest)
	{
		comparableRequest = CreateComparableRequest(syncInfo);
		if (HasMapViewRecord(syncInfo))
		{
			return true;
		}
		return !IsSameSyncData(_lastSyncedComparableRequest, comparableRequest);
	}

	private SyncGameInfoReq CreateComparableRequest(SyncGameInfoReq syncInfo)
	{
		SyncGameInfoReq syncGameInfoReq = syncInfo.Clone();
		syncGameInfoReq.MapViewRecordParam = null;
		return syncGameInfoReq;
	}

	private static bool HasMapViewRecord(SyncGameInfoReq syncInfo)
	{
		if (syncInfo.MapViewRecordParam != null)
		{
			return syncInfo.MapViewRecordParam.Areas.Count > 0;
		}
		return false;
	}

	private static bool IsSameSyncData(SyncGameInfoReq left, SyncGameInfoReq right)
	{
		return left?.Equals(right) ?? false;
	}

	private void ApplyLocalSyncSnapshot(SyncGameInfoReq syncInfo)
	{
		if (syncInfo.Position != null && syncInfo.Wid == Singleton<GameManager>.instance.worldManager.ActiveWorldId)
		{
			int key = (int)sceneStatus;
			if (G.localPlayer.Profile.SceneInfos.TryGetValue(key, out var value))
			{
				value.LastPos = syncInfo.Position;
				value.ChunkID = syncInfo.ChunkId;
				value.WorldID = syncInfo.Wid;
			}
			else
			{
				G.localPlayer.Profile.SceneInfos.Add(key, new SceneInfo
				{
					LastPos = syncInfo.Position,
					ChunkID = syncInfo.ChunkId,
					WorldID = syncInfo.Wid
				});
			}
		}
		if (syncInfo.CharacterInfo == null)
		{
			return;
		}
		foreach (KeyValuePair<int, CharacterStatus> c in syncInfo.CharacterInfo.Cs)
		{
			Character curCharacterByCharacterId = CharacterDataHelper.GetCurCharacterByCharacterId(c.Key);
			if (curCharacterByCharacterId != null)
			{
				curCharacterByCharacterId.Status = c.Value;
			}
		}
	}

	private void SendSyncGameInfo(SyncGameInfoReq syncInfo, SyncGameInfoReq comparableRequest)
	{
		G.service.SyncGameInfoReq(syncInfo, null);
		_lastSyncedComparableRequest = comparableRequest;
	}

	public void SceneChangeComplete(SceneStatus status)
	{
		IsLoadSubScene = false;
		clientSceneStatus = status;
		SceneChangeEvt evt = Singleton<EventManager>.instance.GetEvt<SceneChangeEvt>();
		evt.newScene = status;
		evt.enterWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		evt.leaveWorldId = Singleton<GameManager>.instance.worldManager.LastWorldId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Scene_Change_Complete, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public async void TrainingGroundSpawnEnemy()
	{
		await KillAllTrainingGroundEnemy();
		SpawnMonsterData().Forget();
	}

	public UniTask KillAllTrainingGroundEnemy(bool immediately = false)
	{
		foreach (Entity tgMonster in m_tgMonsters)
		{
			if (tgMonster.IsValid && tgMonster.GetCompAlliance().alliance == Alliance.Enemy && tgMonster.CanRemove())
			{
				tgMonster.GetCompAbility().onDie -= new Action<Entity>(OnEnemyDie);
				if (immediately)
				{
					TryRemoveBehave(tgMonster);
				}
				else
				{
					tgMonster.KillEntity();
				}
			}
		}
		m_tgMonsters.Clear();
		return UniTask.CompletedTask;
	}

	private async UniTaskVoid SpawnMonsterData()
	{
		TrainingGroundModel.EnemyConfig enemyConfig = Model<TrainingGroundModel>.Interface.enemyConfig;
		int enemyId = enemyConfig.enemyId;
		SpawnMonsterParams param = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		param.id = enemyId;
		param.monsterPointId = enemyId;
		param.levelType = -1;
		param.pos = Vector3.zero;
		param.buffList = null;
		param.isLeft = true;
		param.groupUid = -1;
		param.groupAi = -1;
		param.levelType = 1;
		param.level = enemyConfig.level;
		param.aiIndex = enemyConfig.aiIndex;
		param.isHaveBornEffect = true;
		param.hatredSize = new Vector3(50f, 50f, 50f);
		param.loseBattleSize = new Vector3(50f, 50f, 50f);
		await UniTask.Delay(TimeSpan.FromSeconds(0.20000000298023224));
		SpawnMonster(param);
	}

	private async void SpawnMonster(SpawnMonsterParams param)
	{
		TrainingGroundModel.EnemyConfig enemyConfig = Model<TrainingGroundModel>.Interface.enemyConfig;
		Entity entity = GameManager.entities.factory.CreateEnemy(param.id);
		await CoServerSpawnMonster(entity, param);
		BSet<string> bSet = BSetPool<string>.Default.Get();
		ActBehaviorTree bTree = entity.GetBTree();
		if ((object)bTree != null && enemyConfig.useAi)
		{
			bSet.Add("TrainingGroundLockHatred");
			bTree.Pause();
		}
		EntityType entityType = entity.GetEntityType();
		if (entityType == EntityType.Elite || entityType == EntityType.Monster)
		{
			Singleton<EntityUIManager>.instance.Register(entity);
		}
		CompAbility compAbility = entity.GetCompAbility();
		if (enemyConfig.isLockBlood)
		{
			bSet.Add("TrainingGroundLockHp_Ability");
		}
		if (enemyConfig.isWeak && compAbility.ActivePosture)
		{
			bSet.Add("TrainingGroundRemainWeak");
		}
		compAbility.AddAbilities(bSet.ToArray(), AbilitySource.System);
		m_tgMonsters.Add(entity);
		compAbility.onDie += new Action<Entity>(OnEnemyDie);
		BSetPool<string>.Default.Recycle(bSet);
	}

	private void OnEnemyDie(Entity enemy)
	{
		m_tgMonsters.Remove(enemy);
		SpawnMonsterData().Forget();
	}

	private bool InitializeCharacterDataPart(Entity eb, ICharacterSource pbCharacter, out EntityCharacterData cData)
	{
		int key = pbCharacter.Id();
		if (!RuntimeConfigs.data.entityCharacterDatas.TryGetValue(key, out cData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"character {pbCharacter.Id()} not exist");
			}
			return false;
		}
		CompCharacter compCharacter = eb.GetCompCharacter();
		compCharacter.characterSource = pbCharacter;
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.Init(compCharacter);
		compAbility.InitCommon(RuntimeConfigs.data.entityDatas[cData.id]);
		eb.SetEntityType(cData.id);
		return true;
	}

	public void SpawnMonsterDataPart(int id, int level, int monsterPointId, Entity eb, out EntityEnemyData cData, bool levelOverride = false)
	{
		if (!RuntimeConfigs.data.entityEnemyDatas.TryGetValue(id, out cData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"monster {id} not exist");
			}
			return;
		}
		CompMonster compMonster = eb.AddComponent<CompMonster>();
		compMonster.id = id;
		compMonster.level = level;
		compMonster.monsterPointId = monsterPointId;
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.SetLevel(level, levelOverride);
		compAbility.Init(compMonster);
		compAbility.InitCommon(RuntimeConfigs.data.entityDatas[id]);
		eb.SetEntityType(id);
		GameManager.entityTickLodSystem?.Register(eb);
		SpawnMonsterDataPartEvt evt = Singleton<EventManager>.instance.GetEvt<SpawnMonsterDataPartEvt>();
		evt.entityBehave = eb;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnSpawnMonsterDataPart, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void SpawnAssistNpcDataPart(int id, int level, SpawnMonsterParams smp, Entity eb, out EntityEnemyData cData)
	{
		if (!RuntimeConfigs.data.entityEnemyDatas.TryGetValue(id, out cData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"assist npcId {id} not exist");
			}
			return;
		}
		CompAssistNpc compAssistNpc = eb.GetCompAssistNpc();
		compAssistNpc.npcId = id;
		compAssistNpc.id = smp.id;
		eb.GetCompAI().Init(smp);
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.SetLevel(level);
		compAbility.Init(compAssistNpc);
		compAbility.InitCommon(RuntimeConfigs.data.entityDatas[id]);
		eb.SetEntityType(EntityType.AssistNpc);
	}

	public void SpawnInteractObjectDataPart(int id, Entity eb, int trapType, int defenceTowerType, out EntityNeutralData cData)
	{
		if (!RuntimeConfigs.data.entityNeutralDatas.TryGetValue(id, out cData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"EntityNeutralData {id} not exist");
			}
			return;
		}
		CompNeutral compNeutral = eb.AddComponent<CompNeutral>();
		compNeutral.attackableId = id;
		compNeutral.trapType = trapType;
		compNeutral.defenceTowerType = defenceTowerType;
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.Init(compNeutral);
		compAbility.InitAttackEntityCommon(RuntimeConfigs.data.entityNeutralDatas[id]);
	}

	public async UniTask SpawnCharacterBattlePart(Entity entity, string configPath, Vector3 pos, bool isBornLeft, bool active = true)
	{
		CompBehave compBehave = entity.GetCompBehave();
		await compBehave.InitCharacter(configPath);
		if (!entity.IsValid)
		{
			return;
		}
		ConfigCharacter config = compBehave.Config;
		if (config == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("character " + configPath + " config not exist");
			}
			return;
		}
		GameObject root = compBehave.Root;
		CapsuleCollider component = root.GetComponent<CapsuleCollider>();
		CompTransform? compTransform = entity.GetCompTransform();
		compTransform.SetBaseCollider(component);
		if (!CompPhysics.IsGroundLikeMotion(config.motionType))
		{
			root.transform.position = pos;
		}
		else
		{
			root.transform.position = PhysicsUtility.GetGroundPoint(pos + component.center + new Vector3(0f, 0.05f, 0f), component.Size(), 5f) - component.center;
		}
		compTransform.InitPosition(root.transform.position);
		compBehave.SetupAnimator(compBehave.Model);
		CompPhysics? compPhysics = entity.GetCompPhysics();
		compPhysics.motion = config.motionType;
		compPhysics.SetConstZ(pos.z);
		CompMotion compMotion = entity.GetCompMotion();
		compMotion.Init(compBehave.Animator);
		CompAbility compAbility = entity.GetCompAbility();
		compAbility.BattleInit();
		CompAbilityBindAction(entity);
		SpawnBehave(entity, isBornLeft);
		entity.GetCompOperateBtn()?.InitTeamCharacterOperateBtnData();
		CompAim compAim = entity.GetCompAim();
		if ((bool)compAim.aimIK)
		{
			compAim.ikOriginTrans = compAim.aimIK.solver.transform;
		}
		CompSound compSound = entity.GetCompSound();
		if (config.audioConfig != null)
		{
			foreach (YooAssetReference item in config.audioConfig.FmodBanksAssetID)
			{
				compSound.LoadBank(item);
			}
			compSound.Init(config.audioConfig.ToVoiceMap());
		}
		else if (config.fmodBanksAssetID != null)
		{
			foreach (YooAssetReference item2 in config.fmodBanksAssetID)
			{
				compSound.LoadBank(item2);
			}
		}
		compAbility.AddAbilities(config.abilities, AbilitySource.Passive);
		if (config.abilitiyBindings != null)
		{
			compAbility.AddAbilitiesByBindings(config.abilitiyBindings);
		}
		CompCharacter compCharacter = entity.GetCompCharacter();
		if (compCharacter != null)
		{
			ICharacterSource characterSource = compCharacter.characterSource;
			if (characterSource is Character character)
			{
				foreach (KeyValuePair<int, int> skillGroupLevel in character.SkillGroupLevels)
				{
					SkillGroupData data = CoreUtils.GetData(skillGroupLevel.Key, RuntimeConfigs.data.skillGroupDatas);
					if (data == null || data.skillType != 12)
					{
						continue;
					}
					for (int i = 0; i < data.skillTotalIds.Length; i++)
					{
						SkillDetailData data2 = CoreUtils.GetData(data.skillTotalIds[i], RuntimeConfigs.data.skillDetailDatas);
						if (data2 != null && !compAbility.TryGetAbility(data2.abilityName, includeAdd: true, out var _))
						{
							compAbility.AddAbility(entity, data2.abilityName, AbilitySource.UpgradeSkill, new MPSkill
							{
								id = data2.id,
								level = (byte)skillGroupLevel.Value
							}, 1);
						}
					}
				}
			}
		}
		if (entity.GetCompCharacter() != null)
		{
			EntityType entityType = compBehave.EntityType;
			if (entityType == EntityType.Monster || entityType == EntityType.Boss || entityType == EntityType.Elite)
			{
				return;
			}
		}
		if (!string.IsNullOrEmpty(config.ultimetaTimelineAssetID.GUID))
		{
			AssetStationManager.BattleStation.InstantiateAsync(config.ultimetaTimelineAssetID, (AssetLoadHandle result) =>
			{
				GameObject gameObject = result.AsGameObject();
				gameObject.SetActive(value: false);
				compMotion.ultimetaTimeline = gameObject;
			});
		}
		if (!string.IsNullOrEmpty(config.monsterUltimetaTimelineAssetID.GUID))
		{
			AssetStationManager.BattleStation.InstantiateAsync(config.ultimetaTimelineAssetID, (AssetLoadHandle result) =>
			{
				GameObject gameObject = result.AsGameObject();
				gameObject.SetActive(value: false);
				compMotion.ultimetaTimeline = gameObject;
			});
		}
		SpawnCharacterBattlePartEvt evt = Singleton<EventManager>.instance.GetEvt<SpawnCharacterBattlePartEvt>();
		EffectDressRuntimeUtility.SyncDressFromCharacter(entity);
		evt.entityBehave = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnSpawnCharacterBattlePart, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void RemoveCharacterBattlePart(Entity eb, bool isTemp = false)
	{
		EffectDressRuntimeUtility.ClearAll(eb);
		eb.GetCompAbility().RemoveToBag();
		CompEffect compEffect = eb.GetCompEffect();
		for (int num = compEffect.myEffects.Count - 1; num >= 0; num--)
		{
			compEffect.myEffects[num].SyncEffectActiveOrNot(isShow: false);
		}
		eb.GetCompSound().ReleaseBanks();
		CompMotion compMotion = eb.GetCompMotion();
		if ((bool)compMotion.ultimetaTimeline)
		{
			AssetStationManager.BattleStation.ReleaseInstance(compMotion.ultimetaTimeline);
		}
		if (!isTemp)
		{
			GameManager.entities.factory.RemoveBattlePart(eb);
		}
		RemoveCharacterBattlePartEvt evt = Singleton<EventManager>.instance.GetEvt<RemoveCharacterBattlePartEvt>();
		evt.entityBehave = eb;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnRemoveCharacterBattlePart, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void ReleaseCharacterBattleEntity(Entity entity)
	{
		if (!entity.IsValid)
		{
			return;
		}
		if (entity.GetCompCharacter()?.characterSource is Character character)
		{
			CompAbility compAbility = entity.GetCompAbility();
			if (compAbility != null)
			{
				EntityHelper.WriteRuntimeAbilityToWorldStatus(character, compAbility);
				EntityHelper.UnregisterBattleEntity(character, entity);
			}
		}
		if (entity.GetCompTransform() != null)
		{
			RemoveCharacterBattlePart(entity);
		}
		GameManager.entities.factory.DestroyEntity(entity);
	}

	public async UniTask SpawnCharacterAIPart(Entity entity, int customAIIndex = -1, SpawnMonsterParams smp = null)
	{
		ConfigCharacter config = entity.GetConfig();
		CompAI compAI = entity.GetCompAI();
		compAI.Init(smp);
		entity.GetCompNav().isAir = config.motionType == MotionType.Air;
		BindNav(entity);
		bool flag;
		if (customAIIndex <= -1)
		{
			flag = await compAI.LoadAsync(config.AIConfig[0].behaviorTreeAssetID, smp);
		}
		else
		{
			flag = ((config.AIConfig != null && config.AIConfig.Length > customAIIndex) ? (await compAI.LoadAsync(config.AIConfig[customAIIndex].behaviorTreeAssetID, smp)) : (await compAI.LoadAsync(config.AIConfig[0].behaviorTreeAssetID, smp)));
		}
		if (flag)
		{
			entity.GetCompBehave().SetAINavAvailable();
		}
	}

	public void BindNav(Entity eb)
	{
		ACTNavMeshAgent component = eb.GetRoot().GetComponent<ACTNavMeshAgent>();
		CompNav? compNav = eb.GetCompNav();
		compNav.navMeshAgent = component;
		ConfigCharacter config = eb.GetConfig();
		NavigationMoveCapability moveCapability = (compNav.moveCapability = ((config != null && config.navigationMoveAbility == MonsterNavigationMoveAbility.JumpAndDrop) ? NavigationMoveCapability.WalkJumpAndDrop : NavigationMoveCapability.WalkAndDrop));
		if (component != null)
		{
			component.moveCapability = moveCapability;
		}
	}

	public async UniTask SpawnStateWorldAssetPart(Entity eb, int serviceSaveUid)
	{
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(serviceSaveUid);
		eb.GetCompStateObject().StateWorldAssetData = worldStateAssetDataBySGOID;
		await SpawnStateObjectBasePart(eb, worldStateAssetDataBySGOID.addressAssetID, worldStateAssetDataBySGOID.initPos, worldStateAssetDataBySGOID.initRotate, worldStateAssetDataBySGOID.useScale ? worldStateAssetDataBySGOID.initScale : Vector3.one, worldStateAssetDataBySGOID.transformParent);
	}

	public async UniTask ChangePosToParent(CancellationToken cancellationToken, int parentSwuid, Entity er, Quaternion rotate, Vector3 offset, StateObjectBase stateObjectBase)
	{
		if (!StateWorldAsset.TryGetWorldAssetBySwid(parentSwuid, out var stateWorldAsset))
		{
			await ruleManager.parentSwid.FirstAsync((int x) => x == parentSwuid, cancellationToken);
			if (cancellationToken.IsCancellationRequested)
			{
				Debug.LogWarning("交互物子物体在等待父物体生成，但是子物体被卸载了");
				return;
			}
			StateWorldAsset.TryGetWorldAssetBySwid(parentSwuid, out var stateWorldAsset2);
			SetConstraint(stateWorldAsset2, er, rotate, offset, stateObjectBase);
		}
		else
		{
			SetConstraint(stateWorldAsset, er, rotate, offset, stateObjectBase);
		}
	}

	private void SetConstraint(StateWorldAsset worldStateAsset, Entity er, Quaternion rotateOffset, Vector3 offset, StateObjectBase stateObjectBase)
	{
		if (stateObjectBase == null)
		{
			Debug.LogWarning("stateObjectBase == null");
			return;
		}
		if (worldStateAsset == null)
		{
			Debug.LogWarning("worldStateAsset == null");
			return;
		}
		if (worldStateAsset != null && !worldStateAsset.stateEntityRef.IsValid)
		{
			Debug.LogWarning("worldStateAsset.stateEntityRef.entity == null");
			return;
		}
		GameObject root = worldStateAsset.stateEntityRef.GetRoot();
		if ((object)root == null)
		{
			Debug.LogWarning("worldStateAsset.stateEntityRef.entity.root == null");
			return;
		}
		Rigidbody componentInChildren = root.GetComponentInChildren<Rigidbody>();
		if (componentInChildren != null)
		{
			if (componentInChildren.transform.localScale != Vector3.one)
			{
				_ = LuminApplication.LogEnabled;
			}
			if (worldStateAsset.stateObjectBase == null)
			{
				Debug.LogWarning("worldStateAsset.stateObjectBase == null");
			}
			Transform transform = worldStateAsset.stateObjectBase.OverrideSyncTransform(componentInChildren.transform);
			GameObject root2 = er.GetRoot();
			CompFollow compFollow = er.AddComponent<CompFollow>();
			compFollow.FollowTarget = transform;
			compFollow.FollowRigidbody = componentInChildren;
			compFollow.PositionOffset = offset;
			compFollow.RotationOffset = rotateOffset;
			FollowPlatformMotionSource orAddComponent = root2.GetOrAddComponent<FollowPlatformMotionSource>();
			orAddComponent.ResetPose();
			compFollow.PlatformMotionSource = orAddComponent;
			Vector3 vector = transform.TransformPoint(offset);
			Quaternion rotation = transform.rotation * rotateOffset;
			orAddComponent.SyncPose(vector, rotation);
			compFollow.ResetPhysicsPose(vector, rotation);
			root2.transform.SetPositionAndRotation(vector, rotation);
			CompTransform? compTransform = er.GetCompTransform();
			compTransform.InitPosition(vector);
			compTransform.rotation = rotation;
			stateObjectBase.BindParentRigidBody(componentInChildren);
			worldStateAsset.stateObjectBase.OnBindChildrenChanged(stateObjectBase);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"交互物随动，子物体是{er}, 父物体{worldStateAsset.stateEntityRef}上应该存在Rigidbody组件!!!");
		}
	}

	public async UniTask SpawnStateObjectBasePart(Entity eb, YooAssetReference address, Vector3 initPos, Quaternion rotate, Vector3 localScale, TransformParent transformParent)
	{
		CompStateObject compStateObject = eb.GetCompStateObject();
		AssetLoadHandle assetLoadHandle = await compStateObject.LoadAsync(address, initPos, rotate);
		if (assetLoadHandle.State == Bamboo.AssetField.LoadState.Failed)
		{
			int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			throw new Exception($"[World:{activeWorldId}, stateWorldAsset:{compStateObject.StateWorldAssetData.stateWorldAssetUid}] SpawnStateObjectBasePart 加载状态交互物资源失败，地址为{address}，检查配置或者资源包是否正确");
		}
		GameObject gameObject = assetLoadHandle.As<GameObject>();
		gameObject.transform.localScale = localScale;
		gameObject.GetOrAddComponent<MonoEntity>();
		eb.GetCompAlliance().alliance = Alliance.Netural;
		CompBehave? compBehave = eb.GetCompBehave();
		compBehave.SetupRoot(gameObject);
		compBehave.UpdateMonoRef();
		compBehave.SetupModel(gameObject);
		compBehave.SetEntityType(EntityType.StateObject);
		StateObjectBase componentInChildren = gameObject.GetComponentInChildren<StateObjectBase>();
		componentInChildren?.SetEntity(eb);
		if (transformParent != null && transformParent.parentSwUid.isValid)
		{
			ChangePosToParent(eb.GetCancellationTokenOnRelease(), transformParent.parentSwUid, eb, Quaternion.Euler(transformParent.rotateOffset), transformParent.offset, componentInChildren).Forget();
		}
		compStateObject.StateObjectBase = componentInChildren;
		CompTransform compTransform = eb.GetCompTransform();
		BoxCollider boxCollider = componentInChildren?.GetComponent<BoxCollider>();
		if (boxCollider != null)
		{
			compTransform.SetBaseCollider(boxCollider);
		}
		compTransform.InitPosition(gameObject.transform.position);
		compBehave.SetCanRemove();
	}

	public void SpawnAttackInteractObject(Entity eb, int attackableId, int trapType, int defenceTowerType, Vector3 pos, Alliance alliance, Vector3 size, Quaternion rotate)
	{
		SpawnInteractObjectDataPart(attackableId, eb, trapType, defenceTowerType, out var _);
		eb.SetAlliance(alliance);
		GameObject root = GetRoot(SceneRootType.AttackInteract);
		GameObject gameObject = new GameObject($"[{eb}] AttackInteractObject", typeof(MonoEntity));
		gameObject.layer = ((attackableId != 6) ? 10 : 0);
		gameObject.transform.position = pos;
		gameObject.transform.rotation = rotate;
		GameObject gameObject2 = gameObject;
		gameObject2.transform.SetParent(root.transform, worldPositionStays: true);
		CompBehave? compBehave = eb.GetCompBehave();
		compBehave.SetupRoot(gameObject2);
		compBehave.UpdateMonoRef();
		compBehave.SetupModel(gameObject2);
		CompTransform compTransform = eb.GetCompTransform();
		BoxCollider component;
		if (attackableId != 6)
		{
			BoxCollider boxCollider = gameObject2.GetComponent<BoxCollider>();
			if (boxCollider == null)
			{
				boxCollider = gameObject2.AddComponent<BoxCollider>();
			}
			boxCollider.enabled = true;
			boxCollider.size = size;
			compTransform.SetBaseCollider(boxCollider);
		}
		else if (gameObject2.TryGetComponent<BoxCollider>(out component))
		{
			component.enabled = false;
		}
		compTransform.InitPosition(pos);
		compBehave.SetEntityType(EntityType.StateObject);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		GameManager.entities.factory.EnqueueBehave(eb);
	}

	public void SpawnAttackInteractObject(Entity eb, int attackableId, int trapType, int defenceTowerType, Alliance alliance, Collider attachCollider)
	{
		eb.AddComponent<CompFollow>().FollowTarget = attachCollider.transform;
		SpawnAttackInteractObject(eb, attackableId, trapType, defenceTowerType, attachCollider.bounds.center, alliance, attachCollider.bounds.size, attachCollider.transform.rotation);
	}

	public async UniTask SpawnCommon(Entity entity, Vector3 pos, string path, bool isBornLeft, bool active, int aiIndex = -1)
	{
		entity.SetAlliance(Alliance.Character);
		entity.SetEntityType(EntityType.StateObject);
		GameManager.entities.factory.EnqueueBehave(entity);
		CompBehave compBehave = entity.GetCompBehave();
		await compBehave.InitCharacter(path);
		if (!entity.IsValid)
		{
			return;
		}
		ConfigCharacter config = compBehave.Config;
		GameObject root = compBehave.Root;
		root.layer = 12;
		root.SetActive(value: true);
		CapsuleCollider component = root.GetComponent<CapsuleCollider>();
		CompTransform? compTransform = entity.GetCompTransform();
		compTransform.SetBaseCollider(component);
		if (!CompPhysics.IsGroundLikeMotion(config.motionType))
		{
			root.transform.position = pos;
		}
		else
		{
			root.transform.position = PhysicsUtility.GetGroundPoint(pos + component.center + new Vector3(0f, 0.05f, 0f), component.Size(), 5f) - component.center;
		}
		compTransform.InitPosition(root.transform.position);
		CompPhysics compPhysics = entity.GetCompPhysics();
		compPhysics.motion = config.motionType;
		compPhysics.SetConstZ(pos.z);
		entity.GetCompMotion().Init(compBehave.Animator);
		SpawnBehave(entity, isBornLeft);
		if (compBehave.IsToRemove())
		{
			compBehave.SetCanRemove();
			return;
		}
		compBehave.SetBehaveAvailable();
		await SpawnCharacterAIPart(entity);
		compPhysics.characterMovement.collisionLayers = LayerMask.GetMask("Default", "Interact");
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		entity.SetActive(active);
		if (active)
		{
			EntityDither(entity, 1f, isShow: true);
		}
	}

	public async UniTask SpawnStateWorldAsset(Entity entity, int serviceSaveUid)
	{
		GameManager.entities.factory.EnqueueBehave(entity);
		await SpawnStateWorldAssetPart(entity, serviceSaveUid);
		CompBehave? compBehave = entity.GetCompBehave();
		compBehave.SetCanRemove();
		compBehave.SetLogicAvailable();
	}

	public UniTask SpawnDropItem(Entity eb, Vector3 pos)
	{
		return SpawnStateObjectBasePart(eb, GameLoader.meta.dropItemReferenceAssetID, pos, Quaternion.identity, Vector3.one, null);
	}

	public Entity SpawnDummy(Entity owner, Entity dummy)
	{
		GameObject root = GetRoot(SceneRootType.Entity);
		GameObject gameObject = BattleGameObjectPoolService.Instance.Acquire("Battle.DummyRoot", () => new GameObject("dummy", typeof(MonoEntity)), root.transform);
		gameObject.name = "dummy";
		gameObject.tag = DummyTag;
		gameObject.layer = 10;
		dummy.SetEntityType(owner.GetEntityType());
		CompProduct? compProduct = dummy.GetCompProduct();
		compProduct.caster = owner;
		compProduct.productOwner = owner;
		compProduct.actionSource = owner;
		CompBehave? compBehave = dummy.GetCompBehave();
		compBehave.SetRootPoolKey("Battle.DummyRoot");
		compBehave.SetupRoot(gameObject);
		compBehave.UpdateMonoRef();
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		return dummy;
	}

	protected void SpawnAbilityEntity(Entity entity, Entity owner)
	{
		if (owner.IsValid)
		{
			entity.SetAlliance(owner.GetAlliance());
			CompProduct? compProduct = entity.GetCompProduct();
			compProduct.caster = owner.GetCaster();
			compProduct.productOwner = owner;
			compProduct.actionSource = owner.GetActionSource();
		}
		GameObject root = GetRoot(SceneRootType.Bullet);
		GameObject gameObject = BattleGameObjectPoolService.Instance.Acquire("Battle.BulletRoot", () => new GameObject("BulletRoot"), root.transform);
		gameObject.name = $"子弹 [{entity}]";
		gameObject.layer = 6;
		CompBehave? compBehave = entity.GetCompBehave();
		compBehave.SetRootPoolKey("Battle.BulletRoot");
		compBehave.SetupRoot(gameObject);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
	}

	public async UniTask AsyncReplaceAbilityEntityPrefab(Entity entity, YooAssetReference assetReference)
	{
		CompBehave compBehave = entity.GetCompBehave();
		await compBehave.LoadBehaveAsset(assetReference);
		compBehave.SetBehaveAvailable();
	}

	public async UniTask CoServerSpawnMonster(Entity er, ISpawnMonsterParams smp)
	{
		await CoServerSpawnMonster(er, smp.GetSpawnMonsterParams());
	}

	public async UniTask CoServerSpawnMonster(Entity eb, SpawnMonsterParams smp)
	{
		GameUtility.ModifyMonsterPointLevel(smp);
		GameUtility.ModifyMonsterPointAI(smp);
		SpawnMonsterDataPart(smp.id, smp.level, smp.monsterPointId, eb, out var cData, smp.levelOverride);
		if (eb.TryGetCompMonster(out CompMonster component))
		{
			component.shareBossInfoUI = smp.shareBossInfoUI;
		}
		eb.SetAlliance(smp.alliance);
		GameManager.entities.factory.EnqueueBehave(eb);
		await SpawnCharacterBattlePart(eb, cData.config, smp.pos, smp.isLeft);
		CompAI? compAI = eb.GetCompAI();
		compAI.groupUid = smp.groupUid;
		compAI.groupAI = smp.groupAi;
		Singleton<GroupAIManager>.instance.RegisterGroupAI(eb, smp.groupUid, smp.groupAi);
		CompBehave compBehave = eb.GetCompBehave();
		if (compBehave.IsToRemove())
		{
			SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
			compBehave.SetCanRemove();
			return;
		}
		compBehave.SetBehaveAvailable();
		eb.HideRoot();
		await SpawnCharacterAIPart(eb, smp.aiIndex, smp);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		EntityType entityType = eb.GetEntityType();
		if (entityType == EntityType.Elite || entityType == EntityType.Monster)
		{
			Singleton<EntityUIManager>.instance.Register(eb);
		}
		EntityDither(eb, 1f, isShow: true);
		if (smp.bornInActive)
		{
			eb.GetModel().SetActive(value: false);
		}
		if (smp.isHaveBornEffect && !smp.bornInActive)
		{
			YooAssetReference bornEffectAssetID = eb.GetConfig().bornEffectAssetID;
			if (bornEffectAssetID.RuntimeKeyIsValid())
			{
				GameManager.effectSystem.FireEffect(bornEffectAssetID, eb.GetModelTrans().position, Quaternion.identity);
			}
		}
		SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
		if (!BossInfoGroupUtility.TryGetGroupId(eb, out var _) || !eb.TryGetCompBehave(out CompBehave component2) || component2.IsToRemove() || component2.IsOnRemove())
		{
			return;
		}
		EventManager eventManager = Singleton<EventManager>.instance;
		BossInfoMemberReadyEvt evt = eventManager.GetEvt<BossInfoMemberReadyEvt>();
		evt.entityId = eb.Id;
		try
		{
			eventManager.EventDispatch(ClientEvent.BossInfo_MemberReady, evt);
		}
		finally
		{
			eventManager.ReleaseEvt(evt);
		}
	}

	public async UniTask CoServerSpawnOwnerMonster(Entity entity, SpawnMonsterParams smp, Entity owner)
	{
		if (owner.IsValid)
		{
			smp.alliance = owner.GetAlliance();
			CompProduct? compProduct = entity.GetCompProduct();
			compProduct.caster = owner.GetCaster();
			compProduct.productOwner = owner;
			compProduct.actionSource = entity;
			if (smp.useOwnerDirection)
			{
				smp.isLeft = owner.IsFaceLeft();
			}
		}
		await CoServerSpawnMonster(entity, smp);
	}

	private void EnsureTrapAttackRigidbody(Entity trapEntity, GameObject root)
	{
		if (root == null || root.GetComponentInChildren<MonoWeaponPart>(includeInactive: true) == null)
		{
			return;
		}
		StateWorldAssetData stateWorldAssetData = trapEntity.GetCompStateObject()?.StateWorldAssetData;
		if ((stateWorldAssetData == null || stateWorldAssetData.trapType != 0) && stateWorldAssetData != null && stateWorldAssetData.transformParent?.parentSwUid?.isValid == true)
		{
			Rigidbody rigidbody = root.GetComponent<Rigidbody>();
			if (rigidbody == null)
			{
				rigidbody = root.AddComponent<Rigidbody>();
			}
			rigidbody.isKinematic = true;
			rigidbody.useGravity = false;
			rigidbody.detectCollisions = true;
			rigidbody.interpolation = RigidbodyInterpolation.None;
			rigidbody.collisionDetectionMode = CollisionDetectionMode.Discrete;
		}
	}

	public async UniTask SpawnTrapAttackObject(int attackableId, int trapType, int defenceTowerType, Entity eb, Alliance alliance, Vector3 pos, Quaternion rotate, Vector3 localScale, YooAssetReference reference, Transform parent = null)
	{
		instance.SpawnInteractObjectDataPart(attackableId, eb, trapType, defenceTowerType, out var _);
		eb.SetAlliance(alliance);
		CompBehave compBehave = eb.GetCompBehave();
		await compBehave.LoadBehaveAsset(reference, (AssetLoadHandle handle) =>
		{
			GameObject gameObject = compBehave.Model;
			if (gameObject == null)
			{
				gameObject = new GameObject($"[{eb}]TrapAttackObject");
				compBehave.SetupModel(gameObject);
			}
			gameObject.layer = ((attackableId != 6) ? 10 : 0);
			gameObject.transform.position = pos;
			gameObject.transform.rotation = rotate;
			gameObject.transform.localScale = localScale;
			gameObject.GetOrAddComponent<MonoEntity>();
			compBehave.SetupRoot(gameObject);
			compBehave.UpdateMonoRef();
			EnsureTrapAttackRigidbody(eb, gameObject);
			if (parent != null)
			{
				gameObject.transform.SetParent(parent);
			}
			eb.GetCompTransform().InitPosition(pos);
			compBehave.SetEntityType(EntityType.StateObject);
			compBehave.SetLogicAvailable();
			compBehave.SetCanRemove();
			GameManager.entities.factory.EnqueueBehave(eb);
		});
	}

	public async UniTask CoServerSpawnTrapAttack(Entity er, int attackableId, int trapType, int defenceTowerType, Alliance alliance, Vector3 pos, Quaternion rotate, Vector3 localScale, YooAssetReference reference, Transform parent = null)
	{
		await SpawnTrapAttackObject(attackableId, trapType, defenceTowerType, er, alliance, pos, rotate, localScale, reference, parent);
	}

	public async UniTask CoServerSpawnStateWorldAsset(Entity entity, int serviceSaveUid)
	{
		await SpawnStateWorldAsset(entity, serviceSaveUid);
	}

	private async UniTask CoSpawnDropItem(Entity eb, Vector3 pos, DropItem dropItem)
	{
		await SpawnDropItem(eb, pos);
		eb.GetCompBehave().SetCanRemove();
		InteractDropItem interactDropItem = eb.GetCompStateObject().StateObjectBase as InteractDropItem;
		if (interactDropItem != null)
		{
			interactDropItem.dropItemData = dropItem;
		}
	}

	public async UniTask<Entity> SpawnOwnerCharacter(MPEntityType type, int cid, int charIndex, Character character = null, bool left = false, Vector3 pos = default(Vector3), bool loadSave = false, int battleEntityIndex = -1)
	{
		if (character == null)
		{
			character = G.localPlayer.GetCharacter(cid);
		}
		if (character == null)
		{
			Debug.LogError($"SpawnOwnerCharacter character {cid} not exist");
			return default;
		}
		bool isNewEntity = !EntityHelper.TryGetBattleEntityByCharacter(character, out var entity);
		if (isNewEntity)
		{
			entity = GameManager.entities.factory.CreateBattleCharacter();
			entity.GetCompCharacter().characterSource = character;
			CompBehave compBehave = entity.GetCompBehave();
			if (character.Id >= 20000)
			{
				SpawnMonsterDataPart(character.Id, character.Level, 0, entity, out var cData);
				if (cData == null)
				{
					GameManager.entities.factory.DestroyEntity(entity);
					return default;
				}
				compBehave.ConfigPath = cData.config;
			}
			else
			{
				character.Refresh();
				if (!InitializeCharacterDataPart(entity, character, out var cData2))
				{
					GameManager.entities.factory.DestroyEntity(entity);
					return default;
				}
				compBehave.ConfigPath = cData2.config;
			}
		}
		else if (entity.GetCompTransform() == null)
		{
			GameManager.entities.factory.AddBattlePart(entity);
		}
		entity.SetAlliance(Alliance.Character);
		CompCharacter compCharacter = entity.GetCompCharacter();
		CompAbility compAbility = entity.GetCompAbility();
		if (entity.GetEntityType() == EntityType.Character)
		{
			CharacterStatus status = character.Status;
			int value = (int)((float)status.Hp * 1f / (float)RuntimeConfigs.data.game.hpSync * (float)compAbility.maxHP);
			compAbility.ServerSetHP(value);
			compAbility.alive = status.Hp > 0;
			compAbility.CurrentUltimateSkillValue = status.ExPower;
			compAbility.ModifyNormalEnergy(status.EnergyPower);
			compAbility.ModifySpecialEnergy(status.SpecialEnergyPower);
			if (loadSave)
			{
				compAbility.SetAssistValue(G.localPlayer.GetCharacter(compCharacter.characterSource.Id()).Status.AssistPower);
			}
			else
			{
				compAbility.SetAssistValue(0f);
			}
		}
		bool active = ((battleEntityIndex == -1) ? (charIndex == instance.battleEntityIndex) : (charIndex == battleEntityIndex));
		CompTrigger? compTrigger = entity.GetCompTrigger();
		compTrigger.SetTriggerGroupId(0u);
		compTrigger.SetCanTriggerHiddenRoom(canTriggerHiddenRoom: true);
		compAbility.RemoveAbilityFormSourceImmediate(AbilitySource.Constellation);
		List<int> list = ListPool<int>.Get();
		compCharacter.characterSource.GetConstellationStates(list);
		foreach (int item in list)
		{
			CharacterConstellationData data = CoreUtils.GetData(item, RuntimeConfigs.data.characterConstellationDatas);
			if (data.unlockSkill == 0)
			{
				foreach (ItemKv item2 in data.upgradeSkillGroup)
				{
					int id = item2.id;
					if (!RuntimeConfigs.data.skillGroupDatas.TryGetValue(id, out var value2))
					{
						continue;
					}
					int[] skillTotalIds = value2.skillTotalIds;
					foreach (int id2 in skillTotalIds)
					{
						Ability abilityById = compAbility.GetAbilityById(id2);
						if (abilityById != null)
						{
							abilityById.skillLevelInfo.level = compCharacter.characterSource.GetSkillGroupEventualLevel(id);
						}
					}
				}
				continue;
			}
			string[] constellationSkillName = data.constellationSkillName;
			foreach (string s in constellationSkillName)
			{
				if (data.unlockSkill == 0 || !int.TryParse(s, out var result))
				{
					continue;
				}
				SkillGroupData data2 = CoreUtils.GetData(result, RuntimeConfigs.data.skillGroupDatas);
				if (data2 != null)
				{
					int[] skillTotalIds = data2.skillTotalIds;
					foreach (int id3 in skillTotalIds)
					{
						string abilityName = CoreUtils.GetData(id3, RuntimeConfigs.data.skillDetailDatas).abilityName;
						compAbility.RemoveAbilityImmediate(abilityName);
						MPSkill skillLevelInfo = new MPSkill
						{
							id = id3,
							level = 1
						};
						compAbility.AddAbility(entity, abilityName, AbilitySource.Constellation, skillLevelInfo, 1);
					}
				}
			}
		}
		ListPool<int>.Release(list);
		compAbility.RemoveAbilityFormSource(AbilitySource.Equip);
		character.Refresh();
		List<int> list2 = ListPool<int>.Get();
		character.GetAllFeatureIDs(list2);
		foreach (int item3 in list2)
		{
			int featureData = character.GetFeatureData(item3);
			if (featureData > 0)
			{
				SkillGroupData data3 = CoreUtils.GetData(CoreUtils.GetData(item3, RuntimeConfigs.data.equipFeatureDatas).skillGroupData, RuntimeConfigs.data.skillGroupDatas);
				for (int k = 0; k < data3.skillTotalIds.Length; k++)
				{
					SkillDetailData data4 = CoreUtils.GetData(data3.skillTotalIds[k], RuntimeConfigs.data.skillDetailDatas);
					compAbility.AddAbility(entity, data4.abilityName, AbilitySource.Equip, new MPSkill
					{
						id = data4.id,
						level = (byte)featureData
					}, 1);
				}
			}
		}
		ListPool<int>.Release(list2);
		BList<int> ids = BListPool<int>.Default.Get(3);
		TableRule.GetActiveEliteSkillIds(cid, character.GetEliteActiveLevel(), ref ids);
		foreach (int item4 in ids)
		{
			SkillDetailData data5 = CoreUtils.GetData(item4, RuntimeConfigs.data.skillDetailDatas);
			compAbility.AddAbility(entity, data5.abilityName, AbilitySource.Elite, new MPSkill
			{
				id = data5.id,
				level = 1
			}, 1);
		}
		BListPool<int>.Default.Recycle(ids);
		CompBehave compBehave2 = entity.GetCompBehave();
		await SpawnCharacterBattlePart(entity, compBehave2.ConfigPath, pos, left, active);
		if (compBehave2.IsToRemove())
		{
			compBehave2.SetCanRemove();
			if (isNewEntity)
			{
				GameManager.entities.factory.DestroyEntity(entity);
			}
			return default;
		}
		if (!CompleteCharacterBattlePartInitialization(entity, charIndex, active))
		{
			if (isNewEntity)
			{
				GameManager.entities.factory.DestroyEntity(entity);
			}
			return default;
		}
		EntityHelper.RegisterBattleEntity(character, entity);
		return entity;
	}

	private bool CompleteCharacterBattlePartInitialization(Entity entity, int characterIndex, bool active)
	{
		if (!entity.IsValid || entity.GetRoot() == null)
		{
			return false;
		}
		GameManager.timeSystem.InitializeEntity(entity);
		if (entity.GetEntityType() == EntityType.Character)
		{
			CompHatred compHatred = entity.GetCompHatred();
			if (active)
			{
				instance.EntityDissolve(entity, GameLoader.meta.dissolveTime, isShow: true);
				EntityDitherPure(entity, 0f, isShow: true);
				compHatred.battleStartTimeStamp = TimeManager.LocalTime.NowTimestamp;
			}
			else
			{
				entity.GetRoot().SetActive(value: false);
				compHatred.battleStartTimeStamp = 0L;
			}
		}
		else
		{
			instance.EntityDither(entity, GameLoader.meta.ditherTime, isShow: true);
		}
		CompBehave? compBehave = entity.GetCompBehave();
		compBehave.SetActive(active);
		CompMotion? compMotion = entity.GetCompMotion();
		compMotion.SetBool("isActive", active);
		compMotion.SetBool("isControlled", active);
		compMotion.SetFloat("normalEnergy", entity.GetCompAbility().EnergyValue);
		compBehave.ChangeCD = 0f;
		GameManager.cameraSystem.InitCharacterVCam(entity, characterIndex);
		compBehave.SetLogicAvailable();
		compBehave.SetBehaveAvailable();
		compBehave.SetCanRemove();
		return true;
	}

	public void SpawnUIRobot()
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(GameLoader.meta.uiRobot);
		GameUtility.uiRobotEffect = gameObject.GetComponentInChildren<ParticleSystem>();
		gameObject.SetActive(value: false);
		GameUtility.uiRobot = gameObject;
	}

	public void SpawnTraceCam()
	{
		GameUtility.traceCam = UnityEngine.Object.Instantiate(GameLoader.meta.traceCam);
	}

	public void SpawnOwnerAbilityEntity(Entity entity, Entity owner)
	{
		SpawnAbilityEntity(entity, owner);
		GameManager.entities.factory.EnqueueBehave(entity);
	}

	public void SpawnFlexibleEntity(FlexibleParams p, Entity owner, Ability ability, Action<Entity> onCreateEntity = null)
	{
		Shape shape = p.shape;
		Vector2 size = p.size;
		Vector3 boxSize = p.boxSize;
		Vector3 vector = p.aimPos;
		Quaternion aimRotation = p.aimRotation;
		int hp = p.hp;
		Vector3 offest = p.offest;
		float overlapThreshold = p.OverlapThreshold;
		bool cantBeAttack = p.cantBeAttack;
		Vector3 vector2 = aimRotation * offest;
		string ignoreEnvironmentCollisionTag = p.ignoreEnvironmentCollisionTag;
		bool flag = !string.IsNullOrEmpty(ignoreEnvironmentCollisionTag);
		if (p.checkEnvAndResolve)
		{
			Vector3 vector3 = aimRotation * Vector3.forward * p.VelocityOverlapDistance;
			Vector3 vector4 = vector - vector3;
			Vector3 vector5 = vector + vector2 - vector4;
			Collider[] cacheColliders = PhysicsUtility.cacheColliders;
			int num = p.shape switch
			{
				Shape.Sphere => Physics.OverlapSphereNonAlloc(vector4, size.x, cacheColliders, BattleConsts.enviromentMask), 
				Shape.Box => Physics.OverlapBoxNonAlloc(vector4, p.boxSize / 2f, cacheColliders, aimRotation, BattleConsts.enviromentMask), 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			Collider collider = ((num > 0) ? cacheColliders[0] : null);
			if (flag)
			{
				collider = null;
				for (int i = 0; i < num; i++)
				{
					Collider collider2 = cacheColliders[i];
					if (!(collider2 == null) && !collider2.CompareTag(ignoreEnvironmentCollisionTag))
					{
						collider = collider2;
						break;
					}
				}
			}
			if (collider != null)
			{
				vector = collider.ClosestPoint(vector4) + ((!(Vector3.Dot(vector5, Vector3.right) > 0f)) ? 1 : (-1)) * new Vector3(((shape == Shape.Sphere) ? size.x : (boxSize.x / 2f)) + overlapThreshold, 0f, 0f) - vector2;
			}
			else if (!flag)
			{
				if (shape switch
				{
					Shape.Sphere => Physics.SphereCast(vector4, size.x, vector5, out var hitInfo, vector5.magnitude, BattleConsts.enviromentMask), 
					Shape.Box => Physics.BoxCast(vector4, boxSize / 2f, vector5, out hitInfo, aimRotation, vector5.magnitude, BattleConsts.enviromentMask), 
					_ => throw new ArgumentOutOfRangeException(), 
				})
				{
					vector = hitInfo.collider.ClosestPoint(vector4) + hitInfo.normal * (((shape == Shape.Sphere) ? size.x : (boxSize.x / 2f)) + overlapThreshold) - vector2;
				}
			}
			else if (vector5.sqrMagnitude > Mathf.Epsilon)
			{
				RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
				int num2 = shape switch
				{
					Shape.Sphere => Physics.SphereCastNonAlloc(vector4, size.x, vector5.normalized, cacheHits, vector5.magnitude, BattleConsts.enviromentMask), 
					Shape.Box => Physics.BoxCastNonAlloc(vector4, boxSize / 2f, vector5.normalized, cacheHits, aimRotation, vector5.magnitude, BattleConsts.enviromentMask), 
					_ => throw new ArgumentOutOfRangeException(), 
				};
				if (num2 > 0)
				{
					Array.Sort(cacheHits, 0, num2, PhysicsUtility.RaycastHitComparer);
					for (int j = 0; j < num2; j++)
					{
						RaycastHit raycastHit = cacheHits[j];
						if (!(raycastHit.collider == null) && !raycastHit.collider.CompareTag(ignoreEnvironmentCollisionTag))
						{
							vector = raycastHit.collider.ClosestPoint(vector4) + raycastHit.normal * (((shape == Shape.Sphere) ? size.x : (boxSize.x / 2f)) + overlapThreshold) - vector2;
							break;
						}
					}
				}
				PhysicsUtility.Release(cacheHits);
			}
			PhysicsUtility.Release(cacheColliders);
		}
		Entity entity = GameManager.entities.factory.CreateAbilityEntity();
		CompBehave compBehave = entity.GetCompBehave();
		compBehave.releaseFlag = 1;
		compBehave.SetEntityType(EntityType.Trajectory);
		SpawnOwnerAbilityEntity(entity, owner);
		CompAbility compAbility = entity.GetCompAbility();
		if (p.onDie != null)
		{
			compAbility.onDie += p.onDie;
		}
		onCreateEntity?.Invoke(entity);
		Transform rootTransform = entity.GetRootTransform();
		if (rootTransform != null && rootTransform.TryGetComponent<BoxCollider>(out var component))
		{
			component.enabled = false;
		}
		if (rootTransform != null && rootTransform.TryGetComponent<SphereCollider>(out var component2))
		{
			component2.enabled = false;
		}
		if (hp > 0)
		{
			switch (shape)
			{
			case Shape.Sphere:
				AttachAttackablePart(entity, offest, size.x);
				break;
			case Shape.Box:
				AttachAttackablePart(entity, new Bounds(offest, boxSize));
				break;
			}
			compAbility.SetHPWithoutNotify(hp);
			PropertyItem propertyItem = GameLoader.meta.configProperty.GetPropertyItem(1u);
			compAbility.GetOrCreateProperty(propertyItem);
			CoreUtils.StartPropertyCal();
			Dictionary<PropertyItem, float> dictionary = DictionaryPool<PropertyItem, float>.Get();
			dictionary.Add(propertyItem, hp);
			compAbility.PushProperties(dictionary, needCal: true, PropertySource.Neutral, -1);
			DictionaryPool<PropertyItem, float>.Release(dictionary);
			if (cantBeAttack)
			{
				compBehave.EntityTags.AddTag(EntityTag.IgnoreAttack);
			}
			if (p.destroyOtherBulletOnBeHit)
			{
				compBehave.MonoEntity.gameObject.tag = BattleConsts.BULLET_DESTROY_TAG;
			}
			compBehave.BeHitFilter = p.beHitFilter;
		}
		if (ability != null)
		{
			compBehave.rogueTrigger = ability.rogueTrigger;
		}
		CompTrajectory? compTrajectory = entity.GetCompTrajectory();
		compTrajectory.shape = shape;
		compTrajectory.size = ShapeSize();
		compTrajectory.ignoreEnvironmentCollisionTag = ignoreEnvironmentCollisionTag;
		CompTransform compTransform = entity.GetCompTransform();
		compTransform.size = ShapeSize();
		compTransform.center = offest;
		entity.GetCompProduct().AbilityEntityType = p.type;
		compTrajectory.tag = p.tag;
		entity.SetAlliance(owner.GetAlliance());
		CompAim? compAim = entity.GetCompAim();
		CompAim compAim2 = owner.GetCompAim();
		compAim.aimTarget = compAim2.aimTarget;
		compAim.aimEntity = compAim2.aimEntity;
		compAim.aimTargetPosition = compAim2.aimTargetPosition;
		entity.GetRootTransform().SetPositionAndRotation(vector, aimRotation);
		compTransform.InitPosition(vector);
		compTransform.rotation = aimRotation;
		Vector3 forward = Vector3.ProjectOnPlane(aimRotation * Vector3.forward, Vector3.up);
		Quaternion faceRotation = (compTransform.PathRotation = Quaternion.LookRotation(forward, Vector3.up));
		compTransform.FaceRotation = faceRotation;
		ConfigTrajectoryObject configTrajectoryObject = p.configTrajectoryObject;
		ConfigTrajectory configTrajectory = ((configTrajectoryObject != null && configTrajectoryObject.configTrajectory != null) ? configTrajectoryObject.configTrajectory : p.trajectory);
		RuntimeTrajectory trajectory = ((!(configTrajectory is GeneralTrajectory generalTrajectory)) ? configTrajectory.Create(entity, ability) : generalTrajectory.Create(p.movementPattern ?? generalTrajectory.movementPattern, entity, ability));
		GameManager.trajectorySystem.BindTrajectory(entity, trajectory);
		if (hp > 0 && !cantBeAttack && p.showUI && entity.GetEntityType() == EntityType.Trajectory)
		{
			Singleton<EntityUIManager>.instance.Register(entity);
		}
		p.onCreate?.Invoke(entity);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtCreateBullet evt = abilitySystem.GetEvt<EvtCreateBullet>(owner, ability);
		evt.mainEntity = owner;
		evt.bullet = entity;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		EvtOnSpawnProduct evt2 = abilitySystem.GetEvt<EvtOnSpawnProduct>(owner, ability);
		evt2.mainEntity = owner;
		evt2.product = entity;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
		Vector3 ShapeSize()
		{
			return shape switch
			{
				Shape.Sphere => (Vector3)size, 
				Shape.Box => boxSize, 
				Shape.Custom => Vector3.zero, 
				Shape.CustomPart => Vector3.zero, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
		}
	}

	private void CompAbilityBindAction(Entity eb)
	{
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.onEntityHpChange += (Action<int, int, Entity>)((int pre, int after, Entity er) =>
		{
			CompAbility compAbility2 = er.GetCompAbility();
			EventManager eventManager = Singleton<EventManager>.instance;
			EntityHpChangeEvt evt = eventManager.GetEvt<EntityHpChangeEvt>();
			evt.entityType = eb.GetEntityType();
			evt.entityId = er.Id;
			evt.oldHp = pre;
			evt.curHp = after;
			evt.basicMaxHp = compAbility2.maxHP;
			evt.curMaxHp = compAbility2.maxHP;
			evt.curHpPercentage = (float)evt.curHp / (float)evt.curMaxHp;
			eventManager.EventDispatch(ClientEvent.EntityHpChange, evt);
			eventManager.ReleaseEvt(evt);
		});
		compAbility.onActivePostureChange = (Action<Entity, bool>)Delegate.Combine(compAbility.onActivePostureChange, (Action<Entity, bool>)((Entity entity, bool active) =>
		{
			if (active)
			{
				EventManager eventManager = Singleton<EventManager>.instance;
				EntityEnterPostureEvt evt = eventManager.GetEvt<EntityEnterPostureEvt>();
				evt.entityId = entity.Id;
				eventManager.EventDispatch(ClientEvent.EntityEnterPosture, evt);
				eventManager.ReleaseEvt(evt);
			}
			else
			{
				EventManager eventManager2 = Singleton<EventManager>.instance;
				EntityExitPostureEvt evt2 = eventManager2.GetEvt<EntityExitPostureEvt>();
				evt2.entityId = entity.Id;
				eventManager2.EventDispatch(ClientEvent.EntityExitPosture, evt2);
				eventManager2.ReleaseEvt(evt2);
			}
		}));
		compAbility.onPostureChange = (Action<Entity, int, int>)Delegate.Combine(compAbility.onPostureChange, (Action<Entity, int, int>)((Entity entity, int pre, int after) =>
		{
			EventManager eventManager = Singleton<EventManager>.instance;
			EntityPostureChangeEvt evt = eventManager.GetEvt<EntityPostureChangeEvt>();
			evt.entityId = entity.Id;
			evt.maxPosture = entity.GetCompAbility().maxPosture;
			evt.oldPosture = pre;
			evt.curPosture = after;
			evt.curPosturePercentage = (float)evt.curPosture / (float)evt.maxPosture;
			eventManager.EventDispatch(ClientEvent.EntityPostureChange, evt);
			eventManager.ReleaseEvt(evt);
		}));
		compAbility.onRevivePostureProgressChange = (Action<Entity, float, float>)Delegate.Combine(compAbility.onRevivePostureProgressChange, (Action<Entity, float, float>)((Entity entity, float pre, float after) =>
		{
			CompAbility compAbility2 = entity.GetCompAbility();
			if (Mathf.Approximately(pre, 1f) && after < 1f)
			{
				EventManager eventManager = Singleton<EventManager>.instance;
				EntityEnterWeakEvt evt = eventManager.GetEvt<EntityEnterWeakEvt>();
				evt.entityId = entity.Id;
				evt.curWeakPercentage = compAbility2.revivePostureProgress;
				eventManager.EventDispatch(ClientEvent.EntityEnterWeak, evt);
				eventManager.ReleaseEvt(evt);
			}
			else if (pre < 1f && after == 1f)
			{
				if (!compAbility2.IsWeak)
				{
					EventManager eventManager2 = Singleton<EventManager>.instance;
					EntityExitWeakEvt evt2 = eventManager2.GetEvt<EntityExitWeakEvt>();
					evt2.entityId = entity.Id;
					eventManager2.EventDispatch(ClientEvent.EntityExitWeak, evt2);
					eventManager2.ReleaseEvt(evt2);
				}
			}
			else
			{
				EventManager eventManager3 = Singleton<EventManager>.instance;
				EntityWeakChangeEvt evt3 = eventManager3.GetEvt<EntityWeakChangeEvt>();
				evt3.entityId = entity.Id;
				evt3.weakPercentage = after;
				eventManager3.EventDispatch(ClientEvent.EntityWeakChange, evt3);
				eventManager3.ReleaseEvt(evt3);
			}
		}));
		compAbility.onPostureBurstChange = (Action<Entity, bool>)Delegate.Combine(compAbility.onPostureBurstChange, (Action<Entity, bool>)((Entity entity, bool active) =>
		{
			if (active)
			{
				EventManager eventManager = Singleton<EventManager>.instance;
				EntityEnterBurstEvt evt = eventManager.GetEvt<EntityEnterBurstEvt>();
				evt.entityId = entity.Id;
				eventManager.EventDispatch(ClientEvent.EntityEnterBurst, evt);
				eventManager.ReleaseEvt(evt);
			}
			else
			{
				EventManager eventManager2 = Singleton<EventManager>.instance;
				EntityExitBurstEvt evt2 = eventManager2.GetEvt<EntityExitBurstEvt>();
				evt2.entityId = entity.Id;
				eventManager2.EventDispatch(ClientEvent.EntityExitBurst, evt2);
				eventManager2.ReleaseEvt(evt2);
			}
		}));
		compAbility.onCharacterDamageHit = (Action<Entity, int>)Delegate.Combine(compAbility.onCharacterDamageHit, (Action<Entity, int>)((Entity entity, int i) =>
		{
			EventManager eventManager = Singleton<EventManager>.instance;
			EntityHitByCharacterEvt evt = eventManager.GetEvt<EntityHitByCharacterEvt>();
			evt.entityId = entity.Id;
			evt.characterDamageType = i;
			eventManager.EventDispatch(ClientEvent.EntityHitByCharacter, evt);
			eventManager.ReleaseEvt(evt);
		}));
	}

	private void SetMeshBones(WeaponPartAttach attach, GameObject go)
	{
		SkinnedMeshRenderer[] skinRenders = go.GetComponent<AniPartControl>().skinRenders;
		for (int i = 0; i < skinRenders.Length; i++)
		{
			skinRenders[i].bones = attach.bones;
		}
	}

	private async UniTask AttachSkinnedModelToCertainNode(Entity er, Transform parent, WeaponPartAttach attach, WeaponDetails detail)
	{
		await AttachNormalModelToCertainNode(er, parent, detail);
		GameObject weaponModel = er.GetMono().weaponModel;
		SetMeshBones(attach, weaponModel);
	}

	private async UniTask AttachNormalModelToCertainNode(Entity er, Transform parent, WeaponDetails detail)
	{
		await InitWeaponModel(detail, er, parent);
		MonoEntity mono = er.GetMono();
		AniPartControl component = mono.weaponModel.GetComponent<AniPartControl>();
		if (component != null)
		{
			mono.aniControls.Add(component);
		}
	}

	private async UniTask InitWeaponModel(WeaponDetails detail, Entity er, Transform parent)
	{
		ConfigCharacter config = er.GetConfig();
		if (detail.weaponScale != null && detail.weaponScale.Count > 0)
		{
			foreach (WeaponScale info in detail.weaponScale)
			{
				if (info.type == config.characterWeightType)
				{
					if (info.overrideWeaponWrapAssetID.RuntimeKeyIsValid())
					{
						await InstantiateWeaponModel(info.overrideWeaponWrapAssetID, parent, er);
						break;
					}
					await InstantiateWeaponModel(detail.weaponAssetAssetID, parent, er);
					SetWeaponWrapScale(er, info.scale, info.type);
					break;
				}
			}
			_ = LuminApplication.LogEnabled;
			await InstantiateWeaponModel(detail.weaponAssetAssetID, parent, er);
			return;
		}
		await InstantiateWeaponModel(detail.weaponAssetAssetID, parent, er);
		List<DefaultWeaponScaleInfo> defaultWeaponScale = config.weapon.defaultWeaponScale;
		if (defaultWeaponScale == null || defaultWeaponScale.Count <= 0)
		{
			return;
		}
		foreach (DefaultWeaponScaleInfo item in defaultWeaponScale)
		{
			if (item.type == config.characterWeightType)
			{
				SetWeaponWrapScale(er, item.scale, item.type);
				break;
			}
		}
	}

	private void SetWeaponWrapScale(Entity er, Vector3 scale, CharacterWeightType type)
	{
		MonoEntity mono = er.GetMono();
		Vector3 localScale = mono.weaponModel.transform.localScale;
		localScale.Scale(scale);
		mono.weaponModel.transform.localScale = localScale;
	}

	private async UniTask InstantiateWeaponModel(YooAssetReference asset, Transform parent, Entity er)
	{
		await er.GetCompBehave().LoadWeapon(asset, parent);
	}

	private async UniTask AttachWeaponBase(Entity entity, WeaponPartAttach attach, WeaponDetails[] details)
	{
		Transform weaponPos = attach.weaponPos;
		if (weaponPos == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色{entity}有武器节点没挂，检查一下prefab");
			}
			return;
		}
		int attachID = attach.attachID;
		int num = IsHaveWeaponProperty(details, attachID);
		if (num == -1)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色{entity}的武器attachID->{attachID}不在角色武器配置内，检查下角色配置");
			}
			return;
		}
		WeaponDetails detail = details[num];
		switch (detail.structure)
		{
		case WeaponStructure.normal:
			await AttachNormalModelToCertainNode(entity, weaponPos, detail);
			break;
		case WeaponStructure.skinned:
			await AttachSkinnedModelToCertainNode(entity, weaponPos, attach, detail);
			break;
		}
	}

	private async UniTask AttachModels(Entity entity, WeaponPartAttach[] attachs, WeaponDetails[] details)
	{
		for (int i = 0; i < attachs.Length; i++)
		{
			await AttachWeaponBase(entity, attachs[i], details);
		}
	}

	private async UniTask LoadWeaponModel(Entity entity, WeaponProperty weapon)
	{
		MonoEntity mono = entity.GetMono();
		mono.curWeapon = weapon.id;
		WeaponPartAttach[] weaponAttachs = mono.weaponAttachs;
		WeaponDetails[] weaponDetails = weapon.weaponDetails;
		await AttachModels(entity, weaponAttachs, weaponDetails);
	}

	public async UniTask LoadWeaponPart(Entity entity, int weaponID)
	{
		CompBehave? compBehave = entity.GetCompBehave();
		ConfigWeapon weapon = compBehave.Config.weapon;
		if (compBehave.MonoEntity.curWeapon == weaponID)
		{
			return;
		}
		RemoveGO(entity);
		if (weaponID == weapon.defaultWeapon.id)
		{
			await LoadWeaponModel(entity, weapon.defaultWeapon);
			return;
		}
		WeaponProperty[] weapons = weapon.weapons;
		int num = IsHaveWeaponProperty(weapons, weaponID);
		if (num == -1)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"weaponID {weaponID} 不在entity{entity}的configWeapon中,请检查配置！");
			}
			await LoadWeaponModel(entity, weapon.defaultWeapon);
		}
		else
		{
			await LoadWeaponModel(entity, weapons[num]);
		}
	}

	private int IsHaveWeaponProperty(WeaponProperty[] weapons, int id)
	{
		for (int i = 0; i < weapons.Length; i++)
		{
			if (weapons[i].id == id)
			{
				return i;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("weapons not exists in config,check it!");
		}
		return -1;
	}

	private int IsHaveWeaponProperty(WeaponDetails[] weapons, int attachID)
	{
		for (int i = 0; i < weapons.Length; i++)
		{
			if (weapons[i].attachID == attachID)
			{
				return i;
			}
		}
		return -1;
	}

	private void RemoveGO(Entity entity)
	{
		entity.GetCompBehave().ReleaseWeapon();
	}

	public async UniTask SpawnGroupAI(Entity eb, int groupId, YooAssetReference ai)
	{
		GameManager.entities.factory.EnqueueBehave(eb);
		CompBehave compBehave = eb.GetCompBehave();
		CompGroupAI? compGroupAI = eb.GetCompGroupAI();
		CompAI compAI = eb.GetCompAI();
		GameObject gameObject = compGroupAI.CreateNode();
		ActBehaviorTree bt = gameObject.GetComponent<ActBehaviorTree>();
		bt.StartWhenEnabled = false;
		bt.AsynchronousLoad = true;
		compBehave.SetupRoot(gameObject);
		compBehave.SetupModel(gameObject);
		compBehave.SetEntityType(EntityType.Monster);
		await compAI.LoadAsync(ai);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		bt.SetEntity(eb);
		bt.running = true;
	}

	public async UniTask SpawnDropItem(Entity eb, int dropSourceUid, DropItem dropItem, DropItemStaticNode node)
	{
		GameManager.entities.factory.EnqueueBehave(eb);
		Vector3 pos = await Singleton<DropItemManager>.instance.GetDropPos(dropSourceUid);
		await instance.CoSpawnDropItem(eb, pos, dropItem);
		InteractDropItem obj = eb.GetCompStateObject().StateObjectBase as InteractDropItem;
		obj.InitStateObject(0);
		obj.SetDropItemNode(node);
	}

	public void AttachAttackablePart(Entity eb, Bounds bounds)
	{
		CompBehave compBehave = eb.GetCompBehave();
		MonoEntity monoEntity = compBehave.MonoEntity;
		if (monoEntity == null && compBehave.Root != null)
		{
			monoEntity = compBehave.Root.GetOrAddComponent<MonoEntity>();
			compBehave.UpdateMonoRef();
		}
		monoEntity.gameObject.layer = 10;
		BoxCollider boxCollider = EntityPrefabRuntimeUtility.EnsureAttackableCollider<BoxCollider>(monoEntity);
		boxCollider.size = bounds.size;
		boxCollider.center = bounds.center;
	}

	public void AttachAttackablePart(Entity eb, Vector3 center, float radius)
	{
		CompBehave compBehave = eb.GetCompBehave();
		MonoEntity monoEntity = compBehave.MonoEntity;
		if (monoEntity == null)
		{
			monoEntity = compBehave.Root.GetOrAddComponent<MonoEntity>();
			compBehave.UpdateMonoRef();
		}
		monoEntity.gameObject.layer = 10;
		SphereCollider sphereCollider = EntityPrefabRuntimeUtility.EnsureAttackableCollider<SphereCollider>(monoEntity);
		sphereCollider.radius = radius;
		sphereCollider.center = center;
	}

	public async UniTask SpawnAssistNpc(Entity entity, SpawnMonsterParams smp, int npcId)
	{
		smp.alliance = Alliance.Character;
		GameUtility.ModifyMonsterPointLevel(smp);
		GameUtility.ModifyMonsterPointAI(smp);
		entity.GetCompAssistNpc().npcId = npcId;
		entity.SetAlliance(smp.alliance);
		SpawnAssistNpcDataPart(smp.id, smp.level, smp, entity, out var cData);
		GameManager.entities.factory.EnqueueBehave(entity);
		await SpawnCharacterBattlePart(entity, cData.config, smp.pos, smp.isLeft);
		CompAI? compAI = entity.GetCompAI();
		compAI.groupUid = smp.groupUid;
		compAI.groupAI = smp.groupAi;
		Singleton<GroupAIManager>.instance.RegisterGroupAI(entity, smp.groupUid, smp.groupAi);
		CompBehave compBehave = entity.GetCompBehave();
		if (compBehave.IsToRemove())
		{
			SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
			compBehave.SetCanRemove();
			return;
		}
		compBehave.SetBehaveAvailable();
		await SpawnCharacterAIPart(entity, smp.aiIndex, smp);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		EntityDither(entity, 1f, isShow: true);
		if (smp.isHaveBornEffect)
		{
			YooAssetReference bornEffectAssetID = compBehave.Config.bornEffectAssetID;
			if (bornEffectAssetID.RuntimeKeyIsValid())
			{
				GameManager.effectSystem.FireEffect(bornEffectAssetID, compBehave.Model.transform.position, Quaternion.identity);
			}
		}
		SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
		if (entity.GetEntityType() == EntityType.AssistNpc)
		{
			Singleton<EntityUIManager>.instance.Register(entity);
		}
	}

	public RuntimeLaser SpawnLaser(LaserParams p)
	{
		Entity owner = p.owner;
		RuntimeLaser runtimeLaser = owner.GetCompLaser().AddLaser();
		runtimeLaser.alliance = p.alliance;
		runtimeLaser.filterEntityType = p.filterEntityType;
		runtimeLaser.canBeAttack = p.canBeAttack;
		runtimeLaser.onTriggerEnter = p.onTriggerEnter;
		runtimeLaser.onTriggerStay = p.onTriggerStay;
		runtimeLaser.onTriggerExit = p.onTriggerExit;
		runtimeLaser.owner = p.owner;
		runtimeLaser.ability = p.ability;
		runtimeLaser.posOffset = p.posOffset;
		runtimeLaser.directionOffset = p.directionOffset;
		runtimeLaser.maxLength = p.maxLength;
		runtimeLaser.runtimeLength = p.runtimeLength;
		runtimeLaser.radius = p.radius;
		runtimeLaser.colliderLayer = p.colliderLayer;
		EffectPoint point = default;
		EffectPoint point2 = default;
		point.constPointPos = null;
		point.continueouslyFollow = true;
		point.rotateFollowLogicDir = false;
		point.offset = p.posOffset;
		point.rotateOffset = p.directionOffset;
		point.useOwnerRot = false;
		point.oriRotX = 0f;
		point.oriRotY = 0f;
		point.oriRotZ = 0f;
		point.aimTarget = false;
		point.type = EffectPoint.EffectPointType.Character;
		SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
		{
			target = FindTargetResult.EntityOnly(owner),
			patternAssetID = p.effectAsset,
			constPointPos = default,
			removeWhenMotionExit = false,
			timescale = TimeScale.Owner,
			type = EffectDataType.Point,
			point1 = point,
			point2 = point2,
			removeWhenStop = true,
			changeScale = false,
			effectRangeEnum = EffectRangeEnum.none,
			transformScaleMulBase = default,
			modelType = EffectModelType.Small,
			isChangeWithEntity = false,
			initRotation = default,
			isAttach = false,
			motioState = MotionState.None,
			xMirror = false,
			warningEffectTime = 0f,
			exclusivePriority = false,
			priority = 0
		};
		runtimeLaser._effect = GameManager.effectSystem.FireEffect(effectParams);
		return runtimeLaser;
	}
}
