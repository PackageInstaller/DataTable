#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using DG.Tweening;
using MagicaCloth;
using Nova.Client;
using Nova.Hotfix;
using Pathfinding;
using TrueSync;
using TrueSync.Physics2D;
using Unity.Mathematics;
using UnityEngine;

[DisallowMultipleComponent]
public class AdventureActor : LogicEntity, IHitBoxContext, IDeterministicCollisionListener, IAnimatorStateTransformationReceiver, IHybridAnimatorHost, IHurtAnimatorHost
{
	public static class AnimationParameterNames
	{
		public static readonly int IsAliveHash = Animator.StringToHash("is_alive");

		public static readonly int MoveSpeedHash = Animator.StringToHash("move_speed");

		public static readonly int MoveSpeedMultiplierHash = Animator.StringToHash("move_speed_multiplier");

		public static readonly int MoveDirectionForward = Animator.StringToHash("move_direction_forward");

		public static readonly int MoveDirectionSide = Animator.StringToHash("move_direction_side");

		public static readonly int IsDashingHash = Animator.StringToHash("is_dashing");

		public static readonly int DashTimeHash = Animator.StringToHash("dash_time");

		public static readonly int IsDodgingHash = Animator.StringToHash("is_dodging");

		public static readonly int DodgeTimeHash = Animator.StringToHash("dodge_time");

		public static readonly int IsJumpingHash = Animator.StringToHash("is_jumping");

		public static readonly int JumpTimeHash = Animator.StringToHash("jump_time");

		public static readonly int IsLostControl = Animator.StringToHash("is_lostcontrol");

		public static readonly int IsLostControlSpecial = Animator.StringToHash("is_lostcontrol_special");

		public static readonly int TriggerLostControl = Animator.StringToHash("tLostControl");

		public static readonly int Hurt = Animator.StringToHash("hurt");

		public static readonly int THurt = Animator.StringToHash("tHurt");

		public static readonly int HurtAniTag = Animator.StringToHash("hurt_ani_tag");

		public static readonly int IsDaze = Animator.StringToHash("is_daze");

		public static readonly int IsAiming = Animator.StringToHash("is_aiming");

		public static readonly int rushCombo = Animator.StringToHash("rushCombo");

		public static readonly int OpenHash = Animator.StringToHash("Open");

		public static readonly int LeaveHash = Animator.StringToHash("leave");

		public static readonly int IsSceneMove = Animator.StringToHash("is_scenemove");
	}

	public static class AnimationStateNames
	{
		public static readonly int IdleStateHash = Animator.StringToHash("Idle");

		public static readonly int WalkStateHash = Animator.StringToHash("Walk");

		public static readonly int RunStateHash = Animator.StringToHash("Run");

		public static readonly int DashStateHash = Animator.StringToHash("Dash");

		public static readonly int DodgeStateHash = Animator.StringToHash("Dodge");

		public static readonly int JumpStateHash = Animator.StringToHash("Jump");

		public static readonly int DeathStateHash = Animator.StringToHash("Death");

		public static readonly int HurtStateHash = Animator.StringToHash("Hurt");

		public static readonly int DazeStateHash = Animator.StringToHash("Daze");

		public static readonly int LeaveStateHash = Animator.StringToHash("Leave");

		public static readonly int SceneMoveStateHash = Animator.StringToHash("SceneMove");
	}

	public enum MovementMode
	{
		[InspectorName("跑步")]
		Run,
		[InspectorName("移动")]
		Walk,
		[InspectorName("未设置")]
		None
	}

	public enum AimMode
	{
		[InspectorName("不瞄准 (默认)")]
		Forward,
		[InspectorName("方向锁定在固定朝向")]
		LockDirection,
		[InspectorName("方向锁定在攻击目标")]
		AimAtAttackTarget
	}

	public enum MoveType
	{
		UpdataType,
		DisTanceType,
		Normal,
		KnockBack,
		Pull
	}

	public enum ForceType
	{
		Constant_Speed,
		Uniform_Acceleration,
		Uniform_Deceleration
	}

	public class MoveFeatureData
	{
		public MoveType moveType;

		public ForceType forceType;

		public FP moveSpeed = 10f;

		public FP moveDistance = 1f;

		public TSVector2 moveDirection;

		public bool isCoexist;

		public bool changeForward;

		public int moveLevel;

		public FP leftTime;

		public FP strength;

		public bool waitList;

		public AdventureActor _owner;

		public Action callback;

		public MoveFeatureData()
		{
			InitData();
		}

		public void InitData()
		{
			moveLevel = 0;
			moveSpeed = 0f;
			moveDistance = 0f;
			moveDirection = TSVector2.zero;
			isCoexist = true;
			changeForward = true;
			leftTime = -1f;
			strength = 1f;
			moveType = MoveType.Normal;
			waitList = false;
			callback = null;
		}

		public void ToStop()
		{
			if (!(leftTime < 0))
			{
				if (_owner.currentMoveFeatureDataLs.Contains(this))
				{
					_owner.currentMoveFeatureDataLs.Remove(this);
					_owner.RefreshCurrentMoveDatas(force: true);
					SceneSingleton<ActorGroupManager>.Instance.PushMoveFData(this);
				}
				else if (_owner.newMoveFeatureDatas.Contains(this))
				{
					_owner.newMoveFeatureDatas.Remove(this);
					_owner.RefreshCurrentMoveDatas(force: true);
					SceneSingleton<ActorGroupManager>.Instance.PushMoveFData(this);
				}
			}
		}

		public void OnStart(AdventureActor _adv)
		{
			_owner = _adv;
			leftTime = moveDistance / moveSpeed;
			if (forceType == ForceType.Uniform_Deceleration && !_owner.isAirBorne)
			{
				leftTime *= (FP)2;
			}
			_owner.AddToMoveDatas(this);
		}

		public void OnEnd()
		{
			callback?.Invoke();
			_owner = null;
			leftTime = -1;
		}
	}

	public delegate void ShowChangedHandle(bool show);

	public const string ActorSpawnBehaviourVariableName = "spawnBehaviour";

	public const string ActorIdleBehaviourVariableName = "idleBehaviour";

	public const string ActorActionBehaviourVariableName = "actionBehaviour";

	public const string ActorLostControlBehaviourVariableName = "lostControlBehaviour";

	public const string ActorDeathBehaviourVariableName = "deathBehaviour";

	public const string ActorConcurrentBehaviourVariableName = "concurrentBehaviour";

	protected readonly List<DeterministicRaycastHit> _tempDeterministicRaycastHits = new List<DeterministicRaycastHit>();

	public readonly AttributeList attributeList = new AttributeList();

	public readonly SpecialAttributeList specialAttributeList = new SpecialAttributeList();

	public readonly StateAttributeList stateAttributeList = new StateAttributeList();

	[Space]
	public ActorInfo actorInfo;

	[Space]
	public ActorElementInfo actorElementInfo;

	[Space]
	public ActorHealthInfo actorHealthInfo;

	[Space]
	public ActorScaleInfo actorScaleInfo;

	[Space]
	public ActorSearchTarget actorSearchTargetInfo;

	[Space]
	public ShootBehaviour shootBehaviour;

	[Space]
	public AmmoInfo ammoInfo;

	[Space]
	public ActorSkillManage actorSkillManage;

	[Space]
	public ActorEffectManage effectManage;

	[Space]
	public BuffCom buffComponent;

	[Space]
	public DeterministicMovementAgent movAgent;

	[Space]
	public Animator animator;

	[Space]
	public AnimationSlotConfigComponent slotConfig;

	[Space]
	public AnimatorReactionBinder animatorReactionBinder;

	[Space]
	public ComboGroup comboGroup;

	[Space]
	public AdventureSelfFXHandler selfFXHandler;

	[HideInInspector]
	public Collider collider;

	[Space]
	public LogicVariable logicVariable;

	[Space]
	protected VisualSmooth _smooth;

	[Space]
	public ActorShield actorShield;

	public FP strengthOverride = -1;

	[Space]
	public bool isSyncActived;

	[Space]
	public string GroupId;

	[Space]
	[ReadOnly]
	private bool _logicPaused;

	private List<LogicEntity> _enterColliderEntities = new List<LogicEntity>();

	protected RuntimeAnimatorController _originRuntimeAnimatorController;

	protected int _animationPauseRC;

	public bool useSpecialLostControlClip;

	public float specialLostControlStartClipLen;

	public float specialLostControlEndClipLen;

	protected Tween _nrootShakeTween;

	protected Vector2 _nrootShakeShifting = Vector2.zero;

	protected float[] _originDynamicBonesBlendWeight;

	protected Coroutine[] _dynamicBonesBlendFadeCoroutines;

	private const string _lostControlStartClipDefaultName = "Special_Lostcontrol_Start_Anim";

	private const string _lostControlEndClipDefaultName = "Special_Lostcontrol_End_Anim";

	internal ActorAttackFSM _attackFSM;

	internal readonly ComboInputBuffer _comboInputBuffer = new ComboInputBuffer(-1f, 10);

	internal string _actionTag;

	internal int lastComboPhaseSwitchFrameCount = -1;

	internal ComboAttack activeComboAttack;

	protected readonly Dictionary<long, FP> _monsterWeaponHitedActors = new Dictionary<long, FP>(5);

	public bool enableChangeCurrentAttackTarget;

	protected LogicEntity _attackTarget;

	public bool isChangeAimLockedTargetWhenCurrentAttackTargetInValid;

	protected TSVector2 _lastAttackTargetDeterministicPosition;

	public long monsterTargetId;

	private LogicEntity _monsterTarget;

	private LogicEntity _soldierAttackTarget;

	internal bool comboTriggerExitTime;

	internal Action<AdventureActor, Combo.Event> _onAttackCustomEvent;

	internal Action<AdventureActor> _onAttackInterrupted;

	internal Action<AdventureActor, Combo.Phase> _onBeforeAttackComboPhaseChange;

	internal Action<AdventureActor, Combo.Phase> _onAfterAttackComboPhaseChange;

	internal Action<AdventureActor, int, Combo.FeaturePhase> _onFeaturePhaseActive;

	internal Action<AdventureActor> _onAttackComboLoop;

	internal Action<AdventureActor> OnSendSkillTakeEffect;

	internal Action<AdventureActor, bool> _onSendSkillAllowOtherSkillExecute;

	protected Dictionary<long, FP> _hitedActors = new Dictionary<long, FP>(5);

	private Action OnDeadImmunityHandle;

	public Func<HotfixEnum.stateAttributeType, bool> OnBuffHandle;

	public Func<HotfixEnum.stateAttributeType, bool> OnDamageHandle;

	public Func<HotfixEnum.stateAttributeType, bool> OnBeHitHandle;

	public Func<HotfixEnum.stateAttributeType, bool> OnSpecialControlHandle;

	public Func<HotfixEnum.stateAttributeType, bool> OnStrongControlHandle;

	public Func<HotfixEnum.stateAttributeType, bool> OnWeekControlHandle;

	public bool onHurtEffectCD;

	private AkAnimatorAudio _akAudio;

	public bool onHurtAudioCD;

	[Space]
	public string specialHurtFx;

	private bool isEnterLostCtr;

	private LostControlType lastCtrType;

	private LostControlType curCtrType;

	private List<int> immuneCertainDamageIds = new List<int>();

	public static int simplePlayerTag = CommonHelper.StringToHash("SimplePlayer");

	private static LogicEntity fromEntityTemp;

	private static AdventureWeapon fromWeaponTemp;

	private static AreaEffectEntity fromAreaTemp;

	private static AdventureActor fromActorTemp;

	private static AdventureActor toActor;

	public static readonly ActorAdditionalAttrInfo fromAdditionalAttrInfo = new ActorAdditionalAttrInfo();

	public static readonly ActorAdditionalAttrInfo toAdditionalAttrInfo = new ActorAdditionalAttrInfo();

	private static HashSet<HotfixEnum.elementType> toWeakElementTemp;

	private static HotfixEnum.elementType toElementTypeTemp;

	private static GameObject hurtEffectPrefabTemp;

	private static HitBox hitboxTemp;

	private static bool isHittedEffectScaleTemp;

	private static int uniqueAttackIdTemp;

	private static DamageType damageTypeTemp;

	private static int onceAttackTargetCountTemp;

	private static int hitDamageIdTemp;

	private static HitDamage hitDamageConfigTemp;

	private static int skillLevelTemp;

	private static bool showHudTemp;

	private static long areaEffectIdTemp;

	private static bool effectIgnoreTimeScaleTemp;

	private static FP knockBackDistancePercentTemp;

	private static int hudColorIndexTemp;

	private static bool isPlayShakeAnim;

	private Recorder.Types.Damage dmgData;

	private static Dictionary<int, int> fromAdditionalAttrDict = new Dictionary<int, int>();

	private static Dictionary<int, int> toAdditionalAttrDict = new Dictionary<int, int>();

	private static FP addEnergyForMainControlTemp;

	private List<CoroutineNode> movableFCoroutineNodes;

	private List<AdventureFXPlayer> playFxs;

	private EventDispatcher _dispatcher;

	public ActorMovementFSM _movementFSM;

	private FP _currentRotateSpeed;

	private FP targetRotation;

	private FP currentRotTime;

	private FP rotationDuration;

	private TSVector2 _velocityDirection;

	[Space]
	public bool forbiddenBehitRot;

	public bool haveExternalForce;

	protected MovementMode _movementMode = MovementMode.None;

	public bool specialDodgeMode;

	private bool _crossObstacleMode;

	public FP crossObstacleModeSpeedMultiply = 1;

	private List<DeterministicCollider> _checkTargetList_PerfectDodge;

	private List<DeterministicCollider> _checkHitList_PerfectDodge;

	protected CoroutineNode _rotateCoroutine;

	private Action _onClear;

	[HideInInspector]
	public bool isRotate;

	[HideInInspector]
	public bool isRotateCloseTarget;

	[Space]
	public bool aimWithStartAnim;

	protected AimMode _aimMode;

	private int curAimIndex = -1;

	public TSVector2 targetDir;

	[Space]
	public FP aimAngleLimit;

	protected NNConstraint _reachableConstraint = NNConstraint.Default;

	private FP _speedTransitionTimer = 0;

	private CoroutineNode speedTransition;

	[Space]
	protected FP _accelerationScaleValue = FP.One;

	[Space]
	protected FP _rotationSpeedScaleValue = FP.One;

	protected int _movementAgentPauseRC;

	protected int _movementAvoidancePauseRC;

	protected int _movementAvoidanceLockRC;

	protected int _movementBlockPauseRC;

	protected FP _orginMovementBlockPriority;

	protected int _lostControlRC;

	[Space]
	public bool InPerfectDodge;

	private int _deadImmunityRC;

	private int _forceControlRC;

	private int _disableMoveRC;

	private int _disableMoveAgentCanMoveRC;

	private int _disableRotateRC;

	private int _disableCastDodgeRC;

	private int _disableCastNormalRC;

	private int _disableCastSkillRC;

	private int _disableCastUltraRC;

	private int _hideMonsterHpAndAttackHintRC;

	private FP _stiffDuration;

	public bool isStiff;

	protected CoroutineNode _knockbackCoroutine;

	protected TSVector2 _knockBackDirection;

	protected FP _knockBackSpeed;

	protected FP _knockBackAcceleration;

	protected CoroutineNode _airBorneCoroutine;

	protected FP _airBorneSpeed;

	protected FP _actorOriginalPositionY;

	private readonly Dictionary<StateEnum, AdventureBuffFXHandler> dicBuffFx = new Dictionary<StateEnum, AdventureBuffFXHandler>();

	private Action _scnenMoveInterruptCallBack;

	private CoroutineNode _sceneMoveCor;

	protected AdventureTimeControlHandler _witchtimeTimeControlHandler;

	protected AdventureActor _witchtimeAttackTarget;

	protected readonly List<MoveFeatureData> currentMoveFeatureDataLs = new List<MoveFeatureData>(5);

	protected readonly List<MoveFeatureData> newMoveFeatureDatas = new List<MoveFeatureData>(5);

	protected MoveFeatureData currentMoveData;

	protected FP moveDuration = 0;

	protected int framIndex;

	protected FP acceleration = 0;

	public static readonly List<HotfixEnum.stateAttributeType> strongControlStatusEffects = new List<HotfixEnum.stateAttributeType>
	{
		HotfixEnum.stateAttributeType.STUN,
		HotfixEnum.stateAttributeType.STUN_WEAKENED,
		HotfixEnum.stateAttributeType.FROZEN,
		HotfixEnum.stateAttributeType.FROZEN_WEAKENED,
		HotfixEnum.stateAttributeType.SLEEP,
		HotfixEnum.stateAttributeType.SLEEP_WEAKENED,
		HotfixEnum.stateAttributeType.CHARM,
		HotfixEnum.stateAttributeType.CHARM_WEAKENED,
		HotfixEnum.stateAttributeType.TERROR,
		HotfixEnum.stateAttributeType.TERROR_WEAKENED
	};

	private FP _enterStunTime;

	private bool _isStunSpecialLostControlFinish;

	private CoroutineNode _stunSpecialLostControlNode;

	private FP currentDuration;

	private FP totalDuration = FP.Zero;

	private CoroutineNode _charmMoveCoroutine;

	private TSVector2 _charmDir;

	private AdventureActor _from;

	private long _fromId;

	private CoroutineNode _terrorMoveCoroutine;

	private TSVector2 _terrorDir;

	private FP _enterToughnessBrokenTime;

	private bool _isToughnessBrokenSpecialLostControlFinish;

	private CoroutineNode _toughnessBrokenSpecialLostControlNode;

	public static readonly List<HotfixEnum.stateAttributeType> weakControlStatusEffects = new List<HotfixEnum.stateAttributeType>
	{
		HotfixEnum.stateAttributeType.TAUNT,
		HotfixEnum.stateAttributeType.TAUNT_WEAKENED,
		HotfixEnum.stateAttributeType.BONDAGE,
		HotfixEnum.stateAttributeType.BONDAGE_WEAKENED,
		HotfixEnum.stateAttributeType.SILENCE,
		HotfixEnum.stateAttributeType.SILENCE_WEAKENED,
		HotfixEnum.stateAttributeType.CHAOS,
		HotfixEnum.stateAttributeType.CHAOS_WEAKENED,
		HotfixEnum.stateAttributeType.BLINDNESS,
		HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED,
		HotfixEnum.stateAttributeType.REDUCE_FOV
	};

	[NonSerialized]
	public AdventureActor tauntFromActor;

	private DeterministicShape _shape;

	private TSVector2 randomPos;

	private CoroutineNode _randomMoveCoroutine;

	private bool complete;

	private int waitC;

	protected ActorState _state;

	private bool _inDying;

	protected ActorPrimeFSM _primeFSM;

	protected ActorNullState _nullState;

	protected ActorSpawnState _spawnState;

	protected ActorIdleState _idleState;

	protected ActorActionState _actionState;

	protected ActorLostControlState _lostControlState;

	protected ActorDeathState _deathState;

	protected ActorClearState _clearState;

	internal string _actionAIPath = "AIScript.Monster.Template.Action";

	internal string _spawnAIPath = "AIScript.Monster.Template.Spawn";

	internal string _idleAIPath = "AIScript.Monster.Template.Idle";

	internal string _lostcontrolAIPath = "";

	internal string _deathAIPath = "AIScript.Monster.Template.Death";

	internal string _parallelAIPath = "AIScript.Monster.Template.Parallel";

	internal string _clearAIPath = "";

	internal string _trapActionAIPath = "AIScript.Monster.Trap.Action";

	internal string _trapSpawnAIPath = "AIScript.Monster.Trap.Spawn";

	internal string _trapIdleAIPath = "AIScript.Monster.Trap.Idle";

	internal string _trapLostcontrolAIPath = "";

	internal string _trapDeathAIPath = "";

	internal string _trapParallelAIPath = "AIScript.Monster.Trap.Parallel";

	internal string _trapClearAIPath = "";

	public string _comboGroupPath;

	protected AIAdapter _parallelAI;

	protected CoroutineNode _bornCoroutine;

	protected CoroutineNode _spwanShowCoroutine;

	protected bool _makeThreatAlert = true;

	protected ActorState _makeThreatAlertPrevState;

	[Space]
	public LogicEntity killer;

	[Space]
	protected IList<int> _damageTag;

	[Space]
	public HitBox killerHitBox;

	[Space]
	protected int _uniqueAttackId;

	[Space]
	protected DeadType _deadType;

	private readonly Dictionary<int, int> tags = new Dictionary<int, int>();

	private readonly Dictionary<int, List<int>> elementMarkTags = new Dictionary<int, List<int>>();

	protected Dictionary<int, FP> _hitImmunitys = new Dictionary<int, FP>(10);

	public bool _hitIdImmuneTriggered;

	private bool _hitIdImmuneSeenNonImmune;

	private int _hideRC;

	private int _transparentRC;

	private float _transparencyFrom;

	private float _transparencyTo;

	private int _transparentFadeMaterialID;

	private Coroutine _transparentFadeCoroutine;

	private Coroutine _transparentFadeSwichActorCoroutine;

	protected int _hurtAnimToggleRC;

	protected int _checkBrokenLineBulletRC;

	[Space]
	public FP checkBrokenLineBulletRadius;

	private List<AdventureRotateWeapon> wepons;

	private FP fixedWeaponTime;

	private bool iFixWeaponDuration;

	public DeterministicCollider dtCollider { get; protected set; }

	public int dataID { get; set; }

	public string attrID { get; set; }

	public int attrTempleteID { get; set; }

	public int skinID { get; set; }

	public int rowOfScene { get; set; } = -1;

	public int columnOfScene { get; set; } = -1;

	public bool logicInitialized { get; protected set; }

	public virtual bool UseInheritElementOnHit => false;

	public bool ignoreDeterministicCollision
	{
		get
		{
			if (!(dtCollider == null) && actorHealthInfo.isAlive)
			{
				return dtCollider.IgnoreCollision;
			}
			return true;
		}
		set
		{
			dtCollider.IgnoreCollision = value;
		}
	}

	public HybirdAnimatorController animatorController { get; protected set; }

	public RuntimeAnimatorController currentRuntimeAnimatorController { get; protected set; }

	public bool isAnimationPaused => _animationPauseRC > 0;

	public bool rootBoneRotationLocked
	{
		get
		{
			if (animatorController != null)
			{
				return animatorController.rootBoneRotationLocked;
			}
			return false;
		}
		set
		{
			if (animatorController != null)
			{
				animatorController.rootBoneRotationLocked = value;
			}
		}
	}

	public BaseCloth[] dynamicBones { get; protected set; }

	public ActorAttackFSM attackFSM => _attackFSM;

	public LogicEntity attackTarget
	{
		get
		{
			if (_attackTarget == null)
			{
				return null;
			}
			if (!_attackTarget.IsSearchedImmunity())
			{
				return _attackTarget;
			}
			return null;
		}
		set
		{
			_attackTarget = value;
		}
	}

	public LogicEntity currentAttackTarget { get; set; }

	public LogicEntity aimLockedTarget
	{
		get
		{
			if (currentAttackTarget == null)
			{
				return attackTarget;
			}
			if (!currentAttackTarget.IsSearchedImmunity() && ((AdventureActor)currentAttackTarget).actorHealthInfo.isAlive)
			{
				return currentAttackTarget;
			}
			if (!isChangeAimLockedTargetWhenCurrentAttackTargetInValid)
			{
				return null;
			}
			return attackTarget;
		}
	}

	public TSVector2 lastAttackTargetDeterministicPosition
	{
		get
		{
			return _lastAttackTargetDeterministicPosition;
		}
		internal set
		{
			_lastAttackTargetDeterministicPosition = value;
		}
	}

	public LogicEntity monsterTarget
	{
		get
		{
			return _monsterTarget;
		}
		set
		{
			_monsterTarget = value;
			monsterTargetId = ((_monsterTarget != null) ? _monsterTarget.Id : 0);
		}
	}

	public LogicEntity soldierAttackTarget
	{
		get
		{
			return _soldierAttackTarget;
		}
		set
		{
			_soldierAttackTarget = value;
		}
	}

	public ActorState attackState
	{
		get
		{
			if (_attackFSM == null)
			{
				return ActorState.Null;
			}
			return (ActorState)_attackFSM.GetCurStateID();
		}
	}

	public Combo.Phase attackComboPhase => attackState switch
	{
		ActorState.AttackAnticipation => Combo.Phase.Anticipation, 
		ActorState.AttackActivation => Combo.Phase.Activation, 
		ActorState.AttackRecovery => Combo.Phase.Recovery, 
		_ => Combo.Phase.None, 
	};

	public bool isPlayingAttackCombo
	{
		get
		{
			ActorState actorState = attackState;
			return actorState == ActorState.AttackAnticipation || actorState == ActorState.AttackActivation || actorState == ActorState.AttackRecovery;
		}
	}

	public bool isComboCurStateEnd => _attackFSM?.IsComboCurStateEnd() ?? false;

	public bool isPlayingLoopCombo => _attackFSM?.isPlayingLoopCombo ?? false;

	public Combo playingCombo => _attackFSM?.currentCombo;

	public ComboClip playingComboClip => _attackFSM?.currentComboClip;

	public bool canExit
	{
		get
		{
			if (playingCombo == null)
			{
				return true;
			}
			if (playingCombo.comboSkillType == ComboSkillType.Ultimate)
			{
				return false;
			}
			if (playingCombo.useExitTime)
			{
				return comboTriggerExitTime;
			}
			return attackState == ActorState.AttackRecovery;
		}
	}

	public Action<AdventureActor, Combo.Event> onAttackCustomEvent
	{
		get
		{
			return _onAttackCustomEvent;
		}
		set
		{
			_onAttackCustomEvent = value;
		}
	}

	public Action<AdventureActor> onAttackInterrupted
	{
		get
		{
			return _onAttackInterrupted;
		}
		set
		{
			_onAttackInterrupted = value;
		}
	}

	public Action<AdventureActor, Combo.Phase> onBeforeAttackComboPhaseChange
	{
		get
		{
			return _onBeforeAttackComboPhaseChange;
		}
		set
		{
			_onBeforeAttackComboPhaseChange = value;
		}
	}

	public Action<AdventureActor, Combo.Phase> onAfterAttackComboPhaseChange
	{
		get
		{
			return _onAfterAttackComboPhaseChange;
		}
		set
		{
			_onAfterAttackComboPhaseChange = value;
		}
	}

	public Action<AdventureActor, int, Combo.FeaturePhase> onFeaturePhaseActive
	{
		get
		{
			return _onFeaturePhaseActive;
		}
		set
		{
			_onFeaturePhaseActive = value;
		}
	}

	public Action<AdventureActor> onAttackComboLoop
	{
		get
		{
			return _onAttackComboLoop;
		}
		set
		{
			_onAttackComboLoop = value;
		}
	}

	public Action<AdventureActor> onSendSkillTakeEffect
	{
		get
		{
			return OnSendSkillTakeEffect;
		}
		set
		{
			OnSendSkillTakeEffect = value;
		}
	}

	public Action<AdventureActor, bool> onSendSkillAllowOtherSkillExecute
	{
		get
		{
			return _onSendSkillAllowOtherSkillExecute;
		}
		set
		{
			_onSendSkillAllowOtherSkillExecute = value;
		}
	}

	public HitBox hitBox { get; protected set; }

	public AdventureActor lastAttackMonster { get; private set; }

	IReadOnlyList<RuntimeAnimatorController> IHybridAnimatorHost.OverrideRuntimeAnimatorControllers
	{
		get
		{
			if (!(comboGroup != null))
			{
				return null;
			}
			return comboGroup.replaceRuntimeAnimatorController;
		}
	}

	public ActorMovementFSM movementFSM => _movementFSM;

	public FP velocitySpeed { get; set; }

	public FP currentRotateSpeed
	{
		get
		{
			if (!(aimAngleLimit > 0))
			{
				return _currentRotateSpeed;
			}
			return aimAngleLimit;
		}
	}

	public TSVector2 velocityDirection
	{
		get
		{
			return _velocityDirection;
		}
		set
		{
			_velocityDirection = value;
			if (value != TSVector2.zero)
			{
				forceChangeDirection = TSVector2.zero;
			}
		}
	}

	public TSVector2 forceChangeDirection { get; set; }

	public TSVector2 velocity => velocityDirection * velocitySpeed;

	public TSVector2 externalForce { get; set; }

	public ActorState movementState
	{
		get
		{
			if (_movementFSM == null)
			{
				return ActorState.Null;
			}
			return (ActorState)_movementFSM.GetCurStateID();
		}
	}

	public int movementLevel
	{
		get
		{
			switch (movementState)
			{
			case ActorState.StandBy:
				return -1;
			case ActorState.Move:
				return 20;
			case ActorState.Jump:
				return 99;
			case ActorState.Dash:
				return 30;
			case ActorState.Dodge:
				return 30;
			case ActorState.Null:
			case ActorState.Spawn:
			case ActorState.Idle:
			case ActorState.Action:
			case ActorState.LostControl:
			case ActorState.Death:
			case ActorState.Clear:
			case ActorState.NonAttack:
			case ActorState.AttackAnticipation:
			case ActorState.AttackActivation:
			case ActorState.AttackRecovery:
			case ActorState.AttackReload:
				return 0;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
	}

	public MovementMode movementMode
	{
		get
		{
			return _movementMode;
		}
		set
		{
			if (_movementMode != value)
			{
				MovementMode movementMode = _movementMode;
				_movementMode = value;
				RefreshMovementSpeed(movementMode == MovementMode.None);
			}
		}
	}

	public bool crossObstacleMode
	{
		get
		{
			return _crossObstacleMode;
		}
		set
		{
			_crossObstacleMode = value;
			if (!_crossObstacleMode)
			{
				crossObstacleModeSpeedMultiply = 1;
				SyncMovementLocation();
			}
		}
	}

	public bool isRotating
	{
		get
		{
			CoroutineNode rotateCoroutine = _rotateCoroutine;
			if (rotateCoroutine != null)
			{
				return !rotateCoroutine.finished;
			}
			return false;
		}
	}

	public AimMode aimMode
	{
		get
		{
			return _aimMode;
		}
		internal set
		{
			_aimMode = value;
		}
	}

	public ComboClip curAimCombo
	{
		get
		{
			if (curAimIndex != -1)
			{
				ComboGroup comboGroup = this.comboGroup;
				if ((object)comboGroup == null)
				{
					return null;
				}
				return comboGroup.aimAnimClip_other[curAimIndex];
			}
			return this.comboGroup?.aimAnimClip;
		}
	}

	public bool movementAgentEnabled { get; protected set; }

	public bool movementAgentPaused => _movementAgentPauseRC > 0;

	public bool movementAvoidancePaused => _movementAvoidancePauseRC > 0;

	public bool movementAvoidanceLocked => _movementAvoidanceLockRC > 0;

	public bool movementBlockPaused => _movementBlockPauseRC > 0;

	public bool isControllable => !isLostControl;

	public bool isLostControl => _lostControlRC > 0;

	public bool isJump => movementState == ActorState.Jump;

	public bool damageImmunity => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.DAMAGE_IMM);

	public bool isInteractive { get; private set; }

	public bool cureImmunity => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.CURE_IMM);

	public bool canPerfectDodge { get; set; }

	public bool forbiddenPerfectDodge { get; set; }

	private FP prefectDodgeTimeScale => AdventureModuleController.Config.PrefectDodge_TimeScale;

	private FP prefectDodgeTimeDuration => AdventureModuleController.Config.PrefectDodge_TimeDuration;

	public bool isDeadImmunity => _deadImmunityRC > 0;

	public bool isHpLocked { get; private set; }

	public long lockedHp { get; private set; }

	public bool killImmunity => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.IMMUNE_KILL);

	public bool dodgeCrossObstacle => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.DODGE_CROSS_OBSTACLE);

	public bool forbiddenRush => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.FORBIDDEN_RUSH);

	public bool forceControl => _forceControlRC > 0;

	public bool disableMove => _disableMoveRC > 0;

	public bool disableMoveAgentCanMove => _disableMoveAgentCanMoveRC > 0;

	public bool disableRotate => _disableRotateRC > 0;

	public bool disableCastDodge => _disableCastDodgeRC > 0;

	public bool disableCastNormal => _disableCastNormalRC > 0;

	public bool disableCastSkill => _disableCastSkillRC > 0;

	public bool disableCastUltra => _disableCastUltraRC > 0;

	public bool hideMonsterHpAndAttackHintRC => _hideMonsterHpAndAttackHintRC > 0;

	public bool isKnockBack
	{
		get
		{
			for (int i = 0; i < currentMoveFeatureDataLs.Count; i++)
			{
				if (currentMoveFeatureDataLs.get_Item(i).moveType == MoveType.KnockBack)
				{
					return true;
				}
			}
			for (int j = 0; j < newMoveFeatureDatas.Count; j++)
			{
				if (newMoveFeatureDatas.get_Item(j).moveType == MoveType.KnockBack)
				{
					return true;
				}
			}
			return false;
		}
	}

	public bool isAirBorne => _airBorneCoroutine != null;

	public bool IsNotBlockBullet
	{
		get
		{
			if (!isCloseBlock && !isHideModel && !isSneak && !isHideOut)
			{
				return isPenetrate;
			}
			return true;
		}
	}

	public bool IsCanNotBeHit
	{
		get
		{
			if (!isBattleOut && !isInvincible && !isUnparalleled && !isHideOut)
			{
				return isPenetrate;
			}
			return true;
		}
	}

	public bool IsCanNotAddBuff => isBattleOut;

	public bool IsCanNotAddDeBuff
	{
		get
		{
			if (!isBattleOut && !isInvincible && !isUnparalleled && !isHideOut)
			{
				return isDodge;
			}
			return true;
		}
	}

	public bool beSuperArmor => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SUA);

	public bool beDyingSuperArmor => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.DYINGSUA);

	public bool isImmuneControl => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.IMMUNE_CONTROL);

	public bool isInvincible => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.INVINCIBLE);

	public bool isSceneMove => _sceneMoveCor != null;

	public bool searchedImmunity => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SEARCHED_IMMUNITY);

	public bool isCloseBlock => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.CLOSE_MOVE_BLOCK);

	public bool isHideModel => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.HIDE_MODEL);

	public bool isSneak => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SNEAK);

	public bool isHideOut => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.HIDE_OUT);

	public bool isBattleOut => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.BATTLE_OUT);

	public bool isWitchTimeOwner { get; protected set; }

	public bool isWitchTimeAttacker { get; protected set; }

	public bool isPenetrate => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.PENETRATE);

	public bool isUnparalleled => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.UNPARALLELED);

	public bool isDodge => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.DODGE);

	public bool isInDefense => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.INDEFENSE);

	public bool isPull
	{
		get
		{
			for (int i = 0; i < currentMoveFeatureDataLs.Count; i++)
			{
				if (currentMoveFeatureDataLs.get_Item(i).moveType == MoveType.Pull)
				{
					return true;
				}
			}
			for (int j = 0; j < newMoveFeatureDatas.Count; j++)
			{
				if (newMoveFeatureDatas.get_Item(j).moveType == MoveType.Pull)
				{
					return true;
				}
			}
			return false;
		}
	}

	public bool isForceMove
	{
		get
		{
			for (int i = 0; i < currentMoveFeatureDataLs.Count; i++)
			{
				if (currentMoveFeatureDataLs.get_Item(i).moveType == MoveType.Normal)
				{
					return true;
				}
			}
			for (int j = 0; j < newMoveFeatureDatas.Count; j++)
			{
				if (newMoveFeatureDatas.get_Item(j).moveType == MoveType.Normal)
				{
					return true;
				}
			}
			return false;
		}
	}

	public bool iExMove => currentMoveFeatureDataLs.Count > 0;

	public bool isStun
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.STUN))
			{
				return isStunWeakened;
			}
			return true;
		}
	}

	public bool isStrongStun => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.STUN);

	public bool isStunWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.STUN_WEAKENED);

	public bool isFrozen
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.FROZEN))
			{
				return isFrozenWeakened;
			}
			return true;
		}
	}

	public bool isFrozenWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.FROZEN_WEAKENED);

	public bool isSleep
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SLEEP))
			{
				return isSleepWeakened;
			}
			return true;
		}
	}

	public bool isSleepWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SLEEP_WEAKENED);

	public bool isCharm
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.CHARM))
			{
				return isCharmWeakened;
			}
			return true;
		}
	}

	public bool isCharmWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.CHARM_WEAKENED);

	public bool isTerror
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.TERROR))
			{
				return isTerrorWeakened;
			}
			return true;
		}
	}

	private bool isImmobilizedByHardControl
	{
		get
		{
			if (!isStun && !isToughnessBrokenState && !isFrozen)
			{
				return isSleep;
			}
			return true;
		}
	}

	public bool isTerrorWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.TERROR_WEAKENED);

	public bool isToughnessBrokenState => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.TOUGHNESS_BORKEN);

	public bool isTaunt
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.TAUNT))
			{
				return isTauntWeakened;
			}
			return true;
		}
	}

	public bool isTauntWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.TAUNT_WEAKENED);

	public bool isBondage
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.BONDAGE))
			{
				return isBondageWeakened;
			}
			return true;
		}
	}

	public bool isBondageWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.BONDAGE_WEAKENED);

	public bool isSilence
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SILENCE))
			{
				return isSilenceWeakened;
			}
			return true;
		}
	}

	public bool isSilenceWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.SILENCE_WEAKENED);

	public bool inChaos
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.CHAOS))
			{
				return inChaosWeakened;
			}
			return true;
		}
	}

	public bool inChaosWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.CHAOS_WEAKENED);

	public bool isBlindness
	{
		get
		{
			if (!stateAttributeList.IsActived(HotfixEnum.stateAttributeType.BLINDNESS))
			{
				return isBlindnessWeakened;
			}
			return true;
		}
	}

	public bool isBlindnessWeakened => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED);

	public bool isReduceFOV => stateAttributeList.IsActived(HotfixEnum.stateAttributeType.REDUCE_FOV);

	public ActorState state => _state;

	public bool inDying
	{
		get
		{
			return _inDying;
		}
		set
		{
			_inDying = value;
			DyingStateChanged?.Invoke(_inDying);
		}
	}

	public bool isBorn { get; internal set; }

	public bool isDead { get; set; }

	public bool isDeclareDead { get; set; }

	public InGameActorVisualControlComponent visualControl { get; protected set; }

	protected RendererMaterialStackComponent materialController
	{
		get
		{
			if (!(visualControl != null))
			{
				return null;
			}
			return visualControl.materialController;
		}
	}

	protected CustomModelMaterialVariantComponent modelMaterialVariantController
	{
		get
		{
			if (!(visualControl != null))
			{
				return null;
			}
			return visualControl.modelMaterialVariantController;
		}
	}

	public bool isHide => _hideRC > 0;

	public bool isTransparent => _transparentRC > 0;

	public float currentTransparency { get; private set; }

	public bool isHurtAnimOff => _hurtAnimToggleRC > 0;

	public bool checkBrokenLineBullet => _checkBrokenLineBulletRC > 0;

	public List<AdventureWeapon> equipedWeapons { get; protected set; } = new List<AdventureWeapon>(5);

	public event Action<bool> DyingStateChanged;

	public event ShowChangedHandle ShowChangedEvent;

	protected void SetupComponents()
	{
		gameObject.AddComponent<Seeker>();
		movAgent = gameObject.AddComponent<DeterministicMovementAgent>();
		movAgent.enabled = false;
		animator = gameObject.GetComponent<Animator>();
		if (animator != null)
		{
			animator.applyRootMotion = false;
			animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
		}
		slotConfig = gameObject.GetComponent<AnimationSlotConfigComponent>();
		animatorReactionBinder = gameObject.GetComponent<AnimatorReactionBinder>();
		selfFXHandler = gameObject.GetComponent<AdventureSelfFXHandler>();
	}

	protected override void OnInit()
	{
		_dispatcher = new EventDispatcher();
		attributeList.Init(this is PlayerAdventureActor);
		attributeList.ValueChangedEvent += OnAttributeListValueChange;
		DeterministicCollider deterministicCollider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		if (dtCollider != null)
		{
			dtCollider.collisionListener = this;
		}
		logicVariable = AddOrGetLogicComponent<LogicVariable>();
		actorInfo = AddOrGetLogicComponent<ActorInfo>();
		actorHealthInfo = AddOrGetLogicComponent<ActorHealthInfo>();
		actorElementInfo = AddOrGetLogicComponent<ActorElementInfo>();
		actorSearchTargetInfo = AddOrGetLogicComponent<ActorSearchTarget>();
		actorScaleInfo = AddOrGetLogicComponent<ActorScaleInfo>();
		AddOrGetLogicComponent<Searchable>();
		shootBehaviour = AddOrGetLogicComponent<ShootBehaviour>();
		actorSkillManage = AddOrGetLogicComponent<ActorSkillManage>();
		effectManage = AddOrGetMonoLogicComponent<ActorEffectManage>();
		buffComponent = AddOrGetMonoLogicComponent<BuffCom>();
		buffComponent.InitBuff(this);
		_smooth = AddOrGetMonoLogicComponent<VisualSmooth>();
		actorShield = AddOrGetMonoLogicComponent<ActorShield>();
		SetupComponents();
		InitializePrimeState();
		InitializeDamageable();
		InitializeAttackBehaviour();
		InitializeMovementBehaviour();
		InitializePassiveBehaviour();
		actorSearchTargetInfo.InitializeSearchTarget();
		InitializeVisual();
		InitializeTag();
		gameObject.layer = 8;
		if (dtCollider != null)
		{
			dtCollider.layer = 8;
		}
		AddAllStateActions();
	}

	protected override void OnShutdown()
	{
		base.OnShutdown();
		attributeList.ValueChangedEvent -= OnAttributeListValueChange;
	}

	protected override void OnActive()
	{
		if (this is MonsterAdventureActor)
		{
			attributeList?.Init();
		}
		actorHealthInfo.HpChangedEvent += OnHpChangedEvent;
		actorHealthInfo.AliveChangedEvent += OnAliveChangedEvent;
		actorShield.shieldChangedEvent += OnShieldChangedEvent;
		ActorScaleInfo actorScaleInfo = this.actorScaleInfo;
		actorScaleInfo.onModelScaleChagned = (Action)Delegate.Combine(actorScaleInfo.onModelScaleChagned, new Action(OnModelScaleChanged));
		ActorScaleInfo actorScaleInfo2 = this.actorScaleInfo;
		actorScaleInfo2.onColliderScalerChanged = (Action)Delegate.Combine(actorScaleInfo2.onColliderScalerChanged, new Action(OnColliderScaleChanged));
		ShowChangedEvent += OnShow;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_START_CHECK_BROKENLINE_BULLET", OnStartCheckBrokenLineBullet);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CANCEL_CHECK_BROKENLINE_BULLET", OnCancelCheckBrokenLineBullet);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		actorInfo.ComboSpdMultiplier = 1;
	}

	protected override void OnDeactive()
	{
		actorInfo.ComboSpdMultiplier = 1;
		buffComponent?.OnClear();
		logicVariable.Clear();
		actorHealthInfo.HpChangedEvent -= OnHpChangedEvent;
		actorHealthInfo.AliveChangedEvent -= OnAliveChangedEvent;
		actorShield.shieldChangedEvent -= OnShieldChangedEvent;
		ActorScaleInfo actorScaleInfo = this.actorScaleInfo;
		actorScaleInfo.onModelScaleChagned = (Action)Delegate.Remove(actorScaleInfo.onModelScaleChagned, new Action(OnModelScaleChanged));
		ActorScaleInfo actorScaleInfo2 = this.actorScaleInfo;
		actorScaleInfo2.onColliderScalerChanged = (Action)Delegate.Remove(actorScaleInfo2.onColliderScalerChanged, new Action(OnColliderScaleChanged));
		ShowChangedEvent -= OnShow;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_START_CHECK_BROKENLINE_BULLET", OnStartCheckBrokenLineBullet);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CANCEL_CHECK_BROKENLINE_BULLET", OnCancelCheckBrokenLineBullet);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ReleasePassiveBehaviour();
		InterrupDisplacement();
		ReleaseMovementBehaviour();
		ReleaseAttackBehaviour();
		ReleaseDamageable();
		ReleasePrimeState();
		actorSearchTargetInfo.ReleaseSearchTarget();
		ReleaseVisual();
		ReleaseTag();
		ClearMonsterWeaponHitedActors();
		_logicPaused = false;
		ClearMovableCoroutineAndStopFx();
		ClearEvent();
		_enterColliderEntities.Clear();
		_comboInputBuffer.Flush();
		actorHealthInfo.hp = actorHealthInfo.hpMax;
		movementMode = MovementMode.None;
		actorSkillManage.DestoryAllSkill(isRelease: true);
		actorSkillManage.DestroyAllPassiveSkill();
		ClearHitImmunitys();
		stateAttributeList.Clear();
		strengthOverride = -1;
	}

	protected override void OnLogicUpdateEnabled()
	{
		if (!logicInitialized)
		{
			_movementFSM?.SwitchState(7);
			_attackFSM?.SwitchState(12);
			if (_primeFSM != null)
			{
				_state = ActorState.Null;
				_primeFSM.SwitchState(0);
			}
			logicInitialized = true;
		}
		tsTransform.transformSyncEnabled = false;
		EnableMovementAgent();
		_movementFSM?.Enable();
		_attackFSM?.Enable();
		_primeFSM?.Enable();
		if (!(this is PlayerAdventureActor))
		{
			StartParallelAI();
		}
	}

	protected override void OnLogicUpdateDisabled()
	{
		InterruptMovement();
		InterruptAttack(force: true);
		_state = ActorState.Null;
		_primeFSM?.SwitchState(0);
		_movementFSM?.Disable();
		_attackFSM?.Disable();
		_primeFSM?.Disable();
		DisableParallelAI();
		DisableMovementAgent();
		TimeControlReset();
		tsTransform.transformSyncEnabled = true;
		actorInfo?.attributeWithElementOrDamageTypeDict?.Clear();
		if (this is MonsterAdventureActor)
		{
			attributeList?.Clear();
		}
	}

	protected override void OnLogicUpdatePaused()
	{
		_logicPaused = true;
		_primeFSM.Pause();
		PauseParallelAI();
		PauseAnimation();
		tsTransform.transformSyncEnabled = true;
		ActorHelper.GetPlayerSkillManageComponent(gameObject)?.PauseSkillBehaviour();
	}

	protected override void OnLogicUpdateResumed()
	{
		_logicPaused = false;
		tsTransform.transformSyncEnabled = false;
		_primeFSM.Resume();
		ResumeParallelAI();
		ResumeAnimation();
		ActorHelper.GetPlayerSkillManageComponent(gameObject)?.ResumeSkillBehaviour();
	}

	protected override void OnLogicUpdate()
	{
		if (!isPenetrate && _enterColliderEntities.Count > 0)
		{
			for (int i = 0; i < _enterColliderEntities.Count; i++)
			{
				TransparentFadeOut();
			}
			_enterColliderEntities.Clear();
		}
	}

	public virtual void LevelStart()
	{
	}

	public virtual void LevelEnd()
	{
	}

	protected virtual void OnAttributeListValueChange(HotfixEnum.effectAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP diff)
	{
		AdventureActorAttributeListChangeEvent adventureActorAttributeListChangeEvent = AdventureActorAttributeListChangeEvent.Generate();
		adventureActorAttributeListChangeEvent.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAttributeListChangeEvent);
	}

	protected virtual void OnHpChangedEvent(long hp, long hpMax)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("HpChanged", Id, hp, hpMax);
	}

	protected virtual void OnAliveChangedEvent(bool alive)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("AliveChanged", Id, alive);
	}

	protected virtual void OnShieldChangedEvent(long value1, long value2)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("ShieldChanged", Id, value1, value2);
	}

	protected virtual void OnShow(bool show)
	{
	}

	protected void OnModelScaleChanged()
	{
		transform.localScale = Vector3.one * (float)actorScaleInfo.modelScale;
	}

	protected void OnColliderScaleChanged()
	{
		float scale = (float)actorScaleInfo.colliderScale;
		dtCollider.ScaleUnityColliderShape(scale, applyScaleToDeterministicCollider: true, applyTransformScale: true);
		checkBrokenLineBulletRadius = dtCollider.Radius;
		if (null != movAgent)
		{
			movAgent.radius = dtCollider.Radius * AdventureModuleController.Config.Actor_NavAgentAvoidRadiusRate;
			movAgent.height = dtCollider.ColliderHeight;
		}
	}

	internal void EnableIgnoreDeterministicCollision()
	{
		dtCollider.ActiveSelf = false;
	}

	internal void DisableIgnoreDeterministicCollision()
	{
		dtCollider.ActiveSelf = true;
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		_primeFSM.GetCurState().OnDeterministicCollisionEnter(other);
		_attackFSM.GetCurState().OnDeterministicCollisionEnter(other);
		_movementFSM.GetCurState().OnDeterministicCollisionEnter(other);
		OnEnterDeterministicCollision(other);
		if (isPenetrate)
		{
			LogicEntity entity = other.Entity;
			if (entity is PlayerAdventureActor || entity is MonsterAdventureActor || entity is AdventureWeapon)
			{
				_enterColliderEntities.Add(other.Entity);
				TransparentFadeIn();
			}
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
		if (_primeFSM != null)
		{
			_primeFSM.GetCurState().OnDeterministicCollisionStay(other);
		}
		if (_attackFSM != null)
		{
			_attackFSM.GetCurState().OnDeterministicCollisionStay(other);
		}
		if (_movementFSM != null)
		{
			_movementFSM.GetCurState().OnDeterministicCollisionStay(other);
		}
		OnStayDeterministicCollision(other);
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		_primeFSM.GetCurState().OnDeterministicCollisionExit(other);
		_attackFSM.GetCurState().OnDeterministicCollisionExit(other);
		_movementFSM.GetCurState().OnDeterministicCollisionExit(other);
		OnExitDeterministicCollision(other);
		if (!isPenetrate)
		{
			return;
		}
		LogicEntity entity = other.Entity;
		if (entity is PlayerAdventureActor || entity is MonsterAdventureActor || entity is AdventureWeapon)
		{
			if (_enterColliderEntities.Contains(other.Entity))
			{
				_enterColliderEntities.Remove(other.Entity);
			}
			TransparentFadeOut();
		}
	}

	public virtual void OnEnterDeterministicCollision(DeterministicCollider other)
	{
	}

	public virtual void OnStayDeterministicCollision(DeterministicCollider other)
	{
	}

	public virtual void OnExitDeterministicCollision(DeterministicCollider other)
	{
	}

	protected override void OnVisualUpdate()
	{
		SyncAnimationPlaybackTimeScale();
	}

	public void ReloadComplete()
	{
		shootBehaviour.reloadAmmoProgress = 1f;
		ammoInfo.ammoCount = ammoInfo.ammoCountMax;
	}

	public UnityEngine.Transform GetHeadTransform()
	{
		if (slotConfig != null)
		{
			UnityEngine.Transform slotNode = slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Head);
			if (slotNode != null)
			{
				return slotNode;
			}
		}
		return transform;
	}

	protected void WwiseEvent(string eventName)
	{
		if (!isDead)
		{
			PlaySound(eventName);
		}
	}

	public virtual void PlaySound(string eventName)
	{
		if (this is PlayerAdventureActor || this is MonsterAdventureActor)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
		}
	}

	protected virtual void LoadAnimations()
	{
		if (animator != null)
		{
			if (animatorController == null)
			{
				currentRuntimeAnimatorController = (_originRuntimeAnimatorController = animator.runtimeAnimatorController);
				animatorController = gameObject.AddComponent<HybirdAnimatorController>();
				if (comboGroup != null)
				{
					comboGroup.LoadAnimations(animatorController);
				}
				useSpecialLostControlClip = CheckUseSpecialLostControlClip();
			}
			else
			{
				if (_originRuntimeAnimatorController != null && currentRuntimeAnimatorController != _originRuntimeAnimatorController)
				{
					if (_originRuntimeAnimatorController is AnimatorOverrideController overrideAnimatorController)
					{
						animatorController.OverrideAnimatorControllerClips(overrideAnimatorController);
					}
					else
					{
						animatorController.OverrideAnimatorControllerClips(_originRuntimeAnimatorController);
					}
					currentRuntimeAnimatorController = _originRuntimeAnimatorController;
				}
				animatorController.ResetAnimatorControllerDefaultState();
				animatorController.ForceStopAllActionAnimation();
				animatorController.enabled = true;
				_animationPauseRC = 0;
			}
		}
		SetupRootMotionBones();
		SetupDynamicBones();
	}

	public void LoadExtendAnimation()
	{
		if (animatorController != null && comboGroup != null)
		{
			comboGroup.LoadExtendAnimation(animatorController);
		}
	}

	public bool SwitchActorAnimationGroup(RuntimeAnimatorController newRuntimeAnimatorController)
	{
		if (animatorController == null)
		{
			return false;
		}
		if (currentRuntimeAnimatorController == newRuntimeAnimatorController)
		{
			return false;
		}
		if (newRuntimeAnimatorController is AnimatorOverrideController overrideAnimatorController)
		{
			animatorController.OverrideAnimatorControllerClips(overrideAnimatorController);
		}
		else
		{
			animatorController.OverrideAnimatorControllerClips(newRuntimeAnimatorController);
		}
		currentRuntimeAnimatorController = newRuntimeAnimatorController;
		useSpecialLostControlClip = CheckUseSpecialLostControlClip();
		return true;
	}

	public void PauseAnimation()
	{
		if (!(animatorController == null))
		{
			_animationPauseRC++;
			if (_animationPauseRC == 1)
			{
				animatorController.enabled = false;
			}
		}
	}

	public void ResumeAnimation()
	{
		if (!(animatorController == null))
		{
			_animationPauseRC--;
			if (_animationPauseRC == 0)
			{
				animatorController.enabled = true;
			}
			if (_animationPauseRC < 0)
			{
				_animationPauseRC = 0;
				LogWarning("PauseAnimation与ResumeAnimation使用不匹配");
			}
		}
	}

	public void OnStateTransformation(string messageName, Animator animator1, AnimatorStateInfo stateInfo, int layerIndex)
	{
		_movementFSM.GetCurState()?.OnAnimationStateTransformation(messageName, animator1, stateInfo, layerIndex);
		_attackFSM.GetCurState()?.OnAnimationStateTransformation(messageName, animator1, stateInfo, layerIndex);
	}

	public void OnStateMachineTransformation(string messageName, Animator animator1, int stateMachinePathHash)
	{
		_movementFSM.GetCurState()?.OnAnimationStateMachineTransformation(messageName, animator1, stateMachinePathHash);
		_attackFSM.GetCurState()?.OnAnimationStateMachineTransformation(messageName, animator1, stateMachinePathHash);
	}

	public bool ReplaceAnimationGroup(int index = 0)
	{
		if (index < 0)
		{
			Debug.LogError("ReplaceAnimationGroup Index Error!");
			return false;
		}
		ComboGroup comboGroupForSkin = comboGroup;
		if (this is PlayerAdventureActor { isSkin: not false } playerAdventureActor && playerAdventureActor.comboGroupForSkin != null)
		{
			comboGroupForSkin = playerAdventureActor.comboGroupForSkin;
		}
		List<AnimatorOverrideController> replaceOverrideController = comboGroupForSkin.replaceOverrideController;
		if (replaceOverrideController == null || replaceOverrideController.Count <= 0)
		{
			return false;
		}
		AnimatorOverrideController animatorOverrideController = comboGroupForSkin.replaceOverrideController.get_Item(index);
		if (animatorOverrideController != null)
		{
			return SwitchActorAnimationGroup(animatorOverrideController);
		}
		Debug.LogError("ReplaceAnimationGroup Failed!");
		return false;
	}

	public void ResumeAnimationGroup()
	{
		SwitchActorAnimationGroup(_originRuntimeAnimatorController);
	}

	protected void SyncAnimationPlaybackTimeScale()
	{
		if (!(animatorController == null))
		{
			float num = (float)finalLogicTimeScale;
			if (!Mathf.Approximately(animatorController.playbackTimeScale, num))
			{
				animatorController.playbackTimeScale = num;
			}
		}
	}

	public void PlayIdleAnim()
	{
		if (!(animatorController == null) && !isStiff && !isKnockBack && !isAirBorne && !isForceMove && !isStun && !isSleep && !isToughnessBrokenState)
		{
			OnPlayIdleAnim();
		}
	}

	public virtual void OnPlayIdleAnim()
	{
		animatorController.SetBool(AnimationParameterNames.IsAliveHash, value: true);
		animatorController.SetBool(AnimationParameterNames.IsLostControl, value: false);
		animatorController.SetBool(AnimationParameterNames.IsLostControlSpecial, value: false);
	}

	public void PlayLostControlAnim(bool useSpecialLostControlAnim = false)
	{
		if (!(animatorController == null))
		{
			useSpecialLostControlAnim = useSpecialLostControlAnim && useSpecialLostControlClip;
			animatorController.SetTrigger(AnimationParameterNames.TriggerLostControl);
			animatorController.SetBool(AnimationParameterNames.IsAliveHash, value: true);
			animatorController.SetBool(AnimationParameterNames.IsLostControl, value: true);
			if (useSpecialLostControlAnim)
			{
				ShowSpecialLostControlLayer(show: true);
			}
		}
	}

	public void ShowSpecialLostControlLayer(bool show)
	{
		animatorController.SetBool(AnimationParameterNames.IsLostControlSpecial, show);
		animatorController.defaultAnimatorControllerPlayable.SetLayerWeight(1, show ? 1f : 0f);
	}

	public void PlayDeathAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetBool(AnimationParameterNames.IsAliveHash, value: false);
			animatorController.SetBool(AnimationParameterNames.IsLostControl, value: true);
		}
	}

	public void PlayJumpAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.JumpTimeHash, 0f);
			animatorController.SetBool(AnimationParameterNames.IsJumpingHash, value: true);
		}
	}

	public void UpdateJumpAnim(float normalizedTime)
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.JumpTimeHash, normalizedTime);
		}
	}

	public void StopJumpAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.JumpTimeHash, 1f);
			animatorController.SetBool(AnimationParameterNames.IsJumpingHash, value: false);
		}
	}

	public void PlayDashAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.DashTimeHash, 0f);
			animatorController.SetBool(AnimationParameterNames.IsDashingHash, value: true);
		}
	}

	public void UpdateDashAnim(float normalizedTime)
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.DashTimeHash, normalizedTime);
		}
	}

	public void StopDashAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.DashTimeHash, 1f);
			animatorController.SetBool(AnimationParameterNames.IsDashingHash, value: false);
		}
	}

	public void PlayDodgeAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.DodgeTimeHash, 0f);
			animatorController.SetBool(AnimationParameterNames.IsDodgingHash, value: true);
		}
	}

	public void UpdateDodgeAnim(float normalizedTime)
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.DodgeTimeHash, normalizedTime);
		}
	}

	public void StopDodgeAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetFloat(AnimationParameterNames.DodgeTimeHash, 1f);
			animatorController.SetBool(AnimationParameterNames.IsDodgingHash, value: false);
		}
	}

	public void PlayHurtAnim(int hurtAniTag = -1)
	{
		if (!(animatorController == null))
		{
			animatorController.SetTrigger(AnimationParameterNames.THurt);
			animatorController.SetInteger(AnimationParameterNames.HurtAniTag, (hurtAniTag != -1) ? hurtAniTag : 0);
		}
	}

	public void PlayOpenChestAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetTrigger(AnimationParameterNames.OpenHash);
		}
	}

	public void PlayLeaveAnim()
	{
		if (!(animatorController == null))
		{
			animatorController.SetTrigger(AnimationParameterNames.LeaveHash);
		}
	}

	public bool IsInLeaveState()
	{
		if (animatorController.defaultAnimatorControllerPlayable.GetCurrentAnimatorStateInfo(0).shortNameHash != AnimationStateNames.LeaveStateHash)
		{
			return false;
		}
		if (this is PlayerAdventureActor playerAdventureActor)
		{
			playerAdventureActor.isAssistStartLeave = false;
		}
		return true;
	}

	public void PlayShakeAnim()
	{
		if (!(animatorController == null))
		{
			AdventureModuleConfigureData config = AdventureModuleController.Config;
			if (this is DestructibleStateSingle)
			{
				nRootShake(config.Actor_Shake_SingleDuration, config.Actor_Shake_Range, config.Actor_Shake_LoopTimes);
			}
			else if (config.Actor_Shake)
			{
				animatorController.RootShake(config.Actor_Shake_SingleDuration, config.Actor_Shake_Range, config.Actor_Shake_LoopTimes);
			}
		}
	}

	public void nRootShake(float singleShakeDuration, float range, int loopTimes)
	{
		TSVector2 pos = tsTransform.Position;
		if (_nrootShakeTween != null)
		{
			_nrootShakeTween.Complete();
			_nrootShakeTween = null;
			_nrootShakeShifting = Vector2.zero;
		}
		_nrootShakeTween = DOTween.To(() => Vector2.zero, (Vector2 x) =>
		{
			_nrootShakeShifting = x;
		}, new Vector2(0f, 0f - range), singleShakeDuration);
		_nrootShakeTween.onComplete = () =>
		{
			_nrootShakeShifting = Vector2.zero;
		};
		_nrootShakeTween.onUpdate = () =>
		{
			tsTransform.Position = new TSVector2(pos.x + _nrootShakeShifting.x, pos.y + _nrootShakeShifting.y);
		};
		_nrootShakeTween.SetLoops(loopTimes);
	}

	protected void SetupRootMotionBones()
	{
		if (animatorController != null && slotConfig != null)
		{
			animatorController.rootBoneNode = slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Root);
			animatorController.rootBoneOffset = slotConfig.GetRootSlotOffset();
			animatorController.rootBoneRotationLocked = false;
		}
	}

	protected int GetDynamicBoneIndexByNode(UnityEngine.Transform node)
	{
		if (dynamicBones == null)
		{
			return -1;
		}
		if (node.TryGetComponent<BaseCloth>(out var component))
		{
			for (int i = 0; i < dynamicBones.Length; i++)
			{
				if (component == dynamicBones[i])
				{
					return i;
				}
			}
		}
		return -1;
	}

	protected void SetupDynamicBones()
	{
		if (dynamicBones == null)
		{
			dynamicBones = GetComponentsInChildren<BaseCloth>();
			_originDynamicBonesBlendWeight = new float[dynamicBones.Length];
			for (int i = 0; i < dynamicBones.Length; i++)
			{
				_originDynamicBonesBlendWeight[i] = dynamicBones[i].BlendWeight;
			}
			_dynamicBonesBlendFadeCoroutines = new Coroutine[dynamicBones.Length];
		}
	}

	public void ResetDynamicBones()
	{
		if (dynamicBones != null)
		{
			for (int i = 0; i < dynamicBones.Length; i++)
			{
				dynamicBones[i].ResetCloth(ClothParams.TeleportMode.Reset, 0.5f);
				dynamicBones[i].BlendWeight = _originDynamicBonesBlendWeight[i];
			}
		}
	}

	public void DynamicBoneOff(UnityEngine.Transform node = null, float transitionTime = 0f)
	{
		if (node == null)
		{
			for (int i = 0; i < dynamicBones.Length; i++)
			{
				DoDynamicBonesBlendTransition(i, _originDynamicBonesBlendWeight[i], 0f, transitionTime);
			}
			return;
		}
		int dynamicBoneIndexByNode = GetDynamicBoneIndexByNode(node);
		if (dynamicBoneIndexByNode != -1)
		{
			DoDynamicBonesBlendTransition(dynamicBoneIndexByNode, _originDynamicBonesBlendWeight[dynamicBoneIndexByNode], 0f, transitionTime);
		}
	}

	public void DynamicBoneOn(UnityEngine.Transform node = null, float transitionTime = 0f)
	{
		if (node == null)
		{
			for (int i = 0; i < dynamicBones.Length; i++)
			{
				DoDynamicBonesBlendTransition(i, 0f, _originDynamicBonesBlendWeight[i], transitionTime);
			}
			return;
		}
		int dynamicBoneIndexByNode = GetDynamicBoneIndexByNode(node);
		if (dynamicBoneIndexByNode != -1)
		{
			dynamicBones[dynamicBoneIndexByNode].ResetCloth(ClothParams.TeleportMode.Keep, 1f);
			DoDynamicBonesBlendTransition(dynamicBoneIndexByNode, 0f, _originDynamicBonesBlendWeight[dynamicBoneIndexByNode], transitionTime);
		}
	}

	protected void DoDynamicBonesBlendTransition(int dynamicBoneIndex, float from, float to, float duration)
	{
		BaseCloth dynamicBone = dynamicBones[dynamicBoneIndex];
		if (_dynamicBonesBlendFadeCoroutines[dynamicBoneIndex] != null)
		{
			StopCoroutine(_dynamicBonesBlendFadeCoroutines[dynamicBoneIndex]);
			_dynamicBonesBlendFadeCoroutines[dynamicBoneIndex] = null;
		}
		if (duration > 0f)
		{
			_dynamicBonesBlendFadeCoroutines[dynamicBoneIndex] = StartCoroutine(DoDynamicBonesBlendTransitionCoroutine());
		}
		else
		{
			dynamicBone.BlendWeight = to;
		}
		IEnumerator DoDynamicBonesBlendTransitionCoroutine()
		{
			float t = 0f;
			while (t < duration)
			{
				t += Time.deltaTime;
				dynamicBone.BlendWeight = Mathf.Lerp(from, to, t / duration);
				yield return null;
			}
			dynamicBone.BlendWeight = to;
			_dynamicBonesBlendFadeCoroutines[dynamicBoneIndex] = null;
		}
	}

	private bool CheckUseSpecialLostControlClip()
	{
		AnimatorOverrideController animatorOverrideController = currentRuntimeAnimatorController as AnimatorOverrideController;
		if (animatorOverrideController == null)
		{
			return false;
		}
		bool result = false;
		List<KeyValuePair<AnimationClip, AnimationClip>> list = new List<KeyValuePair<AnimationClip, AnimationClip>>();
		animatorOverrideController.GetOverrides(list);
		foreach (var (animationClip3, animationClip4) in list)
		{
			if (animationClip3.name.Equals("Special_Lostcontrol_Start_Anim") && animationClip4 != null)
			{
				result = true;
				specialLostControlStartClipLen = animationClip4.length;
			}
			if (animationClip3.name.Equals("Special_Lostcontrol_End_Anim") && animationClip4 != null)
			{
				specialLostControlEndClipLen = animationClip4.length;
			}
		}
		return result;
	}

	public bool QueryMonsterWeaponHitedTimeout(long actorId, FP timeout)
	{
		if (!_monsterWeaponHitedActors.TryGetValue(actorId, out var value))
		{
			return true;
		}
		return LogicTime > value + timeout;
	}

	public void SetMonsterWeaponHitedTime(long actorId, FP time)
	{
		_monsterWeaponHitedActors.set_Item(actorId, time);
	}

	public void ClearMonsterWeaponHitedActors()
	{
		_monsterWeaponHitedActors.Clear();
	}

	protected void InitializeAttackBehaviour()
	{
		hitBox = HitBox.Setup(gameObject, this, this);
		_attackFSM = new ActorAttackFSM(gameObject);
		_attackFSM.RegistState(new ActorNonAttackState());
		_attackFSM.RegistState(new ActorAttackAnticipationState());
		_attackFSM.RegistState(new ActorAttackActivationState());
		_attackFSM.RegistState(new ActorAttackRecoveryState());
		_attackFSM.RegistState(new ActorAttackReloadState());
		isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	protected void ReleaseAttackBehaviour()
	{
		attackTarget = null;
		_hitedActors.Clear();
		lastComboPhaseSwitchFrameCount = -1;
	}

	public void PlayComboByKey(string actionTag, Action onComplete = null, Action onInterrupt = null)
	{
		Attack(actionTag, onComplete, onInterrupt);
	}

	public ComboInputBuffer.InputResult Attack(ComboInputBuffer.ActionKey actionKey, Action onComplete = null, bool cancelInputIfNotExecute = false, bool keyPerfectMatch = false)
	{
		if (isDead || !isControllable)
		{
			return ComboInputBuffer.InputResult.Invalid;
		}
		_comboInputBuffer.InputKey(actionKey, LogicTime);
		ComboInputBuffer.InputResult inputResult = AttackInternal(onComplete);
		if (cancelInputIfNotExecute && inputResult != ComboInputBuffer.InputResult.Execute)
		{
			_comboInputBuffer.CancelKeys(1);
		}
		return inputResult;
	}

	public ComboInputBuffer.InputResult Attack(ComboInputBuffer.ActionKey[] actionKeys, Action onComplete = null, bool cancelInputIfNotExecute = false, bool keyPerfectMatch = false)
	{
		if (isDead || !isControllable)
		{
			return ComboInputBuffer.InputResult.Invalid;
		}
		_comboInputBuffer.FlushKeys(actionKeys, LogicTime, keyPerfectMatch);
		ComboInputBuffer.InputResult inputResult = AttackInternal(onComplete);
		if (cancelInputIfNotExecute && inputResult != ComboInputBuffer.InputResult.Execute)
		{
			_comboInputBuffer.CancelKeys(1);
		}
		return inputResult;
	}

	public ComboInputBuffer.InputResult Attack(string actionTag, Action onComplete = null, Action onInterrupt = null)
	{
		if (isDead || !isControllable)
		{
			return ComboInputBuffer.InputResult.Invalid;
		}
		_actionTag = actionTag;
		return AttackInternal(onComplete, onInterrupt);
	}

	protected ComboInputBuffer.InputResult AttackInternal(Action onComplete = null, Action onInterrupt = null)
	{
		if (!isPlayingAttackCombo)
		{
			Combo combo = _attackFSM.SelectCombo();
			if (combo == null)
			{
				return ComboInputBuffer.InputResult.NoMatch;
			}
			_attackFSM.StartCombo(combo, onComplete, onInterrupt);
			return ComboInputBuffer.InputResult.Execute;
		}
		_attackFSM.StartCombo(null, onComplete, onInterrupt);
		return ComboInputBuffer.InputResult.Accept;
	}

	public void CancelAttack()
	{
		if (!isDead)
		{
			_comboInputBuffer.Flush();
			_attackFSM.StopLoopingCombo();
		}
	}

	public bool InterruptAttack(bool force = false, bool fadeOutAnim = true, bool interruptReload = true)
	{
		if (interruptReload)
		{
			ShootBehaviour shootBehaviour = this.shootBehaviour;
			if (shootBehaviour != null && shootBehaviour.isReloadingAmmo)
			{
				_attackFSM.StopCombo(fadeOutAnim);
				return true;
			}
		}
		if (!isPlayingAttackCombo)
		{
			return true;
		}
		if (!force)
		{
			return false;
		}
		_comboInputBuffer.Flush();
		_attackFSM.StopCombo(fadeOutAnim);
		SceneSingleton<AdventureFXManager>.Instance.InterruptFXPlayersByOwner(gameObject);
		_onAttackInterrupted?.Invoke(this);
		return true;
	}

	public bool CheckBreakAttack(SkillPhaseFeatureFlag skillPhaseFeatureFlag)
	{
		if (_attackFSM.currentFeaturePhase == null)
		{
			return false;
		}
		return (_attackFSM.currentFeaturePhase.skillPhaseConfig.BreakSkillPhaseConfig.skillPhaseFeatureFlag & skillPhaseFeatureFlag) != 0;
	}

	public FP QueryHitBoxContextTime()
	{
		return LogicTime;
	}

	public TSVector2 QueryHitBoxContextPosition()
	{
		return tsTransform.Position;
	}

	public TSVector2 QueryHitBoxContextDirection()
	{
		return tsTransform.Forward;
	}

	public bool QueryActorHitedTimeout(long actorId, FP timeout)
	{
		if (!_hitedActors.TryGetValue(actorId, out var value))
		{
			return true;
		}
		return LogicTime > value + timeout;
	}

	public void SetActorHitedTime(long actorId, FP time)
	{
		_hitedActors.set_Item(actorId, time);
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity actor)
	{
		if ((hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !this.IsConfrontWith(actor))
		{
			return this.IsNeutralWith(actor);
		}
		return true;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (isDead)
		{
			return false;
		}
		if (!actor.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = actor.GetComponent<AdventureActor>().Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (isDead)
		{
			return false;
		}
		AdventureActor component = actor.GetComponent<AdventureActor>();
		if (!component.CurrentStepCanbeHurt())
		{
			return true;
		}
		(damaged, _, _) = component.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public virtual bool CurrentStepCanbeHurt()
	{
		return true;
	}

	internal void ResetActorHitedTimeout()
	{
		_hitedActors.Clear();
	}

	public void RigisterDeadImmunity(Action action)
	{
		OnDeadImmunityHandle = (Action)Delegate.Combine(OnDeadImmunityHandle, action);
	}

	public void UnRigisterDeadImmunity(Action action)
	{
		OnDeadImmunityHandle = (Action)Delegate.Remove(OnDeadImmunityHandle, action);
	}

	public void ExcuteDeadImmunity(LogicEntity from, LogicEntity to, AdventureWeapon weapon = null, DamageType damageType1 = DamageType.None, long value = 0L, bool isCrit = false, bool isDodge = false, HotfixEnum.elementType elementType = HotfixEnum.elementType.NONE)
	{
		AdventureActorDeadImmunityEvent adventureActorDeadImmunityEvent = AdventureActorDeadImmunityEvent.Generate();
		adventureActorDeadImmunityEvent.sender = this;
		adventureActorDeadImmunityEvent.from = from;
		adventureActorDeadImmunityEvent.to = to;
		adventureActorDeadImmunityEvent.weapon = weapon;
		adventureActorDeadImmunityEvent.attackType = damageType1;
		adventureActorDeadImmunityEvent.value = value;
		adventureActorDeadImmunityEvent.isCrit = isCrit;
		adventureActorDeadImmunityEvent.isDodge = isDodge;
		adventureActorDeadImmunityEvent.elementType = elementType;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorDeadImmunityEvent);
		OnDeadImmunityHandle?.Invoke();
	}

	private void StartHurtEffectCD()
	{
		StartLogicCoroutine(HurtEffectCD(), runImmediately: true);
	}

	private IEnumerator HurtEffectCD()
	{
		onHurtEffectCD = true;
		yield return ModuleController<AdventureModuleController>.Instance.sharedConfigureData.Actor_Damage_HurtEffectAndAudio_CD;
		onHurtEffectCD = false;
	}

	public void StartHurtAudioCD()
	{
		StartLogicCoroutine(HurtAudioCD(), runImmediately: true);
	}

	private IEnumerator HurtAudioCD()
	{
		onHurtAudioCD = true;
		yield return ModuleController<AdventureModuleController>.Instance.sharedConfigureData.Actor_Damage_HurtEffectAndAudio_CD;
		onHurtAudioCD = false;
	}

	public void AddImmuneCertainDamageId(int damageId)
	{
		if (!immuneCertainDamageIds.Contains(damageId))
		{
			immuneCertainDamageIds.Add(damageId);
		}
	}

	public void RemoveImmuneCertainDamageId(int damageId)
	{
		if (immuneCertainDamageIds.Contains(damageId))
		{
			immuneCertainDamageIds.Remove(damageId);
		}
	}

	protected void InitializeDamageable()
	{
		toActor = this;
	}

	protected void ReleaseDamageable()
	{
		_deadImmunityRC = 0;
		actorHealthInfo.isAlive = false;
		toActor = null;
		immuneCertainDamageIds.Clear();
	}

	public void MinusHp(int minus)
	{
		actorHealthInfo.hp -= minus;
	}

	public void ResetHp(int curHp)
	{
		actorHealthInfo.hp = curHp;
	}

	public static void AddFromAttr(int id, AdventureActor fromActor, int count = 1)
	{
		fromAdditionalAttrInfo.AddAttr(fromActor, id, count);
		if (fromAdditionalAttrDict.TryGetValue(id, out var value))
		{
			fromAdditionalAttrDict.set_Item(id, value + count);
		}
		else
		{
			fromAdditionalAttrDict.TryAdd(id, count);
		}
	}

	public static void AddFromAttr(List<int> idList, AdventureActor fromActor, int count = 1)
	{
		fromAdditionalAttrInfo.AddAttr(fromActor, idList, count);
		foreach (int id in idList)
		{
			if (fromAdditionalAttrDict.TryGetValue(id, out var value))
			{
				fromAdditionalAttrDict.set_Item(id, value + count);
			}
			else
			{
				fromAdditionalAttrDict.TryAdd(id, count);
			}
		}
	}

	public static void AddToAttr(int id, AdventureActor fromActor, int count = 1)
	{
		toAdditionalAttrInfo.AddAttr(fromActor, id, count);
		if (toAdditionalAttrDict.TryGetValue(id, out var value))
		{
			toAdditionalAttrDict.set_Item(id, value + count);
		}
		else
		{
			toAdditionalAttrDict.TryAdd(id, count);
		}
	}

	public static void AddToAttr(List<int> idList, AdventureActor fromActor, int count = 1)
	{
		toAdditionalAttrInfo.AddAttr(fromActor, idList, count);
		foreach (int id in idList)
		{
			if (toAdditionalAttrDict.TryGetValue(id, out var value))
			{
				toAdditionalAttrDict.set_Item(id, value + count);
			}
			else
			{
				toAdditionalAttrDict.TryAdd(id, count);
			}
		}
	}

	private static void ClearOnceAdditionalAttr()
	{
		fromAdditionalAttrInfo.Clear();
		toAdditionalAttrInfo.Clear();
		fromAdditionalAttrDict.Clear();
		toAdditionalAttrDict.Clear();
	}

	private static void CopyOnceAttrDict(Dictionary<int, int> src, Dictionary<int, int> dst)
	{
		dst.Clear();
		foreach (KeyValuePair<int, int> item in src)
		{
			dst.set_Item(item.Key, item.Value);
		}
	}

	public static void SetFromForceCrit(bool val)
	{
		fromAdditionalAttrInfo.forceCrit = val;
	}

	public static void SetToForceCrit(bool val)
	{
		toAdditionalAttrInfo.forceCrit = val;
	}

	public static void SetFromForceMissDamage(bool val)
	{
		fromAdditionalAttrInfo.forceMissDamage = val;
	}

	public static void SetToForceMissDamage(bool val)
	{
		toAdditionalAttrInfo.forceMissDamage = val;
	}

	public void SetExtraAtk(FP _extraAtkPercent, FP _extraAtkAmend)
	{
	}

	public void SetKnockBackDistancePercent(FP _value)
	{
		if (!(_value < -100))
		{
			knockBackDistancePercentTemp = _value;
		}
	}

	public static bool IsRecordActor(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor)
		{
			return true;
		}
		if (actor is MonsterAdventureActor monsterAdventureActor && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LORD || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LEADER || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.BOSSRUSH || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.JOINTDRILLBOSS))
		{
			return true;
		}
		return false;
	}

	public long CalculateDamage(bool isCrit, out Recorder.Types.Damage dmgData)
	{
		dmgData = null;
		if (fromActorTemp == null)
		{
			return 0L;
		}
		long num = 0L;
		bool flag = ModuleController<AdventureModuleController>.Instance.uploadDamageData && IsRecordActor(this);
		if (flag)
		{
			dmgData = new Recorder.Types.Damage
			{
				From = new Recorder.Types.Attacker(),
				To = new Recorder.Types.Defender()
			};
		}
		FDP fDP = FDP.Zero;
		switch ((HotfixEnum.damageEffect)hitDamageConfigTemp.EffectType)
		{
		case HotfixEnum.damageEffect.PHYSICS:
		case HotfixEnum.damageEffect.MAGIC:
		{
			fDP = fromAdditionalAttrInfo.GetAttributeValue((HotfixEnum.effectAttributeType)hitDamageConfigTemp.DamageBonusType);
			num = CommonHelper.CalculateNormalDamage(fromActorTemp, this, hitDamageConfigTemp, skillLevelTemp, isCrit, isDot: false, out hudColorIndexTemp, out var skillPercentAmend2, out var talentGroupPercentAmend2, out var skillAbsAmend2, out var talentGroupAbsAmend2, out var perkIntensityRatio, out var slotDmgRatio, out var fromEE, out var erAmend, out var defAmend, out var rcdSlotDmgRatio, out var toEERCD, out var skillIntensityRatio, out var toughnessBrokenDmgRatio, out var critRatio, out var envAmendRatio);
			if (flag)
			{
				dmgData.DmgType = Recorder.Types.DamageType.Normal;
				dmgData.From.SkillPercentAmend = (float)skillPercentAmend2;
				dmgData.From.TalentGroupPercentAmend = (float)talentGroupPercentAmend2;
				dmgData.From.SkillAbsAmend = (float)skillAbsAmend2;
				dmgData.From.TalentGroupAbsAmend = (float)talentGroupAbsAmend2;
				dmgData.From.PerkIntensityRatio = (float)perkIntensityRatio;
				dmgData.From.SlotDmgRatio = (float)slotDmgRatio;
				dmgData.From.SkillIntensityRatio = (float)skillIntensityRatio;
				dmgData.From.EE = (float)fromEE;
				dmgData.To.ErAmend = (float)erAmend;
				dmgData.To.DefAmend = (float)defAmend;
				dmgData.To.RcdSlotDmgRatio = (float)rcdSlotDmgRatio;
				dmgData.To.EERCD = (float)toEERCD;
				dmgData.To.ToughnessBrokenDmgRatio = (float)toughnessBrokenDmgRatio;
				dmgData.To.EnvAmendRatio = (float)envAmendRatio;
				dmgData.From.CritRatio = (float)critRatio;
				if (isCrit)
				{
					dmgData.DmgFlag |= 1u;
				}
			}
			break;
		}
		case HotfixEnum.damageEffect.REAL:
		{
			FDP atk = fromAdditionalAttrInfo.atk;
			atk = FDP.Max(FDP.One, atk);
			fDP = atk;
			CommonHelper.GetSkillAndTalentGroupAmend(skillLevelTemp, -1, hitDamageConfigTemp, out var skillPercentAmend, out var skillAbsAmend, out var talentGroupPercentAmend, out var talentGroupAbsAmend);
			skillAbsAmend += CommonHelper.GetAdditionalSkillAbsAmend(hitDamageConfigTemp, fromActorTemp, this, skillLevelTemp);
			num = (long)FDP.Clamp(atk * ((skillPercentAmend + talentGroupPercentAmend) / 10000L / 100L) + skillAbsAmend + talentGroupAbsAmend, long.MinValue, long.MaxValue);
			num = math.max(1L, num);
			if (flag)
			{
				dmgData.DmgType = Recorder.Types.DamageType.Real;
				dmgData.From.SkillPercentAmend = (float)skillPercentAmend;
				dmgData.From.TalentGroupPercentAmend = (float)talentGroupPercentAmend;
				dmgData.From.SkillAbsAmend = (float)skillAbsAmend;
				dmgData.From.TalentGroupAbsAmend = (float)talentGroupAbsAmend;
			}
			break;
		}
		}
		if (flag)
		{
			AttributeList attributeList = fromAdditionalAttrInfo.attributeList;
			AttributeList attributeList2 = toAdditionalAttrInfo.attributeList;
			dmgData.Value = num;
			dmgData.From.Atk = (float)fDP;
			dmgData.From.GenDmgRatio = (float)fromAdditionalAttrInfo.genDmgRatio;
			dmgData.From.DmgPlus = (float)fromAdditionalAttrInfo.dmgPlus;
			dmgData.From.FinalDmgRatio = (float)fromAdditionalAttrInfo.finalDmgRatio;
			dmgData.From.FinalDmgPlus = (float)fromAdditionalAttrInfo.finalDmgPlus;
			dmgData.From.CritRate = (float)fromAdditionalAttrInfo.critRate;
			dmgData.From.DefPierce = (float)fromAdditionalAttrInfo.defPenetrate;
			dmgData.From.DefIgnore = (float)fromAdditionalAttrInfo.defIgnore;
			dmgData.From.WEP = (int)(long)attributeList.GetPentrateElementValue(HotfixEnum.elementType.WE);
			dmgData.From.WEI = (float)attributeList.GetIgnoringInjuredElementValue(HotfixEnum.elementType.WE);
			dmgData.From.FEP = (int)(long)attributeList.GetPentrateElementValue(HotfixEnum.elementType.FE);
			dmgData.From.FEI = (float)attributeList.GetIgnoringInjuredElementValue(HotfixEnum.elementType.FE);
			dmgData.From.SEP = (int)(long)attributeList.GetPentrateElementValue(HotfixEnum.elementType.SE);
			dmgData.From.SEI = (float)attributeList.GetIgnoringInjuredElementValue(HotfixEnum.elementType.SE);
			dmgData.From.AEP = (int)(long)attributeList.GetPentrateElementValue(HotfixEnum.elementType.AE);
			dmgData.From.AEI = (int)(long)attributeList.GetIgnoringInjuredElementValue(HotfixEnum.elementType.AE);
			dmgData.From.LEP = (int)(long)attributeList.GetPentrateElementValue(HotfixEnum.elementType.LE);
			dmgData.From.LEI = (float)attributeList.GetIgnoringInjuredElementValue(HotfixEnum.elementType.LE);
			dmgData.From.DEP = (int)(long)attributeList.GetPentrateElementValue(HotfixEnum.elementType.DE);
			dmgData.From.DEI = (float)attributeList.GetIgnoringInjuredElementValue(HotfixEnum.elementType.DE);
			dmgData.To.GenDmgRcdRatio = (float)toAdditionalAttrInfo.genDmgRcdRatio;
			dmgData.To.DmgPlusRcd = (float)toAdditionalAttrInfo.dmgPlusRcd;
			dmgData.To.SrcDef = (float)toAdditionalAttrInfo.def;
			dmgData.To.CritResistance = (float)toAdditionalAttrInfo.opposeCritRate;
			dmgData.To.WER = (int)(long)attributeList2.GetResistanceElementValue(HotfixEnum.elementType.WE);
			dmgData.To.FER = (int)(long)attributeList2.GetResistanceElementValue(HotfixEnum.elementType.FE);
			dmgData.To.SER = (int)(long)attributeList2.GetResistanceElementValue(HotfixEnum.elementType.SE);
			dmgData.To.AER = (int)(long)attributeList2.GetResistanceElementValue(HotfixEnum.elementType.AE);
			dmgData.To.LER = (int)(long)attributeList2.GetResistanceElementValue(HotfixEnum.elementType.LE);
			dmgData.To.DER = (int)(long)attributeList2.GetResistanceElementValue(HotfixEnum.elementType.DE);
			dmgData.To.Suppress = (float)fromAdditionalAttrInfo.suppressRatio;
			dmgData.To.HP = actorHealthInfo.hp;
			dmgData.To.MaxHP = actorHealthInfo.hpMax;
			dmgData.From.ProtoId = (uint)fromActorTemp.dataID;
			dmgData.From.EntClass = ((!(fromActorTemp is PlayerAdventureActor)) ? Recorder.Types.EntityClass.Monster : Recorder.Types.EntityClass.Role);
			dmgData.To.ProtoId = (uint)dataID;
			dmgData.To.EntClass = ((!(this is PlayerAdventureActor)) ? Recorder.Types.EntityClass.Monster : Recorder.Types.EntityClass.Role);
			dmgData.HitDamageID = hitDamageIdTemp;
			if (fromActorTemp.buffComponent != null && fromActorTemp.buffComponent.GetBuffIds != null)
			{
				dmgData.From.BuffIDs.AddRange(fromActorTemp.buffComponent.GetBuffIds);
			}
			if (fromActorTemp.effectManage != null && fromActorTemp.effectManage.GetEffectIDs != null)
			{
				dmgData.From.EffectIDs.AddRange(fromActorTemp.effectManage.GetEffectIDs);
			}
			if (buffComponent != null && buffComponent.GetBuffIds != null)
			{
				dmgData.To.BuffIDs.AddRange(buffComponent.GetBuffIds);
			}
			dmgData.From.OnceAttributes.Clear();
			int value;
			int key;
			if (fromAdditionalAttrDict.Count > 0)
			{
				foreach (KeyValuePair<int, int> item3 in fromAdditionalAttrDict.ToList())
				{
					item3.Deconstruct(out value, out key);
					int id = value;
					int count = key;
					Recorder.Types.OnceAttribute item = new Recorder.Types.OnceAttribute
					{
						Id = id,
						Count = count
					};
					dmgData.From.OnceAttributes.Add(item);
				}
			}
			dmgData.To.OnceAttributes.Clear();
			if (toAdditionalAttrDict.Count > 0)
			{
				foreach (KeyValuePair<int, int> item4 in toAdditionalAttrDict.ToList())
				{
					item4.Deconstruct(out key, out value);
					int id2 = key;
					int count2 = value;
					Recorder.Types.OnceAttribute item2 = new Recorder.Types.OnceAttribute
					{
						Id = id2,
						Count = count2
					};
					dmgData.To.OnceAttributes.Add(item2);
				}
			}
			if (effectManage != null && effectManage.GetEffectIDs != null)
			{
				dmgData.To.EffectIDs.AddRange(effectManage.GetEffectIDs);
			}
			toAdditionalAttrInfo.WriteMessage(dmgData.To.Attributes);
			fromAdditionalAttrInfo.WriteMessage(dmgData.From.Attributes);
			toAdditionalAttrInfo.WriteSpecialMessage(dmgData.To.SpAttributes);
			fromAdditionalAttrInfo.WriteSpecialMessage(dmgData.From.SpAttributes);
			ModuleController<AdventureModuleController>.Instance.RecordDamage(dmgData, fromActorTemp.Id, Id);
		}
		return num;
	}

	private void GetBothAllInfo()
	{
		bool flag = fromActorTemp.IsPlayerSummoned(out var summoner, out var _);
		skillLevelTemp = 0;
		switch (damageTypeTemp)
		{
		case DamageType.Range:
			fromAdditionalAttrInfo.AddFrom(fromWeaponTemp.attributeList, fromWeaponTemp.attributeWithElementOrDamageTypeDict);
			if (hitDamageConfigTemp.LevelTypeData == 3 && fromWeaponTemp.bindSkillSlotLevelInfo != null)
			{
				skillLevelTemp = fromWeaponTemp.bindSkillSlotLevelInfo.GetSkillLevel((ActionKey)hitDamageConfigTemp.LevelData);
			}
			break;
		case DamageType.Area:
			fromAdditionalAttrInfo.AddFrom(fromAreaTemp.attributeList, fromAreaTemp.attributeWithElementOrDamageTypeDict);
			if (hitDamageConfigTemp.LevelTypeData == 3 && fromAreaTemp.bindSkillSlotLevelInfo != null)
			{
				skillLevelTemp = fromAreaTemp.bindSkillSlotLevelInfo.GetSkillLevel((ActionKey)hitDamageConfigTemp.LevelData);
			}
			break;
		default:
			fromAdditionalAttrInfo.AddFrom(fromActorTemp.attributeList, fromActorTemp.actorInfo.attributeWithElementOrDamageTypeDict);
			if (hitDamageConfigTemp.LevelTypeData == 3)
			{
				PlayerSkillCd logicComponent = fromActorTemp.GetLogicComponent<PlayerSkillCd>();
				if (flag)
				{
					logicComponent = summoner.GetLogicComponent<PlayerSkillCd>();
				}
				if (logicComponent != null)
				{
					skillLevelTemp = logicComponent.GetSkillLevel((ActionKey)hitDamageConfigTemp.LevelData);
				}
			}
			break;
		}
		if (hitDamageConfigTemp.LevelTypeData != 0 && hitDamageConfigTemp.LevelTypeData != 3)
		{
			int num = 0;
			if (fromActorTemp is PlayerAdventureActor playerAdventureActor)
			{
				num = playerAdventureActor.dataID;
			}
			else if (flag)
			{
				num = summoner.dataID;
			}
			if (num != 0)
			{
				skillLevelTemp = CommonHelper.GetLevelByLevelType(num, (HotfixEnum.levelTypeData)hitDamageConfigTemp.LevelTypeData, null, hitDamageConfigTemp.LevelData);
			}
		}
		if (fromActorTemp != null && fromActorTemp.TryOverrideSkillLevel((HotfixEnum.levelTypeData)hitDamageConfigTemp.LevelTypeData, out var overriddenLevel))
		{
			skillLevelTemp = overriddenLevel;
		}
		int levelTypeData = hitDamageConfigTemp.LevelTypeData;
		if (levelTypeData == 3 || levelTypeData == 2 || levelTypeData == 1)
		{
			skillLevelTemp--;
		}
		toAdditionalAttrInfo.AddFrom(attributeList, actorInfo.attributeWithElementOrDamageTypeDict);
		toElementTypeTemp = actorElementInfo.elementType;
		toWeakElementTemp = actorElementInfo.weakElementType;
	}

	protected virtual bool TryOverrideSkillLevel(HotfixEnum.levelTypeData type, out int overriddenLevel)
	{
		overriddenLevel = 0;
		return false;
	}

	public (bool successed, long damage, bool isPerfectDodge) Damage(LogicEntity from, int uniqueAttackId, int onceAttackTargetCount, int hitDamageId = 0, GameObject hurtEffectPrefab = null, HitBox hitbox = null, bool isHittedEffectScale = true, bool showHud = true, bool effectIgnoreTimeScale = true)
	{
		PlayerAdventureActor summoner = this as PlayerAdventureActor;
		if ((object)summoner != null && summoner.isAssist)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (!ModuleController<AdventureModuleController>.Instance.InBattleState)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		isEnterLostCtr = isLostControl;
		lastCtrType = LostControlType.None;
		curCtrType = LostControlType.None;
		if (isStiff)
		{
			lastCtrType |= LostControlType.Stiff;
		}
		if (isAirBorne)
		{
			lastCtrType |= LostControlType.AirBorne;
		}
		if (isKnockBack)
		{
			lastCtrType |= LostControlType.KnockBack;
		}
		fromEntityTemp = from;
		uniqueAttackIdTemp = uniqueAttackId;
		onceAttackTargetCountTemp = onceAttackTargetCount;
		hitDamageIdTemp = hitDamageId;
		hurtEffectPrefabTemp = hurtEffectPrefab;
		hitboxTemp = hitbox;
		isHittedEffectScaleTemp = isHittedEffectScale;
		showHudTemp = showHud && !(this is DestructibleStateSingle);
		effectIgnoreTimeScaleTemp = effectIgnoreTimeScale;
		knockBackDistancePercentTemp = 0;
		isPlayShakeAnim = true;
		if (CheckTag(simplePlayerTag))
		{
			if (!PlayDamageEffect(isKill: false, isCrit: false, isToughnessBroken: false, damaged: false, (!(hitboxTemp == null)) ? hitboxTemp.hurtAnimType : HitBox.HurtAnimType.None))
			{
				if (_akAudio == null)
				{
					_akAudio = GetComponent<AkAnimatorAudio>();
				}
				AkAnimatorAudio.State state = AkAnimatorAudio.State.Hurt_None;
				switch (hitboxTemp.hurtAnimType)
				{
				case HitBox.HurtAnimType.Small:
					state = AkAnimatorAudio.State.Hurt_Samll1;
					if (TSRandom.value <= 0.5)
					{
						state = AkAnimatorAudio.State.Hurt_Samll2;
					}
					break;
				case HitBox.HurtAnimType.Large:
					state = AkAnimatorAudio.State.Hurt_Large;
					break;
				}
				_akAudio.OnStateEnter(state);
			}
			if (!onHurtEffectCD)
			{
				StartHurtEffectCD();
				AdventureFXManager.PlayFX(ModuleController<AdventureModuleController>.Instance.sharedConfigureData.Actor_hit_effect, 1f, Vector3.zero, transform.rotation);
			}
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (!(this is DestructibleStateSingle) && this.state == ActorState.Spawn)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (!actorHealthInfo.isAlive)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (_logicPaused)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		hitDamageConfigTemp = Singleton<HotfixDataController>.Instance.GetHitDamage(hitDamageIdTemp);
		if (hitDamageConfigTemp == null)
		{
			Debug.LogError($"hitDamageId not exist, id:{hitDamageIdTemp}");
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (CheckHitIdImmunity(hitDamageConfigTemp))
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if ((bool)(this as PlayerAdventureActor) && movementState == ActorState.Dodge && canPerfectDodge && !forbiddenPerfectDodge && CanTriggerPerfectDodge(hitDamageIdTemp))
		{
			EnterPerfectDodge();
			canPerfectDodge = false;
			return (successed: false, damage: 0L, isPerfectDodge: true);
		}
		if (from != null)
		{
			fromActorTemp = from.GetComponent<AdventureActor>();
			fromWeaponTemp = from.GetComponent<AdventureWeapon>();
			fromAreaTemp = from.GetComponent<AreaEffectEntity>();
		}
		damageTypeTemp = DamageType.Melee;
		if (fromWeaponTemp != null)
		{
			fromActorTemp = fromWeaponTemp.owner as AdventureActor;
			damageTypeTemp = DamageType.Range;
		}
		else if (fromAreaTemp != null)
		{
			fromActorTemp = fromAreaTemp.owner;
			damageTypeTemp = DamageType.Area;
			areaEffectIdTemp = fromAreaTemp.Id;
		}
		if (hitDamageConfigTemp.SingleDamage && (fromActorTemp == null || fromActorTemp.soldierAttackTarget == null || fromActorTemp.soldierAttackTarget != this))
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (fromActorTemp.IsUseHitFromSummon(out var summoner2))
		{
			fromActorTemp = summoner2;
		}
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = AdventureActorReceiveAttackEvent.Generate();
		adventureActorReceiveAttackEvent.sender = this;
		adventureActorReceiveAttackEvent.from = fromActorTemp;
		adventureActorReceiveAttackEvent.firstFrom = from;
		adventureActorReceiveAttackEvent.to = this;
		adventureActorReceiveAttackEvent.weapon = fromWeaponTemp;
		adventureActorReceiveAttackEvent.hitDamageId = hitDamageIdTemp;
		adventureActorReceiveAttackEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
		adventureActorReceiveAttackEvent.uniqueAttackId = uniqueAttackIdTemp;
		adventureActorReceiveAttackEvent.onceAttackTargetCount = onceAttackTargetCountTemp;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveAttackEvent);
		if (immuneCertainDamageIds.Contains(hitDamageIdTemp))
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		int effectType = hitDamageConfigTemp.EffectType;
		if (effectType == 5 || effectType == 8)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (fromActorTemp == null)
		{
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (!IsAoeHittableByEnemy(fromActorTemp) && !IsAoeHittableByFriend(fromActorTemp))
		{
			HitEffectAndHudDefenceProcess();
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		if (CheckCost_BeHit() || IsCanNotBeHit)
		{
			HitEffectAndHudDefenceProcess();
			return (successed: false, damage: 0L, isPerfectDodge: false);
		}
		switch ((HotfixEnum.damageEffect)hitDamageConfigTemp.EffectType)
		{
		case HotfixEnum.damageEffect.NO_DAMAGE_APPLY_FEATHER_NO_ANI:
			HurtAnimOff();
			isPlayShakeAnim = false;
			PlayDamageEffect(isKill: false, isCrit: false, isToughnessBroken: false, damaged: true);
			HurtAnimOn();
			return (successed: false, damage: 0L, isPerfectDodge: false);
		case HotfixEnum.damageEffect.NO_DAMAGE_APPLY_FEATHER:
		{
			PlayDamageEffect(isKill: false, isCrit: false, isToughnessBroken: false, damaged: true);
			AdventureActorNoDamageEvent adventureActorNoDamageEvent = AdventureActorNoDamageEvent.Generate();
			adventureActorNoDamageEvent.sender = this;
			adventureActorNoDamageEvent.from = fromActorTemp;
			adventureActorNoDamageEvent.firstFrom = from;
			adventureActorNoDamageEvent.to = this;
			adventureActorNoDamageEvent.hitDamageConfigId = hitDamageConfigTemp.Id;
			adventureActorNoDamageEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
			adventureActorNoDamageEvent.uniqueAttackId = uniqueAttackIdTemp;
			adventureActorNoDamageEvent.weapon = fromWeaponTemp;
			if (fromWeaponTemp != null)
			{
				adventureActorNoDamageEvent.weaponTag = fromWeaponTemp.weaponTag;
			}
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorNoDamageEvent);
			return (successed: true, damage: 0L, isPerfectDodge: false);
		}
		default:
		{
			long num = 0L;
			bool isKill = false;
			bool flag = false;
			addEnergyForMainControlTemp = 0;
			if (actorHealthInfo.hp <= 0)
			{
				PlayDamageEffect(isKill, flag, isToughnessBroken: false);
				return (successed: false, damage: 0L, isPerfectDodge: false);
			}
			if (fromActorTemp is PlayerAdventureActor || fromActorTemp.IsPlayerSummoned(out summoner, out var _))
			{
				FDP energy = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.playerSkillCd.GetEnergy();
				FP energy2 = FP.FromMyriad(hitDamageConfigTemp.EnergyCharge);
				SceneSingleton<AdventurePlayerController>.Instance.AddEnergy(uniqueAttackIdTemp, energy2, fromActorTemp, hitDamageConfigTemp.SkillId);
				addEnergyForMainControlTemp = (FP)SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.playerSkillCd.GetEnergy() - (FP)energy;
			}
			ClearOnceAdditionalAttr();
			try
			{
				if (fromWeaponTemp != null)
				{
					List<int> additionalAttrIdList = fromWeaponTemp.additionalAttrIdList;
					if (additionalAttrIdList != null && additionalAttrIdList.Count > 0)
					{
						AddFromAttr(additionalAttrIdList, fromActorTemp);
					}
				}
				if (fromAreaTemp != null)
				{
					List<int> additionalAttrIdList2 = fromAreaTemp.additionalAttrIdList;
					if (additionalAttrIdList2 != null && additionalAttrIdList2.Count > 0)
					{
						AddFromAttr(additionalAttrIdList2, fromActorTemp);
					}
				}
				AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = AdventureActorReceiveDamageBeforeHitEvent.Generate();
				adventureActorReceiveDamageBeforeHitEvent.sender = this;
				adventureActorReceiveDamageBeforeHitEvent.from = fromActorTemp;
				adventureActorReceiveDamageBeforeHitEvent.firstFrom = from;
				adventureActorReceiveDamageBeforeHitEvent.to = this;
				adventureActorReceiveDamageBeforeHitEvent.weapon = fromWeaponTemp;
				adventureActorReceiveDamageBeforeHitEvent.attackType = damageTypeTemp;
				adventureActorReceiveDamageBeforeHitEvent.hitDamageConfigId = hitDamageConfigTemp.Id;
				adventureActorReceiveDamageBeforeHitEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
				adventureActorReceiveDamageBeforeHitEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
				adventureActorReceiveDamageBeforeHitEvent.uniqueAttackId = uniqueAttackIdTemp;
				adventureActorReceiveDamageBeforeHitEvent.onceAttackTargetCount = onceAttackTargetCountTemp;
				adventureActorReceiveDamageBeforeHitEvent.skillSlotType = (HotfixEnum.skillSlotType)hitDamageConfigTemp.SkillSlotType;
				adventureActorReceiveDamageBeforeHitEvent.areaEffectId = areaEffectIdTemp;
				adventureActorReceiveDamageBeforeHitEvent.damageType = (HotfixEnum.damageType)hitDamageConfigTemp.DamageType;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageBeforeHitEvent);
				Recorder.Types.Damage damage = null;
				switch ((HotfixEnum.damageEffect)hitDamageConfigTemp.EffectType)
				{
				case HotfixEnum.damageEffect.PHYSICS:
				case HotfixEnum.damageEffect.MAGIC:
				{
					if (fromActorTemp.isBlindness)
					{
						MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", Id, 1);
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					bool flag2 = toAdditionalAttrInfo.forceMissDamage;
					if (!flag2)
					{
						FDP fDP = fromActorTemp.actorInfo.hitRate;
						if (damageTypeTemp == DamageType.Range)
						{
							fDP = fromWeaponTemp.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.HITRATE);
						}
						else if (damageTypeTemp == DamageType.Area)
						{
							fDP = fromAreaTemp.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.HITRATE);
						}
						FDP y = fromAdditionalAttrInfo.hitRate + fDP;
						y = FDP.Max((FDP)0.25f, y);
						FDP y2 = toAdditionalAttrInfo.evd + actorInfo.evd;
						y2 = FDP.Max(FDP.Zero, y2);
						FDP y3 = y - y2;
						y3 = FDP.Max((FDP)0.25f, y3);
						flag2 = TSRandom.value > (FP)y3;
					}
					if (flag2)
					{
						AdventureActorMissDamageEvent adventureActorMissDamageEvent = AdventureActorMissDamageEvent.Generate();
						adventureActorMissDamageEvent.sender = this;
						adventureActorMissDamageEvent.from = fromActorTemp;
						adventureActorMissDamageEvent.to = this;
						adventureActorMissDamageEvent.weapon = fromWeaponTemp;
						adventureActorMissDamageEvent.attackType = damageTypeTemp;
						adventureActorMissDamageEvent.hitDamageConfigId = hitDamageConfigTemp.Id;
						adventureActorMissDamageEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
						adventureActorMissDamageEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
						adventureActorMissDamageEvent.uniqueAttackId = uniqueAttackIdTemp;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorMissDamageEvent);
						MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", Id, 1);
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					if (damageImmunity)
					{
						AdventureActorImmunityDamageEvent adventureActorImmunityDamageEvent2 = AdventureActorImmunityDamageEvent.Generate();
						adventureActorImmunityDamageEvent2.sender = this;
						adventureActorImmunityDamageEvent2.from = fromActorTemp;
						adventureActorImmunityDamageEvent2.to = this;
						adventureActorImmunityDamageEvent2.weapon = fromWeaponTemp;
						adventureActorImmunityDamageEvent2.attackType = damageTypeTemp;
						adventureActorImmunityDamageEvent2.hitDamageConfigId = hitDamageConfigTemp.Id;
						adventureActorImmunityDamageEvent2.hitDamageTag = hitDamageConfigTemp.DamageTag;
						adventureActorImmunityDamageEvent2.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
						adventureActorImmunityDamageEvent2.uniqueAttackId = uniqueAttackIdTemp;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorImmunityDamageEvent2);
						PlayDamageEffect(isKill: false, isCrit: false, isToughnessBroken: false, damaged: true, HitBox.HurtAnimType.None, ignoreFeature: true);
						MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", Id, 2);
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent2 = AdventureActorReceiveDamageBeforeSettlementEvent.Generate();
					adventureActorReceiveDamageBeforeSettlementEvent2.sender = this;
					adventureActorReceiveDamageBeforeSettlementEvent2.from = fromActorTemp;
					adventureActorReceiveDamageBeforeSettlementEvent2.firstFrom = from;
					adventureActorReceiveDamageBeforeSettlementEvent2.to = this;
					adventureActorReceiveDamageBeforeSettlementEvent2.weapon = fromWeaponTemp;
					adventureActorReceiveDamageBeforeSettlementEvent2.attackType = damageTypeTemp;
					adventureActorReceiveDamageBeforeSettlementEvent2.hitDamageConfigId = hitDamageConfigTemp.Id;
					adventureActorReceiveDamageBeforeSettlementEvent2.hitDamageTag = hitDamageConfigTemp.DamageTag;
					adventureActorReceiveDamageBeforeSettlementEvent2.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
					adventureActorReceiveDamageBeforeSettlementEvent2.uniqueAttackId = uniqueAttackIdTemp;
					adventureActorReceiveDamageBeforeSettlementEvent2.onceAttackTargetCount = onceAttackTargetCountTemp;
					adventureActorReceiveDamageBeforeSettlementEvent2.skillSlotType = (HotfixEnum.skillSlotType)hitDamageConfigTemp.SkillSlotType;
					adventureActorReceiveDamageBeforeSettlementEvent2.damageType = (HotfixEnum.damageType)hitDamageConfigTemp.DamageType;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageBeforeSettlementEvent2);
					if (!actorHealthInfo.isAlive)
					{
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					GetBothAllInfo();
					if (null != fromActorTemp)
					{
						flag = fromAdditionalAttrInfo.forceCrit;
						if (!flag)
						{
							FDP y4 = fromAdditionalAttrInfo.critRate + GetCritRateByDamageType();
							y4 = FDP.Max(FDP.Zero, y4);
							FDP opposeCritRate = toAdditionalAttrInfo.opposeCritRate;
							opposeCritRate = FDP.Max(FDP.Zero, opposeCritRate);
							FDP value = y4 - opposeCritRate;
							value = FDP.Clamp(value, FDP.Zero, FDP.One);
							flag = TSRandom.value <= (FP)value;
						}
						if (flag)
						{
							AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = AdventureActorReceiveCritDamageEvent.Generate();
							adventureActorReceiveCritDamageEvent.sender = this;
							adventureActorReceiveCritDamageEvent.from = fromActorTemp;
							adventureActorReceiveCritDamageEvent.to = this;
							adventureActorReceiveCritDamageEvent.weapon = fromWeaponTemp;
							adventureActorReceiveCritDamageEvent.attackType = damageTypeTemp;
							adventureActorReceiveCritDamageEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
							adventureActorReceiveCritDamageEvent.hitDamageConfigId = hitDamageConfigTemp.Id;
							adventureActorReceiveCritDamageEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
							adventureActorReceiveCritDamageEvent.uniqueAttackId = uniqueAttackIdTemp;
							adventureActorReceiveCritDamageEvent.onceAttackTargetCount = onceAttackTargetCountTemp;
							adventureActorReceiveCritDamageEvent.skillSlotType = (HotfixEnum.skillSlotType)hitDamageConfigTemp.SkillSlotType;
							ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveCritDamageEvent);
						}
						num = CalculateDamage(flag, out damage);
					}
					if (isInteractive)
					{
						ExitInteractive();
					}
					RealDamage(num, flag, damage);
					return (successed: true, damage: num, isPerfectDodge: false);
				}
				case HotfixEnum.damageEffect.REAL:
				{
					if (fromActorTemp.isBlindness)
					{
						MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", Id, 1);
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					if (damageImmunity)
					{
						AdventureActorImmunityDamageEvent adventureActorImmunityDamageEvent = AdventureActorImmunityDamageEvent.Generate();
						adventureActorImmunityDamageEvent.sender = this;
						adventureActorImmunityDamageEvent.from = fromActorTemp;
						adventureActorImmunityDamageEvent.to = this;
						adventureActorImmunityDamageEvent.weapon = fromWeaponTemp;
						adventureActorImmunityDamageEvent.attackType = damageTypeTemp;
						adventureActorImmunityDamageEvent.hitDamageConfigId = hitDamageConfigTemp.Id;
						adventureActorImmunityDamageEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
						adventureActorImmunityDamageEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
						adventureActorImmunityDamageEvent.uniqueAttackId = uniqueAttackIdTemp;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorImmunityDamageEvent);
						PlayDamageEffect(isKill: false, isCrit: false, isToughnessBroken: false, damaged: true, HitBox.HurtAnimType.None, ignoreFeature: true);
						MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", Id, 2);
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = AdventureActorReceiveDamageBeforeSettlementEvent.Generate();
					adventureActorReceiveDamageBeforeSettlementEvent.sender = this;
					adventureActorReceiveDamageBeforeSettlementEvent.from = fromActorTemp;
					adventureActorReceiveDamageBeforeSettlementEvent.firstFrom = from;
					adventureActorReceiveDamageBeforeSettlementEvent.to = this;
					adventureActorReceiveDamageBeforeSettlementEvent.weapon = fromWeaponTemp;
					adventureActorReceiveDamageBeforeSettlementEvent.attackType = damageTypeTemp;
					adventureActorReceiveDamageBeforeSettlementEvent.hitDamageConfigId = hitDamageConfigTemp.Id;
					adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
					adventureActorReceiveDamageBeforeSettlementEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
					adventureActorReceiveDamageBeforeSettlementEvent.uniqueAttackId = uniqueAttackIdTemp;
					adventureActorReceiveDamageBeforeSettlementEvent.onceAttackTargetCount = onceAttackTargetCountTemp;
					adventureActorReceiveDamageBeforeSettlementEvent.damageType = (HotfixEnum.damageType)hitDamageConfigTemp.DamageType;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageBeforeSettlementEvent);
					if (!actorHealthInfo.isAlive)
					{
						return (successed: false, damage: 0L, isPerfectDodge: false);
					}
					GetBothAllInfo();
					num = CalculateDamage(flag, out damage);
					if (isInteractive)
					{
						ExitInteractive();
					}
					RealDamage(num, flag, damage);
					return (successed: true, damage: num, isPerfectDodge: false);
				}
				default:
					return (successed: false, damage: 0L, isPerfectDodge: false);
				}
			}
			finally
			{
				ClearOnceAdditionalAttr();
			}
		}
		}
		void HitEffectAndHudDefenceProcess()
		{
			if (fromWeaponTemp != null && fromWeaponTemp is AdventureBulletBase && !IsNotBlockBullet)
			{
				PlayDamageEffect(isKill: false, isCrit: false, isToughnessBroken: false, damaged: true, HitBox.HurtAnimType.None, ignoreFeature: true);
			}
			if (!isBattleOut && isInvincible)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", Id, 2);
			}
		}
	}

	private FDP GetCritRateByDamageType()
	{
		FDP attributeSetValue = FDP.Zero;
		HotfixEnum.elementType hitDamageElementType = CommonHelper.GetHitDamageElementType(hitDamageConfigTemp, fromActorTemp);
		switch ((HotfixEnum.damageType)hitDamageConfigTemp.DamageType)
		{
		case HotfixEnum.damageType.NORMAL:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.NORMALCRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.SKILL:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SKILLCRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.ULTIMATE:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.ULTRACRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.OTHER:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.OTHERCRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.MARK:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.MARKCRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.PROJECTILE:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.PROJECTILECRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.SUMMON:
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SUMMONCRITRATE, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		}
		CommonHelper.ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType.FINAL_ELEMENTTYPE_DAMAGETYPE_CRITRATE, fromActorTemp, ref attributeSetValue);
		return attributeSetValue;
	}

	protected void RealDamage(long dmg, bool isCrit, Recorder.Types.Damage dmgData)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = AdventureActorReceiveDamageEvent.Generate();
		CopyOnceAttrDict(fromAdditionalAttrDict, adventureActorReceiveDamageEvent.fromOnceAttrIds);
		CopyOnceAttrDict(toAdditionalAttrDict, adventureActorReceiveDamageEvent.toOnceAttrIds);
		if (this is MonsterAdventureActor && fromActorTemp is MonsterAdventureActor && this.IsConfrontWith(fromActorTemp))
		{
			lastAttackMonster = fromActorTemp;
		}
		bool flag = false;
		long num = dmg;
		long num2 = 0L;
		long num3 = 0L;
		long a = dmg;
		long value = dmg;
		bool flag2 = false;
		int bossLevel = 0;
		long num4 = actorHealthInfo.hp;
		long num5 = dmg;
		if (actorShield != null)
		{
			num5 = actorShield.DamageToShield(dmg, fromActorTemp);
			num2 = dmg - num5;
		}
		num = num5;
		if (num5 > 0)
		{
			num4 = actorHealthInfo.hp - num5;
			if (isHpLocked)
			{
				if (actorHealthInfo.hp > lockedHp)
				{
					num4 = ((num4 >= lockedHp) ? num4 : lockedHp);
					num = (int)(actorHealthInfo.hp - num4);
				}
				else
				{
					num4 = actorHealthInfo.hp;
					num = 0L;
				}
				a = num + num2;
				value = num + num2;
			}
		}
		if (num4 <= 0)
		{
			if (this is MonsterAdventureActor { HasBattleLevelUp: not false } monsterAdventureActor)
			{
				int num6 = 0;
				while (num4 <= 0)
				{
					monsterAdventureActor.BattleLevel++;
					num4 = monsterAdventureActor.actorHealthInfo.hp + num4;
					num6++;
				}
				if (num6 > 100)
				{
					NovaLogger.Error($"bossrush怪物单次伤害导致升级过快，升了:{num6}级");
				}
				flag2 = true;
				bossLevel = monsterAdventureActor.BattleLevel;
			}
			else
			{
				flag = true;
				num = (int)actorHealthInfo.hp;
			}
		}
		if (flag)
		{
			AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = AdventureActorReceiveDamageCanCauseDeadEvent.Generate();
			adventureActorReceiveDamageCanCauseDeadEvent.sender = this;
			adventureActorReceiveDamageCanCauseDeadEvent.from = fromActorTemp;
			adventureActorReceiveDamageCanCauseDeadEvent.to = this;
			adventureActorReceiveDamageCanCauseDeadEvent.weapon = fromWeaponTemp;
			adventureActorReceiveDamageCanCauseDeadEvent.attackType = damageTypeTemp;
			adventureActorReceiveDamageCanCauseDeadEvent.value = dmg;
			adventureActorReceiveDamageCanCauseDeadEvent.isCrit = isCrit;
			adventureActorReceiveDamageCanCauseDeadEvent.isDodge = false;
			adventureActorReceiveDamageCanCauseDeadEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
			adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
			adventureActorReceiveDamageCanCauseDeadEvent.uniqueAttackId = uniqueAttackIdTemp;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageCanCauseDeadEvent);
		}
		if (flag && isDeadImmunity)
		{
			ExcuteDeadImmunity(fromActorTemp, this, fromWeaponTemp, damageTypeTemp, dmg, isCrit, isDodge: false, (HotfixEnum.elementType)hitDamageConfigTemp.ElementType);
			flag = false;
			num4 = actorHealthInfo.hp;
			num = 0L;
		}
		if (showHudTemp)
		{
			bool a2 = hitDamageConfigTemp.DamageType == 5;
			if (this is SoldierActor soldierActor)
			{
				hudColorIndexTemp = (soldierActor.isEnemyCamp ? 3 : 2);
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("HudDamage", Id, a, isCrit, hitDamageConfigTemp, fromActorTemp.Id, a2, (int)fromActorTemp.actorElementInfo.elementType, hudColorIndexTemp);
		}
		bool isToughnessBroken = false;
		if (this is MonsterAdventureActor monsterAdventureActor2)
		{
			num3 = (FDP.FromLong(value) * fromAdditionalAttrInfo.toughnessDamageRatio).AsLong();
			num3 = math.max(0L, num3);
			isToughnessBroken = monsterAdventureActor2.monsterToughnessInfo.DamageToToughness(fromActorTemp, num3, hitDamageConfigTemp.DamageTag);
		}
		if (flag)
		{
			actorHealthInfo.hp = 0L;
		}
		else
		{
			actorHealthInfo.hp = num4;
		}
		if (num != 0L)
		{
			AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
			adventureActorHpChangedEvent.sender = this;
			adventureActorHpChangedEvent.currentHp = actorHealthInfo.hp;
			adventureActorHpChangedEvent.maxHp = actorHealthInfo.hpMax;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
		}
		if (isSleep)
		{
			InterruptSleep();
		}
		bool flag3 = PlayDamageEffect(flag, isCrit, isToughnessBroken, damaged: true, (!(hitboxTemp == null)) ? hitboxTemp.hurtAnimType : HitBox.HurtAnimType.None);
		if (this is PlayerAdventureActor)
		{
			if (!flag3)
			{
				if (_akAudio == null)
				{
					_akAudio = GetComponent<AkAnimatorAudio>();
				}
				AkAnimatorAudio.State state = AkAnimatorAudio.State.Hurt_None;
				switch (hitboxTemp.hurtAnimType)
				{
				case HitBox.HurtAnimType.Small:
					state = AkAnimatorAudio.State.Hurt_Samll1;
					if (TSRandom.value <= 0.5)
					{
						state = AkAnimatorAudio.State.Hurt_Samll2;
					}
					break;
				case HitBox.HurtAnimType.Large:
					state = AkAnimatorAudio.State.Hurt_Large;
					break;
				}
				_akAudio.OnStateEnter(state);
			}
			if (!onHurtEffectCD)
			{
				StartHurtEffectCD();
				AdventureFXManager.PlayFX(ModuleController<AdventureModuleController>.Instance.sharedConfigureData.Actor_hit_effect, 1f, Vector3.zero, transform.rotation);
			}
		}
		bool flag4 = this is MonsterAdventureActor monsterAdventureActor3 && monsterAdventureActor3.ToughnessBrokenToIdle;
		if (this.state == ActorState.Idle && !flag4)
		{
			Action();
		}
		AdventureActorReceiveDamageForEffectEvent adventureActorReceiveDamageForEffectEvent = AdventureActorReceiveDamageForEffectEvent.Generate();
		adventureActorReceiveDamageForEffectEvent.sender = this;
		adventureActorReceiveDamageForEffectEvent.from = fromActorTemp;
		adventureActorReceiveDamageForEffectEvent.to = this;
		adventureActorReceiveDamageForEffectEvent.weapon = fromWeaponTemp;
		adventureActorReceiveDamageForEffectEvent.attackType = damageTypeTemp;
		adventureActorReceiveDamageForEffectEvent.damage = dmg;
		adventureActorReceiveDamageForEffectEvent.damageToShieldAndHp = num2 + num;
		adventureActorReceiveDamageForEffectEvent.damageToHp = num;
		adventureActorReceiveDamageForEffectEvent.isCrit = isCrit;
		adventureActorReceiveDamageForEffectEvent.isDodge = false;
		adventureActorReceiveDamageForEffectEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
		adventureActorReceiveDamageForEffectEvent.isKill = flag;
		adventureActorReceiveDamageForEffectEvent.damageShield = num5 <= 0;
		adventureActorReceiveDamageForEffectEvent.hitDamageId = hitDamageConfigTemp.Id;
		adventureActorReceiveDamageForEffectEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
		adventureActorReceiveDamageForEffectEvent.uniqueAttackId = uniqueAttackIdTemp;
		adventureActorReceiveDamageForEffectEvent.onceAttackTargetCount = onceAttackTargetCountTemp;
		adventureActorReceiveDamageForEffectEvent.skillSlotType = (HotfixEnum.skillSlotType)hitDamageConfigTemp.SkillSlotType;
		adventureActorReceiveDamageForEffectEvent.areaEffectId = areaEffectIdTemp;
		adventureActorReceiveDamageForEffectEvent.skillId = hitDamageConfigTemp.SkillId;
		adventureActorReceiveDamageForEffectEvent.isEnterLostCtr = !isEnterLostCtr && isLostControl;
		adventureActorReceiveDamageForEffectEvent.lostControlType = curCtrType;
		adventureActorReceiveDamageForEffectEvent.damageToughness = num3;
		adventureActorReceiveDamageForEffectEvent.damageType = (HotfixEnum.damageType)hitDamageConfigTemp.DamageType;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageForEffectEvent);
		adventureActorReceiveDamageEvent.sender = this;
		adventureActorReceiveDamageEvent.from = fromActorTemp;
		adventureActorReceiveDamageEvent.to = this;
		adventureActorReceiveDamageEvent.weapon = fromWeaponTemp;
		adventureActorReceiveDamageEvent.attackType = damageTypeTemp;
		adventureActorReceiveDamageEvent.damage = dmg;
		adventureActorReceiveDamageEvent.damageToShieldAndHp = num2 + num;
		adventureActorReceiveDamageEvent.damageToHp = num;
		adventureActorReceiveDamageEvent.isCrit = isCrit;
		adventureActorReceiveDamageEvent.isDodge = false;
		adventureActorReceiveDamageEvent.elementType = (HotfixEnum.elementType)hitDamageConfigTemp.ElementType;
		adventureActorReceiveDamageEvent.isKill = flag;
		adventureActorReceiveDamageEvent.damageShield = num5 <= 0;
		adventureActorReceiveDamageEvent.hitDamageId = hitDamageConfigTemp.Id;
		adventureActorReceiveDamageEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
		adventureActorReceiveDamageEvent.uniqueAttackId = uniqueAttackIdTemp;
		adventureActorReceiveDamageEvent.onceAttackTargetCount = onceAttackTargetCountTemp;
		adventureActorReceiveDamageEvent.skillSlotType = (HotfixEnum.skillSlotType)hitDamageConfigTemp.SkillSlotType;
		adventureActorReceiveDamageEvent.areaEffectId = areaEffectIdTemp;
		adventureActorReceiveDamageEvent.skillId = hitDamageConfigTemp.SkillId;
		adventureActorReceiveDamageEvent.isEnterLostCtr = !isEnterLostCtr && isLostControl;
		adventureActorReceiveDamageEvent.lostControlType = curCtrType;
		adventureActorReceiveDamageEvent.damageToughness = (int)num3;
		adventureActorReceiveDamageEvent.damageType = (HotfixEnum.damageType)hitDamageConfigTemp.DamageType;
		adventureActorReceiveDamageEvent.addEnergyForMainControl = addEnergyForMainControlTemp;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageEvent);
		if (ModuleController<AdventureModuleController>.Instance.uploadDamageData && IsRecordActor(this))
		{
			if (isHpLocked)
			{
				dmgData.DmgFlag |= 4u;
			}
			if (num2 > 0)
			{
				dmgData.DmgFlag |= 2u;
			}
			dmgData.FinalValue = num;
			if (flag2)
			{
				ModuleController<AdventureModuleController>.Instance.RecordBossRushBossLevelUp(this, actorHealthInfo.hp, actorHealthInfo.hpMax, bossLevel);
			}
		}
		if (flag)
		{
			Death(fromActorTemp, hitDamageConfigTemp.DamageTag, hitboxTemp, uniqueAttackIdTemp, DeadType.NormalDmgkill);
		}
	}

	protected bool PlayDamageEffect(bool isKill, bool isCrit, bool isToughnessBroken, bool damaged = false, HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.None, bool ignoreFeature = false)
	{
		bool flag = false;
		bool flag2 = false;
		if (!ignoreFeature && null != hitboxTemp && hitboxTemp.featureData != null)
		{
			FP fP = 0;
			if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.DamageFreezeFrame) == HitBox.FeatureFlag.DamageFreezeFrame && (fromActorTemp is PlayerAdventureActor || this is PlayerAdventureActor))
			{
				AdventureModuleConfigureData sharedConfigureData = ModuleController<AdventureModuleController>.Instance.sharedConfigureData;
				bool iLoacl = hitboxTemp.featureData._freezeFrameType == HitBox.FreezeFrameType.Local || hitboxTemp.featureData._freezeFrameType == HitBox.FreezeFrameType.Personalize;
				if (isKill && sharedConfigureData.FX_DefaultFreezeFrameWhenKill > FP.Zero && sharedConfigureData.FX_DefaultFreezeFrameTimeScaleWhenKill >= 0)
				{
					fP = sharedConfigureData.FX_DefaultFreezeFrameWhenKill;
					EnterFreezeFrame(iLoacl, sharedConfigureData.FX_DefaultFreezeFrameTimeScaleWhenKill, fP);
				}
				else if (hitboxTemp.featureData._freezeFrameType == HitBox.FreezeFrameType.Personalize)
				{
					FP aDuration = 0;
					FP aTimeScale = 0;
					FP fP2 = 0;
					FP bTimeScale = 0;
					if (isToughnessBroken && (hitboxTemp.featureData.aFreezeFrameWhenToughnessBroken > 0 || hitboxTemp.featureData.bFreezeFrameWhenToughnessBroken > 0))
					{
						aDuration = hitboxTemp.featureData.aFreezeFrameWhenToughnessBroken;
						aTimeScale = hitboxTemp.featureData.aFreezeFrameTimeScaleWhenToughnessBroken;
						fP2 = hitboxTemp.featureData.bFreezeFrameWhenToughnessBroken;
						bTimeScale = hitboxTemp.featureData.bFreezeFrameTimeScaleWhenToughnessBroken;
					}
					else if (isCrit && (hitboxTemp.featureData.aFreezeFrameWhenCrit > 0 || hitboxTemp.featureData.bFreezeFrameWhenCrit > 0))
					{
						aDuration = hitboxTemp.featureData.aFreezeFrameWhenCrit;
						aTimeScale = hitboxTemp.featureData.aFreezeFrameTimeScaleWhenCrit;
						fP2 = hitboxTemp.featureData.bFreezeFrameWhenCrit;
						bTimeScale = hitboxTemp.featureData.bFreezeFrameTimeScaleWhenCrit;
					}
					else if (hitboxTemp.featureData.aFreezeFrameWhenDamage > 0 || hitboxTemp.featureData.bFreezeFrameWhenDamage > 0)
					{
						aDuration = hitboxTemp.featureData.aFreezeFrameWhenDamage;
						aTimeScale = hitboxTemp.featureData.aFreezeFrameTimeScaleWhenDamage;
						fP2 = hitboxTemp.featureData.bFreezeFrameWhenDamage;
						bTimeScale = hitboxTemp.featureData.bFreezeFrameTimeScaleWhenDamage;
					}
					EnterFreezeFramePer(aTimeScale, aDuration, bTimeScale, fP2);
					fP = fP2;
				}
				else
				{
					if (isToughnessBroken && hitboxTemp.featureData.FreezeFrameWhenToughnessBroken != FP.Zero)
					{
						fP = ((hitboxTemp.featureData.FreezeFrameWhenToughnessBroken < FP.Zero) ? sharedConfigureData.FX_DefaultFreezeFrameWhenToughnessBroken : hitboxTemp.featureData.FreezeFrameWhenToughnessBroken);
					}
					else if (isCrit && hitboxTemp.featureData.FreezeFrameWhenCrit != FP.Zero)
					{
						fP = ((hitboxTemp.featureData.FreezeFrameWhenCrit < FP.Zero) ? sharedConfigureData.FX_DefaultFreezeFrameWhenCrit : hitboxTemp.featureData.FreezeFrameWhenCrit);
					}
					else if (hitboxTemp.featureData.FreezeFrameWhenDamage != FP.Zero)
					{
						fP = ((hitboxTemp.featureData.FreezeFrameWhenDamage < FP.Zero) ? sharedConfigureData.FX_DefaultFreezeFrameWhenDamage : hitboxTemp.featureData.FreezeFrameWhenDamage);
					}
					EnterFreezeFrame(iLoacl, 0, fP);
				}
			}
			if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.Stiff) == HitBox.FeatureFlag.Stiff && EnterStiff(hitboxTemp.featureData.hitStrenth, hitboxTemp.featureData.StiffDuration - fP, fromActorTemp))
			{
				flag = true;
				curCtrType |= LostControlType.Stiff;
			}
			if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.KnockBack) == HitBox.FeatureFlag.KnockBack)
			{
				HitBox.HitBoxFeatureData featureData = hitboxTemp.featureData;
				TSVector2 direction;
				if (featureData.UseAtttackForward)
				{
					direction = hitboxTemp.context.QueryHitBoxContextDirection();
				}
				else
				{
					TSVector2 tSVector = (featureData.UseHitBoxPosition ? hitboxTemp.hitPos : hitboxTemp.context.QueryHitBoxContextPosition());
					direction = ((!hitboxTemp.CheckWithInRing(this)) ? (tsTransform.Position - tSVector).normalized : (tSVector - tsTransform.Position).normalized);
				}
				FP distance = featureData.KnockBackDistance * (1 + knockBackDistancePercentTemp / 100L);
				if (KnockBack(direction, featureData.KnockBackForce, distance, featureData.hitStrenth, hurtAnimType, fromActorTemp) != null)
				{
					if (!forbiddenBehitRot && !isHurtAnimOff && hurtAnimType == HitBox.HurtAnimType.Large)
					{
						ForceChangeDirection((fromActorTemp.tsTransform.Position - tsTransform.Position).normalized);
					}
					flag = true;
					curCtrType |= LostControlType.KnockBack;
				}
			}
			if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.AirBorne) == HitBox.FeatureFlag.AirBorne)
			{
				if (AirBorne(hitboxTemp.featureData.KnockOutForce, hitboxTemp.featureData.hitStrenth, hurtAnimType, fromActorTemp))
				{
					if (!forbiddenBehitRot && !isHurtAnimOff && hurtAnimType == HitBox.HurtAnimType.Large)
					{
						ForceChangeDirection((fromActorTemp.tsTransform.Position - tsTransform.Position).normalized);
					}
					flag = true;
					curCtrType |= LostControlType.AirBorne;
				}
				else
				{
					AirBorneDamageFalseEvent airBorneDamageFalseEvent = AirBorneDamageFalseEvent.Generate();
					airBorneDamageFalseEvent.sender = this;
					airBorneDamageFalseEvent.from = fromActorTemp;
					airBorneDamageFalseEvent.to = this;
					airBorneDamageFalseEvent.weapon = fromWeaponTemp;
					airBorneDamageFalseEvent.hitDamageTag = hitDamageConfigTemp.DamageTag;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(airBorneDamageFalseEvent);
				}
			}
			if (damaged)
			{
				if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.AddBuffForSelf) == HitBox.FeatureFlag.AddBuffForSelf)
				{
					List<int> buffIdsForSelf = hitboxTemp.featureData.buffIdsForSelf;
					if (buffIdsForSelf != null && buffIdsForSelf.Count > 0 && fromActorTemp != null)
					{
						BuffCom logicComponent = fromActorTemp.GetLogicComponent<BuffCom>();
						if (logicComponent != null)
						{
							for (int i = 0; i < hitboxTemp.featureData.buffIdsForSelf.Count; i++)
							{
								logicComponent.AddBuff(hitboxTemp.featureData.buffIdsForSelf.get_Item(i), fromActorTemp);
							}
						}
					}
				}
				if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.AddBuffForTarget) == HitBox.FeatureFlag.AddBuffForTarget)
				{
					List<int> buffIdsForSelf = hitboxTemp.featureData.buffIdsForTarget;
					if (buffIdsForSelf != null && buffIdsForSelf.Count > 0)
					{
						BuffCom logicComponent2 = GetLogicComponent<BuffCom>();
						if (logicComponent2 != null)
						{
							for (int j = 0; j < hitboxTemp.featureData.buffIdsForTarget.Count; j++)
							{
								logicComponent2.AddBuff(hitboxTemp.featureData.buffIdsForTarget.get_Item(j), fromActorTemp);
							}
						}
					}
				}
				if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.RemoveBuffForSelf) == HitBox.FeatureFlag.RemoveBuffForSelf)
				{
					List<int> buffIdsForSelf = hitboxTemp.featureData.removeBuffIdsForSelf;
					if (buffIdsForSelf != null && buffIdsForSelf.Count > 0 && fromActorTemp != null)
					{
						BuffCom logicComponent3 = fromActorTemp.GetLogicComponent<BuffCom>();
						if (logicComponent3 != null)
						{
							for (int k = 0; k < hitboxTemp.featureData.removeBuffIdsForSelf.Count; k++)
							{
								if (logicComponent3.RemoveBuffByBuffId(hitboxTemp.featureData.removeBuffIdsForSelf.get_Item(k)))
								{
									AdventureActorRemoveBuffWhenHittingEvent adventureActorRemoveBuffWhenHittingEvent = AdventureActorRemoveBuffWhenHittingEvent.Generate();
									adventureActorRemoveBuffWhenHittingEvent.sender = this;
									adventureActorRemoveBuffWhenHittingEvent.entity = fromActorTemp;
									adventureActorRemoveBuffWhenHittingEvent.buffId = hitboxTemp.featureData.removeBuffIdsForSelf.get_Item(k);
									ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorRemoveBuffWhenHittingEvent);
								}
							}
						}
					}
				}
				if ((hitboxTemp.featureFlags & HitBox.FeatureFlag.RemoveBuffForTarget) == HitBox.FeatureFlag.RemoveBuffForTarget)
				{
					List<int> buffIdsForSelf = hitboxTemp.featureData.removeBuffIdsForTarget;
					if (buffIdsForSelf != null && buffIdsForSelf.Count > 0)
					{
						BuffCom logicComponent4 = GetLogicComponent<BuffCom>();
						if (logicComponent4 != null)
						{
							for (int l = 0; l < hitboxTemp.featureData.removeBuffIdsForTarget.Count; l++)
							{
								logicComponent4.RemoveBuffByBuffId(hitboxTemp.featureData.removeBuffIdsForTarget.get_Item(l));
							}
						}
					}
				}
			}
		}
		if (!isHurtAnimOff && hitboxTemp != null && ((damageTypeTemp == DamageType.Melee || damageTypeTemp == DamageType.Range || damageTypeTemp == DamageType.Area) & flag) && hitboxTemp.hurtAnimType != HitBox.HurtAnimType.None)
		{
			int hurtAniTag = 0;
			if (hitboxTemp.hurtAnimType == HitBox.HurtAnimType.Small)
			{
				hurtAniTag = 1;
				if (TSRandom.value <= 0.5)
				{
					hurtAniTag = 2;
				}
			}
			else if (!forbiddenBehitRot)
			{
				ForceChangeDirection((fromActorTemp.tsTransform.Position - tsTransform.Position).normalized);
			}
			PlayHurtAnim(hurtAniTag);
			flag2 = true;
		}
		Vector3 capsuleColliderBoundPosition = this.GetCapsuleColliderBoundPosition(fromActorTemp, out var rotation);
		GameObject hurtEffectSource = fromEntityTemp.gameObject;
		if (hitboxTemp != null && hitboxTemp.hurtEffectSource != null)
		{
			hurtEffectSource = hitboxTemp.hurtEffectSource;
		}
		if (!string.IsNullOrEmpty(specialHurtFx))
		{
			GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(this, specialHurtFx);
			if (fxByAlias != null)
			{
				hurtEffectPrefabTemp = fxByAlias;
			}
		}
		PlayHurtCueEffect(hurtEffectSource, hurtEffectPrefabTemp, isHittedEffectScaleTemp, playFlashTint: false, capsuleColliderBoundPosition, rotation, HotfixEnum.hurtFlashTintType.NONE, effectIgnoreTimeScaleTemp);
		GameObject fxByAlias2 = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(this, comboGroup?.commonHittedEffectAlias);
		if (fxByAlias2 != null)
		{
			PlayHurtCueEffect(hurtEffectSource, fxByAlias2, isHittedEffectScaleTemp, playFlashTint: false, dtCollider.colliderCenter, rotation, HotfixEnum.hurtFlashTintType.NONE, effectIgnoreTimeScaleTemp);
		}
		HotfixEnum.hurtFlashTintType flashTintType = ((this is MonsterAdventureActor) ? ((!flag2) ? HotfixEnum.hurtFlashTintType.EDGE : HotfixEnum.hurtFlashTintType.WHOLE) : ((this is DestructibleStateSingle) ? HotfixEnum.hurtFlashTintType.WHOLE : HotfixEnum.hurtFlashTintType.NONE));
		PlayShakeFlashEffect(flashTintType);
		return flag2;
	}

	private void PlayShakeFlashEffect(HotfixEnum.hurtFlashTintType flashTintType = HotfixEnum.hurtFlashTintType.NONE)
	{
		if (isPlayShakeAnim)
		{
			PlayShakeAnim();
		}
		bool effectIgnoreTimeScale = effectIgnoreTimeScaleTemp;
		PlayHurtCueEffect(null, null, isHurtEffectScale: true, playFlashTint: true, default, default, flashTintType, effectIgnoreTimeScale);
	}

	public void DirectDamage(long damage, string tag, long fromActorId, bool showHud = true, GameObject healFxEffect = null, GameObject hurtEffectPrefab = null, bool isHurtEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		if (this is PlayerAdventureActor { isAssist: not false } || !ModuleController<AdventureModuleController>.Instance.InBattleState || damage <= 0 || isInvincible)
		{
			return;
		}
		AdventureActor adventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(fromActorId) as AdventureActor;
		if (adventureActor == null)
		{
			return;
		}
		bool flag = false;
		long num = damage;
		long num2 = 0L;
		long num3 = 0L;
		long a = damage;
		long value = damage;
		bool flag2 = false;
		int bossLevel = 0;
		long num4 = actorHealthInfo.hp;
		long num5 = damage;
		if (actorShield != null)
		{
			num5 = actorShield.DamageToShield(damage, adventureActor);
			num2 = damage - num5;
		}
		num = num5;
		if (num5 > 0)
		{
			num4 = actorHealthInfo.hp - num5;
			if (isHpLocked)
			{
				if (actorHealthInfo.hp > lockedHp)
				{
					num4 = ((num4 >= lockedHp) ? num4 : lockedHp);
					num = (int)(actorHealthInfo.hp - num4);
				}
				else
				{
					num4 = actorHealthInfo.hp;
					num = 0L;
				}
				a = num + num2;
				value = num + num2;
			}
		}
		if (num4 <= 0)
		{
			if (this is MonsterAdventureActor { HasBattleLevelUp: not false } monsterAdventureActor)
			{
				int num6 = 0;
				while (num4 <= 0)
				{
					monsterAdventureActor.BattleLevel++;
					num4 = monsterAdventureActor.actorHealthInfo.hp + num4;
					num6++;
				}
				if (num6 > 100)
				{
					NovaLogger.Error($"bossrush怪物单次伤害导致升级过快，升了:{num6}级");
				}
				flag2 = true;
				bossLevel = monsterAdventureActor.BattleLevel;
			}
			else
			{
				flag = true;
				num = (int)actorHealthInfo.hp;
			}
		}
		if (flag)
		{
			AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = AdventureActorReceiveDamageCanCauseDeadEvent.Generate();
			adventureActorReceiveDamageCanCauseDeadEvent.sender = this;
			adventureActorReceiveDamageCanCauseDeadEvent.from = adventureActor;
			adventureActorReceiveDamageCanCauseDeadEvent.to = this;
			adventureActorReceiveDamageCanCauseDeadEvent.weapon = null;
			adventureActorReceiveDamageCanCauseDeadEvent.attackType = DamageType.None;
			adventureActorReceiveDamageCanCauseDeadEvent.value = damage;
			adventureActorReceiveDamageCanCauseDeadEvent.isCrit = false;
			adventureActorReceiveDamageCanCauseDeadEvent.isDodge = false;
			adventureActorReceiveDamageCanCauseDeadEvent.elementType = HotfixEnum.elementType.NONE;
			adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag = null;
			adventureActorReceiveDamageCanCauseDeadEvent.uniqueAttackId = 0L;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageCanCauseDeadEvent);
		}
		if (flag && isDeadImmunity)
		{
			ExcuteDeadImmunity(adventureActor, this, null, DamageType.None, damage);
			flag = false;
			num4 = actorHealthInfo.hp;
			num = 0L;
		}
		ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(this, num, Recorder.Types.DamageType.Direct, isHpLocked, num2 > 0);
		if (flag2)
		{
			ModuleController<AdventureModuleController>.Instance.RecordBossRushBossLevelUp(this, actorHealthInfo.hp, actorHealthInfo.hpMax, bossLevel);
		}
		if (flag)
		{
			actorHealthInfo.hp = 0L;
		}
		else
		{
			actorHealthInfo.hp = num4;
		}
		if (showHud)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("HudDamage", Id, a, a3: false, a4: false, fromActorId, a6: false);
		}
		if (num != 0L)
		{
			AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
			adventureActorHpChangedEvent.sender = this;
			adventureActorHpChangedEvent.currentHp = actorHealthInfo.hp;
			adventureActorHpChangedEvent.maxHp = actorHealthInfo.hpMax;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
		}
		if (isSleep)
		{
			InterruptSleep();
		}
		MonsterAdventureActor monsterAdventureActor2 = this as MonsterAdventureActor;
		if (monsterAdventureActor2 != null && adventureActor != null && adventureActor is PlayerAdventureActor)
		{
			num3 = (FDP.FromLong(value) * adventureActor.actorInfo.toughnessDamageRatio).AsLong();
			num3 = math.max(0L, num3);
			monsterAdventureActor2.monsterToughnessInfo.DamageToToughness(adventureActor, num3);
		}
		Vector3 capsuleColliderBoundPosition = this.GetCapsuleColliderBoundPosition(adventureActor, out var rotation);
		GameObject source = ((adventureActor != null) ? adventureActor.gameObject : null);
		PlayHurtCueEffect(source, hurtEffectPrefab, isHurtEffectScale, playFlashTint: false, capsuleColliderBoundPosition, rotation, HotfixEnum.hurtFlashTintType.NONE, effectIgnoreTimeScale);
		AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent = AdventureActorReceiveDirectEvent.Generate();
		adventureActorReceiveDirectEvent.fromId = fromActorId;
		adventureActorReceiveDirectEvent.from = adventureActor;
		adventureActorReceiveDirectEvent.to = this;
		adventureActorReceiveDirectEvent.damage = damage;
		adventureActorReceiveDirectEvent.damageToShieldAndHp = num2 + num;
		adventureActorReceiveDirectEvent.damageToHp = num;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDirectEvent);
		if (flag)
		{
			Death(adventureActor, null, null, 0, DeadType.DirectDmgKill);
			DirectDamageKillEvent directDamageKillEvent = DirectDamageKillEvent.Generate();
			directDamageKillEvent.sender = this;
			directDamageKillEvent.tag = tag;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(directDamageKillEvent);
		}
	}

	public void DirectHeal(int value, bool showHud)
	{
		if (value > 0 && actorHealthInfo.isAlive)
		{
			actorHealthInfo.hp += value;
			ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(this, value, Recorder.Types.DamageType.DirectHeal);
			AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
			adventureActorHpChangedEvent.sender = this;
			adventureActorHpChangedEvent.currentHp = actorHealthInfo.hp;
			adventureActorHpChangedEvent.maxHp = actorHealthInfo.hpMax;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
			if (showHud)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", Id, value);
			}
		}
	}

	public bool Kill(LogicEntity from, GameObject hurtEffectPrefab = null, HitBox.FeatureFlag hitboxFeatureFlags = HitBox.FeatureFlag.None, HitBox.HitBoxFeatureData hitboxFeatureData = null, bool isHurtEffectScale = true, IList<int> damageTag = null, bool effectIgnoreTimeScale = true)
	{
		if (state == ActorState.Spawn)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		if (killImmunity)
		{
			return false;
		}
		if (isInvincible)
		{
			return false;
		}
		if (from != null)
		{
			fromActorTemp = from.GetComponent<AdventureActor>();
			fromWeaponTemp = from.GetComponent<AdventureWeapon>();
			fromAreaTemp = from.GetComponent<AreaEffectEntity>();
		}
		if (fromWeaponTemp != null)
		{
			fromActorTemp = fromWeaponTemp.owner as AdventureActor;
		}
		else if (fromAreaTemp != null)
		{
			fromActorTemp = fromAreaTemp.owner;
		}
		if (fromActorTemp == null)
		{
			return false;
		}
		AdventureActorReceiveKillEvent adventureActorReceiveKillEvent = AdventureActorReceiveKillEvent.Generate();
		adventureActorReceiveKillEvent.sender = this;
		adventureActorReceiveKillEvent.from = fromActorTemp;
		adventureActorReceiveKillEvent.to = this;
		adventureActorReceiveKillEvent.curValue = (int)actorHealthInfo.hp;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveKillEvent);
		effectIgnoreTimeScaleTemp = effectIgnoreTimeScale;
		actorHealthInfo.hp = 0L;
		Death(fromActorTemp, damageTag, hitBox, 0, DeadType.Kill);
		Vector3 capsuleColliderBoundPosition = this.GetCapsuleColliderBoundPosition(null, out var rotation);
		PlayHurtCueEffect((from != null) ? from.gameObject : null, hurtEffectPrefab, isHurtEffectScale, playFlashTint: true, capsuleColliderBoundPosition, rotation, HotfixEnum.hurtFlashTintType.NONE, effectIgnoreTimeScaleTemp);
		if ((hitboxFeatureFlags & HitBox.FeatureFlag.DamageFreezeFrame) != HitBox.FeatureFlag.DamageFreezeFrame || hitboxFeatureData == null)
		{
			return true;
		}
		AdventureModuleConfigureData sharedConfigureData = ModuleController<AdventureModuleController>.Instance.sharedConfigureData;
		if (actorHealthInfo.isAlive || sharedConfigureData.FX_DefaultFreezeFrameWhenKill <= FP.Zero || sharedConfigureData.FX_DefaultFreezeFrameTimeScaleWhenKill < 0)
		{
			return true;
		}
		HitBox.FreezeFrameType freezeFrameType = hitboxTemp.featureData._freezeFrameType;
		bool iLoacl = freezeFrameType == HitBox.FreezeFrameType.Local || freezeFrameType == HitBox.FreezeFrameType.Personalize;
		EnterFreezeFrame(iLoacl, sharedConfigureData.FX_DefaultFreezeFrameTimeScaleWhenKill, sharedConfigureData.FX_DefaultFreezeFrameWhenKill);
		return true;
	}

	public bool DestroySelf(bool forceDestory = false)
	{
		if (!forceDestory)
		{
			if (state == ActorState.Spawn)
			{
				return false;
			}
			if (!actorHealthInfo.isAlive)
			{
				return false;
			}
		}
		actorHealthInfo.hp = 0L;
		Death(this, null, null, 0, DeadType.DestorySelf);
		return true;
	}

	public bool ClearMonsterSelf()
	{
		if (state == ActorState.Spawn)
		{
			return false;
		}
		if (!(this is MonsterAdventureActor) || !actorHealthInfo.isAlive)
		{
			return false;
		}
		return ClearSelf();
	}

	private void EnterFreezeFrame(bool iLoacl, FP timeScale, FP duration)
	{
		if (duration <= 0)
		{
			return;
		}
		if (iLoacl && !ModuleController<AdventureModuleController>.Instance.InGlobalFreezeFrame())
		{
			LogicTimeScale(timeScale, duration, AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
			if (fromWeaponTemp != null)
			{
				fromWeaponTemp.LogicTimeScale(timeScale, duration, AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
			}
			else if (fromActorTemp != null)
			{
				fromActorTemp.LogicTimeScale(timeScale, duration, AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
			}
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(timeScale, duration);
		}
	}

	private void EnterFreezeFramePer(FP aTimeScale, FP aDuration, FP bTimeScale, FP bDuration)
	{
		if (ModuleController<AdventureModuleController>.Instance.InGlobalFreezeFrame())
		{
			return;
		}
		if (bDuration > 0)
		{
			LogicTimeScale(bTimeScale, bDuration, AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
		}
		if (!(aDuration <= 0))
		{
			if (fromWeaponTemp != null)
			{
				fromWeaponTemp.LogicTimeScale(aTimeScale, aDuration, AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
			}
			else if (fromActorTemp != null)
			{
				fromActorTemp.LogicTimeScale(aTimeScale, aDuration, AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
			}
		}
	}

	protected virtual void InitializeFXControl()
	{
		selfFXHandler?.Initialize();
	}

	internal void StopFXBeforeDied()
	{
		selfFXHandler?.StopFXOnDied();
	}

	internal void StopFXOnDied()
	{
		StopSuperArmorCueEffect();
		StopImmuneControlCueEffect();
		StopInvincibleCueEffect();
	}

	public void PlayFX(string effectName, float? playbackSpeed = null, ActorState actorState = ActorState.Null, Combo combo = null, Combo.Phase comboPhase = Combo.Phase.All, bool cancelOnInterrupt = false)
	{
		if (!string.IsNullOrEmpty(effectName))
		{
			selfFXHandler?.PlayFX(effectName, playbackSpeed, actorState, combo, comboPhase, cancelOnInterrupt);
		}
	}

	public void StopFX(string effectName)
	{
		if (!string.IsNullOrEmpty(effectName))
		{
			selfFXHandler?.StopFX(effectName);
		}
	}

	public virtual void PlayHurtCueEffect(GameObject source, GameObject hurtEffectPrefab, bool isHurtEffectScale, bool playFlashTint, Vector3 hitPoint = default(Vector3), Quaternion hitRotation = default(Quaternion), HotfixEnum.hurtFlashTintType flashTintType = HotfixEnum.hurtFlashTintType.NONE, bool effectIgnoreTimeScale = true)
	{
		AdventureFXManager.PlayTintCueEffect(playFlashTint ? AdventureFXManager.CueEffectType.Hurt : AdventureFXManager.CueEffectType.None, flashTintType, source, gameObject, materialController, modelMaterialVariantController, hurtEffectPrefab, isHurtEffectScale, 1f, dtCollider.colliderBounds, dtCollider.Radius, hitPoint, hitRotation, effectIgnoreTimeScale);
	}

	public void PlaySuperArmorCueEffect()
	{
		AdventureFXManager.PlayTintCueEffect(AdventureFXManager.CueEffectType.SuperArmor, HotfixEnum.hurtFlashTintType.NONE, null, gameObject, materialController, modelMaterialVariantController, null, isEffectScale: false, 1f, dtCollider.colliderBounds, dtCollider.Radius);
	}

	public void StopSuperArmorCueEffect()
	{
		AdventureFXManager.StopTintCueEffect(AdventureFXManager.CueEffectType.SuperArmor, null, gameObject, materialController);
	}

	public void PlayImmuneControlCueEffect()
	{
		AdventureFXManager.PlayTintCueEffect(AdventureFXManager.CueEffectType.ImmuneControl, HotfixEnum.hurtFlashTintType.NONE, null, gameObject, materialController, modelMaterialVariantController, null, isEffectScale: false, 1f, dtCollider.colliderBounds, dtCollider.Radius);
	}

	public void StopImmuneControlCueEffect()
	{
		AdventureFXManager.StopTintCueEffect(AdventureFXManager.CueEffectType.ImmuneControl, null, gameObject, materialController);
	}

	public void PlayInvincibleCueEffect()
	{
		AdventureFXManager.PlayTintCueEffect(AdventureFXManager.CueEffectType.Invincible, HotfixEnum.hurtFlashTintType.NONE, null, gameObject, materialController, modelMaterialVariantController, null, isEffectScale: false, 1f, dtCollider.colliderBounds, dtCollider.Radius);
	}

	public void StopInvincibleCueEffect()
	{
		AdventureFXManager.StopTintCueEffect(AdventureFXManager.CueEffectType.Invincible, null, gameObject, materialController);
	}

	public void PlayMovableFx(string fxAlias, Vector3 startPosition, Vector3 targetPosition, float speed, Action finishCallback = null)
	{
		GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(this, fxAlias);
		if (fxByAlias == null)
		{
			Debug.LogError($"play fx fxAlias:{fxAlias} not exit, actorId:{dataID}");
			return;
		}
		Vector3 normalized = (targetPosition - startPosition).normalized;
		AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(gameObject, useActorSizeScale: false, useTransformSync: false, fxByAlias, 1f, startPosition, Quaternion.Euler(normalized));
		adventureFXPlayer.ownerActor = this;
		adventureFXPlayer.transform.forward = normalized;
		if (playFxs == null)
		{
			playFxs = new List<AdventureFXPlayer>();
		}
		playFxs.Add(adventureFXPlayer);
		float distance = Vector3.Distance(startPosition, targetPosition);
		CoroutineNode item = StartLogicCoroutine(FxMove(adventureFXPlayer, distance, speed, normalized, finishCallback));
		if (movableFCoroutineNodes == null)
		{
			movableFCoroutineNodes = new List<CoroutineNode>();
		}
		movableFCoroutineNodes.Add(item);
	}

	private IEnumerator FxMove(AdventureFXPlayer fx, float distance, float speed, Vector3 direction, Action callback)
	{
		float leftTime = distance / speed;
		while (leftTime > 0f)
		{
			float num = (float)LogicDeltaTime;
			Vector3 vector = direction * speed * num;
			fx.transform.position += vector;
			leftTime -= num;
			yield return null;
		}
		fx.Stop();
		if (playFxs.Contains(fx))
		{
			playFxs.Remove(fx);
		}
		callback?.Invoke();
	}

	private void ClearMovableCoroutineAndStopFx()
	{
		if (movableFCoroutineNodes != null)
		{
			foreach (CoroutineNode movableFCoroutineNode in movableFCoroutineNodes)
			{
				StopLogicCoroutine(movableFCoroutineNode);
			}
			movableFCoroutineNodes.Clear();
			movableFCoroutineNodes = null;
		}
		if (playFxs == null)
		{
			return;
		}
		foreach (AdventureFXPlayer playFx in playFxs)
		{
			playFx.Stop();
		}
		playFxs.Clear();
		playFxs = null;
	}

	public bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate, EventDispatchMode aEventDispatchMode = EventDispatchMode.Default)
	{
		return _dispatcher.AddEventListener(aEventName_string, aEventDelegate, aEventDispatchMode);
	}

	public bool RemoveEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return _dispatcher.RemoveEventListener(aEventName_string, aEventDelegate);
	}

	private bool RemoveAllEventListeners()
	{
		return _dispatcher.RemoveAllEventListeners();
	}

	public bool DispatchEvent(BaseAdventureEvent aEvent)
	{
		bool result = _dispatcher.DispatchEvent(aEvent);
		ModuleController<AdventureModuleController>.Instance.ReleaseEvent(aEvent);
		return result;
	}

	public void ClearEvent()
	{
		RemoveAllEventListeners();
	}

	void IHurtAnimatorHost.SetHurt(bool value)
	{
		if (animatorController != null)
		{
			animatorController.SetBool(AnimationParameterNames.Hurt, value);
		}
	}

	protected virtual void InitializeMovementBehaviour()
	{
		_movementFSM = new ActorMovementFSM(gameObject);
		_movementFSM.RegistState(new ActorStandbyState());
		_movementFSM.RegistState(new ActorMoveState());
		_movementFSM.RegistState(new ActorJumpState());
		_movementFSM.RegistState(new ActorDashState());
		_movementFSM.RegistState(new ActorDodgeState());
		specialDodgeMode = false;
	}

	protected void ReleaseMovementBehaviour()
	{
		velocitySpeed = 0f;
		velocityDirection = TSVector2.zero;
		externalForce = TSVector2.zero;
		specialDodgeMode = false;
	}

	public void InterruptMovement(bool stopRotate = true, bool cancelAiming = true)
	{
		if (stopRotate)
		{
			StopRotate();
		}
		if (cancelAiming)
		{
			CancelAiming();
		}
		if (movementState != ActorState.StandBy)
		{
			_movementFSM.SwitchState(7);
		}
		_movementFSM.UpdateAnimation(applyRootMotion: false, applyRootMotionRotate: false);
	}

	public bool StandBy(Action onComplete = null, bool force = false)
	{
		if (isDead)
		{
			return false;
		}
		if (force)
		{
			return _movementFSM.SwitchState(7, onComplete);
		}
		if (isControllable)
		{
			return _movementFSM.SwitchState(7, onComplete);
		}
		return false;
	}

	public void ForceChangeDirection(TSVector2 direction)
	{
		tsTransform.Forward = direction;
		forceChangeDirection = direction;
	}

	public bool Move(TSVector2 direction)
	{
		if (isDead)
		{
			return false;
		}
		if (isInteractive)
		{
			return false;
		}
		ActorState actorState = movementState;
		if (actorState == ActorState.Jump || actorState == ActorState.Dash || actorState == ActorState.Dodge)
		{
			return false;
		}
		if (actorSkillManage != null && actorSkillManage.BreakOthers(SkillPhaseFeatureFlag.Move))
		{
			InterruptAttack(force: true);
		}
		StopRotate();
		if (this is PlayerAdventureActor && inChaos)
		{
			direction = -direction;
		}
		direction.Normalize();
		_movementFSM.moveMode = ActorMoveState.MoveMode.MoveByDirection;
		_movementFSM.direction = direction;
		_movementFSM.targetPosition = TSVector2.zero;
		_movementFSM.targetPositionY = 0;
		_movementFSM.trackTarget = null;
		_movementFSM.stopDistance = -1f;
		_movementFSM.enableNavigation = false;
		_movementFSM.navigationUpdateQualityLevel = NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate;
		_movementFSM.forceMove = false;
		return _movementFSM.SwitchState(8);
	}

	public bool Walk(TSVector2 direction)
	{
		movementMode = MovementMode.Walk;
		return Move(direction);
	}

	public bool Run(TSVector2 direction)
	{
		movementMode = MovementMode.Run;
		return Move(direction);
	}

	public void FastSpeedMode(bool isRunFast)
	{
		actorInfo.fastSpeedMode = isRunFast;
		RefreshMovementSpeed(isInit: true);
	}

	public bool MoveTo(TSVector2 targetPosition, FP stopDistance, bool enableNavigation = false, MovementMode movementMode = MovementMode.Run, Action onComplete = null, bool randomMove = false, bool forceMove = false, FP targetPosY = default(FP), Action onLeave = null, bool stayWhenReachTarget = false, bool stopDisIgnoreRadius = false)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		if (this is MonsterAdventureActor && inChaos && !randomMove)
		{
			return false;
		}
		ActorState actorState = movementState;
		if (actorState == ActorState.Jump || actorState == ActorState.Dash || actorState == ActorState.Dodge)
		{
			return false;
		}
		StopRotate();
		if (targetPosY == default(FP))
		{
			targetPosY = CommonHelper.GetGroundHeightByActorMoveType(this, targetPosition, tsTransform.PositionY);
		}
		this.movementMode = movementMode;
		_movementFSM.moveMode = ActorMoveState.MoveMode.MoveToTarget;
		_movementFSM.direction = TSVector2.zero;
		_movementFSM.targetPosition = targetPosition;
		_movementFSM.targetPositionY = targetPosY;
		_movementFSM.trackTarget = null;
		_movementFSM.stopDistance = stopDistance;
		_movementFSM.enableNavigation = enableNavigation;
		_movementFSM.navigationUpdateQualityLevel = NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate;
		_movementFSM.forceMove = forceMove;
		_movementFSM.stayWhenReachTarget = stayWhenReachTarget;
		_movementFSM.stopDisIgnoreRadius = stopDisIgnoreRadius;
		return _movementFSM.SwitchState(8, onComplete, onLeave);
	}

	public bool TrackMove(LogicEntity trackTarget, FP stopDistance, bool enableNavigation = false, NavAgentTypeNames.NavigationUpdateQualityLevel navigationUpdateQualityLevel = NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, MovementMode movementMode = MovementMode.Run, Action onComplete = null, Action onLeave = null)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		if (inChaos)
		{
			return false;
		}
		ActorState actorState = movementState;
		if (actorState == ActorState.Jump || actorState == ActorState.Dash || actorState == ActorState.Dodge)
		{
			return false;
		}
		if (trackTarget == null || !trackTarget.isActiveAndEnabled)
		{
			return false;
		}
		StopRotate();
		this.movementMode = movementMode;
		_movementFSM.moveMode = ActorMoveState.MoveMode.MoveToTarget;
		_movementFSM.direction = TSVector2.zero;
		_movementFSM.targetPosition = TSVector2.zero;
		_movementFSM.targetPositionY = trackTarget.tsTransform.PositionY;
		_movementFSM.trackTarget = trackTarget;
		_movementFSM.stopDistance = stopDistance;
		_movementFSM.enableNavigation = enableNavigation;
		_movementFSM.navigationUpdateQualityLevel = navigationUpdateQualityLevel;
		return _movementFSM.SwitchState(8, onComplete, onLeave);
	}

	public bool Jump(TSVector2 targetPosition, FP speed, FP duration, Action onComplete = null, bool comboWithAttack = false, bool forbiddenHeight = false, bool checkPositionReachable = true)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		if (movementState == ActorState.Jump)
		{
			return false;
		}
		if (checkPositionReachable && !QueryPositionReachable(targetPosition))
		{
			return false;
		}
		if (comboWithAttack || InterruptAttack(force: false, fadeOutAnim: false))
		{
			StopRotate();
			movementMode = MovementMode.Run;
			CancelAiming();
			_movementFSM.targetPosition = targetPosition;
			_movementFSM.speed = speed;
			_movementFSM.duration = duration;
			_movementFSM.forbiddenHeight = forbiddenHeight;
			return _movementFSM.SwitchState(9, onComplete);
		}
		return false;
	}

	public bool Dash(TSVector2 direction, FP distance, FP speed, Action onComplete = null, bool comboWithAttack = false, bool canRotate = true, Action changeDir = null, bool triggerOne = true, bool triggerTwo = true, bool triggerThree = true, bool checkStop = false, FP minDashTime = default(FP), bool playAnim = true, Action leaveCallBack = null)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		if (movementState == ActorState.Jump)
		{
			return false;
		}
		direction.Normalize();
		if (comboWithAttack || InterruptAttack(force: false, fadeOutAnim: false))
		{
			if (canRotate)
			{
				StopRotate();
				CancelAiming();
			}
			movementMode = MovementMode.Run;
			_movementFSM._checkStop = checkStop;
			_movementFSM.direction = direction;
			_movementFSM.distance = distance;
			_movementFSM.speed = speed;
			_movementFSM.dashCanRotate = canRotate;
			_movementFSM.changeDir = changeDir;
			_movementFSM.triggerStopS[0] = triggerOne;
			_movementFSM.triggerStopS[1] = triggerTwo;
			_movementFSM.triggerStopS[2] = triggerThree;
			_movementFSM.minStopTime = minDashTime;
			_movementFSM.playAnim = playAnim;
			return _movementFSM.SwitchState(10, onComplete, leaveCallBack);
		}
		return false;
	}

	public bool Dodge(TSVector2 direction, FP distance, FP duration, Action onComplete = null, Action onLeave = null, bool comboWithAttack = false, bool canRotate = true)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		if (movementState == ActorState.Jump)
		{
			return false;
		}
		direction.Normalize();
		if (comboWithAttack || InterruptAttack(force: false, fadeOutAnim: false))
		{
			StopRotate();
			movementMode = MovementMode.Run;
			if (canRotate)
			{
				CancelAiming();
			}
			canPerfectDodge = CheckPerfectDodge();
			_movementFSM.direction = direction;
			_movementFSM.distance = distance;
			_movementFSM.duration = duration;
			_movementFSM.dashCanRotate = canRotate;
			return _movementFSM.SwitchState(11, onComplete, onLeave);
		}
		return false;
	}

	public bool CheckPerfectDodge()
	{
		if (!(this is PlayerAdventureActor))
		{
			return false;
		}
		if (_checkTargetList_PerfectDodge == null)
		{
			_checkTargetList_PerfectDodge = new List<DeterministicCollider>(10);
		}
		_checkTargetList_PerfectDodge.Clear();
		FP prefectDodge_BulletDistance = AdventureModuleController.Config.PrefectDodge_BulletDistance;
		FP prefectDodge_MonsterDistance = AdventureModuleController.Config.PrefectDodge_MonsterDistance;
		PlayerAdventureActor summoner;
		SummonType summonType;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(dtCollider.Radius + prefectDodge_BulletDistance, tsTransform.Position, _checkTargetList_PerfectDodge, 33280))
		{
			for (int i = 0; i < _checkTargetList_PerfectDodge.Count; i++)
			{
				if (_checkTargetList_PerfectDodge.get_Item(i).Entity is AdventureWeapon { ActiveSelf: not false } adventureWeapon && !(adventureWeapon.owner is PlayerAdventureActor) && !adventureWeapon.owner.IsPlayerSummoned(out summoner, out summonType) && CanTriggerPerfectDodge(adventureWeapon.hitBox.hitDamageId))
				{
					return true;
				}
			}
		}
		else if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(dtCollider.Radius + prefectDodge_MonsterDistance, tsTransform.Position, _checkTargetList_PerfectDodge, 256))
		{
			for (int j = 0; j < _checkTargetList_PerfectDodge.Count; j++)
			{
				if (!(_checkTargetList_PerfectDodge.get_Item(j).Entity is AdventureActor adventureActor) || adventureActor is PlayerAdventureActor || adventureActor is DestructibleStateSingle || adventureActor.IsPlayerSummoned(out summoner, out summonType) || !(adventureActor.attackFSM.currentComboClip != null))
				{
					continue;
				}
				FP comboPlayedTime = adventureActor.attackFSM.GetComboPlayedTime();
				FP fP = adventureActor.attackFSM.CalcComboClipDuration();
				FP startNormalizedTime = comboPlayedTime / fP;
				FP prefectDodge_MeleeTime = AdventureModuleController.Config.PrefectDodge_MeleeTime;
				FP fP2 = (comboPlayedTime + prefectDodge_MeleeTime) / fP;
				fP2 = ((fP2 <= 1) ? fP2 : ((FP)1));
				List<Combo.Event> list = adventureActor.attackFSM.GetEvent(startNormalizedTime, fP2, Combo.Event.EventType.Hit);
				if (list == null || list.Count <= 0)
				{
					continue;
				}
				for (int k = 0; k < list.Count; k++)
				{
					if (_checkHitList_PerfectDodge == null)
					{
						_checkHitList_PerfectDodge = new List<DeterministicCollider>(5);
					}
					else
					{
						_checkHitList_PerfectDodge.Clear();
					}
					Combo.Event obj = list.get_Item(k);
					if (!CanTriggerPerfectDodge(obj.hitDamageId))
					{
						continue;
					}
					TSVector2 lastRootMotionTranslate = adventureActor.attackFSM.lastRootMotionTranslate;
					TSVector2 point = obj.hitBoxOffset * adventureActor.actorScaleInfo.modelScale - lastRootMotionTranslate;
					FP hitBoxRotation = obj.hitBoxRotation;
					FP hitBoxWidth = obj.hitBoxWidth * adventureActor.actorScaleInfo.modelScale;
					FP hitBoxLength = obj.hitBoxLength * adventureActor.actorScaleInfo.modelScale;
					FP hitBoxRadius = obj.hitBoxRadius * adventureActor.actorScaleInfo.modelScale;
					FP hitBoxInnerRadius = obj.hitBoxInnerRadius * adventureActor.actorScaleInfo.modelScale;
					FP hitBoxAngle = obj.hitBoxAngle;
					TSVector2 pos = adventureActor.tsTransform.TransformLocalPointToWorldSpace(point);
					FP rot = adventureActor.tsTransform.Rotation + hitBoxRotation;
					if (obj.hitBoxConfigureWithGameData != Combo.Event.HitBoxConfigureWithGameData.Disable)
					{
						adventureActor.attackFSM.HitBoxConfigureWithGameData(obj.hitBoxConfigureWithGameData, obj.hitBoxShape, ref hitBoxWidth, ref hitBoxLength, ref hitBoxRadius, ref hitBoxInnerRadius, ref hitBoxAngle);
					}
					switch (obj.hitBoxShape)
					{
					case HitBox.Shape.Rectangle:
						SceneSingleton<DeterministicCollisionManager>.Instance.CheckRectangleOverlap(hitBoxWidth, hitBoxLength, pos, rot, _checkHitList_PerfectDodge, 256);
						break;
					case HitBox.Shape.Circle:
						if (hitBoxInnerRadius > 0f)
						{
							SceneSingleton<DeterministicCollisionManager>.Instance.CheckRingOverlap(hitBoxRadius, hitBoxInnerRadius, pos, _checkHitList_PerfectDodge, 256);
						}
						else
						{
							SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(hitBoxRadius, pos, _checkHitList_PerfectDodge, 256);
						}
						break;
					case HitBox.Shape.Fan:
						if (hitBoxInnerRadius > 0f)
						{
							SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanRingOverlap(hitBoxAngle, hitBoxRadius, hitBoxInnerRadius, pos, rot, _checkHitList_PerfectDodge, 256);
						}
						else
						{
							SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanOverlap(hitBoxAngle, hitBoxRadius, pos, rot, _checkHitList_PerfectDodge, 256);
						}
						break;
					default:
						throw new ArgumentOutOfRangeException();
					}
					for (int l = 0; l < _checkHitList_PerfectDodge.Count; l++)
					{
						if (_checkHitList_PerfectDodge.get_Item(l).Entity == this)
						{
							return true;
						}
					}
				}
			}
		}
		return false;
	}

	private bool CanTriggerPerfectDodge(int hitDamageId)
	{
		HitDamage hitDamage = Singleton<HotfixDataController>.Instance.GetHitDamage(hitDamageId);
		if (hitDamage == null)
		{
			return false;
		}
		HotfixEnum.damageEffect effectType = (HotfixEnum.damageEffect)hitDamage.EffectType;
		if ((uint)(effectType - 1) <= 1u || effectType == HotfixEnum.damageEffect.REAL)
		{
			return true;
		}
		return false;
	}

	public bool Blink(TSVector2 direction, FP distance, bool changeForwrd = false)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		direction.Normalize();
		TSVector2 linecastHitPoint = tsTransform.Position + direction * distance;
		if (!QueryPositionReachable(linecastHitPoint))
		{
			int layerMask = 4096;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(dtCollider.Radius, tsTransform.Position, null, layerMask))
			{
				bool flag = false;
				TSVector2 origin = tsTransform.Position;
				TSVector2 direction2 = direction;
				SceneSingleton<DeterministicCollisionManager>.Instance.RaycastAll(ref origin, ref direction2, _tempDeterministicRaycastHits, distance, layerMask);
				for (int num = _tempDeterministicRaycastHits.Count - 1; num >= 0; num--)
				{
					TSVector2 tSVector = _tempDeterministicRaycastHits.get_Item(num).point - direction * dtCollider.Radius;
					if (QueryPositionReachable(tSVector))
					{
						linecastHitPoint = tSVector;
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					LinecastNavmeshGraph(tsTransform.Position, linecastHitPoint, out linecastHitPoint);
				}
				_tempDeterministicRaycastHits.Clear();
			}
			else
			{
				LinecastNavmeshGraph(tsTransform.Position, linecastHitPoint, out linecastHitPoint);
			}
		}
		tsTransform.Position = linecastHitPoint;
		if (changeForwrd)
		{
			tsTransform.Forward = direction;
		}
		SyncMovementLocation();
		return true;
	}

	public bool Teleport(TSVector2 targetPosition)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		QueryClosestPositionWalkable(targetPosition, out targetPosition);
		tsTransform.Position = targetPosition;
		tsTransform.PositionY = CommonHelper.GetGroundHeightByActorMoveType(this, targetPosition, tsTransform.PositionY);
		SyncMovementLocation();
		DynamicBoneOn(null, 0.5f);
		return true;
	}

	public bool Teleport(TSVector2 targetPosition, FP targetPositionY)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		QueryClosestPositionWalkable(targetPosition, out targetPosition);
		tsTransform.Position = targetPosition;
		tsTransform.PositionY = targetPositionY;
		SyncMovementLocation();
		return true;
	}

	public bool LookAt(TSVector2 target, FP duration, Action onComplete = null, Action onClear = null, bool useShortAngle = true)
	{
		FP angle = (target - tsTransform.Position).normalized.GetAngle();
		return RotateTo(angle, duration, useShortAngle, onComplete, onClear);
	}

	public bool LookAtDir(TSVector2 dir, FP duration, Action onComplete = null, Action onClear = null, bool useShortAngle = true)
	{
		FP angle = dir.normalized.GetAngle();
		return RotateTo(angle, duration, useShortAngle, onComplete, onClear);
	}

	public bool RotateTo(FP angle, FP duration, bool useShortAngle = true, Action onComplete = null, Action onClear = null)
	{
		angle = (angle + 360f) % 360f;
		FP rotation = tsTransform.Rotation360;
		FP fP = angle - rotation;
		if (useShortAngle)
		{
			FP fP2 = ((fP > 0f) ? fP : (-fP));
			if (fP2 > 180f)
			{
				fP = ((fP > 0f) ? (-(360f - fP2)) : (360f - fP2));
			}
		}
		return Rotate(fP, duration, useShortAngle, onComplete, onClear);
	}

	public bool Rotate(FP relativeAngle, FP duration, bool useShortAngle = true, Action onComplete = null, Action onClear = null)
	{
		if (isDead)
		{
			return false;
		}
		if (!isControllable)
		{
			return false;
		}
		CancelAiming();
		if (useShortAngle)
		{
			FP fP = ((relativeAngle > 0f) ? relativeAngle : (-relativeAngle));
			if (fP > 180f)
			{
				relativeAngle = ((relativeAngle > 0f) ? (-(360f - fP)) : (360f - fP));
			}
		}
		if (duration <= 0f)
		{
			if (_rotateCoroutine != null)
			{
				StopLogicCoroutine(_rotateCoroutine);
				_rotateCoroutine = null;
				_currentRotateSpeed = 0;
			}
			RotDelta(relativeAngle);
			onComplete?.Invoke();
			return true;
		}
		if (_rotateCoroutine != null && !_rotateCoroutine.finished)
		{
			targetRotation = tsTransform.Rotation360 + relativeAngle;
			_currentRotateSpeed = relativeAngle / duration;
			currentRotTime = 0;
			rotationDuration = duration;
		}
		else
		{
			_rotateCoroutine = StartLogicCoroutine(RotateCoroutine(relativeAngle, duration, onComplete));
		}
		_onClear = onClear;
		return true;
	}

	public bool StopRotate()
	{
		if (_rotateCoroutine == null)
		{
			return false;
		}
		_onClear?.Invoke();
		StopLogicCoroutine(_rotateCoroutine);
		_rotateCoroutine = null;
		_currentRotateSpeed = 0;
		targetRotation = 0;
		currentRotTime = 0;
		rotationDuration = 0;
		return true;
	}

	protected IEnumerator RotateCoroutine(FP relativeAngle, FP duration, Action onComplete)
	{
		targetRotation = tsTransform.Rotation360 + relativeAngle;
		_currentRotateSpeed = relativeAngle / duration;
		currentRotTime = 0f;
		rotationDuration = duration;
		do
		{
			if (rotationDuration - currentRotTime < LogicDeltaTime)
			{
				RotateToAngle(targetRotation);
			}
			else
			{
				RotDelta(_currentRotateSpeed * LogicDeltaTime);
			}
			currentRotTime += LogicDeltaTime;
			yield return null;
		}
		while (currentRotTime < rotationDuration);
		_rotateCoroutine = null;
		_currentRotateSpeed = 0;
		onComplete?.Invoke();
	}

	public void Aim(TSVector2 direction, FP angleLimit = default(FP))
	{
		if (!forceControl && aimMode != AimMode.LockDirection)
		{
			aimMode = AimMode.LockDirection;
			if (angleLimit > FP.Zero)
			{
				angleLimit /= (FP)30f;
				angleLimit = ((angleLimit < 0.5f) ? ((FP)0.5f) : angleLimit);
			}
			else
			{
				tsTransform.Forward = direction;
			}
			aimAngleLimit = angleLimit;
			targetDir = direction;
		}
	}

	public void AimAtTarget(LogicEntity target, FP angleLimit = default(FP), int aimClipIndex = -1)
	{
		if (forceControl || aimMode == AimMode.AimAtAttackTarget)
		{
			return;
		}
		if (!(this is PlayerAdventureActor))
		{
			attackTarget = target;
		}
		if (angleLimit > FP.Zero)
		{
			angleLimit /= (FP)30f;
			angleLimit = ((angleLimit < 0.5f) ? ((FP)0.5f) : angleLimit);
		}
		aimAngleLimit = angleLimit;
		if (movementState != ActorState.Move)
		{
			if (aimLockedTarget != null && angleLimit <= FP.Zero)
			{
				LookAt(aimLockedTarget.tsTransform.Position, 0);
			}
			else
			{
				StopRotate();
			}
		}
		else if (aimLockedTarget != null && angleLimit <= FP.Zero)
		{
			tsTransform.Forward = (aimLockedTarget.tsTransform.Position - tsTransform.Position).normalized;
		}
		aimMode = AimMode.AimAtAttackTarget;
		curAimIndex = aimClipIndex;
	}

	public void CancelAiming()
	{
		if (aimMode != AimMode.Forward)
		{
			aimMode = AimMode.Forward;
			aimAngleLimit = 0;
			if (movementState == ActorState.StandBy)
			{
				LookAtDir(tsTransform.Forward, 0);
			}
		}
	}

	public bool HasAnimingAnimationReady()
	{
		if (aimMode == AimMode.Forward)
		{
			return false;
		}
		if (animatorController == null)
		{
			return true;
		}
		if (comboGroup == null || comboGroup.aimAnimClip == null || animatorController.baseOverrideWithMaskPlayable.playingAnimationClip != comboGroup.aimAnimClip.animationClip)
		{
			return false;
		}
		return animatorController.baseOverrideWithMaskPlayable.totalPlayingTime > (float)comboGroup.aimAnimClip.transitionIn;
	}

	public NavmeshBase GetNavmeshGraph()
	{
		GraphMask graphMask = movAgent.cachedSeeker.graphMask;
		NavGraph[] graphs = AstarPath.active.graphs;
		for (int i = 0; i < graphs.Length; i++)
		{
			NavGraph navGraph = graphs[i];
			if (navGraph != null && graphMask.Contains(i))
			{
				return navGraph as NavmeshBase;
			}
		}
		return null;
	}

	public bool LinecastNavmeshGraph(TSVector2 startPoint, TSVector2 endPoint, out TSVector2 linecastHitPoint, bool offset = false, FP startPointY = default(FP), FP endPointY = default(FP))
	{
		NavmeshBase navmeshGraph = GetNavmeshGraph();
		if (navmeshGraph != null)
		{
			TSVector tSVector = new TSVector(startPoint.x, startPointY, startPoint.y);
			TSVector tSVector2 = new TSVector(endPoint.x, endPointY, endPoint.y);
			GraphNode node = navmeshGraph.GetNearest(tSVector, NNConstraint.None).node;
			if (navmeshGraph.Linecast(tSVector, tSVector2, node, out var hit))
			{
				if (offset)
				{
					TSVector vector = tSVector2 - hit.point;
					TSVector tSVector3 = hit.tangent.normalized * TSVector.Dot(vector, hit.tangent.normalized) + hit.point;
					linecastHitPoint = new TSVector2(tSVector3.x, tSVector3.z);
					if (!QueryPositionWalkable(linecastHitPoint))
					{
						linecastHitPoint = new TSVector2(hit.point.x, hit.point.z);
					}
				}
				else
				{
					linecastHitPoint = new TSVector2(hit.point.x, hit.point.z);
				}
				return true;
			}
		}
		linecastHitPoint = startPoint;
		return false;
	}

	public bool QueryPositionReachable(TSVector2 position)
	{
		FP positionY = tsTransform.PositionY;
		if (isSceneMove || isAirBorne || _movementFSM.GetCurStateID() == 9)
		{
			positionY = CommonHelper.GetGroundHeightByActorMoveType(this, tsTransform.Position, tsTransform.PositionY);
		}
		return QueryPositionReachable(position, positionY);
	}

	public bool QueryPositionReachable(TSVector2 position, FP positionY)
	{
		AstarPath.active.maxNearestNodeDistance = AdventureModuleController.Config.Level_ReachableNearestNodeDistance;
		try
		{
			_reachableConstraint.graphMask = movAgent.cachedSeeker.graphMask;
			_reachableConstraint.constrainDistance = true;
			_reachableConstraint.distanceXZ = true;
			_reachableConstraint.constrainWalkability = true;
			_reachableConstraint.walkable = true;
			if (positionY == 0)
			{
				positionY = tsTransform.PositionY;
			}
			if (isSceneMove || isAirBorne || _movementFSM.GetCurStateID() == 9)
			{
				positionY = CommonHelper.GetGroundHeightByActorMoveType(this, tsTransform.Position, tsTransform.PositionY);
			}
			TSVector start = new TSVector(tsTransform.Position.x, tsTransform.PositionY, tsTransform.Position.y);
			TSVector end = new TSVector(position.x, positionY, position.y);
			ABPath aBPath = ABPath.Construct(start, end);
			aBPath.nnConstraint = _reachableConstraint;
			AstarPath.StartPath(aBPath);
			aBPath.BlockUntilCalculated();
			aBPath.Claim(this);
			if (aBPath.error)
			{
				aBPath.Release(this);
				return false;
			}
			aBPath.Release(this);
			return true;
		}
		finally
		{
			AstarPath.active.maxNearestNodeDistance = AdventureModuleController.Config.Level_NavigationMaxNearestNodeDistance;
		}
	}

	public bool QueryClosestPositionWalkable(TSVector2 position, out TSVector2 result)
	{
		AstarPath.active.maxNearestNodeDistance = AdventureModuleController.Config.Level_ReachableNearestNodeDistance;
		try
		{
			_reachableConstraint.graphMask = movAgent.cachedSeeker.graphMask;
			_reachableConstraint.constrainDistance = false;
			_reachableConstraint.distanceXZ = true;
			_reachableConstraint.constrainWalkability = true;
			_reachableConstraint.walkable = true;
			FP y = tsTransform.PositionY;
			if (isAirBorne || _movementFSM.GetCurStateID() == 9)
			{
				y = CommonHelper.GetGroundHeightByActorMoveType(this, tsTransform.Position, tsTransform.PositionY);
			}
			NNInfo nearest = AstarPath.active.GetNearest(new TSVector(position.x, y, position.y), _reachableConstraint);
			if (nearest.node != null)
			{
				result = new TSVector2(nearest.position.x, nearest.position.z);
				return true;
			}
			result = position;
			return false;
		}
		finally
		{
			AstarPath.active.maxNearestNodeDistance = AdventureModuleController.Config.Level_NavigationMaxNearestNodeDistance;
		}
	}

	public bool QueryPositionWalkable(TSVector2 position)
	{
		FP positionY = tsTransform.PositionY;
		if (isAirBorne || _movementFSM.GetCurStateID() == 9)
		{
			positionY = CommonHelper.GetGroundHeightByActorMoveType(this, tsTransform.Position, tsTransform.PositionY);
		}
		return QueryPositionWalkable(position, positionY);
	}

	public bool QueryPositionWalkable(TSVector2 position, FP positionY)
	{
		NavmeshBase navmeshGraph = GetNavmeshGraph();
		if (navmeshGraph == null)
		{
			return false;
		}
		_reachableConstraint.graphMask = movAgent.cachedSeeker.graphMask;
		_reachableConstraint.constrainDistance = true;
		_reachableConstraint.distanceXZ = true;
		_reachableConstraint.constrainWalkability = true;
		_reachableConstraint.walkable = true;
		return navmeshGraph.PointOnNavmesh(new TSVector(position.x, positionY, position.y), _reachableConstraint) != null;
	}

	public TSVector2 RandomActorReachablePointInsideRing(TSVector2 center, FP innerRadius, FP outerRadius, bool useSelfPos = false, int maxCheckCount = 30)
	{
		TSVector2 position = tsTransform.Position;
		FP radius = dtCollider.Radius;
		for (int i = 0; i < maxCheckCount; i++)
		{
			TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(center, innerRadius, outerRadius);
			if (!(TSVector2.Distance(tSVector, position) <= radius) && QueryPositionReachable(tSVector))
			{
				return tSVector;
			}
		}
		if (!useSelfPos)
		{
			return center;
		}
		return position;
	}

	public TSVector2 RandomActorReachablePointInsideShape(DeterministicShape _shape, int maxCheckCount = 15)
	{
		TSVector2 position = tsTransform.Position;
		FP radius = dtCollider.Radius;
		TSVector2 position2 = _shape.position;
		FP angle = _shape.angle;
		FP radius2 = _shape.radius;
		FP innerRadius = _shape.innerRadius;
		TSVector2 position3 = _shape.position;
		FP rotation = _shape.rotation;
		FP width = _shape.width;
		FP length = _shape.length;
		for (int i = 0; i < maxCheckCount; i++)
		{
			position2 = _shape.shapeType switch
			{
				DeterministicShape.ShapeType.Circle => (rotation > 0) ? TrueSyncExtensions.RandomPointInsideFan(position3, innerRadius, radius2, rotation, angle) : TrueSyncExtensions.RandomPointInsideRing(position3, innerRadius, radius2), 
				DeterministicShape.ShapeType.Fan => TrueSyncExtensions.RandomPointInsideFan(position3, innerRadius, radius2, rotation, angle), 
				DeterministicShape.ShapeType.Rectangle => TrueSyncExtensions.RandomPointInsideRectangle(position3, width, length, rotation), 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			if (!(TSVector2.Distance(position2, position) <= radius) && QueryPositionReachable(position2))
			{
				return position2;
			}
		}
		return position3;
	}

	public TSVector2 RandomActorReachablePointInsideLine(TSVector2 center, TSVector2 dir, FP offset, int maxCheckCount = 30)
	{
		for (int i = 0; i < maxCheckCount; i++)
		{
			TSVector2 tSVector = center + TSRandom.Range(-offset, offset) * dir;
			if (QueryPositionReachable(tSVector))
			{
				return tSVector;
			}
		}
		return center;
	}

	public void RefreshMoveSpeed(bool isInit = false)
	{
		RefreshMovementSpeed(isInit);
	}

	internal void RefreshMovementSpeed(bool isInit = false)
	{
		if (movementAgentEnabled)
		{
			if (speedTransition != null)
			{
				StopLogicCoroutine(speedTransition);
				speedTransition = null;
				_speedTransitionTimer = 0;
			}
			switch (_movementMode)
			{
			case MovementMode.Walk:
				movAgent.maxSpeed = actorInfo.walkSpeed;
				break;
			case MovementMode.Run:
			{
				if (isInit)
				{
					movAgent.maxSpeed = actorInfo.runSpeed;
				}
				FP fP = actorInfo.runSpeed - movAgent.maxSpeed;
				if (actorInfo.walktoRunDuration > 0 && fP > 0)
				{
					speedTransition = StartLogicCoroutine(moveSpeedTransition(movAgent.maxSpeed, fP));
				}
				else
				{
					movAgent.maxSpeed = actorInfo.runSpeed;
				}
				break;
			}
			default:
				throw new ArgumentOutOfRangeException();
			case MovementMode.None:
				break;
			}
		}
		else
		{
			switch (_movementMode)
			{
			case MovementMode.Walk:
				movAgent.maxSpeed = actorInfo.walkSpeed;
				break;
			case MovementMode.Run:
				movAgent.maxSpeed = actorInfo.runSpeed;
				break;
			default:
				throw new ArgumentOutOfRangeException();
			case MovementMode.None:
				break;
			}
		}
	}

	private IEnumerator moveSpeedTransition(FP origin, FP speedDiff)
	{
		FP normalize = 0;
		while (normalize < 1)
		{
			_speedTransitionTimer += LogicDeltaTime;
			normalize = TSMath.Clamp01(_speedTransitionTimer / actorInfo.walktoRunDuration);
			movAgent.maxSpeed = origin + speedDiff * normalize;
			yield return null;
		}
	}

	internal void ScaleMovementAcceleration(FP value)
	{
		if (movementAgentEnabled)
		{
			_accelerationScaleValue = value;
			movAgent.acceleration = actorInfo.moveAcceleration * value;
		}
	}

	internal void ScaleMovementRotationSpeed(FP value)
	{
		if (movementAgentEnabled)
		{
			_rotationSpeedScaleValue = value;
			movAgent.rotationSpeed = actorInfo.moveRotationSpeed * value;
		}
	}

	public void RefreshMovementRotationSpeed()
	{
		ScaleMovementRotationSpeed(_rotationSpeedScaleValue);
	}

	public void RefreshMovementAcc()
	{
		ScaleMovementAcceleration(_accelerationScaleValue);
	}

	public void SyncMovementLocation(TSVector2 position, FP positionY, FP rotation)
	{
		tsTransform.Position = position;
		tsTransform.PositionY = positionY;
		tsTransform.Rotation = rotation;
		SyncMovementLocation();
	}

	public void SyncMovementLocation(bool clearPath = true)
	{
		_smooth?.SyncDeterministicTransform();
		if (movementAgentEnabled)
		{
			movAgent?.Teleport(new TSVector(tsTransform.Position.x, tsTransform.PositionY, tsTransform.Position.y), clearPath);
		}
	}

	public void EnableMovementAgent()
	{
		if (!movementAgentEnabled)
		{
			movementAgentEnabled = true;
			movAgent.owner = this;
			movAgent.updatePosition = false;
			movAgent.updateRotation = false;
			movAgent.endReachedDistance = movAgent.radius;
			movAgent.slowWhenNotFacingTarget = false;
			movAgent.enabled = true;
			ScaleMovementAcceleration(FP.One);
			ScaleMovementRotationSpeed(FP.One);
			if (movAgent.cachedRVOController != null)
			{
				movAgent.cachedRVOController.enabled = true;
				movAgent.cachedRVOController.locked = false;
			}
			movAgent.canBlock = true;
			UpdateNovementAgentTraversableType();
			UpdateNovementAgentAvoidanceBlockSetting();
			SyncMovementLocation();
			movementMode = MovementMode.Run;
		}
	}

	public void DisableMovementAgent()
	{
		if (movementAgentEnabled)
		{
			movementAgentEnabled = false;
			movAgent.enabled = false;
			if (movAgent.cachedRVOController != null)
			{
				movAgent.cachedRVOController.enabled = false;
				movAgent.cachedRVOController.locked = false;
			}
			movAgent.canBlock = false;
			_movementAgentPauseRC = 0;
			_movementAvoidancePauseRC = 0;
			_movementAvoidanceLockRC = 0;
			_movementBlockPauseRC = 0;
		}
	}

	protected void UpdateNovementAgentTraversableType()
	{
		if (movementAgentEnabled)
		{
			switch (actorInfo.moveType)
			{
			case HotfixEnum.actorMovType.STATIC:
			case HotfixEnum.actorMovType.WALK:
				movAgent.cachedSeeker.graphMask = NavAgentTypeNames.HumanoidGraphMask;
				break;
			case HotfixEnum.actorMovType.FLY:
				movAgent.cachedSeeker.graphMask = NavAgentTypeNames.FlyingGraphMask;
				break;
			}
		}
	}

	public void PauseMovementAgent()
	{
		if (movementAgentEnabled)
		{
			_movementAgentPauseRC++;
			if (_movementAgentPauseRC == 1)
			{
				movAgent.enabled = false;
			}
		}
	}

	public void ResumeMovementAgent()
	{
		if (movementAgentEnabled)
		{
			_movementAgentPauseRC--;
			if (_movementAgentPauseRC == 0)
			{
				movAgent.enabled = true;
			}
			if (_movementAgentPauseRC < 0)
			{
				_movementAgentPauseRC = 0;
				LogWarning("PauseMovementAgent与ResumeMovementAgent使用不匹配，请成对使用");
			}
		}
	}

	public void SetBlockPriorityToStatic()
	{
		DeterministicMovementAgent deterministicMovementAgent = movAgent;
		FP blockPriority;
		if (this is PlayerAdventureActor)
		{
			blockPriority = NavAgentTypeNames.UnmoveableAgentPriority;
		}
		else
		{
			blockPriority = ((!(this is MonsterAdventureActor)) ? movAgent.blockPriority : ((FP)NavAgentTypeNames.UnmoveableAgentPriority));
		}
		deterministicMovementAgent.blockPriority = blockPriority;
	}

	public void ResetBlockPriority()
	{
		movAgent.blockPriority = _orginMovementBlockPriority;
	}

	protected virtual void UpdateNovementAgentAvoidanceBlockSetting()
	{
		_orginMovementBlockPriority = movAgent.blockPriority;
	}

	public void PauseMovementAvoidance()
	{
		if (movementAgentEnabled)
		{
			_movementAvoidancePauseRC++;
			if (_movementAvoidancePauseRC == 1 && movAgent.cachedRVOController != null)
			{
				movAgent.cachedRVOController.enabled = false;
			}
		}
	}

	public void ResumeMovementAvoidance()
	{
		if (movementAgentEnabled)
		{
			_movementAvoidancePauseRC--;
			if (_movementAvoidancePauseRC == 0 && movAgent.cachedRVOController != null)
			{
				movAgent.cachedRVOController.enabled = true;
			}
			if (_movementAvoidancePauseRC < 0)
			{
				_movementAvoidancePauseRC = 0;
				LogWarning("EnableMovementAvoidance与DisableMovementAvoidance使用不匹配，请成对使用");
			}
		}
	}

	public void LockMovementAvoidance()
	{
		if (movementAgentEnabled)
		{
			_movementAvoidanceLockRC++;
			if (_movementAvoidanceLockRC == 1 && movAgent.cachedRVOController != null)
			{
				movAgent.cachedRVOController.locked = true;
			}
		}
	}

	public void UnlockMovementAvoidance()
	{
		if (movementAgentEnabled)
		{
			_movementAvoidanceLockRC--;
			if (_movementAvoidanceLockRC == 0 && movAgent.cachedRVOController != null)
			{
				movAgent.cachedRVOController.locked = false;
			}
			if (_movementAvoidanceLockRC < 0)
			{
				_movementAvoidanceLockRC = 0;
				LogWarning("LockMovementAvoidance与UnlockMovementAvoidance使用不匹配，请成对使用");
			}
		}
	}

	public void PauseMovementBlock()
	{
		if (movementAgentEnabled)
		{
			_movementBlockPauseRC++;
			if (_movementBlockPauseRC == 1)
			{
				movAgent.canBlock = false;
			}
		}
	}

	public void ResumeMovementBlock()
	{
		if (movementAgentEnabled)
		{
			_movementBlockPauseRC--;
			if (_movementBlockPauseRC == 0)
			{
				movAgent.canBlock = true;
			}
			if (_movementBlockPauseRC < 0)
			{
				_movementBlockPauseRC = 0;
				LogWarning("PauseMovementBlock与ResumeMovementBlock使用不匹配，请成对使用");
			}
		}
	}

	public void RotDelta(FP deltaAngle)
	{
		if (!(deltaAngle == FP.Zero))
		{
			tsTransform.Rotation = tsTransform.Rotation360 + deltaAngle;
			if (movAgent.enabled)
			{
				TSVector2 forward = tsTransform.Forward;
				movAgent.RotationTowards(new TSVector(forward.x, 0f, forward.y), FP.MaxValue);
			}
		}
	}

	public void RotateToAngle(FP targetAngle)
	{
		tsTransform.Rotation = targetAngle;
		if (movAgent.enabled)
		{
			TSVector2 forward = tsTransform.Forward;
			movAgent.RotationTowards(new TSVector(forward.x, 0f, forward.y), FP.MaxValue);
		}
	}

	public bool CheckCanRot(FP deltaAngle)
	{
		Rot rot = new Rot((tsTransform.Rotation360 + deltaAngle) * FP.Deg2Rad);
		if (!(rot.s != tsTransform.dtTransform.q.s))
		{
			return rot.c != tsTransform.dtTransform.q.c;
		}
		return true;
	}

	protected void InitializePassiveBehaviour()
	{
	}

	protected void ReleasePassiveBehaviour()
	{
		InterruptPassiveBehaviour();
	}

	public bool IsInCannotSwitchActorStates()
	{
		if (!isStiff && !isKnockBack && !isAirBorne && !isForceMove && !isStun && !isFrozen && !isSleep && !isCharm && !isTerror && !isBondage)
		{
			return isSilence;
		}
		return true;
	}

	public bool IsInCannotUseSkillStates()
	{
		if (!isStiff && !isKnockBack && !isAirBorne && !isForceMove && !isStun && !isFrozen && !isSleep && !isCharm)
		{
			return isTerror;
		}
		return true;
	}

	public void InterruptPassiveBehaviour()
	{
		InterruptSceneMove();
		InterruptStiff();
		InterruptKnockBack();
		InterruptAirBorne();
		InterruptStrongControl();
		InterruptToughnessBrokenState();
		InterruptWeakControl();
		InterruptPull();
		InterruptForceMove();
		InterruptImmuneControl();
		InterruptSuperArmor();
		InterruptInvincible();
		InterruptSearchedImmunity();
		InterruptSneak();
		InterruptCloseBlock();
		InterruptHideModel();
		InterruptHideOut();
		InterruptBattleOut();
		InterruptWitchTime();
		InterruptPenetrate();
		InterruptDamageImmunity();
		ExitInteractive();
		InterruptCureImmunity();
		ExitPerfectDodge();
		InterruptDeadImmunity();
		UnlockHp();
		InterruptKillImmunity();
		InterruptDodgeCrossObstacle();
		InterruptForbiddenRush();
		InterruptUnparalleled();
		InterruptDodge();
		InterruptDefense();
		ResetForbidenPerfectDodge();
		InterruptLostControl();
	}

	public void InterruptForceControl()
	{
		InterruptStiff();
		InterruptKnockBack();
		InterruptAirBorne();
		InterruptForceMove();
		InterruptStrongControl();
	}

	public void RefreshSkillUseable()
	{
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillUseableByActionKey", Id, 1, !disableCastDodge);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillUseableByActionKey", Id, 2, !disableCastSkill);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillUseableByActionKey", Id, 4, !disableCastUltra);
	}

	public void EnterLostControl(bool isInterruptAttack = true)
	{
		_lostControlRC++;
		if (_lostControlRC == 1)
		{
			LostControl(isInterruptAttack);
		}
	}

	public void ExitLostControl()
	{
		_lostControlRC--;
		if (_lostControlRC == 0)
		{
			if (this is MonsterAdventureActor monsterAdventureActor)
			{
				if (monsterAdventureActor.ToughnessBrokenToIdle)
				{
					Idle();
				}
				else
				{
					Action();
				}
			}
			else
			{
				Action();
			}
		}
		if (_lostControlRC < 0)
		{
			_lostControlRC = 0;
			LogWarning("EnterLostControl与ExitLostControl使用不匹配，请成对使用");
		}
	}

	public void InterruptLostControl()
	{
		if (isLostControl)
		{
			_lostControlRC = 0;
		}
	}

	public bool ToJump(TSVector2 targetPosition, FP speed, FP _duration, Action onComplete = null, bool comboWithAttack = false, bool forbiddenHeight = false, bool checkPositionReachable = true)
	{
		if (isKnockBack || isAirBorne || isStun || isFrozen || isBondage)
		{
			return false;
		}
		return Jump(targetPosition, speed, _duration, onComplete, comboWithAttack, forbiddenHeight, checkPositionReachable);
	}

	public void EnableDamageImmunity()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.DAMAGE_IMM);
	}

	public void DisableDamageImmunity()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.DAMAGE_IMM);
	}

	public void InterruptDamageImmunity()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.DAMAGE_IMM);
	}

	public void EnterInteractive()
	{
		isInteractive = true;
		InterruptMovement();
		PlayOpenChestAnim();
	}

	public void ExitInteractive()
	{
		if (isInteractive)
		{
			isInteractive = false;
		}
	}

	public void EnableCureImmunity()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.CURE_IMM);
	}

	public void DisableCureImmunity()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.CURE_IMM);
	}

	public void InterruptCureImmunity()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.CURE_IMM);
	}

	public void EnterPerfectDodge()
	{
		if (!InPerfectDodge && !forbiddenPerfectDodge)
		{
			InPerfectDodge = true;
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(prefectDodgeTimeScale, prefectDodgeTimeDuration, ExitPerfectDodge);
			if (AdventureModuleController.Config.FeedbackData_PrefectDodge != null)
			{
				AdventureModuleController.Config.FeedbackData_PrefectDodge.Play(transform.position, gameObject);
			}
			AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = AdventurePerfectDodgeTrigger.Generate();
			adventurePerfectDodgeTrigger.actor = this;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurePerfectDodgeTrigger);
			MonoSingleton<WwiseAudioManager>.Instance?.WwiseVoice_Play(dataID, "exdodge");
		}
	}

	protected void ExitPerfectDodge()
	{
		InPerfectDodge = false;
	}

	public void SetForbidenPerfectDodge(bool forbidden)
	{
		forbiddenPerfectDodge = forbidden;
	}

	protected void ResetForbidenPerfectDodge()
	{
		forbiddenPerfectDodge = false;
	}

	public void EnableDeadImmunity(int count = 1)
	{
		_deadImmunityRC += count;
	}

	public void DisableDeadImmunity()
	{
		_deadImmunityRC--;
		if (_deadImmunityRC < 0)
		{
			_deadImmunityRC = 0;
			LogWarning("EnableDeadImmunity与DisableDeadImmunity使用不匹配，请成对使用");
		}
	}

	public void InterruptDeadImmunity()
	{
		if (isDeadImmunity)
		{
			_deadImmunityRC = 0;
		}
	}

	public void LockHpAbs(long hp)
	{
		if (!isHpLocked)
		{
			isHpLocked = true;
			lockedHp = hp;
		}
	}

	public void LockHpPercent(FP percent)
	{
		if (!isHpLocked)
		{
			isHpLocked = true;
			lockedHp = (long)(actorHealthInfo.hpMax * percent / 100);
		}
	}

	public void UnlockHp()
	{
		isHpLocked = false;
	}

	public void EnableKillImmunity()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.IMMUNE_KILL);
	}

	public void DisableKillImmunity()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.IMMUNE_KILL);
	}

	public void InterruptKillImmunity()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.IMMUNE_KILL);
	}

	public void EnableDodgeCrossObstacle()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.DODGE_CROSS_OBSTACLE);
	}

	public void DisableDodgeCrossObstacle()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.DODGE_CROSS_OBSTACLE);
	}

	public void InterruptDodgeCrossObstacle()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.DODGE_CROSS_OBSTACLE);
	}

	public void EnableForbiddenRush()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.FORBIDDEN_RUSH);
	}

	public void DisableForbiddenRush()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.FORBIDDEN_RUSH);
	}

	public void InterruptForbiddenRush()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.FORBIDDEN_RUSH);
	}

	protected void updateTime()
	{
		UpdateDisplacement();
		if (isStiff)
		{
			_stiffDuration -= LogicDeltaTime;
			if (_stiffDuration <= 0)
			{
				InterruptStiff();
			}
		}
		FrozenOutSate();
	}

	private void EnterForceControl(bool interruptAttack = true, bool playLostControlAnim = false, bool useSpecialLostControlAnim = false)
	{
		_forceControlRC++;
		CancelAiming();
		InterruptMovement();
		ExitInteractive();
		if (this is MonsterAdventureActor)
		{
			EnterLostControl(interruptAttack);
		}
		if (playLostControlAnim)
		{
			PlayLostControlAnim(useSpecialLostControlAnim);
		}
		if (interruptAttack)
		{
			InterruptAttack(force: true);
			AdventureActorBeControlledEvent adventureActorBeControlledEvent = AdventureActorBeControlledEvent.Generate();
			adventureActorBeControlledEvent.actor = this;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorBeControlledEvent);
		}
	}

	private void ExitForceControl(bool exitLostControlAnim = false)
	{
		_forceControlRC--;
		if (this is MonsterAdventureActor)
		{
			ExitLostControl();
		}
		if (exitLostControlAnim && actorHealthInfo.isAlive)
		{
			PlayIdleAnim();
		}
	}

	private void DisableMove()
	{
		_disableMoveRC++;
	}

	private void EnableMove()
	{
		_disableMoveRC--;
		if (_disableMoveRC < 0)
		{
			_disableMoveRC = 0;
			LogWarning("DisableMove与EnableMove使用不匹配，请成对使用");
		}
	}

	private void DisableMoveAgentCanMove()
	{
		_disableMoveAgentCanMoveRC++;
		if (_disableMoveAgentCanMoveRC == 1)
		{
			movAgent.canMove = false;
		}
	}

	private void EnableMoveAgentCanMove()
	{
		_disableMoveAgentCanMoveRC--;
		if (_disableMoveAgentCanMoveRC == 0)
		{
			movAgent.canMove = true;
		}
		if (_disableMoveAgentCanMoveRC < 0)
		{
			_disableMoveAgentCanMoveRC = 0;
			LogWarning("DisableMove与EnableMove使用不匹配，请成对使用");
		}
	}

	public void DisableRotate()
	{
		_disableRotateRC++;
	}

	public void EnableRotate()
	{
		_disableRotateRC--;
		if (_disableRotateRC < 0)
		{
			_disableRotateRC = 0;
			LogWarning("DisableRotate与EnableRotate使用不匹配，请成对使用");
		}
	}

	public void DisableCastDodge()
	{
		_disableCastDodgeRC++;
	}

	public void EnableCastDodge()
	{
		_disableCastDodgeRC--;
		if (_disableCastDodgeRC < 0)
		{
			_disableCastDodgeRC = 0;
			LogWarning("DisableCastDodgeRC与EnableCastDodgeRC使用不匹配，请成对使用");
		}
	}

	public void DisableCastNormal()
	{
		_disableCastNormalRC++;
	}

	public void EnableCastNormal()
	{
		_disableCastNormalRC--;
		if (_disableCastNormalRC < 0)
		{
			_disableCastNormalRC = 0;
			LogWarning("DisableCastNormal与EnableCastNormal使用不匹配，请成对使用");
		}
	}

	public void DisableCastSkill()
	{
		_disableCastSkillRC++;
	}

	public void EnableCastSkill()
	{
		_disableCastSkillRC--;
		if (_disableCastSkillRC < 0)
		{
			_disableCastSkillRC = 0;
			LogWarning("DisableCastSkill与EnableCastSkill使用不匹配，请成对使用");
		}
	}

	public void DisableCastUltra()
	{
		_disableCastUltraRC++;
	}

	public void EnableCastUltra()
	{
		_disableCastUltraRC--;
		if (_disableCastUltraRC < 0)
		{
			_disableCastUltraRC = 0;
			LogWarning("DisableCastUltra与EnableCastUltra使用不匹配，请成对使用");
		}
	}

	private void ShowMonsterHpAndAttackHint()
	{
		_hideMonsterHpAndAttackHintRC--;
		if (_hideMonsterHpAndAttackHintRC == 0 && this is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.ShowBlood(isShow: true);
			monsterAdventureActor.AttackHintShow();
		}
		if (_hideMonsterHpAndAttackHintRC < 0)
		{
			_hideMonsterHpAndAttackHintRC = 0;
			LogWarning("ShowMonsterHpAndAttackHint与HideMonsterHpAndAttackHint使用不匹配，请成对使用");
		}
	}

	private void HideMonsterHpAndAttackHint()
	{
		_hideMonsterHpAndAttackHintRC++;
		if (_hideMonsterHpAndAttackHintRC == 1 && this is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.ShowBlood(isShow: false);
			monsterAdventureActor.AttackHintHide();
		}
	}

	private bool CommonImmuneCheckForBeHit(FP strength)
	{
		if (this is DestructibleStateSingle)
		{
			return true;
		}
		if (!actorHealthInfo.isAlive)
		{
			return true;
		}
		if (beSuperArmor || beDyingSuperArmor || CheckImmCtrByBeHit() || CheckInvincibleByBeHit() || isSceneMove)
		{
			return true;
		}
		return actorInfo.weight >= strength;
	}

	private bool CheckImmCtrByBeHit()
	{
		return OnBeHitHandle?.Invoke(HotfixEnum.stateAttributeType.IMMUNE_CONTROL) ?? isImmuneControl;
	}

	private bool CheckInvincibleByBeHit()
	{
		return OnBeHitHandle?.Invoke(HotfixEnum.stateAttributeType.INVINCIBLE) ?? isInvincible;
	}

	public bool EnterStiff(FP strength, FP duration, AdventureActor fromActor = null)
	{
		if (fromActor != null && fromActor.strengthOverride >= 0)
		{
			strength = fromActor.strengthOverride;
		}
		if (CommonImmuneCheckForBeHit(strength))
		{
			return false;
		}
		if (isFrozen || isJump || isKnockBack || isAirBorne)
		{
			return false;
		}
		if (!isStiff && duration > 0)
		{
			isStiff = true;
			EnterForceControl(interruptAttack: true, playLostControlAnim: true);
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
		}
		if (duration > _stiffDuration)
		{
			_stiffDuration = duration;
		}
		return true;
	}

	public void InterruptStiff()
	{
		if (isStiff)
		{
			isStiff = false;
			_stiffDuration = 0;
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
		}
	}

	public MoveFeatureData KnockBack(TSVector2 direction, FP force, FP distance, FP strength, HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.None, AdventureActor fromActor = null)
	{
		if (fromActor != null && fromActor.strengthOverride >= 0)
		{
			strength = fromActor.strengthOverride;
		}
		if (CommonImmuneCheckForBeHit(strength))
		{
			return null;
		}
		if (isFrozen || isJump || isBondage)
		{
			return null;
		}
		if (!isKnockBack)
		{
			EnterForceControl(interruptAttack: true, playLostControlAnim: true);
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
		}
		MoveFeatureData moveFeatureData = ForceMove(force, distance, direction, isCoexist: false, changeForward: false, 40, strength, MoveType.KnockBack, ForceType.Uniform_Deceleration, ChecktKnockBack);
		if (moveFeatureData != null && !isHurtAnimOff && hurtAnimType != HitBox.HurtAnimType.None)
		{
			PlayHurtAnim();
		}
		return moveFeatureData;
	}

	private void ChecktKnockBack()
	{
		if (!isKnockBack)
		{
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
		}
	}

	public void InterruptKnockBack()
	{
		if (!isKnockBack)
		{
			return;
		}
		for (int i = 0; i < currentMoveFeatureDataLs.Count; i++)
		{
			if (currentMoveFeatureDataLs.get_Item(i).moveType == MoveType.KnockBack)
			{
				currentMoveFeatureDataLs.get_Item(i).ToStop();
			}
		}
		for (int j = 0; j < newMoveFeatureDatas.Count; j++)
		{
			if (newMoveFeatureDatas.get_Item(j).moveType == MoveType.KnockBack)
			{
				newMoveFeatureDatas.get_Item(j).ToStop();
			}
		}
	}

	public bool AirBorne(FP force, FP strength, HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.None, AdventureActor fromActor = null)
	{
		if (fromActor != null && fromActor.strengthOverride >= 0)
		{
			strength = fromActor.strengthOverride;
		}
		if (CommonImmuneCheckForBeHit(strength))
		{
			return false;
		}
		if (isFrozen || isJump || isBondage)
		{
			return false;
		}
		if (ignoreDeterministicCollision || actorInfo.moveType == HotfixEnum.actorMovType.STATIC)
		{
			return false;
		}
		if (strength > 0 && actorInfo.weight > 0)
		{
			FP weightStrengthRate = GetWeightStrengthRate(strength / actorInfo.weight);
			force *= weightStrengthRate;
		}
		if (force <= 0f)
		{
			return false;
		}
		FP fP = force;
		if (fP > _airBorneSpeed)
		{
			_airBorneSpeed = fP;
		}
		if (!isAirBorne)
		{
			EnterForceControl(interruptAttack: true, playLostControlAnim: true);
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
			_actorOriginalPositionY = tsTransform.PositionY;
			_airBorneCoroutine = StartLogicCoroutine(AirBorneCoroutine());
		}
		if (!isHurtAnimOff && hurtAnimType != HitBox.HurtAnimType.None)
		{
			PlayHurtAnim();
		}
		return true;
	}

	protected IEnumerator AirBorneCoroutine()
	{
		FP gravity = AdventureModuleController.Config.Combat_Gravity;
		while (true)
		{
			FP logicDeltaTime = LogicDeltaTime;
			FP fP = tsTransform.PositionY;
			_airBorneSpeed += gravity * logicDeltaTime;
			fP += _airBorneSpeed * logicDeltaTime;
			if (fP > AdventureModuleController.Config.Combat_MaxJumpHeight + _actorOriginalPositionY)
			{
				fP = AdventureModuleController.Config.Combat_MaxJumpHeight + _actorOriginalPositionY;
			}
			if (fP < _actorOriginalPositionY)
			{
				break;
			}
			tsTransform.PositionY = fP;
			yield return null;
		}
		tsTransform.PositionY = ((_actorOriginalPositionY >= 0) ? _actorOriginalPositionY : ((FP)0));
		_airBorneCoroutine = null;
		ExitForceControl(exitLostControlAnim: true);
		EnableMove();
		EnableRotate();
		EnableCastNormal();
		EnableCastDodge();
		EnableCastSkill();
		EnableCastUltra();
		RefreshSkillUseable();
		_airBorneSpeed = FP.Zero;
	}

	public void InterruptAirBorne()
	{
		if (isAirBorne)
		{
			StopLogicCoroutine(_airBorneCoroutine);
			_airBorneCoroutine = null;
			tsTransform.PositionY = _actorOriginalPositionY;
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
			_airBorneSpeed = FP.Zero;
		}
	}

	private void PlayBuffFX(StateEnum stateEnum)
	{
		string text = stateEnum switch
		{
			StateEnum.Stun => AdventureModuleController.Config.FX_StunFXPath, 
			StateEnum.StunWeakened => AdventureModuleController.Config.FX_StunFXPath_Weakened, 
			StateEnum.Frozen => AdventureModuleController.Config.FX_FrozenFXPath, 
			StateEnum.FrozenWeakened => AdventureModuleController.Config.FX_FrozenFXPath_Weakened, 
			StateEnum.Sleep => AdventureModuleController.Config.FX_SleepFXPath, 
			StateEnum.SleepWeakened => AdventureModuleController.Config.FX_SleepFXPath_Weakened, 
			StateEnum.Charm => AdventureModuleController.Config.FX_CharmFXPath, 
			StateEnum.CharmWeakened => AdventureModuleController.Config.FX_CharmFXPath_Weakened, 
			StateEnum.Terror => AdventureModuleController.Config.FX_TerrorFXPath, 
			StateEnum.TerrorWeakened => AdventureModuleController.Config.FX_TerrorFXPath_Weakened, 
			StateEnum.Taunt => AdventureModuleController.Config.FX_TauntFXPath, 
			StateEnum.TauntWeakened => AdventureModuleController.Config.FX_TauntFXPath_Weakened, 
			StateEnum.Bondage => AdventureModuleController.Config.FX_BondageFXPath, 
			StateEnum.BondageWeakened => AdventureModuleController.Config.FX_BondageFXPath_Weakened, 
			StateEnum.Silence => AdventureModuleController.Config.FX_SilenceFXPath, 
			StateEnum.SilenceWeakened => AdventureModuleController.Config.FX_SilenceFXPath_Weakened, 
			StateEnum.Chaos => AdventureModuleController.Config.FX_ChaosFXPath, 
			StateEnum.ChaosWeakened => AdventureModuleController.Config.FX_ChaosFXPath_Weakened, 
			StateEnum.Blindness => AdventureModuleController.Config.FX_BlindnessFXPath, 
			StateEnum.BlindnessWeakened => AdventureModuleController.Config.FX_BlindnessFXPath_Weakened, 
			StateEnum.ReduceFOV => AdventureModuleController.Config.FX_ReduceFOVFXPath, 
			_ => "", 
		};
		if (dicBuffFx.ContainsKey(stateEnum))
		{
			AdventureBuffFXHandler value = AdventureFXManager.PlayBuffFX(text, gameObject);
			dicBuffFx.set_Item(stateEnum, value);
		}
		else if (!string.IsNullOrEmpty(text))
		{
			AdventureBuffFXHandler adventureBuffFXHandler = AdventureFXManager.PlayBuffFX(text, gameObject);
			if (adventureBuffFXHandler != null)
			{
				dicBuffFx.Add(stateEnum, adventureBuffFXHandler);
			}
		}
	}

	private void StopBuffFX(StateEnum stateEnum)
	{
		if (dicBuffFx.TryGetValue(stateEnum, out var value))
		{
			value?.StopFX();
		}
	}

	public bool IsSearchableByEnemy(AdventureActor other)
	{
		if (other == null)
		{
			return false;
		}
		if (!other.IsConfrontWith(this))
		{
			return false;
		}
		if (isBattleOut || isUnparalleled || searchedImmunity || isHideModel || isSneak || isHideOut || isPenetrate)
		{
			return false;
		}
		return true;
	}

	public bool IsSearchableByFriend(AdventureActor other)
	{
		if (other == null)
		{
			return false;
		}
		if (!other.IsFriendlyWith(this))
		{
			return false;
		}
		return true;
	}

	public bool IsAoeHittableByEnemy(AdventureActor other)
	{
		if (other == null)
		{
			return false;
		}
		if (!other.IsConfrontWith(this))
		{
			return false;
		}
		if (isBattleOut || isUnparalleled || isHideOut || isPenetrate || isDodge)
		{
			return false;
		}
		return true;
	}

	public bool IsAoeHittableByFriend(AdventureActor other)
	{
		if (other == null)
		{
			return false;
		}
		if (!other.IsFriendlyWith(this) && !other.IsNeutralWith(this))
		{
			return false;
		}
		if (isBattleOut || isUnparalleled || isDodge)
		{
			return false;
		}
		return true;
	}

	public bool CheckCost_BeHit()
	{
		if (isBattleOut)
		{
			return true;
		}
		Func<HotfixEnum.stateAttributeType, bool> onDamageHandle = OnDamageHandle;
		if (onDamageHandle != null && onDamageHandle(HotfixEnum.stateAttributeType.UNPARALLELED))
		{
			return true;
		}
		Func<HotfixEnum.stateAttributeType, bool> onDamageHandle2 = OnDamageHandle;
		if (onDamageHandle2 != null && onDamageHandle2(HotfixEnum.stateAttributeType.INVINCIBLE))
		{
			return true;
		}
		return false;
	}

	public bool CheckCost_AddDeBuff()
	{
		if (isBattleOut)
		{
			return true;
		}
		Func<HotfixEnum.stateAttributeType, bool> onBuffHandle = OnBuffHandle;
		if (onBuffHandle != null && onBuffHandle(HotfixEnum.stateAttributeType.UNPARALLELED))
		{
			return true;
		}
		Func<HotfixEnum.stateAttributeType, bool> onBuffHandle2 = OnBuffHandle;
		if (onBuffHandle2 != null && onBuffHandle2(HotfixEnum.stateAttributeType.INVINCIBLE))
		{
			return true;
		}
		return false;
	}

	private void OnEnableSuperArmor(int referenceCount)
	{
		if (referenceCount == 1)
		{
			HurtAnimOff();
			PlaySuperArmorCueEffect();
		}
	}

	private void OnDisableSuperArmor(int referenceCount)
	{
		if (referenceCount == 0)
		{
			HurtAnimOn();
			StopSuperArmorCueEffect();
		}
	}

	public void EnableSuperArmor()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SUA);
	}

	public void DisableSuperArmor()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SUA);
	}

	public void InterruptSuperArmor()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SUA);
	}

	private void OnEnableDyingSuperArmor(int referenceCount)
	{
		if (referenceCount == 1)
		{
			HurtAnimOff();
		}
	}

	private void OnDisableDyingSuperArmor(int referenceCount)
	{
		if (referenceCount == 0)
		{
			HurtAnimOn();
		}
	}

	public void EnableDyingSuperArmor()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.DYINGSUA);
	}

	public void DisableDyingSuperArmor()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.DYINGSUA);
	}

	public void InterruptDyingSuperArmor()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.DYINGSUA);
	}

	private void OnEnableImmuneControl(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayImmuneControlCueEffect();
		}
	}

	private void OnDisableImmuneControl(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopImmuneControlCueEffect();
		}
	}

	public void EnableImmuneControl()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.IMMUNE_CONTROL);
	}

	public void DisableImmuneControl()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.IMMUNE_CONTROL);
	}

	public void InterruptImmuneControl()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.IMMUNE_CONTROL);
	}

	private void OnEnableInvincible(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayInvincibleCueEffect();
		}
	}

	private void OnDisableInvincible(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopInvincibleCueEffect();
		}
	}

	public void EnableInvincible()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.INVINCIBLE);
	}

	public void DisableInvincible()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.INVINCIBLE);
	}

	public void InterruptInvincible()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.INVINCIBLE);
	}

	private bool CommonImmuneCheckForSceneControl()
	{
		if (this is DestructibleStateSingle)
		{
			return true;
		}
		if (!actorHealthInfo.isAlive)
		{
			return true;
		}
		return false;
	}

	public bool EnterSceneMove(TSVector direction, FP startSpeed, FP acceleratedSpeed, FP maxDistance, Action moveFinishCallBack = null, Action interruptCallBack = null)
	{
		if (CommonImmuneCheckForSceneControl())
		{
			return false;
		}
		InterrupDisplacement();
		if (!isSceneMove)
		{
			EnterForceControl();
			DisableMovementAgent();
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
		}
		animatorController.SetBool(AnimationParameterNames.IsSceneMove, value: true);
		if (_sceneMoveCor != null)
		{
			if (!_sceneMoveCor.finished)
			{
				_scnenMoveInterruptCallBack?.Invoke();
			}
			StopLogicCoroutine(_sceneMoveCor);
		}
		_scnenMoveInterruptCallBack = interruptCallBack;
		_sceneMoveCor = StartLogicCoroutine(SceneMove(direction, startSpeed, acceleratedSpeed, maxDistance, moveFinishCallBack));
		return true;
	}

	public void ExitSceneMove()
	{
		if (!isSceneMove)
		{
			return;
		}
		ExitForceControl(exitLostControlAnim: true);
		EnableMovementAgent();
		EnableMove();
		EnableRotate();
		EnableCastNormal();
		EnableCastDodge();
		EnableCastSkill();
		EnableCastUltra();
		RefreshSkillUseable();
		animatorController.SetBool(AnimationParameterNames.IsSceneMove, value: false);
		if (_sceneMoveCor != null)
		{
			if (!_sceneMoveCor.finished)
			{
				_scnenMoveInterruptCallBack?.Invoke();
			}
			StopLogicCoroutine(_sceneMoveCor);
		}
		_sceneMoveCor = null;
		_scnenMoveInterruptCallBack = null;
	}

	public void InterruptSceneMove()
	{
		if (isSceneMove)
		{
			ExitForceControl(exitLostControlAnim: true);
			EnableMovementAgent();
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
			animatorController.SetBool(AnimationParameterNames.IsSceneMove, value: false);
			StopLogicCoroutine(_sceneMoveCor);
			_sceneMoveCor = null;
			_scnenMoveInterruptCallBack = null;
		}
	}

	private IEnumerator SceneMove(TSVector direction, FP startSpeed, FP acceleratedSpeed, FP maxDistance, Action finishCallBack = null)
	{
		if (comboGroup != null && comboGroup.useSceneMoveAnimationMotion)
		{
			FP time = 0;
			while (time < comboGroup.sceneMoveAnimationMotionTime)
			{
				time += LogicDeltaTime;
				yield return null;
			}
		}
		else
		{
			FP time = 0;
			FP speed = startSpeed;
			direction.Normalize();
			while (time < maxDistance)
			{
				FP fP = speed * LogicDeltaTime;
				if (time + fP > maxDistance)
				{
					fP = maxDistance - time;
				}
				time += fP;
				TSVector tSVector = fP * direction;
				tsTransform.Position += new TSVector2(tSVector.x, tSVector.z);
				tsTransform.PositionY += tSVector.y;
				if (acceleratedSpeed != 0)
				{
					speed += acceleratedSpeed * LogicDeltaTime;
					if (acceleratedSpeed < 0 && speed < 0)
					{
						speed = 0;
					}
				}
				yield return null;
			}
		}
		finishCallBack?.Invoke();
	}

	private void AddAllStateActions()
	{
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SEARCHED_IMMUNITY, OnEnableSearchedImmunity, OnDisableSearchedImmunity);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.CLOSE_MOVE_BLOCK, OnEnableCloseBlock, OnDisableCloseBlock);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.HIDE_MODEL, OnEnableHideModel, OnDisableHideModel);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.HIDE_OUT, OnEnableHideOut, OnDisableHideOut);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SNEAK, OnEnableSneak, OnDisableSneak);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.BATTLE_OUT, OnEnableBattleOut, OnDisableBattleOut);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.PENETRATE, OnEnablePenetrate, OnDisablePenetrate);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.UNPARALLELED, OnEnableUnparalleled, OnDisableUnparalleled);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.DODGE, OnEnableDodge, OnDisableDodge);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.INDEFENSE, OnEnableDefense, OnDisableDefense);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.STUN, OnEnterStun, OnExitStun, CheckEnterStun);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.STUN_WEAKENED, OnEnterStunWeakened, OnExitStunWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.FROZEN, OnEnterFrozen, OnExitFrozen, CheckEnterFrozen, OnInterruptFrozen);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.FROZEN_WEAKENED, OnEnterFrozenWeakened, OnExitFrozenWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SLEEP, OnEnterSleep, OnExitSleep, CheckEnterSleep);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SLEEP_WEAKENED, OnEnterSleepWeakened, OnExitSleepWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.CHARM, OnEnterCharm, OnExitCharm, CheckEnterCharm);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.CHARM_WEAKENED, OnEnterCharmWeakened, OnExitCharmWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.TERROR, OnEnterTerror, OnExitTerror, CheckEnterTerror);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.TERROR_WEAKENED, OnEnterTerrorWeakened, OnExitTerrorWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.TOUGHNESS_BORKEN, OnEnterToughnessBrokenState, OnExitToughnessBrokenState);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SUA, OnEnableSuperArmor, OnDisableSuperArmor);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.DYINGSUA, OnEnableDyingSuperArmor, OnDisableDyingSuperArmor);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.IMMUNE_CONTROL, OnEnableImmuneControl, OnDisableImmuneControl);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.INVINCIBLE, OnEnableInvincible, OnDisableInvincible);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.TAUNT, OnEnterTaunt, OnExitTaunt, CheckEnterTaunt);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.TAUNT_WEAKENED, OnEnterTauntWeakened, OnExitTauntWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.BONDAGE, OnEnterBondage, OnExitBondage, CheckEnterBondage);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.BONDAGE_WEAKENED, OnEnterBondageWeakened, OnExitBondageWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SILENCE, OnEnterSilence, OnExitSilence, CheckEnterSilence);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.SILENCE_WEAKENED, OnEnterSilenceWeakened, OnExitSilenceWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.CHAOS, OnEnterChaos, OnExitChaos, CheckEnterChaos);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.CHAOS_WEAKENED, OnEnterChaosWeakened, OnExitChaosWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.BLINDNESS, OnEnterBlindness, OnExitBlindness, CheckEnterBlindness);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED, OnEnterBlindnessWeakened, OnExitBlindnessWeakened);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.REDUCE_FOV, OnEnterReduceFOV, OnExitReduceFOV, CheckEnterReduceFOV);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.DAMAGE_IMM);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.CURE_IMM);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.IMMUNE_KILL);
		stateAttributeList.AddAction(HotfixEnum.stateAttributeType.DODGE_CROSS_OBSTACLE);
	}

	private void OnEnableSearchedImmunity(int referenceCount)
	{
		if (referenceCount == 1)
		{
			AdventureSearchImmunityStateChangedEvent adventureSearchImmunityStateChangedEvent = AdventureSearchImmunityStateChangedEvent.Generate();
			adventureSearchImmunityStateChangedEvent.actor = this;
			adventureSearchImmunityStateChangedEvent.searchImmunity = true;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSearchImmunityStateChangedEvent);
		}
	}

	private void OnDisableSearchedImmunity(int referenceCount)
	{
		if (referenceCount == 0)
		{
			AdventureSearchImmunityStateChangedEvent adventureSearchImmunityStateChangedEvent = AdventureSearchImmunityStateChangedEvent.Generate();
			adventureSearchImmunityStateChangedEvent.actor = this;
			adventureSearchImmunityStateChangedEvent.searchImmunity = false;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSearchImmunityStateChangedEvent);
		}
	}

	public void EnableSearchedImmunity()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SEARCHED_IMMUNITY);
	}

	public void DisableSearchedImmunity()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SEARCHED_IMMUNITY);
	}

	public void InterruptSearchedImmunity()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SEARCHED_IMMUNITY);
	}

	private void OnEnableCloseBlock(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PauseMovementAvoidance();
			PauseMovementBlock();
		}
	}

	private void OnDisableCloseBlock(int referenceCount)
	{
		if (referenceCount == 0)
		{
			ResumeMovementAvoidance();
			ResumeMovementBlock();
		}
	}

	public void EnableCloseBlock()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.CLOSE_MOVE_BLOCK);
	}

	public void DisableCloseBlock()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.CLOSE_MOVE_BLOCK);
	}

	public void InterruptCloseBlock()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.CLOSE_MOVE_BLOCK);
	}

	private void OnEnableHideModel(int referenceCount)
	{
		if (referenceCount == 1)
		{
			Hide();
			EnableSearchedImmunity();
			PauseMovementAvoidance();
			PauseMovementBlock();
			HideMonsterHpAndAttackHint();
			if (this is PlayerAdventureActor playerAdventureActor && SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == playerAdventureActor)
			{
				SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
			}
		}
	}

	private void OnDisableHideModel(int referenceCount)
	{
		if (referenceCount == 0)
		{
			Visible();
			DisableSearchedImmunity();
			ResumeMovementAvoidance();
			ResumeMovementBlock();
			ShowMonsterHpAndAttackHint();
			if (this is PlayerAdventureActor playerAdventureActor && SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == playerAdventureActor)
			{
				SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
			}
		}
	}

	public void EnableHideModel()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.HIDE_MODEL);
	}

	public void DisableHideModel()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.HIDE_MODEL);
	}

	public void InterruptHideModel()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.HIDE_MODEL);
	}

	private void OnEnableSneak(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnableSearchedImmunity();
			PauseMovementAvoidance();
			PauseMovementBlock();
			TransparentFadeIn();
		}
	}

	private void OnDisableSneak(int referenceCount)
	{
		if (referenceCount == 0)
		{
			DisableSearchedImmunity();
			ResumeMovementAvoidance();
			ResumeMovementBlock();
			TransparentFadeOut();
		}
	}

	public void EnableSneak()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SNEAK);
	}

	public void DisableSneak()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SNEAK);
	}

	public void InterruptSneak()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SNEAK);
	}

	private void OnEnableHideOut(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnableSearchedImmunity();
			PauseMovementAvoidance();
			PauseMovementBlock();
			TransparentFadeIn();
		}
	}

	private void OnDisableHideOut(int referenceCount)
	{
		if (referenceCount == 0)
		{
			DisableSearchedImmunity();
			ResumeMovementAvoidance();
			ResumeMovementBlock();
			TransparentFadeOut();
		}
	}

	public void EnableHideOut()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.HIDE_OUT);
	}

	public void DisableHideOut()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.HIDE_OUT);
	}

	public void InterruptHideOut()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.HIDE_OUT);
	}

	private void OnEnableBattleOut(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnableSearchedImmunity();
			if (this is MonsterAdventureActor monsterAdventureActor)
			{
				monsterAdventureActor.SetBlockPriorityToStatic();
			}
			HideMonsterHpAndAttackHint();
		}
	}

	private void OnDisableBattleOut(int referenceCount)
	{
		if (referenceCount == 0)
		{
			DisableSearchedImmunity();
			if (this is MonsterAdventureActor monsterAdventureActor)
			{
				monsterAdventureActor.ResetBlockPriority();
			}
			ShowMonsterHpAndAttackHint();
		}
	}

	public void EnableBattleOut()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.BATTLE_OUT);
	}

	public void DisableBattleOut()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.BATTLE_OUT);
	}

	public void InterruptBattleOut()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.BATTLE_OUT);
	}

	public void EnterWitchTime(FP duration, bool includeSelf = false)
	{
		if (duration <= 0)
		{
			return;
		}
		SceneSingleton<AdventurePlayerController>.Instance?.EndCurrentWitchTime();
		if (!includeSelf)
		{
			isWitchTimeOwner = true;
			_witchtimeAttackTarget = (AdventureActor)attackTarget;
			if (this is PlayerAdventureActor { isAssist: not false } playerAdventureActor)
			{
				_witchtimeAttackTarget = playerAdventureActor.assistWitchTimeTarget;
			}
			if (_witchtimeAttackTarget != null && _witchtimeAttackTarget.actorHealthInfo.isAlive)
			{
				_witchtimeAttackTarget.isWitchTimeAttacker = true;
			}
		}
		FP frozenTime_Scale = AdventureModuleController.Config.FrozenTime_Scale;
		_witchtimeTimeControlHandler = ModuleController<AdventureModuleController>.Instance?.LogicTimeScale(frozenTime_Scale, duration, ExitWitchTime);
		if (!includeSelf)
		{
			ignoreGlobalLogicTimeScale = true;
		}
		AdventureActorEnterWitchTime adventureActorEnterWitchTime = AdventureActorEnterWitchTime.Generate();
		adventureActorEnterWitchTime.sender = this;
		adventureActorEnterWitchTime.owner = (isWitchTimeOwner ? this : null);
		adventureActorEnterWitchTime.attackTarget = _witchtimeAttackTarget;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEnterWitchTime);
	}

	public void ExitWitchTime()
	{
		if (_witchtimeTimeControlHandler != null)
		{
			_witchtimeTimeControlHandler.Stop();
			_witchtimeTimeControlHandler = null;
			ignoreGlobalLogicTimeScale = false;
			ModuleController<AdventureModuleController>.Instance?.SetForzenTimeChildren(iAdd: false);
			AdventureActorExitWitchTime adventureActorExitWitchTime = AdventureActorExitWitchTime.Generate();
			adventureActorExitWitchTime.sender = this;
			adventureActorExitWitchTime.owner = (isWitchTimeOwner ? this : null);
			adventureActorExitWitchTime.attackTarget = _witchtimeAttackTarget;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorExitWitchTime);
			isWitchTimeOwner = false;
			if (_witchtimeAttackTarget != null)
			{
				_witchtimeAttackTarget.isWitchTimeAttacker = false;
				_witchtimeAttackTarget = null;
			}
		}
		isWitchTimeAttacker = false;
	}

	public void InterruptWitchTime()
	{
		ExitWitchTime();
	}

	private void OnEnablePenetrate(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnableSearchedImmunity();
			PauseMovementAvoidance();
			PauseMovementBlock();
		}
	}

	private void OnDisablePenetrate(int referenceCount)
	{
		if (referenceCount == 0)
		{
			DisableSearchedImmunity();
			ResumeMovementAvoidance();
			ResumeMovementBlock();
		}
	}

	public void EnablePenetrate()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.PENETRATE);
	}

	public void DisablePenetrate()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.PENETRATE);
	}

	public void InterruptPenetrate()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.PENETRATE);
	}

	private void OnEnableUnparalleled(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnableSearchedImmunity();
			HideMonsterHpAndAttackHint();
		}
	}

	private void OnDisableUnparalleled(int referenceCount)
	{
		if (referenceCount == 0)
		{
			DisableSearchedImmunity();
			ShowMonsterHpAndAttackHint();
		}
	}

	public void EnableUnparalleled()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.UNPARALLELED);
	}

	public void DisableUnparalleled()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.UNPARALLELED);
	}

	public void InterruptUnparalleled()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.UNPARALLELED);
	}

	private void OnEnableDodge(int referenceCount)
	{
		_ = 1;
	}

	private void OnDisableDodge(int referenceCount)
	{
	}

	public void EnableDodge()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.DODGE);
	}

	public void DisableDodge()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.DODGE);
	}

	public void InterruptDodge()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.DODGE);
	}

	private void OnEnableDefense(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PauseMovementAvoidance();
			PauseMovementBlock();
		}
	}

	private void OnDisableDefense(int referenceCount)
	{
		if (referenceCount == 0)
		{
			ResumeMovementAvoidance();
			ResumeMovementBlock();
		}
	}

	public void EnableDefense()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.INDEFENSE);
	}

	public void DisableDefense()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.INDEFENSE);
	}

	public void InterruptDefense()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.INDEFENSE);
	}

	private bool CommonImmuneCheckForSpecialControl(FP strength)
	{
		if (this is DestructibleStateSingle)
		{
			return true;
		}
		if (!actorHealthInfo.isAlive)
		{
			return true;
		}
		if (CheckImmCtrBySpecialControl() || CheckInvincibleBySpecialControl() || isSceneMove)
		{
			return true;
		}
		return actorInfo.weight >= strength;
	}

	private bool CheckImmCtrBySpecialControl()
	{
		Func<HotfixEnum.stateAttributeType, bool> onSpecialControlHandle = OnSpecialControlHandle;
		if (onSpecialControlHandle == null || !onSpecialControlHandle(HotfixEnum.stateAttributeType.IMMUNE_CONTROL))
		{
			return isImmuneControl;
		}
		return true;
	}

	private bool CheckInvincibleBySpecialControl()
	{
		Func<HotfixEnum.stateAttributeType, bool> onSpecialControlHandle = OnSpecialControlHandle;
		if (onSpecialControlHandle == null || !onSpecialControlHandle(HotfixEnum.stateAttributeType.INVINCIBLE))
		{
			return isInvincible;
		}
		return true;
	}

	public bool EnterPull(FP strength, FP moveSpeed, FP moveDistance, TSVector2 moveDirection, bool isCoExist, bool isChangeForward, int moveLevel, AdventureActor fromActor = null)
	{
		if (fromActor != null && fromActor.strengthOverride >= 0)
		{
			strength = fromActor.strengthOverride;
		}
		if (CommonImmuneCheckForSpecialControl(strength))
		{
			return false;
		}
		if (isJump || isKnockBack || isAirBorne || isForceMove)
		{
			return false;
		}
		return ForceMove(moveSpeed, moveDistance, moveDirection, isCoExist, isChangeForward, moveLevel, strength, MoveType.Pull) != null;
	}

	public void InterruptPull()
	{
		if (!isPull)
		{
			return;
		}
		for (int i = 0; i < currentMoveFeatureDataLs.Count; i++)
		{
			if (currentMoveFeatureDataLs.get_Item(i).moveType == MoveType.Pull)
			{
				currentMoveFeatureDataLs.get_Item(i).ToStop();
			}
		}
		for (int j = 0; j < newMoveFeatureDatas.Count; j++)
		{
			if (newMoveFeatureDatas.get_Item(j).moveType == MoveType.Pull)
			{
				newMoveFeatureDatas.get_Item(j).ToStop();
			}
		}
	}

	public bool EnterForceMove(FP strength, FP moveSpeed, FP moveDistance, TSVector2 moveDirection, bool isCoExist, bool isChangeForward, int moveLevel, AdventureActor fromActor = null)
	{
		if (fromActor != null && fromActor.strengthOverride >= 0)
		{
			strength = fromActor.strengthOverride;
		}
		if (CommonImmuneCheckForSpecialControl(strength))
		{
			return false;
		}
		if (isJump || isKnockBack || isAirBorne || isPull)
		{
			return false;
		}
		if (!isForceMove)
		{
			EnterForceControl(interruptAttack: true, playLostControlAnim: true);
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
		}
		return ForceMove(moveSpeed, moveDistance, moveDirection, isCoExist, isChangeForward, moveLevel, strength, MoveType.Normal, ForceType.Constant_Speed, CheckForceMove) != null;
	}

	private void CheckForceMove()
	{
		if (!isForceMove)
		{
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
		}
	}

	public void InterruptForceMove()
	{
		if (!isForceMove)
		{
			return;
		}
		for (int i = 0; i < currentMoveFeatureDataLs.Count; i++)
		{
			if (currentMoveFeatureDataLs.get_Item(i).moveType == MoveType.Normal)
			{
				currentMoveFeatureDataLs.get_Item(i).ToStop();
			}
		}
		for (int j = 0; j < newMoveFeatureDatas.Count; j++)
		{
			if (newMoveFeatureDatas.get_Item(j).moveType == MoveType.Normal)
			{
				newMoveFeatureDatas.get_Item(j).ToStop();
			}
		}
	}

	public MoveFeatureData ForceMove(FP moveSpeed, FP moveDistance, TSVector2 moveDirection, bool isCoexist, bool changeForward, int moveLevel, FP strength, MoveType moveType = MoveType.Normal, ForceType forceType = ForceType.Constant_Speed, Action callback = null)
	{
		MoveFeatureData moveFeatureData = SceneSingleton<ActorGroupManager>.Instance.PopMoveFData();
		moveFeatureData.moveSpeed = moveSpeed;
		moveFeatureData.moveDistance = moveDistance;
		moveFeatureData.moveDirection = moveDirection;
		moveFeatureData.isCoexist = isCoexist;
		moveFeatureData.changeForward = changeForward;
		moveFeatureData.moveLevel = moveLevel;
		moveFeatureData.strength = strength;
		moveFeatureData.moveType = moveType;
		moveFeatureData.forceType = forceType;
		moveFeatureData.callback = callback;
		if (!CanExecuteCheck(moveFeatureData))
		{
			SceneSingleton<ActorGroupManager>.Instance.PushMoveFData(moveFeatureData);
			return null;
		}
		if (actorInfo.weight > 0 && moveFeatureData.strength > 0 && Singleton<HotfixDataController>.Instance.WeightParameterData.Count > 2)
		{
			FP weightStrengthRate = GetWeightStrengthRate(moveFeatureData.strength / actorInfo.weight);
			if (moveFeatureData.moveDistance > 0)
			{
				moveFeatureData.moveDistance *= weightStrengthRate;
			}
			else
			{
				moveFeatureData.moveSpeed *= weightStrengthRate;
			}
		}
		moveFeatureData.OnStart(this);
		return moveFeatureData;
	}

	public void InterrupDisplacement()
	{
		if (currentMoveData != null && currentMoveData.leftTime >= 0)
		{
			ResetMoveDatas(force: true);
		}
		currentMoveFeatureDataLs.Clear();
		newMoveFeatureDatas.Clear();
	}

	private FP GetWeightStrengthRate(FP _proportion)
	{
		if (_proportion < FP.FromMyriad(Singleton<HotfixDataController>.Instance.WeightParameterData.get_Item(0).Proportion))
		{
			return FP.FromMyriad(Singleton<HotfixDataController>.Instance.WeightParameterData.get_Item(0).Effect);
		}
		if (_proportion == FP.FromMyriad(Singleton<HotfixDataController>.Instance.WeightParameterData.get_Item(1).Proportion))
		{
			return FP.FromMyriad(Singleton<HotfixDataController>.Instance.WeightParameterData.get_Item(1).Effect);
		}
		if (_proportion > FP.FromMyriad(Singleton<HotfixDataController>.Instance.WeightParameterData.get_Item(2).Proportion))
		{
			return FP.FromMyriad(Singleton<HotfixDataController>.Instance.WeightParameterData.get_Item(2).Effect);
		}
		return 1;
	}

	private bool CanExecuteCheck(MoveFeatureData _moveFeatureData)
	{
		if (this is DestructibleStateSingle)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		if (isFrozen || isJump)
		{
			return false;
		}
		if (isInvincible)
		{
			return false;
		}
		if (_moveFeatureData.moveType == MoveType.KnockBack)
		{
			if (ignoreDeterministicCollision)
			{
				return false;
			}
			if (isInvincible || isImmuneControl || beSuperArmor || beDyingSuperArmor)
			{
				return false;
			}
		}
		if (isBondage)
		{
			return false;
		}
		if (actorInfo.moveType == HotfixEnum.actorMovType.STATIC)
		{
			return false;
		}
		if (_moveFeatureData.moveSpeed <= 0f)
		{
			return false;
		}
		return _moveFeatureData.moveDistance >= 0f;
	}

	protected void AddToMoveDatas(MoveFeatureData _moveFeatureData)
	{
		if (_moveFeatureData == null)
		{
			return;
		}
		InitCurrentMoveData();
		if (currentMoveData.leftTime >= 0)
		{
			if (!currentMoveData.isCoexist || !_moveFeatureData.isCoexist)
			{
				if (_moveFeatureData.moveLevel >= currentMoveData.moveLevel)
				{
					newMoveFeatureDatas.Add(_moveFeatureData);
				}
				else
				{
					SceneSingleton<ActorGroupManager>.Instance.PushMoveFData(_moveFeatureData);
				}
				return;
			}
			if (_moveFeatureData.moveLevel < currentMoveData.moveLevel)
			{
				_moveFeatureData.waitList = true;
			}
			newMoveFeatureDatas.Add(_moveFeatureData);
		}
		else
		{
			newMoveFeatureDatas.Add(_moveFeatureData);
		}
	}

	protected void RefreshCurrentMoveDatas(bool force = false)
	{
		if (currentMoveData == null || (!force && newMoveFeatureDatas.Count < 1 && currentMoveData.leftTime >= 0))
		{
			return;
		}
		ResetMoveDatas();
		if (newMoveFeatureDatas.Count > 0)
		{
			for (int i = 0; i < newMoveFeatureDatas.Count; i++)
			{
				currentMoveFeatureDataLs.Add(newMoveFeatureDatas.get_Item(i));
			}
			newMoveFeatureDatas.Clear();
		}
		if (currentMoveFeatureDataLs.Count > 0)
		{
			bool flag = currentMoveData.leftTime < 0;
			for (int j = 0; j < currentMoveFeatureDataLs.Count; j++)
			{
				if (flag && currentMoveFeatureDataLs.get_Item(j).waitList)
				{
					currentMoveFeatureDataLs.get_Item(j).waitList = false;
				}
				if (currentMoveFeatureDataLs.get_Item(j).waitList)
				{
					continue;
				}
				if (currentMoveFeatureDataLs.get_Item(j).moveLevel < 0 || currentMoveFeatureDataLs.get_Item(j).moveLevel > currentMoveData.moveLevel)
				{
					currentMoveData.moveLevel = currentMoveFeatureDataLs.get_Item(j).moveLevel;
					currentMoveData.moveSpeed = currentMoveFeatureDataLs.get_Item(j).moveSpeed;
					currentMoveData.isCoexist = currentMoveFeatureDataLs.get_Item(j).isCoexist;
					currentMoveData.changeForward = currentMoveFeatureDataLs.get_Item(j).changeForward;
					currentMoveData.moveDistance = currentMoveFeatureDataLs.get_Item(j).moveDistance;
					currentMoveData.moveType = currentMoveFeatureDataLs.get_Item(j).moveType;
					currentMoveData.forceType = currentMoveFeatureDataLs.get_Item(j).forceType;
					currentMoveData.moveDirection = TSVector2.Normalize(currentMoveFeatureDataLs.get_Item(j).moveDirection);
					currentMoveData.leftTime = currentMoveFeatureDataLs.get_Item(j).leftTime;
				}
				else if (currentMoveFeatureDataLs.get_Item(j).moveLevel == currentMoveData.moveLevel)
				{
					if (currentMoveFeatureDataLs.get_Item(j).forceType != ForceType.Constant_Speed)
					{
						currentMoveData.forceType = currentMoveFeatureDataLs.get_Item(j).forceType;
					}
					if (currentMoveFeatureDataLs.get_Item(j).moveType != MoveType.Normal)
					{
						currentMoveData.moveType = currentMoveFeatureDataLs.get_Item(j).moveType;
					}
					if (currentMoveFeatureDataLs.get_Item(j).leftTime < currentMoveData.leftTime)
					{
						currentMoveData.leftTime = currentMoveFeatureDataLs.get_Item(j).leftTime;
					}
					if (!currentMoveData.changeForward)
					{
						currentMoveData.changeForward = currentMoveFeatureDataLs.get_Item(j).changeForward;
					}
					TSVector2 tSVector = TSVector2.Normalize(currentMoveFeatureDataLs.get_Item(j).moveDirection);
					tSVector = currentMoveData.moveDirection * currentMoveData.moveSpeed + tSVector * currentMoveFeatureDataLs.get_Item(j).moveSpeed;
					currentMoveData.moveDirection = TSVector2.Normalize(tSVector);
					currentMoveData.moveSpeed = tSVector.magnitude;
				}
			}
		}
		if (currentMoveData.leftTime >= 0 && currentMoveData.moveDistance > 0 && currentMoveData.moveLevel >= movementLevel)
		{
			acceleration = -1f * (currentMoveData.moveSpeed / currentMoveData.leftTime);
			SyncMovementLocation(clearPath: false);
		}
	}

	protected void ResetMoveDatas(bool force = false)
	{
		if (currentMoveData == null)
		{
			return;
		}
		if ((moveDuration > 0) | force)
		{
			for (int num = currentMoveFeatureDataLs.Count - 1; num > -1; num--)
			{
				currentMoveFeatureDataLs.get_Item(num).leftTime -= moveDuration;
				if (!(currentMoveFeatureDataLs.get_Item(num).leftTime >= 0) || force)
				{
					MoveFeatureData moveData = currentMoveFeatureDataLs.get_Item(num);
					currentMoveFeatureDataLs.RemoveAt(num);
					SceneSingleton<ActorGroupManager>.Instance.PushMoveFData(moveData);
				}
			}
		}
		moveDuration = 0;
		currentMoveData.leftTime = -1f;
		InitCurrentMoveData();
	}

	protected void InitCurrentMoveData(MoveFeatureData _moveFeatureData = null)
	{
		if (currentMoveData == null)
		{
			currentMoveData = new MoveFeatureData();
		}
		if (currentMoveData.leftTime < 0)
		{
			currentMoveData.InitData();
			currentMoveData.moveLevel = -1;
		}
	}

	public void UpdateDisplacement()
	{
		RefreshCurrentMoveDatas();
		if (currentMoveData == null || !(currentMoveData.leftTime >= 0))
		{
			return;
		}
		if (currentMoveData.moveLevel >= movementLevel)
		{
			externalForce = currentMoveData.moveDirection * currentMoveData.moveSpeed;
			if (currentMoveData.forceType == ForceType.Uniform_Deceleration && !isAirBorne)
			{
				currentMoveData.moveSpeed += acceleration * LogicDeltaTime;
			}
			if (currentMoveData.changeForward)
			{
				velocityDirection = currentMoveData.moveDirection;
			}
		}
		currentMoveData.leftTime -= LogicDeltaTime;
		moveDuration += LogicDeltaTime;
		if (currentMoveData.leftTime < 0)
		{
			RefreshCurrentMoveDatas();
		}
	}

	public void InterruptStrongControl()
	{
		for (int i = 0; i < strongControlStatusEffects.Count; i++)
		{
			stateAttributeList?.Interrupt(strongControlStatusEffects.get_Item(i));
		}
	}

	private bool CommonImmuneCheckForStrongControl()
	{
		if (this is DestructibleStateSingle)
		{
			return true;
		}
		if (!actorHealthInfo.isAlive)
		{
			return true;
		}
		if (!beSuperArmor && !beDyingSuperArmor && !CheckImmCtrByStrongControl())
		{
			return CheckInvincibleByStrongControl();
		}
		return true;
	}

	private bool CheckImmCtrByStrongControl()
	{
		return OnStrongControlHandle?.Invoke(HotfixEnum.stateAttributeType.IMMUNE_CONTROL) ?? isImmuneControl;
	}

	private bool CheckInvincibleByStrongControl()
	{
		return OnStrongControlHandle?.Invoke(HotfixEnum.stateAttributeType.INVINCIBLE) ?? isInvincible;
	}

	private void OnEnterStun(int referenceCount)
	{
		if (referenceCount != 1)
		{
			return;
		}
		if (_stunSpecialLostControlNode != null)
		{
			StopLogicCoroutine(_stunSpecialLostControlNode);
			_stunSpecialLostControlNode = null;
			if (!_isStunSpecialLostControlFinish)
			{
				ExitLostControl();
				if (!isToughnessBrokenState)
				{
					ShowSpecialLostControlLayer(show: false);
				}
			}
		}
		_enterStunTime = LogicTime;
		SyncMovementLocation();
		bool useSpecialLostControlAnim = !(this is PlayerAdventureActor);
		EnterForceControl(interruptAttack: true, playLostControlAnim: true, useSpecialLostControlAnim);
		DisableMove();
		DisableRotate();
		DisableCastNormal();
		DisableCastDodge();
		DisableCastSkill();
		DisableCastUltra();
		RefreshSkillUseable();
		PlayBuffFX(StateEnum.Stun);
	}

	private void OnExitStun(int referenceCount)
	{
		if (referenceCount == 0)
		{
			MonsterSpecialLostControlDelay();
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
			StopBuffFX(StateEnum.Stun);
		}
	}

	private bool CheckEnterStun()
	{
		if (CommonImmuneCheckForStrongControl())
		{
			return false;
		}
		return !isJump;
	}

	public bool EnterStun()
	{
		return stateAttributeList.Enable(HotfixEnum.stateAttributeType.STUN);
	}

	public bool ExitStun()
	{
		return stateAttributeList.Disable(HotfixEnum.stateAttributeType.STUN);
	}

	public void InterruptStun()
	{
		stateAttributeList.Interrupt(HotfixEnum.stateAttributeType.STUN);
	}

	private void MonsterSpecialLostControlDelay()
	{
		if (this is MonsterAdventureActor && useSpecialLostControlClip && !isToughnessBrokenState)
		{
			FP delayTime = specialLostControlEndClipLen;
			if (LogicTime - _enterStunTime < specialLostControlStartClipLen)
			{
				delayTime += specialLostControlStartClipLen - (LogicTime - _enterStunTime);
			}
			_stunSpecialLostControlNode = StartLogicCoroutine(StunSpecialLostControl(delayTime), runImmediately: true);
		}
	}

	private IEnumerator StunSpecialLostControl(FP delayTime)
	{
		_isStunSpecialLostControlFinish = false;
		EnterLostControl();
		yield return delayTime;
		ExitLostControl();
		if (!isToughnessBrokenState)
		{
			ShowSpecialLostControlLayer(show: false);
		}
		_isStunSpecialLostControlFinish = true;
	}

	private void OnEnterStunWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.StunWeakened);
		}
	}

	private void OnExitStunWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.StunWeakened);
		}
	}

	public bool EnterStunWeakened()
	{
		return stateAttributeList.Enable(HotfixEnum.stateAttributeType.STUN_WEAKENED);
	}

	public bool ExitStunWeakened()
	{
		return stateAttributeList.Disable(HotfixEnum.stateAttributeType.STUN_WEAKENED);
	}

	public void InterruptStunWeakened()
	{
		stateAttributeList.Interrupt(HotfixEnum.stateAttributeType.STUN_WEAKENED);
	}

	private void OnEnterFrozen(int referenceCount)
	{
		InterruptKnockBack();
		if (isAirBorne)
		{
			InterruptAirBorne();
		}
		if (referenceCount == 1)
		{
			PauseAnimation();
			EnterForceControl();
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
			PlayBuffFX(StateEnum.Frozen);
		}
	}

	private void OnExitFrozen(int referenceCount)
	{
		if (referenceCount == 0)
		{
			ResumeAnimation();
			ExitForceControl();
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
			StopBuffFX(StateEnum.Frozen);
			PlayHurtAnim();
			float spawnSize = AdventureFXManager.CalcFXScaleWithBody(dtCollider.colliderBounds, AdventureModuleController.Config.FX_HurtCueEffectScaleFactor, float.MinValue, float.MaxValue);
			AdventureFXManager.PlayFX(AdventureModuleController.Config.FX_FrozenFXPath_Break, 1f, transform.position, transform.rotation, spawnSize);
		}
	}

	private void OnInterruptFrozen()
	{
		ResumeFrozen();
	}

	private bool CheckEnterFrozen()
	{
		if (CommonImmuneCheckForStrongControl())
		{
			return false;
		}
		return !isJump;
	}

	public bool EnterFrozen()
	{
		return stateAttributeList.Enable(HotfixEnum.stateAttributeType.FROZEN);
	}

	public bool ExitFrozen()
	{
		return stateAttributeList.Disable(HotfixEnum.stateAttributeType.FROZEN);
	}

	public void InterruptFrozen()
	{
		stateAttributeList.Interrupt(HotfixEnum.stateAttributeType.FROZEN);
	}

	private void OnEnterFrozenWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.FrozenWeakened);
		}
	}

	private void OnExitFrozenWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.FrozenWeakened);
		}
	}

	public bool EnterFrozenWeakened()
	{
		return stateAttributeList.Enable(HotfixEnum.stateAttributeType.FROZEN_WEAKENED);
	}

	public bool ExitFrozenWeakened()
	{
		return stateAttributeList.Disable(HotfixEnum.stateAttributeType.FROZEN_WEAKENED);
	}

	public void InterruptFrozenWeakened()
	{
		stateAttributeList.Interrupt(HotfixEnum.stateAttributeType.FROZEN_WEAKENED);
	}

	protected void EnterFrozenOutSate()
	{
		currentDuration = 0.5f;
		totalDuration = 0.5f;
		TimeControlReset();
	}

	protected void ResumeFrozen()
	{
		currentDuration = FP.Zero;
		totalDuration = FP.Zero;
		TimeControlReset();
	}

	public void FrozenOutSate()
	{
		if (currentDuration > FP.Zero)
		{
			currentDuration -= LogicDeltaTime;
			currentDuration = ((currentDuration < FP.Zero) ? FP.Zero : currentDuration);
			FP fP = FP.One - currentDuration / totalDuration;
			logicTimeScale = fP;
		}
	}

	private void OnEnterSleep(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnterForceControl(interruptAttack: true, playLostControlAnim: true);
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
			PlayBuffFX(StateEnum.Sleep);
		}
	}

	private void OnExitSleep(int referenceCount)
	{
		if (referenceCount == 0)
		{
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
			StopBuffFX(StateEnum.Sleep);
		}
	}

	private bool CheckEnterSleep()
	{
		if (CommonImmuneCheckForStrongControl())
		{
			return false;
		}
		return !isJump;
	}

	public void EnterSleep()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SLEEP);
	}

	public void ExitSleep()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SLEEP);
	}

	public void InterruptSleep()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SLEEP);
	}

	private void OnEnterSleepWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.SleepWeakened);
		}
	}

	private void OnExitSleepWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.SleepWeakened);
		}
	}

	public void EnterSleepWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SLEEP_WEAKENED);
	}

	public void ExitSleepWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SLEEP_WEAKENED);
	}

	public void InterruptSleepWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SLEEP_WEAKENED);
	}

	public void SetCharmDir(AdventureActor from)
	{
		_from = from;
		_fromId = from.Id;
		_charmDir = (from.tsTransform.Position - tsTransform.Position).normalized;
	}

	private void OnEnterCharm(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnterForceControl();
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			if (actorInfo.moveType != HotfixEnum.actorMovType.STATIC && _charmMoveCoroutine == null)
			{
				_charmMoveCoroutine = StartLogicCoroutine(CharmMove());
			}
			RefreshSkillUseable();
			PlayBuffFX(StateEnum.Charm);
		}
	}

	private void OnExitCharm(int referenceCount)
	{
		if (referenceCount == 0)
		{
			_from = null;
			ExitForceControl();
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			if (_charmMoveCoroutine != null)
			{
				StopLogicCoroutine(_charmMoveCoroutine);
				_charmMoveCoroutine = null;
			}
			RefreshSkillUseable();
			StopBuffFX(StateEnum.Charm);
		}
	}

	private bool CheckEnterCharm()
	{
		if (CommonImmuneCheckForStrongControl())
		{
			return false;
		}
		return !isJump;
	}

	public void EnterCharm(AdventureActor from)
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.CHARM);
	}

	public void ExitCharm()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.CHARM);
	}

	public void InterruptCharm()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.CHARM);
	}

	private bool CharmFromCanFollow()
	{
		if (_from == null || _from.IsDead())
		{
			return false;
		}
		if (_from.Id != _fromId)
		{
			return false;
		}
		if (_from.IsSearchedImmunity())
		{
			return false;
		}
		return true;
	}

	private IEnumerator CharmMove()
	{
		FP disTance = 0;
		while (isCharm)
		{
			if (CharmFromCanFollow())
			{
				_charmDir = (_from.tsTransform.Position - tsTransform.Position).normalized;
				disTance = _from.DistanceWithRadius(this);
			}
			if (disTance > 1.5f)
			{
				disTance = 0;
				tsTransform.Forward = _charmDir;
				Walk(_charmDir);
			}
			else if (movementState == ActorState.Move && disTance <= 1)
			{
				StandBy(null, force: true);
			}
			yield return null;
		}
	}

	private void OnEnterCharmWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.CharmWeakened);
		}
	}

	private void OnExitCharmWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.CharmWeakened);
		}
	}

	public void EnterCharmWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.CHARM_WEAKENED);
	}

	public void ExitCharmWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.CHARM_WEAKENED);
	}

	public void InterruptCharmWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.CHARM_WEAKENED);
	}

	public void SetTerrorDir(AdventureActor from)
	{
		_terrorDir = (tsTransform.Position - from.tsTransform.Position).normalized;
		int num = TSRandom.Range(-90, 90);
		_terrorDir = TSVector2.Rotate(_terrorDir, num);
	}

	private void OnEnterTerror(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnterForceControl();
			DisableMove();
			DisableRotate();
			DisableCastNormal();
			DisableCastDodge();
			DisableCastSkill();
			DisableCastUltra();
			if (actorInfo.moveType != HotfixEnum.actorMovType.STATIC && _terrorMoveCoroutine == null)
			{
				_terrorMoveCoroutine = StartLogicCoroutine(TerrorMove());
			}
			RefreshSkillUseable();
			PlayBuffFX(StateEnum.Terror);
		}
	}

	private void OnExitTerror(int referenceCount)
	{
		if (referenceCount == 0)
		{
			ExitForceControl();
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			if (_terrorMoveCoroutine != null)
			{
				StopLogicCoroutine(_terrorMoveCoroutine);
				_terrorMoveCoroutine = null;
			}
			RefreshSkillUseable();
			StopBuffFX(StateEnum.Terror);
		}
	}

	private bool CheckEnterTerror()
	{
		if (CommonImmuneCheckForStrongControl())
		{
			return false;
		}
		return !isJump;
	}

	public void EnterTerror(AdventureActor from)
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.TERROR);
		SetTerrorDir(from);
	}

	public void ExitTerror()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.TERROR);
	}

	public void InterruptTerror()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.TERROR);
	}

	private IEnumerator TerrorMove()
	{
		while (isTerror)
		{
			if (!isImmobilizedByHardControl)
			{
				tsTransform.Forward = _terrorDir;
				Walk(_terrorDir);
			}
			yield return null;
		}
	}

	private void OnEnterTerrorWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.TerrorWeakened);
		}
	}

	private void OnExitTerrorWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.TerrorWeakened);
		}
	}

	public void EnterTerrorWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.TERROR_WEAKENED);
	}

	public void ExitTerrorWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.TERROR_WEAKENED);
	}

	public void InterruptTerrorWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.TERROR_WEAKENED);
	}

	private void OnEnterToughnessBrokenState(int referenceCount)
	{
		if (referenceCount != 1)
		{
			return;
		}
		if (_toughnessBrokenSpecialLostControlNode != null)
		{
			StopLogicCoroutine(_toughnessBrokenSpecialLostControlNode);
			_toughnessBrokenSpecialLostControlNode = null;
			if (!_isToughnessBrokenSpecialLostControlFinish)
			{
				ExitLostControl();
				if (!isStun)
				{
					ShowSpecialLostControlLayer(show: false);
				}
			}
		}
		_enterToughnessBrokenTime = LogicTime;
		SyncMovementLocation();
		bool useSpecialLostControlAnim = !(this is PlayerAdventureActor);
		EnterForceControl(interruptAttack: true, playLostControlAnim: true, useSpecialLostControlAnim);
		DisableMove();
		DisableRotate();
		DisableCastNormal();
		DisableCastDodge();
		DisableCastSkill();
		DisableCastUltra();
		RefreshSkillUseable();
	}

	private void OnExitToughnessBrokenState(int referenceCount)
	{
		if (referenceCount == 0)
		{
			MonsterToughnessBrokenSpecialLostControlDelay();
			ExitForceControl(exitLostControlAnim: true);
			EnableMove();
			EnableRotate();
			EnableCastNormal();
			EnableCastDodge();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
		}
	}

	public bool EnterToughnessBrokenState()
	{
		return stateAttributeList.Enable(HotfixEnum.stateAttributeType.TOUGHNESS_BORKEN);
	}

	public bool ExitToughnessBrokenState()
	{
		return stateAttributeList.Disable(HotfixEnum.stateAttributeType.TOUGHNESS_BORKEN);
	}

	public void InterruptToughnessBrokenState()
	{
		stateAttributeList.Interrupt(HotfixEnum.stateAttributeType.TOUGHNESS_BORKEN);
	}

	private void MonsterToughnessBrokenSpecialLostControlDelay()
	{
		if (this is MonsterAdventureActor && useSpecialLostControlClip && !isStun)
		{
			FP delayTime = specialLostControlEndClipLen;
			if (LogicTime - _enterToughnessBrokenTime < specialLostControlStartClipLen)
			{
				delayTime += specialLostControlStartClipLen - (LogicTime - _enterToughnessBrokenTime);
			}
			_toughnessBrokenSpecialLostControlNode = StartLogicCoroutine(ToughnessBrokenSpecialLostControl(delayTime), runImmediately: true);
		}
	}

	private IEnumerator ToughnessBrokenSpecialLostControl(FP delayTime)
	{
		_isToughnessBrokenSpecialLostControlFinish = false;
		EnterLostControl();
		yield return delayTime;
		ExitLostControl();
		if (!isStun)
		{
			ShowSpecialLostControlLayer(show: false);
		}
		_isToughnessBrokenSpecialLostControlFinish = true;
	}

	public void InterruptWeakControl()
	{
		for (int i = 0; i < weakControlStatusEffects.Count; i++)
		{
			stateAttributeList?.Interrupt(weakControlStatusEffects.get_Item(i));
		}
	}

	private bool CommonImmuneCheckForWeakControl()
	{
		if (this is DestructibleStateSingle)
		{
			return true;
		}
		if (!actorHealthInfo.isAlive)
		{
			return true;
		}
		if (!CheckImmCtrByWeekControl())
		{
			return CheckInvincibleByWeekControl();
		}
		return true;
	}

	private bool CheckImmCtrByWeekControl()
	{
		return OnWeekControlHandle?.Invoke(HotfixEnum.stateAttributeType.IMMUNE_CONTROL) ?? isImmuneControl;
	}

	private bool CheckInvincibleByWeekControl()
	{
		return OnWeekControlHandle?.Invoke(HotfixEnum.stateAttributeType.INVINCIBLE) ?? isInvincible;
	}

	private void OnEnterTaunt(int referenceCount)
	{
		if (referenceCount == 1)
		{
			if (this is PlayerAdventureActor)
			{
				DisableMove();
				DisableRotate();
			}
			PlayBuffFX(StateEnum.Taunt);
			AdventureForceTargetStateChangedEvent adventureForceTargetStateChangedEvent = AdventureForceTargetStateChangedEvent.Generate();
			adventureForceTargetStateChangedEvent.actor = this;
			adventureForceTargetStateChangedEvent.from = tauntFromActor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureForceTargetStateChangedEvent);
		}
	}

	private void OnExitTaunt(int referenceCount)
	{
		if (referenceCount == 0)
		{
			if (this is PlayerAdventureActor)
			{
				EnableMove();
				EnableRotate();
			}
			tauntFromActor = null;
			StopBuffFX(StateEnum.Taunt);
			AdventureForceTargetStateChangedEvent adventureForceTargetStateChangedEvent = AdventureForceTargetStateChangedEvent.Generate();
			adventureForceTargetStateChangedEvent.actor = this;
			adventureForceTargetStateChangedEvent.from = null;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureForceTargetStateChangedEvent);
		}
	}

	private bool CheckEnterTaunt()
	{
		return !CommonImmuneCheckForWeakControl();
	}

	public void EnterTaunt(AdventureActor from)
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.TAUNT);
	}

	public void ExitTaunt()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.TAUNT);
	}

	public void InterruptTaunt()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.TAUNT);
	}

	private void OnActorDied(IEvent e)
	{
		if (e is AdventureActorDiedEvent adventureActorDiedEvent && isTaunt && !(tauntFromActor == null) && adventureActorDiedEvent.actor == tauntFromActor)
		{
			ExitTaunt();
		}
	}

	private void OnEnterTauntWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.TauntWeakened);
		}
	}

	private void OnExitTauntWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.TauntWeakened);
		}
	}

	public void EnterTauntWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.TAUNT_WEAKENED);
	}

	public void ExitTauntWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.TAUNT_WEAKENED);
	}

	public void InterruptTauntWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.TAUNT_WEAKENED);
	}

	private void OnEnterBondage(int referenceCount)
	{
		if (referenceCount == 1)
		{
			InterrupDisplacement();
			DisableMoveAgentCanMove();
			PlayBuffFX(StateEnum.Bondage);
		}
	}

	private void OnExitBondage(int referenceCount)
	{
		if (referenceCount == 0)
		{
			EnableMoveAgentCanMove();
			StopBuffFX(StateEnum.Bondage);
		}
	}

	private bool CheckEnterBondage()
	{
		if (CommonImmuneCheckForWeakControl())
		{
			return false;
		}
		return !isJump;
	}

	public void EnterBondage()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.BONDAGE);
	}

	public void ExitBondage()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.BONDAGE);
	}

	public void InterruptBondage()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.BONDAGE);
	}

	private void OnEnterBondageWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.BondageWeakened);
		}
	}

	private void OnExitBondageWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.BondageWeakened);
		}
	}

	public void EnterBondageWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.BONDAGE_WEAKENED);
	}

	public void ExitBondageWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.BONDAGE_WEAKENED);
	}

	public void InterruptBondageWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.BONDAGE_WEAKENED);
	}

	private void OnEnterSilence(int referenceCount)
	{
		if (referenceCount == 1)
		{
			EnterForceControl();
			DisableCastSkill();
			DisableCastUltra();
			RefreshSkillUseable();
			PlayBuffFX(StateEnum.Silence);
		}
	}

	private void OnExitSilence(int referenceCount)
	{
		if (referenceCount == 0)
		{
			ExitForceControl();
			EnableCastSkill();
			EnableCastUltra();
			RefreshSkillUseable();
			StopBuffFX(StateEnum.Silence);
		}
	}

	private bool CheckEnterSilence()
	{
		return !CommonImmuneCheckForWeakControl();
	}

	public void EnterSilence()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SILENCE);
	}

	public void ExitSilence()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SILENCE);
	}

	public void InterruptSilence()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SILENCE);
	}

	private void OnEnterSilenceWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.SilenceWeakened);
		}
	}

	private void OnExitSilenceWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.SilenceWeakened);
		}
	}

	public void EnterSilenceWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.SILENCE_WEAKENED);
	}

	public void ExitSilenceWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.SILENCE_WEAKENED);
	}

	public void InterruptSilenceWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.SILENCE_WEAKENED);
	}

	private void OnEnterChaos(int referenceCount)
	{
		if (referenceCount != 1)
		{
			return;
		}
		StandBy();
		if (this is MonsterAdventureActor && actorInfo.moveType != HotfixEnum.actorMovType.STATIC)
		{
			_shape = AdventureModuleController.Config.Shap_Chaos;
			_shape.position = new TSVector2(tsTransform.Position.x, tsTransform.Position.y);
			if (_randomMoveCoroutine == null)
			{
				ToRandomMove();
				_randomMoveCoroutine = StartLogicCoroutine(RandomMoveCoroutine());
			}
		}
		PlayBuffFX(StateEnum.Chaos);
	}

	private void OnExitChaos(int referenceCount)
	{
		if (referenceCount == 0)
		{
			if (_randomMoveCoroutine != null)
			{
				StopLogicCoroutine(_randomMoveCoroutine);
				_randomMoveCoroutine = null;
			}
			StopBuffFX(StateEnum.Chaos);
		}
	}

	private bool CheckEnterChaos()
	{
		if (CommonImmuneCheckForWeakControl())
		{
			return false;
		}
		return !isJump;
	}

	public void EnterChaos()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.CHAOS);
	}

	public void ExitChaos()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.CHAOS);
	}

	public void InterruptChaos()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.CHAOS);
	}

	private void ToRandomMove()
	{
		randomPos = RandomActorReachablePointInsideShape(_shape, 3);
		complete = true;
	}

	private IEnumerator RandomMoveCoroutine()
	{
		while (inChaos)
		{
			if (waitC > 0)
			{
				waitC--;
				yield return null;
			}
			if (randomPos == _shape.position || isLostControl)
			{
				ToRandomMove();
				waitC = 20;
				yield return null;
			}
			if (complete && randomPos != _shape.position && !isLostControl)
			{
				complete = false;
				waitC = 10;
				AdventureActor adventureActor = this;
				TSVector2 targetPosition = randomPos;
				FP stopDistance = dtCollider.Radius + 0.1f;
				Action onLeave = ToRandomMove;
				if (!adventureActor.MoveTo(targetPosition, stopDistance, enableNavigation: true, MovementMode.Run, null, randomMove: true, forceMove: false, default, onLeave))
				{
					ToRandomMove();
				}
			}
			yield return null;
		}
	}

	private void OnEnterChaosWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.ChaosWeakened);
		}
	}

	private void OnExitChaosWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.ChaosWeakened);
		}
	}

	public void EnterChaosWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.CHAOS_WEAKENED);
	}

	public void ExitChaosWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.CHAOS_WEAKENED);
	}

	public void InterruptChaosWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.CHAOS_WEAKENED);
	}

	private void OnEnterBlindness(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.Blindness);
		}
	}

	private void OnExitBlindness(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.Blindness);
		}
	}

	private bool CheckEnterBlindness()
	{
		return !CommonImmuneCheckForWeakControl();
	}

	public void EnterBlindness()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.BLINDNESS);
	}

	public void ExitBlindness()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.BLINDNESS);
	}

	public void InterruptBlindness()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.BLINDNESS);
	}

	private void OnEnterBlindnessWeakened(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.BlindnessWeakened);
		}
	}

	private void OnExitBlindnessWeakened(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.BlindnessWeakened);
		}
	}

	public void EnterBlindnessWeakened()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED);
	}

	public void ExitBlindnessWeakened()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED);
	}

	public void InterruptBlindnessWeakened()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED);
	}

	private void OnEnterReduceFOV(int referenceCount)
	{
		if (referenceCount == 1)
		{
			PlayBuffFX(StateEnum.ReduceFOV);
		}
	}

	private void OnExitReduceFOV(int referenceCount)
	{
		if (referenceCount == 0)
		{
			StopBuffFX(StateEnum.ReduceFOV);
		}
	}

	private bool CheckEnterReduceFOV()
	{
		return !CommonImmuneCheckForWeakControl();
	}

	public void EnterReduceFOV()
	{
		stateAttributeList?.Enable(HotfixEnum.stateAttributeType.REDUCE_FOV);
	}

	public void ExitReduceFOV()
	{
		stateAttributeList?.Disable(HotfixEnum.stateAttributeType.REDUCE_FOV);
	}

	public void InterruptReduceFOV()
	{
		stateAttributeList?.Interrupt(HotfixEnum.stateAttributeType.REDUCE_FOV);
	}

	protected void InitializePrimeState()
	{
	}

	protected void ReleasePrimeState()
	{
		_state = ActorState.Null;
		isBorn = false;
		actorHealthInfo.isAlive = false;
		isDead = true;
		isDeclareDead = true;
		_bornCoroutine = null;
		killer = null;
		_damageTag = null;
		if (_spwanShowCoroutine != null)
		{
			StopCoroutine(WaitSpwanShow());
			_spwanShowCoroutine = null;
		}
	}

	public virtual void SetupPrimeFSM(int aiId)
	{
		_ = SceneSingleton<AdventureLevelObjPoolMgr>.Instance;
		if (!string.IsNullOrEmpty(_comboGroupPath))
		{
			string assetName = "Assets/AssetBundles/Actor/" + _comboGroupPath + ".asset";
			ComboGroup comboGroup = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, assetName, typeof(ComboGroup)) as ComboGroup;
			this.comboGroup = comboGroup;
		}
	}

	public void PauseBehaviour()
	{
		_primeFSM?.GetCurState()?.OnPause();
	}

	public void ResumeBehaviour()
	{
		_primeFSM?.GetCurState()?.OnResume();
	}

	public void InitParallelAI(string aiPath)
	{
		if (_parallelAI == null && !string.IsNullOrEmpty(aiPath))
		{
			_parallelAI = new AIAdapter();
			if (!_parallelAI.Initialize(aiPath, gameObject))
			{
				_parallelAI = null;
			}
		}
	}

	public void ResetParallelAI(string aiPath)
	{
		if (_parallelAI != null)
		{
			_parallelAI.Stop();
			_parallelAI.Disable();
			_parallelAI = null;
		}
		if (!string.IsNullOrEmpty(aiPath))
		{
			_parallelAI = new AIAdapter();
			if (!_parallelAI.Initialize(aiPath, gameObject))
			{
				_parallelAI = null;
			}
		}
		StartParallelAI();
	}

	public void StartParallelAI()
	{
		_parallelAI?.Start();
	}

	public void StopParallelAI()
	{
		_parallelAI?.Stop();
	}

	public void DisableParallelAI()
	{
		StopParallelAI();
		_parallelAI?.Disable();
	}

	public void PauseParallelAI()
	{
		_parallelAI?.Pause();
	}

	public void ResumeParallelAI()
	{
		_parallelAI?.Resume();
	}

	public void UpdateParallelAI()
	{
		_parallelAI?.Update();
	}

	public bool EnterNull()
	{
		if (_state == ActorState.Null)
		{
			return false;
		}
		OnSendActorPrimeState(ActorState.Null);
		return _primeFSM.SwitchState(0);
	}

	public bool Spawn()
	{
		if (_state == ActorState.Spawn)
		{
			return false;
		}
		_state = ActorState.Spawn;
		if (actorHealthInfo.isAlive)
		{
			isBorn = true;
			if (this is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterAIInfo.spawnSkillId != 0)
			{
				Visible();
			}
		}
		else
		{
			isBorn = false;
			actorHealthInfo.isAlive = true;
		}
		OnSpawnStateEnter();
		return true;
	}

	protected void OnSpawnStateEnter()
	{
		isBorn = false;
		OnSendActorPrimeState(ActorState.Spawn);
		_primeFSM.SwitchState(1);
		PlayIdleAnim();
		if (visualControl != null)
		{
			visualControl.EnableAllOcclusionRendererOccluders();
		}
		AdventureActorEnterBattle adventureActorEnterBattle = AdventureActorEnterBattle.Generate();
		adventureActorEnterBattle.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEnterBattle);
	}

	public bool Idle(bool isActorLevelStart = false)
	{
		if (_state == ActorState.Idle)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		if (isLostControl)
		{
			return false;
		}
		OnIdleStateEnter();
		if (!isActorLevelStart)
		{
			AdventureActorLeaveBattle adventureActorLeaveBattle = AdventureActorLeaveBattle.Generate();
			adventureActorLeaveBattle.sender = this;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorLeaveBattle);
		}
		return true;
	}

	protected void OnIdleStateEnter()
	{
		if (_state != ActorState.Idle)
		{
			_state = ActorState.Idle;
			OnSendActorPrimeState(ActorState.Idle);
			_primeFSM.SwitchState(2);
			PlayIdleAnim();
		}
	}

	public bool Action(bool makeThreatAlert = true)
	{
		if (_state == ActorState.Action)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		if (isLostControl)
		{
			return false;
		}
		if (_spwanShowCoroutine != null)
		{
			return false;
		}
		if (makeThreatAlert && state != ActorState.Action && GroupId != null && isSyncActived && this is MonsterAdventureActor)
		{
			AdventureEntityGroup adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(GroupId);
			if (adventureEntityGroup != null)
			{
				AdventureActorGroupAttackThreatAlert adventureActorGroupAttackThreatAlert = AdventureActorGroupAttackThreatAlert.Generate();
				adventureActorGroupAttackThreatAlert.sender = this;
				adventureEntityGroup.Broadcast(adventureActorGroupAttackThreatAlert);
			}
		}
		MonsterAdventureActor monsterAdventureActor = this as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			int spawnSkillId = monsterAdventureActor.monsterAIInfo.spawnSkillId;
			if (spawnSkillId > 0 && actorSkillManage.HaveSkill(spawnSkillId))
			{
				_spwanShowCoroutine = StartLogicCoroutine(WaitSpwanShow());
				return false;
			}
		}
		OnActionStateEnter();
		return true;
	}

	protected IEnumerator WaitSpwanShow()
	{
		int _showId = (this as MonsterAdventureActor).monsterAIInfo.spawnSkillId;
		while (actorSkillManage.HaveSkill(_showId))
		{
			yield return null;
		}
		_spwanShowCoroutine = null;
		Action(makeThreatAlert: false);
	}

	protected void OnActionStateEnter()
	{
		if (_state != ActorState.Action)
		{
			_state = ActorState.Action;
			OnSendActorPrimeState(ActorState.Action);
			_primeFSM.SwitchState(3);
			PlayIdleAnim();
		}
	}

	protected bool LostControl(bool isInterruptAttack = true)
	{
		if (_state == ActorState.LostControl)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		OnLostControlStateEnter(isInterruptAttack);
		AdventureActorLostControlEvent adventureActorLostControlEvent = AdventureActorLostControlEvent.Generate();
		adventureActorLostControlEvent.actor = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorLostControlEvent);
		return true;
	}

	protected void OnLostControlStateEnter(bool isInterruptAttack = true)
	{
		if (_state != ActorState.LostControl)
		{
			_state = ActorState.LostControl;
			InterruptMovement();
			if (isInterruptAttack)
			{
				InterruptAttack(force: true);
			}
			OnSendActorPrimeState(ActorState.LostControl);
			_primeFSM.SwitchState(4);
		}
	}

	public virtual bool Death(LogicEntity killer, IList<int> damageTag = null, HitBox hitBox = null, int uniqueAttackId = 0, DeadType deadType = DeadType.None)
	{
		ModuleController<AdventureModuleController>.Instance.RecordDeath(Id);
		if (this is DestructibleStateSingle)
		{
			return false;
		}
		if (_state == ActorState.Death)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		_state = ActorState.Death;
		this.killer = killer;
		_damageTag = damageTag;
		killerHitBox = hitBox;
		_uniqueAttackId = uniqueAttackId;
		_deadType = deadType;
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("Dead", Id);
		InterruptMovement();
		InterruptAttack(force: true);
		OnDeathStateEnter();
		return true;
	}

	protected void OnDeathStateEnter()
	{
		actorHealthInfo.isAlive = false;
		_primeFSM.killer = killer;
		_primeFSM.damageTag = _damageTag;
		_primeFSM.uniqueAttackId = _uniqueAttackId;
		_primeFSM.deadType = _deadType;
		OnSendActorPrimeState(ActorState.Death);
		_primeFSM.SwitchState(5);
		if (visualControl != null)
		{
			visualControl.DisableAllOcclusionRendererOccluders();
		}
	}

	public void SendDeclareDeadEvent()
	{
		if (this is MonsterAdventureActor monsterAdventureActor && !isDeclareDead)
		{
			isDeclareDead = true;
			AdventureMonsterDeclareDiedEvent adventureMonsterDeclareDiedEvent = AdventureMonsterDeclareDiedEvent.Generate();
			adventureMonsterDeclareDiedEvent.sender = this;
			adventureMonsterDeclareDiedEvent.id = Id;
			adventureMonsterDeclareDiedEvent.monsterID = dataID;
			MonsterInfo monsterInfo = monsterAdventureActor.monsterInfo;
			if (monsterInfo != null)
			{
				adventureMonsterDeclareDiedEvent.epicType = monsterInfo.epicType;
			}
			MonsterSpawnerInfo spawnerInfo = monsterAdventureActor.spawnerInfo;
			if (spawnerInfo != null)
			{
				adventureMonsterDeclareDiedEvent.callSpawnSrc = spawnerInfo.callSpawnSrc;
			}
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterDeclareDiedEvent);
			MonoSingleton<LuaManager>.Instance.FireEvent(adventureMonsterDeclareDiedEvent.type, adventureMonsterDeclareDiedEvent.id);
		}
	}

	public bool ClearSelf()
	{
		if (_state == ActorState.Clear)
		{
			return false;
		}
		_state = ActorState.Clear;
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("ClearSlef", Id);
		InterruptMovement();
		InterruptAttack(force: true);
		actorHealthInfo.isAlive = false;
		_primeFSM.SwitchState(6);
		OnSendActorPrimeState(ActorState.Clear);
		return true;
	}

	private void OnSendActorPrimeState(ActorState _acstate)
	{
		AdventureActorStateSwitchEvent adventureActorStateSwitchEvent = AdventureActorStateSwitchEvent.Generate();
		adventureActorStateSwitchEvent.Id = Id;
		adventureActorStateSwitchEvent.dataId = dataID;
		adventureActorStateSwitchEvent._acState = _acstate;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorStateSwitchEvent);
	}

	protected void InitializeTag()
	{
	}

	public void AddTag(string myTag)
	{
		if (!string.IsNullOrEmpty(myTag))
		{
			int myTagHash = CommonHelper.StringToHash(myTag);
			AddTag(myTagHash);
		}
	}

	public void AddTag(int myTagHash)
	{
		if (myTagHash != 0 && !tags.TryAdd(myTagHash, 1))
		{
			tags.get_Item(myTagHash)++;
		}
	}

	public void RemoveTag(string myTag)
	{
		if (!string.IsNullOrEmpty(myTag))
		{
			int myTagHash = CommonHelper.StringToHash(myTag);
			RemoveTag(myTagHash);
		}
	}

	public void RemoveTag(int myTagHash)
	{
		if (myTagHash != 0 && tags.ContainsKey(myTagHash))
		{
			tags.get_Item(myTagHash)--;
			if (tags.get_Item(myTagHash) <= 0)
			{
				tags.Remove(myTagHash);
			}
		}
	}

	public void ClearTag(string myTag)
	{
		int myTagHash = CommonHelper.StringToHash(myTag);
		ClearTag(myTagHash);
	}

	public void ClearTag(int myTagHash)
	{
		if (myTagHash != 0 && tags.ContainsKey(myTagHash))
		{
			tags.Remove(myTagHash);
		}
	}

	public void ClearAllTag()
	{
		tags?.Clear();
	}

	public bool CheckTag(string myTag)
	{
		if (string.IsNullOrEmpty(myTag))
		{
			return false;
		}
		int myTagHash = CommonHelper.StringToHash(myTag);
		return CheckTag(myTagHash);
	}

	public bool CheckTag(int myTagHash)
	{
		if (myTagHash == 0)
		{
			return false;
		}
		if (!tags.ContainsKey(myTagHash))
		{
			return false;
		}
		return tags.get_Item(myTagHash) > 0;
	}

	public int GetTagCount(string myTag)
	{
		if (string.IsNullOrEmpty(myTag))
		{
			return 0;
		}
		int myTagHash = CommonHelper.StringToHash(myTag);
		return GetTagCount(myTagHash);
	}

	public int GetTagCount(int myTagHash)
	{
		if (myTagHash == 0)
		{
			return 0;
		}
		return tags.GetValueOrDefault(myTagHash, 0);
	}

	public void AddTagByGroup(string myTag)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).AddTag(myTag);
		}
	}

	public void AddTagByGroup(int myTagHash)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).AddTag(myTagHash);
		}
	}

	public int GetTagByGroup(string myTag)
	{
		int num = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			num += SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).GetTagCount(myTag);
		}
		return num;
	}

	public int GetTagByGroup(int myTagHash)
	{
		int num = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			num += SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).GetTagCount(myTagHash);
		}
		return num;
	}

	public void ClearTagByGroup(string myTag)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).ClearTag(myTag);
		}
	}

	public void ClearTagByGroup(int myTagHash)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).ClearTag(myTagHash);
		}
	}

	protected void ReleaseTag()
	{
		ClearAllTag();
	}

	public void BeginHitIdImmunityCheck()
	{
		_hitIdImmuneTriggered = false;
		_hitIdImmuneSeenNonImmune = false;
	}

	public bool CheckHitIdImmunity(HitDamage hitConfig)
	{
		if (hitConfig == null)
		{
			MarkHitIdNonImmune();
			return false;
		}
		if (hitConfig.HitImmunityTime <= 0)
		{
			MarkHitIdNonImmune();
			return false;
		}
		if (_hitImmunitys.TryGetValue(hitConfig.Id, out var value))
		{
			if (LogicTime < FP.FromMyriad(hitConfig.HitImmunityTime) + value)
			{
				MarkHitIdImmune();
				return true;
			}
			_hitImmunitys.set_Item(hitConfig.Id, LogicTime);
			MarkHitIdNonImmune();
			return false;
		}
		_hitImmunitys.Add(hitConfig.Id, LogicTime);
		MarkHitIdNonImmune();
		return false;
	}

	private void MarkHitIdImmune()
	{
		if (!_hitIdImmuneSeenNonImmune)
		{
			_hitIdImmuneTriggered = true;
		}
	}

	private void MarkHitIdNonImmune()
	{
		_hitIdImmuneSeenNonImmune = true;
		_hitIdImmuneTriggered = false;
	}

	protected void ClearHitImmunitys()
	{
		_hitIdImmuneTriggered = false;
		_hitIdImmuneSeenNonImmune = false;
		_hitImmunitys.Clear();
	}

	protected virtual void InitializeVisual()
	{
	}

	protected virtual void ReleaseVisual()
	{
		if (visualControl != null)
		{
			visualControl.ResetBasicActorVisualComponents();
		}
		_hideRC = 0;
		_hurtAnimToggleRC = 0;
	}

	protected virtual void LoadModel(float visibleRadius, float visibleHeight)
	{
		SetupVisualComponents(visibleRadius, visibleHeight);
		LoadAnimations();
		InitializeFXControl();
	}

	public void ActiveDefaultModelGroup()
	{
		if (visualControl != null)
		{
			visualControl.ActiveDefaultModelGroup();
		}
	}

	public void ActiveVariantModelGroup(string groupName)
	{
		if (visualControl != null)
		{
			visualControl.ActiveVariantModelGroup(groupName);
		}
	}

	protected virtual void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
		if (visualControl == null)
		{
			visualControl = gameObject.AddComponent<InGameActorVisualControlComponent>();
		}
	}

	public void ResetHideRC()
	{
		_hideRC = 1;
	}

	public void Visible()
	{
		_hideRC--;
		if (_hideRC < 0)
		{
			_hideRC = 0;
			LogWarning("Show与Hide使用不匹配，请成对使用");
		}
		if (_hideRC == 0 && visualControl != null)
		{
			visualControl.Visible();
		}
		ShowChangedEvent?.Invoke(show: true);
	}

	public void Hide(bool performanceMode = false)
	{
		_hideRC++;
		if (_hideRC == 1 && visualControl != null)
		{
			visualControl.Hide(performanceMode);
		}
		ShowChangedEvent?.Invoke(show: false);
	}

	public void SetRenderLayer(int layer)
	{
		if (visualControl != null)
		{
			visualControl.SetRenderLayer(layer);
		}
	}

	public void ResetRenderLayer()
	{
		if (visualControl != null)
		{
			visualControl.SetRenderLayer(8);
		}
	}

	public void TransparentFadeIn(float transparency = 0.35f, float duration = 0.5f)
	{
		_transparentRC++;
		if (_transparentRC == 1 && _transparentFadeSwichActorCoroutine == null)
		{
			_transparencyFrom = 1f;
			_transparencyTo = transparency;
			ResetTransparentFade();
			_transparentFadeCoroutine = StartCoroutine(UpdateTransparentFadeCoroutine(fadeIn: true, fadeOut: false, duration));
		}
	}

	public void TransparentFade(float transparencyFrom = -1f, float transparencyTo = 0.35f, float duration = 0.5f)
	{
		if (isTransparent)
		{
			if (transparencyFrom < 0f)
			{
				transparencyFrom = currentTransparency;
			}
			_transparencyFrom = transparencyFrom;
			_transparencyTo = transparencyTo;
			if (_transparentFadeCoroutine != null)
			{
				StopCoroutine(_transparentFadeCoroutine);
				_transparentFadeCoroutine = null;
			}
			if (duration > 0f)
			{
				_transparentFadeCoroutine = StartCoroutine(UpdateTransparentFadeCoroutine(fadeIn: false, fadeOut: false, duration));
			}
			else
			{
				currentTransparency = GameRenderUtils.UpdateTransparentFade(visualControl.materialController, visualControl.tint, _transparencyFrom, _transparencyTo, 1f);
			}
		}
	}

	public void TransparentFadeOut(float transparency = -1f, float duration = 0.5f)
	{
		_transparentRC--;
		if (_transparentRC == 0 && _transparentFadeSwichActorCoroutine == null)
		{
			if (transparency < 0f)
			{
				transparency = currentTransparency;
			}
			_transparencyFrom = transparency;
			_transparencyTo = 1f;
			if (actorHealthInfo.isAlive && ActiveSelf)
			{
				_transparentFadeCoroutine = StartCoroutine(UpdateTransparentFadeCoroutine(fadeIn: false, fadeOut: true, duration));
			}
		}
		if (_transparentRC < 0)
		{
			_transparentRC = 0;
			LogWarning("TransparentFadeIn与TransparentFadeOut使用不匹配，请成对使用");
		}
	}

	protected void InitializeTransparentFade()
	{
		if (!(visualControl == null) && !(visualControl.materialController == null))
		{
			GameRenderUtils.StopTransparentFade(visualControl.materialController, _transparentFadeMaterialID);
			_transparentFadeMaterialID = 0;
			_transparentRC = 0;
			currentTransparency = 1f;
			_transparentFadeCoroutine = null;
			_transparentFadeSwichActorCoroutine = null;
		}
	}

	protected IEnumerator UpdateTransparentFadeCoroutine(bool fadeIn, bool fadeOut, float duration)
	{
		float timer = 0f;
		if (fadeIn)
		{
			_transparentFadeMaterialID = GameRenderUtils.StartTransparentFade(visualControl.materialController);
		}
		if (duration > 0f)
		{
			while (timer < duration)
			{
				timer += Time.deltaTime;
				float t = Mathf.Clamp01(timer / duration);
				currentTransparency = GameRenderUtils.UpdateTransparentFade(visualControl.materialController, visualControl.tint, _transparencyFrom, _transparencyTo, t);
				yield return null;
			}
		}
		else
		{
			currentTransparency = GameRenderUtils.UpdateTransparentFade(visualControl.materialController, visualControl.tint, _transparencyFrom, _transparencyTo, 1f);
		}
		if (fadeOut)
		{
			GameRenderUtils.StopTransparentFade(visualControl.materialController, _transparentFadeMaterialID);
			_transparentFadeMaterialID = 0;
			currentTransparency = 1f;
		}
		_transparentFadeCoroutine = null;
	}

	protected void ResetTransparentFade()
	{
		GameRenderUtils.StopTransparentFade(visualControl.materialController, _transparentFadeMaterialID);
		_transparentFadeMaterialID = 0;
		currentTransparency = 1f;
		if (_transparentFadeCoroutine != null)
		{
			StopCoroutine(_transparentFadeCoroutine);
			_transparentFadeCoroutine = null;
		}
		if (_transparentFadeSwichActorCoroutine != null)
		{
			StopCoroutine(_transparentFadeSwichActorCoroutine);
			_transparentFadeSwichActorCoroutine = null;
		}
	}

	public void TransparentSwichActorFadeIn(float duration = 0f, float from = 0f, float to = 1f, bool stopOnFinish = false)
	{
		ResetTransparentFade();
		_transparentFadeSwichActorCoroutine = StartCoroutine(UpdateTransparentFadeSwichActorCoroutine(duration, from, to, stopOnFinish));
	}

	protected IEnumerator UpdateTransparentFadeSwichActorCoroutine(float duration = 0f, float f1 = 0f, float t1 = 1f, bool stopOnFinish = false)
	{
		float timer = 0f;
		_transparentFadeMaterialID = GameRenderUtils.StartTransparentFade(visualControl.materialController);
		float fadeDuration = duration;
		if (fadeDuration == 0f)
		{
			fadeDuration = AdventureModuleController.Config.sFadeInDuration;
		}
		while (timer < fadeDuration)
		{
			timer += Time.deltaTime;
			float t2 = Mathf.Clamp01(timer / fadeDuration);
			GameRenderUtils.UpdateTransparentFade(visualControl.materialController, visualControl.tint, f1, t1, t2);
			yield return null;
		}
		if (stopOnFinish)
		{
			GameRenderUtils.StopTransparentFade(visualControl.materialController, _transparentFadeMaterialID);
			_transparentFadeMaterialID = 0;
		}
		_transparentFadeSwichActorCoroutine = null;
	}

	public void HurtAnimOff()
	{
		_hurtAnimToggleRC++;
	}

	public void HurtAnimOn()
	{
		_hurtAnimToggleRC--;
		if (_hurtAnimToggleRC < 0)
		{
			_hurtAnimToggleRC = 0;
			LogWarning("HurtAnimOn与HurtAnimOn使用不匹配，请成对使用");
		}
	}

	public void EnableCheckBrokenLineBullet()
	{
		_checkBrokenLineBulletRC++;
	}

	public void DisableCheckBrokenLineBullet()
	{
		_checkBrokenLineBulletRC--;
		if (_checkBrokenLineBulletRC < 0)
		{
			_checkBrokenLineBulletRC = 0;
			LogWarning("EnableCheckBrokenLineBullet与DisableCheckBrokenLineBullet使用不匹配，请成对使用");
		}
	}

	protected void OnStartCheckBrokenLineBullet(IEvent e)
	{
		if (e is AdventureActorStartCheckBrokenBulletEvent adventureActorStartCheckBrokenBulletEvent && !(adventureActorStartCheckBrokenBulletEvent.entity != this))
		{
			EnableCheckBrokenLineBullet();
		}
	}

	protected void OnCancelCheckBrokenLineBullet(IEvent e)
	{
		if (e is AdventureActorCancelCheckBrokenBulletEvent adventureActorCancelCheckBrokenBulletEvent && !(adventureActorCancelCheckBrokenBulletEvent.entity != this))
		{
			DisableCheckBrokenLineBullet();
		}
	}

	protected void CheckBrokenLineBulletBack()
	{
		if (!checkBrokenLineBullet || checkBrokenLineBulletRadius <= 0)
		{
			return;
		}
		List<DeterministicCollider> list = new List<DeterministicCollider>();
		SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(checkBrokenLineBulletRadius, tsTransform.Position, list, 32768);
		for (int i = 0; i < list.Count; i++)
		{
			AdventureBrokenLineBullet adventureBrokenLineBullet = list.get_Item(i).Entity as AdventureBrokenLineBullet;
			if (!(adventureBrokenLineBullet == null) && !(adventureBrokenLineBullet.owner != this))
			{
				AdventureActorCheckBrokenBulletSuccessEvent adventureActorCheckBrokenBulletSuccessEvent = AdventureActorCheckBrokenBulletSuccessEvent.Generate();
				adventureActorCheckBrokenBulletSuccessEvent.entity = this;
				adventureActorCheckBrokenBulletSuccessEvent.bullet = adventureBrokenLineBullet;
				adventureActorCheckBrokenBulletSuccessEvent.bulletPosition = adventureBrokenLineBullet.tsTransform.Position;
				adventureActorCheckBrokenBulletSuccessEvent.tag = adventureBrokenLineBullet.bulletTag;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCheckBrokenBulletSuccessEvent);
			}
		}
	}

	public AdventureWeapon EquipWeapon(GameObject weaponPrefab, bool dCheck = false, TSVector2 direction = default(TSVector2))
	{
		if (weaponPrefab == null)
		{
			LogError("武器预制体为空");
			return null;
		}
		if (!dCheck)
		{
			AdventureWeapon component = weaponPrefab.GetComponent<AdventureWeapon>();
			if (component == null || !component.isEquipableWeapon)
			{
				LogError("武器类型不可装备:" + weaponPrefab.name);
				return null;
			}
		}
		AdventureWeapon adventureWeapon = ModuleController<AdventureModuleController>.Instance.SpawnWeapon<AdventureWeapon>(weaponPrefab, this);
		adventureWeapon.Setup(this, tsTransform.Position, dtCollider.HeightCenter, (direction == default(TSVector2)) ? tsTransform.Forward : direction);
		EquipWith(adventureWeapon);
		return adventureWeapon;
	}

	protected void EquipWith(AdventureWeapon weapon)
	{
		if (equipedWeapons.Contains(weapon))
		{
			return;
		}
		equipedWeapons.Add(weapon);
		weapon.OnEquipWith();
		for (int num = equipedWeapons.Count - 1; num >= 0; num--)
		{
			AdventureWeapon adventureWeapon = equipedWeapons.get_Item(num);
			if (adventureWeapon != weapon)
			{
				adventureWeapon.OnEquipUpdate();
			}
		}
		AdventureActorEquipWeaponEvent adventureActorEquipWeaponEvent = AdventureActorEquipWeaponEvent.Generate();
		adventureActorEquipWeaponEvent.sender = this;
		adventureActorEquipWeaponEvent.weapon = weapon;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEquipWeaponEvent);
		AdventureRotateWeapon adventureRotateWeapon = weapon as AdventureRotateWeapon;
		if (iFixWeaponDuration && adventureRotateWeapon != null)
		{
			adventureRotateWeapon.fixLeftTime(fixedWeaponTime);
			wepons.Add(adventureRotateWeapon);
			fixedWeaponTime = 0;
		}
	}

	public void RemindFixWeapon(bool ienble)
	{
		iFixWeaponDuration = ienble;
		fixedWeaponTime = 0;
		if (wepons == null)
		{
			wepons = new List<AdventureRotateWeapon>(3);
		}
	}

	public void FixWeaponDuration(FP fixValue)
	{
		if (iFixWeaponDuration)
		{
			fixedWeaponTime += fixValue;
		}
		List<AdventureRotateWeapon> list = wepons;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < wepons.Count; i++)
			{
				wepons.get_Item(i).fixLeftTime(fixValue);
			}
		}
	}

	public void EquipDrop(AdventureWeapon weapon)
	{
		if (wepons != null && weapon is AdventureRotateWeapon item && wepons.Contains(item))
		{
			wepons.Remove(item);
		}
		if (equipedWeapons.Remove(weapon))
		{
			weapon.OnEquipDrop();
			weapon = null;
			for (int num = equipedWeapons.Count - 1; num >= 0; num--)
			{
				equipedWeapons.get_Item(num).OnEquipUpdate();
			}
		}
	}

	public void QueryOwnedAliveBullets(List<AdventureBulletBase> bullets)
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (!(adventureWeapon == null) && !(adventureWeapon.owner != this) && adventureWeapon.ownerId == Id)
			{
				AdventureBulletBase adventureBulletBase = adventureWeapon as AdventureBulletBase;
				if (adventureBulletBase != null)
				{
					bullets.Add(adventureBulletBase);
				}
			}
		}
	}

	public void QueryOwnedAliveBullets(GameObject bulletPrefab, List<AdventureBulletBase> bullets)
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (!(adventureWeapon == null) && !(adventureWeapon.owner != this) && adventureWeapon.ownerId == Id && (!(bulletPrefab != null) || !(adventureWeapon.prefab != bulletPrefab)))
			{
				AdventureBulletBase adventureBulletBase = adventureWeapon as AdventureBulletBase;
				if (adventureBulletBase != null)
				{
					bullets.Add(adventureBulletBase);
				}
			}
		}
	}

	public AdventureBulletBase QueryOwnedBullet(long bulletId)
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureBulletBase adventureBulletBase = weapons.get_Item(i) as AdventureBulletBase;
			if (!(adventureBulletBase == null) && !(adventureBulletBase.owner != this) && adventureBulletBase.ownerId == Id && adventureBulletBase.Id == bulletId)
			{
				return adventureBulletBase;
			}
		}
		return null;
	}

	public void QueryEnemyBullets(List<AdventureBulletBase> bullets)
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (!(adventureWeapon == null) && adventureWeapon.owner.IsConfrontWith(this))
			{
				AdventureBulletBase adventureBulletBase = adventureWeapon as AdventureBulletBase;
				if (adventureBulletBase != null)
				{
					bullets.Add(adventureBulletBase);
				}
			}
		}
	}
}
