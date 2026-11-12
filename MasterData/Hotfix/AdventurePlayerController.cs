#define LOG_WARNING
using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using Cinemachine;
using DG.Tweening;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;
using UnityEngine.UI.Extensions;
using XLua;

public class AdventurePlayerController : SceneSingleton<AdventurePlayerController>, ICoroutineOwner
{
	protected LogManager.Logger _logger;

	[BlackList]
	public bool ultimateIgnoreEnergy;

	[BlackList]
	public bool showVisionAttackRange;

	[BlackList]
	public bool tempShowVisionAttackRange = true;

	[BlackList]
	public UIFan uifan;

	[SerializeField]
	private Color uifanColor_CanAtk = new Color(1f, 1f, 1f, 0.2745f);

	[SerializeField]
	private Color uifanColor_CanNotAtk = new Color(1f, 1f, 1f, 0.1372f);

	private bool _mainActorCanAttack;

	[Header("Player Agent Config:")]
	[BlackList]
	public GameObject playerAgent;

	[BlackList]
	public CapsuleCollider playerAgentCollider;

	[BlackList]
	public AdventurePlayerIndependentImpulseListener playerImpulseListener;

	protected AdventureEntityGroup _actorGroup;

	private PlayerAdventureActor _activedPlayerActor;

	protected int _firstSlotActorId;

	protected int _secondSlotActorId;

	protected readonly Dictionary<int, PlayerAdventureActor> _actorDicts = new Dictionary<int, PlayerAdventureActor>();

	protected readonly List<PlayerAdventureActor> _beDeactiveActors = new List<PlayerAdventureActor>();

	[BlackList]
	public List<PlayerAdventureActor> ActorLs = new List<PlayerAdventureActor>(3);

	protected bool _hideByInit;

	[BlackList]
	public int currentCharid;

	protected readonly Dictionary<long, AdventureActor> alertEntity = new Dictionary<long, AdventureActor>(10);

	protected readonly List<long> dieEntity = new List<long>(20);

	protected readonly List<long> actionEnemyEntity = new List<long>(20);

	private int counsse;

	private int alterLv;

	private LogicEntity _dynamicActor;

	private TSVector2 tslastPos;

	private Vector3 lastPos;

	private Quaternion lastRot;

	private PlayFX outFx = new PlayFX();

	private PlayFX inFx = new PlayFX();

	private readonly List<int> _alreadyAddedEnergy = new List<int>();

	private int uniqueAttackId;

	protected readonly List<long> searchList = new List<long>(20);

	[BlackList]
	public LogicEntity selectEntity;

	[BlackList]
	public LogicEntity _defaultSelect;

	protected FP _leftTime;

	protected TiliaShieldEntity tiliaShieldEntity;

	[BlackList]
	public GameObject testAreaEffectPrefab;

	private int lastCastSkillActorId;

	private FP lastCastSkillTime;

	private Dictionary<int, AutoBattleReadyInfo> autoBattleReadyInfoDict = new Dictionary<int, AutoBattleReadyInfo>();

	private AutoBattleReadyInfo autoBattleReadyInfoIndex1 = new AutoBattleReadyInfo();

	private AutoBattleReadyInfo autoBattleReadyInfoIndex2 = new AutoBattleReadyInfo();

	private AutoBattleReadyInfo autoBattleReadyInfoIndex3 = new AutoBattleReadyInfo();

	private AutoBattleReadyInfo autoBattleReadyInfoIndex4 = new AutoBattleReadyInfo();

	private AutoBattleReadyInfo autoBattleReadyInfoIndex5 = new AutoBattleReadyInfo();

	private AutoBattleReadyInfo autoBattleReadyInfoIndex6 = new AutoBattleReadyInfo();

	private CoroutineNode skillHoldTimeNode;

	private readonly FP extraStopDistance = 1;

	private readonly int minMonsterCount = 3;

	private readonly FP traceMoveAcc = 300;

	private readonly FP minStopDistance = 0;

	private readonly FP roadPointStopDistance = 0.5f;

	private readonly FP autoTraceCD = 1f;

	private bool isTracing;

	private LogicEntity currentTarget;

	private List<LogicEntity> searchResult;

	private FP originMoveAcc;

	private bool isMinStopDistanceMove;

	private bool isMoveToRoadPointing;

	private bool autoTraceCooling;

	private bool manualMove;

	private CoroutineNode autoTraceCoolingNode;

	private CoroutineNode navMoveAccGuardNode;

	[Header("Camera Config:")]
	[BlackList]
	public Camera closeupCamera;

	[BlackList]
	public Camera hudCamera;

	[Space]
	[BlackList]
	public CinemachineBlendDefinition.Style mainCameraBlendStyle = CinemachineBlendDefinition.Style.EaseInOut;

	[BlackList]
	public float mainCameraBlendTime = 2f;

	[BlackList]
	public CinemachineVirtualCamera playerMainVCam;

	[Space]
	[BlackList]
	public Image closeupBackground;

	[BlackList]
	public Color closeupBackgroundColor = new Color(0f, 0f, 0f, 0.5f);

	[BlackList]
	public LayerMask mainCamVisibleLayerMaskOnCloseup;

	[Space]
	[BlackList]
	public Transform cameraBeacon;

	[Space]
	[BlackList]
	public AdventureCameraControlConfigureData meleeSharedConfigureData;

	[BlackList]
	public AdventureCameraControlConfigureData rangeSharedConfigureData;

	[BlackList]
	public AdventureCameraControlConfigureData meleeSharedConfigureData_RoguelikeMode;

	[BlackList]
	public AdventureCameraControlConfigureData rangeSharedConfigureData_RoguelikeMode;

	[BlackList]
	public AdventureCameraControlConfigureData comboClipToolsConfigureData;

	[Space]
	[BlackList]
	public float cameraFollowTransitionCheckDistance = 0.5f;

	[Space]
	[BlackList]
	public bool enableDebugView;

	[Space]
	[BlackList]
	public GameObject meleeFOVTimeline;

	[BlackList]
	public GameObject rangeFOVTimeline;

	private bool swichActor;

	private float _actorSwitchTime;

	protected AdventureCameraControlConfigureData _defaultConfigureData;

	protected AdventureCameraControlConfigureData _overrideConfigureData;

	internal AdventureCameraControlConfigureData lastOverrideConfigureData;

	protected AdventureCameraControlConfigureData _customConfigureData;

	protected Vector3 _cameraFollowTargetPosition = Vector3.zero;

	protected Vector3 _cameraDampPosition = Vector3.zero;

	protected Vector3 _cameraDampVelocity = Vector3.zero;

	protected float _cameraOffsetRngRadius;

	protected float _cameraDampAngle;

	protected float _cameraDampAngleVelocity;

	protected float _cameraRotationDampAngle;

	protected float _cameraRotationDampAngleVelocity;

	protected float _cameraDepth;

	protected float _cameraDampDepth;

	protected float _cameraDampDepthVelocity;

	protected float _cameraFOVDamp;

	protected float _cameraFOVDampVelocity;

	protected float _cameraOffsetX;

	protected float _cameraOffsetY;

	protected float _cameraOffsetZ;

	protected Vector2 _playerAttackRange = Vector2.zero;

	protected float _cameraFollowSmoothTime;

	protected float _lastCameraConfigY;

	protected bool _cameraConfigYChanged;

	protected float _fixedCameraOffsetRngRadius;

	protected FP _fixedDuration;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	protected int _cameraControlEnableRC;

	private Transform cameraLookAt;

	private Transform playerProbe;

	private bool needCameraMove;

	protected GameObject _meleeFOVTimeline;

	protected GameObject _rangeFOVTimeline;

	protected PlayableDirector _fovDirector;

	protected float _zoomFreeze;

	protected float _zoomDurationTime;

	protected Tweener _cameraShakeTweener;

	protected float _shakeCoefficient;

	protected Vector3 _cameraShakeShifting = Vector3.zero;

	protected Vector3 _cameraShakeShiftingR = Vector3.zero;

	protected Vector3 _cameraShakeShiftingRz = Vector3.zero;

	protected float _cameraDelpth;

	private int _cameraShakeSort;

	private long _cameraShakeUniqueId;

	protected UniversalAdditionalCameraData _closeupCameraAdditionalCameraData;

	protected float _closeupCameraNearClipPlane;

	protected float _closeupCameraFarClipPlane;

	protected Canvas _closeupBackgroundCanvas;

	protected int _originMainCameraLayerMask;

	protected int _originPlayerMainVCamLayer;

	protected CinemachineTransposer _cameraTransposer;

	protected CinemachineComposer _cameraComposer;

	private readonly List<ICinemachineCamera> vCamList = new List<ICinemachineCamera>();

	private readonly List<AIAdapter> _discScripts = new List<AIAdapter>();

	private readonly string _elementTagManagerPath = "AIScript.ElementTagManager";

	private AIAdapter _elementTagManagerAI;

	private readonly string _fateCardThemeManagerPath = "AIScript.FateCardThemeManager";

	private AIAdapter _fateCardThemeManagerAI;

	[Header("Input Config:")]
	[BlackList]
	public bool enableTouchScreenSupport;

	[BlackList]
	public bool enableKeyboardMouseSupport;

	[BlackList]
	public bool enableJoystickSupport;

	private int _disableFire1RC;

	private int _disableFire2RC;

	private int _disableFire3RC;

	private int _disableFire4RC;

	private int _disableActorSwitch1RC;

	private int _disableActorSwitch2RC;

	private int _disableSwitchWithUltra1RC;

	private int _disableSwitchWithUltra2RC;

	private int _disableInteractiveRC;

	private int _disableTargetSwitchRC;

	internal bool _movementHasInput;

	internal Vector2 _movementInputVector;

	internal Vector2 _movementInputDirection;

	internal Vector2 _lastInputDirection = Vector2.zero;

	internal Vector2 _lastDirection = Vector2.zero;

	protected ButtonState _actionBtnAState;

	protected ButtonState _actionBtnBState;

	protected ButtonState _actionBtnCState;

	protected ButtonState _actionBtnDState;

	protected ButtonState _switchActorBtnAState;

	protected ButtonState _switchActorBtnBState;

	protected ButtonState _interactiveBtnState;

	protected ButtonState _targetSwitchBtnState;

	protected ButtonState _switchWithUltraBtnAState;

	protected ButtonState _switchWithUltraBtnBState;

	private const int MoveRatio = 10000;

	private const float MoveRatioRev = 0.0001f;

	private bool bFirstEnable = true;

	protected int _inputEnableRC;

	internal readonly Queue<OperationInfo> _operationsBuffer = new Queue<OperationInfo>();

	internal bool _movementHasInputBuffer;

	internal TSVector2 _movementInputDirectionBuffer;

	private readonly string _themeManagerPath = "AIScript.ThemeManager";

	private AIAdapter _themeManagerAI;

	public bool MainActorCanAttack
	{
		get
		{
			return _mainActorCanAttack;
		}
		set
		{
			if (_mainActorCanAttack != value)
			{
				_mainActorCanAttack = value;
				SetPlayerAtkRangeAlpha(_mainActorCanAttack);
			}
		}
	}

	[BlackList]
	public bool playerAgentSyncEnabled { get; protected set; }

	[BlackList]
	public bool playerAgentColliderEnabled => playerAgentCollider.enabled;

	[BlackList]
	public PlayerAdventureActor ActivedPlayerActor
	{
		get
		{
			return _activedPlayerActor;
		}
		set
		{
			_activedPlayerActor = value;
		}
	}

	public int FirstSlotActorId => _firstSlotActorId;

	public int SecondSlotActorId => _secondSlotActorId;

	[BlackList]
	public Dictionary<int, PlayerAdventureActor> ActorDicts => _actorDicts;

	[BlackList]
	public AdventureEntityGroup actorGroup => _actorGroup ?? (_actorGroup = SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID("STANDALONE_PLAYER_ACTOR_GROUP"));

	[BlackList]
	public LogicEntity activedPlayerActor => _activedPlayerActor;

	[BlackList]
	public LogicEntity dynamicActor => _dynamicActor;

	[BlackList]
	public AdventureCameraControlConfigureData activedSharedConigureData
	{
		get
		{
			if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower)
			{
				if (!isActiveMelee())
				{
					return rangeSharedConfigureData_RoguelikeMode;
				}
				return meleeSharedConfigureData_RoguelikeMode;
			}
			if (!isActiveMelee())
			{
				return rangeSharedConfigureData;
			}
			return meleeSharedConfigureData;
		}
	}

	[BlackList]
	public AdventureCameraControlConfigureData defaultConfigureData
	{
		get
		{
			return _defaultConfigureData;
		}
		set
		{
			_defaultConfigureData = value;
		}
	}

	[BlackList]
	public AdventureCameraControlConfigureData overrideConfigureData
	{
		get
		{
			return _overrideConfigureData;
		}
		set
		{
			_overrideConfigureData = value;
		}
	}

	[BlackList]
	public AdventureCameraControlConfigureData customConfigureData
	{
		get
		{
			return _customConfigureData;
		}
		set
		{
			_customConfigureData = value;
		}
	}

	[BlackList]
	public float cameraFollowDampTime
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraFollowSettings)
			{
				return _customConfigureData.cameraFollowDampTime;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraFollowSettings)
			{
				return _overrideConfigureData.cameraFollowDampTime;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraFollowSettings)
			{
				return _defaultConfigureData.cameraFollowDampTime;
			}
			return activedSharedConigureData.cameraFollowDampTime;
		}
	}

	[BlackList]
	public float cameraFollowRngRadius
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraFollowSettings)
			{
				return _customConfigureData.cameraFollowRngRadius;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraFollowSettings)
			{
				return _overrideConfigureData.cameraFollowRngRadius;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraFollowSettings)
			{
				return _defaultConfigureData.cameraFollowRngRadius;
			}
			return activedSharedConigureData.cameraFollowRngRadius;
		}
	}

	[BlackList]
	public float cameraOffsetRngRadius
	{
		get
		{
			if (_fixedCameraOffsetRngRadius > 0f && _fixedDuration > 0)
			{
				return _fixedCameraOffsetRngRadius;
			}
			if (null != _customConfigureData && _customConfigureData.enableCameraFollowSettings)
			{
				return _customConfigureData.cameraOffsetRngRadius;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraFollowSettings)
			{
				return _overrideConfigureData.cameraOffsetRngRadius;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraFollowSettings)
			{
				return _defaultConfigureData.cameraOffsetRngRadius;
			}
			return activedSharedConigureData.cameraOffsetRngRadius;
		}
	}

	[BlackList]
	public float cameraViewRngRadius
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraFollowSettings)
			{
				return _customConfigureData.cameraViewRngRadius;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraFollowSettings)
			{
				return _overrideConfigureData.cameraViewRngRadius;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraFollowSettings)
			{
				return _defaultConfigureData.cameraViewRngRadius;
			}
			return activedSharedConigureData.cameraViewRngRadius;
		}
	}

	[BlackList]
	public float cameraAngle
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraAngleSettings)
			{
				return _customConfigureData.cameraAngle;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraAngleSettings)
			{
				return _overrideConfigureData.cameraAngle;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraAngleSettings)
			{
				return _defaultConfigureData.cameraAngle;
			}
			return activedSharedConigureData.cameraAngle;
		}
	}

	[BlackList]
	public float cameraRotationAngle
	{
		get
		{
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraRotationSettings)
			{
				return _overrideConfigureData.cameraRotationAngle * (float)reversalCameraRotationAngle;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraRotationSettings)
			{
				return _defaultConfigureData.cameraRotationAngle * (float)reversalCameraRotationAngle;
			}
			return activedSharedConigureData.cameraRotationAngle * (float)reversalCameraRotationAngle;
		}
	}

	[BlackList]
	public int reversalCameraRotationAngle { get; set; } = 1;

	[BlackList]
	public float cameraFOV
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraViewportSettings)
			{
				return _customConfigureData.cameraFOV;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraViewportSettings)
			{
				return _overrideConfigureData.cameraFOV;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraViewportSettings)
			{
				return _defaultConfigureData.cameraFOV;
			}
			return activedSharedConigureData.cameraFOV;
		}
	}

	[BlackList]
	public Vector2 cameraDepthRng
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraDepthSettings)
			{
				return _customConfigureData.cameraDepthRng;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraDepthSettings)
			{
				return _overrideConfigureData.cameraDepthRng;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraDepthSettings)
			{
				return _defaultConfigureData.cameraDepthRng;
			}
			return activedSharedConigureData.cameraDepthRng;
		}
	}

	[BlackList]
	public float cameraHeightOffset
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraDepthSettings)
			{
				return _customConfigureData.cameraHeightOffset;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraDepthSettings)
			{
				return _overrideConfigureData.cameraHeightOffset;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraDepthSettings)
			{
				return _defaultConfigureData.cameraHeightOffset;
			}
			return activedSharedConigureData.cameraHeightOffset;
		}
	}

	[BlackList]
	public float cameraHorizontalOffset
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraDepthSettings)
			{
				return _customConfigureData.cameraHorizontalOffset;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraDepthSettings)
			{
				return _overrideConfigureData.cameraHorizontalOffset;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraDepthSettings)
			{
				return _defaultConfigureData.cameraHorizontalOffset;
			}
			return activedSharedConigureData.cameraHorizontalOffset;
		}
	}

	[BlackList]
	public Vector2 monsterHeightRng
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraDepthExtraSettings)
			{
				return _customConfigureData.monsterHeightRng;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraDepthExtraSettings)
			{
				return _overrideConfigureData.monsterHeightRng;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraDepthExtraSettings)
			{
				return _defaultConfigureData.monsterHeightRng;
			}
			return activedSharedConigureData.monsterHeightRng;
		}
	}

	[BlackList]
	public Vector2 playerAtkRng
	{
		get
		{
			if (null != _customConfigureData && _customConfigureData.enableCameraDepthExtraSettings)
			{
				return _customConfigureData.playerAtkRng;
			}
			if (null != _overrideConfigureData && _overrideConfigureData.enableCameraDepthExtraSettings)
			{
				return _overrideConfigureData.playerAtkRng;
			}
			if (null != _defaultConfigureData && _defaultConfigureData.enableCameraDepthExtraSettings)
			{
				return _defaultConfigureData.playerAtkRng;
			}
			return activedSharedConigureData.playerAtkRng;
		}
	}

	[BlackList]
	public bool cameraControlEnabled => _cameraControlEnableRC > 0;

	public bool disableFire1 => _disableFire1RC > 0;

	public bool disableFire2 => _disableFire2RC > 0;

	public bool disableFire3 => _disableFire3RC > 0;

	public bool disableFire4 => _disableFire4RC > 0;

	public bool disableActorSwitch1 => _disableActorSwitch1RC > 0;

	public bool disableActorSwitch2 => _disableActorSwitch2RC > 0;

	public bool disableSwitchWithUltra1 => _disableSwitchWithUltra1RC > 0;

	public bool disableSwitchWithUltra2 => _disableSwitchWithUltra2RC > 0;

	public bool disableInteractive => _disableInteractiveRC > 0;

	public bool disableTargetSwitch => _disableTargetSwitchRC > 0;

	[BlackList]
	public bool inputEnabled => _inputEnableRC > 0;

	private void SetPlayerAtkRangeAlpha(bool bPlayerCanAtk)
	{
		if (!(uifan == null))
		{
			uifan.color = (bPlayerCanAtk ? uifanColor_CanAtk : uifanColor_CanNotAtk);
		}
	}

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure");
		DisablePlayerAgentCollider();
		_mainActorCanAttack = true;
		SetPlayerAtkRangeAlpha(_mainActorCanAttack);
	}

	protected void Start()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_READY", OnLevelReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_START", OnLevelStart);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_END", OnLevelStop);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_FINISH", OnLevelFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", OnMonsterCleared);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnTriggerElementMark);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
	}

	protected void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_LEVEL_READY", OnLevelReady);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_LEVEL_START", OnLevelStart);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_LEVEL_END", OnLevelStop);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_LEVEL_FINISH", OnLevelFinish);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", OnMonsterCleared);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnTriggerElementMark);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
	}

	private void OnTriggerElementMark(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent { elementType: not HotfixEnum.elementType.NONE } adventureElementMarkTriggerEvent && !string.IsNullOrEmpty(adventureElementMarkTriggerEvent.tipsKey))
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("TriggerElementMark", adventureElementMarkTriggerEvent.markActor.Id, (int)adventureElementMarkTriggerEvent.elementType, adventureElementMarkTriggerEvent.tipsKey);
		}
	}

	protected void OnLevelReady(IEvent evt)
	{
		ValidateCameras();
		CameraControlEnable();
		EnablePlayerAgentSync();
		SceneSingleton<AdventureMiniMapController>.Instance.ResumeMinimapCameraFollowMotion();
	}

	protected void OnLevelStart(IEvent evt)
	{
		EnablePlayerAgentCollider();
	}

	protected void OnLevelStop(IEvent evt)
	{
		InputDisable();
		CameraControlDisable();
		DisablePlayerAgentSync();
		DisablePlayerAgentCollider();
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StopCoroutinesByOwner(this);
		}
		defaultConfigureData = null;
		overrideConfigureData = null;
		lastOverrideConfigureData = null;
		customConfigureData = null;
		if (tiliaShieldEntity != null)
		{
			tiliaShieldEntity.ActiveSelf = false;
			UnityEngine.Object.Destroy(tiliaShieldEntity);
			tiliaShieldEntity = null;
		}
		if (_activedPlayerActor != null)
		{
			PlayerAdventureActor playerAdventureActor = _activedPlayerActor;
			if (playerAdventureActor.movementState != ActorState.StandBy)
			{
				playerAdventureActor.StandBy();
			}
		}
	}

	private void OnLevelFinish(IEvent ievent)
	{
		playerAgent = null;
		playerAgentCollider = null;
		playerImpulseListener = null;
	}

	[BlackList]
	public void DriveUpdate()
	{
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		float deltaTime = Time.deltaTime;
		InputUpdate(unscaledDeltaTime);
		PlayerAgentUpdate(deltaTime);
	}

	public void FixCameraLateUpdate()
	{
		float deltaTime = Time.deltaTime;
		CameraUpdate(deltaTime);
	}

	[BlackList]
	public void DriveLateUpdate()
	{
		float deltaTime = Time.deltaTime;
		CameraLateUpdate(deltaTime);
	}

	[BlackList]
	public void LogicUpdate()
	{
		InputLogicUpdate();
		CheckAssistActorDeActive();
		UpdateDiscScripts();
		UpdateAutoBattle();
	}

	[BlackList]
	public void EnablePlayerAgentSync()
	{
		playerAgentSyncEnabled = true;
	}

	[BlackList]
	public void DisablePlayerAgentSync()
	{
		playerAgentSyncEnabled = false;
	}

	[BlackList]
	public void EnablePlayerAgentCollider()
	{
		if (null != playerAgentCollider)
		{
			playerAgentCollider.enabled = true;
		}
	}

	[BlackList]
	public void DisablePlayerAgentCollider()
	{
		if (null != playerAgentCollider)
		{
			playerAgentCollider.enabled = false;
		}
	}

	protected void PlayerAgentUpdate(float dt)
	{
		if (!(null == playerAgent))
		{
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			LogicEntity logicEntity = activedPlayerActor;
			if (playerAgentSyncEnabled && null != logicEntity)
			{
				playerAgent.transform.rotation = logicEntity.transform.rotation;
				playerAgent.transform.position = logicEntity.transform.position;
			}
			else
			{
				playerAgent.transform.rotation = mainCamera.transform.rotation;
				playerAgent.transform.position = mainCamera.transform.position;
			}
			Vector3 position = playerAgent.transform.position;
			position.y += playerAgentCollider.height * 0.5f;
			float radius = playerAgentCollider.radius;
			Shader.SetGlobalVector(GlobalShaderPropertyName.PlayerWorldPositionID, new Vector4(position.x, position.y, position.z, radius));
			Vector3 vector = mainCamera.WorldToViewportPointAsHFOV(position);
			Shader.SetGlobalVector(GlobalShaderPropertyName.PlayerScreenPositionID, new Vector4(vector.x, vector.y, vector.z, 1f));
		}
	}

	[BlackList]
	public void Teleporter_PlayRunForward(TSVector2 targetPosition, bool enableMove)
	{
		PlayerAdventureActor player = _activedPlayerActor;
		if (null == player)
		{
			return;
		}
		TeleporterForceShow();
		if (!enableMove)
		{
			if (inputEnabled)
			{
				InputDisable();
			}
		}
		else
		{
			if (!inputEnabled)
			{
				InputEnable();
			}
			if (MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
			{
				SceneSingleton<AdventureIndicatorController>.Instance.FadeInTargetBlobRangeGraphic();
				MonoSingleton<LuaManager>.Instance.FireEvent("ShowPlayerHudRootCanvas");
			}
		}
		if (!ModuleController<AdventureModuleController>.Instance.isReconnected)
		{
			FP terrainHeight = CommonHelper.GetTerrainHeight(targetPosition, player.tsTransform.PositionY);
			if (player.QueryPositionReachable(targetPosition, terrainHeight))
			{
				player.isBornForceMove = true;
				player.MoveTo(targetPosition, 0.1, enableNavigation: false, AdventureActor.MovementMode.Run, null, randomMove: false, forceMove: false, default, () =>
				{
					player.isBornForceMove = false;
					if (!inputEnabled && !enableMove)
					{
						InputEnable();
					}
					if (!enableMove && MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
					{
						SceneSingleton<AdventureIndicatorController>.Instance.FadeInTargetBlobRangeGraphic();
						if (MonoSingleton<GameController>.Instance != null)
						{
							MonoSingleton<GameController>.Instance.entryLevelUIFadeIn = false;
						}
						MonoSingleton<LuaManager>.Instance.FireEvent("ShowPlayerHudRootCanvas");
					}
					AdventurActorSpawnedComplete aEvent = AdventurActorSpawnedComplete.Generate();
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
				});
			}
			else
			{
				if (!inputEnabled)
				{
					InputEnable();
				}
				if (!enableMove && MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
				{
					SceneSingleton<AdventureIndicatorController>.Instance.FadeInTargetBlobRangeGraphic();
					MonoSingleton<LuaManager>.Instance.FireEvent("ShowPlayerHudRootCanvas");
				}
			}
		}
		else if (!inputEnabled)
		{
			InputEnable();
		}
	}

	[BlackList]
	public void TeleporterForceShow()
	{
		PlayerAdventureActor playerAdventureActor = _activedPlayerActor;
		if (playerAdventureActor.isBondage)
		{
			playerAdventureActor.ExitBondage();
		}
		if (playerAdventureActor.isHide)
		{
			playerAdventureActor.Visible();
		}
		if (!inputEnabled)
		{
			InputEnable();
		}
		SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
	}

	[BlackList]
	public void showBronFx(GameObject effectObj = null)
	{
		if (null == _activedPlayerActor)
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = _activedPlayerActor;
		if (null == playerAdventureActor)
		{
			return;
		}
		if (effectObj == null)
		{
			if (playerAdventureActor.comboGroup != null && playerAdventureActor.comboGroup.switchInEffect != null && playerAdventureActor.comboGroup.switchInEffect.effectPrefab != null)
			{
				playerAdventureActor._attackFSM.PlayEffect(oneShot: true, -1, playerAdventureActor.comboGroup.switchInEffect, playerAdventureActor.tsTransform.Position, playerAdventureActor.tsTransform.PositionY, playerAdventureActor.tsTransform.Rotation, bindActor: false);
			}
			else if (playerAdventureActor.comboGroup != null && playerAdventureActor.comboGroup.switchOutEffect != null && playerAdventureActor.comboGroup.switchOutEffect.effectPrefab != null)
			{
				playerAdventureActor._attackFSM.PlayEffect(oneShot: true, -1, playerAdventureActor.comboGroup.switchOutEffect, playerAdventureActor.tsTransform.Position, playerAdventureActor.tsTransform.PositionY, playerAdventureActor.tsTransform.Rotation, bindActor: false);
			}
		}
		else
		{
			Vector3 spawnPosition = new Vector3((float)playerAdventureActor.tsTransform.Position.x, (float)playerAdventureActor.tsTransform.PositionY, (float)playerAdventureActor.tsTransform.Position.y);
			Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)playerAdventureActor.tsTransform.Rotation, 0f);
			AdventureFXPlayer.PlayFX(effectObj, 1f, spawnPosition, spawnRotation);
		}
	}

	[BlackList]
	public void TeleporterForceHide(bool showfx = true)
	{
		if (!(null == _activedPlayerActor))
		{
			if (!_activedPlayerActor.isHide)
			{
				_activedPlayerActor.Hide();
			}
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		}
	}

	public bool IsCoroutineAlive()
	{
		return true;
	}

	public bool IsCoroutineRunning()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			return !ModuleController<AdventureModuleController>.Instance.isPause;
		}
		return false;
	}

	public FP GetCoroutineDeltaTime()
	{
		return ICoroutineOwner.UseDefaultDeltaTime;
	}

	public CoroutineNode StartLogicCoroutine(IEnumerator routine, bool runImmediately = false)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			return ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StartCoroutine(routine, this, runImmediately);
		}
		return null;
	}

	public void StopLogicCoroutine(CoroutineNode coroutine)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StopCoroutine(coroutine);
		}
	}

	public void SetDynamicActor(LogicEntity dynamic_actor)
	{
		_dynamicActor = dynamic_actor;
	}

	[BlackList]
	public void LevelEnd()
	{
		_actorGroup = null;
		_beDeactiveActors.Clear();
		_actorDicts.Clear();
		_firstSlotActorId = 0;
		_secondSlotActorId = 0;
		ClearAutoBattle();
		_dynamicActor = null;
	}

	[BlackList]
	public void OnPlayerActorsLoaded()
	{
		if (actorGroup == null)
		{
			return;
		}
		_hideByInit = false;
		ActorLs.Clear();
		List<LogicEntity> members = actorGroup.members;
		int count = members.Count;
		if (count <= 0)
		{
			return;
		}
		for (int i = 0; i < count; i++)
		{
			PlayerAdventureActor playerAdventureActor = members.get_Item(i) as PlayerAdventureActor;
			if (!(playerAdventureActor == null))
			{
				switch (i)
				{
				case 0:
					_activedPlayerActor = playerAdventureActor;
					break;
				case 1:
					_firstSlotActorId = playerAdventureActor.dataID;
					break;
				case 2:
					_secondSlotActorId = playerAdventureActor.dataID;
					break;
				}
				_actorDicts.set_Item(playerAdventureActor.dataID, playerAdventureActor);
				ActorLs.Add(playerAdventureActor);
			}
		}
	}

	public void SummonMonsters()
	{
		List<Lua2CSharpInfo_SummonMonsterInfo> summonMonsters = ModuleController<AdventureModuleController>.Instance.SummonMonsters;
		if (summonMonsters == null || summonMonsters.Count <= 0)
		{
			return;
		}
		foreach (Lua2CSharpInfo_SummonMonsterInfo summonInfo in ModuleController<AdventureModuleController>.Instance.SummonMonsters)
		{
			if (!_actorDicts.TryGetValue(summonInfo.summonerId, out var value))
			{
				continue;
			}
			TSVector2 pos = _activedPlayerActor.RandomActorReachablePointInsideRing(_activedPlayerActor.tsTransform.Position, 1, ModuleController<AdventureModuleController>.Instance.sharedConfigureData.SummonMonsterCorssLevelSpawnRadius);
			FP leftTime = new FP(summonInfo.leftTime);
			ILRuntimeAPI.SummonMonster(value, 0, summonInfo.monsterId, pos, _activedPlayerActor.tsTransform.Forward, summonInfo.summonCfg, null, (MonsterAdventureActor monster) =>
			{
				if (!(monster == null))
				{
					monster.actorHealthInfo.hp = summonInfo.hp;
					monster.monsterSummonInfo.AddLeftTime(leftTime - summonInfo.summonCfg.leftTime);
					List<Lua2CSharpInfo_ResetBuffInfo> buffInfos = summonInfo.buffInfos;
					if (buffInfos != null && buffInfos.Count > 0)
					{
						BuffCom logicComponent = monster.GetLogicComponent<BuffCom>();
						if (!(logicComponent == null))
						{
							foreach (Lua2CSharpInfo_ResetBuffInfo buffInfo in summonInfo.buffInfos)
							{
								logicComponent.ResetBuff(buffInfo.Id, buffInfo.buffNum, new FP(buffInfo.Cd));
							}
						}
					}
				}
			});
		}
	}

	[BlackList]
	public void InitSwitchPlayerStatus()
	{
		if (actorGroup == null)
		{
			return;
		}
		_alreadyAddedEnergy.Clear();
		if (null != _activedPlayerActor)
		{
			_activedPlayerActor.SetActorOperateType(assist: false);
			Active(_activedPlayerActor);
		}
		if (!_hideByInit)
		{
			_hideByInit = true;
			if (_actorDicts.TryGetValue(_firstSlotActorId, out var value))
			{
				value.SetActorOperateType(assist: true);
				HideByInit(value);
			}
			if (_actorDicts.TryGetValue(_secondSlotActorId, out value))
			{
				value.SetActorOperateType(assist: true);
				HideByInit(value);
			}
		}
		AdventurePlayeSpawnCompleteEvent aEvent = AdventurePlayeSpawnCompleteEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
	}

	public PlayerAdventureActor GetFirstSlotActor()
	{
		return _actorDicts.GetValueOrDefault(_firstSlotActorId);
	}

	public PlayerAdventureActor GetSecondSlotActor()
	{
		return _actorDicts.GetValueOrDefault(_secondSlotActorId);
	}

	[BlackList]
	public bool CastAssistActorSkill(int id)
	{
		if (!CheckAssistActorSkillReady(id, showTips: true, out var actor, autoCast: false))
		{
			return false;
		}
		if (!CastAssistActorSkill(actor))
		{
			return false;
		}
		return true;
	}

	public bool CastAssistActorSkill(PlayerAdventureActor actor)
	{
		if (!Active(actor, 1))
		{
			return false;
		}
		AdventureAssistActorCastSkillEvent adventureAssistActorCastSkillEvent = AdventureAssistActorCastSkillEvent.Generate();
		adventureAssistActorCastSkillEvent.actorId = actor.dataID;
		adventureAssistActorCastSkillEvent.skillEventInfo = new SkillEventInfo(HotfixEnum.skillSlotType.B, 0);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureAssistActorCastSkillEvent);
		if (!_beDeactiveActors.Contains(actor))
		{
			_beDeactiveActors.Add(actor);
		}
		actor.OnCastAssistSkillEvent(ActionKey.B);
		return true;
	}

	public bool CheckAssistActorSkillReady(int id, bool showTips, out PlayerAdventureActor actor, bool autoCast)
	{
		actor = null;
		if (actorGroup == null)
		{
			return false;
		}
		if (id == 0)
		{
			return false;
		}
		if (!_actorDicts.TryGetValue(id, out actor))
		{
			return false;
		}
		ActorHealthInfo actorHealthInfo = actor.actorHealthInfo;
		if (actorHealthInfo != null && !actorHealthInfo.isAlive)
		{
			return false;
		}
		if (!actor.isAssistAIFinish)
		{
			if (showTips)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("SupportSkillUnExecutableTips", actor.dataID, AdventureModuleController.Config.skillUnExecutableTipDuration);
			}
			return false;
		}
		if (!actor.CheckSkillReady(autoCast))
		{
			return false;
		}
		return true;
	}

	public void ActiveActor(PlayerAdventureActor actor, int type = 1)
	{
		Active(actor, type);
		if (!_beDeactiveActors.Contains(actor))
		{
			_beDeactiveActors.Add(actor);
		}
	}

	[BlackList]
	public bool CastAssistActorUltimate(int id)
	{
		if (!CheckAssistActorUltimateReady(id, out var actor, autoCast: false))
		{
			return false;
		}
		if (!CastAssistActorUltimate(actor))
		{
			return false;
		}
		return true;
	}

	public bool CastAssistActorUltimate(PlayerAdventureActor actor)
	{
		if (!Active(actor, 2))
		{
			return false;
		}
		AdventureAssistActorCastSkillEvent adventureAssistActorCastSkillEvent = AdventureAssistActorCastSkillEvent.Generate();
		adventureAssistActorCastSkillEvent.actorId = actor.dataID;
		adventureAssistActorCastSkillEvent.skillEventInfo = new SkillEventInfo(HotfixEnum.skillSlotType.D, 0);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureAssistActorCastSkillEvent);
		MonoSingleton<LuaManager>.Instance.FireEvent("SupUltraState", actor.dataID, a2: true);
		if (!_beDeactiveActors.Contains(actor))
		{
			_beDeactiveActors.Add(actor);
		}
		actor.OnCastAssistSkillEvent(ActionKey.D);
		return true;
	}

	public bool CheckAssistActorUltimateReady(int id, out PlayerAdventureActor actor, bool autoCast)
	{
		actor = null;
		if (actorGroup == null)
		{
			return false;
		}
		if (id == 0)
		{
			return false;
		}
		if (!_actorDicts.TryGetValue(id, out actor))
		{
			return false;
		}
		ActorHealthInfo actorHealthInfo = actor.actorHealthInfo;
		if (actorHealthInfo != null && !actorHealthInfo.isAlive)
		{
			return false;
		}
		if (!actor.CheckUltimateSkillReady(autoCast))
		{
			return false;
		}
		if (AdventureFXManager.IsPlayingTimeline)
		{
			return false;
		}
		return true;
	}

	public void CheckAssistActorDeActive()
	{
		if (_beDeactiveActors.Count <= 0)
		{
			return;
		}
		bool flag = false;
		for (int num = _beDeactiveActors.Count - 1; num >= 0; num--)
		{
			PlayerAdventureActor playerAdventureActor = _beDeactiveActors.get_Item(num);
			if (playerAdventureActor.isAssistAIFinish && !playerAdventureActor.isResidentAssist)
			{
				if (!playerAdventureActor.isSceneMove && !playerAdventureActor.isAssistLeaving)
				{
					playerAdventureActor.isAssistStartLeave = true;
					playerAdventureActor.isAssistLeaving = true;
					_ = (new TSVector2(MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform.position.x, MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform.position.z) - playerAdventureActor.tsTransform.Position).normalized;
					playerAdventureActor.EnablePenetrate();
					playerAdventureActor.PlayLeaveAnim();
				}
				if (!playerAdventureActor.IsInLeaveState() && !playerAdventureActor.isAssistStartLeave)
				{
					playerAdventureActor.DisablePenetrate();
					if (DeActive(playerAdventureActor))
					{
						playerAdventureActor.isAssistLeaving = false;
						flag = true;
						playerAdventureActor.isResident = false;
						AdventurePlayerLeaveEvent adventurePlayerLeaveEvent = AdventurePlayerLeaveEvent.Generate();
						adventurePlayerLeaveEvent.player = playerAdventureActor;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurePlayerLeaveEvent);
					}
				}
			}
		}
		if (flag)
		{
			_beDeactiveActors.RemoveAll((PlayerAdventureActor x) => !x.actived);
		}
	}

	private void HideByInit(PlayerAdventureActor actor)
	{
		actor.PauseBehaviour();
		actor.EnableHideModel();
		actor.EnableIgnoreDeterministicCollision();
	}

	private bool Active(PlayerAdventureActor actor, int type = 0)
	{
		if (actor == null)
		{
			return false;
		}
		bool actived = actor.actived;
		tslastPos = actor.tsTransform.Position;
		lastRot = actor.transform.rotation;
		lastPos = actor.transform.position;
		if (actor.Active())
		{
			if (ModuleController<AdventureModuleController>.Instance.adventureLevelState == AdventureLevelState.LevelStart || ModuleController<AdventureModuleController>.Instance.adventureLevelState == AdventureLevelState.BattleEnd)
			{
				actor.Action();
			}
			actor.isResident = true;
			AdventurePlayerEnterEvent adventurePlayerEnterEvent = AdventurePlayerEnterEvent.Generate();
			adventurePlayerEnterEvent.player = actor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurePlayerEnterEvent);
		}
		if (type != 0)
		{
			actor.Visible();
			SyncNextPlayer(actor, type);
			if (actived && TSVector2.Distance(tslastPos, actor.tsTransform.Position) > AdventureModuleController.Config.assistJumpDistance)
			{
				outFx.Play(actor, AdventureModuleController.Config.assistOutFx, 1f, lastPos, lastRot);
				Vector3 spawnPosition = new Vector3(actor.tsTransform.Position.x.AsFloat(), actor.tsTransform.PositionY.AsFloat(), actor.tsTransform.Position.y.AsFloat());
				inFx.Play(actor, AdventureModuleController.Config.assistInFx, 1f, spawnPosition, actor.transform.rotation);
			}
		}
		return true;
	}

	[BlackList]
	private bool DeActive(PlayerAdventureActor actor)
	{
		if (actor != null)
		{
			return actor.DeActive();
		}
		return false;
	}

	private void SyncNextPlayer(PlayerAdventureActor nextPlayer, int type)
	{
		nextPlayer.attackTarget = null;
		TSVector2 position = _activedPlayerActor.tsTransform.Position;
		TSVector2 forward = _activedPlayerActor.tsTransform.Forward;
		FP angle = nextPlayer.actorInfo.assistSkillAngle;
		FP radius = nextPlayer.actorInfo.assistSkillRadius;
		HotfixEnum.AssistOnStageType assistOnStageType = nextPlayer.actorInfo.assistSkillOnStageType;
		HotfixEnum.AssistOnStageOrientation assistOnStageOrientation = nextPlayer.actorInfo.assistSkillOnStageOrientation;
		if (type == 2)
		{
			assistOnStageType = nextPlayer.actorInfo.assistUltraOnStageType;
			assistOnStageOrientation = nextPlayer.actorInfo.assistUltraOnStageOrientation;
			angle = nextPlayer.actorInfo.assistUltimateAngle;
			radius = nextPlayer.actorInfo.assistUltimateRadius;
		}
		if (assistOnStageType == HotfixEnum.AssistOnStageType.Attack)
		{
			bool flag = _activedPlayerActor.attackTarget != null && ((AdventureActor)_activedPlayerActor.attackTarget).actorHealthInfo.isAlive;
			LogicEntity logicEntity = _activedPlayerActor.attackTarget;
			if (!flag)
			{
				logicEntity = SearchAttackTarget();
				if (logicEntity != null)
				{
					flag = true;
					nextPlayer.attackTarget = logicEntity;
				}
			}
			if (!flag)
			{
				TSVector2 normalized = _activedPlayerActor.tsTransform.Forward.normalized;
				FP backOffset = AdventureModuleController.Config.BackOffset;
				position = _activedPlayerActor.tsTransform.Position - backOffset * normalized;
				if (!_activedPlayerActor.QueryPositionReachable(position))
				{
					position = _activedPlayerActor.RandomActorReachablePointInsideRing(_activedPlayerActor.tsTransform.Position, AdventureModuleController.Config.defRdin, AdventureModuleController.Config.defRd);
				}
			}
			else
			{
				position = GetAngleReachablePoint(_activedPlayerActor, (AdventureActor)logicEntity, angle, radius);
				forward = (logicEntity.tsTransform.Position - position).normalized;
			}
		}
		else
		{
			position = GetDefendReachablePoint(_activedPlayerActor, angle, radius);
			switch (assistOnStageOrientation)
			{
			case HotfixEnum.AssistOnStageOrientation.None:
			case HotfixEnum.AssistOnStageOrientation.Same:
				forward = _activedPlayerActor.tsTransform.Forward;
				break;
			case HotfixEnum.AssistOnStageOrientation.LookAt:
				forward = (_activedPlayerActor.tsTransform.Position - position).normalized;
				break;
			case HotfixEnum.AssistOnStageOrientation.BackOn:
				forward = (position - _activedPlayerActor.tsTransform.Position).normalized;
				break;
			}
		}
		if (_beDeactiveActors.Count > 0 && TSVector2.Distance(position, _beDeactiveActors.get_Item(0).tsTransform.Position) < AdventureModuleController.Config.assistBornOverlapDistance)
		{
			position = _beDeactiveActors.get_Item(0).RandomActorReachablePointInsideRing(position, AdventureModuleController.Config.assistBornOverlapDistance, AdventureModuleController.Config.assistBornRandomOuterRadius);
		}
		nextPlayer.tsTransform.Position = position;
		nextPlayer.tsTransform.Forward = forward;
		FP positionY = _activedPlayerActor.tsTransform.PositionY;
		nextPlayer.tsTransform.PositionY = CommonHelper.GetTerrainHeight(position, positionY);
		nextPlayer.SyncMovementLocation();
		nextPlayer.assistWitchTimeTarget = null;
		if (nextPlayer.actorInfo.assistWitchTimeTargetType == HotfixEnum.FrozenTimeHighlightUnit.SelfAndTarget)
		{
			if (_activedPlayerActor.attackTarget != null && ((AdventureActor)_activedPlayerActor.attackTarget).actorHealthInfo.isAlive)
			{
				nextPlayer.assistWitchTimeTarget = _activedPlayerActor.attackTarget as AdventureActor;
			}
			else if (nextPlayer.attackTarget != null)
			{
				nextPlayer.assistWitchTimeTarget = nextPlayer.attackTarget as AdventureActor;
			}
			else
			{
				nextPlayer.assistWitchTimeTarget = SearchAttackTarget() as AdventureActor;
			}
		}
		LogicEntity SearchAttackTarget()
		{
			LogicEntity result = null;
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(AdventureModuleController.Config.SearchRadius, _activedPlayerActor.tsTransform.Position, list, 256);
			List<LogicEntity> list2 = new List<LogicEntity>();
			for (int i = 0; i < list.Count; i++)
			{
				LogicEntity entity = list.get_Item(i).Entity;
				if (entity != null)
				{
					list2.Add(entity);
				}
			}
			CommonHelper.SearchEntityAlive(list2);
			_activedPlayerActor.SearchEntityConfront(list2);
			if (list2.Count > 0)
			{
				_activedPlayerActor.SearchEntitySortByDistance(list2);
				result = list2.get_Item(0);
			}
			return result;
		}
	}

	private TSVector2 GetAngleReachablePoint(PlayerAdventureActor player, AdventureActor target, FP angle, FP radius)
	{
		TSVector2 normalized = (player.tsTransform.Position - target.tsTransform.Position).normalized;
		FP fP = angle / 2;
		if (TSRandom.Range(0, 10) > 5)
		{
			fP = -fP;
		}
		FP fP2 = radius + target.dtCollider.Radius;
		TSVector2 tSVector = TSVector2.Rotate(normalized, fP);
		TSVector2 tSVector2 = target.tsTransform.Position + tSVector * fP2;
		if (player.QueryPositionReachable(tSVector2))
		{
			return tSVector2;
		}
		tSVector = TSVector2.Rotate(normalized, -fP);
		tSVector2 = target.tsTransform.Position + tSVector * fP2;
		if (player.QueryPositionReachable(tSVector2))
		{
			return tSVector2;
		}
		FP defRdin = AdventureModuleController.Config.defRdin;
		FP defRd = AdventureModuleController.Config.defRd;
		return player.RandomActorReachablePointInsideRing(player.tsTransform.Position, defRdin, defRd);
	}

	private TSVector2 GetDefendReachablePoint(PlayerAdventureActor player, FP angle, FP radius)
	{
		TSVector2 tSVector = player.tsTransform.Forward;
		if (angle > 0)
		{
			tSVector = TSVector2.Rotate(tSVector, -angle);
		}
		TSVector2 tSVector2 = player.tsTransform.Position + tSVector * radius;
		if (player.QueryPositionReachable(tSVector2))
		{
			return tSVector2;
		}
		TSVector2 tSVector3 = player.RandomActorReachablePointInsideRing(tSVector2, 0, AdventureModuleController.Config.defRd);
		if (tSVector3 != tSVector2)
		{
			return tSVector3;
		}
		return player.RandomActorReachablePointInsideRing(player.tsTransform.Position, AdventureModuleController.Config.defRdin, AdventureModuleController.Config.defRd);
	}

	[BlackList]
	public int GetUniqueAttackId()
	{
		return uniqueAttackId++;
	}

	[BlackList]
	public void AddEnergy(int uniqueAttackId, FP energy, AdventureActor actor, int skillId)
	{
		if (_alreadyAddedEnergy.Contains(uniqueAttackId))
		{
			return;
		}
		_alreadyAddedEnergy.Add(uniqueAttackId);
		if (actor is PlayerAdventureActor playerAdventureActor && skillId > 0)
		{
			SkillEnergyInfo skillEnergyInfo = playerAdventureActor.playerSkillCd.GetSkillEnergyInfo(skillId);
			if (skillEnergyInfo != null)
			{
				energy = TSMath.Min(skillEnergyInfo.maxEnergy - skillEnergyInfo.curEnergy, energy);
				skillEnergyInfo.curEnergy += energy;
			}
		}
		AddEnergy(energy);
	}

	[BlackList]
	public void AddEnergy(FP energy)
	{
		if (!(energy == 0))
		{
			if (_activedPlayerActor != null)
			{
				_activedPlayerActor.playerSkillCd?.AddEnergy(energy * _activedPlayerActor.frontEnergyConvertRatio);
			}
			if (_actorDicts.TryGetValue(_firstSlotActorId, out var value))
			{
				value.playerSkillCd?.AddEnergy(energy * value.energyConvertRatio);
			}
			if (_actorDicts.TryGetValue(_secondSlotActorId, out value))
			{
				value.playerSkillCd?.AddEnergy(energy * value.energyConvertRatio);
			}
		}
	}

	[BlackList]
	public void SwitchTarget()
	{
		if (!(ActivedPlayerActor == null))
		{
			_leftTime = 100;
			LogicEntity switchConfrontActor = ActivedPlayerActor.actorSearchTargetInfo.GetSwitchConfrontActor();
			if (switchConfrontActor != null)
			{
				selectEntity = switchConfrontActor;
				ActivedPlayerActor.attackTarget = switchConfrontActor;
				_defaultSelect = switchConfrontActor;
			}
		}
	}

	[BlackList]
	public void UpdateSwitchTargetCD(FP _deltaTime)
	{
		if (_leftTime > 0)
		{
			_leftTime -= _deltaTime;
			if (_leftTime < 0)
			{
				ClearSwitchTargetLs();
			}
		}
	}

	[BlackList]
	public void ClearSwitchTargetLs(bool swichOff = false)
	{
		if (swichOff)
		{
			selectEntity = null;
		}
		searchList.Clear();
	}

	[BlackList]
	public LogicEntity GetSelectTarget()
	{
		if (selectEntity == null)
		{
			return null;
		}
		if (!selectEntity.IsDead() && !selectEntity.IsSearchedImmunity())
		{
			if (ActivedPlayerActor.movementState != ActorState.Dodge)
			{
				return selectEntity;
			}
			return null;
		}
		ClearSwitchTargetLs(swichOff: true);
		return null;
	}

	[BlackList]
	public LogicEntity GetDefaultSelectTarget(List<LogicEntity> scope)
	{
		if (_defaultSelect == null)
		{
			return null;
		}
		if (_defaultSelect.IsDead() || _defaultSelect.IsSearchedImmunity())
		{
			_defaultSelect = null;
			ClearSwitchTargetLs(swichOff: true);
			return null;
		}
		if (scope.Count <= 0)
		{
			return null;
		}
		if (!scope.Contains(_defaultSelect))
		{
			return null;
		}
		return _defaultSelect;
	}

	[BlackList]
	public bool CheckAlreadySearch(List<LogicEntity> scope, bool isH = false)
	{
		if (scope.Count <= 0)
		{
			return scope.Count > 0;
		}
		if (scope.Count <= searchList.Count)
		{
			int num = 0;
			for (int num2 = scope.Count - 1; num2 >= 0; num2--)
			{
				if (isAlreadySearch(scope.get_Item(num2)))
				{
					num++;
				}
			}
			if (scope.Count == num)
			{
				if (isH)
				{
					ClearSwitchTargetLs();
				}
				return false;
			}
		}
		for (int num3 = scope.Count - 1; num3 >= 0; num3--)
		{
			if (isAlreadySearch(scope.get_Item(num3)))
			{
				scope.RemoveAt(num3);
			}
		}
		return scope.Count > 0;
	}

	[BlackList]
	public void AddToSearchList(LogicEntity _scope)
	{
		if (!searchList.Contains(_scope.Id))
		{
			searchList.Add(_scope.Id);
		}
	}

	private bool isAlreadySearch(LogicEntity _scope)
	{
		if (searchList.Count <= 0)
		{
			if (ActivedPlayerActor?.attackTarget != null)
			{
				AddToSearchList(ActivedPlayerActor.attackTarget);
			}
			return false;
		}
		return searchList.Contains(_scope.Id);
	}

	[BlackList]
	public void OnEnterAlertEvent(List<LogicEntity> enterAlertActors, LogicEntity entity)
	{
		for (int i = 0; i < enterAlertActors.Count; i++)
		{
			if (enterAlertActors.get_Item(i).Id != entity.Id && !alertEntity.ContainsKey(enterAlertActors.get_Item(i).Id) && !dieEntity.Contains(enterAlertActors.get_Item(i).Id))
			{
				AdventureActor component = enterAlertActors.get_Item(i).GetComponent<AdventureActor>();
				if (component != null && component is MonsterAdventureActor && (component as MonsterAdventureActor).monsterInfo.subType == HotfixEnum.monsterSubType.Monster)
				{
					alertEntity.Add(enterAlertActors.get_Item(i).Id, component);
				}
			}
		}
		checkAlertState();
	}

	[BlackList]
	public void ActionAlert(AdventureActor _Enity, bool add = true)
	{
		if (add && _Enity is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Monster)
		{
			alertEntity.TryAdd(monsterAdventureActor.Id, monsterAdventureActor);
		}
		else
		{
			if (dieEntity.Count > 19)
			{
				dieEntity.Clear();
			}
			if (alertEntity.ContainsKey(_Enity.Id))
			{
				alertEntity.Remove(_Enity.Id);
				dieEntity.Add(_Enity.Id);
			}
			setActionEnemyLs(_Enity.Id, add: false);
		}
		checkAlertState();
	}

	private void checkAlertState()
	{
		alterLv = 999;
		if (alertEntity.Count == counsse)
		{
			return;
		}
		counsse = alertEntity.Count;
		foreach (AdventureActor value in alertEntity.Values)
		{
			if (value is MonsterAdventureActor monsterAdventureActor && (int)monsterAdventureActor.monsterInfo.epicType < alterLv && !monsterAdventureActor.isDead && monsterAdventureActor.Id > 0)
			{
				alterLv = (int)monsterAdventureActor.monsterInfo.epicType;
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.Mainline)
		{
			switch (alterLv)
			{
			case 2:
				MonoSingleton<WwiseAudioManager>.Instance.SetState("combat", "combatBoss");
				break;
			case 3:
				MonoSingleton<WwiseAudioManager>.Instance.SetState("combat", "combatLeader");
				break;
			case 4:
				MonoSingleton<WwiseAudioManager>.Instance.SetState("combat", "combatElite");
				break;
			case 5:
				MonoSingleton<WwiseAudioManager>.Instance.SetState("combat", "combatNomal");
				break;
			default:
				MonoSingleton<WwiseAudioManager>.Instance.SetState("combat", "explore");
				break;
			}
		}
		if (inAlert())
		{
			ModuleController<AdventureModuleController>.Instance.EnterBattleStateTimes++;
		}
		AdventureActorPLAYER_ALERT_STATEEvent adventureActorPLAYER_ALERT_STATEEvent = AdventureActorPLAYER_ALERT_STATEEvent.Generate();
		adventureActorPLAYER_ALERT_STATEEvent.inAlert = inAlert();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorPLAYER_ALERT_STATEEvent);
		if (!inAlert())
		{
			ClearSwitchTargetLs();
		}
	}

	[BlackList]
	public void setActionEnemyLs(long id, bool add)
	{
		if (add)
		{
			if (!actionEnemyEntity.Contains(id))
			{
				actionEnemyEntity.Add(id);
			}
		}
		else if (actionEnemyEntity.Contains(id))
		{
			actionEnemyEntity.Remove(id);
		}
		AdventureActorMONSTER_ENTERACTION_STATEEvent adventureActorMONSTER_ENTERACTION_STATEEvent = AdventureActorMONSTER_ENTERACTION_STATEEvent.Generate();
		adventureActorMONSTER_ENTERACTION_STATEEvent.enemyCount = getActionEnemyCount();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorMONSTER_ENTERACTION_STATEEvent);
	}

	[BlackList]
	public bool inAlert()
	{
		return counsse > 0;
	}

	[BlackList]
	public int getActionEnemyCount()
	{
		return actionEnemyEntity.Count;
	}

	[BlackList]
	public void AddTiliaShield(int buffId, FP duration, FP shieldRotateSpeed, bool counterAttack = false, FP counterAttackCoolDown = default(FP), FP counterAttackRadius = default(FP), int counterAttackHitDamageId = 0, int beBrokenBuff = 0)
	{
		if (tiliaShieldEntity == null)
		{
			GameObject gameObject = new GameObject("TiliaShieldEntity");
			tiliaShieldEntity = gameObject.AddComponent<TiliaShieldEntity>();
		}
		if (tiliaShieldEntity.logicUpdateEnabled)
		{
			tiliaShieldEntity.Finish();
		}
		tiliaShieldEntity.Initialize(buffId, duration, shieldRotateSpeed, counterAttack, counterAttackCoolDown, counterAttackRadius, counterAttackHitDamageId, beBrokenBuff);
	}

	public void EndCurrentWitchTime()
	{
		for (int i = 0; i < ActorLs.Count; i++)
		{
			ActorLs.get_Item(i).InterruptWitchTime();
		}
	}

	public void SaveGroupAttributeSnapshot()
	{
		foreach (PlayerAdventureActor actorL in ActorLs)
		{
			actorL.SavePlayerAttributeSnapshot();
		}
	}

	private void TestAreaEffect()
	{
		if (!(testAreaEffectPrefab == null) && activedPlayerActor is AdventureActor { transform: var transform } adventureActor)
		{
			SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(adventureActor, testAreaEffectPrefab, transform.position, transform.rotation);
		}
	}

	public void InitAutoBattle()
	{
		if (!(null == ActivedPlayerActor))
		{
			originMoveAcc = ActivedPlayerActor.actorInfo.moveAcceleration;
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		}
	}

	private void UpdateAutoBattle()
	{
		if (!(null == ActivedPlayerActor))
		{
			if (ModuleController<AdventureModuleController>.Instance.InBattleState && ModuleController<AdventureModuleController>.Instance.SemiAutoBattle)
			{
				ProcessAutoCastSkill();
			}
			if (ModuleController<AdventureModuleController>.Instance.FullAutoBattle)
			{
				ProcessBattleTrace();
				return;
			}
			CancelBattleTrace();
			ClearAutoTrace();
		}
	}

	private void ClearAutoBattle()
	{
		lastCastSkillActorId = 0;
		lastCastSkillTime = 0;
		CancelBattleTrace();
		ClearAutoTrace();
		BreakHoldActionKeyB();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
	}

	private void ClearAutoTrace()
	{
		EndBattleTrace();
		EndMoveToRoadPoint();
		autoTraceCooling = false;
		manualMove = false;
		if (autoTraceCoolingNode != null)
		{
			ActivedPlayerActor.StopLogicCoroutine(autoTraceCoolingNode);
			autoTraceCoolingNode = null;
		}
	}

	public void ProcessAutoCastSkill()
	{
		autoBattleReadyInfoIndex1.actionKey = ActionKey.None;
		autoBattleReadyInfoIndex2.actionKey = ActionKey.None;
		autoBattleReadyInfoIndex3.actionKey = ActionKey.None;
		autoBattleReadyInfoIndex4.actionKey = ActionKey.None;
		autoBattleReadyInfoIndex5.actionKey = ActionKey.None;
		autoBattleReadyInfoIndex6.actionKey = ActionKey.None;
		ActionKey actionKey = GetActorReadySkillKey(ActivedPlayerActor);
		if (actionKey != ActionKey.None)
		{
			int currentBindSkillId = ActivedPlayerActor.playerSkillCd.GetCurrentBindSkillId(actionKey);
			Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(currentBindSkillId);
			if (skill != null && !skill.CheckSkillInterval)
			{
				autoBattleReadyInfoIndex1.actor = ActivedPlayerActor;
				autoBattleReadyInfoIndex1.actionKey = actionKey;
				SendAutoBattleSkillCastEvent(autoBattleReadyInfoIndex1);
				return;
			}
			if (ActivedPlayerActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support)
			{
				SetDict(2, ActivedPlayerActor, actionKey);
			}
			else if (ActivedPlayerActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard)
			{
				SetDict(4, ActivedPlayerActor, actionKey);
			}
			else if (ActivedPlayerActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
			{
				SetDict(6, ActivedPlayerActor, actionKey);
			}
		}
		if (ActorDicts.TryGetValue(SecondSlotActorId, out var value))
		{
			GetAssistReadyInfo(value);
		}
		if (ActorDicts.TryGetValue(FirstSlotActorId, out value))
		{
			GetAssistReadyInfo(value);
		}
		for (int i = 1; i <= 6; i++)
		{
			if (autoBattleReadyInfoDict.TryGetValue(i, out var value2) && value2.actionKey != ActionKey.None)
			{
				if (lastCastSkillActorId == 0 || lastCastSkillActorId == value2.actor.dataID)
				{
					SendAutoBattleSkillCastEvent(value2);
					break;
				}
				if (LockStepManager.time - lastCastSkillTime > FP.FromConfigFloat(AdventureModuleController.Config.AutoBattleDifferentActorSkillInterval))
				{
					SendAutoBattleSkillCastEvent(value2);
					break;
				}
			}
		}
		void GetAssistReadyInfo(PlayerAdventureActor actor)
		{
			actionKey = GetActorReadySkillKey(actor);
			if (actionKey != ActionKey.None)
			{
				if (actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support)
				{
					SetDict(1, actor, actionKey);
				}
				else if (actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
				{
					SetDict(3, actor, actionKey);
				}
				else if (actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard)
				{
					SetDict(5, actor, actionKey);
				}
			}
		}
		void SendAutoBattleSkillCastEvent(AutoBattleReadyInfo readyInfo)
		{
			if (readyInfo.actionKey == ActionKey.B)
			{
				if (readyInfo.actor.isAssist)
				{
					CastAssistActorSkill(readyInfo.actor);
				}
				else
				{
					DispatchButtonInput(ActionKey.B, ButtonState.Press, isSimulative: true);
					FP actionHoldTime = ActivedPlayerActor.GetActionHoldTime(ActionKey.B);
					if (actionHoldTime > 0)
					{
						BreakHoldActionKeyB();
						skillHoldTimeNode = ActivedPlayerActor.StartLogicCoroutine(HoldActionKeyB(actionHoldTime));
					}
					else
					{
						DispatchButtonInput(ActionKey.B, ButtonState.Cancel, isSimulative: true);
					}
				}
			}
			else if (readyInfo.actionKey == ActionKey.D)
			{
				if (readyInfo.actor.isAssist)
				{
					CastAssistActorUltimate(readyInfo.actor);
				}
				else
				{
					DispatchButtonInput(ActionKey.D, ButtonState.Press, isSimulative: true);
				}
			}
		}
		void SetDict(int index, PlayerAdventureActor actor, ActionKey key)
		{
			if (autoBattleReadyInfoDict.ContainsKey(index))
			{
				autoBattleReadyInfoDict.get_Item(index).actor = actor;
				autoBattleReadyInfoDict.get_Item(index).actionKey = key;
			}
			else
			{
				AutoBattleReadyInfo autoBattleReadyInfo = autoBattleReadyInfoIndex1;
				switch (index)
				{
				case 2:
					autoBattleReadyInfo = autoBattleReadyInfoIndex2;
					break;
				case 3:
					autoBattleReadyInfo = autoBattleReadyInfoIndex3;
					break;
				case 4:
					autoBattleReadyInfo = autoBattleReadyInfoIndex4;
					break;
				case 5:
					autoBattleReadyInfo = autoBattleReadyInfoIndex5;
					break;
				case 6:
					autoBattleReadyInfo = autoBattleReadyInfoIndex6;
					break;
				}
				autoBattleReadyInfo.actor = actor;
				autoBattleReadyInfo.actionKey = key;
				autoBattleReadyInfoDict.Add(index, autoBattleReadyInfo);
			}
		}
	}

	private IEnumerator HoldActionKeyB(FP holdTime)
	{
		while (holdTime > FP.Zero)
		{
			holdTime -= ActivedPlayerActor.LogicDeltaTime;
			yield return null;
		}
		DispatchButtonInput(ActionKey.B, ButtonState.Cancel, isSimulative: true);
	}

	private void BreakHoldActionKeyB()
	{
		if (skillHoldTimeNode != null)
		{
			ActivedPlayerActor.StopLogicCoroutine(skillHoldTimeNode);
		}
		skillHoldTimeNode = null;
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent && !(evt.sender as AdventureActor != ActivedPlayerActor) && adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			DispatchButtonInput(ActionKey.B, ButtonState.Cancel, isSimulative: true);
			BreakHoldActionKeyB();
		}
	}

	private ActionKey GetActorReadySkillKey(PlayerAdventureActor actor)
	{
		if (actor.isAssist)
		{
			if (ModuleController<AdventureModuleController>.Instance.AutoCastUltimateSkill && CheckActionConditionByCustom(actor, ActionKey.D) && CheckMonsterInfoForUltimateSkill() && CheckAssistActorTargetReady() && CheckAssistActorUltimateReady(actor.dataID, out var actor2, autoCast: true))
			{
				return ActionKey.D;
			}
			if (CheckActionConditionByCustom(actor, ActionKey.B) && CheckAssistActorTargetReady() && CheckAssistActorSkillReady(actor.dataID, showTips: false, out actor2, autoCast: true))
			{
				return ActionKey.B;
			}
		}
		else
		{
			if (actor.dodgeButtonHold)
			{
				return ActionKey.None;
			}
			if (ModuleController<AdventureModuleController>.Instance.AutoCastUltimateSkill && CheckActionConditionByCustom(actor, ActionKey.D) && CheckMonsterInfoForUltimateSkill() && CheckAttackRange(actor.actorInfo.ultimateSemiAutoRng) && actor.CheckUltimateSkillReady(autoCast: true))
			{
				return ActionKey.D;
			}
			if (CheckActionConditionByCustom(actor, ActionKey.B) && CheckAttackRange(actor.actorInfo.skillSemiAutoRng) && actor.CheckSkillReady(autoCast: true))
			{
				return ActionKey.B;
			}
		}
		return ActionKey.None;
	}

	private bool CheckActionConditionByCustom(PlayerAdventureActor actor, ActionKey key)
	{
		return actor.CheckActionCondition(key);
	}

	private void OnActorCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B || adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D) && adventureActorCastSkillEvent.skillEventInfo.checkSkillInterval)
		{
			lastCastSkillTime = LockStepManager.time;
			lastCastSkillActorId = ((AdventureActor)adventureActorCastSkillEvent.sender).dataID;
		}
	}

	private bool CheckAttackRange(FP range)
	{
		if (ActivedPlayerActor.attackTarget == null || !((AdventureActor)ActivedPlayerActor.attackTarget).actorHealthInfo.isAlive)
		{
			return false;
		}
		return ActivedPlayerActor.DistanceWithRadius(ActivedPlayerActor.attackTarget) <= range;
	}

	private bool CheckAssistActorTargetReady()
	{
		if (ActivedPlayerActor.attackTarget != null && ((AdventureActor)ActivedPlayerActor.attackTarget).actorHealthInfo.isAlive && ActivedPlayerActor.DistanceWithRadius(ActivedPlayerActor.attackTarget) <= ActivedPlayerActor.actorSearchTargetInfo.hearAttackRange)
		{
			return true;
		}
		List<DeterministicCollider> list = new List<DeterministicCollider>();
		SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(ActivedPlayerActor.actorSearchTargetInfo.hearAttackRange, ActivedPlayerActor.tsTransform.Position, list, 256);
		List<LogicEntity> list2 = new List<LogicEntity>();
		for (int i = 0; i < list.Count; i++)
		{
			LogicEntity entity = list.get_Item(i).Entity;
			if (entity != null)
			{
				list2.Add(entity);
			}
		}
		CommonHelper.SearchEntityAlive(list2);
		ActivedPlayerActor.SearchEntityConfront(list2);
		if (list2.Count > 0)
		{
			return true;
		}
		return false;
	}

	private bool CheckMonsterInfoForUltimateSkill()
	{
		bool result = true;
		if (ModuleController<AdventureModuleController>.Instance.monsterActors.Count <= minMonsterCount)
		{
			result = false;
			foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
			{
				if (monsterActor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.actorHealthInfo.isAlive && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	private void ProcessBattleTrace()
	{
		if (HasMovementInput())
		{
			manualMove = true;
			autoTraceCooling = false;
			if (autoTraceCoolingNode != null)
			{
				ActivedPlayerActor.StopLogicCoroutine(autoTraceCoolingNode);
				autoTraceCoolingNode = null;
			}
		}
		else if (manualMove)
		{
			manualMove = false;
			autoTraceCooling = true;
			autoTraceCoolingNode = ActivedPlayerActor.StartLogicCoroutine(AutoTraceCooling(), runImmediately: true);
		}
		AdventurePlaceHolder activePlaceHolder = ModuleController<AdventureModuleController>.Instance.GetActivePlaceHolder();
		if (activePlaceHolder != null && TSVector2.Distance(activePlaceHolder.tsTransform.Position, ActivedPlayerActor.tsTransform.Position) < activePlaceHolder.checkRadius)
		{
			activePlaceHolder.isActive = false;
		}
		if (manualMove || autoTraceCooling)
		{
			CancelBattleTrace();
			return;
		}
		if (isMoveToRoadPointing && ModuleController<AdventureModuleController>.Instance.GetActivePlaceHolder() == null)
		{
			CancelBattleTrace();
			return;
		}
		if (ActivedPlayerActor.disableMove || ActivedPlayerActor.dodgeButtonHold)
		{
			CancelBattleTrace();
			return;
		}
		if (ActivedPlayerActor.actorSkillManage != null && ActivedPlayerActor.actorSkillManage.HaveRunningSkill() && (!ActivedPlayerActor.actorSkillManage.CheckIsMovable() || isMinStopDistanceMove || isMoveToRoadPointing))
		{
			CancelBattleTrace();
			return;
		}
		if (isTracing && ActivedPlayerActor.actorSkillManage != null && ActivedPlayerActor.actorSkillManage.BreakOthers(SkillPhaseFeatureFlag.Move))
		{
			ActivedPlayerActor.InterruptAttack(force: true);
		}
		LogicEntity target = ActivedPlayerActor.attackTarget;
		if (target == null)
		{
			if (searchResult == null)
			{
				searchResult = new List<LogicEntity>();
			}
			else
			{
				searchResult.Clear();
			}
			List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
			if (monsterActors != null && monsterActors.Count > 0)
			{
				searchResult.AddRange(monsterActors);
			}
			CommonHelper.SearchEntityAlive(searchResult);
			ActivedPlayerActor.SearchEntityConfront(searchResult);
			ActivedPlayerActor.SearchEntitySortByDistance(searchResult);
			if (searchResult.Count > 0)
			{
				target = searchResult.get_Item(0);
			}
		}
		if ((isTracing || isMoveToRoadPointing) && ActivedPlayerActor.moveControlType == PlayerActorMoveType.Range)
		{
			if ((ActivedPlayerActor.actorSkillManage != null && ActivedPlayerActor.actorSkillManage.HaveRunningSkill()) || ActivedPlayerActor.aimMode != AdventureActor.AimMode.Forward)
			{
				ActivedPlayerActor.movementMode = AdventureActor.MovementMode.Walk;
			}
			else
			{
				ActivedPlayerActor.movementMode = AdventureActor.MovementMode.Run;
			}
		}
		FP stopDistance = ActivedPlayerActor.actorSearchTargetInfo.attackRange;
		if (ActivedPlayerActor.actorInfo.attackType == HotfixEnum.characterAttackType.RANGED)
		{
			stopDistance -= extraStopDistance;
		}
		if (target != null)
		{
			if (isTracing && target == currentTarget)
			{
				return;
			}
			if (!ActivedPlayerActor.actorSkillManage.HaveRunningSkill() && ILRuntimeAPI.IsObstacleBetweenActorAndTargetAndPreventNormalAttack(ActivedPlayerActor))
			{
				stopDistance = minStopDistance;
			}
			if (!(ActivedPlayerActor.DistanceWithRadius(target) > stopDistance))
			{
				return;
			}
			if (ActivedPlayerActor.actorSkillManage != null && ActivedPlayerActor.actorSkillManage.HaveRunningSkill())
			{
				if (ActivedPlayerActor.actorSkillManage.CheckIsMovable() && BeginBattleTrace() && ActivedPlayerActor.actorSkillManage.BreakOthers(SkillPhaseFeatureFlag.Move))
				{
					ActivedPlayerActor.InterruptAttack(force: true);
				}
			}
			else
			{
				BeginBattleTrace();
			}
			return;
		}
		CancelBattleTrace(alsoCancelMove: false);
		if (!ModuleController<AdventureModuleController>.Instance.GetActivePlaceHolderPosition(out var targetPosition) || isMoveToRoadPointing || ActivedPlayerActor.movementState != ActorState.StandBy || !(TSVector2.Distance(ActivedPlayerActor.tsTransform.Position, targetPosition) > roadPointStopDistance))
		{
			return;
		}
		if (ActivedPlayerActor.actorSkillManage != null && ActivedPlayerActor.actorSkillManage.HaveRunningSkill())
		{
			if (ActivedPlayerActor.actorSkillManage.CheckIsMovable() && BeginMoveToRoadPoint() && ActivedPlayerActor.actorSkillManage.BreakOthers(SkillPhaseFeatureFlag.Move))
			{
				ActivedPlayerActor.InterruptAttack(force: true);
			}
		}
		else
		{
			BeginMoveToRoadPoint();
		}
		bool BeginBattleTrace()
		{
			if (ActivedPlayerActor.actorInfo.fastSpeedMode)
			{
				return false;
			}
			if (ActivedPlayerActor.isBornForceMove)
			{
				return false;
			}
			bool result = true;
			ActivedPlayerActor.isPreventNormalAttackByObstacle = false;
			CancelBattleTrace();
			if (stopDistance == minStopDistance)
			{
				isMinStopDistanceMove = true;
			}
			isTracing = true;
			ActivedPlayerActor.actorInfo.moveAcceleration = traceMoveAcc;
			StartNavMoveAccGuard();
			if (ActivedPlayerActor.TrackMove(target, stopDistance, enableNavigation: true, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, null, EndBattleTrace))
			{
				currentTarget = target;
			}
			else
			{
				EndBattleTrace();
				result = false;
			}
			return result;
		}
		bool BeginMoveToRoadPoint()
		{
			if (ActivedPlayerActor.actorInfo.fastSpeedMode)
			{
				return false;
			}
			if (ActivedPlayerActor.isBornForceMove)
			{
				return false;
			}
			bool result = true;
			isMoveToRoadPointing = true;
			ActivedPlayerActor.actorInfo.moveAcceleration = traceMoveAcc;
			StartNavMoveAccGuard();
			PlayerAdventureActor playerAdventureActor = ActivedPlayerActor;
			TSVector2 targetPosition2 = targetPosition;
			FP stopDistance2 = roadPointStopDistance;
			Action onLeave = EndMoveToRoadPoint;
			if (!playerAdventureActor.MoveTo(targetPosition2, stopDistance2, enableNavigation: true, AdventureActor.MovementMode.Run, null, randomMove: false, forceMove: false, default, onLeave))
			{
				EndMoveToRoadPoint();
				result = false;
			}
			return result;
		}
	}

	private void EndBattleTrace()
	{
		if (isTracing)
		{
			RestoreOriginMoveAcc();
		}
		isTracing = false;
		isMinStopDistanceMove = false;
		StopNavMoveAccGuard();
	}

	private void EndMoveToRoadPoint()
	{
		if (isMoveToRoadPointing)
		{
			RestoreOriginMoveAcc();
		}
		isMoveToRoadPointing = false;
		StopNavMoveAccGuard();
	}

	private void RestoreOriginMoveAcc()
	{
		if (!(null == ActivedPlayerActor))
		{
			ActivedPlayerActor.actorInfo.moveAcceleration = originMoveAcc;
			ActivedPlayerActor.RefreshMovementAcc();
		}
	}

	private void StartNavMoveAccGuard()
	{
		StopNavMoveAccGuard();
		if (!(null == ActivedPlayerActor))
		{
			navMoveAccGuardNode = ActivedPlayerActor.StartLogicCoroutine(NavMoveAccGuard());
		}
	}

	private void StopNavMoveAccGuard()
	{
		if (navMoveAccGuardNode != null)
		{
			if (null != ActivedPlayerActor)
			{
				ActivedPlayerActor.StopLogicCoroutine(navMoveAccGuardNode);
			}
			navMoveAccGuardNode = null;
		}
	}

	private IEnumerator NavMoveAccGuard()
	{
		while ((isTracing || isMoveToRoadPointing) && !(null == ActivedPlayerActor))
		{
			if (ActivedPlayerActor.actorInfo.moveAcceleration != traceMoveAcc)
			{
				ActivedPlayerActor.actorInfo.moveAcceleration = traceMoveAcc;
				ActivedPlayerActor.RefreshMovementAcc();
			}
			yield return null;
		}
	}

	private void CancelBattleTrace(bool alsoCancelMove = true)
	{
		if (isTracing && ActivedPlayerActor.movementState == ActorState.Move)
		{
			ActivedPlayerActor.StandBy();
		}
		if ((isMoveToRoadPointing & alsoCancelMove) && ActivedPlayerActor.movementState == ActorState.Move)
		{
			ActivedPlayerActor.StandBy();
		}
		if (alsoCancelMove)
		{
			StopNavMoveAccGuard();
		}
	}

	private IEnumerator AutoTraceCooling()
	{
		FP duration = autoTraceCD;
		while (duration > 0)
		{
			duration -= ActivedPlayerActor.LogicDeltaTime;
			yield return null;
		}
		autoTraceCooling = false;
	}

	private bool isActiveMelee()
	{
		if (!(_activedPlayerActor == null))
		{
			ActorInfo actorInfo = _activedPlayerActor.actorInfo;
			return actorInfo == null || actorInfo.attackType != HotfixEnum.characterAttackType.RANGED;
		}
		return true;
	}

	[BlackList]
	public void SetupCameraStack()
	{
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		Camera mainCamera = instance.mainCamera;
		UniversalAdditionalCameraData mainCameraAdditionalCameraData = instance.mainCameraAdditionalCameraData;
		Camera uiCamera = instance.uiCamera;
		uiCamera.GetUniversalAdditionalCameraData();
		UniversalAdditionalCameraData universalAdditionalCameraData = closeupCamera.GetUniversalAdditionalCameraData();
		hudCamera.GetUniversalAdditionalCameraData();
		instance.SetupMainCameraRender();
		instance.SetCameraMode(mainCamera, GameCameraStackManager.CameraMode.MainMaster);
		instance.InsertCameraToCameraStack(closeupCamera, 0, GameCameraStackManager.CameraMode.MainSlave);
		instance.InsertCameraToCameraStack(hudCamera, 1, GameCameraStackManager.CameraMode.UIMaster);
		instance.SetCameraMode(uiCamera, GameCameraStackManager.CameraMode.UISlave);
		mainCameraAdditionalCameraData.volumeTrigger = playerAgent.transform;
		universalAdditionalCameraData.volumeTrigger = playerAgent.transform;
		instance.SetMainCameraBrainDefaultBlendSetting(mainCameraBlendStyle, mainCameraBlendTime);
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Combine(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(VirtualCameraBlendOverride));
		_closeupCameraAdditionalCameraData = universalAdditionalCameraData;
		_closeupCameraNearClipPlane = closeupCamera.nearClipPlane;
		_closeupCameraFarClipPlane = closeupCamera.farClipPlane;
		_closeupBackgroundCanvas = closeupBackground.GetComponentInParent<Canvas>();
		_originMainCameraLayerMask = mainCamera.cullingMask;
		_originPlayerMainVCamLayer = playerMainVCam.gameObject.layer;
	}

	[BlackList]
	public void UnSetupCameraStack()
	{
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		if (!(instance == null))
		{
			closeupCamera.GetUniversalAdditionalCameraData().volumeTrigger = null;
			instance.RemoveCameraFromCameraStack(closeupCamera);
			instance.RemoveCameraFromCameraStack(hudCamera);
			instance.DisableMainCameraBrainDefaultBlendSetting();
			CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Remove(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(VirtualCameraBlendOverride));
			vCamList.Clear();
		}
	}

	[BlackList]
	public void FixCameraOffsetRngRadius(float _radius, FP _duration)
	{
		_fixedCameraOffsetRngRadius = _radius;
		_fixedDuration = _duration;
	}

	[BlackList]
	public float GetRotateDurationTime()
	{
		if (null != _customConfigureData && _customConfigureData.enableCameraRotationSpdSetting)
		{
			return _customConfigureData.cameraRotationDuration;
		}
		if (null != _overrideConfigureData && _overrideConfigureData.enableCameraRotationSpdSetting)
		{
			return _overrideConfigureData.cameraRotationDuration;
		}
		if (null != _defaultConfigureData && _defaultConfigureData.enableCameraRotationSpdSetting)
		{
			return _defaultConfigureData.cameraRotationDuration;
		}
		return activedSharedConigureData.cameraRotationDuration;
	}

	[BlackList]
	public void CameraControlEnable()
	{
		_cameraControlEnableRC++;
		if (_cameraControlEnableRC == 1 && !(null == activedPlayerActor))
		{
			cameraLookAt = cameraBeacon;
			playerProbe = activedPlayerActor.transform;
			playerMainVCam.enabled = false;
			playerMainVCam.Follow = cameraLookAt;
			playerMainVCam.LookAt = cameraLookAt;
			if (null == _cameraComposer)
			{
				_cameraComposer = playerMainVCam.GetCinemachineComponent<CinemachineComposer>();
			}
			if (null == _cameraTransposer)
			{
				_cameraTransposer = playerMainVCam.GetCinemachineComponent<CinemachineTransposer>();
			}
			cameraLookAt.position = playerProbe.position;
			UpdateCameraFollowTargetPosition(initialize: true, 0f);
			_cameraDampPosition = _cameraFollowTargetPosition;
			_cameraDampAngle = cameraAngle;
			_cameraRotationDampAngle = cameraRotationAngle - 180f;
			_cameraDampDepth = _cameraDepth;
			_cameraFOVDamp = cameraFOV;
			float num = Mathf.Cos(MathF.PI / 180f * _cameraDampAngle) * _cameraDampDepth;
			_cameraOffsetX = (0f - Mathf.Sin(MathF.PI / 180f * _cameraRotationDampAngle)) * num;
			_cameraOffsetY = Mathf.Sin(MathF.PI / 180f * _cameraDampAngle) * _cameraDampDepth;
			_cameraOffsetZ = Mathf.Cos(MathF.PI / 180f * _cameraRotationDampAngle) * num;
			_cameraTransposer.m_FollowOffset = new Vector3(_cameraOffsetX, _cameraOffsetY, _cameraOffsetZ);
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			Vector3 position = cameraLookAt.transform.position;
			mainCamera.transform.position = position + _cameraTransposer.m_FollowOffset;
			playerMainVCam.transform.position = position + _cameraTransposer.m_FollowOffset;
			playerMainVCam.m_Lens.FieldOfView = _cameraFOVDamp;
			_cameraDampVelocity = Vector3.zero;
			_cameraDampAngleVelocity = 0f;
			_cameraRotationDampAngleVelocity = 0f;
			_cameraDampDepthVelocity = 0f;
			_cameraFOVDampVelocity = 0f;
			_cameraFollowSmoothTime = 0f;
			playerMainVCam.enabled = true;
		}
	}

	[BlackList]
	public void CameraControlDisable()
	{
		_cameraControlEnableRC--;
		if (_cameraControlEnableRC == 0)
		{
			playerMainVCam.Follow = null;
			playerMainVCam.LookAt = null;
		}
		if (_cameraControlEnableRC < 0)
		{
			_logger.LogWarning("CameraControlEnable与CameraControlDisable使用不匹配，请成对使用");
		}
	}

	[BlackList]
	public void ChangeVirtualCamera(bool enable, Transform flollow = null, Transform probe = null, CinemachineVirtualCamera vm = null, AdventureCameraControlConfigureData configureData = null)
	{
		if (enable)
		{
			MonoSingleton<GameCameraStackManager>.Instance.DisableMainCameraBrainDefaultBlendSetting();
			cameraLookAt = flollow;
			playerProbe = probe;
			if (cameraLookAt != null && playerProbe != null)
			{
				cameraLookAt.position = playerProbe.position;
			}
			if (vm != null)
			{
				_cameraComposer = vm.GetCinemachineComponent<CinemachineComposer>();
				_cameraTransposer = vm.GetCinemachineComponent<CinemachineTransposer>();
			}
			_customConfigureData = configureData;
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.SetMainCameraBrainDefaultBlendSetting(mainCameraBlendStyle, mainCameraBlendTime);
			cameraLookAt = cameraBeacon;
			if (activedPlayerActor != null)
			{
				playerProbe = activedPlayerActor.transform;
				cameraLookAt.position = playerProbe.position;
			}
			_cameraComposer = playerMainVCam.GetCinemachineComponent<CinemachineComposer>();
			_cameraTransposer = playerMainVCam.GetCinemachineComponent<CinemachineTransposer>();
			_customConfigureData = null;
		}
	}

	[BlackList]
	public void RefreshVirtualCamera()
	{
		cameraLookAt = cameraBeacon;
		if (activedPlayerActor != null)
		{
			playerProbe = activedPlayerActor.transform;
		}
	}

	public Vector3 GetMainCameraFollowPosition()
	{
		return playerMainVCam.Follow.transform.position;
	}

	protected void UpdateCameraFollowTargetPosition(bool initialize, float dt)
	{
		Vector3 position = playerProbe.position;
		_fixedDuration -= (FP)dt;
		_cameraFollowTargetPosition = new Vector3(position.x + cameraHorizontalOffset, position.y + cameraHeightOffset, position.z);
		_cameraOffsetRngRadius = cameraOffsetRngRadius;
		if (initialize)
		{
			_lastCameraConfigY = cameraHeightOffset;
			needCameraMove = false;
			_cameraDampPosition = _cameraFollowTargetPosition;
		}
		else
		{
			Vector3 position2 = cameraLookAt.position;
			float num = position2.x - position.x;
			float num2 = position2.z - position.z;
			needCameraMove = num * num + num2 * num2 >= cameraFollowRngRadius * cameraFollowRngRadius;
		}
		_playerAttackRange = playerAtkRng * 0.01f;
		float a = Mathf.Clamp01((0f - monsterHeightRng.x) / (monsterHeightRng.y - monsterHeightRng.x));
		ActorSearchTarget logicComponent = playerProbe.gameObject.GetLogicComponent<ActorSearchTarget>();
		if (logicComponent != null)
		{
			float b = Mathf.Clamp01(((float)logicComponent.GetCurrentAttackRange() - _playerAttackRange.x) / (_playerAttackRange.y - _playerAttackRange.x));
			float t = Mathf.Max(a, b);
			_cameraDepth = Mathf.Lerp(cameraDepthRng.x, cameraDepthRng.y, t);
		}
		_cameraFollowSmoothTime = cameraFollowDampTime;
		if (Math.Abs(_lastCameraConfigY - cameraHeightOffset) > Mathf.Epsilon)
		{
			_lastCameraConfigY = cameraHeightOffset;
			_cameraConfigYChanged = true;
		}
	}

	protected void CameraUpdate(float dt)
	{
		if (null == playerProbe || !cameraControlEnabled || (playerProbe.gameObject.TryGetComponent<PlayerAdventureActor>(out var component) && component.isSceneMove))
		{
			return;
		}
		UpdateCameraFollowTargetPosition(initialize: false, dt);
		if (swichActor)
		{
			_actorSwitchTime -= dt;
			if (_actorSwitchTime <= 0f)
			{
				_actorSwitchTime = 0f;
				swichActor = false;
			}
		}
		if (needCameraMove || _cameraConfigYChanged)
		{
			if (swichActor)
			{
				_cameraDampPosition = Vector3.SmoothDamp(cameraLookAt.position, _cameraFollowTargetPosition, ref _cameraDampVelocity, Mathf.Max(_actorSwitchTime, 0.1f));
			}
			else
			{
				_cameraDampPosition = Vector3.SmoothDamp(cameraLookAt.position, _cameraFollowTargetPosition, ref _cameraDampVelocity, _cameraFollowSmoothTime);
				if (_fixedDuration < 0)
				{
					Vector3 position = playerProbe.position;
					Vector2 vector = new Vector2(position.x, position.z);
					Vector2 vector2 = new Vector2(_cameraDampPosition.x, _cameraDampPosition.z);
					Vector2 vector3 = vector2 - vector;
					if (vector3.magnitude > cameraOffsetRngRadius)
					{
						Vector2 normalized = vector3.normalized;
						vector2 = vector + normalized * cameraOffsetRngRadius;
						_cameraDampPosition = new Vector3(vector2.x, _cameraDampPosition.y, vector2.y);
					}
				}
			}
		}
		if (_cameraConfigYChanged)
		{
			if (Mathf.Abs(_cameraDampPosition.y - (playerProbe.position.y + cameraHeightOffset)) <= 0.01f)
			{
				_cameraConfigYChanged = false;
			}
		}
		else
		{
			_cameraDampPosition.y = playerProbe.position.y + cameraHeightOffset;
		}
		float speed = 0f;
		Vector3 forward = Vector3.zero;
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.CameraGizmo)
		{
			Vector3 vector4 = _cameraDampPosition - cameraLookAt.position;
			speed = vector4.magnitude / dt;
			forward = vector4.normalized;
		}
		cameraLookAt.position = _cameraDampPosition;
		if (dt > float.Epsilon)
		{
			_cameraDampAngle = Mathf.SmoothDamp(_cameraDampAngle, cameraAngle, ref _cameraDampAngleVelocity, GetRotateDurationTime(), float.PositiveInfinity, dt);
			_cameraRotationDampAngle = Mathf.SmoothDamp(_cameraRotationDampAngle, cameraRotationAngle - 180f, ref _cameraRotationDampAngleVelocity, GetRotateDurationTime(), float.PositiveInfinity, dt);
			_cameraDampDepth = Mathf.SmoothDamp(_cameraDampDepth, _cameraDepth, ref _cameraDampDepthVelocity, GetRotateDurationTime(), float.PositiveInfinity, dt);
			_cameraFOVDamp = Mathf.SmoothDamp(_cameraFOVDamp, cameraFOV, ref _cameraFOVDampVelocity, GetRotateDurationTime(), float.PositiveInfinity, dt);
		}
		float num = Mathf.Cos(MathF.PI / 180f * _cameraDampAngle) * _cameraDampDepth;
		_cameraOffsetX = (0f - Mathf.Sin(MathF.PI / 180f * _cameraRotationDampAngle)) * num;
		_cameraOffsetY = Mathf.Sin(MathF.PI / 180f * _cameraDampAngle) * _cameraDampDepth;
		_cameraOffsetZ = Mathf.Cos(MathF.PI / 180f * _cameraRotationDampAngle) * num;
		_cameraTransposer.m_FollowOffset = new Vector3(_cameraOffsetX, _cameraOffsetY, _cameraOffsetZ);
		playerMainVCam.m_Lens.FieldOfView = _cameraFOVDamp;
		SceneSingleton<AdventureMiniMapController>.Instance.SyncMinimapCameraRotation();
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.CameraGizmo)
		{
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCameraGizmo(_cameraDampPosition, _cameraFollowTargetPosition, forward, speed, needCameraMove, Color.green);
		}
	}

	protected void CameraLateUpdate(float dt)
	{
		if (!cameraControlEnabled)
		{
			return;
		}
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		Camera mainCamera = instance.mainCamera;
		_ = instance.mainCameraAdditionalCameraData;
		Transform transform = mainCamera.transform;
		if (!closeupCamera.enabled)
		{
			transform.position += _cameraShakeShifting * _shakeCoefficient;
			if (_cameraDelpth != 0f)
			{
				transform.position += transform.forward.normalized * _cameraDelpth * _shakeCoefficient;
			}
			transform.eulerAngles += _cameraShakeShiftingR * _shakeCoefficient;
			if (playerImpulseListener != null)
			{
				playerImpulseListener.DoUpdate(dt, transform);
			}
		}
		else
		{
			closeupCamera.transform.SetPositionAndRotation(transform.position, transform.rotation);
			closeupCamera.SyncWith(mainCamera);
			if (_closeupCameraAdditionalCameraData.clearDepth)
			{
				closeupCamera.nearClipPlane = _closeupCameraNearClipPlane;
				closeupCamera.farClipPlane = _closeupCameraFarClipPlane;
			}
		}
	}

	protected void OnMonsterCleared(IEvent evt)
	{
		if (!(evt is AdventureLevelMonsterClearedEvent { isEmptyLevel: not false }))
		{
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
			if (AdventureModuleController.Config.FeedbackData_FinalKill != null && activedPlayerActor != null)
			{
				AdventureModuleController.Config.FeedbackData_FinalKill.Play(activedPlayerActor.transform.position, activedPlayerActor.gameObject);
			}
		}
		static void Action()
		{
			if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower && !ModuleController<AdventureModuleController>.Instance.levelLoadParams.isStarTowerPrologue && ModuleController<AdventureModuleController>.Instance.levelLoadParams.starTowerFloorSet != null)
			{
				switch ((HotfixEnum.starTowerRoomType)ModuleController<AdventureModuleController>.Instance.levelLoadParams.starTowerFloorSet.RoomType)
				{
				case HotfixEnum.starTowerRoomType.BattleRoom:
					MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("special_effect_slowmotion_end");
					break;
				case HotfixEnum.starTowerRoomType.EliteBattleRoom:
				case HotfixEnum.starTowerRoomType.BossRoom:
				case HotfixEnum.starTowerRoomType.FinalBossRoom:
				case HotfixEnum.starTowerRoomType.DangerRoom:
				case HotfixEnum.starTowerRoomType.HorrorRoom:
					MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("special_effect_slowmotion_end_longer_10s");
					break;
				}
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("FreezeFrameEnd");
		}
	}

	protected PlayableDirector GetCurFOVDirector()
	{
		PlayableDirector component;
		if (isActiveMelee())
		{
			if (_meleeFOVTimeline == null)
			{
				_meleeFOVTimeline = UnityEngine.Object.Instantiate(meleeFOVTimeline);
			}
			component = _meleeFOVTimeline.GetComponent<PlayableDirector>();
		}
		else
		{
			if (_rangeFOVTimeline == null)
			{
				_rangeFOVTimeline = UnityEngine.Object.Instantiate(rangeFOVTimeline);
			}
			component = _rangeFOVTimeline.GetComponent<PlayableDirector>();
		}
		if (component != null)
		{
			AdventureTimelinePlayer.BindCameraBrain(component, MonoSingleton<GameCameraStackManager>.Instance.mainCameraBrain);
		}
		return component;
	}

	private void TestZoom()
	{
		AdventureLevelMonsterClearedEvent adventureLevelMonsterClearedEvent = AdventureLevelMonsterClearedEvent.Generate();
		adventureLevelMonsterClearedEvent.isEmptyLevel = false;
		OnMonsterCleared(adventureLevelMonsterClearedEvent);
	}

	[BlackList]
	public long CameraShake(float cameraShakeDuration, Vector3 cameraShakeStrength, int cameraShakeVibrato, float cameraShakeRandomness, float cameraShakeRotate, float cameraShakeDepth, float cameraShakeFadeIn, float cameraShakeFadeOut, int cameraShakeSort = 0)
	{
		if (_cameraShakeTweener != null)
		{
			if (_cameraShakeSort > cameraShakeSort)
			{
				return -1L;
			}
			_cameraShakeTweener.Complete();
			_cameraShakeTweener = null;
			_shakeCoefficient = 0f;
			_cameraShakeShiftingRz = Vector3.zero;
			_cameraShakeShifting = Vector3.zero;
			_cameraShakeShiftingR = Vector3.zero;
		}
		_cameraShakeSort = cameraShakeSort;
		float duration = cameraShakeFadeIn + cameraShakeDuration + cameraShakeFadeOut;
		_cameraShakeTweener = DOTween.Shake(() => _cameraShakeShifting, (Vector3 x) =>
		{
			_cameraShakeShifting = x;
		}, duration, cameraShakeStrength, cameraShakeVibrato, cameraShakeRandomness, fadeOut: false, ShakeRandomnessMode.Harmonic).SetEase(Ease.Linear);
		float _fadeInDuration = 0f;
		float _duration = 0f;
		float _fadeOutDuration = 0f;
		_cameraShakeTweener.onUpdate = () =>
		{
			if (cameraShakeFadeIn > 0f && _fadeInDuration < cameraShakeFadeIn)
			{
				_fadeInDuration += Time.deltaTime;
				_shakeCoefficient = 0f + _fadeInDuration / cameraShakeFadeIn;
			}
			else if (_duration < cameraShakeDuration)
			{
				_duration += Time.deltaTime;
				_shakeCoefficient = 1f;
			}
			else if (cameraShakeFadeOut > 0f && _fadeOutDuration < cameraShakeFadeOut)
			{
				_fadeOutDuration += Time.deltaTime;
				_shakeCoefficient = 1f - _fadeOutDuration / cameraShakeFadeOut;
			}
			_shakeCoefficient = ((_shakeCoefficient >= 0f) ? _shakeCoefficient : 0f);
			_cameraShakeShiftingR.z = cameraShakeRotate * (_cameraShakeShifting.x + _cameraShakeShifting.y + _cameraShakeShifting.z) / 3f;
			_cameraDelpth = cameraShakeDepth * (_cameraShakeShifting.x + _cameraShakeShifting.y + _cameraShakeShifting.z) / 3f;
		};
		_cameraShakeTweener.onComplete = () =>
		{
			_cameraShakeSort = 0;
		};
		_cameraShakeUniqueId++;
		return _cameraShakeUniqueId;
	}

	public void StopCameraShake(long cameraShakeUniqueId)
	{
		if (cameraShakeUniqueId > 0 && _cameraShakeTweener != null && _cameraShakeUniqueId == cameraShakeUniqueId)
		{
			_cameraShakeTweener.Complete();
			_cameraShakeTweener = null;
			_shakeCoefficient = 0f;
			_cameraShakeShiftingRz = Vector3.zero;
			_cameraShakeShifting = Vector3.zero;
			_cameraShakeShiftingR = Vector3.zero;
		}
	}

	[BlackList]
	public void EnableCloseupCamera(float fadeTime = 1f, Color? fadeInBackgroundColor = null, bool withMainCamera = true, bool replaceMainCameraCullingMask = true, int closeupCameraRenderLayer = 26, bool clearDepth = true)
	{
		if (closeupCamera.enabled)
		{
			DisableCloseupCamera_Internal();
		}
		closeupCamera.enabled = true;
		closeupCamera.cullingMask = 1 << closeupCameraRenderLayer;
		_closeupCameraAdditionalCameraData.clearDepth = clearDepth;
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		if (withMainCamera)
		{
			mainCamera.cullingMask = (replaceMainCameraCullingMask ? mainCamVisibleLayerMaskOnCloseup.value : mainCamera.cullingMask);
		}
		else
		{
			mainCamera.cullingMask = 0;
		}
		MonoSingleton<GameCameraStackManager>.Instance.SetCameraMode(mainCamera, GameCameraStackManager.CameraMode.MainSlave);
		MonoSingleton<GameCameraStackManager>.Instance.SetCameraMode(closeupCamera, GameCameraStackManager.CameraMode.MainMaster);
		ProFlareControlHandler.HideAll();
		OcclusionRendererManager.Instance.PauseDetect();
		closeupBackground.DOKill();
		if (!(fadeTime > 0f))
		{
			if (fadeTime <= -1f)
			{
				_closeupBackgroundCanvas.enabled = false;
				return;
			}
			_closeupBackgroundCanvas.enabled = true;
			Color color = fadeInBackgroundColor ?? closeupBackgroundColor;
			closeupBackground.color = color;
		}
		else
		{
			_closeupBackgroundCanvas.enabled = true;
			Color color2 = fadeInBackgroundColor ?? closeupBackgroundColor;
			closeupBackground.color = new Color(color2.r, color2.g, color2.b, 0f);
			closeupBackground.DOFade(color2.a, fadeTime).SetUpdate(isIndependentUpdate: true);
		}
	}

	[BlackList]
	public void DisableCloseupCamera(float fadeTime = 1f)
	{
		if (!closeupCamera.enabled)
		{
			return;
		}
		closeupBackground.DOKill();
		if (fadeTime > 0f)
		{
			closeupBackground.DOFade(0f, fadeTime).SetUpdate(isIndependentUpdate: true).OnComplete(() =>
			{
				DisableCloseupCamera_Internal();
			});
		}
		else
		{
			DisableCloseupCamera_Internal();
		}
	}

	protected void DisableCloseupCamera_Internal()
	{
		if (closeupCamera.enabled)
		{
			closeupCamera.enabled = false;
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			mainCamera.cullingMask = _originMainCameraLayerMask;
			MonoSingleton<GameCameraStackManager>.Instance.SetCameraMode(mainCamera, GameCameraStackManager.CameraMode.MainMaster);
			MonoSingleton<GameCameraStackManager>.Instance.SetCameraMode(closeupCamera, GameCameraStackManager.CameraMode.MainSlave);
			ProFlareControlHandler.VisibleAll();
			OcclusionRendererManager.Instance.ResumeDetect();
			_closeupBackgroundCanvas.enabled = false;
		}
	}

	[BlackList]
	public CinemachineBlendDefinition VirtualCameraBlendOverride(ICinemachineCamera fromVcam, ICinemachineCamera toVcam, CinemachineBlendDefinition defaultBlend, MonoBehaviour owner)
	{
		if (!cameraControlEnabled)
		{
			return new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		}
		if (closeupCamera.enabled && ((CinemachineVirtualCamera)fromVcam == playerMainVCam || (CinemachineVirtualCamera)toVcam == playerMainVCam))
		{
			return new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		}
		if (vCamList.Contains(toVcam))
		{
			return new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		}
		return defaultBlend;
	}

	public void RegisterVmBlend(ICinemachineCamera vCam)
	{
		vCamList.Add(vCam);
	}

	[BlackList]
	public void ValidateCameras()
	{
		Camera[] allCameras = Camera.allCameras;
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		Camera uiCamera = MonoSingleton<GameCameraStackManager>.Instance.uiCamera;
		Camera mapCam = SceneSingleton<AdventureMiniMapController>.Instance.MapCam;
		Camera minimapCam = SceneSingleton<AdventureMiniMapController>.Instance.MinimapCam;
		foreach (Camera camera in allCameras)
		{
			if (camera.cameraType == CameraType.Game)
			{
				GameObject gameObject = camera.gameObject;
				if (!(camera == mainCamera) && !(camera == uiCamera) && !(camera == closeupCamera) && !(camera == hudCamera) && !(camera == mapCam) && !(camera == minimapCam) && !(gameObject.name == "FlareCamera"))
				{
					gameObject.SetActive(value: false);
					_logger.LogError("场景中有多余的摄像机:" + gameObject.name + " 场景名:" + gameObject.scene.name);
				}
			}
		}
	}

	public void EnableDiscScripts()
	{
		foreach (Lua2CSharpInfo_DiscInfo discInfo in ModuleController<AdventureModuleController>.Instance.DiscInfos)
		{
			if (!string.IsNullOrEmpty(discInfo.discScript))
			{
				AIAdapter aIAdapter = new AIAdapter();
				if (!aIAdapter.Initialize(discInfo.discScript, gameObject))
				{
					aIAdapter = null;
				}
				aIAdapter?.Start();
				if (aIAdapter != null)
				{
					_discScripts.Add(aIAdapter);
				}
			}
		}
	}

	public void DisableDiscScripts()
	{
		foreach (AIAdapter discScript in _discScripts)
		{
			discScript?.Disable();
		}
		_discScripts.Clear();
	}

	public void UpdateDiscScripts()
	{
		foreach (AIAdapter discScript in _discScripts)
		{
			discScript?.Update();
		}
	}

	public void EnableElementTagManager()
	{
		_elementTagManagerAI = new AIAdapter();
		if (!_elementTagManagerAI.Initialize(_elementTagManagerPath, gameObject))
		{
			_elementTagManagerAI = null;
		}
		_elementTagManagerAI?.Start();
	}

	public void DisableElementTagManager()
	{
		_elementTagManagerAI?.Disable();
		_elementTagManagerAI = null;
	}

	public void EnableFateCardThemeManager()
	{
		_fateCardThemeManagerAI = new AIAdapter();
		if (!_fateCardThemeManagerAI.Initialize(_fateCardThemeManagerPath, gameObject))
		{
			_fateCardThemeManagerAI = null;
		}
		_fateCardThemeManagerAI?.Start();
	}

	public void DisableFateCardThemeManager()
	{
		_fateCardThemeManagerAI?.Disable();
		_fateCardThemeManagerAI = null;
	}

	public void DisableFire1()
	{
		_disableFire1RC++;
	}

	public void EnableFire1()
	{
		_disableFire1RC--;
		if (_disableFire1RC < 0)
		{
			_disableFire1RC = 0;
			NovaLogger.Warning("EnableFire1与DisableFire1使用不匹配，请成对使用");
		}
	}

	public void DisableFire2()
	{
		_disableFire2RC++;
	}

	public void EnableFire2()
	{
		_disableFire2RC--;
		if (_disableFire2RC < 0)
		{
			_disableFire2RC = 0;
			NovaLogger.Warning("EnableFire2与DisableFire2使用不匹配，请成对使用");
		}
	}

	public void DisableFire3()
	{
		_disableFire3RC++;
	}

	public void EnableFire3()
	{
		_disableFire3RC--;
		if (_disableFire3RC < 0)
		{
			_disableFire3RC = 0;
			NovaLogger.Warning("EnableFire3与DisableFire3使用不匹配，请成对使用");
		}
	}

	public void DisableFire4()
	{
		_disableFire4RC++;
	}

	public void EnableFire4()
	{
		_disableFire4RC--;
		if (_disableFire4RC < 0)
		{
			_disableFire4RC = 0;
			NovaLogger.Warning("EnableFire4与DisableFire4使用不匹配，请成对使用");
		}
	}

	public void DisableActorSwitch1()
	{
		_disableActorSwitch1RC++;
	}

	public void EnableActorSwitch1()
	{
		_disableActorSwitch1RC--;
		if (_disableActorSwitch1RC < 0)
		{
			_disableActorSwitch1RC = 0;
			NovaLogger.Warning("EnableActorSwitch1与DisableActorSwitch1使用不匹配，请成对使用");
		}
	}

	public void DisableActorSwitch2()
	{
		_disableActorSwitch2RC++;
	}

	public void EnableActorSwitch2()
	{
		_disableActorSwitch2RC--;
		if (_disableActorSwitch2RC < 0)
		{
			_disableActorSwitch2RC = 0;
			NovaLogger.Warning("EnableActorSwitch2与DisableActorSwitch2使用不匹配，请成对使用");
		}
	}

	public void DisableSwitchWithUltra1()
	{
		_disableSwitchWithUltra1RC++;
	}

	public void EnableSwitchWithUltra1()
	{
		_disableSwitchWithUltra1RC--;
		if (_disableSwitchWithUltra1RC < 0)
		{
			_disableSwitchWithUltra1RC = 0;
			NovaLogger.Warning("EnableSwitchWithUltra1与DisableSwitchWithUltra1使用不匹配，请成对使用");
		}
	}

	public void DisableSwitchWithUltra2()
	{
		_disableSwitchWithUltra2RC++;
	}

	public void EnableSwitchWithUltra2()
	{
		_disableSwitchWithUltra2RC--;
		if (_disableSwitchWithUltra2RC < 0)
		{
			_disableSwitchWithUltra2RC = 0;
			NovaLogger.Warning("EnableSwitchWithUltra2与DisableSwitchWithUltra2使用不匹配，请成对使用");
		}
	}

	public void DisableInteractive()
	{
		_disableInteractiveRC++;
	}

	public void EnableInteractive()
	{
		_disableInteractiveRC--;
		if (_disableInteractiveRC < 0)
		{
			_disableInteractiveRC = 0;
			NovaLogger.Warning("EnableInteractive与DisableInteractive使用不匹配，请成对使用");
		}
	}

	public void DisableTargetSwitch()
	{
		_disableTargetSwitchRC++;
	}

	public void EnableTargetSwitch()
	{
		_disableTargetSwitchRC--;
		if (_disableTargetSwitchRC < 0)
		{
			_disableTargetSwitchRC = 0;
			NovaLogger.Warning("EnableTargetSwitch与DisableTargetSwitch使用不匹配，请成对使用");
		}
	}

	public void InputEnable()
	{
		if (SceneSingleton<PerformManager>.Instance.InPerform)
		{
			return;
		}
		_inputEnableRC = 1;
		MonoSingleton<LuaManager>.Instance.FireEvent("InputEnable", a1: true);
		if (_inputEnableRC == 1)
		{
			if (bFirstEnable)
			{
				bFirstEnable = false;
				CrossPlatformInputManager.ActiveRealButtonsAtFirstTime();
				MonoSingleton<LuaManager>.Instance.FireEvent("FirstInputEnable");
			}
			AdventureInputEnable adventureInputEnable = AdventureInputEnable.Generate();
			adventureInputEnable.enbale = true;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInputEnable);
		}
		if (bFirstEnable && _inputEnableRC != 1)
		{
			_logger.LogWarning("InputEnable与InputDisable使用不匹配，未正常激活玩家（手柄/键盘/鼠标）操控");
		}
	}

	public void InputDisable()
	{
		if (!SceneSingleton<PerformManager>.Instance.InPerform)
		{
			_inputEnableRC = 0;
			MonoSingleton<LuaManager>.Instance.FireEvent("InputEnable", a1: false);
			if (_inputEnableRC == 0)
			{
				CancelInput();
				ClearInput();
				AdventureInputEnable adventureInputEnable = AdventureInputEnable.Generate();
				adventureInputEnable.enbale = false;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInputEnable);
			}
			if (_inputEnableRC < 0)
			{
				_inputEnableRC = 0;
				_logger.LogWarning("InputEnable与InputDisable使用不匹配，请成对使用");
			}
		}
	}

	protected void InputUpdate(float dt)
	{
		CrossPlatformInputManager.Update(dt);
		if (!inputEnabled || MonoSingleton<ClientManager>.Instance.blockInputEnabled)
		{
			return;
		}
		_movementHasInput = false;
		_movementInputDirection = (_movementInputVector = Vector2.zero);
		float axis = CrossPlatformInputManager.GetAxis("Horizontal");
		float axis2 = CrossPlatformInputManager.GetAxis("Vertical");
		if (Mathf.Abs(axis) > float.Epsilon || Mathf.Abs(axis2) > float.Epsilon)
		{
			_movementHasInput = true;
			_movementInputVector = new Vector2(axis, axis2);
			_movementInputDirection = _movementInputVector.normalized;
			if (Singleton<BuffManager>.Instance.CanReduceBuffTime && _lastInputDirection != _movementInputDirection)
			{
				if (_lastDirection == Vector2.zero)
				{
					_lastDirection = _movementInputDirection;
				}
				if (Vector2.Angle(_lastDirection, _movementInputDirection) > 120f)
				{
					_lastDirection = _movementInputDirection;
					Singleton<BuffManager>.Instance._reduceCount++;
				}
				_lastInputDirection = _movementInputDirection;
			}
		}
		if (_movementHasInput)
		{
			_movementInputDirection = TransformInputDirectionToWorldDirection(_movementInputDirection);
			int num = (int)(_movementInputDirection.x * 10000f);
			int num2 = (int)(_movementInputDirection.y * 10000f);
			_movementInputDirection = new Vector2((float)num * 0.0001f, (float)num2 * 0.0001f);
		}
		_actionBtnAState = CrossPlatformInputManager.GetButtonState("Fire1");
		_actionBtnBState = CrossPlatformInputManager.GetButtonState("Fire2");
		_actionBtnCState = CrossPlatformInputManager.GetButtonState("Fire3");
		_actionBtnDState = CrossPlatformInputManager.GetButtonState("Fire4");
		_switchActorBtnAState = CrossPlatformInputManager.GetButtonState("ActorSwitch1");
		_switchActorBtnBState = CrossPlatformInputManager.GetButtonState("ActorSwitch2");
		_interactiveBtnState = CrossPlatformInputManager.GetButtonState("Interactive");
		_targetSwitchBtnState = CrossPlatformInputManager.GetButtonState("targetSwitch");
		_switchWithUltraBtnAState = CrossPlatformInputManager.GetButtonState("SwitchWithUltra1");
		_switchWithUltraBtnBState = CrossPlatformInputManager.GetButtonState("SwitchWithUltra2");
		SubmitInputBuffer();
		ClearInput();
	}

	protected Vector2 TransformInputDirectionToWorldDirection(Vector2 inputDirection)
	{
		float num = Vector2.SignedAngle(inputDirection, Vector2.up);
		Vector3 forward = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform.forward;
		Vector2 v = new Vector2(forward.x, forward.z);
		v.Normalize();
		inputDirection = MathMisc.Rotate(v, 0f - num);
		return inputDirection;
	}

	[BlackList]
	public bool GetMouseInputDirection(out TSVector2 mouseDirection)
	{
		mouseDirection = TSVector2.zero;
		return false;
	}

	[BlackList]
	public void InputLogicUpdate()
	{
		PlayerAdventureActor playerAdventureActor = _activedPlayerActor;
		if (playerAdventureActor != null)
		{
			playerAdventureActor.OnMovementInput(_movementHasInputBuffer, TSVector2.zero, _movementInputDirectionBuffer);
		}
		Queue<OperationInfo> val = null;
		while (_operationsBuffer.Count > 0)
		{
			OperationInfo operationInfo = _operationsBuffer.Dequeue();
			MonoSingleton<LuaManager>.Instance.FireEvent("ExecuteRealButton", operationInfo.key.ToString());
			switch (operationInfo.key)
			{
			case ActionKey.SwitchPreActor:
				CastAssistActorSkill(_firstSlotActorId);
				continue;
			case ActionKey.SwitchNextActor:
				CastAssistActorSkill(_secondSlotActorId);
				continue;
			case ActionKey.SwitchNextTarget:
				SwitchTarget();
				continue;
			case ActionKey.SwitchPreWithUltra:
				CastAssistActorUltimate(_firstSlotActorId);
				continue;
			case ActionKey.SwitchNextWithUltra:
				CastAssistActorUltimate(_secondSlotActorId);
				continue;
			case ActionKey.Interactive:
				MonoSingleton<LuaManager>.Instance.FireEvent("InteractiveEnable");
				continue;
			}
			if (val == null)
			{
				val = new Queue<OperationInfo>();
			}
			val.Enqueue(operationInfo);
		}
		if (val != null && val.Count > 0)
		{
			OperationInfo[] array = val.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				DispatchButtonInput(array[i].key, array[i].state);
			}
		}
	}

	protected void SubmitInputBuffer()
	{
		if (_actionBtnAState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "Fire1", (int)_actionBtnAState);
		}
		if (_actionBtnBState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "Fire2", (int)_actionBtnBState);
		}
		if (_actionBtnCState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "Fire3", (int)_actionBtnCState);
		}
		if (_actionBtnDState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "Fire4", (int)_actionBtnDState);
		}
		if (_switchActorBtnAState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "ActorSwitch1", (int)_switchActorBtnAState);
		}
		if (_switchActorBtnBState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "ActorSwitch2", (int)_switchActorBtnBState);
		}
		if (_interactiveBtnState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "Interactive", (int)_interactiveBtnState);
		}
		if (_targetSwitchBtnState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "targetSwitch", (int)_targetSwitchBtnState);
		}
		if (_switchWithUltraBtnAState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "SwitchWithUltra1", (int)_switchWithUltraBtnAState);
		}
		if (_switchWithUltraBtnBState != ButtonState.None)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ButtonStateChange", "SwitchWithUltra2", (int)_switchWithUltraBtnBState);
		}
		if (_switchActorBtnAState == ButtonState.Press && !disableActorSwitch1)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.SwitchPreActor, _switchActorBtnAState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_switchActorBtnBState == ButtonState.Press && !disableActorSwitch2)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.SwitchNextActor, _switchActorBtnBState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_switchWithUltraBtnAState == ButtonState.Press && !disableSwitchWithUltra1)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.SwitchPreWithUltra, _switchWithUltraBtnAState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_switchWithUltraBtnBState == ButtonState.Press && !disableSwitchWithUltra2)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.SwitchNextWithUltra, _switchWithUltraBtnBState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_actionBtnAState != ButtonState.None && !disableFire1)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.A, _actionBtnAState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_actionBtnBState != ButtonState.None && !disableFire2)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.B, _actionBtnBState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_actionBtnCState != ButtonState.None && !disableFire3)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.C, _actionBtnCState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_actionBtnDState != ButtonState.None && !disableFire4)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.D, _actionBtnDState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_interactiveBtnState == ButtonState.Click && !disableInteractive)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.Interactive, _interactiveBtnState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		if (_targetSwitchBtnState == ButtonState.Click && !disableTargetSwitch)
		{
			OperationInfo operationInfo = new OperationInfo(ActionKey.SwitchNextTarget, _targetSwitchBtnState);
			_operationsBuffer.Enqueue(operationInfo);
		}
		_movementHasInputBuffer = _movementHasInput;
		_movementInputDirectionBuffer = _movementInputDirection.ToTSVector2();
	}

	[BlackList]
	public void ClearInputBuffer()
	{
		_operationsBuffer.Clear();
	}

	protected void ClearInput()
	{
		_movementHasInput = false;
		_movementInputDirection = (_movementInputVector = Vector2.zero);
		_actionBtnAState = ButtonState.None;
		_actionBtnBState = ButtonState.None;
		_actionBtnCState = ButtonState.None;
		_actionBtnDState = ButtonState.None;
		_switchActorBtnAState = ButtonState.None;
		_switchActorBtnBState = ButtonState.None;
		_interactiveBtnState = ButtonState.None;
		_targetSwitchBtnState = ButtonState.None;
		_switchWithUltraBtnAState = ButtonState.None;
		_switchWithUltraBtnBState = ButtonState.None;
		CrossPlatformInputManager.ClearButtonState("Fire1");
		CrossPlatformInputManager.ClearButtonState("Fire2");
		CrossPlatformInputManager.ClearButtonState("Fire3");
		CrossPlatformInputManager.ClearButtonState("Fire4");
		CrossPlatformInputManager.ClearButtonState("ActorSwitch1");
		CrossPlatformInputManager.ClearButtonState("ActorSwitch2");
		CrossPlatformInputManager.ClearButtonState("Interactive");
		CrossPlatformInputManager.ClearButtonState("targetSwitch");
		CrossPlatformInputManager.ClearButtonState("SwitchWithUltra1");
		CrossPlatformInputManager.ClearButtonState("SwitchWithUltra2");
	}

	public void CancelInput()
	{
		CancelButtonInput(ref _actionBtnAState);
		CancelButtonInput(ref _actionBtnBState);
		CancelButtonInput(ref _actionBtnCState);
		CancelButtonInput(ref _actionBtnDState);
		SubmitInputBuffer();
	}

	private void CancelButtonInput(ref ButtonState state)
	{
		state = ButtonState.Cancel;
	}

	public void DispatchButtonInput(ActionKey key, ButtonState state, bool isSimulative = false)
	{
		if (state != ButtonState.None)
		{
			AdventureInputActionOperate adventureInputActionOperate = AdventureInputActionOperate.Generate();
			adventureInputActionOperate.sender = this;
			adventureInputActionOperate.key = key;
			adventureInputActionOperate.buttonState = state;
			adventureInputActionOperate.isSimulative = isSimulative;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInputActionOperate);
		}
	}

	[BlackList]
	public TSVector2 GetMovementInputDirection()
	{
		return _movementInputDirectionBuffer;
	}

	[BlackList]
	public FP GetMovementInputAngle()
	{
		FP angle = GetMovementInputDirection().GetAngle();
		return (360f - angle) % 360f;
	}

	[BlackList]
	public bool HasMovementInput()
	{
		return _movementHasInputBuffer;
	}

	[BlackList]
	public TSVector2 GetWorldDirByInput(Vector2 dir)
	{
		Vector2 vector = TransformInputDirectionToWorldDirection(dir);
		int num = (int)(vector.x * 10000f);
		int num2 = (int)(vector.y * 10000f);
		return new TSVector2((float)num * 0.0001f, (float)num2 * 0.0001f);
	}

	public void AutoBattle_InsertNewOperation(ActionKey key, ButtonState state)
	{
	}

	public void EnableThemeManager()
	{
		_themeManagerAI = new AIAdapter();
		if (!_themeManagerAI.Initialize(_themeManagerPath, gameObject))
		{
			_themeManagerAI = null;
		}
		_themeManagerAI?.Start();
	}

	public void DisableThemeManager()
	{
		_themeManagerAI?.Disable();
		_themeManagerAI = null;
	}
}
