using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.MultiPlayer;
using ACT.Sound;
using ACT.Sound.Core;
using ACT.Utility;
using ACT.World.Behave;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cinemachine;
using EasyCharacterMovement;
using Fundamental;
using Runtime.World;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.Battle;

public class CompPhysics : EcsComponent
{
	public struct NormalSwitchMotionSnapshot
	{
		public bool isValid;

		public string stateName;

		public float normalizedTime;

		public ACTMovementMode movementMode;

		public bool isInAir;

		public bool isGrounded;

		public Vector3 rawVelocity;

		public Vector3 characterMovementVelocity;

		public Vector3 velocity;

		public float fallingTime;

		public float freeFallingTime;

		public bool jumpPress;

		public float jumpPressTime;

		public float frameJumpSpeed;

		public bool jumpPressInput;

		public bool jumpHoldInput;

		public bool inheritAirSwitchPhysics;

		public float inheritAirSwitchGravity;

		public float inheritAirSwitchFallFriction;

		public bool updraft;

		public Ladder activeLadder;

		public ClimbingState climbingState;
	}

	private enum PathSwitchRootMotionState
	{
		None,
		RotateToMoveDirection,
		Moving
	}

	private enum TeleportMovePhysicsState
	{
		None,
		MoveLerpToSitPos,
		Sit,
		MoveToPath
	}

	public struct ECM2PARAMS
	{
		public float radius;

		public float height;

		public Vector3 rootTransformOffset;
	}

	public ConfigPhysics config;

	public CharacterMovement characterMovement;

	public bool impartPlatformVelocity = true;

	public bool applyPushForce = true;

	public float _fallingTime;

	private bool _useRootMotionXZ;

	private bool _useRootMotionY;

	private bool _jumpPress;

	private float _jumpPressTime;

	private float _frameJumpSpeed;

	private float _freeFallingTime;

	public float groundDistance;

	protected int _customMovementMode;

	public Vector3 lastGroundPoint;

	public ConfigMotionPhysics configMotionPhysics;

	private float m_DefaultRadius;

	private float m_DefaultHeight;

	private Vector3 m_DefaultRootTransformOffset;

	private Vector3 m_RootTransformOffsetLocalBase;

	private Vector3 m_RootTransformOffsetWorld;

	private bool _inheritAirSwitchPhysics;

	private float _inheritAirSwitchGravity;

	private float _inheritAirSwitchFallFriction;

	private const float InheritAirSwitchGravityThreshold = -30f;

	private bool _skipWallSnapOnNextEnter;

	private float m_CacheVecYBeforeRootMotion;

	private bool m_LastUseRootMotionY;

	private bool immediatelySetDir;

	public OverlapEntityMode overlapEntityMode;

	private bool m_FrobidDir;

	private Ladder _activeLadder;

	private Vector3 _grabbingVelocity;

	private int _grabbingFrameCount;

	public ClimbingState climbingState;

	private Vector3 m_StartPoint;

	private Vector3 m_EndPoint;

	private Vector3 m_SpringDistance;

	private float m_SpringTime;

	private float m_SpringColliedTime;

	private AdsorbWall wall;

	public AdsorbingState adsorbingState;

	private Vector3 m_AdsorbLerpVelocity;

	private int m_AdsorbLerpCount;

	private Collider m_JumpDownCollider;

	private float m_JumpDownTime;

	private List<Collider> m_AllJumpDownColliders = new List<Collider>();

	private bool m_IsWallClimbCompensation;

	private Collider m_SpringGroundCollider;

	private Collider m_ConveyorBeltCollider;

	private Collider _submergePlatformCollider;

	public bool isBeControled;

	protected bool getHit;

	protected bool hitUp;

	protected Vector3 hitVelocity;

	protected FaceDir hitFaceDir;

	public bool hitOverride;

	public float hitOverrideBrakingDecelerationFalling;

	public float hitHorizontalFriction;

	public float hitUpwardGravity;

	public float hitUpwardFriction;

	public float hitDownwardGravity;

	public float hitDownwardFriction;

	public float hitDownwardMaxSpeed;

	public int horizontalHitWallNum;

	public int verticalHitWallNum;

	public Vector3 HitLocationPoint;

	public Vector3 velocity;

	public Vector3 lastFramePathLocalVelocity;

	public Vector3 compositeVelocity;

	public bool pauseVelocity;

	private MotionType m_MotionType;

	private bool m_BeCarryedConstrainInPlane;

	private bool m_HasBeCarryedConstrainInPlane;

	protected float m_ConstZ;

	private Vector3 pathOffset;

	private readonly List<MotionPath> motionPaths = new List<MotionPath>();

	public float _PathPosDistanceUnit;

	public float _PathPosNativeUnit;

	public const float PathPosCorrectionThreshold = 0.005f;

	private float rootUp;

	private float rootForward;

	private float rootRight;

	private float rootEulerY;

	private float deltaTime;

	public Vector3 rawVelocity;

	private bool isPushOverlapEnvironment;

	private HashSet<IPushCallBack> pushCallBacks;

	private HashSet<IPushCallBack> pushCallBacksCache;

	private HashSet<IPushCallBack> lastPushCallBacks;

	private HashSet<IHitWallCallBack> hitCallBacks;

	private HashSet<IHitWallCallBack> lastHitCallBacks;

	private Vector3 hookEndPoint;

	private Vector3 hookDistance;

	private float hookTime;

	private bool throughHookPoint;

	private float hookBlockTime;

	private Vector3 recover;

	private const string PathMoveInMotionName = "PathMove";

	private Vector3 _pathSwitchRootMotionTargetPosition;

	private float _pathSwitchRootMotionTargetRotation;

	private PathSwitchRootMotionState _pathSwitchRootMotionState;

	private bool _pathSwitchRootMotionFinished;

	private int _teleportFrameLerpCount;

	private Vector3 _teleportLerpVelocity;

	private TeleportMovePhysicsState _teleportMovePhysicsState;

	public ClimbType wallClimbingState;

	private const float UpdraftExitAccelerationDuration = 1f;

	private Vector3 _updraftAcceleration;

	private bool _updraftActiveThisStep;

	private bool _updraftAppliedLastStep;

	private bool _updraftExitRequested;

	private float _updraftExitRemain;

	private float lastHoriSpeed;

	private List<(PushImpetusData, Collider)> overlaped;

	private bool overlapEnviroment;

	private List<(PushImpetusData, Collider)> pushGameObjects;

	private Dictionary<string, int> m_IgnoreEnvironmentCollisionTagRefCounts;

	private const string GroundMaterialKey = "Ground_Material";

	public float orbital360Speed = 2f;

	public Orbital360Direction orbital360Direction;

	public float orbital360ProbeDistance = 0.75f;

	public float orbital360CornerProbeDistance = 1f;

	public float orbital360SkinWidth = 0.03f;

	public float orbital360ProbeOriginOffset = 0.12f;

	public float orbital360CastThickness = 0.06f;

	public bool orbital360DebugDraw;

	public bool orbital360DebugLog;

	private bool _orbital360Initialized;

	private bool _orbital360Stopped;

	private bool _orbital360PrevCannotOffCliff;

	private bool _orbital360PrevConstrainToGround;

	private float _orbital360LockedZ;

	private Vector2 _orbital360SurfaceNormal = Vector2.up;

	private Vector2 _orbital360MoveDir = Vector2.right;

	private Quaternion _orbital360Rotation = Quaternion.identity;

	private Sensor wallSensor;

	private Sensor wallDownSensor;

	private Sensor rightSensor;

	private Sensor leftSensor;

	private Sensor frontSensor;

	[Header("Sensor Array Options :")]
	[Range(1f, 5f)]
	private int sensorArrayRows = 1;

	[Range(3f, 10f)]
	private int sensorArrayRayCount = 6;

	private bool sensorArrayRowsAreOffset;

	public Vector3[] raycastArrayPreviewPositions;

	private bool isInDebugMode = true;

	private float baseSensorRange;

	private Transform attachedWall;

	private Vector3 localOffset;

	public LayerMask wallLayer = 8388608;

	public Sensor.CastType wallSensorType;

	[Range(0f, 1f)]
	public float wallCheckOffset = 0.1f;

	[Range(-3f, 3f)]
	public float wallBorderCheckOffset = 0.2f;

	[Range(-3f, 3f)]
	public float wallDownBorderCheckOffset = -0.5f;

	[Range(0f, 90f)]
	public float wallCheckAngle = 30f;

	[Range(0f, 1f)]
	public float ledgeCheckOffset = 1f;

	private Vector3 lastHitWallPoint = Vector3.zero;

	private float wallSnapOffset = 0.3f;

	private bool STUCKING;

	private int _stuckFrameCount;

	private const int STUCK_FRAME_THRESHOLD = 60;

	private const float STUCK_MOVE_THRESHOLD = 0.01f;

	private const int MAX_STUCK_COLLIDER_CHECK = 8;

	public ACTMovementMode state { get; protected set; }

	public float FreeFallingTime => _freeFallingTime;

	public Vector3 SyncPosition => owner.GetCompTransform().physicsPosition;

	public float RotateSpeed
	{
		get
		{
			if (configMotionPhysics != null && configMotionPhysics.rotateSpeed.isOverride)
			{
				return configMotionPhysics.rotateSpeed.value;
			}
			return config.RotateSpeed;
		}
	}

	public float Mass => owner.GetConfig().mass;

	public float Gravity
	{
		get
		{
			if (hitOverride)
			{
				if (!(rawVelocity.y > 0f))
				{
					return hitDownwardGravity;
				}
				return hitUpwardGravity;
			}
			bool flag = IsUsingInheritedAirSwitchPhysics();
			float effectiveGravity = GetEffectiveGravity();
			if (!flag)
			{
				CompMotion compMotion = owner.GetCompMotion();
				if (compMotion == null || compMotion.curMotionState != MotionState.Jump)
				{
					goto IL_00d5;
				}
			}
			if (rawVelocity.y > 0f && _jumpPress && _jumpPressTime < config.JumpMaxPressTime + config.JumpPreForbidTime && _jumpPressTime > config.JumpPreForbidTime && (owner.GetMotionBool("JumpPress") || owner.GetMotionBool("JumpHold")))
			{
				float jumpPressGravity = config.JumpPressGravity;
				return effectiveGravity + jumpPressGravity;
			}
			goto IL_00d5;
			IL_00d5:
			return effectiveGravity;
		}
	}

	public float HitFallFriction
	{
		get
		{
			if (!hitOverride)
			{
				return 0f;
			}
			if (!(rawVelocity.y > 0f))
			{
				return hitDownwardFriction;
			}
			return hitUpwardFriction;
		}
	}

	public float FallFriction
	{
		get
		{
			if (hitOverride)
			{
				return hitHorizontalFriction;
			}
			return GetEffectiveFallFriction();
		}
	}

	public bool ForbidDir
	{
		get
		{
			return m_FrobidDir;
		}
		set
		{
			m_FrobidDir = value;
		}
	}

	private Vector3 m_MoveGrabbingVelocity => _activeLadder.MoveGrabVelocity;

	protected Vector3 pathLoaclRootMotionVelocity { get; private set; }

	public MotionType motion
	{
		get
		{
			return m_MotionType;
		}
		set
		{
			m_MotionType = value;
			CompInput compInput = owner.GetCompInput();
			if (compInput != null)
			{
				InputDirMode inputDirMode = ((m_MotionType == MotionType.Air) ? InputDirMode.Gimbal : InputDirMode.FourDirection);
				compInput.inputDirMode = inputDirMode;
			}
		}
	}

	public Quaternion faceDirRot => OnPathOrientation * localFaceDirRot;

	public Quaternion localFaceDirRot => QuaternionUtility.FaceLocalRotation(owner.GetCompTransform().FaceDir);

	public bool ConstrainInPlaneZ { get; protected set; }

	public bool InPath { get; protected set; }

	public CinemachinePathBase Path { get; private set; }

	public float GetConstZ => m_ConstZ;

	public Vector3 OnPathPosition { get; private set; }

	public Quaternion OnPathOrientation { get; private set; }

	public Quaternion LastOnPathOrientation { get; private set; }

	public Quaternion InterpolationPathOrientation { get; internal set; }

	public Quaternion InterpolationPathQuaternion => InterpolationPathOrientation * Quaternion.Euler(0f, -90f, 0f);

	public Quaternion OnPathQuaternion => OnPathOrientation * QuaternionUtility.FaceRotation(FaceDir.Left);

	private Vector3 PathBaseTangent
	{
		get
		{
			Vector3 vector = OnPathOrientation * Vector3.forward;
			if (!(vector.sqrMagnitude <= 1E-06f))
			{
				return vector.normalized;
			}
			return Vector3.right;
		}
	}

	private Vector3 PathPlaneNormal
	{
		get
		{
			Vector3 vector = OnPathOrientation * Vector3.left;
			if (!(vector.sqrMagnitude <= 1E-06f))
			{
				return vector.normalized;
			}
			return Vector3.forward;
		}
	}

	public Vector3 pathTangent => PathBaseTangent;

	public Vector3 pathNormal => PathPlaneNormal;

	public bool CantHook { get; private set; }

	public Vector3 HookPoint { get; private set; }

	public bool FrameCollided { get; private set; }

	public bool SidesFrameCollided { get; private set; }

	public bool AboveFrameCollided { get; private set; }

	public bool FrameCliffBlocked { get; private set; }

	public bool IsAdsorbing => state == ACTMovementMode.Adsorbing;

	public bool IsPathSwitchRootMotionFinished => _pathSwitchRootMotionFinished;

	private bool IsSpring => state == ACTMovementMode.Spring;

	public float MaxSpeed => state switch
	{
		ACTMovementMode.Walking => (configMotionPhysics == null || !configMotionPhysics.walkMaxSpeed.isOverride) ? config.Walk.maxSpeed : configMotionPhysics.walkMaxSpeed.value, 
		ACTMovementMode.Flying => (configMotionPhysics == null || !configMotionPhysics.fly.isOverride) ? config.Fly.maxSpeed : configMotionPhysics.fly.value.maxSpeed, 
		ACTMovementMode.Falling => (hitOverride && velocity.y < 0f) ? hitDownwardMaxSpeed : ((configMotionPhysics == null || !configMotionPhysics.fallVertMaxSpeed.isOverride) ? config.Fall.maxSpeed : configMotionPhysics.fallVertMaxSpeed.value), 
		_ => config.Walk.maxSpeed, 
	};

	public float MaxAcceleration => state switch
	{
		ACTMovementMode.Walking => (configMotionPhysics == null || !configMotionPhysics.walkMaxAcceleration.isOverride) ? config.Walk.maxAcceleration : configMotionPhysics.walkMaxAcceleration.value, 
		ACTMovementMode.Flying => (configMotionPhysics == null || !configMotionPhysics.fly.isOverride) ? config.Fly.maxAcceleration : configMotionPhysics.fly.value.maxAcceleration, 
		ACTMovementMode.Falling => (configMotionPhysics == null || !configMotionPhysics.fallMaxAcceleration.isOverride) ? config.Fall.maxAcceleration : configMotionPhysics.fallMaxAcceleration.value, 
		_ => config.Walk.maxAcceleration, 
	};

	public float BrakingDeceleration => state switch
	{
		ACTMovementMode.Falling => hitOverride ? hitOverrideBrakingDecelerationFalling : ((configMotionPhysics == null || !configMotionPhysics.fallMaxBrakingDeceleration.isOverride) ? config.Fall.maxBrakingDeceleration : configMotionPhysics.fallMaxBrakingDeceleration.value), 
		ACTMovementMode.Flying => hitOverride ? hitOverrideBrakingDecelerationFalling : ((configMotionPhysics == null || !configMotionPhysics.fly.isOverride) ? config.Fly.maxBrakingDeceleration : configMotionPhysics.fly.value.maxBrakingDeceleration), 
		ACTMovementMode.Walking => hitOverride ? hitOverrideBrakingDecelerationFalling : ((configMotionPhysics == null || !configMotionPhysics.walkBrakingDeceleration.isOverride) ? config.Walk.maxBrakingDeceleration : configMotionPhysics.walkBrakingDeceleration.value), 
		_ => hitOverride ? hitOverrideBrakingDecelerationFalling : config.Walk.maxBrakingDeceleration, 
	};

	public float Friction => state switch
	{
		ACTMovementMode.Falling => hitOverride ? hitHorizontalFriction : config.Fall.friction, 
		ACTMovementMode.Flying => hitOverride ? hitHorizontalFriction : ((configMotionPhysics == null || !configMotionPhysics.fly.isOverride) ? config.Fly.friction : configMotionPhysics.fly.value.friction), 
		ACTMovementMode.Walking => hitOverride ? hitHorizontalFriction : ((configMotionPhysics == null || !configMotionPhysics.walkFriction.isOverride) ? config.Walk.friction : configMotionPhysics.walkFriction.value), 
		_ => hitOverride ? hitHorizontalFriction : config.Walk.friction, 
	};

	public float MaxFallSpeed
	{
		get
		{
			if (!hitOverride)
			{
				if (!(configMotionPhysics == null) && configMotionPhysics.maxFallSpeed.isOverride)
				{
					return configMotionPhysics.maxFallSpeed.value;
				}
				return config.MaxFallSpeed;
			}
			return hitDownwardMaxSpeed;
		}
	}

	public bool isGrounded => characterMovement.isGrounded;

	public bool DetectCollision
	{
		get
		{
			return characterMovement.detectCollisions;
		}
		set
		{
			characterMovement.detectCollisions = value;
		}
	}

	private float GetEffectiveGravity()
	{
		if (IsUsingInheritedAirSwitchPhysics())
		{
			return _inheritAirSwitchGravity;
		}
		if (!(configMotionPhysics == null) && configMotionPhysics.gravity.isOverride)
		{
			return configMotionPhysics.gravity.value;
		}
		return config.Gravity;
	}

	private float GetEffectiveFallFriction()
	{
		if (IsUsingInheritedAirSwitchPhysics())
		{
			return _inheritAirSwitchFallFriction;
		}
		if (!(configMotionPhysics == null) && configMotionPhysics.fallingFriction.isOverride)
		{
			return configMotionPhysics.fallingFriction.value;
		}
		return config.Fall.friction;
	}

	public NormalSwitchMotionSnapshot CaptureNormalSwitchMotionSnapshot()
	{
		NormalSwitchMotionSnapshot result = default;
		FSMRuntimeState layer0Peak = owner.GetCompMotion().layer0Peak;
		if (layer0Peak == null || !IsNormalSwitchMotionState(layer0Peak))
		{
			return result;
		}
		float num = layer0Peak.toLogicTime;
		if (layer0Peak.length > Mathf.Epsilon && layer0Peak.loop)
		{
			num = Mathf.Repeat(num, layer0Peak.length);
		}
		result.isValid = true;
		result.stateName = layer0Peak.state.value.name;
		result.normalizedTime = ((layer0Peak.length > Mathf.Epsilon) ? Mathf.Clamp01(num / layer0Peak.length) : 0f);
		result.movementMode = state;
		result.isInAir = owner.GetMotionBool("InAir") || state != ACTMovementMode.Walking;
		result.isGrounded = isGrounded;
		result.rawVelocity = rawVelocity;
		result.characterMovementVelocity = characterMovement.velocity;
		result.velocity = velocity;
		result.fallingTime = _fallingTime;
		result.freeFallingTime = _freeFallingTime;
		result.jumpPress = _jumpPress;
		result.jumpPressTime = _jumpPressTime;
		result.frameJumpSpeed = _frameJumpSpeed;
		result.jumpPressInput = owner.GetMotionBool("JumpPress");
		result.jumpHoldInput = owner.GetMotionBool("JumpHold");
		result.inheritAirSwitchPhysics = _inheritAirSwitchPhysics;
		result.inheritAirSwitchGravity = _inheritAirSwitchGravity;
		result.inheritAirSwitchFallFriction = _inheritAirSwitchFallFriction;
		result.updraft = owner.GetMotionBool("Updraft");
		result.activeLadder = _activeLadder;
		result.climbingState = climbingState;
		return result;
	}

	private bool IsNormalSwitchMotionState(FSMRuntimeState runtimeState)
	{
		switch (runtimeState.state.value.stateType)
		{
		case MotionState.Move:
			return state == ACTMovementMode.Walking;
		case MotionState.Jump:
		case MotionState.FreeFall:
			return state == ACTMovementMode.Falling;
		case MotionState.Climb:
		case MotionState.ClimbDown:
			if (state == ACTMovementMode.Climbing)
			{
				return _activeLadder != null;
			}
			return false;
		case MotionState.WallClimb:
			return state == ACTMovementMode.WallClimbing;
		case MotionState.Glide:
		case MotionState.Updraft:
			return state == ACTMovementMode.Falling;
		default:
			return false;
		}
	}

	public bool PrepareNormalSwitchMotionRestore(in NormalSwitchMotionSnapshot snapshot)
	{
		switch (snapshot.movementMode)
		{
		case ACTMovementMode.Climbing:
		{
			if (snapshot.activeLadder == null)
			{
				return false;
			}
			if (state == ACTMovementMode.Climbing)
			{
				SetMovementMode(ACTMovementMode.Falling);
			}
			_activeLadder = snapshot.activeLadder;
			Vector3 pos = _activeLadder.ClosestPointOnPath(characterMovement.position, characterMovement.ladderOffset, out var _);
			OnSetPosition(pos);
			_grabbingVelocity = Vector3.zero;
			_grabbingFrameCount = 0;
			return true;
		}
		case ACTMovementMode.WallClimbing:
		{
			rawVelocity = snapshot.rawVelocity;
			characterMovement.velocity = snapshot.characterMovementVelocity;
			velocity = snapshot.velocity;
			InitSensor();
			if (wallSensor == null)
			{
				return false;
			}
			ClimbType climbType = CheckForWall();
			if (climbType == ClimbType.None)
			{
				return false;
			}
			wallClimbingState = climbType;
			attachedWall = null;
			_skipWallSnapOnNextEnter = true;
			return true;
		}
		default:
			return true;
		}
	}

	public void RestoreNormalSwitchMotion(in NormalSwitchMotionSnapshot snapshot)
	{
		_fallingTime = snapshot.fallingTime;
		_freeFallingTime = snapshot.freeFallingTime;
		_jumpPress = snapshot.jumpPress;
		_jumpPressTime = snapshot.jumpPressTime;
		_frameJumpSpeed = snapshot.frameJumpSpeed;
		_inheritAirSwitchPhysics = snapshot.inheritAirSwitchPhysics;
		_inheritAirSwitchGravity = snapshot.inheritAirSwitchGravity;
		_inheritAirSwitchFallFriction = snapshot.inheritAirSwitchFallFriction;
		owner.SetBool("JumpPress", snapshot.jumpPressInput);
		owner.SetBool("JumpHold", snapshot.jumpHoldInput);
		owner.SetBool("Updraft", snapshot.updraft);
		owner.SetBool("OnGround", snapshot.isGrounded);
		owner.SetBool("InAir", snapshot.isInAir);
		owner.SetFloat("Vy", snapshot.rawVelocity.y);
		owner.SetFloat("FallingTime", _fallingTime);
		if (snapshot.movementMode == ACTMovementMode.Climbing)
		{
			climbingState = snapshot.climbingState;
			return;
		}
		if (snapshot.movementMode == ACTMovementMode.WallClimbing)
		{
			_skipWallSnapOnNextEnter = false;
			return;
		}
		rawVelocity = snapshot.rawVelocity;
		characterMovement.velocity = snapshot.characterMovementVelocity;
		velocity = snapshot.velocity;
		SetMovementMode(snapshot.movementMode);
	}

	public void AbortNormalSwitchMotionRestore()
	{
		if (state == ACTMovementMode.Climbing)
		{
			SetMovementMode(ACTMovementMode.Falling);
		}
		else if (state == ACTMovementMode.WallClimbing)
		{
			MotionExitWallClimb();
		}
		_activeLadder = null;
		climbingState = ClimbingState.None;
		wallClimbingState = ClimbType.None;
		_skipWallSnapOnNextEnter = false;
	}

	internal void InheritAirSwitchPhysicsFrom(CompPhysics source)
	{
		rawVelocity = source.rawVelocity;
		characterMovement.velocity = source.characterMovement.velocity;
		_fallingTime = source._fallingTime;
		_freeFallingTime = source._freeFallingTime;
		_jumpPress = source._jumpPress;
		_jumpPressTime = source._jumpPressTime;
		_frameJumpSpeed = source._frameJumpSpeed;
		float effectiveGravity = source.GetEffectiveGravity();
		if (rawVelocity.y > 0f && effectiveGravity < -30f)
		{
			_inheritAirSwitchPhysics = true;
			_inheritAirSwitchGravity = effectiveGravity;
			_inheritAirSwitchFallFriction = source.GetEffectiveFallFriction();
		}
		else
		{
			ClearInheritedAirSwitchPhysics();
		}
		owner.SetBool("JumpPress", source.owner.GetMotionBool("JumpPress"));
		owner.SetBool("JumpHold", source.owner.GetMotionBool("JumpHold"));
		owner.SetBool("OnGround", value: false);
		owner.SetBool("InAir", value: true);
		owner.SetFloat("Vy", rawVelocity.y);
		owner.SetFloat("FallingTime", _fallingTime);
	}

	private bool IsUsingInheritedAirSwitchPhysics()
	{
		if (_inheritAirSwitchPhysics && state == ACTMovementMode.Falling)
		{
			return rawVelocity.y > 0f;
		}
		return false;
	}

	private void UpdateInheritedAirSwitchPhysicsState()
	{
		if (_inheritAirSwitchPhysics && (state != ACTMovementMode.Falling || rawVelocity.y <= 0f))
		{
			ClearInheritedAirSwitchPhysics();
		}
	}

	private void ClearInheritedAirSwitchPhysics()
	{
		_inheritAirSwitchPhysics = false;
	}

	public static bool IsGroundLikeMotion(MotionType motionType)
	{
		return motionType == MotionType.Ground;
	}

	private bool IsGroundLikeMotion()
	{
		return IsGroundLikeMotion(motion);
	}

	public void AddPath(MotionPath motionPath)
	{
		if (!motionPaths.Contains(motionPath))
		{
			if (owner == MonoECS.instance.mainEntity && LuminApplication.LogEnabled)
			{
				Debug.Log("add path !!! " + motionPath.name);
			}
			motionPaths.Add(motionPath);
			List<MotionPath> list = motionPaths;
			TrySetPath(list[list.Count - 1].pathBase);
		}
	}

	public void RemovePath(MotionPath motionPath)
	{
		if (motionPaths.Remove(motionPath))
		{
			if (owner == MonoECS.instance.mainEntity && LuminApplication.LogEnabled)
			{
				Debug.Log("remove path !!! " + motionPath.name);
			}
			if (motionPaths.Count > 0)
			{
				List<MotionPath> list = motionPaths;
				TrySetPath(list[list.Count - 1].pathBase);
			}
			else
			{
				TrySetPath(null);
			}
		}
	}

	public void ClearPath()
	{
		if (owner == MonoECS.instance.mainEntity && LuminApplication.LogEnabled)
		{
			Debug.Log("clear path!!!");
		}
		motionPaths.Clear();
		TrySetPath(null);
	}

	public void SetPathOffset(Vector3 off)
	{
		pathOffset = off;
	}

	public void TrySetPath(CinemachinePathBase newPath)
	{
		if (newPath != Path)
		{
			ChangePath(newPath);
		}
	}

	private void ChangePath(CinemachinePathBase newPath)
	{
		Path = newPath;
		if ((bool)Path)
		{
			InPath = true;
			FirstFindClosestPoint();
		}
		else
		{
			FirstFindConstZ();
		}
	}

	private void FirstFindConstZ()
	{
		if (ConstrainInPlaneZ)
		{
			InPath = false;
			OnPathOrientation = QuaternionUtility.FaceRotation(FaceDir.Right);
			m_ConstZ = characterMovement.position.z - rootRight;
			OnPathPosition = characterMovement.position.WithZ(m_ConstZ);
		}
	}

	public void SetConstZ(float z)
	{
		m_ConstZ = z;
	}

	public void SetConstrainInPlane(bool constrain)
	{
		ConstrainInPlaneZ = constrain;
		if (ConstrainInPlaneZ)
		{
			if (Path != null && InPath)
			{
				FirstFindClosestPoint();
				return;
			}
			OnPathOrientation = QuaternionUtility.FaceRotation(FaceDir.Right);
			OnPathPosition = characterMovement.position.WithZ(m_ConstZ);
		}
	}

	private void FirstFindClosestPoint()
	{
		if (owner.IsValid && ConstrainInPlaneZ)
		{
			int startSegment = Mathf.FloorToInt(Path.ToNativePathUnits(Path.PathLength, CinemachinePathBase.PositionUnits.Distance) / 2f);
			_PathPosNativeUnit = Path.FindClosestPoint(owner.GetCompTransform().physicsPosition, startSegment, -1, 20);
			_PathPosDistanceUnit = Path.FromPathNativeUnits(_PathPosNativeUnit, CinemachinePathBase.PositionUnits.Distance);
			OnPathPosition = Path.EvaluatePosition(_PathPosNativeUnit) + pathOffset;
			OnPathOrientation = QuaternionUtility.ProjectRotationOnXZPlane(Path.EvaluateOrientation(_PathPosNativeUnit));
		}
	}

	private void UpdatePath()
	{
		for (int num = motionPaths.Count - 1; num >= 0; num--)
		{
			if (motionPaths[num] == null)
			{
				motionPaths.RemoveAt(num);
			}
		}
		if (Path == null && motionPaths.Count > 0)
		{
			TrySetPath(motionPaths[0].pathBase);
		}
		if (InPath && Path == null)
		{
			FirstFindConstZ();
		}
	}

	private void UpdatePathPosAndRotation()
	{
		if (Path != null && ConstrainInPlaneZ)
		{
			float num = Path.FindClosestPoint(characterMovement.position, Mathf.FloorToInt(_PathPosNativeUnit), 2, 20);
			float num2 = Path.FromPathNativeUnits(num, CinemachinePathBase.PositionUnits.Distance);
			if (Mathf.Abs(num2 - _PathPosDistanceUnit) > 0.005f)
			{
				_PathPosNativeUnit = num;
				_PathPosDistanceUnit = num2;
			}
			OnPathPosition = Path.EvaluatePosition(_PathPosNativeUnit) + pathOffset;
			OnPathOrientation = QuaternionUtility.ProjectRotationOnXZPlane(Path.EvaluateOrientation(_PathPosNativeUnit));
		}
		else
		{
			OnPathOrientation = QuaternionUtility.FaceRotation(FaceDir.Right);
		}
	}

	public void InitPathOrientation(Quaternion quaternion)
	{
		OnPathOrientation = quaternion;
	}

	public Vector3 PathLocalToWorld(Vector3 local)
	{
		return Quaternion.FromToRotation(Vector3.forward, pathTangent) * local;
	}

	public Vector3 WorldToPathLocal(Vector3 world)
	{
		return Quaternion.FromToRotation(pathTangent, Vector3.forward) * Vector3.ProjectOnPlane(world, pathNormal);
	}

	public void SetCliffBlockDetection(bool enabled)
	{
		if (characterMovement != null)
		{
			characterMovement.detectCliffBlock = enabled;
		}
		if (!enabled)
		{
			FrameCliffBlocked = false;
		}
	}

	public float GetDeltaTime()
	{
		return deltaTime;
	}

	public CompPhysics()
	{
		overlaped = new List<(PushImpetusData, Collider)>();
		pushGameObjects = new List<(PushImpetusData, Collider)>();
		pushCallBacks = new HashSet<IPushCallBack>();
		lastPushCallBacks = new HashSet<IPushCallBack>();
		pushCallBacksCache = new HashSet<IPushCallBack>();
		hitCallBacks = new HashSet<IHitWallCallBack>();
		lastHitCallBacks = new HashSet<IHitWallCallBack>();
		ConstrainInPlaneZ = true;
	}

	public void DetectCollisionsChange(bool value)
	{
		DetectCollisionsChange evt = Singleton<EventManager>.instance.GetEvt<DetectCollisionsChange>();
		evt.enable = value;
		evt.entity = owner;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.DetectCollisionsChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		MonoEntity mono = owner.GetMono();
		if (mono != null)
		{
			mono.onDisable -= OnMonoDisable;
			mono.onDestroy -= OnMonoDestroy;
		}
		if (this.characterMovement != null)
		{
			this.characterMovement.detectCliffBlock = false;
			CharacterMovement characterMovement = this.characterMovement;
			characterMovement.detectCollisionsAction = (Action<bool>)Delegate.Remove(characterMovement.detectCollisionsAction, new Action<bool>(DetectCollisionsChange));
		}
		FrameCliffBlocked = false;
		this.characterMovement = null;
		state = ACTMovementMode.None;
		m_DefaultRootTransformOffset = Vector3.zero;
		m_RootTransformOffsetLocalBase = Vector3.zero;
		m_RootTransformOffsetWorld = Vector3.zero;
		m_IsWallClimbCompensation = false;
		impartPlatformVelocity = true;
		applyPushForce = true;
		_fallingTime = 0f;
		_freeFallingTime = 0f;
		ResetUpdraftExitAcceleration();
		getHit = false;
		hitVelocity = Vector3.zero;
		_customMovementMode = 0;
		lastFramePathLocalVelocity = (velocity = Vector3.zero);
		motionPaths.Clear();
		Path = null;
		_PathPosDistanceUnit = 0f;
		OnPathPosition = Vector3.zero;
		OnPathOrientation = Quaternion.identity;
		pauseVelocity = false;
		overlaped.Clear();
		rawVelocity = Vector2.zero;
		pushGameObjects.Clear();
		pushCallBacks.Clear();
		lastPushCallBacks.Clear();
		pushCallBacksCache.Clear();
		ConstrainInPlaneZ = true;
		m_BeCarryedConstrainInPlane = false;
		m_HasBeCarryedConstrainInPlane = false;
		hitOverride = false;
		overlapEntityMode = OverlapEntityMode.DashCrossable;
		m_FrobidDir = false;
		_jumpPress = false;
		_jumpPressTime = 0f;
		_frameJumpSpeed = 0f;
		_useRootMotionY = false;
		_useRootMotionXZ = false;
		m_LastUseRootMotionY = false;
		m_IgnoreEnvironmentCollisionTagRefCounts?.Clear();
		ResetSensor();
	}

	public void Simulate(float d)
	{
		characterMovement.SetPosition(owner.GetCompTransform().physicsPosition);
		deltaTime = d;
		UpdateFrameParam();
		Move();
		AfterMove();
		UpdateStuckDetection();
	}

	public void SimulateRootMotionOnly(float d)
	{
		characterMovement.SetPosition(owner.GetCompTransform().physicsPosition);
		deltaTime = d;
		UpdateFrameParam();
		CalcRootMotion();
		rawVelocity = ApplyRootMotion(Vector3.zero);
		HandleRawVelocity();
		characterMovement.constrainToGround = false;
		characterMovement.Move(deltaTime, Vector3.zero);
		FrameCliffBlocked = characterMovement.frameCliffBlocked;
		UpdatePathPosAndRotation();
		SetEntityValue();
	}

	private void UpdateFrameParam()
	{
		LastOnPathOrientation = OnPathOrientation;
		FrameCollided = false;
		SidesFrameCollided = false;
		AboveFrameCollided = false;
		FrameCliffBlocked = false;
		CompMotion compMotion = owner.GetCompMotion();
		ConfigMotion layer0PeakConfig = compMotion.layer0PeakConfig;
		_useRootMotionXZ = layer0PeakConfig.RootMotionXZ && !compMotion.InTag(MotionTag_backUp.InputControl);
		_useRootMotionY = layer0PeakConfig.RootMotionY && !compMotion.InTag(MotionTag_backUp.GravityControl);
		UpdatePath();
		UpdateLadder();
		UpdateJumpDownCollider();
	}

	private void SetEntityValue()
	{
		CompMotion? compMotion = owner.GetCompMotion();
		compMotion.SetFloat("Vx", rawVelocity.z);
		compMotion.SetFloat("Vy", rawVelocity.y);
		compMotion.SetFloat("AbsVx", Mathf.Abs(rawVelocity.z));
		compMotion.SetFloat("AbsVy", Mathf.Abs(rawVelocity.y));
		bool flag = isGrounded;
		compMotion.SetBool("OnGround", flag);
		compMotion.SetBool("InAir", !flag);
		compMotion.SetFloat("FallingTime", owner.GetCompPhysics()._fallingTime);
		groundDistance = 0f;
		if (!flag)
		{
			characterMovement.ComputeGroundDistance(characterMovement.position, characterMovement.radius, 20f, 20f, out var outGroundResult, BattleConsts.enviromentMask);
			if (outGroundResult.hitGround)
			{
				groundDistance = outGroundResult.GetDistanceToGround();
			}
			else
			{
				groundDistance = 20f;
			}
		}
		compMotion.SetFloat("GroundDistance", groundDistance);
		CompTransform compTransform = owner.GetCompTransform();
		compTransform.UpdatePositionFromPhysics(characterMovement.position);
		if (state == ACTMovementMode.Orbital360)
		{
			compTransform.rotation = GetOrbital360Rotation();
			compTransform.FaceRotation = compTransform.rotation;
			compTransform.PathRotation = compTransform.rotation;
		}
		else
		{
			compTransform.FaceRotation = faceDirRot;
			compTransform.PathRotation = OnPathOrientation;
		}
	}

	public void ExternalComputeGroundDistance(Vector3 characterPosition, float height, Vector3 capsuleCenter, float radius, Quaternion rotation, float sweepDistance, float castDistance, out FindGroundResult outGroundResult, LayerMask groundDistanceLayerMask)
	{
		characterMovement.ExternalComputeGroundDistance(characterPosition, height, capsuleCenter, radius, rotation, sweepDistance, castDistance, out outGroundResult, groundDistanceLayerMask);
	}

	private void UpdateJumpDownCollider()
	{
		if (owner.IsCharacter())
		{
			if (!m_AllJumpDownColliders.Contains(m_JumpDownCollider) && m_JumpDownCollider != null)
			{
				characterMovement.IgnoreCollision(m_JumpDownCollider, ignore: false);
				m_JumpDownCollider = null;
			}
			m_AllJumpDownColliders.Clear();
			if ((bool)characterMovement.groundCollider)
			{
				owner.SetBool("jumpDown", JumpDownLayer.Contains(characterMovement.groundCollider));
			}
			else
			{
				owner.SetBool("jumpDown", value: false);
			}
		}
	}

	private void OverLapToJumpDownCollider()
	{
		if (!owner.IsCharacter() || !(m_JumpDownTime > 0f))
		{
			return;
		}
		m_JumpDownTime -= deltaTime;
		if (m_JumpDownTime <= 0f)
		{
			m_JumpDownTime = 0f;
			m_AllJumpDownColliders.Add(m_JumpDownCollider);
			characterMovement.IgnoreCollision(characterMovement.groundCollider, ignore: false);
			return;
		}
		PauseGroundConstraint();
		characterMovement.IgnoreCollision(characterMovement.groundCollider);
		if (!m_AllJumpDownColliders.Contains(m_JumpDownCollider))
		{
			m_AllJumpDownColliders.Add(m_JumpDownCollider);
		}
	}

	private void UpdateLadder()
	{
		if (IsClimbing() && !(_activeLadder != null))
		{
			owner.SetTrigger("ClimbExit");
			owner.SetBool("IsClimbState", value: false);
			MotionExitClimb();
		}
	}

	public void ClearLastFrameVelocity()
	{
		lastFramePathLocalVelocity = (velocity = Vector3.zero);
	}

	public void InitRotation(bool faceLeft)
	{
		UpdatePathPosAndRotation();
		if (state == ACTMovementMode.Orbital360)
		{
			ApplyOrbital360Rotation();
			return;
		}
		float y = QuaternionUtility.FaceLocalYAngle((!faceLeft) ? FaceDir.Right : FaceDir.Left);
		SetCharacterMovementRotation(OnPathOrientation * Quaternion.Euler(0f, y, 0f));
	}

	public void GetHit(CmdHit hit, bool changeDir)
	{
		float f = hit.angle * (MathF.PI / 180f);
		float y = Mathf.Sin(f) * hit.length;
		float f2 = Mathf.Cos(f) * hit.length;
		float z = (hit.attackeeAtLeft ? (0f - Mathf.Abs(f2)) : Mathf.Abs(f2));
		if (hit.overrideSpeed)
		{
			hitVelocity = new Vector3(0f, y, z);
		}
		else
		{
			hitVelocity += new Vector3(0f, y, z);
		}
		hitOverrideBrakingDecelerationFalling = hit.hitBrakingDeceleration;
		hitHorizontalFriction = hit.hitHorizontalFriction;
		hitUpwardFriction = hit.upwardFriction;
		hitUpwardGravity = hit.upwardGravity;
		hitDownwardFriction = hit.downwardFriction;
		hitDownwardMaxSpeed = hit.downwardMaxSpeed;
		hitDownwardGravity = hit.downwardGravity;
		horizontalHitWallNum = ((hit.horizontalHitWallNum == 0) ? horizontalHitWallNum : hit.horizontalHitWallNum);
		verticalHitWallNum = ((hit.verticalHitWallNum == 0) ? verticalHitWallNum : hit.verticalHitWallNum);
		if (changeDir)
		{
			hitFaceDir = (hit.attackeeAtLeft ? FaceDir.Right : FaceDir.Left);
		}
		else
		{
			hitFaceDir = FaceDir.None;
		}
		hitUp = hit.hitLevel >= 2 || hit.groundprotection;
		getHit = true;
		if (isBeControled)
		{
			EnterHit();
		}
	}

	public void EnterHit()
	{
		if (!getHit)
		{
			return;
		}
		if (state == ACTMovementMode.BeCarryed)
		{
			getHit = false;
			hitVelocity = Vector3.zero;
			return;
		}
		getHit = false;
		if (hitFaceDir != FaceDir.None)
		{
			owner.SetFaceDir(hitFaceDir);
			owner.GetCompMotion().layer0Peak.startFaceDir = hitFaceDir;
			immediatelySetDir = true;
		}
		hitOverride = true;
		rawVelocity = AdjustHitVelocityByWall(hitVelocity);
		hitVelocity = Vector3.zero;
		bool flag = owner.IsCharacter();
		if ((!flag && hitUp) || (flag && !owner.GetCompMotion().layer0PeakConfig.RootMotionY && rawVelocity.y > 0f))
		{
			if (motion != MotionType.None)
			{
				SetMovementMode(ACTMovementMode.Falling);
			}
			PauseGroundConstraint();
		}
	}

	private Vector3 AdjustHitVelocityByWall(Vector3 inHitVelocity)
	{
		Vector3 result = inHitVelocity;
		Vector3 initialVelocity = new Vector3(result.x, 0f, result.z);
		if (initialVelocity.sqrMagnitude <= 1E-06f)
		{
			return result;
		}
		Vector3 normalized = new Vector3(initialVelocity.z, 0f, initialVelocity.x).normalized;
		Vector3 position = characterMovement.position;
		float height = characterMovement.height;
		Vector3 origin = new Vector3(position.x, position.y + height / 2f, position.z);
		MonoEntity mono = owner.GetMono();
		if (mono.sonColliders == null || mono.sonColliders.Length == 0)
		{
			return result;
		}
		Vector3 sonCollidersCenterOffset = mono.SonCollidersCenterOffset;
		float num = mono.SonColliderBounds.size.x / 2f;
		float num2 = num + sonCollidersCenterOffset.x;
		float num3 = num - sonCollidersCenterOffset.x;
		owner.GetCompTransform();
		bool flag = owner.IsFaceLeft();
		float num4;
		if (normalized.x > 0f)
		{
			num4 = (flag ? num3 : num2);
		}
		else
		{
			num4 = (flag ? num2 : num3);
		}
		float num5 = float.MaxValue;
		if (Physics.Raycast(origin, normalized, out var hitInfo, 5f, BattleConsts.enviromentMask))
		{
			num5 = hitInfo.distance - num4;
			if (num5 <= 0f)
			{
				num5 = 0f;
			}
		}
		if (num5 >= 5f)
		{
			return result;
		}
		float num6 = PredictDisplacementUntilStop(initialVelocity);
		if (num6 <= num5)
		{
			return result;
		}
		float b = num5 / num6;
		b = Mathf.Max(0f, b);
		initialVelocity.x *= b;
		initialVelocity.z *= b;
		result.x = initialVelocity.x;
		result.z = initialVelocity.z;
		return result;
	}

	public void ExitHit()
	{
		horizontalHitWallNum = (verticalHitWallNum = 0);
		hitOverride = false;
	}

	public void PauseGroundConstraint()
	{
		characterMovement.PauseGroundConstraint();
	}

	private void ApplyRecoverPushImpetus()
	{
		for (int num = overlaped.Count - 1; num >= 0; num--)
		{
			PushImpetusData item = overlaped[num].Item1;
			Collider item2 = overlaped[num].Item2;
			if (item2 == null || (!item.otherEntity.IsValid && !item.isGameObject))
			{
				RemoveOverlap(overlaped[num]);
			}
			else if (item.isGameObject || !EffectCollisionFilter(item.otherEntity))
			{
				if (Physics.ComputePenetration(characterMovement.collider, characterMovement.position, characterMovement.rotation, item2, item2.transform.position, item2.transform.rotation, out var _, out var _))
				{
					Vector3 vector = (characterMovement.worldCenter - item2.transform.position).projectedOnPlane(GetUpVector());
					vector.z = 0f;
					float pushImpetusBase = item.pushImpetusBase;
					if (pushImpetusBase == 0f)
					{
						recover = Vector3.zero;
					}
					else
					{
						float magnitude = vector.magnitude;
						float num2 = 0f;
						float num3 = 0f;
						float num4 = 0f;
						if (item2 is CapsuleCollider capsuleCollider)
						{
							num2 = capsuleCollider.radius;
							num3 = capsuleCollider.height / 2f;
						}
						else if (item2 is BoxCollider boxCollider)
						{
							Vector3 vector2 = boxCollider.transform.TransformDirection(boxCollider.size);
							num2 = vector2.x / 2f;
							num3 = vector2.y / 2f;
						}
						if (item.customDirection)
						{
							switch (item.direction)
							{
							case PushDirection.Left:
								vector = Vector3.left;
								magnitude = (item2.bounds.center + num2 * -Vector3.left - characterMovement.position).projectedOnPlane(GetUpVector()).magnitude;
								num4 = 2f * num2 * item2.bounds.extents.x + characterMovement.radius * characterMovement.transform.lossyScale.x;
								break;
							case PushDirection.Right:
								vector = Vector3.right;
								magnitude = (item2.bounds.center + num2 * -Vector3.right - characterMovement.position).projectedOnPlane(GetUpVector()).magnitude;
								num4 = 2f * num2 * item2.bounds.extents.x + characterMovement.radius * characterMovement.transform.lossyScale.x;
								break;
							case PushDirection.Horizontal:
								vector = Vector3.Project(vector, Vector3.right).normalized;
								if (VectorUtility.V3isZero(vector))
								{
									vector = Vector3.right;
								}
								magnitude = (item2.bounds.center + num2 * vector - characterMovement.position).projectedOnPlane(Vector3.forward).magnitude;
								num4 = 2f * num2 * item2.bounds.extents.x + characterMovement.radius * characterMovement.transform.lossyScale.x;
								break;
							case PushDirection.Vertical:
								vector = Vector3.Project(characterMovement.worldCenter - item2.transform.position, Vector3.up).normalized;
								if (VectorUtility.V3isZero(vector))
								{
									vector = Vector3.up;
								}
								magnitude = (item2.bounds.center + num3 * vector - characterMovement.position).projectedOnPlane(Vector3.forward).magnitude;
								num4 = 2f * num3 * item2.bounds.extents.y + characterMovement.height / 2f * characterMovement.transform.lossyScale.y;
								break;
							}
						}
						else
						{
							num4 = num2 * item2.bounds.extents.x + characterMovement.radius * characterMovement.transform.lossyScale.x;
						}
						float time = Mathf.Abs(magnitude / num4);
						float num5 = GameLoader.meta.curveLibrary.GetCurve(item.pushImpetusCurve).Evaluate(time);
						if (VectorUtility.V3isZero(vector))
						{
							vector = pathTangent;
						}
						if (owner.IsAlive())
						{
							recover = vector.normalized * Mathf.Max(0.01f, pushImpetusBase * num5 / Mass);
						}
						else
						{
							recover = Vector3.zero;
						}
					}
				}
				else
				{
					RemoveOverlap(overlaped[num]);
				}
			}
		}
	}

	public void SetMovementMode(ACTMovementMode newMovementMode, int newCustomMode = 0)
	{
		if (newMovementMode != state || (newMovementMode == ACTMovementMode.Custom && newCustomMode != _customMovementMode))
		{
			ACTMovementMode prevMovementMode = state;
			int customMovementMode = _customMovementMode;
			state = newMovementMode;
			_customMovementMode = newCustomMode;
			OnMovementModeChanged(prevMovementMode, customMovementMode);
		}
	}

	protected void OnMovementModeChanged(ACTMovementMode prevMovementMode, int prevCustomMode)
	{
		if (state != ACTMovementMode.Falling)
		{
			ClearInheritedAirSwitchPhysics();
			ResetUpdraftExitAcceleration();
		}
		switch (prevMovementMode)
		{
		case ACTMovementMode.GrabHook:
			owner.SetTrigger("hookOver");
			owner.SetBool("hookTransfer", value: false);
			owner.SetBool("hooking", value: false);
			characterMovement.height = 1f / config.HookHeightScale * characterMovement.height;
			break;
		case ACTMovementMode.Spring:
			owner.SetTrigger("springOver");
			characterMovement.height = 1f / config.HookHeightScale * characterMovement.height;
			break;
		case ACTMovementMode.Climbing:
			if (_activeLadder != null)
			{
				if (_activeLadder.rig != null && _activeLadder.rig == characterMovement.movingPlatform.platform)
				{
					characterMovement.SetPlatform(null);
				}
				if ((bool)_activeLadder.topCollider)
				{
					characterMovement.IgnoreCollision(_activeLadder.topCollider, ignore: false);
				}
				_activeLadder = null;
			}
			switch (owner.GetCompInput().dirX)
			{
			case EInputDir.Left:
				owner.SetFaceDir(FaceDir.Left);
				break;
			case EInputDir.Right:
				owner.SetFaceDir(FaceDir.Right);
				break;
			}
			climbingState = ClimbingState.None;
			break;
		case ACTMovementMode.Orbital360:
			ExitOrbital360Move();
			break;
		case ACTMovementMode.PathSwitchRootMotion:
			StopPathSwitchRootMotion();
			break;
		}
		switch (state)
		{
		case ACTMovementMode.Walking:
			owner.OnWalking();
			rawVelocity.y = 0f;
			if (prevMovementMode == ACTMovementMode.Flying || prevMovementMode == ACTMovementMode.Swimming || prevMovementMode == ACTMovementMode.Climbing || prevMovementMode == ACTMovementMode.Recalling || prevMovementMode == ACTMovementMode.WallClimbing)
			{
				characterMovement.constrainToGround = true;
			}
			break;
		case ACTMovementMode.Falling:
			owner.OnFalling();
			if (prevMovementMode == ACTMovementMode.Flying || prevMovementMode == ACTMovementMode.Swimming || prevMovementMode == ACTMovementMode.Climbing || prevMovementMode == ACTMovementMode.Adsorbing || prevMovementMode == ACTMovementMode.WallClimbing)
			{
				characterMovement.constrainToGround = true;
			}
			break;
		case ACTMovementMode.Swimming:
			characterMovement.constrainToGround = false;
			break;
		case ACTMovementMode.Flying:
			characterMovement.constrainToGround = false;
			break;
		case ACTMovementMode.Recalling:
			characterMovement.constrainToGround = false;
			break;
		case ACTMovementMode.GrabHook:
			characterMovement.PauseGroundConstraint();
			hookDistance = HookPoint - owner.GetCompTransform().colliderPosition;
			hookEndPoint = HookPoint + hookDistance.normalized * config.GrabHookExtends;
			hookDistance += hookDistance.normalized * config.GrabHookExtends;
			throughHookPoint = false;
			hookTime = 0f;
			owner.SetBool("hookTransfer", value: false);
			owner.SetBool("hooking", value: true);
			ClearFallingAccumulateSpeed();
			hookBlockTime = 0f;
			characterMovement.height = config.HookHeightScale * characterMovement.height;
			break;
		case ACTMovementMode.Spring:
			characterMovement.PauseGroundConstraint();
			m_SpringDistance = m_EndPoint - characterMovement.position;
			m_SpringTime = 0f;
			m_SpringColliedTime = 0f;
			ClearFallingAccumulateSpeed();
			break;
		case ACTMovementMode.Climbing:
			if (_activeLadder != null && _activeLadder.rig != null)
			{
				characterMovement.SetPlatform(_activeLadder.rig);
			}
			if (_activeLadder != null && (bool)_activeLadder.topCollider)
			{
				characterMovement.IgnoreCollision(_activeLadder.topCollider);
			}
			characterMovement.PauseGroundConstraint(0.2f);
			rawVelocity = Vector3.zero;
			break;
		case ACTMovementMode.Orbital360:
			EnterOrbital360Move();
			break;
		case ACTMovementMode.BeCarryed:
			m_BeCarryedConstrainInPlane = ConstrainInPlaneZ;
			m_HasBeCarryedConstrainInPlane = true;
			characterMovement.constrainToGround = false;
			SetConstrainInPlane(constrain: false);
			break;
		case ACTMovementMode.PathSwitchRootMotion:
			_pathSwitchRootMotionState = PathSwitchRootMotionState.RotateToMoveDirection;
			_pathSwitchRootMotionFinished = false;
			characterMovement.velocity = Vector3.zero;
			break;
		}
		if (!IsFalling())
		{
			_freeFallingTime = 0f;
			if (!IsGrabHooking())
			{
				_fallingTime = 0f;
			}
		}
	}

	private void HandleRawVelocity()
	{
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.Timeline) && owner.IsCharacter() && !owner.InTag(MotionTag_backUp.TimelineAllowRootMotion))
		{
			rawVelocity.z = 0f;
		}
		Vector3 vector = rawVelocity * deltaTime;
		Vector3 position = characterMovement.position;
		Vector3 worldVelocity = Vector3.zero;
		if (ConstrainInPlaneZ)
		{
			if (Path != null)
			{
				_PathPosDistanceUnit += vector.z;
				_PathPosNativeUnit = Path.ToNativePathUnits(_PathPosDistanceUnit, CinemachinePathBase.PositionUnits.Distance);
				Vector3 vector2 = Path.EvaluatePosition(_PathPosNativeUnit);
				Vector3 vector3 = QuaternionUtility.ProjectRotationOnXZPlane(Path.EvaluateOrientation(_PathPosNativeUnit)) * Vector3.right;
				vector2.y = position.y + vector.y;
				position = vector2 + vector3 * rootRight;
				worldVelocity = ((deltaTime == 0f) ? Vector3.zero : ((position - characterMovement.position) / deltaTime));
			}
			else
			{
				worldVelocity.y = rawVelocity.y;
				worldVelocity.x = rawVelocity.z;
				worldVelocity.z = ((deltaTime == 0f) ? 0f : ((m_ConstZ - rootRight - position.z) / deltaTime));
			}
		}
		else
		{
			worldVelocity.y = rawVelocity.y;
			worldVelocity.x = rawVelocity.z;
			worldVelocity.z = ((deltaTime == 0f) ? 0f : ((0f - rootRight) / deltaTime));
		}
		PostWorldVelocity(worldVelocity);
	}

	protected void Walking(Vector3 desiredVelocity)
	{
		Vector3 desired = CalcVelocity(rawVelocity, desiredVelocity, Friction);
		desired = ApplyRootMotion(desired);
		rawVelocity = desired;
		HandleRawVelocity();
	}

	protected void Falling(Vector3 desiredVelocity)
	{
		_fallingTime += deltaTime;
		if (_jumpPress)
		{
			_jumpPressTime += deltaTime;
			if (_jumpPressTime > config.JumpMaxPressTime + config.JumpPreForbidTime)
			{
				_jumpPress = false;
			}
		}
		MotionState curMotionState = owner.GetCompMotion().curMotionState;
		if ((MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.Timeline) && !owner.InTag(MotionTag_backUp.TimelineAllowRootMotion)) || curMotionState == MotionState.Attack || curMotionState == MotionState.AirAttackA || curMotionState == MotionState.Glide || curMotionState == MotionState.Updraft)
		{
			_freeFallingTime = 0f;
		}
		else
		{
			_freeFallingTime += deltaTime;
		}
		Vector3 desired = ApplyCacheVerticalSpeed();
		desired = ApplyJumpSpeed(desired);
		Vector3 vector = new Vector3(rawVelocity.x, 0f, rawVelocity.z);
		vector = CalcVelocity(vector, desiredVelocity, 0f);
		desired.y += (Gravity - desired.y * FallFriction) * deltaTime;
		if (hitOverride)
		{
			desired = ApplyVelocityBraking(desired, HitFallFriction, 0f);
		}
		Vector3 currentVelocity = vector + desired;
		currentVelocity = LimitFallingVelocity(currentVelocity);
		currentVelocity = ApplyRootMotion(currentVelocity);
		CacheVecYBeforeRootMotion(currentVelocity);
		rawVelocity = currentVelocity;
		UpdateInheritedAirSwitchPhysicsState();
		HandleRawVelocity();
	}

	public void EnterCC()
	{
		SetMovementMode(ACTMovementMode.ClimbCompensate);
	}

	public void ExitCC()
	{
		m_IsWallClimbCompensation = false;
		characterMovement.ClearClimbSnapReference();
		if (state == ACTMovementMode.ClimbCompensate)
		{
			if (isGrounded)
			{
				SetMovementMode(ACTMovementMode.Walking);
			}
			else
			{
				SetMovementMode(ACTMovementMode.Falling);
			}
		}
		characterMovement.SetPlatform(null);
	}

	protected virtual void Flying(Vector3 desiredVelocity)
	{
		Vector3 desired = CalcVelocity(rawVelocity, desiredVelocity, Friction, isFluid: true);
		desired = ApplyRootMotion(desired);
		rawVelocity = desired;
		HandleRawVelocity();
	}

	public void MotionEnterAdsorb()
	{
		if (wall.rig != null)
		{
			characterMovement.SetPlatform(wall.rig);
		}
		SetMovementMode(ACTMovementMode.Adsorbing);
		characterMovement.constrainToGround = false;
		rawVelocity = Vector3.zero;
		if (wall.wallFaceDir == FaceDir.Left)
		{
			if (owner.IsFaceLeft())
			{
				owner.SetFaceLeft(left: false);
			}
		}
		else if (!owner.IsFaceLeft())
		{
			owner.SetFaceLeft(left: true);
		}
	}

	public void MotionExitAdsorb()
	{
		if (IsAdsorbing)
		{
			if (characterMovement.isOnWalkableGround)
			{
				SetMovementMode(ACTMovementMode.Walking);
			}
			else
			{
				SetMovementMode(ACTMovementMode.Falling);
			}
			characterMovement.constrainToGround = true;
			if (wall.rig != null && wall.rig == characterMovement.movingPlatform.platform)
			{
				characterMovement.SetPlatform(null);
			}
			adsorbingState = AdsorbingState.None;
			owner.SetBool("ForbidUp", value: false);
			wall = null;
		}
	}

	private bool CanAdsorb()
	{
		if (motion == MotionType.Air)
		{
			return false;
		}
		MotionState curMotionState = owner.GetCompMotion().curMotionState;
		if (curMotionState != MotionState.FreeFall && curMotionState != MotionState.Jump && curMotionState != MotionState.Dodge)
		{
			return false;
		}
		Collider[] array = characterMovement.OverlapTest(characterMovement.position, characterMovement.rotation, characterMovement.radius, characterMovement.height, BattleConsts.enviromentMask, QueryTriggerInteraction.Collide, out var overlapCount);
		if (overlapCount == 0)
		{
			return false;
		}
		for (int i = 0; i < overlapCount; i++)
		{
			if (array[i].TryGetComponent<AdsorbWall>(out wall))
			{
				return true;
			}
		}
		return false;
	}

	public void InputEnterAdsorb()
	{
		if (!IsAdsorbing && CanAdsorb())
		{
			Vector3 attachPointPosition = owner.GetMono().GetAttachPointPosition("waist");
			Vector3 vector = wall.ClosestPointOnPath(attachPointPosition, 1.5f, out var pathPos);
			if (pathPos == 0f)
			{
				owner.SetTrigger("AdsorbEnter");
				adsorbingState = AdsorbingState.Lerp;
				m_AdsorbLerpCount = config.AdsorbLerpCount;
				m_AdsorbLerpVelocity = (vector - characterMovement.position) / ((float)m_AdsorbLerpCount * Time.fixedDeltaTime);
			}
		}
	}

	private void Adsorbing()
	{
		Vector3 vector = ApplyRootMotion((m_AdsorbLerpCount > 0) ? m_AdsorbLerpVelocity : Vector3.zero);
		wall.ClosestPointOnPath(characterMovement.position, 1.5f, out var pathPos);
		Vector3 top = characterMovement.position + characterMovement.rotation * (characterMovement.height * Vector3.up);
		switch (adsorbingState)
		{
		case AdsorbingState.Lerp:
			if (!wall.CanAdsorb())
			{
				owner.SetTrigger("WallMustLeave");
			}
			if (m_AdsorbLerpCount == 0)
			{
				adsorbingState = AdsorbingState.OnWall;
			}
			break;
		case AdsorbingState.OnWall:
			if (!wall.CanAdsorb())
			{
				owner.SetTrigger("WallMustLeave");
			}
			if (pathPos > 0f)
			{
				vector = Vector3.zero;
				owner.SetBool("ForbidUp", value: true);
			}
			else if (pathPos == 0f)
			{
				owner.SetBool("ForbidUp", CheckOtherCollider(top, 0.3f));
				if (owner.GetMotionBool("ForbidUp"))
				{
					vector = Vector3.zero;
				}
			}
			break;
		}
		characterMovement.velocity = vector;
		if (m_AdsorbLerpCount > 0)
		{
			m_AdsorbLerpCount--;
		}
	}

	private bool CheckOtherCollider(Vector3 top, float distance)
	{
		return Physics.CapsuleCast(characterMovement.position, top, characterMovement.radius, Vector3.up, distance, BattleConsts.enviromentMask);
	}

	private void Recalling()
	{
		characterMovement.velocity = Vector3.zero;
	}

	public void MotionEnterRecall()
	{
		characterMovement.SetPlatform(null);
		SetMovementMode(ACTMovementMode.Recalling);
	}

	public void MotionExitReCall()
	{
		SetMovementMode(ACTMovementMode.Walking);
	}

	public void StartPathSwitchRootMotion(Vector3 targetPosition, FaceDir faceDir)
	{
		_pathSwitchRootMotionTargetPosition = targetPosition;
		_pathSwitchRootMotionTargetRotation = QuaternionUtility.FaceLocalYAngle(faceDir);
		MonoECS.instance.ForceToIdle(owner);
		owner.SetFaceDir(faceDir);
		SetMovementMode(ACTMovementMode.PathSwitchRootMotion);
	}

	private void StopPathSwitchRootMotion()
	{
		_pathSwitchRootMotionState = PathSwitchRootMotionState.None;
		_pathSwitchRootMotionFinished = false;
		characterMovement.velocity = Vector3.zero;
		owner.GetCompMotion()?.SetTrigger("StopPathMove");
	}

	private void PathSwitchRootMotionMoving()
	{
		switch (_pathSwitchRootMotionState)
		{
		case PathSwitchRootMotionState.RotateToMoveDirection:
			RotatePathSwitchRootMotion();
			break;
		case PathSwitchRootMotionState.Moving:
			MovePathSwitchRootMotionToTarget();
			break;
		default:
			characterMovement.velocity = Vector3.zero;
			break;
		}
	}

	private void RotatePathSwitchRootMotion()
	{
		characterMovement.velocity = Vector3.zero;
		SetCharacterMovementRotation(OnPathOrientation * Quaternion.Euler(0f, _pathSwitchRootMotionTargetRotation, 0f));
		owner.GetCompTransform().physicsRotateDegree = _pathSwitchRootMotionTargetRotation;
		GameManager.behaveSystem.ForcedChangeToMotionState(owner, "PathMove");
		_pathSwitchRootMotionState = PathSwitchRootMotionState.Moving;
	}

	private void MovePathSwitchRootMotionToTarget()
	{
		Vector3 physicsPosition = owner.GetCompTransform().physicsPosition;
		Vector3 vector = _pathSwitchRootMotionTargetPosition - physicsPosition;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			characterMovement.velocity = Vector3.zero;
			_pathSwitchRootMotionFinished = true;
			return;
		}
		Vector3 vector2 = ApplyRootMotion(Vector3.zero);
		Vector3 lhs = characterMovement.rotation * vector2;
		if (lhs.sqrMagnitude > 1E-06f && Vector3.Dot(lhs, vector) <= 0f)
		{
			characterMovement.velocity = ((deltaTime <= 0f) ? Vector3.zero : (vector / deltaTime));
			_pathSwitchRootMotionFinished = true;
		}
		else
		{
			characterMovement.velocity = lhs;
		}
	}

	public void EnterTeleportSitDown()
	{
		SetMovementMode(ACTMovementMode.TeleportMove);
		_teleportMovePhysicsState = TeleportMovePhysicsState.MoveLerpToSitPos;
		State state = owner.GetCompMotion().moveController.childrenStateLayers[0].states.Find((State e) => (!owner.IsFaceLeft()) ? (e.value.name == "Teleport_SitDown__FaceRight") : (e.value.name == "Teleport_SitDown__FaceLeft"));
		GameManager.behaveSystem.ForcedChangeToMotionState(owner, state);
		_teleportFrameLerpCount = config.TeleportMoveLerpFrames;
		_teleportLerpVelocity = (Singleton<TeleportMoveManager>.instance.SitPosition - characterMovement.position) / ((float)_teleportFrameLerpCount * Time.fixedDeltaTime);
		SetDirImmediately();
	}

	public void RespawnEnterTeleportSitLoop()
	{
		SetMovementMode(ACTMovementMode.TeleportMove);
		_teleportMovePhysicsState = TeleportMovePhysicsState.Sit;
		State state = owner.GetCompMotion().moveController.childrenStateLayers[0].states.Find((State x) => x.value.stateType == MotionState.TeleportSitLoop);
		GameManager.behaveSystem.ForcedChangeToMotionState(owner, state);
		Debug.LogWarning($"时间->{Time.frameCount}, 角色进入SitLoop动作");
		SetCharacterMovementRotation(OnPathOrientation * Quaternion.Euler(0f, QuaternionUtility.FaceLocalYAngle(FaceDir.Back), 0f));
		SetDirImmediately();
	}

	public void MotionExitTeleportMoveToPath()
	{
		SetMovementMode(ACTMovementMode.Walking);
		_teleportMovePhysicsState = TeleportMovePhysicsState.None;
		MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove);
		owner.SetFaceLeft(left: false);
		SetDirImmediately();
		SetConstZ(Singleton<TeleportMoveManager>.instance.PathCenter.z);
	}

	public void MotionEnterTeleportMoveToPath()
	{
		_teleportMovePhysicsState = TeleportMovePhysicsState.MoveToPath;
	}

	private void TeleportMoving()
	{
		switch (_teleportMovePhysicsState)
		{
		case TeleportMovePhysicsState.MoveLerpToSitPos:
			characterMovement.velocity = ((_teleportFrameLerpCount > 0) ? _teleportLerpVelocity : Vector3.zero);
			if (_teleportFrameLerpCount > 0)
			{
				_teleportFrameLerpCount--;
			}
			else
			{
				_teleportMovePhysicsState = TeleportMovePhysicsState.Sit;
			}
			break;
		case TeleportMovePhysicsState.Sit:
			characterMovement.velocity = Vector3.zero;
			break;
		case TeleportMovePhysicsState.MoveToPath:
		{
			Vector3 pathCenter = Singleton<TeleportMoveManager>.instance.PathCenter;
			Vector3 physicsPosition = owner.GetCompTransform().physicsPosition;
			Vector3 normalized = (pathCenter - physicsPosition).normalized;
			Vector3 vector = ApplyRootMotion(Vector3.zero);
			if (Vector3.Dot((characterMovement.rotation * vector).normalized, normalized) <= 0f)
			{
				owner.SetTrigger("TeleportExitMove");
				characterMovement.velocity = (pathCenter - physicsPosition) / deltaTime;
			}
			else
			{
				characterMovement.velocity = characterMovement.rotation * vector;
			}
			break;
		}
		}
	}

	public bool IsClimbing()
	{
		return state == ACTMovementMode.Climbing;
	}

	private bool CanClimb()
	{
		if (motion == MotionType.Air)
		{
			return false;
		}
		MotionState curMotionState = owner.GetCompMotion().curMotionState;
		if (curMotionState != MotionState.Spring && curMotionState != MotionState.Jump && curMotionState != MotionState.FreeFall && curMotionState != MotionState.Move && curMotionState != MotionState.Idle)
		{
			return false;
		}
		Collider[] array = characterMovement.OverlapTest(characterMovement.position, characterMovement.rotation, characterMovement.radius, characterMovement.height, BattleConsts.interactMask, QueryTriggerInteraction.Collide, out var overlapCount);
		if (overlapCount == 0)
		{
			return false;
		}
		for (int i = 0; i < overlapCount; i++)
		{
			if (array[i].TryGetComponent<Ladder>(out _activeLadder))
			{
				return true;
			}
		}
		return false;
	}

	public void InputEnterClimb(bool downBtn)
	{
		if (IsClimbing() || !CanClimb())
		{
			return;
		}
		Vector3 vector = _activeLadder.ClosestPointOnPath(characterMovement.position, characterMovement.ladderOffset, out var pathPosition);
		if (downBtn)
		{
			if (pathPosition <= 0f)
			{
				_activeLadder = null;
				return;
			}
		}
		else if (pathPosition > 0f)
		{
			_activeLadder = null;
			return;
		}
		owner.SetTrigger("Climb");
		_grabbingVelocity = (vector - characterMovement.position) / ((float)config.GrabbingFrames * Time.fixedDeltaTime);
		_grabbingFrameCount = config.GrabbingFrames;
	}

	public void MotionEnterClimbDown()
	{
		climbingState = ClimbingState.DownGrab;
		SetClimbParas();
	}

	public void MotionEnterClimb()
	{
		climbingState = ClimbingState.Grabbed;
		SetClimbParas();
	}

	private void SetClimbParas()
	{
		SetMovementMode(ACTMovementMode.Climbing);
	}

	public void MotionExitClimb()
	{
		if (IsClimbing())
		{
			if (characterMovement.isOnWalkableGround)
			{
				SetMovementMode(ACTMovementMode.Walking);
			}
			else
			{
				SetMovementMode(ACTMovementMode.Falling);
			}
		}
	}

	public void MotionExitClimbDown()
	{
		climbingState = ClimbingState.Grabbed;
	}

	private void Climbing()
	{
		Vector3 vector = ((!_activeLadder.rig) ? ApplyRootMotion((_grabbingFrameCount > 0) ? _grabbingVelocity : Vector3.zero) : ApplyRootMotion(m_MoveGrabbingVelocity));
		switch (climbingState)
		{
		case ClimbingState.DownGrab:
			characterMovement.velocity = vector;
			break;
		case ClimbingState.Grabbed:
		{
			Vector3 vector2 = characterMovement.position + vector * deltaTime;
			_activeLadder.ClosestPointOnPath(vector2, characterMovement.ladderOffset, out var pathPosition);
			if (pathPosition > 0f)
			{
				owner.SetTrigger("ClimbOver");
				climbingState = ClimbingState.Over;
				vector2.y -= pathPosition;
				vector = ((deltaTime == 0f) ? Vector3.zero : ((vector2 - characterMovement.position) / deltaTime));
			}
			else if (characterMovement.isOnWalkableGround || pathPosition < 0f)
			{
				owner.SetTrigger("ClimbExit");
			}
			characterMovement.velocity = vector;
			break;
		}
		case ClimbingState.Over:
			owner.SetTrigger("ClimbOver");
			characterMovement.velocity = vector;
			break;
		}
		if (_grabbingFrameCount > 0)
		{
			_grabbingFrameCount--;
		}
	}

	private bool CanSpring()
	{
		if (!owner.IsCharacter())
		{
			return false;
		}
		if (owner.InTag(MotionTag_backUp.CantSpring))
		{
			return false;
		}
		return true;
	}

	public bool TriggerEnterSpring(Vector3 startPoint, Vector3 endPoint)
	{
		if (!CanSpring())
		{
			if (owner.IsMonster())
			{
				Vector3 vector = (characterMovement.worldCenter - characterMovement.groundCollider.transform.position).projectedOnPlane(GetUpVector());
				owner.GetCompPhysics().characterMovement.AddForce(vector * 5f, ForceMode.VelocityChange);
			}
			return false;
		}
		float num = Vector3.Dot(startPoint - endPoint, (characterMovement.position - endPoint).normalized);
		Vector3 startPoint2 = endPoint + (characterMovement.position - endPoint).normalized * num;
		startPoint2.y = startPoint.y;
		characterMovement.position = (m_StartPoint = startPoint2);
		m_EndPoint = m_StartPoint + (endPoint - startPoint).normalized * Vector3.Distance(startPoint, endPoint);
		if (MathF.Abs(characterMovement.position.x - m_EndPoint.x) > 0.1f)
		{
			bool flag = false;
			flag = Vector3.Dot(characterMovement.position - m_EndPoint, pathTangent) > 0f;
			owner.SetFaceLeft(flag);
			SetDirImmediately();
		}
		rawVelocity = Vector3.zero;
		if (IsSpring)
		{
			m_SpringDistance = m_EndPoint - characterMovement.position;
			m_SpringTime = 0f;
			m_SpringColliedTime = 0f;
		}
		else
		{
			owner.SetTrigger("springEnter");
		}
		return true;
	}

	public void MotionEnterSpringBegin()
	{
	}

	public void MotionExitSpringBegin()
	{
	}

	public void MotionEnterSpring()
	{
		SetMovementMode(ACTMovementMode.Spring);
	}

	public void MotionExitSpring()
	{
		if (characterMovement.isOnWalkableGround)
		{
			SetMovementMode(ACTMovementMode.Walking);
		}
		else
		{
			SetMovementMode(ACTMovementMode.Falling);
		}
	}

	private void Spring(Vector3 desiredVelocity)
	{
		_fallingTime += deltaTime;
		float motionFixedDeltaTime = owner.GetCompTime().motionFixedDeltaTime;
		float num = m_SpringDistance.magnitude / config.SpringInitSpeed;
		float time = Mathf.Clamp01(m_SpringTime / num);
		float num2 = config.SpringInitSpeed * config.SpringSpeedCurve.Evaluate(time);
		Vector3 vector = m_SpringDistance.projectedOnPlane(Vector3.forward).normalized * num2;
		rawVelocity = new Vector3(vector.z, vector.y, vector.x + desiredVelocity.z);
		HandleRawVelocity();
		m_SpringTime += motionFixedDeltaTime;
	}

	public void MotionEnterJumpDown()
	{
		if (owner.IsCharacter())
		{
			PauseGroundConstraint();
			characterMovement.IgnoreCollision(characterMovement.groundCollider);
			m_JumpDownCollider = characterMovement.groundCollider;
			m_AllJumpDownColliders.Add(m_JumpDownCollider);
			m_JumpDownTime = 0.1f;
		}
	}

	public void MotionExitJumpDown()
	{
	}

	public void EnterBeCarryed()
	{
		SetMovementMode(ACTMovementMode.BeCarryed);
	}

	public void ExitBeCarryed()
	{
		if (state == ACTMovementMode.BeCarryed || m_HasBeCarryedConstrainInPlane)
		{
			CompTransform? compTransform = owner.GetCompTransform();
			compTransform.carrier = default;
			compTransform.carryCenter = null;
			compTransform.beCarryCenter = null;
			compTransform.carryOffest = Vector3.zero;
			SetMovementMode(ACTMovementMode.Falling);
			characterMovement.constrainToGround = true;
			if (m_HasBeCarryedConstrainInPlane)
			{
				SetConstrainInPlane(m_BeCarryedConstrainInPlane);
				m_HasBeCarryedConstrainInPlane = false;
			}
		}
	}

	private void BeCarryed(Vector3 desiredVelocity)
	{
		_fallingTime += deltaTime;
		CompTransform compTransform = owner.GetCompTransform();
		if (deltaTime > 0f && compTransform.carryCenter != null && compTransform.beCarryCenter != null)
		{
			Vector3 vector = compTransform.carryCenter.position + compTransform.carryOffest;
			Vector3 position = compTransform.beCarryCenter.position;
			Vector3 worldVelocity = (vector - position) / deltaTime;
			rawVelocity = new Vector3(worldVelocity.z, worldVelocity.y, worldVelocity.x);
			PostWorldVelocity(worldVelocity);
		}
		else
		{
			rawVelocity = Vector3.zero;
			PostWorldVelocity(Vector3.zero);
		}
	}

	public void MotionEnterWallClimb()
	{
		bool skipWallSnapOnNextEnter = _skipWallSnapOnNextEnter;
		_skipWallSnapOnNextEnter = false;
		characterMovement.constrainToGround = false;
		characterMovement.isWallClimb = true;
		characterMovement.PauseGroundConstraint();
		if (skipWallSnapOnNextEnter)
		{
			attachedWall = null;
			SetDirImmediately();
		}
		else
		{
			SnapCapsuleToWall(characterMovement.transform.forward);
		}
		SetMovementMode(ACTMovementMode.WallClimbing);
		CompInput? compInput = owner.GetCompInput();
		compInput.onLeftPressed.Add(MovePress);
		compInput.onRightPressed.Add(MovePress);
		compInput.onDownPressed.Add(MovePress);
	}

	private void MovePress(Entity entity, float pressTime)
	{
		if (!(pressTime <= config.LeaveWallPressTime))
		{
			FaceDir faceDir = entity.GetCompTransform().FaceDir;
			CompInput compInput = entity.GetCompInput();
			bool num = ((faceDir == FaceDir.Left && compInput.dirX == EInputDir.Right) || (faceDir == FaceDir.Right && compInput.dirX == EInputDir.Left)) && wallClimbingState == ClimbType.ClimbWall;
			if (compInput.dirY == EInputDir.Down)
			{
				_ = groundDistance < 0.1f;
			}
			else
				_ = 0;
			if (num)
			{
				entity.SetTrigger("NeedLeaveWallClimbByInput");
			}
		}
	}

	public void MotionExitWallClimb()
	{
		characterMovement.isWallClimb = false;
		owner.SetBool("WallClimb", value: false);
		if (characterMovement.isOnWalkableGround)
		{
			SetMovementMode(ACTMovementMode.Walking);
		}
		else
		{
			SetMovementMode(ACTMovementMode.Falling);
		}
		CompInput? compInput = owner.GetCompInput();
		compInput.onLeftPressed.Remove(MovePress);
		compInput.onRightPressed.Remove(MovePress);
		compInput.onDownPressed.Remove(MovePress);
	}

	private void WallClimbing()
	{
		Vector3 vector = ApplyRootMotion(Vector3.zero);
		switch (wallClimbingState)
		{
		case ClimbType.None:
			characterMovement.velocity = vector;
			MotionExitWallClimb();
			break;
		case ClimbType.ClimbWall:
			if (CheckWallFront() && vector.y > 0.1f)
			{
				characterMovement.velocity = Vector3.zero;
			}
			else if (!CheckSide())
			{
				owner.SetTrigger("WallMustLeave");
				owner.SetBool("WallClimb", value: false);
			}
			else
			{
				characterMovement.velocity = vector;
				owner.SetBool("WallClimb", value: true);
				FixedWallOffset(vector);
			}
			break;
		case ClimbType.ClimbDone:
			owner.SetTrigger("WallMustLeave");
			owner.SetBool("WallClimb", value: false);
			break;
		case ClimbType.Jump:
			break;
		}
	}

	public bool UseGlide()
	{
		if (Singleton<SystemUnlockManager>.instance.IsUnlock(103103))
		{
			return !Singleton<ProtagonistManager>.instance.IsProtagonist;
		}
		return false;
	}

	public void MotionEnterGlide()
	{
		SetMovementMode(ACTMovementMode.Falling);
		characterMovement.PauseGroundConstraint();
	}

	public void MotionExitGlide()
	{
		if (characterMovement.isOnWalkableGround)
		{
			SetMovementMode(ACTMovementMode.Walking);
		}
		else
		{
			SetMovementMode(ACTMovementMode.Falling);
		}
	}

	public void EnterUpdraft()
	{
		owner.SetBool("Updraft", value: true);
		if (UseGlide())
		{
			owner.GetCompMotion().JumpInAirCount = 0;
		}
	}

	public bool InUpdraft()
	{
		return owner.GetMotionBool("Updraft");
	}

	public void Updraft(Vector3 dir, float force)
	{
		if (IsUpdrafting())
		{
			if (!_updraftActiveThisStep)
			{
				_updraftAcceleration = Vector3.zero;
			}
			Vector3 vector = dir * force;
			_updraftAcceleration += vector;
			_updraftActiveThisStep = true;
			_updraftExitRequested = false;
			_updraftExitRemain = 0f;
			characterMovement.AddForce(vector, ForceMode.Acceleration);
		}
	}

	public void ExitUpdraft()
	{
		owner.SetBool("Updraft", value: false);
		if (UseGlide())
		{
			owner.GetCompMotion().RecoverMotionCount();
		}
		_updraftExitRequested = true;
	}

	private void ApplyUpdraftExitAcceleration()
	{
		if (_updraftActiveThisStep)
		{
			_updraftActiveThisStep = false;
			_updraftAppliedLastStep = true;
			_updraftExitRequested = false;
			_updraftExitRemain = 0f;
			return;
		}
		if (_updraftExitRequested && _updraftAppliedLastStep)
		{
			_updraftExitRemain = 1f;
		}
		_updraftExitRequested = false;
		_updraftAppliedLastStep = false;
		if (!(_updraftExitRemain <= 0f) && !(_updraftAcceleration.sqrMagnitude <= Mathf.Epsilon))
		{
			MotionState curMotionState = owner.GetCompMotion().curMotionState;
			if (!IsFalling() || isGrounded || (curMotionState != MotionState.Updraft && curMotionState != MotionState.Glide))
			{
				ResetUpdraftExitAcceleration();
				return;
			}
			float num = Mathf.Clamp01(_updraftExitRemain / 1f);
			characterMovement.AddForce(_updraftAcceleration * num, ForceMode.Acceleration);
			_updraftExitRemain -= deltaTime;
		}
	}

	private void ResetUpdraftExitAcceleration()
	{
		_updraftAcceleration = Vector3.zero;
		_updraftActiveThisStep = false;
		_updraftAppliedLastStep = false;
		_updraftExitRequested = false;
		_updraftExitRemain = 0f;
	}

	public bool CanStepUp(ref RaycastHit hitResult)
	{
		if ((bool)hitResult.rigidbody)
		{
			return hitResult.rigidbody.isKinematic;
		}
		return true;
	}

	public bool IsDisabled()
	{
		return state == ACTMovementMode.None;
	}

	public bool IsWalking()
	{
		return state == ACTMovementMode.Walking;
	}

	public bool IsFalling()
	{
		return state == ACTMovementMode.Falling;
	}

	public bool IsUpdrafting()
	{
		if (state == ACTMovementMode.Falling && owner.GetCompMotion().curMotionState == MotionState.Updraft)
		{
			return !owner.InTag(MotionTag_backUp.ForbidUpdraft);
		}
		return false;
	}

	public bool IsFlying()
	{
		return state == ACTMovementMode.Flying;
	}

	public bool IsSwimming()
	{
		return state == ACTMovementMode.Swimming;
	}

	public bool IsClimbCompensate()
	{
		return state == ACTMovementMode.ClimbCompensate;
	}

	public bool IsGrabHooking()
	{
		return state == ACTMovementMode.GrabHook;
	}

	public Vector3 GetUpVector()
	{
		return Vector3.up;
	}

	public void BindInterface()
	{
		this.characterMovement.colliderFilterCallback = ColliderFilterCallback;
		this.characterMovement.collisionBehaviorCallback = CollisionBehaviorCallback;
		CharacterMovement characterMovement = this.characterMovement;
		characterMovement.climbUpCallBack = (UnityAction<Collider>)Delegate.Combine(characterMovement.climbUpCallBack, new UnityAction<Collider>(ClimbUpCallBack));
		this.characterMovement.collisionOverlapCallback = CollisionOverlapCallback;
		this.characterMovement.computeSliderVectorCallBack = ComputeSliderVectorCallBack;
		this.characterMovement.FoundGround += OnFoundGround;
		this.characterMovement.Collided += ComputeHitOnWall;
		this.characterMovement.Collided += OnHitWallCallBack;
		this.characterMovement.Collided += ComputeCollideEffect;
		this.characterMovement.Collided += Collided;
		if (owner.IsCharacter())
		{
			this.characterMovement.Collided += ColliedBattleGate;
		}
		if (owner.IsCharacter())
		{
			CharacterMovement characterMovement2 = this.characterMovement;
			characterMovement2.sweepColliderCallback = (CharacterMovement.SweepColliderCallBack)Delegate.Combine(characterMovement2.sweepColliderCallback, new CharacterMovement.SweepColliderCallBack(SweepColliderCallback));
			CharacterMovement characterMovement3 = this.characterMovement;
			characterMovement3.collisionOverlapBeforeShouldFilterCallback = (CharacterMovement.CollisionOverlapCallback)Delegate.Combine(characterMovement3.collisionOverlapBeforeShouldFilterCallback, new CharacterMovement.CollisionOverlapCallback(JumpDownCollisionOverlapCallback));
		}
		CharacterMovement characterMovement4 = this.characterMovement;
		characterMovement4.groundColliderChange = (CharacterMovement.GroundColliderChange)Delegate.Combine(characterMovement4.groundColliderChange, new CharacterMovement.GroundColliderChange(HitSpringCallBack));
		CharacterMovement characterMovement5 = this.characterMovement;
		characterMovement5.groundColliderChange = (CharacterMovement.GroundColliderChange)Delegate.Combine(characterMovement5.groundColliderChange, new CharacterMovement.GroundColliderChange(HitConveyorBeltCallBack));
		CharacterMovement characterMovement6 = this.characterMovement;
		characterMovement6.groundColliderChange = (CharacterMovement.GroundColliderChange)Delegate.Combine(characterMovement6.groundColliderChange, new CharacterMovement.GroundColliderChange(HitSubmergePlatformCallBack));
	}

	private void ColliedBattleGate(ref CollisionResult collisionResult)
	{
		BattleGateEffect component = collisionResult.collider.GetComponent<BattleGateEffect>();
		if (component != null)
		{
			component.FireEffect(collisionResult.point);
		}
	}

	private void JumpDownCollisionOverlapCallback(Collider[] overlaps, int overlapCount, int depenetrationIterations)
	{
		for (int i = 0; i < overlapCount; i++)
		{
			Collider collider = overlaps[i];
			if (!JumpDownLayer.Contains(collider))
			{
				continue;
			}
			if (!m_AllJumpDownColliders.Contains(collider))
			{
				m_AllJumpDownColliders.Add(collider);
			}
			if (owner.InTag(MotionTag_backUp.JumpAssist))
			{
				Bounds bounds = collider.bounds;
				float y = bounds.center.y;
				if (Mathf.Abs(characterMovement.position.y - y) < characterMovement.jumpAssistOffset)
				{
					Vector3 position = characterMovement.position;
					position.y = bounds.max.y + characterMovement.radius;
					characterMovement.position = position;
				}
			}
			if (!(m_JumpDownCollider == null) && m_JumpDownCollider == collider)
			{
				characterMovement.IgnoreCollision(collider);
			}
		}
	}

	private bool SweepColliderCallback(Collider otherCollider)
	{
		if (JumpDownLayer.Contains(otherCollider))
		{
			if (!m_AllJumpDownColliders.Contains(otherCollider))
			{
				m_AllJumpDownColliders.Add(otherCollider);
			}
			if (m_JumpDownCollider == null)
			{
				CompMotion compMotion = owner.GetCompMotion();
				if ((!m_IsWallClimbCompensation || state != ACTMovementMode.ClimbCompensate) && (!(velocity.y > 0f) || compMotion.curMotionState == MotionState.ClimbCompensate || compMotion.curMotionState == MotionState.Glide))
				{
					characterMovement.IgnoreCollision(otherCollider, ignore: false);
					return false;
				}
				m_JumpDownCollider = otherCollider;
				characterMovement.IgnoreCollision(otherCollider);
				return true;
			}
			if (m_JumpDownCollider == otherCollider)
			{
				characterMovement.IgnoreCollision(otherCollider);
			}
			return m_JumpDownCollider == otherCollider;
		}
		return false;
	}

	private void HitSpringCallBack(FindGroundResult result)
	{
		if (result.collider == null || (m_SpringGroundCollider != null && m_SpringGroundCollider != result.collider))
		{
			m_SpringGroundCollider = null;
			return;
		}
		InteractSpring componentInParent = result.collider.GetComponentInParent<InteractSpring>();
		if ((bool)componentInParent)
		{
			m_SpringGroundCollider = result.collider;
			componentInParent.OnSpringInteract(owner);
		}
	}

	private void HitConveyorBeltCallBack(FindGroundResult result)
	{
		ConveyorBeltBehaveEvent component;
		if (result.collider == null || (m_ConveyorBeltCollider != null && m_ConveyorBeltCollider != result.collider))
		{
			m_ConveyorBeltCollider = null;
		}
		else if (result.collider.TryGetComponent<ConveyorBeltBehaveEvent>(out component))
		{
			m_ConveyorBeltCollider = result.collider;
			component.interactConveyorBelt.PhysicsInteract(owner);
		}
	}

	private void HitSubmergePlatformCallBack(FindGroundResult result)
	{
		if (_submergePlatformCollider != null && _submergePlatformCollider != result.collider)
		{
			InteractSubmergePlatform componentInParent = _submergePlatformCollider.GetComponentInParent<InteractSubmergePlatform>();
			if ((bool)componentInParent)
			{
				componentInParent.PhysicsInteractSubmergePlatform(owner, enter: false);
			}
			_submergePlatformCollider = null;
		}
		else if (result.collider != null && _submergePlatformCollider == null)
		{
			InteractSubmergePlatform componentInParent2 = result.collider.GetComponentInParent<InteractSubmergePlatform>();
			if ((bool)componentInParent2)
			{
				_submergePlatformCollider = result.collider;
				componentInParent2.PhysicsInteractSubmergePlatform(owner, enter: true);
			}
		}
	}

	public CmdHit HitOnWallParameterCalc(int tempValue, bool horizontal)
	{
		ConfigHitParameter configHitParameter = GameLoader.meta.hitOnWallParameter.hitParameters[tempValue];
		CmdHit result = new CmdHit
		{
			hitLevel = 4,
			attackeeAtLeft = owner.IsFaceLeft(),
			attackerInAir = !owner.GetCompPhysics().isGrounded,
			caster = MPPlayer.local.battleEntity,
			angle = configHitParameter.angle,
			expressiveAngle = 0,
			length = configHitParameter.length,
			overrideSpeed = configHitParameter.overrideSpeed,
			hitBrakingDeceleration = configHitParameter.hitBrakingDeceleration,
			hitEndureLevel = 0,
			bodyIndex = 1,
			upwardGravity = configHitParameter.upwardGravity,
			upwardFriction = configHitParameter.upwardFriction,
			downwardGravity = configHitParameter.downwardGravity,
			downwardMaxSpeed = configHitParameter.downwardMaxSpeed,
			downwardFriction = configHitParameter.downwardFriction
		};
		if (horizontal)
		{
			result.horizontalHitWallNum = 0;
		}
		else
		{
			result.dontChangeDir = true;
			result.verticalHitWallNum = 0;
		}
		return result;
	}

	private void OnHitWallCallBack(ref CollisionResult collisionResult)
	{
		IHitWallCallBack componentInChildren = collisionResult.transform.GetComponentInChildren<IHitWallCallBack>();
		if (componentInChildren != null)
		{
			hitCallBacks.Add(componentInChildren);
		}
	}

	private void ComputeHitOnWall(ref CollisionResult collisionResult)
	{
		if ((horizontalHitWallNum == 0 && verticalHitWallNum == 0) || collisionResult.hitLocation == HitLocation.Above || collisionResult.collider.gameObject.layer == 6)
		{
			return;
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		if (!owner.IsBattleBehaveNotCharacter())
		{
			return;
		}
		MonsterWeigtType monsterWeigtType = owner.GetConfig().monsterWeigtType;
		if ((monsterWeigtType != MonsterWeigtType.Small && monsterWeigtType != MonsterWeigtType.Normal) || owner.GetCompMotion().curMotionState != MotionState.Hit)
		{
			return;
		}
		EvtHitWall evt = abilitySystem.GetEvt<EvtHitWall>(owner, null);
		evt.mainEntity = owner;
		evt.result = collisionResult;
		HitLocationPoint = collisionResult.point;
		if (horizontalHitWallNum != 0 && collisionResult.hitLocation == HitLocation.Sides)
		{
			evt.hitWallNum = horizontalHitWallNum;
			evt.changeDir = true;
			Vector3 point = collisionResult.point;
			Transform attachPoint = owner.GetMono().GetAttachPoint(BattleConsts.AIM_ATTACH_POINT);
			if (attachPoint != null)
			{
				if (Mathf.Abs(point.y - attachPoint.position.y) > owner.GetCompPhysics().characterMovement.height / 4f)
				{
					return;
				}
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
		}
		else
		{
			if (verticalHitWallNum == 0 || collisionResult.hitLocation != HitLocation.Below)
			{
				return;
			}
			evt.hitWallNum = verticalHitWallNum;
			evt.changeDir = false;
		}
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		if (collisionResult.hitLocation == HitLocation.Sides)
		{
			horizontalHitWallNum = 0;
		}
		else
		{
			verticalHitWallNum = 0;
		}
	}

	private void ComputeCollideEffect(ref CollisionResult collisionResult)
	{
		if (!owner.InTag(MotionTag_backUp.IgnoreEffectCollision))
		{
			return;
		}
		Collider collider = collisionResult.collider;
		IColliderEntityRef entityRef = PhysicsUtility.GetEntityRef(collider);
		if (entityRef == null)
		{
			return;
		}
		MonoEntity monoEntity = entityRef?.GetMonoEntity();
		if (monoEntity != null)
		{
			Entity entity = monoEntity.entity;
			if (entity.IsBehaveEntity() && entity.IsLogicAvailable() && (entity.InTag(MotionTag_backUp.Uncrossable) || entity.GetCompPhysics().overlapEntityMode == OverlapEntityMode.Uncrossable))
			{
				float magnitude = new Vector3(rawVelocity.x, 0f, rawVelocity.z).magnitude;
				if (lastHoriSpeed < 0.001f && magnitude > 0.2f)
				{
					CmdCollisionHit hit = new CmdCollisionHit
					{
						bodyIndex = 1,
						touchPos = collisionResult.point,
						attackerFaceLeft = entity.IsFaceLeft()
					};
					entity.GetCollisionHit(hit);
				}
				lastHoriSpeed = magnitude;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("场景中存在错误MonoEntity！" + collider.gameObject.name);
		}
	}

	private void Collided(ref CollisionResult collisionResult)
	{
		FrameCollided = true;
		if (collisionResult.hitLocation == HitLocation.Sides)
		{
			SidesFrameCollided = true;
		}
		if (collisionResult.hitLocation == HitLocation.Above)
		{
			AboveFrameCollided = true;
		}
	}

	private bool ComputeSliderVectorCallBack(CollisionResult collisionResult)
	{
		return collisionResult.collider.gameObject.layer == 6;
	}

	private void ClimbUpCallBack(Collider collider)
	{
		m_IsWallClimbCompensation = characterMovement.isWallClimb;
		owner.ClimbCompensate();
		characterMovement.constrainToGround = true;
		characterMovement.SetPlatform(collider.attachedRigidbody);
	}

	private CollisionBehavior CollisionBehaviorCallback(Collider collider)
	{
		CollisionBehavior collisionBehavior = CollisionBehavior.Default;
		if (collider.TryGetComponent<CharacterMovement>(out var _))
		{
			collisionBehavior |= CollisionBehavior.NotWalkable | CollisionBehavior.IncreaseSlopeSlide;
		}
		CompMotion compMotion = owner.GetCompMotion();
		if (collider.CompareTag(BattleConsts.CANTCLIMB))
		{
			collisionBehavior |= CollisionBehavior.CanNotClimb;
		}
		else
		{
			if (state == ACTMovementMode.Falling && compMotion.curMotionState != MotionState.ClimbCompensate && owner.InTag(MotionTag_backUp.CanDoClimbCompensation))
			{
				bool flag = rawVelocity.z > 0f;
				bool flag2 = owner.IsFaceRight();
				if (flag == flag2)
				{
					collisionBehavior |= CollisionBehavior.CanClimb;
				}
			}
			if (state == ACTMovementMode.Adsorbing && compMotion.curMotionState != MotionState.ClimbCompensate)
			{
				collisionBehavior |= CollisionBehavior.CanClimb;
			}
			if (state == ACTMovementMode.WallClimbing && compMotion.curMotionState != MotionState.ClimbCompensate)
			{
				collisionBehavior |= CollisionBehavior.CanClimb;
			}
			if (state == ACTMovementMode.Glide && compMotion.curMotionState != MotionState.ClimbCompensate)
			{
				collisionBehavior |= CollisionBehavior.CanClimb;
			}
		}
		collisionBehavior = ((!compMotion.InTag(MotionTag_backUp.DodgeAssist)) ? (collisionBehavior | CollisionBehavior.CanNotDodgeAssist) : (collisionBehavior | CollisionBehavior.CanDodgeAssist));
		if (collider.TryGetComponent<MultiTagCollider>(out var component2) && component2.HasTag(CustomTag.CanOffCliff))
		{
			collisionBehavior |= CollisionBehavior.CanOffCliff;
		}
		return collisionBehavior;
	}

	public void AddOverlap((PushImpetusData, Collider) v)
	{
		overlaped.Add(v);
		characterMovement.IgnoreCollision(v.Item2);
	}

	public void RemoveOverlap((PushImpetusData, Collider) v)
	{
		overlaped.Remove(v);
		characterMovement.IgnoreCollision(v.Item2, ignore: false);
	}

	private void CollisionOverlapCallback(Collider[] overlaps, int overlapCount, int depenetrationIterations)
	{
		if (depenetrationIterations == 0)
		{
			overlapEnviroment = false;
			isPushOverlapEnvironment = false;
		}
		for (int i = 0; i < overlapCount; i++)
		{
			if (characterMovement.ShouldFilter(overlaps[i]))
			{
				continue;
			}
			IColliderEntityRef entityRef = PhysicsUtility.GetEntityRef(overlaps[i]);
			if (entityRef != null)
			{
				MonoEntity monoEntity = entityRef.GetMonoEntity();
				if (monoEntity != null)
				{
					if (monoEntity.entity.IsBehaveEntity() && monoEntity.entity.IsLogicAvailable() && !(overlaps[i].GetComponentInChildren<PushImpetusGameObject>() != null))
					{
						ConfigCharacter configCharacter = monoEntity.entity.GetConfig();
						PushImpetusData item = new PushImpetusData
						{
							customDirection = false,
							pushImpetusBase = configCharacter.pushImpetusBase,
							pushImpetusCurve = configCharacter.pushImpetusCurve,
							otherEntity = monoEntity.entity,
							isGameObject = false
						};
						SonCollider componentInChildren = overlaps[i].GetComponentInChildren<SonCollider>();
						if (componentInChildren != null)
						{
							item = componentInChildren.pushImpetusConfig;
							item.otherEntity = monoEntity.entity;
						}
						AddOverlap((item, overlaps[i]));
					}
				}
				else if (!(entityRef is TrajectoryCollider) && LuminApplication.LogEnabled)
				{
					Debug.LogError("场景中存在错误MonoEntity！" + overlaps[i].gameObject.name);
				}
			}
			PushImpetusGameObject componentInChildren2 = overlaps[i].GetComponentInChildren<PushImpetusGameObject>();
			IPushCallBack componentInChildren3 = overlaps[i].GetComponentInChildren<IPushCallBack>();
			if ((bool)componentInChildren2)
			{
				componentInChildren2.pushImpetusConfig.isGameObject = true;
				pushGameObjects.Add((componentInChildren2.pushImpetusConfig, overlaps[i]));
			}
			else
			{
				overlapEnviroment = true;
			}
			if (componentInChildren3 != null)
			{
				pushCallBacksCache.Add(componentInChildren3);
			}
			else
			{
				isPushOverlapEnvironment = true;
			}
		}
		if (overlapEnviroment)
		{
			for (int j = 0; j < pushGameObjects.Count; j++)
			{
				AddOverlap(pushGameObjects[j]);
			}
			pushGameObjects.Clear();
		}
		if (!isPushOverlapEnvironment)
		{
			return;
		}
		foreach (IPushCallBack item2 in pushCallBacksCache)
		{
			pushCallBacks.Add(item2);
		}
		pushCallBacksCache.Clear();
	}

	internal void AddIgnoreEnvironmentCollisionTag(string tag)
	{
		if (!string.IsNullOrEmpty(tag))
		{
			if (m_IgnoreEnvironmentCollisionTagRefCounts == null)
			{
				m_IgnoreEnvironmentCollisionTagRefCounts = new Dictionary<string, int>();
			}
			if (m_IgnoreEnvironmentCollisionTagRefCounts.TryGetValue(tag, out var value))
			{
				m_IgnoreEnvironmentCollisionTagRefCounts[tag] = value + 1;
			}
			else
			{
				m_IgnoreEnvironmentCollisionTagRefCounts.Add(tag, 1);
			}
		}
	}

	internal void RemoveIgnoreEnvironmentCollisionTag(string tag)
	{
		if (!string.IsNullOrEmpty(tag) && m_IgnoreEnvironmentCollisionTagRefCounts != null && m_IgnoreEnvironmentCollisionTagRefCounts.TryGetValue(tag, out var value))
		{
			if (value > 1)
			{
				m_IgnoreEnvironmentCollisionTagRefCounts[tag] = value - 1;
			}
			else
			{
				m_IgnoreEnvironmentCollisionTagRefCounts.Remove(tag);
			}
		}
	}

	private bool ShouldIgnoreEnvironmentCollisionByAbility(Collider collider)
	{
		if (collider == null || m_IgnoreEnvironmentCollisionTagRefCounts == null || m_IgnoreEnvironmentCollisionTagRefCounts.Count == 0)
		{
			return false;
		}
		int num = 1 << collider.gameObject.layer;
		if ((BattleConsts.enviromentMask & num) == 0)
		{
			return false;
		}
		foreach (KeyValuePair<string, int> ignoreEnvironmentCollisionTagRefCount in m_IgnoreEnvironmentCollisionTagRefCounts)
		{
			if (collider.CompareTag(ignoreEnvironmentCollisionTagRefCount.Key))
			{
				return true;
			}
		}
		return false;
	}

	private bool ColliderFilterCallback(Collider otherCollider)
	{
		if (state == ACTMovementMode.WallClimbing && wallClimbingState == ClimbType.ClimbWall && velocity.y > 0f && JumpDownLayer.Contains(otherCollider))
		{
			SweepColliderCallback(otherCollider);
			return true;
		}
		if (ShouldIgnoreEnvironmentCollisionByAbility(otherCollider))
		{
			return true;
		}
		if (otherCollider.gameObject.layer == 6)
		{
			IColliderEntityRef entityRef = PhysicsUtility.GetEntityRef(otherCollider);
			if (entityRef != null)
			{
				MonoEntity monoEntity = entityRef?.GetMonoEntity();
				if (monoEntity != null)
				{
					if (monoEntity.entity.IsBehaveEntity() || monoEntity.entity.IsRobot())
					{
						if (entityRef is SonCollider { uncrossableByMotionTag: not false } && monoEntity.entity.InTag(MotionTag_backUp.Uncrossable) && !STUCKING)
						{
							return false;
						}
						return EffectCollisionFilter(monoEntity.entity);
					}
				}
				else
				{
					if (entityRef is TrajectoryCollider)
					{
						TrajectoryCollider trajectoryCollider = (TrajectoryCollider)entityRef;
						return EffectCollisionFilter(trajectoryCollider.entity);
					}
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("打到了Entity层的Collider上 但是没有MonoEntity", otherCollider.gameObject);
					}
				}
			}
		}
		if (!owner.InTag(MotionTag_backUp.IgnoreSceneCollision))
		{
			return otherCollider.CompareTag("IgnoreCollision");
		}
		return true;
	}

	private bool EffectCollisionFilter(Entity otherEntity)
	{
		CompPhysics compPhysics = otherEntity.GetCompPhysics();
		Alliance alliance = owner.GetAlliance();
		Alliance alliance2 = otherEntity.GetAlliance();
		if (compPhysics != null && compPhysics.overlapEntityMode == OverlapEntityMode.DashCrossable && alliance2 != alliance)
		{
			if (owner.InTag(MotionTag_backUp.IgnoreEffectCollision) || otherEntity.InTag(MotionTag_backUp.IgnoreEffectCollision) || state == ACTMovementMode.BeCarryed || compPhysics.state == ACTMovementMode.BeCarryed)
			{
				return true;
			}
			if (STUCKING)
			{
				return true;
			}
		}
		if (otherEntity.IsValid && owner.IsValid)
		{
			return alliance2 == alliance;
		}
		return false;
	}

	private void OnAudioInstanceSetup(IAudioInstance instance)
	{
		instance.SetParameter("Ground_Material", (int)Singleton<RoadMaterialManager>.instance.GetRoadMaterial(owner));
	}

	protected void Move()
	{
		ApplyRecoverPushImpetus();
		ApplyPushCallBack();
		ApplyHitWallCallBack();
		CalcRootMotion();
		RestoreGroundConstraintBeforeRootMotionLanding();
		Rotate();
		CompMotion compMotion = owner.GetCompMotion();
		if (IsWalking() || IsFlying())
		{
			if (isGrounded && motion == MotionType.Air)
			{
				SetMovementMode(ACTMovementMode.Falling);
			}
			if (!isGrounded)
			{
				if (motion == MotionType.Air)
				{
					if (compMotion != null && compMotion.curMotionState == MotionState.Hit)
					{
						SetMovementMode(ACTMovementMode.Falling);
					}
					else
					{
						SetMovementMode(ACTMovementMode.Flying);
					}
				}
				else
				{
					SetMovementMode(ACTMovementMode.Falling);
				}
			}
			else if ((rootUp > 0f || _jumpPress) && IsGroundLikeMotion())
			{
				SetMovementMode(ACTMovementMode.Falling);
				PauseGroundConstraint();
			}
			if (isGrounded && owner.GetEntityType() == EntityType.Character)
			{
				lastGroundPoint = characterMovement.position;
				if (Path == null)
				{
					lastGroundPoint.z = m_ConstZ;
				}
			}
		}
		if (IsFalling())
		{
			if (isGrounded)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/Common/Character/Character_Land", new AudioPlayOptions
				{
					attachTarget = owner.GetRootTransform(),
					onParametersSetup = OnAudioInstanceSetup
				});
				if (motion == MotionType.Air)
				{
					SetMovementMode(ACTMovementMode.Flying);
				}
				else
				{
					SetMovementMode(ACTMovementMode.Walking);
				}
			}
			if (motion == MotionType.Air && compMotion != null && compMotion.curMotionState != MotionState.Hit)
			{
				SetMovementMode(ACTMovementMode.Flying);
			}
		}
		characterMovement.tryDownMove = compMotion.InTag(MotionTag_backUp.TryDownMove);
		characterMovement.tryDownMoveClimb = IsClimbCompensate() && characterMovement.tryDownMove;
		if (IsClimbCompensate() && !characterMovement.tryDownMove)
		{
			PauseGroundConstraint();
		}
		Vector3 desiredVelocity = CalcDesiredVelocity();
		switch (state)
		{
		case ACTMovementMode.Walking:
			Walking(desiredVelocity);
			break;
		case ACTMovementMode.Falling:
		case ACTMovementMode.ClimbCompensate:
			Falling(desiredVelocity);
			break;
		case ACTMovementMode.Flying:
			Flying(desiredVelocity);
			break;
		case ACTMovementMode.Climbing:
			Climbing();
			break;
		case ACTMovementMode.Adsorbing:
			Adsorbing();
			break;
		case ACTMovementMode.Recalling:
			Recalling();
			break;
		case ACTMovementMode.GrabHook:
			GrabHooking();
			break;
		case ACTMovementMode.Spring:
			Spring(desiredVelocity);
			break;
		case ACTMovementMode.BeCarryed:
			BeCarryed(desiredVelocity);
			break;
		case ACTMovementMode.WallClimbing:
			WallClimbing();
			break;
		case ACTMovementMode.TeleportMove:
			TeleportMoving();
			break;
		case ACTMovementMode.PathSwitchRootMotion:
			PathSwitchRootMotionMoving();
			break;
		case ACTMovementMode.Orbital360:
			Orbital360Move();
			break;
		}
		Vector3 vector = (compMotion.InTag(MotionTag_backUp.IgnoreBlackViscous) ? characterMovement.velocity : ApplyModifyVelocity(characterMovement.velocity));
		Vector3 vector2 = (characterMovement.velocity = vector);
		velocity = vector2;
		Vector3 dir;
		if ((state != ACTMovementMode.Adsorbing || adsorbingState != AdsorbingState.OnWall) && (state != ACTMovementMode.WallClimbing || wallClimbingState == ClimbType.None))
		{
			dir = Vector3.zero;
		}
		else
		{
			dir = (owner.IsFaceLeft() ? Vector3.left : Vector3.right);
		}
		ApplyUpdraftExitAcceleration();
		characterMovement.Move(deltaTime, dir);
		FrameCliffBlocked = characterMovement.frameCliffBlocked;
		UpdatePathPosAndRotation();
	}

	protected void AfterMove()
	{
		CompTransform compTransform = owner.GetCompTransform();
		switch (state)
		{
		case ACTMovementMode.GrabHook:
			if (FrameCollided)
			{
				hookBlockTime += deltaTime;
			}
			else
			{
				hookBlockTime = 0f;
			}
			if (Vector3.Dot(hookDistance, HookPoint - compTransform.colliderPosition) < 0f)
			{
				throughHookPoint = true;
			}
			if (hookBlockTime > config.HookBlockThresholds)
			{
				rawVelocity = Vector3.zero;
				ExitGrabHook();
			}
			if (Vector3.Dot(hookDistance, hookEndPoint - compTransform.colliderPosition) < 0f)
			{
				float num3 = (Mathf.Approximately(rawVelocity.y, 0f) ? 0f : (Mathf.Clamp(rawVelocity.y, float.MinValue, config.GrabMaxVSpeedY) / rawVelocity.y));
				float num4 = (Mathf.Approximately(rawVelocity.z, 0f) ? 0f : (Mathf.Clamp(rawVelocity.z, float.MinValue, config.GrabMaxVSpeedZ) / rawVelocity.z));
				rawVelocity.y *= num3;
				rawVelocity.z *= num4;
				ExitGrabHook();
			}
			break;
		case ACTMovementMode.Spring:
			if (AboveFrameCollided)
			{
				m_SpringColliedTime += deltaTime;
			}
			else
			{
				m_SpringColliedTime = 0f;
			}
			if (m_SpringColliedTime > config.SpringBlockThresholds)
			{
				rawVelocity = Vector3.zero;
				MotionExitSpring();
			}
			if (compTransform.colliderPosition.y >= m_EndPoint.y)
			{
				float num = (Mathf.Approximately(rawVelocity.y, 0f) ? 0f : (Mathf.Clamp(rawVelocity.y, float.MinValue, config.SpringMaxVSpeedY) / rawVelocity.y));
				float num2 = (Mathf.Approximately(rawVelocity.z, 0f) ? 0f : (Mathf.Clamp(rawVelocity.z, float.MinValue, config.SpringMaxVSpeedZ) / rawVelocity.z));
				rawVelocity.y *= num;
				rawVelocity.z *= num2;
				MotionExitSpring();
			}
			break;
		}
		OverLapToJumpDownCollider();
		EnforceOrbital360LockedZ();
		SetEntityValue();
	}

	private Vector2 GetMovementDirection()
	{
		if (ForbidDir)
		{
			return Vector2.zero;
		}
		CompInput compInput = owner.GetCompInput();
		if (IsWalking() || IsFalling())
		{
			CompMotion compMotion = owner.GetCompMotion();
			if (compMotion != null && compMotion.curMotionState == MotionState.Hit)
			{
				return Vector2.zero;
			}
			return compInput.dirX switch
			{
				EInputDir.Left => Vector2.left, 
				EInputDir.None => Vector2.zero, 
				EInputDir.Right => Vector2.right, 
				_ => Vector2.zero, 
			};
		}
		return compInput.dir;
	}

	protected Vector3 CalcDesiredVelocity()
	{
		Vector2 movementDirection = GetMovementDirection();
		return new Vector3(0f, movementDirection.y, movementDirection.x) * MaxSpeed;
	}

	private float EvaluateCurveDiff(AnimationCurve curve, float length, float fromTime, float toTime, bool loop)
	{
		if (curve == null)
		{
			return 0f;
		}
		if (loop)
		{
			int num = Mathf.FloorToInt(fromTime / length);
			int num2 = Mathf.FloorToInt(toTime / length);
			float time = fromTime - (float)num * length;
			float time2 = toTime - (float)num2 * length;
			return curve.Evaluate(time2) - curve.Evaluate(time) + (float)(num2 - num) * (curve[curve.length - 1].value - curve[0].value);
		}
		return curve.Evaluate(toTime) - curve.Evaluate(fromTime);
	}

	private float EvaluateCurve(AnimationCurve curve, float length, float time, bool loop)
	{
		if (curve == null)
		{
			return 0f;
		}
		if (loop)
		{
			float time2 = time % length;
			return curve.Evaluate(time2);
		}
		return curve.Evaluate(time);
	}

	private void CalcRootMotion()
	{
		CompMotion? compMotion = owner.GetCompMotion();
		float b = QuaternionUtility.FaceLocalYAngle(owner.GetFaceDir());
		float num = 1f;
		rootForward = (rootRight = (rootUp = (rootEulerY = 0f)));
		bool flag = false;
		List<FSMRuntimeState> list = compMotion.layerMotionQueue[0];
		for (int i = 0; i < list.Count; i++)
		{
			FSMRuntimeState fSMRuntimeState = list[i];
			ConfigMotion actualMotion = fSMRuntimeState.actualMotion;
			float curveRate = fSMRuntimeState.compensationForwardCurveRate;
			if (actualMotion._useEnvCompensation)
			{
				FixCurveXRateByEnv(ref curveRate, fSMRuntimeState);
			}
			float compensationRightCurveRate = fSMRuntimeState.compensationRightCurveRate;
			float compensationUpCurveRate = fSMRuntimeState.compensationUpCurveRate;
			float num2 = (fSMRuntimeState.fromLogicWeight + fSMRuntimeState.toLogicWeight) / 2f;
			if (actualMotion.RootMotionXZ)
			{
				float num3 = EvaluateCurveDiff(actualMotion.forwardCurve, fSMRuntimeState.length, fSMRuntimeState.fromLogicTime, fSMRuntimeState.toLogicTime, fSMRuntimeState.loop) * num2 * curveRate * CalcInputMotionScale(actualMotion, fSMRuntimeState.startFaceDir) * fSMRuntimeState.frameCompensationRate;
				float num4 = (ConstrainInPlaneZ ? EvaluateCurve(actualMotion.rightCurve, fSMRuntimeState.length, fSMRuntimeState.toLogicTime, fSMRuntimeState.loop) : EvaluateCurveDiff(actualMotion.rightCurve, fSMRuntimeState.length, fSMRuntimeState.fromLogicTime, fSMRuntimeState.toLogicTime, fSMRuntimeState.loop)) * num2 * compensationRightCurveRate * CalcInputMotionScale(actualMotion, fSMRuntimeState.startFaceDir);
				if (state == ACTMovementMode.PathSwitchRootMotion || state == ACTMovementMode.Orbital360)
				{
					rootForward += num3;
					rootRight += num4;
				}
				else
				{
					switch (fSMRuntimeState.startFaceDir)
					{
					case FaceDir.Right:
						rootForward += num3;
						rootRight += num4;
						break;
					case FaceDir.Left:
						rootForward -= num3;
						rootRight -= num4;
						break;
					}
				}
			}
			if (actualMotion.RootMotionY)
			{
				float num5 = EvaluateCurveDiff(actualMotion.upCurve, fSMRuntimeState.length, fSMRuntimeState.fromLogicTime, fSMRuntimeState.toLogicTime, fSMRuntimeState.loop) * fSMRuntimeState.frameCompensationRateY * compensationUpCurveRate;
				if (i < list.Count - 1)
				{
					num5 *= fSMRuntimeState.toLogicWeight;
				}
				rootUp += num5;
			}
			if (actualMotion.RootRotation)
			{
				float num6 = EvaluateCurve(actualMotion.yEulerCurve, fSMRuntimeState.length, fSMRuntimeState.toLogicTime, fSMRuntimeState.loop);
				if (fSMRuntimeState.startFaceDir == FaceDir.Left)
				{
					num6 += 180f;
				}
				if (!flag)
				{
					flag = true;
					rootEulerY = num6;
				}
				else
				{
					rootEulerY = Mathf.LerpAngle(rootEulerY, num6, num2);
				}
				num -= num2;
			}
		}
		rootEulerY = Mathf.LerpAngle(rootEulerY, b, num);
	}

	private void RestoreGroundConstraintBeforeRootMotionLanding()
	{
		if (IsGroundLikeMotion() && _useRootMotionY && !(rootUp >= 0f) && IsFalling() && groundDistance <= 0f - rootUp + 0.05f)
		{
			characterMovement.PauseGroundConstraint(0f);
		}
	}

	private void FixCurveXRateByEnv(ref float curveRate, FSMRuntimeState state)
	{
		bool flag = false;
		float time = 0f;
		List<ConfigMotion.CurveTimeRange> upRanges = state.actualMotion.upRanges;
		_ = upRanges?.Count;
		if (upRanges.Count > 0)
		{
			foreach (ConfigMotion.CurveTimeRange item in upRanges)
			{
				if (state.length * state.toLogicPercent >= item.startTime && state.length * state.toLogicPercent <= item.endTime)
				{
					flag = true;
					time = item.endTime;
				}
			}
		}
		if (!flag)
		{
			return;
		}
		CompTransform compTransform = owner.GetCompTransform();
		Vector3 vector = Vector3.zero;
		Vector3 direction = Vector3.right * (owner.IsFaceRight() ? 1 : (-1));
		if (Physics.Raycast(compTransform.physicsPosition, direction, out var hitInfo, 20f, BattleConsts.enviromentMask))
		{
			MonoEntity mono = owner.GetMono();
			Vector3 sonCollidersCenterOffset = mono.SonCollidersCenterOffset;
			float x = mono.SonColliderBounds.size.x;
			Vector3 vector2 = new Vector3(hitInfo.point.x + ((compTransform.FaceDir == FaceDir.Left) ? (x / 2f + sonCollidersCenterOffset.x) : ((0f - x) / 2f - sonCollidersCenterOffset.x)), hitInfo.point.y, hitInfo.point.z);
			float num = float.MaxValue;
			if (Vector2.Distance(compTransform.physicsPosition, vector2) < num)
			{
				vector = vector2;
			}
		}
		if (vector != Vector3.zero)
		{
			float num2 = 0f;
			num2 = Vector3.Project(vector - compTransform.physicsPosition, Vector3.right).magnitude * (float)((compTransform.physicsPosition.x < vector.x) ? 1 : (-1));
			float num3 = state.actualMotion.forwardCurve.Evaluate(time) - state.actualMotion.forwardCurve.Evaluate(state.length * state.toLogicPercent);
			num3 *= (float)(owner.IsFaceRight() ? 1 : (-1));
			float num4 = 0f;
			num4 = ((!Mathf.Approximately(0f, num3)) ? (num2 / num3) : 1f);
			num4 = Mathf.Clamp(num4, 0f, 1f);
			curveRate = num4;
		}
	}

	private float CalcInputMotionScale(ConfigMotion config, FaceDir startFaceDir)
	{
		float num = 1f;
		switch (startFaceDir)
		{
		case FaceDir.Right:
			num = 1f;
			break;
		case FaceDir.Left:
			num = -1f;
			break;
		}
		if (!config.enableInputMotion)
		{
			return 1f;
		}
		return config.inputMotionScale.Evaluate(owner.GetCompInput().dir.x * num);
	}

	private Vector3 ApplyRootMotion(Vector3 desired)
	{
		_ = owner.GetCompMotion().layer0PeakConfig;
		if (_useRootMotionXZ)
		{
			desired.z = ((deltaTime == 0f) ? 0f : (rootForward / deltaTime));
		}
		if (_useRootMotionY)
		{
			desired.y = ((deltaTime == 0f) ? 0f : (rootUp / deltaTime));
		}
		return desired;
	}

	private Vector3 ApplyJumpSpeed(Vector3 desired)
	{
		if (!_useRootMotionY)
		{
			desired.y += _frameJumpSpeed;
		}
		_frameJumpSpeed = 0f;
		return desired;
	}

	private Vector3 ApplyModifyVelocity(Vector3 desired)
	{
		CompAbility compAbility = owner.GetCompAbility();
		if (compAbility != null)
		{
			FSMRuntimeState layer0Peak = owner.GetCompMotion().layer0Peak;
			float num = 1f + compAbility.GetProperty(225u).value;
			float num2 = 1f + compAbility.GetProperty(224u).value;
			float num3 = 1f + compAbility.GetProperty(202u).value;
			float num4;
			float num5;
			switch (layer0Peak.state.value.stateType)
			{
			case MotionState.Move:
			case MotionState.Jump:
			case MotionState.Attack:
			case MotionState.AirAttackA:
				num4 = num;
				num5 = num2;
				break;
			case MotionState.Dodge:
				num4 = num3 * num;
				num5 = num2;
				break;
			case MotionState.FreeFall:
				num4 = num;
				num5 = 1f;
				break;
			default:
				num4 = 1f;
				num5 = 1f;
				break;
			}
			desired.x *= num4;
			desired.y *= num5;
		}
		return desired;
	}

	private void Rotate()
	{
		if (state == ACTMovementMode.Orbital360)
		{
			immediatelySetDir = false;
			return;
		}
		CompMotion compMotion = owner.GetCompMotion();
		CompTransform compTransform = owner.GetCompTransform();
		FaceDir faceDir = compTransform.FaceDir;
		FaceDir dir = compMotion.layer0PeakConfig.dir;
		if (dir != FaceDir.None)
		{
			faceDir = dir;
		}
		float target = 0f;
		switch (owner.GetConfig().animationSchema)
		{
		case AnimationSchema.UnlockRotation:
			target = QuaternionUtility.FaceLocalYAngle(faceDir);
			break;
		case AnimationSchema.LockRotation:
			if (compMotion.layer0Peak.toLogicPercent > compMotion.layer0PeakConfig.changeFaceDirTiming)
			{
				owner.SetFaceDir(compMotion.layer0PeakConfig.changFaceDir);
			}
			break;
		}
		if (compMotion.layer0PeakConfig.RootRotation)
		{
			target = rootEulerY;
			FaceDir dir2 = QuaternionUtility.LocalYToFaceDir(rootEulerY);
			owner.SetFaceDir(dir2);
		}
		else
		{
			float max = deltaTime * RotateSpeed;
			if (immediatelySetDir)
			{
				max = 1000f;
			}
			target = MathUtility.MoveTowardsAngle(compTransform.physicsRotateDegree, target, max);
		}
		compTransform.physicsRotateDegree = target;
		if (immediatelySetDir)
		{
			characterMovement.interpolation = RigidbodyInterpolation.None;
		}
		SetCharacterMovementRotation(OnPathOrientation * Quaternion.Euler(0f, target, 0f));
		if (immediatelySetDir)
		{
			characterMovement.interpolation = RigidbodyInterpolation.Interpolate;
		}
		immediatelySetDir = false;
	}

	public void SetDirImmediately()
	{
		immediatelySetDir = true;
	}

	private void PostPathLocalVelocity(Vector3 pathLocalVelocity)
	{
		Vector3 worldVelocity = PathLocalToWorld(pathLocalVelocity);
		PostWorldVelocity(worldVelocity);
	}

	private void PostWorldVelocity(Vector3 worldVelocity)
	{
		worldVelocity += compositeVelocity;
		if (worldVelocity.dot(recover) < 0f)
		{
			worldVelocity = Vector3.zero;
		}
		if (pauseVelocity)
		{
			characterMovement.velocity = Vector3.zero;
		}
		characterMovement.velocity = worldVelocity;
		if (recover.y > 0f)
		{
			characterMovement.PauseGroundConstraint(0.02f);
		}
		characterMovement.extraDisplacement = recover * deltaTime;
		compositeVelocity = Vector3.zero;
		recover = Vector3.zero;
	}

	public void LaunchCharacter(Vector3 launchVelocity, bool overrideVerticalVelocity = false, bool overrideLateralVelocity = false)
	{
		characterMovement.LaunchCharacter(launchVelocity, overrideVerticalVelocity, overrideLateralVelocity);
	}

	public float PredictMoveDisIfStopNow()
	{
		float brakingDeceleration = BrakingDeceleration;
		float num = rawVelocity.magnitude / brakingDeceleration;
		return 0.5f * brakingDeceleration * num * num;
	}

	public float PredictDisplacementUntilStop(Vector3 initialVelocity, float friction = -1f, float deceleration = -1f, float maxTime = 3f)
	{
		if (friction < 0f)
		{
			friction = Friction;
		}
		if (deceleration < 0f)
		{
			deceleration = BrakingDeceleration;
		}
		if (initialVelocity.sqrMagnitude <= 1E-05f)
		{
			return 0f;
		}
		float fixedDeltaTime = owner.GetCompTime().fixedDeltaTime;
		float num = 0f;
		float num2 = 0f;
		Vector3 vector = initialVelocity;
		if (fixedDeltaTime <= 0f)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("deltaTime must be greater than 0");
			}
			return 0f;
		}
		for (; num < maxTime; num += fixedDeltaTime)
		{
			if (!(vector.sqrMagnitude > 1E-05f))
			{
				break;
			}
			Vector3 rhs = vector;
			bool flag = friction == 0f;
			bool flag2 = deceleration == 0f;
			if (!flag || !flag2)
			{
				Vector3 vector2 = (flag2 ? Vector3.zero : ((0f - deceleration) * vector.normalized));
				vector += ((0f - friction) * vector + vector2) * fixedDeltaTime;
				if (Vector3.Dot(vector, rhs) <= 0f)
				{
					vector = Vector3.zero;
				}
				float sqrMagnitude = vector.sqrMagnitude;
				if (sqrMagnitude <= 1E-05f || (!flag2 && sqrMagnitude <= 0.01f))
				{
					vector = Vector3.zero;
				}
			}
			float num3 = rhs.magnitude * fixedDeltaTime;
			num2 += num3;
		}
		return num2;
	}

	private void CacheVecYBeforeRootMotion(Vector3 desired)
	{
		m_LastUseRootMotionY = _useRootMotionY;
		if (!m_LastUseRootMotionY && desired.y < 0f && !owner.InTag(MotionTag_backUp.ForbidFallSpeedAccumulate))
		{
			m_CacheVecYBeforeRootMotion = desired.y;
		}
	}

	private Vector3 ApplyCacheVerticalSpeed()
	{
		return new Vector3(0f, rawVelocity.y, 0f);
	}

	public Vector3 GetGravityVector()
	{
		return Vector3.down;
	}

	protected Vector3 LimitFallingVelocity(Vector3 currentVelocity)
	{
		Vector3 vector = currentVelocity;
		float maxFallSpeed = MaxFallSpeed;
		if (vector.sqrMagnitude > maxFallSpeed.square())
		{
			Vector3 gravityVector = GetGravityVector();
			if (Vector3.Dot(vector, gravityVector) > maxFallSpeed)
			{
				vector = vector.projectedOnPlane(gravityVector) + gravityVector * maxFallSpeed;
			}
		}
		return vector;
	}

	protected virtual Vector3 CalcVelocity(Vector3 velocity, Vector3 desiredVelocity, float friction, bool isFluid = false)
	{
		float magnitude = desiredVelocity.magnitude;
		Vector3 vector = ((magnitude > 0f) ? (desiredVelocity / magnitude) : Vector3.zero);
		Vector3 vector2 = MaxAcceleration * vector;
		float maxSpeed = MaxSpeed;
		bool flag = VectorUtility.V3isZero(vector2);
		bool flag2 = velocity.isExceeding(maxSpeed);
		if (flag | flag2)
		{
			Vector3 rhs = velocity;
			velocity = ApplyVelocityBraking(velocity, friction, BrakingDeceleration);
			if (flag2 && velocity.sqrMagnitude < maxSpeed.square() && Vector3.Dot(vector2, rhs) > 0f)
			{
				velocity = rhs.normalized * maxSpeed;
			}
		}
		else
		{
			velocity -= (velocity - vector * velocity.magnitude) * Mathf.Min(friction * deltaTime, 1f);
		}
		if (isFluid)
		{
			velocity *= 1f - Mathf.Min(friction * deltaTime, 1f);
		}
		if (!flag)
		{
			float maxLength = (velocity.isExceeding(maxSpeed) ? velocity.magnitude : maxSpeed);
			velocity += vector2 * deltaTime;
			velocity = velocity.clampedTo(maxLength);
		}
		return velocity;
	}

	protected virtual Vector3 ApplyVelocityBraking(Vector3 velocity, float friction, float deceleration)
	{
		bool flag = friction == 0f;
		bool flag2 = deceleration == 0f;
		if (flag & flag2)
		{
			return velocity;
		}
		Vector3 rhs = velocity;
		Vector3 vector = (flag2 ? Vector3.zero : ((0f - deceleration) * velocity.normalized));
		velocity += ((0f - friction) * velocity + vector) * deltaTime;
		if (Vector3.Dot(velocity, rhs) <= 0f)
		{
			return Vector3.zero;
		}
		float sqrMagnitude = velocity.sqrMagnitude;
		if (sqrMagnitude <= 1E-05f || (!flag2 && sqrMagnitude <= 0.01f))
		{
			return Vector3.zero;
		}
		return velocity;
	}

	protected void OnFoundGround(ref FindGroundResult findGroundResult)
	{
		if (findGroundResult.isWalkableGround)
		{
			hitOverride = false;
			m_CacheVecYBeforeRootMotion = 0f;
			_jumpPress = false;
			_frameJumpSpeed = 0f;
			_jumpPressTime = 0f;
			owner.SetBool("IsAirAttacked", value: false);
		}
	}

	public void OnSetPosition(Vector3 pos)
	{
		characterMovement.SetPosition(pos);
		if (!owner.IsBehaveEntity())
		{
			return;
		}
		CompTransform compTransform = owner.GetCompTransform();
		Path = null;
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		(Vector3, Vector3) p0P = PhysicsUtility.GetP0P1(pos + compTransform.center, compTransform.size);
		Vector3 item = p0P.Item1;
		Vector3 item2 = p0P.Item2;
		int num = Physics.OverlapCapsuleNonAlloc(item, item2, compTransform.size.x, cacheColliders, BattleConsts.enviromentMask, QueryTriggerInteraction.Collide);
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				MotionPath component = cacheColliders[i].GetComponent<MotionPath>();
				if (component != null)
				{
					AddPath(component);
				}
			}
		}
		PhysicsUtility.Release(cacheColliders);
		if (Path != null && ConstrainInPlaneZ)
		{
			FirstFindClosestPoint();
		}
	}

	public void ClearFallingAccumulateSpeed()
	{
		m_CacheVecYBeforeRootMotion = 0f;
	}

	public void ClearVelocity()
	{
		ClearInheritedAirSwitchPhysics();
		rawVelocity = Vector3.zero;
	}

	private void ApplyPushCallBack()
	{
		foreach (IPushCallBack pushCallBack in pushCallBacks)
		{
			if (!lastPushCallBacks.Contains(pushCallBack))
			{
				pushCallBack.OnPush(owner);
			}
		}
		lastPushCallBacks.Clear();
		foreach (IPushCallBack pushCallBack2 in pushCallBacks)
		{
			lastPushCallBacks.Add(pushCallBack2);
		}
		pushCallBacks.Clear();
		pushCallBacksCache.Clear();
	}

	private void ApplyHitWallCallBack()
	{
		foreach (IHitWallCallBack hitCallBack in hitCallBacks)
		{
			if (!lastHitCallBacks.Contains(hitCallBack))
			{
				hitCallBack.OnHitWall(owner);
			}
		}
		lastHitCallBacks.Clear();
		foreach (IHitWallCallBack hitCallBack2 in hitCallBacks)
		{
			lastHitCallBacks.Add(hitCallBack2);
		}
		hitCallBacks.Clear();
	}

	public void EnterGrabHookBegin()
	{
		bool left = Vector3.Dot(owner.GetCompTransform().colliderPosition - HookPoint, pathTangent) > 0f;
		owner.SetFaceLeft(left);
		SetDirImmediately();
		rawVelocity = Vector3.zero;
	}

	public void EnterGrabHook()
	{
		Vector3.Dot(owner.GetCompTransform().colliderPosition - HookPoint, pathTangent);
		SetMovementMode(ACTMovementMode.GrabHook);
	}

	public void ExitGrabHook()
	{
		if (state == ACTMovementMode.GrabHook)
		{
			SetMovementMode(characterMovement.isOnWalkableGround ? ACTMovementMode.Walking : ACTMovementMode.Falling);
		}
	}

	public void BreakHook()
	{
		CantHook = false;
	}

	public bool TriggerHook(Vector3 position)
	{
		if (owner.GetMotionBool("hooking") && !owner.GetMotionBool("hookTransfer"))
		{
			return false;
		}
		CompTransform compTransform = owner.GetCompTransform();
		owner.SetTrigger("hook");
		owner.SetBool("Hook_Down", compTransform.physicsPosition.y > position.y);
		float num = Vector3.Angle(Vector3.up, compTransform.physicsPosition - position);
		if (num < config.GrabUpAngle || num > 180f - config.GrabUpAngle)
		{
			owner.SetTrigger("Hook_Horizontal");
		}
		HookPoint = position;
		CantHook = true;
		return true;
	}

	private void GrabHooking()
	{
		_fallingTime += deltaTime;
		float motionFixedDeltaTime = owner.GetCompTime().motionFixedDeltaTime;
		float num = hookDistance.magnitude / config.GrabInitSpeed;
		float time = Mathf.Clamp01(hookTime / num);
		float num2 = config.GrabInitSpeed * config.GrabSpeedCurve.Evaluate(time);
		Vector3 vector = hookDistance.projectedOnPlane(Vector3.forward).normalized * num2;
		rawVelocity = new Vector3(vector.z, vector.y, vector.x);
		HandleRawVelocity();
		hookTime += motionFixedDeltaTime;
	}

	public void ResetFreeFallingTime()
	{
		_freeFallingTime = 0f;
	}

	public void OnMonoDisable(Entity entityBehave)
	{
		ResetUpdraftExitAcceleration();
		DetectCollisionsChange evt = Singleton<EventManager>.instance.GetEvt<DetectCollisionsChange>();
		evt.enable = false;
		evt.entity = entityBehave;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.DetectCollisionsChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void OnMonoDestroy(Entity entityBehave)
	{
		DetectCollisionsChange evt = Singleton<EventManager>.instance.GetEvt<DetectCollisionsChange>();
		evt.enable = false;
		evt.entity = entityBehave;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.DetectCollisionsChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void OnMotionStateChanged(MotionState prevMotionState, MotionState nextMotionState)
	{
		if (nextMotionState != MotionState.Updraft && nextMotionState != MotionState.Glide)
		{
			ResetUpdraftExitAcceleration();
		}
		if (nextMotionState == MotionState.Jump)
		{
			_frameJumpSpeed = config.JumpSpeed;
			_jumpPress = true;
			_jumpPressTime = 0f;
		}
		if (nextMotionState == MotionState.Move || nextMotionState == MotionState.Dodge)
		{
			lastHoriSpeed = 0f;
		}
	}

	public void ReleaseJumpPress()
	{
		if (state == ACTMovementMode.Falling)
		{
			_jumpPress = false;
		}
	}

	public void SetRootTransformOffset(Vector3 worldOffset)
	{
		m_RootTransformOffsetLocalBase = Vector3.zero;
		m_RootTransformOffsetWorld = worldOffset;
		SyncRootTransformOffset();
	}

	private void SyncRootTransformOffset()
	{
		if (!(characterMovement == null))
		{
			Vector3 rootTransformOffsetLocalBase = m_RootTransformOffsetLocalBase;
			if (m_RootTransformOffsetWorld != Vector3.zero)
			{
				Transform rootTransform = characterMovement.rootTransform;
				rootTransformOffsetLocalBase += ((rootTransform != null && rootTransform.parent != null) ? rootTransform.parent.InverseTransformVector(m_RootTransformOffsetWorld) : (Quaternion.Inverse(characterMovement.rotation) * m_RootTransformOffsetWorld));
			}
			characterMovement.rootTransformOffset = rootTransformOffsetLocalBase;
			characterMovement.SyncRootTransformPosition();
		}
	}

	internal void SetCharacterMovementRotation(Quaternion rotation)
	{
		characterMovement.rotation = rotation;
		if (m_RootTransformOffsetWorld != Vector3.zero)
		{
			SyncRootTransformOffset();
		}
	}

	public void SetDefaultEcm2Params(ECM2PARAMS ecm2Params)
	{
		m_DefaultRadius = ecm2Params.radius;
		m_DefaultHeight = ecm2Params.height;
		m_DefaultRootTransformOffset = ecm2Params.rootTransformOffset;
		m_RootTransformOffsetLocalBase = ecm2Params.rootTransformOffset;
		m_RootTransformOffsetWorld = Vector3.zero;
	}

	public void ResetParams()
	{
		float b = Mathf.Max(m_DefaultRadius, 0f);
		float b2 = Mathf.Max(m_DefaultHeight, m_DefaultRadius * 2f);
		if (!Mathf.Approximately(characterMovement.radius, b) || !Mathf.Approximately(characterMovement.height, b2))
		{
			characterMovement.height = m_DefaultHeight;
			characterMovement.radius = m_DefaultRadius;
		}
	}

	private bool IsCapsuleFullyOnPlatform(Collider platformCollider)
	{
		CompTransform? compTransform = owner.GetCompTransform();
		Vector3 physicsPosition = compTransform.physicsPosition;
		float x = compTransform.size.x;
		Bounds bounds = platformCollider.bounds;
		float num = Mathf.Abs(physicsPosition.x - bounds.min.x);
		float num2 = Mathf.Abs(physicsPosition.x - bounds.max.x);
		float num3 = Mathf.Abs(physicsPosition.z - bounds.min.z);
		float num4 = Mathf.Abs(physicsPosition.z - bounds.max.z);
		if (num < x || num2 < x || num3 < x || num4 < x)
		{
			return false;
		}
		return true;
	}

	public void ConfigureOrbital360Move(float speed, Orbital360Direction direction, float probeDistance, float cornerProbeDistance, float skinWidth, bool debugDraw = false)
	{
		orbital360Speed = Mathf.Max(0f, speed);
		orbital360Direction = direction;
		orbital360ProbeDistance = Mathf.Max(0.01f, probeDistance);
		orbital360CornerProbeDistance = Mathf.Max(orbital360ProbeDistance, cornerProbeDistance);
		orbital360SkinWidth = Mathf.Max(0f, skinWidth);
		orbital360DebugDraw = debugDraw;
	}

	public void EnterOrbital360Move(float speed, Orbital360Direction direction, float probeDistance, float cornerProbeDistance, float skinWidth, bool debugDraw = false)
	{
		ConfigureOrbital360Move(speed, direction, probeDistance, cornerProbeDistance, skinWidth, debugDraw);
		if (state == ACTMovementMode.Orbital360)
		{
			EnterOrbital360Move();
		}
		else
		{
			SetMovementMode(ACTMovementMode.Orbital360);
		}
	}

	private void EnterOrbital360Move()
	{
		_orbital360Initialized = true;
		_orbital360Stopped = false;
		_orbital360PrevCannotOffCliff = characterMovement.cannotOffCliff;
		_orbital360PrevConstrainToGround = characterMovement.constrainToGround;
		_orbital360LockedZ = characterMovement.position.z;
		SetConstZ(_orbital360LockedZ);
		SetConstrainInPlane(constrain: true);
		characterMovement.constrainToGround = false;
		characterMovement.cannotOffCliff = false;
		characterMovement.SetPlaneConstraint(PlaneConstraint.ConstrainZAxis, Vector3.zero);
		if (!TryFindOrbital360Surface(out var hit))
		{
			AlignOrbital360DirectionToFace();
			StopOrbital360Move("enter without surface");
			return;
		}
		SetOrbital360Surface(hit.normal);
		AlignOrbital360DirectionToFace();
		LogOrbital360("enter", $"hit={hit.collider?.name}, normal={_orbital360SurfaceNormal}, moveDir={_orbital360MoveDir}, pos={characterMovement.position}");
		ApplyOrbital360Rotation();
		rawVelocity = Vector3.zero;
		characterMovement.velocity = Vector3.zero;
	}

	private void ExitOrbital360Move()
	{
		_orbital360Initialized = false;
		_orbital360Stopped = false;
		characterMovement.cannotOffCliff = _orbital360PrevCannotOffCliff;
		characterMovement.constrainToGround = _orbital360PrevConstrainToGround;
		rawVelocity = Vector3.zero;
		characterMovement.velocity = Vector3.zero;
	}

	private void Orbital360Move()
	{
		if (!_orbital360Initialized)
		{
			EnterOrbital360Move();
		}
		if (_orbital360Stopped)
		{
			rawVelocity = Vector3.zero;
			characterMovement.velocity = Vector3.zero;
			ApplyOrbital360Rotation();
			return;
		}
		characterMovement.constrainToGround = false;
		characterMovement.cannotOffCliff = false;
		EnforceOrbital360LockedZ();
		if (!AttachOrbital360Surface())
		{
			StopOrbital360Move("lost surface");
			return;
		}
		if (TryTurnOrbital360ForwardSurface())
		{
			LogOrbital360("turn forward", $"normal={_orbital360SurfaceNormal}, moveDir={_orbital360MoveDir}");
			AttachOrbital360Surface();
		}
		if (!HasOrbital360FrontSupport() && !TryTurnOrbital360Corner())
		{
			StopOrbital360Move("open edge");
			return;
		}
		ApplyOrbital360Rotation();
		Vector3 worldVelocity = ToOrbital360Vector3(_orbital360MoveDir) * GetOrbital360Speed();
		worldVelocity.z = 0f;
		rawVelocity = new Vector3(0f, worldVelocity.y, worldVelocity.x);
		characterMovement.velocity = worldVelocity;
		LogOrbital360Move(worldVelocity);
	}

	private float GetOrbital360Speed()
	{
		if (!_useRootMotionXZ)
		{
			return orbital360Speed;
		}
		if (!(deltaTime > 0f))
		{
			return 0f;
		}
		return rootForward / deltaTime;
	}

	private bool AttachOrbital360Surface()
	{
		Vector3 vector = Orbital360FootPosition() + ToOrbital360Vector3(_orbital360SurfaceNormal) * orbital360ProbeOriginOffset;
		Vector3 vector2 = -ToOrbital360Vector3(_orbital360SurfaceNormal);
		float num = orbital360ProbeDistance + orbital360ProbeOriginOffset;
		if (!CastOrbital360(vector, vector2, num, out var hit, Color.green))
		{
			LogOrbital360("attach failed", $"origin={vector}, dir={vector2}, distance={num}");
			return false;
		}
		if (!TryProjectOrbital360Normal(hit.normal, out var normal2D))
		{
			LogOrbital360("attach invalid normal", $"hit={hit.collider?.name}, normal={hit.normal}");
			return false;
		}
		_orbital360SurfaceNormal = normal2D;
		_orbital360MoveDir = TangentFromOrbital360Normal(_orbital360SurfaceNormal);
		float num2 = orbital360ProbeOriginOffset + orbital360SkinWidth - hit.distance;
		Vector3 vector3 = ToOrbital360Vector3(_orbital360SurfaceNormal) * num2;
		vector3.z = 0f;
		float num3 = Mathf.Max(characterMovement.radius, orbital360ProbeDistance) * 0.5f;
		if (vector3.sqrMagnitude > num3 * num3)
		{
			vector3 = vector3.normalized * num3;
		}
		if (vector3.sqrMagnitude > 1E-06f)
		{
			characterMovement.extraDisplacement += vector3;
		}
		return true;
	}

	private bool HasOrbital360FrontSupport()
	{
		Vector3 vector = Orbital360FootPosition() + ToOrbital360Vector3(_orbital360MoveDir) * Orbital360FrontOffset() + ToOrbital360Vector3(_orbital360SurfaceNormal) * orbital360ProbeOriginOffset;
		Vector3 vector2 = -ToOrbital360Vector3(_orbital360SurfaceNormal);
		float num = orbital360ProbeDistance + orbital360ProbeOriginOffset;
		if (!CastOrbital360(vector, vector2, num, out var hit, Color.yellow))
		{
			LogOrbital360("front support miss", $"origin={vector}, dir={vector2}, distance={num}, normal={_orbital360SurfaceNormal}, moveDir={_orbital360MoveDir}");
			return false;
		}
		if (!TryProjectOrbital360Normal(hit.normal, out var normal2D))
		{
			LogOrbital360("front support invalid normal", $"hit={hit.collider?.name}, normal={hit.normal}");
			return false;
		}
		float num2 = Vector2.Dot(normal2D, _orbital360SurfaceNormal);
		if (num2 <= 0.45f)
		{
			LogOrbital360("front support normal mismatch", $"hit={hit.collider?.name}, hitNormal={normal2D}, surfaceNormal={_orbital360SurfaceNormal}, dot={num2}");
			return false;
		}
		return true;
	}

	private bool TryTurnOrbital360ForwardSurface()
	{
		Vector3 origin = Orbital360FootPosition() + ToOrbital360Vector3(_orbital360SurfaceNormal) * orbital360ProbeOriginOffset;
		Vector3 direction = ToOrbital360Vector3(_orbital360MoveDir);
		float distance = Orbital360FrontOffset() + orbital360ProbeDistance;
		if (!CastOrbital360(origin, direction, distance, out var hit, Color.magenta))
		{
			return false;
		}
		if (!TryProjectOrbital360Normal(hit.normal, out var normal2D))
		{
			return false;
		}
		if (Vector2.Dot(normal2D, _orbital360MoveDir) > -0.45f)
		{
			return false;
		}
		SetOrbital360Surface(hit.normal);
		SnapOrbital360ToSurface(hit.point, normal2D);
		LogOrbital360("forward surface hit", $"hit={hit.collider?.name}, normal={_orbital360SurfaceNormal}, moveDir={_orbital360MoveDir}");
		return true;
	}

	private bool TryTurnOrbital360Corner()
	{
		Vector2 orbital360MoveDir = _orbital360MoveDir;
		Vector3 vector = Orbital360FootPosition() + ToOrbital360Vector3(orbital360MoveDir) * (Orbital360FrontOffset() + orbital360ProbeOriginOffset);
		Vector3 vector2 = ToOrbital360Vector3(_orbital360SurfaceNormal);
		if (TryTurnOrbital360CornerFrom(vector - vector2 * orbital360ProbeOriginOffset, orbital360MoveDir))
		{
			return true;
		}
		return TryTurnOrbital360CornerFrom(vector, orbital360MoveDir);
	}

	private bool TryTurnOrbital360CornerFrom(Vector3 origin, Vector2 expectedNormal)
	{
		Vector3 vector = -ToOrbital360Vector3(expectedNormal);
		float num = orbital360CornerProbeDistance + orbital360ProbeOriginOffset;
		if (!CastOrbital360(origin, vector, num, out var hit, Color.cyan))
		{
			LogOrbital360("corner miss", $"origin={origin}, dir={vector}, distance={num}, expectedNormal={expectedNormal}");
			return false;
		}
		if (!TryProjectOrbital360Normal(hit.normal, out var normal2D))
		{
			LogOrbital360("corner invalid normal", $"hit={hit.collider?.name}, normal={hit.normal}");
			return false;
		}
		float num2 = Vector2.Dot(normal2D, expectedNormal);
		if (num2 < 0.45f)
		{
			LogOrbital360("corner normal mismatch", $"hit={hit.collider?.name}, hitNormal={normal2D}, expectedNormal={expectedNormal}, dot={num2}");
			return false;
		}
		SetOrbital360Surface(hit.normal);
		SnapOrbital360ToSurface(hit.point, normal2D);
		LogOrbital360("corner hit", $"hit={hit.collider?.name}, normal={_orbital360SurfaceNormal}, moveDir={_orbital360MoveDir}");
		return true;
	}

	private bool TryFindOrbital360Surface(out RaycastHit hit)
	{
		if (TryCastOrbital360Surface(_orbital360SurfaceNormal, out hit))
		{
			return true;
		}
		if (characterMovement.isOnGround && TryProjectOrbital360Normal(characterMovement.groundNormal, out var normal2D) && TryCastOrbital360Surface(normal2D, out hit))
		{
			return true;
		}
		Vector2[] array = new Vector2[4]
		{
			Vector2.up,
			Vector2.down,
			Vector2.right,
			Vector2.left
		};
		for (int i = 0; i < array.Length; i++)
		{
			if (TryCastOrbital360Surface(array[i], out hit))
			{
				return true;
			}
		}
		hit = default;
		return false;
	}

	private bool TryCastOrbital360Surface(Vector2 normal, out RaycastHit hit)
	{
		Vector3 origin = Orbital360FootPosition() + ToOrbital360Vector3(normal) * orbital360ProbeOriginOffset;
		Vector3 direction = -ToOrbital360Vector3(normal);
		return CastOrbital360(origin, direction, orbital360ProbeDistance + orbital360ProbeOriginOffset, out hit, Color.green);
	}

	private bool CastOrbital360(Vector3 origin, Vector3 direction, float distance, out RaycastHit hit, Color debugColor)
	{
		return characterMovement.Raycast(origin, direction.normalized, distance, BattleConsts.enviromentMask, out hit, orbital360CastThickness);
	}

	private void SetOrbital360Surface(Vector3 normal)
	{
		if (!TryProjectOrbital360Normal(normal, out _orbital360SurfaceNormal))
		{
			_orbital360SurfaceNormal = Vector2.up;
		}
		_orbital360MoveDir = TangentFromOrbital360Normal(_orbital360SurfaceNormal);
	}

	private bool TryProjectOrbital360Normal(Vector3 normal, out Vector2 normal2D)
	{
		normal2D = new Vector2(normal.x, normal.y);
		float sqrMagnitude = normal2D.sqrMagnitude;
		if (sqrMagnitude <= 0.0001f)
		{
			normal2D = Vector2.up;
			return false;
		}
		normal2D /= Mathf.Sqrt(sqrMagnitude);
		return true;
	}

	private void SnapOrbital360ToSurface(Vector3 hitPoint, Vector2 surfaceNormal)
	{
		Vector3 vector = hitPoint + ToOrbital360Vector3(surfaceNormal) * orbital360SkinWidth;
		vector.z = _orbital360LockedZ;
		Vector3 vector2 = vector - characterMovement.position;
		float num = Mathf.Max(characterMovement.radius, orbital360CornerProbeDistance) + orbital360ProbeOriginOffset;
		if (vector2.sqrMagnitude > num * num)
		{
			vector2 = vector2.normalized * num;
		}
		if (!(vector2.sqrMagnitude <= 1E-06f))
		{
			characterMovement.SetPosition(characterMovement.position + vector2);
			LogOrbital360("snap", $"hitPoint={hitPoint}, target={vector}, displacement={vector2}, pos={characterMovement.position}");
		}
	}

	private Vector2 TangentFromOrbital360Normal(Vector2 normal)
	{
		if (orbital360Direction != Orbital360Direction.Clockwise)
		{
			return new Vector2(0f - normal.y, normal.x);
		}
		return new Vector2(normal.y, 0f - normal.x);
	}

	private void AlignOrbital360DirectionToFace()
	{
		Vector2 rhs = (owner.IsFaceLeft() ? Vector2.left : Vector2.right);
		Vector2 lhs = new Vector2(_orbital360SurfaceNormal.y, 0f - _orbital360SurfaceNormal.x);
		orbital360Direction = ((!(Vector2.Dot(lhs, rhs) >= 0f)) ? Orbital360Direction.CounterClockwise : Orbital360Direction.Clockwise);
		_orbital360MoveDir = TangentFromOrbital360Normal(_orbital360SurfaceNormal);
	}

	private void ApplyOrbital360Rotation()
	{
		Vector3 vector = ToOrbital360Vector3(_orbital360SurfaceNormal);
		Vector3 vector2 = ToOrbital360Vector3(_orbital360MoveDir);
		if (!(vector2.sqrMagnitude <= 0.0001f) && !(vector.sqrMagnitude <= 0.0001f))
		{
			_orbital360Rotation = Quaternion.LookRotation(vector2.normalized, vector.normalized);
			characterMovement.rotation = _orbital360Rotation;
			CompTransform? compTransform = owner.GetCompTransform();
			compTransform.rotation = _orbital360Rotation;
			compTransform.FaceRotation = _orbital360Rotation;
			compTransform.PathRotation = _orbital360Rotation;
		}
	}

	private Quaternion GetOrbital360Rotation()
	{
		return _orbital360Rotation;
	}

	private void EnforceOrbital360LockedZ()
	{
		if (state == ACTMovementMode.Orbital360 && !(characterMovement == null))
		{
			Vector3 position = characterMovement.position;
			if (!Mathf.Approximately(position.z, _orbital360LockedZ))
			{
				position.z = _orbital360LockedZ;
				characterMovement.SetPosition(position);
			}
		}
	}

	private void StopOrbital360Move(string reason)
	{
		_orbital360Stopped = true;
		rawVelocity = Vector3.zero;
		characterMovement.velocity = Vector3.zero;
		ApplyOrbital360Rotation();
		LogOrbital360("stopped", $"reason={reason}, pos={characterMovement.position}, normal={_orbital360SurfaceNormal}, moveDir={_orbital360MoveDir}, velocity={characterMovement.velocity}", warning: true);
	}

	private void LogOrbital360Move(Vector3 worldVelocity)
	{
	}

	private void LogOrbital360(string title, string message, bool warning = false)
	{
	}

	private Vector3 Orbital360FootPosition()
	{
		Vector3 position = characterMovement.position;
		position.z = _orbital360LockedZ;
		return position;
	}

	private float Orbital360FrontOffset()
	{
		return Mathf.Max(characterMovement.radius, orbital360SkinWidth);
	}

	private static Vector3 ToOrbital360Vector3(Vector2 vector)
	{
		return new Vector3(vector.x, vector.y, 0f);
	}

	public bool UseWallClimb()
	{
		if (Singleton<SystemUnlockManager>.instance.IsUnlock(103102))
		{
			return !Singleton<ProtagonistManager>.instance.IsProtagonist;
		}
		return false;
	}

	public void InitSensor()
	{
		if (UseWallClimb())
		{
			wallSensor = new Sensor(characterMovement.transform, characterMovement.collider);
			RecalibrateSensor(wallSensor, WallSensorPos(), Sensor.CastDirection.Forward, wallLayer, wallSensorType);
			wallDownSensor = new Sensor(characterMovement.transform, characterMovement.collider);
			RecalibrateSensor(wallDownSensor, WallDownSensorPos(), Sensor.CastDirection.Forward, wallLayer, wallSensorType);
			rightSensor = new Sensor(characterMovement.transform, characterMovement.collider);
			RecalibrateSensor(rightSensor, WallRightSensorPos(), Sensor.CastDirection.Forward, wallLayer, wallSensorType);
			rightSensor.castLength = 5f;
			leftSensor = new Sensor(characterMovement.transform, characterMovement.collider);
			RecalibrateSensor(leftSensor, WallLeftSensorPos(), Sensor.CastDirection.Forward, wallLayer, wallSensorType);
			leftSensor.castLength = 5f;
			frontSensor = new Sensor(characterMovement.transform, characterMovement.collider);
			RecalibrateSensor(frontSensor, WallFrontSensorPos(), Sensor.CastDirection.Forward, 7 | (int)wallLayer, wallSensorType);
			frontSensor.castLength = 1.5f;
		}
	}

	public void ResetSensor()
	{
		wallSensor = null;
		wallDownSensor = null;
		rightSensor = null;
		leftSensor = null;
	}

	private void RecalibrateSensor(Sensor sensor, Vector3 center, Sensor.CastDirection direction, LayerMask layer, Sensor.CastType castType, Action<Sensor> callBack = null)
	{
		sensor.SetCastOrigin(center);
		sensor.SetCastDirection(direction);
		sensor.layermask = layer;
		sensor.castType = castType;
		float radius = characterMovement.radius;
		float num = 0.001f;
		Transform transform = characterMovement.transform;
		sensor.sphereCastRadius = radius * transform.localScale.x;
		float num2 = 0f;
		num2 += radius;
		num2 += wallCheckOffset;
		baseSensorRange = num2 * (1f + num);
		sensor.castLength = num2;
		sensor.ArrayRows = sensorArrayRows;
		sensor.arrayRayCount = sensorArrayRayCount;
		sensor.offsetArrayRows = sensorArrayRowsAreOffset;
		sensor.isInDebugMode = isInDebugMode;
		sensor.calculateRealDistance = true;
		sensor.calculateRealSurfaceNormal = true;
		callBack?.Invoke(sensor);
		sensor.RecalibrateRaycastArrayPositions();
	}

	public void UpdateSensor()
	{
		if (!UseWallClimb())
		{
			owner.SetBool("WallCheck", value: false);
			return;
		}
		if (!owner.InTag(MotionTag_backUp.CanDoWallClimb))
		{
			owner.SetBool("WallCheck", value: false);
			return;
		}
		if (wallSensor == null)
		{
			InitSensor();
		}
		wallClimbingState = CheckForWall();
		bool flag = isGrounded || (owner.IsFaceLeft() ? (rawVelocity.z < -0.1f) : (rawVelocity.z > 0.1f));
		owner.SetBool("WallCheck", flag && (int)wallClimbingState > 1);
	}

	private Vector3 WallSensorPos()
	{
		float num;
		if (AboveFrameCollided)
		{
			num = 0f;
		}
		else
		{
			num = ((characterMovement.velocity.y <= 0f) ? 0f : (characterMovement.height / 2f + wallBorderCheckOffset));
		}
		return characterMovement.worldCenter + Vector3.up * num;
	}

	private void RefreshWallSensorPos()
	{
		Vector3 castOrigin = WallSensorPos();
		wallSensor.SetCastOrigin(castOrigin);
		castOrigin = WallLeftSensorPos();
		leftSensor.SetCastOrigin(castOrigin);
		castOrigin = WallRightSensorPos();
		rightSensor.SetCastOrigin(castOrigin);
	}

	private Vector3 WallDownSensorPos()
	{
		float num = characterMovement.height / 2f + wallDownBorderCheckOffset;
		return characterMovement.worldCenter + Vector3.up * (0f - num);
	}

	private Vector3 WallLeftSensorPos()
	{
		return characterMovement.worldCenter + owner.GetCompTransform().FaceRotation * (Vector3.left * 0.5f);
	}

	private Vector3 WallRightSensorPos()
	{
		return characterMovement.worldCenter + owner.GetCompTransform().FaceRotation * (Vector3.right * 0.5f);
	}

	private Vector3 WallFrontSensorPos()
	{
		return characterMovement.worldCenter + Vector3.up * characterMovement.height / 2f;
	}

	public ClimbType CheckForWall()
	{
		RefreshWallSensorPos();
		wallSensor.Cast();
		if (!wallSensor.HasDetectedHit())
		{
			return ClimbType.None;
		}
		if (characterMovement.velocity.y < 0f)
		{
			Vector3 castOrigin = characterMovement.worldCenter + Vector3.up * 0.5f;
			wallSensor.SetCastOrigin(castOrigin);
			wallSensor.Cast();
			if (!wallSensor.HasDetectedHit())
			{
				return ClimbType.None;
			}
		}
		if (Vector3.Angle(-wallSensor.GetNormal(), characterMovement.transform.forward) > wallCheckAngle)
		{
			return ClimbType.None;
		}
		wallDownSensor.Cast();
		if (!wallDownSensor.HasDetectedHit())
		{
			if (state == ACTMovementMode.WallClimbing)
			{
				return ClimbType.ClimbDone;
			}
			return ClimbType.None;
		}
		if (!CheckSide())
		{
			return ClimbType.None;
		}
		lastHitWallPoint = wallSensor.GetPosition();
		return ClimbType.ClimbWall;
	}

	public bool CheckWallFront()
	{
		if (frontSensor == null)
		{
			return false;
		}
		frontSensor.Cast();
		if (!frontSensor.HasDetectedHit())
		{
			return false;
		}
		Collider collider = frontSensor.GetCollider();
		if (collider == null)
		{
			return false;
		}
		if (frontSensor.GetDistance() < 3f * characterMovement.radius)
		{
			return collider.gameObject.layer != 23;
		}
		return false;
	}

	public bool CheckSide()
	{
		leftSensor.Cast();
		rightSensor.Cast();
		if (leftSensor.HasDetectedHit())
		{
			return rightSensor.HasDetectedHit();
		}
		return false;
	}

	private void InitAttachWall()
	{
		if (attachedWall == null)
		{
			attachedWall = wallSensor.GetTransform();
			localOffset = attachedWall.InverseTransformPoint(characterMovement.position);
		}
	}

	private void SnapCapsuleToWall(Vector3 castDir)
	{
		float num = Mathf.Max(wallSensor.GetDistance() + wallSnapOffset, 0f);
		Vector3 pos = characterMovement.position + castDir.normalized * num;
		owner.SetFaceLeft(wallSensor.GetNormal().x > 0f);
		SetDirImmediately();
		characterMovement.constrainToGround = false;
		characterMovement.PauseGroundConstraint(0.2f);
		OnSetPosition(pos);
		attachedWall = null;
	}

	private void FixedWallOffset(Vector3 velocity)
	{
		if (attachedWall == null)
		{
			attachedWall = wallSensor.GetTransform();
			localOffset = attachedWall.InverseTransformPoint(characterMovement.position);
		}
		if (attachedWall != null)
		{
			Vector3 vector = attachedWall.TransformPoint(localOffset);
			float x = vector.x;
			float y = vector.y;
			if (Mathf.Abs(velocity.y) > 0.5f)
			{
				y = characterMovement.position.y;
				localOffset = attachedWall.InverseTransformPoint(characterMovement.position);
			}
			characterMovement.position = new Vector3(x, y, characterMovement.position.z);
		}
	}

	public void UpdateStuckDetection()
	{
		if (owner.HasCompCharacter())
		{
			CompTransform compTransform = owner.GetCompTransform();
			float num = Vector3.Distance(compTransform.lastPhysicsPosition, compTransform.physicsPosition);
			bool flag = IsLikelyStuck();
			if ((num < 0.01f) & flag)
			{
				_stuckFrameCount++;
			}
			else
			{
				_stuckFrameCount = 0;
				STUCKING = false;
			}
			if (_stuckFrameCount >= 60)
			{
				SetSTUCKING();
			}
		}
	}

	public bool IsLikelyStuck()
	{
		if (characterMovement == null || characterMovement.collider == null)
		{
			return false;
		}
		if (state != ACTMovementMode.Falling)
		{
			return false;
		}
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < characterMovement.GetCollisionResultRealCount(); i++)
		{
			Collider collider = characterMovement.GetCollisionResult(i).collider;
			if (!(collider == null) && !(collider == characterMovement.collider))
			{
				if (((1 << collider.gameObject.layer) & BattleConsts.enviromentMask) > 0)
				{
					num++;
				}
				if (collider.gameObject.layer == 6)
				{
					num2++;
				}
			}
		}
		Collider[] collisionOverlaps = characterMovement.GetCollisionOverlaps();
		foreach (Collider collider2 in collisionOverlaps)
		{
			if (!(collider2 == null) && !(collider2 == characterMovement.collider) && collider2.gameObject.layer == 6)
			{
				num2++;
			}
		}
		if (num <= 0 || num2 <= 0)
		{
			return num2 >= 2;
		}
		return true;
	}

	public void SetSTUCKING()
	{
		STUCKING = true;
	}
}
