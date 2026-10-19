using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Battle.Configs;

public class ConfigPhysics : ScriptableObject
{
	[SerializeField]
	private float rotateSpeed = 900f;

	[SerializeField]
	private OverlapEntityMode overlapEntityMode;

	[SerializeField]
	private VelocityRange walk;

	[SerializeField]
	private VelocityRange fall;

	[SerializeField]
	private VelocityRange fly;

	[SerializeField]
	private float gravity = -10f;

	[HideInInspector]
	[SerializeField]
	private float groundFriction = 0.3f;

	[FormerlySerializedAs("fallingLateralFriction")]
	[SerializeField]
	[HideInInspector]
	private float fallingFriction = 0.2f;

	[SerializeField]
	[HideInInspector]
	private float flyingFriction = 0.3f;

	[SerializeField]
	private float highAirHorSpeed = 9f;

	[SerializeField]
	private float climbingSpeed = 5f;

	[SerializeField]
	private int grabbingFrames = 10;

	[SerializeField]
	private float maxFallSpeed = 20f;

	[SerializeField]
	private float jumpSpeed = 20f;

	[SerializeField]
	private float jumpPressGravity;

	[SerializeField]
	private float jumpPreForbidTime = 0.1f;

	[SerializeField]
	private float jumpMaxPressTime;

	[SerializeField]
	private int adsorbLerpCount = 5;

	[SerializeField]
	private float leaveWallPressTime = 0.5f;

	[SerializeField]
	private float grabHookExtends;

	[SerializeField]
	private float grabInitSpeed = 40f;

	[SerializeField]
	private AnimationCurve grabSpeedCurve;

	[SerializeField]
	private float grabMaxVSpeedY = 20f;

	[SerializeField]
	private float grabMaxVSpeedZ = 20f;

	[SerializeField]
	private float grabUpAngle = 30f;

	[SerializeField]
	private float hookBlockThresholds = 0.1f;

	[SerializeField]
	private float hookHeightScale = 1f;

	[SerializeField]
	private float springInitSpeed = 40f;

	[SerializeField]
	private AnimationCurve springSpeedCurve;

	[SerializeField]
	private float springMaxVSpeedY = 20f;

	[SerializeField]
	private float springMaxVSpeedZ = 20f;

	[SerializeField]
	private float springBlockThresholds = 0.1f;

	[SerializeField]
	private float overDistance;

	[SerializeField]
	private float moveDistance;

	[SerializeField]
	private int _teleportMoveLerpFrames = 10;

	public float RotateSpeed => rotateSpeed;

	public OverlapEntityMode OverlapEntityMode => overlapEntityMode;

	public VelocityRange Walk => walk;

	public VelocityRange Fall => fall;

	public VelocityRange Fly => fly;

	public float Gravity => gravity;

	public float GroundFriction => groundFriction;

	public float FallingFriction => fallingFriction;

	public float FlyingFriction => flyingFriction;

	public float HighAirHorSpeed => highAirHorSpeed;

	public float ClimbingSpeed => climbingSpeed;

	public int GrabbingFrames => grabbingFrames;

	public float MaxFallSpeed => maxFallSpeed;

	public float JumpSpeed => jumpSpeed;

	public float JumpPressGravity => jumpPressGravity;

	public float JumpPreForbidTime => jumpPreForbidTime;

	public float JumpMaxPressTime => jumpMaxPressTime;

	public int AdsorbLerpCount => adsorbLerpCount;

	public float LeaveWallPressTime => leaveWallPressTime;

	public float GrabHookExtends => grabHookExtends;

	public float GrabInitSpeed => grabInitSpeed;

	public AnimationCurve GrabSpeedCurve => grabSpeedCurve;

	public float GrabMaxVSpeedY => grabMaxVSpeedY;

	public float GrabMaxVSpeedZ => grabMaxVSpeedZ;

	public float GrabUpAngle => grabUpAngle;

	public float HookBlockThresholds => hookBlockThresholds;

	public float HookHeightScale => hookHeightScale;

	public float SpringInitSpeed => springInitSpeed;

	public AnimationCurve SpringSpeedCurve => springSpeedCurve;

	public float SpringMaxVSpeedY => springMaxVSpeedY;

	public float SpringMaxVSpeedZ => springMaxVSpeedZ;

	public float SpringBlockThresholds => springBlockThresholds;

	public float OverDistance => overDistance;

	public float MoveDistance => moveDistance;

	public int TeleportMoveLerpFrames => _teleportMoveLerpFrames;
}
