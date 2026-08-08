using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
[RequireComponent(typeof(PolygonCollider2D))]
public abstract class SummerRaceCharacterBase : MonoBehaviour
{
	protected struct WheelContactData
	{
		public bool hasContact;

		public Vector2 point;

		public Vector2 normal;

		public Vector2 tangent;

		public float compression;

		public float compressionVelocity;

		public float supportSwitchCount1s;

		public float relativeNormalSpeed;

		public VehiclePhysicsController.WheelSupportSource supportSource;

		public float tangentVelocity;

		public RigidbodyType2D surfaceBodyType;
	}

	protected struct BodySkeletonBoundsFit
	{
		public Vector2 SourceCenter;

		public Vector2 TargetCenter;

		public float ScaleX;

		public float ScaleY;
	}

	private static readonly string[] BattleBodyBaseSkinStack = new string[1] { "default" };

	protected static readonly string[] BattleBodyPlayerSkinStack = new string[1] { "car/che_2" };

	protected static readonly string[] BattleBodyEnemySkinStack = new string[1] { "car/che_1" };

	private static readonly HashSet<string> BodyWheelSlotNames = new HashSet<string> { "lunzi3", "lunzi4", "lunzi5", "lunzi6" };

	protected const float NoGhostDebugLineDuration = 0f;

	protected const float DriveMinX = -7.95f;

	protected const float DriveMaxX = 7.95f;

	private const float OutOfBoundsGuardHorizontalPadding = 1.25f;

	private const float OutOfBoundsGuardMinX = -9.2f;

	private const float OutOfBoundsGuardMaxX = 9.2f;

	private const float OutOfBoundsGuardMinY = -4.85f;

	private const float OutOfBoundsGuardMaxY = 4.85f;

	private const float OutOfBoundsGuardPositionEpsilon = 0.001f;

	protected const float DriveSupportContactMinNormalY = 0.32f;

	protected const float DriveSupportCompressionMin = 0.05f;

	private const float WheelContactSupportDotMin = 0.42f;

	private const float WheelContactSupportDotFull = 0.88f;

	private const float SecondarySupportCompressionScale = 0.35f;

	private const float DynamicSupportCompressionScale = 0.55f;

	private const float BoundaryDriveBlockHoldSeconds = 0.16f;

	private const float VehicleCollisionAudioMinRelativeSpeed = 1.8f;

	private const float VehicleCollisionAudioCooldown = 0.16f;

	protected static readonly Vector3 WheelInnerTireVisualAuthoringOffset = new Vector3(0.03f, 0f, 0f);

	[Header("Common Settings")]
	[SerializeField]
	protected float laneY = -1.3f;

	[SerializeField]
	protected bool runtimeDebugLog = true;

	[SerializeField]
	protected bool hookPullTraceLog;

	[SerializeField]
	protected bool drawColliderOutlineInGame = true;

	[SerializeField]
	protected bool drawWeaponDirectionDebug = true;

	[SerializeField]
	protected bool drawRuntimeGizmos;

	[SerializeField]
	protected float debugLinePersistSeconds = 0.08f;

	[SerializeField]
	protected float weaponDirectionDebugLength = 1.4f;

	[SerializeField]
	protected float weaponMountLocalAngle;

	[SerializeField]
	protected bool lockToXAxisMotion = true;

	[Header("Wheel Physics")]
	[SerializeField]
	protected float wheelProbeExtra = 0.22f;

	[SerializeField]
	protected float wheelSpring = 520f;

	[SerializeField]
	protected float wheelDamping = 52f;

	[SerializeField]
	protected float wheelRollingResistance = 0.9f;

	[SerializeField]
	protected float maxAngularSpeedDeg = 440f;

	[SerializeField]
	protected float maxWheelMotorForcePerMass = 12f;

	[SerializeField]
	protected float maxSuspensionForcePerMass = 14.5f;

	[SerializeField]
	[Range(0f, 1f)]
	protected float dynamicSurfaceTractionMultiplier = 0.35f;

	[Header("Wheel Visual")]
	[SerializeField]
	protected float wheelVisualFollowRate = 22f;

	[SerializeField]
	protected float wheelVisualMaxTravel = 0.3f;

	[SerializeField]
	[Range(0f, 1f)]
	protected float wheelVisualSupportMinNormalY = 0.12f;

	[SerializeField]
	protected float wheelVisualSpring = 170f;

	[SerializeField]
	protected float wheelVisualDamping = 26f;

	[SerializeField]
	protected float wheelEmbedTargetRatio = 0.18f;

	[SerializeField]
	[Range(0.85f, 1.25f)]
	protected float wheelVisualContactRadiusScale = 1f;

	[SerializeField]
	[Min(0.05f)]
	protected float largeWheelBoostRadiusStart = 0.3f;

	[SerializeField]
	[Min(0.01f)]
	protected float largeWheelBoostRadiusRange = 0.12f;

	[SerializeField]
	[Range(1f, 1.5f)]
	protected float largeWheelVisualSpringBoost = 1.1f;

	[SerializeField]
	[Range(1f, 1.8f)]
	protected float largeWheelVisualDampingBoost = 1.25f;

	[Header("Suspension")]
	[SerializeField]
	protected float rearCompressionCapUnderFireDrive = 0.72f;

	[SerializeField]
	protected float wheelEmbedCompressionHardLimit = 0.75f;

	[SerializeField]
	protected float rearCompressionHardLimit = 0.72f;

	[Header("Lane Stabilization")]
	[SerializeField]
	protected float laneSpring = 38f;

	[SerializeField]
	protected float laneDamping = 11f;

	[SerializeField]
	protected float laneStabilizeMaxForcePerMass = 18f;

	[SerializeField]
	[Range(0.05f, 0.7f)]
	protected float spawnCompressionNormalized = 0.28f;

	[Header("Spawn Drive Convergence")]
	[SerializeField]
	[Min(0f)]
	protected float spawnDriveGraceSeconds = 0.1f;

	[SerializeField]
	[Min(0.05f)]
	protected float spawnDriveRampSeconds = 0.7f;

	[SerializeField]
	[Min(0f)]
	protected float spawnDriveConditionHoldSeconds = 0.18f;

	[SerializeField]
	[Range(0.05f, 1f)]
	protected float spawnDriveMinScale = 0.24f;

	[SerializeField]
	[Min(0f)]
	protected float spawnDriveDistanceTolerance = 1.2f;

	[SerializeField]
	[Range(0f, 1f)]
	protected float spawnDriveSupportTolerance = 0.28f;

	[Header("Boundary Recovery")]
	[SerializeField]
	[Range(0f, 1f)]
	protected float boundaryEscapeGateThreshold = 0.2f;

	[SerializeField]
	[Min(0f)]
	protected float boundaryEscapeSpeedThreshold = 0.2f;

	[SerializeField]
	[Range(0f, 1f)]
	protected float boundaryEscapeAccelerationScale = 0.38f;

	protected Rigidbody2D rb;

	protected float frontWheelRadius;

	protected float backWheelRadius;

	protected Vector2 frontWheelLocal;

	protected Vector2 backWheelLocal;

	protected bool frontWheelVisualInitialized;

	protected bool backWheelVisualInitialized;

	protected float frontWheelVisualVelY;

	protected float backWheelVisualVelY;

	protected Vector2 frontWheelVisualWorld;

	protected Vector2 backWheelVisualWorld;

	protected Transform frontWheel;

	protected Transform backWheel;

	protected float currentHP;

	protected float currentEnergy;

	protected float currentLoadWeight;

	protected float shieldUntil;

	protected float thrusterUntil;

	protected float thrusterBoostStrength;

	protected float thrusterImpulseGuardUntil;

	protected float knockbackDriveGuardUntil;

	protected float nextDebugLogAt;

	protected float debugWheelEmbedRatio;

	protected float debugRearCompressionNormalized;

	protected float recoilKick;

	protected float recoilKickVel;

	protected float authoredSpawnAnchorX;

	protected bool hasAuthoredSpawnAnchorX;

	protected bool weaponFireUnlockedAfterSpawn = true;

	protected float weaponFireSupportStableElapsed;

	protected bool weaponFireLandingDetectedAfterSpawn;

	protected bool spawnEntryLandingAnimationPlayed;

	protected float spawnDriveRampStartAt = -999f;

	protected float spawnDriveConditionStableElapsed;

	protected float spawnDriveBlend;

	protected float boundaryDriveBlockUntil = -1f;

	protected Vector2 boundaryDriveBlockNormal = Vector2.zero;

	protected const float ThrusterImpulseGuardSeconds = 0.95f;

	protected const float ThrusterImpulseMinDeltaSpeed = 10f;

	protected const float ThrusterImpulseMaxDeltaSpeed = 56f;

	protected const float ThrusterImpulseMagnitudeScale = 2.8f;

	protected const float ThrusterSustainedAccelerationMin = 24f;

	protected const float ThrusterSustainedAccelerationScale = 4f;

	protected const float ThrusterSustainedAccelerationMax = 70f;

	protected const float KnockbackDriveGuardSeconds = 0.22f;

	protected const float KnockbackDriveGuardMaxSeconds = 0.42f;

	[Header("Modular Backend")]
	[SerializeField]
	protected bool mirrorModularWheelDebug = true;

	protected VehicleAssembler modularAssembler;

	protected VehiclePhysicsController modularPhysics;

	protected VehicleWeaponSystem modularWeaponSystem;

	protected VehicleEquipSystem modularEquipSystem;

	protected bool modularBackendReady;

	protected SummerRaceRuntimeVehicleBuild modularRuntimeBuild;

	protected readonly List<VehiclePhysicsController.DebugWheelState> modularWheelStates = new List<VehiclePhysicsController.DebugWheelState>(8);

	protected bool modularVisualMirrorInitialized;

	protected float modularVisualMirrorSign = 1f;

	protected readonly Dictionary<Transform, Quaternion> modularMountedVisualAuthoringRotations = new Dictionary<Transform, Quaternion>(16);

	protected WheelContactData lastFrontWheelContact;

	protected WheelContactData lastBackWheelContact;

	protected string lastExplainabilityEvent = "init";

	protected float lastExplainabilityEventAt = -999f;

	protected ContactFilter2D driveContactFilter;

	protected Collider2D[] driveContactBuffer = new Collider2D[24];

	protected Collider2D[] wheelVisualPenetrationBuffer = new Collider2D[24];

	private static readonly Dictionary<long, float> VehicleCollisionAudioNextTimeByPair = new Dictionary<long, float>(32);

	private float nextVehicleCollisionAudioAt = -1f;

	[Header("Tank Body")]
	[SerializeField]
	protected SummerRaceBodyType bodyType = SummerRaceBodyType.Medium;

	private const float WeaponFireUnlockMinNormalY = 0.1f;

	private const float WeaponFireUnlockMinCompression = 0.2f;

	private const float WeaponFireUnlockStableSeconds = 0.04f;

	private const float SpawnLandingFallbackStableSeconds = 0.04f;

	private const float SpawnLandingFallbackMaxVerticalSpeed = 0.08f;

	protected bool IsRuntimeDebugLogEnabled
	{
		get
		{
			if (runtimeDebugLog)
			{
				return SummerRaceRuntimeLog.IsGameplayVerboseEnabled;
			}
			return false;
		}
	}

	public float LastDamageReceivedTime { get; protected set; } = float.NegativeInfinity;

	protected virtual void Awake()
	{
		rb = GetComponent<Rigidbody2D>();
		EnsureCombatAudioSink();
		CaptureAuthoredSpawnAnchorX();
		driveContactFilter = new ContactFilter2D
		{
			useTriggers = false
		};
	}

	protected virtual void Update()
	{
		TickEnergyAndOverload();
		TickBurnDamage();
	}

	protected virtual void FixedUpdate()
	{
		DebugDraw();
	}

	protected virtual void LateUpdate()
	{
		if (Application.isPlaying)
		{
			UpdateWheelVisual(RequirePhysicsBodyReady("LateUpdate").velocity.x, Time.deltaTime);
		}
		else
		{
			UpdateWheelVisual(0f, Time.deltaTime);
		}
	}

	protected virtual void OnDestroy()
	{
		if (modularRuntimeBuild != null)
		{
			SummerRaceRuntimeModuleFactory.ReleaseBuild(modularRuntimeBuild);
			modularRuntimeBuild = null;
		}
	}

	protected virtual void TickEnergyAndOverload()
	{
	}

	protected virtual void TickBurnDamage()
	{
	}

	protected void ApplySelfDashEffect(float strength, float duration)
	{
		float num = Mathf.Max(0f, strength);
		thrusterUntil = Mathf.Max(thrusterUntil, Time.time + ResolveThrusterActiveSeconds(duration));
		thrusterBoostStrength = Mathf.Max(thrusterBoostStrength, num);
		thrusterImpulseGuardUntil = Mathf.Max(thrusterImpulseGuardUntil, Time.time + ResolveThrusterImpulseGuardSeconds(duration));
		if (!(num <= 0f) || !(duration <= 0f))
		{
			Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ApplySelfDashEffect");
			float num2 = Mathf.Clamp(Mathf.Max(num, 10f), 0f, 56f) * Mathf.Max(0.1f, rigidbody2D.mass) * 2.8f;
			ApplyImpulse(ResolveThrusterImpulseDirection() * num2);
		}
	}

	protected float ResolveThrusterImpulseProtectedAcceleration(float driveAcceleration, float accelerationCap, out bool reverseSuppressedByThruster)
	{
		RequireFiniteValue(driveAcceleration, "ResolveThrusterImpulseProtectedAcceleration.driveAcceleration");
		RequireFiniteValue(accelerationCap, "ResolveThrusterImpulseProtectedAcceleration.accelerationCap");
		reverseSuppressedByThruster = false;
		if (Time.time < knockbackDriveGuardUntil)
		{
			return 0f;
		}
		if (Time.time >= thrusterImpulseGuardUntil)
		{
			return driveAcceleration;
		}
		Vector2 vector = ResolveThrusterImpulseDirection();
		if (driveAcceleration * vector.x < 0f)
		{
			reverseSuppressedByThruster = true;
			return ResolveSignedDirectionSign(vector.x, driveAcceleration) * ResolveThrusterPursuitAssistAcceleration(accelerationCap);
		}
		float num = ResolveThrusterPursuitAssistAcceleration(accelerationCap);
		if (num <= 0f)
		{
			return driveAcceleration;
		}
		float num2 = ResolveSignedDirectionSign(driveAcceleration, vector.x);
		return driveAcceleration + num2 * num;
	}

	protected virtual float ResolveThrusterImpulseGuardSeconds(float duration)
	{
		return Mathf.Max(0.95f, Mathf.Min(1.2f, ResolveThrusterActiveSeconds(duration) * 0.85f));
	}

	protected virtual float ResolveThrusterActiveSeconds(float duration)
	{
		return Mathf.Max(0.85f, Mathf.Max(0f, duration));
	}

	protected virtual float ResolveThrusterPursuitAssistAcceleration(float accelerationCap)
	{
		float num = Mathf.Max(0f, accelerationCap);
		if (num <= 0.0001f || Time.time >= thrusterImpulseGuardUntil)
		{
			return 0f;
		}
		float b = (ResolveThrusterSpeedMultiplier() - 1f) * 1.2f;
		float num2 = Mathf.Clamp(Mathf.Max(0.6f, b), 0f, 1.35f);
		return num * num2;
	}

	protected void ApplyThrusterSustainedForce(float deltaTime)
	{
		if (!(deltaTime <= 0f) && !(Time.time >= thrusterUntil))
		{
			Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ApplyThrusterSustainedForce");
			Vector2 vector = ResolveThrusterImpulseDirection();
			float t = Mathf.Clamp01((thrusterUntil - Time.time) / ResolveThrusterActiveSeconds(0f));
			float num = Mathf.Max(thrusterBoostStrength, 10f);
			float num2 = Mathf.Clamp(24f + num * 4f, 24f, 70f);
			num2 *= Mathf.Lerp(0.65f, 1f, t);
			rigidbody2D.AddForce(vector * num2 * rigidbody2D.mass, ForceMode2D.Force);
		}
	}

	protected virtual Vector2 ResolveThrusterImpulseDirection()
	{
		Vector2 vector = ResolveThrusterVehicleForwardDirection();
		if (vector.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Thruster impulse direction is invalid.");
		}
		return vector.normalized;
	}

	protected virtual Vector2 ResolveThrusterVehicleForwardDirection()
	{
		return ResolveForwardPhysicsDirection();
	}

	private static float ResolveSignedDirectionSign(float primary, float fallback)
	{
		if (Mathf.Abs(primary) > 0.0001f)
		{
			return Mathf.Sign(primary);
		}
		if (Mathf.Abs(fallback) > 0.0001f)
		{
			return Mathf.Sign(fallback);
		}
		return 1f;
	}

	protected float ResolveThrusterSpeedMultiplier()
	{
		if (Time.time >= thrusterUntil)
		{
			thrusterBoostStrength = 0f;
			return 1f;
		}
		return 1f + Mathf.Clamp(thrusterBoostStrength * 0.34f, 0f, 0.95f);
	}

	protected bool TryApplyPullTargetEffect(ICombatSourceContext sourceContext, float strength)
	{
		Transform transform = ResolveAliveCombatSourceTransform(sourceContext);
		if (transform == null || strength <= 0f)
		{
			return false;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("TryApplyPullTargetEffect");
		Vector2 velocity = rigidbody2D.velocity;
		Vector2 vector = (Vector2)transform.position - (Vector2)base.transform.position;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return false;
		}
		Vector2 normalized = vector.normalized;
		float num = ResolvePullTargetImpulseMagnitude(sourceContext, normalized, vector.magnitude, strength);
		Vector2 vector2 = normalized * num;
		ApplyImpulse(vector2);
		Rigidbody2D rigidbody2D2 = ResolveAliveCombatSourceRigidbody(sourceContext);
		if (rigidbody2D2 != null && rigidbody2D2 != rigidbody2D && rigidbody2D2.bodyType == RigidbodyType2D.Dynamic)
		{
			rigidbody2D2.AddForce(-vector2, ForceMode2D.Impulse);
		}
		if (hookPullTraceLog && IsRuntimeDebugLogEnabled)
		{
			Vector2 vector3 = ((rigidbody2D2 != null) ? rigidbody2D2.velocity : Vector2.zero);
			Vector2 velocity2 = rigidbody2D.velocity;
			float num2 = ((rigidbody2D2 != null) ? rigidbody2D2.mass : 0f);
			string[] obj = new string[24]
			{
				"[SummerRace][",
				GetType().Name,
				"][HookTrace] sourcePos=",
				transform.position.ToString(),
				" targetPos=",
				base.transform.position.ToString(),
				" pullDir=",
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null
			};
			Vector2 vector4 = normalized;
			obj[7] = vector4.ToString();
			obj[8] = " distance=";
			obj[9] = vector.magnitude.ToString("F3");
			obj[10] = " baseStrength=";
			obj[11] = strength.ToString("F3");
			obj[12] = " impulse=";
			obj[13] = num.ToString("F3");
			obj[14] = " targetMass=";
			obj[15] = rigidbody2D.mass.ToString("F3");
			obj[16] = " sourceMass=";
			obj[17] = num2.ToString("F3");
			obj[18] = " sourceVel=";
			vector4 = vector3;
			obj[19] = vector4.ToString();
			obj[20] = " preVel=";
			vector4 = velocity;
			obj[21] = vector4.ToString();
			obj[22] = " postVel=";
			vector4 = velocity2;
			obj[23] = vector4.ToString();
			SummerRaceRuntimeLog.Log(string.Concat(obj));
		}
		return true;
	}

	protected bool TryApplyKnockbackEffect(Vector2 hitDirection, float strength, ICombatSourceContext sourceContext)
	{
		if (strength <= 0f)
		{
			return false;
		}
		RequirePhysicsBodyReady("TryApplyKnockbackEffect");
		Vector2 vector = ((hitDirection.sqrMagnitude > 0.0001f) ? hitDirection.normalized : ResolveForwardPhysicsDirection());
		float num = ResolveKnockbackImpulseMagnitude(sourceContext, vector, strength);
		float num2 = Mathf.Clamp(0.22f + Mathf.Max(0f, strength) * 0.018f, 0.22f, 0.42f);
		knockbackDriveGuardUntil = Mathf.Max(knockbackDriveGuardUntil, Time.time + num2);
		if (IsRuntimeDebugLogEnabled)
		{
			string[] obj = new string[12]
			{
				"[SummerRace][",
				GetType().Name,
				"][KnockbackTrace] dir=",
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null
			};
			Vector2 vector2 = vector;
			obj[3] = vector2.ToString();
			obj[4] = " strength=";
			obj[5] = strength.ToString("F3");
			obj[6] = " impulse=";
			obj[7] = num.ToString("F3");
			obj[8] = " guardUntil=";
			obj[9] = knockbackDriveGuardUntil.ToString("F3");
			obj[10] = " velBefore=";
			obj[11] = RequirePhysicsBodyReady("TryApplyKnockbackEffect.Trace").velocity.ToString();
			SummerRaceRuntimeLog.Log(string.Concat(obj));
		}
		ApplyImpulse(vector * num);
		if (IsRuntimeDebugLogEnabled)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][" + GetType().Name + "][KnockbackTrace] velAfter=" + RequirePhysicsBodyReady("TryApplyKnockbackEffect.TraceAfter").velocity.ToString());
		}
		return true;
	}

	protected float ResolvePullTargetImpulseMagnitude(ICombatSourceContext sourceContext, Vector2 pullDirection, float distanceToSource, float baseStrength)
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ResolvePullTargetImpulseMagnitude");
		float num = Mathf.Max(0f, baseStrength);
		float num2 = Mathf.Max(0f, distanceToSource);
		float num3 = Mathf.Min(num * 0.8f, Mathf.Max(0f, num2 - 1f) * 0.5f);
		Rigidbody2D rigidbody2D2 = ResolveAliveCombatSourceRigidbody(sourceContext);
		float num4 = Vector2.Dot(((rigidbody2D2 != null) ? rigidbody2D2.velocity : Vector2.zero) - rigidbody2D.velocity, pullDirection);
		float num5 = Mathf.Clamp(Mathf.Clamp(num * 0.8f, 1.5f, 6f) - num4, 0f, Mathf.Max(0.5f, num * 0.4f));
		return num + num3 + num5;
	}

	protected float ResolveKnockbackImpulseMagnitude(ICombatSourceContext sourceContext, Vector2 knockDirection, float baseStrength)
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ResolveKnockbackImpulseMagnitude");
		float num = Mathf.Max(0f, baseStrength);
		Rigidbody2D rigidbody2D2 = ResolveAliveCombatSourceRigidbody(sourceContext);
		Vector2 vector = ((rigidbody2D2 != null) ? rigidbody2D2.velocity : Vector2.zero);
		float num2 = Mathf.Clamp(Mathf.Max(0f, Vector2.Dot(vector - rigidbody2D.velocity, knockDirection)) * 0.35f, 0f, Mathf.Max(0.5f, num * 0.6f));
		return num + num2;
	}

	private static Transform ResolveAliveCombatSourceTransform(ICombatSourceContext sourceContext)
	{
		if (sourceContext == null)
		{
			return null;
		}
		try
		{
			Transform combatSourceTransform = sourceContext.CombatSourceTransform;
			return (combatSourceTransform != null) ? combatSourceTransform : null;
		}
		catch (MissingReferenceException)
		{
			return null;
		}
	}

	private static Rigidbody2D ResolveAliveCombatSourceRigidbody(ICombatSourceContext sourceContext)
	{
		if (sourceContext == null)
		{
			return null;
		}
		try
		{
			Rigidbody2D combatSourceRigidbody = sourceContext.CombatSourceRigidbody;
			return (combatSourceRigidbody != null) ? combatSourceRigidbody : null;
		}
		catch (MissingReferenceException)
		{
			return null;
		}
	}

	protected Vector2 ResolveForwardPhysicsDirection()
	{
		Vector2 vector = RequirePhysicsBodyReady("ResolveForwardPhysicsDirection").transform.right;
		if (vector.sqrMagnitude > 0.0001f)
		{
			return vector.normalized;
		}
		throw new InvalidOperationException("[SummerRace] Forward physics direction is invalid on " + base.name);
	}

	protected void ApplyImpulse(Vector2 impulse)
	{
		if (!(impulse.sqrMagnitude <= 0.0001f))
		{
			RequirePhysicsBodyReady("ApplyImpulse").AddForce(impulse, ForceMode2D.Impulse);
		}
	}

	protected void ApplyOutOfBoundsGuard(string context)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady(context + ".OutOfBoundsGuard");
		if (!rigidbody2D.simulated)
		{
			return;
		}
		Vector2 position = rigidbody2D.position;
		Vector2 vector = ClampOutOfBoundsGuardPosition(position, laneY);
		if (!((vector - position).sqrMagnitude <= 1.0000001E-06f))
		{
			Vector2 velocity = rigidbody2D.velocity;
			Vector2 velocity2 = ClampOutOfBoundsGuardVelocity(velocity, position);
			base.transform.position = new Vector3(vector.x, vector.y, base.transform.position.z);
			rigidbody2D.position = vector;
			rigidbody2D.velocity = velocity2;
			if (IsRuntimeDebugLogEnabled)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][OutOfBoundsGuard] " + context + " name=" + base.name + " pos=" + position.ToString("F3") + "->" + vector.ToString("F3") + " vel=" + velocity.ToString("F3") + "->" + velocity2.ToString("F3"));
			}
		}
	}

	private static Vector2 ClampOutOfBoundsGuardPosition(Vector2 position, float fallbackY)
	{
		float x = (IsFinite(position.x) ? Mathf.Clamp(position.x, -9.2f, 9.2f) : 0f);
		float y = (IsFinite(position.y) ? Mathf.Clamp(position.y, -4.85f, 4.85f) : Mathf.Clamp(fallbackY, -4.85f, 4.85f));
		return new Vector2(x, y);
	}

	private static Vector2 ClampOutOfBoundsGuardVelocity(Vector2 velocity, Vector2 originalPosition)
	{
		if (!IsFinite(velocity))
		{
			return Vector2.zero;
		}
		if (originalPosition.x < -9.2f && velocity.x < 0f)
		{
			velocity.x = 0f;
		}
		else if (originalPosition.x > 9.2f && velocity.x > 0f)
		{
			velocity.x = 0f;
		}
		if (originalPosition.y < -4.85f && velocity.y < 0f)
		{
			velocity.y = 0f;
		}
		else if (originalPosition.y > 4.85f && velocity.y > 0f)
		{
			velocity.y = 0f;
		}
		return velocity;
	}

	protected virtual void ApplyDrivePhysics(float driveAcceleration)
	{
	}

	protected virtual void DebugDraw()
	{
	}

	protected virtual void DrawWheelCircleDebug()
	{
	}

	protected void DrawWheelSuspensionLimitGizmo(Vector2 wheelLocal, float wheelRadius, in WheelContactData contact, Color axisColor, Color currentColor)
	{
		Vector2 vector = base.transform.TransformPoint(wheelLocal);
		Vector2 value = -(Vector2)base.transform.up;
		if (!IsFinite(value) || value.sqrMagnitude <= 0.0001f)
		{
			value = Vector2.down;
		}
		value = value.normalized;
		float num = Mathf.Max(0.0001f, GetSuspensionReach(wheelRadius));
		float num2 = 0f;
		float num3 = Mathf.Lerp(num, num2, Mathf.Clamp01(spawnCompressionNormalized));
		float t = (IsFinite(contact.compression) ? Mathf.Clamp01(contact.compression) : 0f);
		bool flag = contact.hasContact && contact.normal.sqrMagnitude > 0.0001f;
		if (Application.isPlaying && rb != null)
		{
			flag = IsSupportContact(in contact, wheelVisualSupportMinNormalY, rb);
		}
		float value2 = (flag ? Mathf.Lerp(num, num2, t) : num);
		value2 = Mathf.Clamp(value2, num2, num);
		Vector3 vector2 = vector + value * num2;
		Vector3 center = vector + value * num3;
		Vector3 vector3 = vector + value * num;
		Vector3 vector4 = vector + value * value2;
		Gizmos.color = axisColor;
		Gizmos.DrawLine(vector2, vector3);
		Gizmos.DrawWireSphere(vector2, 0.018f);
		Gizmos.DrawWireSphere(center, 0.018f);
		Gizmos.DrawWireSphere(vector3, 0.018f);
		Gizmos.color = currentColor;
		Gizmos.DrawWireSphere(vector4, 0.026f);
		Gizmos.DrawLine(vector, vector4);
	}

	protected virtual void UpdateWheelVisual(float velocityX, float deltaTime)
	{
		SyncModularVisualMirror();
		float num = Mathf.Clamp(Mathf.Abs(velocityX) * 220f, 90f, 520f);
		float deltaZ = ((velocityX >= 0f) ? (0f - num) : num) * Mathf.Max(0.0001f, deltaTime);
		if (frontWheel != null)
		{
			RotateWheelVisual(frontWheel, deltaZ);
			frontWheelVisualWorld = ResolveWheelVisualWorldPos(frontWheelLocal, frontWheelRadius, lastFrontWheelContact, frontWheelVisualWorld, ref frontWheelVisualVelY, ref frontWheelVisualInitialized, deltaTime);
			frontWheel.position = frontWheelVisualWorld;
		}
		if (backWheel != null)
		{
			RotateWheelVisual(backWheel, deltaZ);
			backWheelVisualWorld = ResolveWheelVisualWorldPos(backWheelLocal, backWheelRadius, lastBackWheelContact, backWheelVisualWorld, ref backWheelVisualVelY, ref backWheelVisualInitialized, deltaTime);
			backWheel.position = backWheelVisualWorld;
		}
	}

	protected virtual WheelContactData SampleWheelContact(Vector2 wheelLocal, float wheelRadius)
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ResolveWheelContact");
		WheelContactData result = new WheelContactData
		{
			hasContact = false,
			point = base.transform.TransformPoint(wheelLocal),
			normal = Vector2.zero,
			tangent = Vector2.zero,
			compression = 0f,
			compressionVelocity = 0f,
			supportSwitchCount1s = 0f,
			relativeNormalSpeed = 0f,
			supportSource = VehiclePhysicsController.WheelSupportSource.None,
			tangentVelocity = 0f,
			surfaceBodyType = RigidbodyType2D.Static
		};
		Vector2 vector = base.transform.TransformPoint(wheelLocal);
		float suspensionReach = GetSuspensionReach(wheelRadius);
		float num = Mathf.Max(0.08f, wheelRadius + suspensionReach);
		int num2 = Physics2D.OverlapCircle(vector, num, driveContactFilter, driveContactBuffer);
		if (num2 <= 0)
		{
			return result;
		}
		float num3 = float.MaxValue;
		Vector2 point = vector;
		Vector2 vector2 = Vector2.zero;
		RigidbodyType2D rigidbodyType2D = RigidbodyType2D.Static;
		for (int i = 0; i < num2; i++)
		{
			Collider2D collider2D = driveContactBuffer[i];
			if (!(collider2D == null) && !(collider2D.attachedRigidbody == rigidbody2D))
			{
				Vector2 vector3 = collider2D.ClosestPoint(vector);
				Vector2 vector4 = vector - vector3;
				float magnitude = vector4.magnitude;
				if (magnitude < num3)
				{
					num3 = magnitude;
					point = vector3;
					vector2 = ((magnitude > 0.0001f) ? (vector4 / magnitude) : Vector2.zero);
					rigidbodyType2D = ((collider2D.attachedRigidbody != null) ? collider2D.attachedRigidbody.bodyType : RigidbodyType2D.Static);
				}
			}
		}
		if (num3 > num || vector2.sqrMagnitude <= 0.0001f)
		{
			return result;
		}
		Vector2 up = Vector2.up;
		result.hasContact = true;
		result.point = point;
		result.normal = vector2.normalized;
		result.tangent = new Vector2(result.normal.y, 0f - result.normal.x).normalized;
		result.surfaceBodyType = rigidbodyType2D;
		float num4 = Mathf.Max(0f, num3 - wheelRadius);
		float num5 = Mathf.Clamp01((suspensionReach - num4) / suspensionReach);
		float num6 = Mathf.Clamp01((Vector2.Dot(result.normal, up) - 0.05f) / 0.35f);
		result.compression = num5 * num6;
		result.supportSource = ((rigidbodyType2D != RigidbodyType2D.Dynamic) ? VehiclePhysicsController.WheelSupportSource.Primary : VehiclePhysicsController.WheelSupportSource.Secondary);
		result.tangentVelocity = Vector2.Dot(rigidbody2D.GetPointVelocity(vector), result.tangent);
		return result;
	}

	protected virtual void ApplyCompressionHardLimits(ref WheelContactData frontContact, ref WheelContactData backContact, bool fireDriveStress)
	{
	}

	protected static float StepDriveAuthority(float current, float target, float riseRate, float fallRate, float dt)
	{
		if (!IsFinite(current))
		{
			current = 0f;
		}
		if (!IsFinite(target))
		{
			target = 0f;
		}
		current = Mathf.Clamp01(current);
		target = Mathf.Clamp01(target);
		float b = ((target >= current) ? riseRate : fallRate);
		float maxDelta = Mathf.Max(0.01f, b) * Mathf.Max(0.0001f, dt);
		return Mathf.MoveTowards(current, target, maxDelta);
	}

	protected static Vector2 ResolveSmoothedDriveAuthorityPair(float currentSupportRatio, float currentAlignmentRatio, float rawSupportRatio, float rawAlignmentRatio, float riseRate, float fallRate, float dt)
	{
		return new Vector2(StepDriveAuthority(currentSupportRatio, rawSupportRatio, riseRate, fallRate, dt), StepDriveAuthority(currentAlignmentRatio, rawAlignmentRatio, riseRate, fallRate, dt));
	}

	protected static float StepSignedCommand(float current, float target, float riseRate, float fallRate, float dt)
	{
		if (!IsFinite(current))
		{
			current = 0f;
		}
		if (!IsFinite(target))
		{
			target = 0f;
		}
		float num = Mathf.Max(0.0001f, dt);
		if (Mathf.Abs(target - current) <= 0.0001f)
		{
			return target;
		}
		float num2 = ((Mathf.Abs(current) > 0.0001f && Mathf.Sign(current) == Mathf.Sign(target)) ? 1f : 0f);
		float num3 = Mathf.Abs(target);
		float num4 = Mathf.Abs(current);
		bool flag = num3 > num4 + 0.0001f;
		float num5 = ((num2 > 0f && !flag) ? Mathf.Max(0f, fallRate) : Mathf.Max(0f, riseRate));
		if (num5 <= 0.0001f)
		{
			return target;
		}
		return Mathf.MoveTowards(current, target, num5 * num);
	}

	protected static float ResolveContinuousDistanceCommandSpeed(float distanceError, float holdDistance, float fullDistance, float maxSpeed)
	{
		float num = Mathf.Abs(distanceError);
		if (num <= 0.0001f || maxSpeed <= 0f)
		{
			return 0f;
		}
		float num2 = Mathf.Max(0.01f, holdDistance);
		float num3 = Mathf.Max(num2, fullDistance);
		float num4 = Mathf.Clamp01(num2 / num3);
		float num5;
		if (num < num2)
		{
			num5 = num4 * Mathf.Clamp01(num / num2);
		}
		else
		{
			float t = Mathf.InverseLerp(num2, num3, num);
			num5 = Mathf.Lerp(num4, 1f, t);
		}
		return Mathf.Sign(distanceError) * maxSpeed * num5;
	}

	protected static float ResolveClosingDistanceCommandSpeed(float distanceToTarget, float preferredDistance, float fullDistance, float maxSpeed)
	{
		float num = Mathf.Max(0f, distanceToTarget);
		if (maxSpeed <= 0f)
		{
			return 0f;
		}
		float num2 = Mathf.Max(0.01f, preferredDistance);
		float num3 = Mathf.Max(num2, fullDistance);
		float num4 = Mathf.Clamp01(num2 / num3);
		float num7;
		if (num < num2)
		{
			float num5 = Mathf.Clamp01(num / num2);
			float num6 = num5 * num5 * (3f - 2f * num5);
			num7 = num4 * num6;
		}
		else
		{
			float t = Mathf.InverseLerp(num2, num3, num);
			num7 = Mathf.Lerp(num4, 1f, t);
		}
		return maxSpeed * num7;
	}

	protected static float ResolveSignedLongitudinalSurfaceGap(Bounds selfBounds, Bounds targetBounds, float fallbackDeltaX)
	{
		float num = ((Mathf.Abs(fallbackDeltaX) > 0.0001f) ? Mathf.Sign(fallbackDeltaX) : 0f);
		if (num == 0f)
		{
			return 0f;
		}
		if (num > 0f)
		{
			float b = targetBounds.min.x - selfBounds.max.x;
			return Mathf.Max(0f, b);
		}
		float b2 = selfBounds.min.x - targetBounds.max.x;
		return 0f - Mathf.Max(0f, b2);
	}

	protected float ResolveTargetSurfaceGapX(Transform target)
	{
		if (target == null)
		{
			return 0f;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ResolveTargetSurfaceGapX");
		PolygonCollider2D component = GetComponent<PolygonCollider2D>();
		Collider2D component2 = target.GetComponent<Collider2D>();
		if (component == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing self collider while resolving target surface gap on " + base.name);
		}
		if (component2 == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing target collider while resolving target surface gap on " + base.name);
		}
		return ResolveSignedLongitudinalSurfaceGap(fallbackDeltaX: target.position.x - rigidbody2D.position.x, selfBounds: component.bounds, targetBounds: component2.bounds);
	}

	protected static float ResolveLatchedDirectionSign(float currentSign, float deltaX, float holdDistance, float commitDistance, float fallbackSign)
	{
		float num = ((Mathf.Abs(currentSign) > 0.0001f) ? Mathf.Sign(currentSign) : 0f);
		float result = ((Mathf.Abs(fallbackSign) > 0.0001f) ? Mathf.Sign(fallbackSign) : 1f);
		float num2 = Mathf.Max(0.01f, holdDistance);
		float num3 = Mathf.Max(num2, commitDistance);
		float num4 = Mathf.Abs(deltaX);
		if (num4 <= num2)
		{
			if (num == 0f)
			{
				return result;
			}
			return num;
		}
		float num5 = ((deltaX >= 0f) ? 1f : (-1f));
		if (num == 0f)
		{
			return num5;
		}
		if (num5 == num)
		{
			return num;
		}
		if (!(num4 >= num3))
		{
			return num;
		}
		return num5;
	}

	protected static float ResolveReversalAwareDesiredSpeed(float currentDriveSpeed, float desiredDriveSpeed)
	{
		RequireFiniteValue(currentDriveSpeed, "ResolveReversalAwareDesiredSpeed.currentDriveSpeed");
		RequireFiniteValue(desiredDriveSpeed, "ResolveReversalAwareDesiredSpeed.desiredDriveSpeed");
		if (!(currentDriveSpeed * desiredDriveSpeed < 0f))
		{
			return desiredDriveSpeed;
		}
		return 0f;
	}

	protected static float ResolveStoppingAccelerationCap(float currentSpeedMagnitude, float stoppingDistance, float fallbackCap)
	{
		RequireFiniteValue(currentSpeedMagnitude, "ResolveStoppingAccelerationCap.currentSpeedMagnitude");
		RequireFiniteValue(stoppingDistance, "ResolveStoppingAccelerationCap.stoppingDistance");
		RequireFiniteValue(fallbackCap, "ResolveStoppingAccelerationCap.fallbackCap");
		float num = Mathf.Max(0.05f, stoppingDistance);
		float max = Mathf.Max(0f, fallbackCap);
		return Mathf.Clamp(currentSpeedMagnitude * currentSpeedMagnitude / (2f * num), 0f, max);
	}

	protected static float ResolveSmoothedDriveAccelerationCommand(float currentAcceleration, float desiredDriveSpeed, float currentDriveSpeed, float controlGain, float maxAcceleration, float riseRate, float fallRate, float dt)
	{
		RequireFiniteValue(currentAcceleration, "ResolveSmoothedDriveAccelerationCommand.currentAcceleration");
		RequireFiniteValue(desiredDriveSpeed, "ResolveSmoothedDriveAccelerationCommand.desiredDriveSpeed");
		RequireFiniteValue(currentDriveSpeed, "ResolveSmoothedDriveAccelerationCommand.currentDriveSpeed");
		RequireFiniteValue(controlGain, "ResolveSmoothedDriveAccelerationCommand.controlGain");
		RequireFiniteValue(maxAcceleration, "ResolveSmoothedDriveAccelerationCommand.maxAcceleration");
		float num = Mathf.Max(0f, controlGain);
		float num2 = Mathf.Max(0f, maxAcceleration);
		if (num <= 0.0001f || num2 <= 0.0001f)
		{
			return StepSignedCommand(currentAcceleration, 0f, Mathf.Max(4f, riseRate), Mathf.Max(10f, fallRate), dt);
		}
		float target = Mathf.Clamp((desiredDriveSpeed - currentDriveSpeed) * num, 0f - num2, num2);
		return StepSignedCommand(currentAcceleration, target, riseRate, fallRate, dt);
	}

	protected static float ResolveNormalizedAccelerationCommand(float acceleration, float referenceAcceleration)
	{
		RequireFiniteValue(acceleration, "ResolveNormalizedAccelerationCommand.acceleration");
		RequireFiniteValue(referenceAcceleration, "ResolveNormalizedAccelerationCommand.referenceAcceleration");
		float num = Mathf.Max(0f, referenceAcceleration);
		if (num <= 0.0001f)
		{
			return 0f;
		}
		return Mathf.Clamp(acceleration / num, -1f, 1f);
	}

	protected static Vector2 ResolveLongitudinalDriveSpeeds(Vector2 currentVelocity, Vector2 driveAxis, float targetSpeedX)
	{
		RequireFiniteValue(currentVelocity, "ResolveLongitudinalDriveSpeeds.currentVelocity");
		RequireFiniteValue(driveAxis, "ResolveLongitudinalDriveSpeeds.driveAxis");
		RequireFiniteValue(targetSpeedX, "ResolveLongitudinalDriveSpeeds.targetSpeedX");
		if (driveAxis.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Drive axis is invalid during longitudinal speed resolution.");
		}
		Vector2 normalized = driveAxis.normalized;
		float x = Vector2.Dot(currentVelocity, normalized);
		float num = ((Mathf.Abs(normalized.x) > 0.0001f) ? Mathf.Sign(normalized.x) : 1f);
		float y = targetSpeedX * num * Mathf.Abs(normalized.x);
		return new Vector2(x, y);
	}

	protected static Vector2 ResolveDriveAccelerationStepRates(float maxAcceleration)
	{
		float num = Mathf.Max(0f, maxAcceleration);
		float num2 = Mathf.Max(0.5f, num * 2f);
		float y = Mathf.Max(num2, num * 3f);
		return new Vector2(num2, y);
	}

	protected static float ResolveCloseRangeControlScale(float surfaceGapAbsX, float preferredDistance)
	{
		RequireFiniteValue(surfaceGapAbsX, "ResolveCloseRangeControlScale.surfaceGapAbsX");
		RequireFiniteValue(preferredDistance, "ResolveCloseRangeControlScale.preferredDistance");
		float num = Mathf.Max(0.05f, preferredDistance);
		float num2 = Mathf.Max(0.04f, num * 0.55f);
		float b = Mathf.Max(num2 + 0.25f, num * 1.4f);
		float num3 = Mathf.InverseLerp(num2, b, Mathf.Max(0f, surfaceGapAbsX));
		float t = num3 * num3 * (3f - 2f * num3);
		return Mathf.Lerp(0.35f, 1f, t);
	}

	protected static float ResolveHardSupportAuthorityGate(float rawSupportRatio)
	{
		RequireFiniteValue(rawSupportRatio, "ResolveHardSupportAuthorityGate.rawSupportRatio");
		return Mathf.Clamp01(Mathf.InverseLerp(0.02f, 0.18f, rawSupportRatio));
	}

	protected static float ResolveCounterMotionRecoveryScale(float currentDriveSpeed, float desiredDriveSpeed, float referenceSpeed)
	{
		RequireFiniteValue(currentDriveSpeed, "ResolveCounterMotionRecoveryScale.currentDriveSpeed");
		RequireFiniteValue(desiredDriveSpeed, "ResolveCounterMotionRecoveryScale.desiredDriveSpeed");
		RequireFiniteValue(referenceSpeed, "ResolveCounterMotionRecoveryScale.referenceSpeed");
		if (Mathf.Abs(desiredDriveSpeed) <= 0.0001f || currentDriveSpeed * desiredDriveSpeed >= 0f)
		{
			return 1f;
		}
		float num = Mathf.Max(0.25f, referenceSpeed);
		float num2 = Mathf.Clamp01(Mathf.Abs(currentDriveSpeed) / num);
		float t = Mathf.Clamp01(Mathf.Abs(desiredDriveSpeed) / num);
		float t2 = num2 * Mathf.Lerp(0.35f, 1f, t);
		return Mathf.Lerp(1f, 1.8f, t2);
	}

	protected float ResolveDrivePostureTractionScale(WheelContactData frontContact, WheelContactData backContact)
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ResolveDrivePostureTractionScale");
		Vector2 lhs = rigidbody2D.transform.up;
		if (lhs.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Vehicle up axis is invalid while resolving drive posture traction.");
		}
		lhs.Normalize();
		float value = Vector2.Dot(lhs, Vector2.up);
		float num = Mathf.Clamp01(Mathf.InverseLerp(0.1f, 0.75f, value));
		float supportUpScore = 0f;
		float supportWeight = 0f;
		AccumulateDriveSupportUp(frontContact, rigidbody2D, ref supportUpScore, ref supportWeight);
		AccumulateDriveSupportUp(backContact, rigidbody2D, ref supportUpScore, ref supportWeight);
		float t = ((supportWeight > 0f) ? Mathf.Clamp01(supportUpScore / supportWeight) : 0f);
		return num * Mathf.Lerp(0.35f, 1f, t);
	}

	private void AccumulateDriveSupportUp(WheelContactData contact, Rigidbody2D body, ref float supportUpScore, ref float supportWeight)
	{
		if (IsDriveSupportContact(in contact, body))
		{
			float num = Mathf.Clamp(contact.compression, 0.2f, 1f);
			float num2 = Mathf.Clamp01(Mathf.InverseLerp(0.35f, 1f, contact.normal.y));
			supportUpScore += num2 * num;
			supportWeight += num;
		}
	}

	protected float ResolveDirectionCommitDistance(float holdDistance)
	{
		float b = Mathf.Abs(frontWheelLocal.x - backWheelLocal.x) * 0.5f;
		return Mathf.Max(Mathf.Max(0.05f, holdDistance), Mathf.Max(0.15f, b));
	}

	protected abstract float ResolveFacingDirection();

	protected virtual float GetWheelVisualTravelMultiplier()
	{
		if (bodyType != SummerRaceBodyType.Heavy)
		{
			if (bodyType != SummerRaceBodyType.Light)
			{
				return 1.03f;
			}
			return 0.96f;
		}
		return 1.12f;
	}

	protected virtual void GetWheelVisualSpringDamping(out float springMul, out float dampingMul)
	{
		if (bodyType == SummerRaceBodyType.Heavy)
		{
			springMul = 1.02f;
			dampingMul = 1.02f;
		}
		else if (bodyType == SummerRaceBodyType.Light)
		{
			springMul = 1.05f;
			dampingMul = 0.92f;
		}
		else
		{
			springMul = 1.06f;
			dampingMul = 0.96f;
		}
	}

	protected static void RotateWheelVisual(Transform wheelRoot, float deltaZ)
	{
		if (!(wheelRoot == null))
		{
			Transform transform = wheelRoot.Find("Visual");
			if (transform == null)
			{
				throw new InvalidOperationException("[SummerRace] Wheel visual root is missing.");
			}
			Transform transform2 = transform.Find("SummerRaceWheelVisual");
			Transform obj = ((transform2 != null) ? transform2 : transform).Find("InnerTireVisual");
			if (obj == null)
			{
				throw new InvalidOperationException("[SummerRace] Wheel inner rotor is missing.");
			}
			obj.Rotate(0f, 0f, deltaZ, Space.Self);
		}
	}

	protected static void SyncWheelVisualSortingToBody(Transform wheelVisualRoot, SkeletonAnimation bodySkeletonAnimation, string context)
	{
		if (wheelVisualRoot == null || bodySkeletonAnimation == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing refs for wheel sorting sync. context=" + context);
		}
		MeshRenderer component = bodySkeletonAnimation.GetComponent<MeshRenderer>();
		if (component == null)
		{
			throw new InvalidOperationException("[SummerRace] Body mesh renderer is missing for wheel sorting sync. context=" + context);
		}
		int sortingLayerID = component.sortingLayerID;
		Transform transform = wheelVisualRoot.Find("SummerRaceWheelVisual");
		Transform obj = ((transform != null) ? transform : wheelVisualRoot);
		SpriteRenderer component2 = obj.GetComponent<SpriteRenderer>();
		if (component2 != null)
		{
			component2.sortingLayerID = sortingLayerID;
			component2.forceRenderingOff = false;
		}
		Transform transform2 = obj.Find("InnerTireVisual");
		if (transform2 != null)
		{
			SpriteRenderer component3 = transform2.GetComponent<SpriteRenderer>();
			if (component3 != null)
			{
				component3.sortingLayerID = sortingLayerID;
				component3.forceRenderingOff = false;
			}
		}
		SkeletonAnimation component4 = wheelVisualRoot.GetComponent<SkeletonAnimation>();
		if (component4 != null)
		{
			MeshRenderer component5 = component4.GetComponent<MeshRenderer>();
			if (component5 != null)
			{
				component5.sortingLayerID = sortingLayerID;
				component5.forceRenderingOff = false;
			}
		}
	}

	protected static void BindBodySkeletonAnimation(Transform visualRoot, ref SkeletonAnimation skeletonAnimation, SkeletonDataAsset skeletonDataAsset, int sortingOrder, string context, string[] bodySkinStack)
	{
		if (visualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing skeleton visual root. context=" + context);
		}
		if (skeletonDataAsset == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing skeleton data asset. context=" + context);
		}
		SpriteRenderer component = visualRoot.GetComponent<SpriteRenderer>();
		if (component != null)
		{
			component.enabled = false;
			UnityEngine.Object.Destroy(component);
		}
		if (skeletonAnimation == null)
		{
			skeletonAnimation = visualRoot.GetComponent<SkeletonAnimation>();
			if (skeletonAnimation == null)
			{
				skeletonAnimation = visualRoot.gameObject.AddComponent<SkeletonAnimation>();
			}
		}
		skeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		skeletonAnimation.Initialize(overwrite: true);
		ApplyBattleBodyVisualContract(skeletonAnimation, context, bodySkinStack);
		MeshRenderer component2 = skeletonAnimation.GetComponent<MeshRenderer>();
		if (component2 == null)
		{
			throw new InvalidOperationException("[SummerRace] SkeletonAnimation MeshRenderer is missing. context=" + context);
		}
		component2.sortingOrder = sortingOrder;
		component2.enabled = true;
	}

	protected static float FitBodySkeletonVisualToTargetSize(Transform visualRoot, SkeletonAnimation skeletonAnimation, Vector2 targetSize, string context)
	{
		if (visualRoot == null || skeletonAnimation == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing body visual refs for size fit. context=" + context);
		}
		if (targetSize.x <= 0.0001f || targetSize.y <= 0.0001f)
		{
			Vector2 vector = targetSize;
			throw new InvalidOperationException("[SummerRace] Invalid body visual target size. context=" + context + " target=" + vector.ToString());
		}
		GetSkeletonLocalBounds(skeletonAnimation, context, out var _, out var size);
		float x = size.x;
		float y = size.y;
		if (x <= 0.0001f || y <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Invalid body visual bounds for size fit. context=" + context + " localBounds=(" + x + "," + y + ")");
		}
		float num = Mathf.Min(targetSize.x / x, targetSize.y / y);
		if (!IsFinite(num) || num <= 0.0001f)
		{
			string[] obj = new string[11]
			{
				"[SummerRace] Invalid body fit scale. context=",
				context,
				" fitScale=",
				num.ToString(),
				" target=",
				null,
				null,
				null,
				null,
				null,
				null
			};
			Vector2 vector = targetSize;
			obj[5] = vector.ToString();
			obj[6] = " localBounds=(";
			obj[7] = x.ToString();
			obj[8] = ",";
			obj[9] = y.ToString();
			obj[10] = ")";
			throw new InvalidOperationException(string.Concat(obj));
		}
		Vector3 localScale = visualRoot.localScale;
		visualRoot.localScale = new Vector3(localScale.x * num, localScale.y * num, localScale.z);
		return num;
	}

	protected static Vector2 FitBodyAuthoringPointToBodySkeletonBounds(Transform bodyVisualRoot, SkeletonAnimation skeletonAnimation, PolygonCollider2D collider, Vector2 sourcePoint, Vector2[] sourcePath, string context)
	{
		BodySkeletonBoundsFit fit = ResolveBodySkeletonBoundsFit(bodyVisualRoot, skeletonAnimation, collider, sourcePath, context);
		return ApplyBodySkeletonBoundsFit(sourcePoint, fit);
	}

	private static BodySkeletonBoundsFit ResolveBodySkeletonBoundsFit(Transform bodyVisualRoot, SkeletonAnimation skeletonAnimation, PolygonCollider2D collider, Vector2[] sourcePath, string context)
	{
		if (bodyVisualRoot == null || skeletonAnimation == null || collider == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing refs for body bounds fit. context=" + context);
		}
		if (sourcePath == null || sourcePath.Length < 3)
		{
			throw new InvalidOperationException("[SummerRace] Invalid source collider path for body bounds fit. context=" + context);
		}
		GetSkeletonLocalBounds(skeletonAnimation, context, out var center, out var size);
		Vector3 vector = new Vector3(center.x - size.x * 0.5f, center.y - size.y * 0.5f, 0f);
		Vector3 vector2 = new Vector3(center.x + size.x * 0.5f, center.y + size.y * 0.5f, 0f);
		Vector3[] worldCorners = new Vector3[4]
		{
			bodyVisualRoot.TransformPoint(new Vector3(vector.x, vector.y, 0f)),
			bodyVisualRoot.TransformPoint(new Vector3(vector.x, vector2.y, 0f)),
			bodyVisualRoot.TransformPoint(new Vector3(vector2.x, vector.y, 0f)),
			bodyVisualRoot.TransformPoint(new Vector3(vector2.x, vector2.y, 0f))
		};
		ComputeTransformedBoundsInLocalSpace(collider.transform, worldCorners, out var _, out var size2);
		float x = size2.x;
		float y = size2.y;
		if (x <= 0.0001f || y <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Invalid target bounds for body bounds fit. context=" + context + " targetSize=(" + x + "," + y + ")");
		}
		ComputePathBounds(sourcePath, out var center3, out var size3);
		if (size3.x <= 0.0001f || size3.y <= 0.0001f)
		{
			Vector2 vector3 = size3;
			throw new InvalidOperationException("[SummerRace] Invalid source bounds for body bounds fit. context=" + context + " sourceSize=" + vector3.ToString());
		}
		float num = x / size3.x;
		float num2 = y / size3.y;
		if (!IsFinite(num) || !IsFinite(num2) || num <= 0.0001f || num2 <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Invalid body bounds fit scales. context=" + context + " scaleX=" + num + " scaleY=" + num2);
		}
		return new BodySkeletonBoundsFit
		{
			SourceCenter = center3,
			TargetCenter = center3,
			ScaleX = num,
			ScaleY = num2
		};
	}

	protected static Vector2[] FitColliderPathToBodySkeletonBounds(Transform bodyVisualRoot, SkeletonAnimation skeletonAnimation, PolygonCollider2D collider, Vector2[] sourcePath, string context)
	{
		BodySkeletonBoundsFit fit = ResolveBodySkeletonBoundsFit(bodyVisualRoot, skeletonAnimation, collider, sourcePath, context);
		Vector2[] array = new Vector2[sourcePath.Length];
		for (int i = 0; i < sourcePath.Length; i++)
		{
			array[i] = ApplyBodySkeletonBoundsFit(sourcePath[i], fit);
		}
		return array;
	}

	protected static Vector2[] OffsetColliderPath(Vector2[] path, Vector2 offset, string context)
	{
		if (path == null || path.Length < 3)
		{
			throw new InvalidOperationException("[SummerRace] Invalid collider path for offset. context=" + context);
		}
		Vector2[] array = new Vector2[path.Length];
		for (int i = 0; i < path.Length; i++)
		{
			array[i] = path[i] + offset;
		}
		return array;
	}

	protected static Vector2 ApplyBodySkeletonBoundsFit(Vector2 sourcePoint, BodySkeletonBoundsFit fit)
	{
		return new Vector2((sourcePoint.x - fit.SourceCenter.x) * fit.ScaleX + fit.TargetCenter.x, (sourcePoint.y - fit.SourceCenter.y) * fit.ScaleY + fit.TargetCenter.y);
	}

	private static void ComputePathBounds(IReadOnlyList<Vector2> path, out Vector2 center, out Vector2 size)
	{
		float num = path[0].x;
		float num2 = path[0].x;
		float num3 = path[0].y;
		float num4 = path[0].y;
		for (int i = 1; i < path.Count; i++)
		{
			Vector2 vector = path[i];
			num = Mathf.Min(num, vector.x);
			num2 = Mathf.Max(num2, vector.x);
			num3 = Mathf.Min(num3, vector.y);
			num4 = Mathf.Max(num4, vector.y);
		}
		center = new Vector2((num + num2) * 0.5f, (num3 + num4) * 0.5f);
		size = new Vector2(num2 - num, num4 - num3);
	}

	private static void GetSkeletonLocalBounds(SkeletonAnimation skeletonAnimation, string context, out Vector2 center, out Vector2 size)
	{
		if (skeletonAnimation == null || skeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing skeleton for bounds query. context=" + context);
		}
		float x = 0f;
		float y = 0f;
		float width = 0f;
		float height = 0f;
		float[] vertexBuffer = null;
		skeletonAnimation.Skeleton.UpdateWorldTransform();
		skeletonAnimation.Skeleton.GetBounds(out x, out y, out width, out height, ref vertexBuffer);
		center = new Vector2(x + width * 0.5f, y + height * 0.5f);
		size = new Vector2(width, height);
	}

	private static void ComputeTransformedBoundsInLocalSpace(Transform localTarget, IReadOnlyList<Vector3> worldCorners, out Vector2 center, out Vector2 size)
	{
		Vector3 vector = localTarget.InverseTransformPoint(worldCorners[0]);
		float num = vector.x;
		float num2 = vector.x;
		float num3 = vector.y;
		float num4 = vector.y;
		for (int i = 1; i < worldCorners.Count; i++)
		{
			Vector3 vector2 = localTarget.InverseTransformPoint(worldCorners[i]);
			num = Mathf.Min(num, vector2.x);
			num2 = Mathf.Max(num2, vector2.x);
			num3 = Mathf.Min(num3, vector2.y);
			num4 = Mathf.Max(num4, vector2.y);
		}
		center = new Vector2((num + num2) * 0.5f, (num3 + num4) * 0.5f);
		size = new Vector2(num2 - num, num4 - num3);
	}

	protected static void BindWheelVisualSprites(Transform visualRoot, Sprite outerSprite, Sprite innerSprite, int outerSortingOrder, int innerSortingOrder, Vector3 innerTireVisualLocalPosition, string context)
	{
		if (visualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing wheel visual root. context=" + context);
		}
		ResolveWheelVisualPrefabTemplateOrThrow(out outerSprite, out innerSprite, out var _, out var _, context);
		SkeletonAnimation component = visualRoot.GetComponent<SkeletonAnimation>();
		if (component != null)
		{
			UnityEngine.Object.Destroy(component);
		}
		MeshRenderer component2 = visualRoot.GetComponent<MeshRenderer>();
		if (component2 != null)
		{
			UnityEngine.Object.Destroy(component2);
		}
		MeshFilter component3 = visualRoot.GetComponent<MeshFilter>();
		if (component3 != null)
		{
			UnityEngine.Object.Destroy(component3);
		}
		for (int num = visualRoot.childCount - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(visualRoot.GetChild(num).gameObject);
		}
		GameObject gameObject = SummerRaceConfigLoader.LoadWheelVisualPrefabOrThrow(context);
		GameObject obj = UnityEngine.Object.Instantiate(gameObject, visualRoot);
		obj.name = gameObject.name;
		Transform obj2 = obj.transform;
		obj2.localPosition = Vector3.zero;
		obj2.localRotation = Quaternion.identity;
		obj2.localScale = Vector3.one;
		SetLayerRecursively(obj2, visualRoot.gameObject.layer);
		SpriteRenderer component4 = obj2.GetComponent<SpriteRenderer>();
		if (component4 == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab instance missing outer SpriteRenderer. context=" + context);
		}
		if (component4.sprite == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab instance missing outer sprite. context=" + context);
		}
		if (component4.sharedMaterial == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab instance missing outer material. context=" + context);
		}
		Transform transform = obj2.Find("InnerTireVisual");
		SpriteRenderer obj3 = ((transform != null) ? transform.GetComponent<SpriteRenderer>() : null);
		if (obj3 == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab instance missing InnerTireVisual SpriteRenderer. context=" + context);
		}
		if (obj3.sprite == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab instance missing inner sprite. context=" + context);
		}
		if (obj3.sharedMaterial == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab instance missing inner material. context=" + context);
		}
		component4.sprite = outerSprite;
		component4.sortingOrder = outerSortingOrder;
		component4.enabled = true;
		component4.forceRenderingOff = false;
		transform.localPosition = innerTireVisualLocalPosition;
		transform.localRotation = Quaternion.identity;
		transform.localScale = Vector3.one;
		obj3.sprite = innerSprite;
		obj3.sortingOrder = innerSortingOrder;
		obj3.enabled = true;
		obj3.forceRenderingOff = false;
	}

	private static void ResolveWheelVisualPrefabTemplateOrThrow(out Sprite outerSprite, out Sprite innerSprite, out Material outerMaterial, out Material innerMaterial, string context)
	{
		SummerRaceConfigLoader.LoadWheelVisualTemplateOrThrow(out outerSprite, out innerSprite, out outerMaterial, out innerMaterial, context);
	}

	private static void SetLayerRecursively(Transform root, int layer)
	{
		if (!(root == null))
		{
			root.gameObject.layer = layer;
			for (int i = 0; i < root.childCount; i++)
			{
				SetLayerRecursively(root.GetChild(i), layer);
			}
		}
	}

	protected static Vector3 ResolveWheelVisualScaleForRadius(Sprite wheelOuterSprite, float wheelRadius, float fallbackZ, string context)
	{
		if (wheelOuterSprite == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing wheel outer sprite while resolving visual scale. context=" + context);
		}
		Vector2 vector = wheelOuterSprite.bounds.size;
		if (vector.x <= 0f || vector.y <= 0f)
		{
			throw new InvalidOperationException("[SummerRace] Invalid wheel outer sprite bounds while resolving visual scale. context=" + context + " sprite=" + wheelOuterSprite.name);
		}
		float num = Mathf.Max(0.01f, Mathf.Max(0.05f, wheelRadius) * 2f);
		float z = ((Mathf.Abs(fallbackZ) > 0.0001f) ? fallbackZ : 1f);
		return new Vector3(num / vector.x, num / vector.y, z);
	}

	protected void LogWheelVisualRendererState(Transform visualRoot, string context)
	{
		if (IsRuntimeDebugLogEnabled && !(visualRoot == null))
		{
			Transform transform = visualRoot.Find("SummerRaceWheelVisual");
			Transform obj = ((transform != null) ? transform : visualRoot);
			SpriteRenderer component = obj.GetComponent<SpriteRenderer>();
			Transform transform2 = obj.Find("InnerTireVisual");
			SpriteRenderer renderer = ((transform2 != null) ? transform2.GetComponent<SpriteRenderer>() : null);
			SummerRaceRuntimeLog.Log("[SummerRace][WheelRendererState] context=" + context + " visualActive=" + visualRoot.gameObject.activeInHierarchy + " visualLocalScale=" + visualRoot.localScale.ToString("F4") + " visualLossyScale=" + visualRoot.lossyScale.ToString("F4") + " outer=" + FormatWheelRendererState(component) + " inner=" + FormatWheelRendererState(renderer));
		}
	}

	private static string FormatWheelRendererState(SpriteRenderer renderer)
	{
		if (renderer == null)
		{
			return "null";
		}
		Sprite sprite = renderer.sprite;
		return "enabled=" + renderer.enabled + ",forceOff=" + renderer.forceRenderingOff + ",sprite=" + ((sprite != null) ? sprite.name : "null") + ",colorA=" + renderer.color.a.ToString("F3") + ",sortingLayer=" + renderer.sortingLayerName + ",sortingOrder=" + renderer.sortingOrder + ",boundsSize=" + renderer.bounds.size.ToString("F4");
	}

	protected static void BindWheelVisualSpine(Transform visualRoot, ref SkeletonAnimation skeletonAnimation, SkeletonDataAsset skeletonDataAsset, int sortingOrder, string context)
	{
		if (visualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing wheel visual root. context=" + context);
		}
		if (skeletonDataAsset == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing wheel skeleton data asset. context=" + context);
		}
		Transform transform = visualRoot.Find("InnerTireVisual");
		if (transform != null)
		{
			UnityEngine.Object.Destroy(transform.gameObject);
		}
		SpriteRenderer component = visualRoot.GetComponent<SpriteRenderer>();
		if (component != null)
		{
			component.enabled = false;
			UnityEngine.Object.Destroy(component);
		}
		if (skeletonAnimation == null)
		{
			skeletonAnimation = visualRoot.GetComponent<SkeletonAnimation>();
			if (skeletonAnimation == null)
			{
				skeletonAnimation = visualRoot.gameObject.AddComponent<SkeletonAnimation>();
			}
		}
		skeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		skeletonAnimation.Initialize(overwrite: true);
		MeshRenderer component2 = skeletonAnimation.GetComponent<MeshRenderer>();
		if (component2 == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel SkeletonAnimation MeshRenderer is missing. context=" + context);
		}
		component2.sortingOrder = sortingOrder;
		component2.enabled = true;
	}

	private static void ApplyBattleBodyVisualContract(SkeletonAnimation skeletonAnimation, string context, string[] skinStack)
	{
		if (skeletonAnimation == null)
		{
			throw new InvalidOperationException("[SummerRace] SkeletonAnimation is missing. context=" + context);
		}
		Skeleton skeleton = skeletonAnimation.Skeleton;
		SkeletonData skeletonData = ((skeletonAnimation.skeletonDataAsset != null) ? skeletonAnimation.skeletonDataAsset.GetSkeletonData(quiet: false) : null);
		if (skeleton == null || skeletonData == null)
		{
			throw new InvalidOperationException("[SummerRace] Skeleton runtime data is missing. context=" + context);
		}
		Skin skin = new Skin("SummerRaceBattleBodySkin");
		skin.AddSkin(ResolveBodyBaseSkinOrThrow(skeletonData, context));
		string[] array = ((skinStack != null && skinStack.Length != 0) ? skinStack : BattleBodyBaseSkinStack);
		for (int i = 0; i < array.Length; i++)
		{
			Skin skin2 = skeletonData.FindSkin(array[i]);
			if (skin2 == null)
			{
				throw new InvalidOperationException("[SummerRace] Missing battle body skin '" + array[i] + "'. context=" + context);
			}
			skin.AddSkin(skin2);
		}
		skeleton.SetSkin(skin);
		skeleton.SetSlotsToSetupPose();
		ClearSkeletonSlots(skeleton, BodyWheelSlotNames);
		skeleton.UpdateWorldTransform();
		skeletonAnimation.LateUpdate();
	}

	private static Skin ResolveBodyBaseSkinOrThrow(SkeletonData skeletonData, string context)
	{
		return skeletonData.FindSkin("default") ?? throw new InvalidOperationException("[SummerRace] Missing battle body base skin 'default'. context=" + context);
	}

	private static void ClearSkeletonSlots(Skeleton skeleton, HashSet<string> slotNames)
	{
		for (int i = 0; i < skeleton.Slots.Count; i++)
		{
			Slot slot = skeleton.Slots.Items[i];
			if (slotNames.Contains(slot.Data.Name))
			{
				slot.Attachment = null;
			}
		}
	}

	protected virtual Vector2 ResolveWheelVisualWorldPos(Vector2 wheelLocal, float wheelRadius, WheelContactData contact, Vector2 cachedWorld, ref float yVelocity, ref bool initialized, float dt)
	{
		Vector2 vector = base.transform.TransformPoint(wheelLocal);
		if (!IsFinite(vector))
		{
			if (Application.isPlaying)
			{
				throw new InvalidOperationException("[SummerRace] Wheel visual base position is invalid during runtime visual sync.");
			}
			if (!IsFinite(cachedWorld))
			{
				return Vector2.zero;
			}
			return cachedWorld;
		}
		Vector2 value = -(Vector2)base.transform.up;
		if (!IsFinite(value) || value.sqrMagnitude <= 0.0001f)
		{
			if (Application.isPlaying)
			{
				throw new InvalidOperationException("[SummerRace] Suspension axis is invalid during runtime visual sync.");
			}
			value = Vector2.down;
		}
		value = value.normalized;
		float num = Mathf.Max(0.0001f, GetSuspensionReach(wheelRadius));
		float num2 = 0f;
		float num3 = Mathf.Lerp(num, num2, Mathf.Clamp01(spawnCompressionNormalized));
		float num4 = (IsFinite(contact.compression) ? Mathf.Clamp01(contact.compression) : 0f);
		Rigidbody2D body = (Application.isPlaying ? RequirePhysicsBodyReady("ResolveWheelVisualWorldPos") : null);
		bool flag = contact.hasContact && num4 > 0.0001f;
		bool num5;
		if (!Application.isPlaying)
		{
			if (contact.hasContact && contact.normal.sqrMagnitude > 0.0001f)
			{
				num5 = contact.normal.normalized.y >= wheelVisualSupportMinNormalY;
				goto IL_0170;
			}
		}
		else if (flag)
		{
			if (!IsSupportContact(in contact, wheelVisualSupportMinNormalY, body))
			{
				num5 = contact.surfaceBodyType == RigidbodyType2D.Dynamic;
				goto IL_0170;
			}
			goto IL_0181;
		}
		goto IL_0172;
		IL_0181:
		float num6 = Mathf.Lerp(num, num2, num4);
		goto IL_018a;
		IL_0172:
		num6 = (ShouldUseWheelVisualSpawnRestPose() ? num3 : num);
		goto IL_018a;
		IL_0170:
		if (!num5)
		{
			goto IL_0172;
		}
		goto IL_0181;
		IL_018a:
		float value2 = num6;
		value2 = Mathf.Clamp(value2, num2, num);
		if (!initialized || !IsFinite(cachedWorld) || !IsFinite(yVelocity))
		{
			cachedWorld = vector + value * value2;
			yVelocity = 0f;
			initialized = true;
		}
		float num7;
		if (IsFinite(dt))
		{
			num7 = Mathf.Max(0.0001f, dt);
		}
		else
		{
			if (Application.isPlaying)
			{
				throw new InvalidOperationException("[SummerRace] Wheel visual deltaTime is invalid during runtime visual sync.");
			}
			num7 = 0.0001f;
		}
		GetWheelVisualSpringDamping(out var springMul, out var dampingMul);
		float num8 = Mathf.Max(6f, wheelVisualSpring * Mathf.Max(0.25f, springMul));
		float num9 = Mathf.Max(2f, wheelVisualDamping * Mathf.Max(0.25f, dampingMul) + wheelVisualFollowRate * 0.12f);
		float t = Mathf.Clamp01((wheelRadius - Mathf.Max(0.05f, largeWheelBoostRadiusStart)) / Mathf.Max(0.01f, largeWheelBoostRadiusRange));
		num8 *= Mathf.Lerp(1f, Mathf.Max(1f, largeWheelVisualSpringBoost), t);
		num9 *= Mathf.Lerp(1f, Mathf.Max(1f, largeWheelVisualDampingBoost), t);
		float value3 = Vector2.Dot(cachedWorld - vector, value);
		if (!IsFinite(value3))
		{
			value3 = value2;
			yVelocity = 0f;
		}
		value3 = Mathf.Clamp(value3, num2, num);
		float num10 = value2 - value3;
		yVelocity += num10 * num8 * num7;
		yVelocity *= Mathf.Exp((0f - num9) * num7);
		value3 += yVelocity * num7;
		value3 = Mathf.Clamp(value3, num2, num);
		if (!IsFinite(value3))
		{
			value3 = value2;
			yVelocity = 0f;
		}
		value3 = ResolveWheelVisualLengthDepenetration(vector, value, contact, wheelRadius, value3, num2, num, ref yVelocity);
		if (!IsFinite(yVelocity))
		{
			yVelocity = 0f;
		}
		cachedWorld = vector + value * value3;
		return cachedWorld;
	}

	protected virtual bool ShouldUseWheelVisualSpawnRestPose()
	{
		if (Application.isPlaying && SummerRaceFightManager.Instance != null)
		{
			return !SummerRaceFightManager.Instance.IsBattleActive;
		}
		return false;
	}

	private float ResolveWheelVisualLengthDepenetration(Vector2 baseWorld, Vector2 suspensionDir, WheelContactData contact, float wheelRadius, float currentLength, float minLength, float maxLength, ref float yVelocity)
	{
		if (!contact.hasContact || !IsFinite(contact.point) || !IsFinite(contact.normal) || contact.normal.sqrMagnitude <= 0.0001f)
		{
			return currentLength;
		}
		Vector2 vector = baseWorld + suspensionDir * currentLength;
		Vector2 vector2 = contact.normal.normalized;
		float num = 0f;
		float num2 = Vector2.Dot(vector - contact.point, vector2);
		float num3 = Mathf.Max(0.01f, wheelRadius * Mathf.Max(0.01f, wheelVisualContactRadiusScale));
		float num4 = num3 - num2;
		if (IsFinite(num4) && num4 > num)
		{
			num = num4;
		}
		if (Application.isPlaying)
		{
			Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ResolveWheelVisualLengthDepenetration");
			int num5 = Physics2D.OverlapCircle(vector, num3, driveContactFilter, wheelVisualPenetrationBuffer);
			for (int i = 0; i < num5; i++)
			{
				Collider2D collider2D = wheelVisualPenetrationBuffer[i];
				if (collider2D == null || collider2D.attachedRigidbody == rigidbody2D)
				{
					continue;
				}
				Vector2 vector3 = collider2D.ClosestPoint(vector);
				Vector2 vector4 = vector - vector3;
				float num6 = vector4.magnitude;
				Vector2 vector5;
				if (num6 > 0.0001f)
				{
					vector5 = vector4 / num6;
				}
				else
				{
					if (!collider2D.OverlapPoint(vector))
					{
						continue;
					}
					vector5 = ((vector2.sqrMagnitude > 0.0001f) ? vector2 : (-suspensionDir));
					num6 = 0f;
				}
				float num7 = num3 - num6;
				if (IsFinite(num7) && !(num7 <= num))
				{
					num = num7;
					vector2 = ((vector5.sqrMagnitude > 0.0001f) ? vector5.normalized : vector2);
				}
			}
		}
		if (!IsFinite(num) || num <= 0f)
		{
			return currentLength;
		}
		float num8 = Vector2.Dot(suspensionDir, vector2);
		if (!IsFinite(num8) || Mathf.Abs(num8) <= 0.0001f)
		{
			num8 = ((num8 >= 0f) ? 0.25f : (-0.25f));
		}
		float num9 = num / num8;
		if (!IsFinite(num9))
		{
			return currentLength;
		}
		float num10 = Mathf.Clamp(currentLength + num9, minLength, maxLength);
		if (num10 < currentLength)
		{
			yVelocity = Mathf.Min(0f, yVelocity);
		}
		return num10;
	}

	protected float ResolveSpawnYAlignedToArenaFloor(float fallbackSpawnY, string context)
	{
		if (!Application.isPlaying)
		{
			return fallbackSpawnY;
		}
		GameObject obj = GameObject.Find("ArenaFloor");
		if (obj == null)
		{
			throw new InvalidOperationException("[SummerRace] ArenaFloor is missing while resolving spawn alignment. context=" + context);
		}
		BoxCollider2D component = obj.GetComponent<BoxCollider2D>();
		if (component == null)
		{
			throw new InvalidOperationException("[SummerRace] ArenaFloor BoxCollider2D is missing while resolving spawn alignment. context=" + context);
		}
		float y = component.bounds.max.y;
		if (!IsFinite(y))
		{
			throw new InvalidOperationException("[SummerRace] ArenaFloor top Y is invalid while resolving spawn alignment. context=" + context);
		}
		return ResolveLaneYFromGround(y);
	}

	public abstract float ResolveLaneYFromGround(float groundTopY);

	protected virtual void ApplyLaneStabilization(WheelContactData frontContact, WheelContactData backContact)
	{
	}

	protected void CaptureAuthoredSpawnAnchorX()
	{
		if (!hasAuthoredSpawnAnchorX)
		{
			if (Application.isPlaying)
			{
				authoredSpawnAnchorX = RequirePhysicsBodyReady("CaptureAuthoredSpawnAnchorX").position.x;
			}
			else
			{
				authoredSpawnAnchorX = base.transform.position.x;
			}
			hasAuthoredSpawnAnchorX = true;
		}
	}

	protected float ResolveAuthoredSpawnAnchorX(float minX, float maxX)
	{
		if (!hasAuthoredSpawnAnchorX)
		{
			CaptureAuthoredSpawnAnchorX();
		}
		return Mathf.Clamp(authoredSpawnAnchorX, minX, maxX);
	}

	protected void ApplySpawnPoseImmediate(float x, float y)
	{
		Vector3 position = new Vector3(x, y, base.transform.position.z);
		Quaternion identity = Quaternion.identity;
		if (!Application.isPlaying)
		{
			base.transform.SetPositionAndRotation(position, identity);
			ResetWheelVisualState();
			return;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ApplySpawnPoseImmediate");
		base.transform.SetPositionAndRotation(position, identity);
		rigidbody2D.position = new Vector2(x, y);
		rigidbody2D.rotation = 0f;
		rigidbody2D.velocity = Vector2.zero;
		rigidbody2D.angularVelocity = 0f;
		ResetWheelVisualState();
	}

	protected void ResetWheelVisualState()
	{
		frontWheelVisualInitialized = false;
		backWheelVisualInitialized = false;
		frontWheelVisualVelY = 0f;
		backWheelVisualVelY = 0f;
		lastFrontWheelContact = default(WheelContactData);
		lastBackWheelContact = default(WheelContactData);
		if (frontWheel != null)
		{
			frontWheel.position = base.transform.TransformPoint(frontWheelLocal);
		}
		if (backWheel != null)
		{
			backWheel.position = base.transform.TransformPoint(backWheelLocal);
		}
	}

	protected void RebuildModularBackend(SummerRaceBodyType runtimeBodyType, IReadOnlyList<SummerRaceWeaponDefSO> weaponDefs, IReadOnlyList<SummerRaceEquipDefSO> equipDefs, Transform aimTarget, Vector2 manualAimDirection, IReadOnlyList<int> weaponSlotIndices = null, IReadOnlyList<int> equipSlotIndices = null)
	{
		float mountXSign = ResolveModularMountXSign();
		SummerRaceRuntimeVehicleBuild build = SummerRaceRuntimeModuleFactory.CreateBuild(runtimeBodyType, weaponDefs, equipDefs, mountXSign, ResolveRuntimeMountLocalPosition, weaponSlotIndices, equipSlotIndices);
		SummerRaceRuntimeVehicleBuild summerRaceRuntimeVehicleBuild = modularRuntimeBuild;
		try
		{
			modularBackendReady = SummerRaceRuntimeAssemblyBootstrap.ApplyBuild(base.gameObject, build, aimTarget, out modularAssembler, out modularPhysics, out modularWeaponSystem);
		}
		catch
		{
			SummerRaceRuntimeModuleFactory.ReleaseBuild(build);
			throw;
		}
		if (!modularBackendReady || modularPhysics == null || modularWeaponSystem == null)
		{
			SummerRaceRuntimeModuleFactory.ReleaseBuild(build);
			throw new InvalidOperationException("[SummerRace] Modular backend bootstrap failed on " + base.name);
		}
		modularRuntimeBuild = build;
		if (summerRaceRuntimeVehicleBuild != null)
		{
			SummerRaceRuntimeModuleFactory.ReleaseBuild(summerRaceRuntimeVehicleBuild);
		}
		modularEquipSystem = GetComponent<VehicleEquipSystem>();
		if (modularEquipSystem == null)
		{
			modularEquipSystem = base.gameObject.AddComponent<VehicleEquipSystem>();
		}
		modularWeaponSystem.SetOwnerContext(this as IWeaponOwnerContext);
		modularEquipSystem.SetAssembler(modularAssembler);
		modularEquipSystem.SetOwnerContext(this as IEquipOwnerContext);
		modularWeaponSystem.RefreshWeapons();
		modularEquipSystem.RefreshUtilities();
		if (manualAimDirection.sqrMagnitude > 0.0001f)
		{
			modularWeaponSystem.SetManualAimDirection(manualAimDirection.normalized);
		}
		modularVisualMirrorInitialized = false;
		modularMountedVisualAuthoringRotations.Clear();
	}

	protected virtual float ResolveModularMountXSign()
	{
		return 1f;
	}

	protected virtual Vector2 ResolveRuntimeMountLocalPosition(SummerRaceMountPointDefConfig mount, float mountXSign)
	{
		if (mount == null)
		{
			throw new InvalidOperationException("[SummerRace] Null mount config while resolving runtime mount position.");
		}
		if (!(mountXSign >= 0f))
		{
			return new Vector2(0f - mount.localPosition.x, mount.localPosition.y);
		}
		return mount.localPosition;
	}

	protected virtual bool ShouldRotateMountedVisualY180(MountPoint mount)
	{
		return false;
	}

	protected void SyncModularVisualMirror()
	{
		if (!Application.isPlaying || !modularBackendReady || modularAssembler == null)
		{
			return;
		}
		float num = ResolveFacingDirection();
		if (!IsFinite(num) || Mathf.Abs(num) <= 0.0001f)
		{
			num = 1f;
		}
		float num2 = ((num >= 0f) ? 1f : (-1f));
		IReadOnlyList<MountPoint> mountPoints = modularAssembler.MountPoints;
		for (int i = 0; i < mountPoints.Count; i++)
		{
			MountPoint mountPoint = mountPoints[i];
			if (mountPoint == null)
			{
				continue;
			}
			GameObject visualInstance = mountPoint.VisualInstance;
			if (!(visualInstance == null))
			{
				Transform transform = visualInstance.transform;
				if (!ShouldMirrorMountedVisual(mountPoint))
				{
					ApplyMountedVisualRotation(mountPoint, transform);
					continue;
				}
				Vector3 localScale = transform.localScale;
				float x = Mathf.Abs(localScale.x) * num2;
				transform.localScale = new Vector3(x, localScale.y, localScale.z);
				ApplyMountedVisualRotation(mountPoint, transform);
			}
		}
		modularVisualMirrorSign = num2;
		modularVisualMirrorInitialized = true;
	}

	private static bool ShouldMirrorMountedVisual(MountPoint mount)
	{
		if (mount == null || mount.InstalledModule == null)
		{
			return false;
		}
		return mount.InstalledModule.MountType == VehicleMountType.Wheel;
	}

	private void ApplyMountedVisualRotation(MountPoint mount, Transform visualTransform)
	{
		if (!(visualTransform == null))
		{
			if (!modularMountedVisualAuthoringRotations.TryGetValue(visualTransform, out var value))
			{
				value = visualTransform.localRotation;
				modularMountedVisualAuthoringRotations[visualTransform] = value;
			}
			Quaternion quaternion = value;
			if (ShouldRotateMountedVisualY180(mount))
			{
				quaternion *= Quaternion.Euler(0f, 180f, 0f);
			}
			if (!(Quaternion.Angle(visualTransform.localRotation, quaternion) <= 0.01f))
			{
				visualTransform.localRotation = quaternion;
			}
		}
	}

	protected void RequireModularBackendReady(string context)
	{
		if (!modularBackendReady || modularPhysics == null || modularWeaponSystem == null || modularEquipSystem == null)
		{
			throw new InvalidOperationException("[SummerRace] Modular backend is not ready (" + context + ") on " + base.name);
		}
	}

	protected Rigidbody2D RequirePhysicsBodyReady(string context)
	{
		if (rb == null)
		{
			throw new InvalidOperationException("[SummerRace] Rigidbody is missing (" + context + ") on " + base.name);
		}
		return rb;
	}

	protected void SetModularAimTarget(Transform aimTarget)
	{
		RequireModularBackendReady("SetModularAimTarget");
		modularWeaponSystem.SetAimTarget(aimTarget);
	}

	public void SetCombatRuntimePaused(bool paused)
	{
		if (modularWeaponSystem != null)
		{
			modularWeaponSystem.SetRuntimePaused(paused);
		}
	}

	protected void SetModularAimDirection(Vector2 aimDirection)
	{
		RequireModularBackendReady("SetModularAimDirection");
		if (aimDirection.sqrMagnitude > 0.0001f)
		{
			modularWeaponSystem.SetManualAimDirection(aimDirection.normalized);
		}
	}

	protected bool TryFireModularWeaponSlot(int slotIndex)
	{
		RequireModularBackendReady("TryFireModularWeaponSlot");
		return modularWeaponSystem.TryFireSlot(slotIndex);
	}

	protected CombatExecutionResult TryUseModularEquipSlot(int slotIndex, Vector2 aimDirection)
	{
		RequireModularBackendReady("TryUseModularEquipSlot");
		return modularEquipSystem.TryActivateSlot(slotIndex, aimDirection);
	}

	protected void ApplyModularDrive(float throttleInput, float steerInput)
	{
		RequireModularBackendReady("ApplyModularDrive");
		modularPhysics.ApplyDrive(Mathf.Clamp(throttleInput, -1f, 1f));
		modularPhysics.ApplySteering(Mathf.Clamp(steerInput, -1f, 1f));
	}

	protected void SyncLegacyWheelContactsFromModular()
	{
		RequireModularBackendReady("SyncLegacyWheelContactsFromModular");
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("SyncLegacyWheelContactsFromModular");
		modularPhysics.CopyDebugWheelStates(modularWheelStates);
		if (modularWheelStates.Count <= 0)
		{
			lastFrontWheelContact = default(WheelContactData);
			lastBackWheelContact = default(WheelContactData);
			return;
		}
		Vector2 rhs = rigidbody2D.transform.right;
		if (rhs.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Rigidbody forward axis is invalid while syncing modular wheel contacts.");
		}
		rhs.Normalize();
		VehiclePhysicsController.DebugWheelState state = modularWheelStates[0];
		VehiclePhysicsController.DebugWheelState state2 = modularWheelStates[0];
		float num = Vector2.Dot(state.worldPos, rhs);
		float num2 = num;
		for (int i = 1; i < modularWheelStates.Count; i++)
		{
			VehiclePhysicsController.DebugWheelState debugWheelState = modularWheelStates[i];
			float num3 = Vector2.Dot(debugWheelState.worldPos, rhs);
			if (num3 > num)
			{
				state = debugWheelState;
				num = num3;
			}
			if (num3 < num2)
			{
				state2 = debugWheelState;
				num2 = num3;
			}
		}
		lastFrontWheelContact = ToWheelContact(state);
		lastBackWheelContact = ToWheelContact(state2);
	}

	private WheelContactData ToWheelContact(VehiclePhysicsController.DebugWheelState state)
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ToWheelContact");
		float num = 0f;
		if (IsFinite(state.worldPos) && IsFinite(state.contactTangent) && state.contactTangent.sqrMagnitude > 0.0001f)
		{
			num = Vector2.Dot(rigidbody2D.GetPointVelocity(state.worldPos), state.contactTangent.normalized);
		}
		float num2 = (IsFinite(state.compression) ? Mathf.Clamp01(state.compression) : 0f);
		if (state.grounded && IsFinite(state.contactNormal) && state.contactNormal.sqrMagnitude > 0.0001f)
		{
			if (rigidbody2D.transform.up.sqrMagnitude <= 0.0001f)
			{
				throw new InvalidOperationException("[SummerRace] Rigidbody support axis is invalid while syncing wheel contact.");
			}
			float value = Vector2.Dot(state.contactNormal.normalized, Vector2.up);
			float num3 = Mathf.Clamp01(Mathf.InverseLerp(0.42f, 0.88f, value));
			if (state.supportSource == VehiclePhysicsController.WheelSupportSource.Secondary)
			{
				num3 *= 0.35f;
			}
			if (state.surfaceBodyType == RigidbodyType2D.Dynamic)
			{
				num3 *= 0.55f;
			}
			num2 *= num3;
		}
		return new WheelContactData
		{
			hasContact = state.grounded,
			point = (IsFinite(state.contactPoint) ? state.contactPoint : Vector2.zero),
			normal = ((state.grounded && IsFinite(state.contactNormal)) ? state.contactNormal : Vector2.zero),
			tangent = ((state.grounded && IsFinite(state.contactTangent)) ? state.contactTangent : Vector2.zero),
			compression = num2,
			compressionVelocity = (IsFinite(state.compressionVelocity) ? state.compressionVelocity : 0f),
			supportSwitchCount1s = (IsFinite(state.supportSwitchCount1s) ? state.supportSwitchCount1s : 0f),
			relativeNormalSpeed = (IsFinite(state.relativeNormalSpeed) ? state.relativeNormalSpeed : 0f),
			supportSource = state.supportSource,
			tangentVelocity = (IsFinite(num) ? num : 0f),
			surfaceBodyType = state.surfaceBodyType
		};
	}

	protected static void IntegrateSpring(ref float value, ref float velocity, float springK, float damping, float dt)
	{
		SummerRaceSuspensionKernel.SpringState state = new SummerRaceSuspensionKernel.SpringState
		{
			value = value,
			velocity = velocity
		};
		SummerRaceSuspensionKernel.SpringConfig config = new SummerRaceSuspensionKernel.SpringConfig
		{
			springK = springK,
			damping = damping
		};
		SummerRaceSuspensionKernel.IntegrateSpring(ref state, config, dt);
		value = state.value;
		velocity = state.velocity;
	}

	protected static void IntegrateSpring(ref SummerRaceSuspensionKernel.SpringState state, SummerRaceSuspensionKernel.SpringConfig config, float dt)
	{
		SummerRaceSuspensionKernel.IntegrateSpring(ref state, config, dt);
	}

	protected virtual float ComputeSuspensionReach(in SummerRaceSuspensionKernel.SuspensionContext context)
	{
		return SummerRaceSuspensionKernel.ComputeSuspensionReach(in context);
	}

	protected virtual SummerRaceSuspensionKernel.SuspensionBodyMultipliers ResolveSuspensionBodyMultipliers(in SummerRaceSuspensionKernel.SuspensionContext context)
	{
		return SummerRaceSuspensionKernel.ResolveBodyMultipliers(in context);
	}

	protected virtual float GetSuspensionReach(float wheelRadius)
	{
		SummerRaceSuspensionKernel.SuspensionContext context = new SummerRaceSuspensionKernel.SuspensionContext
		{
			bodyType = bodyType,
			wheelRadius = wheelRadius,
			wheelProbeExtra = wheelProbeExtra
		};
		return ComputeSuspensionReach(in context);
	}

	protected virtual void GetSuspensionBodyMultipliers(out float springMul, out float dampingMul)
	{
		SummerRaceSuspensionKernel.SuspensionContext context = new SummerRaceSuspensionKernel.SuspensionContext
		{
			bodyType = bodyType
		};
		SummerRaceSuspensionKernel.SuspensionBodyMultipliers suspensionBodyMultipliers = ResolveSuspensionBodyMultipliers(in context);
		springMul = suspensionBodyMultipliers.springMul;
		dampingMul = suspensionBodyMultipliers.dampingMul;
	}

	protected virtual Vector2 Rotate(Vector2 v, float degrees)
	{
		float f = degrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(v.x * num - v.y * num2, v.x * num2 + v.y * num).normalized;
	}

	protected abstract float GetCruiseSpeed();

	protected abstract float GetTractionGain();

	protected abstract float GetTractionCompressionMultiplier();

	protected abstract float GetDesiredWheelLinearMultiplier();

	protected abstract Vector2 GetWheelRadiusClampRange();

	protected virtual void ApplyWheelMotorForce(WheelContactData contact, Vector2 wheelLocal, float wheelRadius, float driveSign, float throttle)
	{
		if (!contact.hasContact)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("ApplyWheelMotorForce");
		Vector2 vector = base.transform.TransformPoint(wheelLocal);
		Vector2 vector2 = contact.tangent;
		Vector2 normalized = ((Vector2)rigidbody2D.transform.right).normalized;
		if (normalized.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace] Chassis forward axis is invalid in motor solve.");
		}
		if (Vector2.Dot(vector2, normalized * driveSign) < 0f)
		{
			vector2 = -vector2;
		}
		float num = Vector2.Dot(rigidbody2D.GetPointVelocity(vector), contact.normal);
		float num2 = Mathf.Clamp(rigidbody2D.mass / 24f, 0.9f, 2.8f);
		SummerRaceSuspensionKernel.SuspensionBodyMultipliers suspensionBodyMultipliers = ResolveSuspensionBodyMultipliers(new SummerRaceSuspensionKernel.SuspensionContext
		{
			bodyType = bodyType,
			wheelRadius = wheelRadius,
			wheelProbeExtra = wheelProbeExtra,
			massScale = num2,
			normalSpeed = num,
			compression = contact.compression,
			tangentVelocity = contact.tangentVelocity,
			throttle = throttle
		});
		float springMul = suspensionBodyMultipliers.springMul;
		float dampingMul = suspensionBodyMultipliers.dampingMul;
		float value = wheelSpring * num2 * springMul * contact.compression - num * wheelDamping * Mathf.Sqrt(num2) * dampingMul;
		float num3 = Mathf.Max(4f, maxSuspensionForcePerMass) * rigidbody2D.mass;
		value = Mathf.Clamp(value, (0f - num3) * 0.28f, num3);
		rigidbody2D.AddForceAtPosition(contact.normal * value, vector, ForceMode2D.Force);
		float num4 = (0f - contact.tangentVelocity) * wheelRollingResistance * rigidbody2D.mass * 0.06f;
		rigidbody2D.AddForceAtPosition(vector2 * num4, vector, ForceMode2D.Force);
		if (!(throttle <= 0.0001f))
		{
			float num5 = 1f / Mathf.Max(0.08f, wheelRadius);
			Vector2 wheelRadiusClampRange = GetWheelRadiusClampRange();
			float num6 = GetCruiseSpeed() * GetDesiredWheelLinearMultiplier() * Mathf.Clamp(wheelRadius / 0.24f, wheelRadiusClampRange.x, wheelRadiusClampRange.y);
			float f = Mathf.Abs(num6) - Mathf.Abs(contact.tangentVelocity);
			float t = Mathf.Clamp01(Mathf.Abs(contact.tangentVelocity) / Mathf.Max(0.2f, num6 * 0.4f));
			float t2 = Mathf.Clamp01(Mathf.Abs(f) / Mathf.Max(0.1f, num6) * Mathf.Lerp(0.65f, 1f, t));
			float num7 = Mathf.Clamp01(contact.compression);
			float t3 = Mathf.Clamp01(num7 * num7 * (3f - 2f * num7) * Mathf.Clamp(GetTractionCompressionMultiplier(), 0.6f, 1.6f));
			float num8 = Mathf.Lerp(0.2f, 1f, t3);
			if (contact.surfaceBodyType == RigidbodyType2D.Dynamic)
			{
				num8 *= Mathf.Clamp01(dynamicSurfaceTractionMultiplier);
			}
			float value2 = rigidbody2D.mass * GetTractionGain() * throttle * num5 * num8 * Mathf.Lerp(0.5f, 1f, t2);
			float num9 = Mathf.Max(0.5f, maxWheelMotorForcePerMass) * rigidbody2D.mass;
			value2 = Mathf.Clamp(value2, 0f - num9, num9);
			rigidbody2D.AddForceAtPosition(vector2 * value2, vector, ForceMode2D.Force);
		}
	}

	protected virtual void RecordExplainabilityEvent(string category, string detail, bool logToConsole = true)
	{
		lastExplainabilityEvent = category + " | " + detail;
		lastExplainabilityEventAt = (Application.isPlaying ? Time.time : 0f);
		if (IsRuntimeDebugLogEnabled & logToConsole)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][" + GetType().Name + "][" + category + "] " + detail);
		}
	}

	protected virtual string FormatExplainabilityEventLabel()
	{
		if (string.IsNullOrEmpty(lastExplainabilityEvent))
		{
			return "event=none";
		}
		if (!Application.isPlaying || lastExplainabilityEventAt < -100f)
		{
			return lastExplainabilityEvent;
		}
		return lastExplainabilityEvent + " @" + Mathf.Max(0f, Time.time - lastExplainabilityEventAt).ToString("F1") + "s";
	}

	protected static string DescribeWheelContact(WheelContactData contact)
	{
		if (!contact.hasContact)
		{
			return "air";
		}
		return "src=" + contact.supportSource.ToString() + "/body=" + contact.surfaceBodyType.ToString() + "/nY=" + contact.normal.y.ToString("F2") + "/c=" + contact.compression.ToString("F2") + "/cv=" + contact.compressionVelocity.ToString("F2") + "/sw=" + contact.supportSwitchCount1s.ToString("F1") + "/rn=" + contact.relativeNormalSpeed.ToString("F2");
	}

	protected static bool IsFinite(float value)
	{
		if (!float.IsNaN(value))
		{
			return !float.IsInfinity(value);
		}
		return false;
	}

	protected static bool IsFinite(Vector2 value)
	{
		if (IsFinite(value.x))
		{
			return IsFinite(value.y);
		}
		return false;
	}

	protected static float RequireFiniteValue(float value, string context)
	{
		if (!IsFinite(value))
		{
			throw new InvalidOperationException("[SummerRace] Non-finite runtime value detected (" + context + ").");
		}
		return value;
	}

	protected static Vector2 RequireFiniteValue(Vector2 value, string context)
	{
		if (!IsFinite(value))
		{
			throw new InvalidOperationException("[SummerRace] Non-finite runtime vector detected (" + context + ").");
		}
		return value;
	}

	protected static float ComputeContactSupportDot(in WheelContactData contact, Rigidbody2D body)
	{
		if (body == null)
		{
			throw new InvalidOperationException("[SummerRace] Rigidbody is missing while computing contact support dot.");
		}
		if (!contact.hasContact || contact.normal.sqrMagnitude <= 0.0001f)
		{
			return 0f;
		}
		return Vector2.Dot(contact.normal.normalized, Vector2.up);
	}

	protected static bool IsSupportContact(in WheelContactData contact, float minSupportDot, Rigidbody2D body)
	{
		if (contact.hasContact)
		{
			return ComputeContactSupportDot(in contact, body) >= minSupportDot;
		}
		return false;
	}

	protected static bool IsDriveSupportContact(in WheelContactData contact, Rigidbody2D body)
	{
		if (!IsSupportContact(in contact, 0.32f, body))
		{
			return false;
		}
		return contact.compression >= 0.05f;
	}

	protected void RegisterBoundaryContact(Collision2D collision)
	{
		if (collision == null || collision.collider == null || !IsBoundaryColliderName(collision.collider.name))
		{
			return;
		}
		Vector2 zero = Vector2.zero;
		int contactCount = collision.contactCount;
		for (int i = 0; i < contactCount; i++)
		{
			Vector2 normal = collision.GetContact(i).normal;
			if (!(normal.sqrMagnitude <= 0.0001f) && !(Mathf.Abs(normal.x) < 0.35f))
			{
				zero += normal;
			}
		}
		if (!(zero.sqrMagnitude <= 0.0001f))
		{
			boundaryDriveBlockNormal = zero.normalized;
			boundaryDriveBlockUntil = Mathf.Max(boundaryDriveBlockUntil, Time.time + 0.16f);
		}
	}

	protected void TryPublishVehicleCollisionAudio(Collision2D collision)
	{
		if (collision == null || collision.contactCount <= 0 || IsMountedWeaponCollision(collision))
		{
			return;
		}
		float magnitude = collision.relativeVelocity.magnitude;
		if (!(magnitude < 1.8f))
		{
			Rigidbody2D selfBody = ((rb != null) ? rb : GetComponent<Rigidbody2D>());
			if (TryReserveVehicleCollisionAudio(selfBody, ResolveOtherCollisionRigidbody(collision, selfBody)))
			{
				ContactPoint2D contact = collision.GetContact(0);
				SummerRaceCombatAudioEventRouter.Publish(base.transform, SummerRaceCombatAudioEvent.VehicleCollision(base.transform, contact.point, magnitude));
			}
		}
	}

	private static bool IsMountedWeaponCollision(Collision2D collision)
	{
		if (collision == null)
		{
			return false;
		}
		Collider2D collider2D = ((collision.collider != null) ? collision.collider : collision.otherCollider);
		if (collider2D != null)
		{
			return collider2D.GetComponentInParent<MountPoint>() != null;
		}
		return false;
	}

	private void EnsureCombatAudioSink()
	{
		if (GetComponent<SummerRaceCombatPresentationAudioSink>() == null)
		{
			base.gameObject.AddComponent<SummerRaceCombatPresentationAudioSink>();
		}
	}

	private bool TryReserveVehicleCollisionAudio(Rigidbody2D selfBody, Rigidbody2D otherBody)
	{
		if (selfBody == null)
		{
			return false;
		}
		float time = Time.time;
		if (otherBody == null || otherBody.bodyType != RigidbodyType2D.Dynamic)
		{
			if (time < nextVehicleCollisionAudioAt)
			{
				return false;
			}
			nextVehicleCollisionAudioAt = time + 0.16f;
			return true;
		}
		long key = BuildVehicleCollisionAudioPairKey(selfBody.GetInstanceID(), otherBody.GetInstanceID());
		if (VehicleCollisionAudioNextTimeByPair.TryGetValue(key, out var value) && time < value && value - time < 5f)
		{
			return false;
		}
		VehicleCollisionAudioNextTimeByPair[key] = time + 0.16f;
		return true;
	}

	private static Rigidbody2D ResolveOtherCollisionRigidbody(Collision2D collision, Rigidbody2D selfBody)
	{
		if (collision == null)
		{
			return null;
		}
		if (collision.rigidbody == selfBody)
		{
			return collision.otherRigidbody;
		}
		if (collision.otherRigidbody == selfBody)
		{
			return collision.rigidbody;
		}
		if (!(collision.rigidbody != null))
		{
			return collision.otherRigidbody;
		}
		return collision.rigidbody;
	}

	private static long BuildVehicleCollisionAudioPairKey(int firstId, int secondId)
	{
		int num = ((firstId < secondId) ? firstId : secondId);
		int num2 = ((firstId < secondId) ? secondId : firstId);
		long num3 = (uint)num;
		long num4 = (uint)num2;
		return (num3 << 32) | num4;
	}

	protected static Vector2 ResolveBestSupportNormal(Collision2D collision)
	{
		if (collision == null || collision.contactCount <= 0)
		{
			return Vector2.zero;
		}
		Vector2 result = Vector2.zero;
		float num = float.NegativeInfinity;
		int contactCount = collision.contactCount;
		for (int i = 0; i < contactCount; i++)
		{
			Vector2 normal = collision.GetContact(i).normal;
			if (normal.y > num)
			{
				num = normal.y;
				result = normal;
			}
		}
		return result;
	}

	protected float ResolveBoundaryDriveGate(float desiredSpeedX)
	{
		RequireFiniteValue(desiredSpeedX, "ResolveBoundaryDriveGate.desiredSpeedX");
		if (Time.time > boundaryDriveBlockUntil || Mathf.Abs(desiredSpeedX) <= 0.0001f || boundaryDriveBlockNormal.sqrMagnitude <= 0.0001f)
		{
			return 1f;
		}
		float x = boundaryDriveBlockNormal.normalized.x;
		if (Mathf.Abs(x) < 0.35f)
		{
			return 1f;
		}
		float num = Mathf.Sign(desiredSpeedX) * x;
		if (num >= -0.05f)
		{
			return 1f;
		}
		return Mathf.Clamp01(Mathf.InverseLerp(-1f, -0.05f, num));
	}

	protected float ResolveBoundaryAdjustedAcceleration(float desiredSpeedX, float accelerationCommand, float accelerationCap, float currentVelocityX)
	{
		RequireFiniteValue(desiredSpeedX, "ResolveBoundaryAdjustedAcceleration.desiredSpeedX");
		RequireFiniteValue(accelerationCommand, "ResolveBoundaryAdjustedAcceleration.accelerationCommand");
		RequireFiniteValue(accelerationCap, "ResolveBoundaryAdjustedAcceleration.accelerationCap");
		RequireFiniteValue(currentVelocityX, "ResolveBoundaryAdjustedAcceleration.currentVelocityX");
		float num = ResolveBoundaryDriveGate(desiredSpeedX);
		float num2 = accelerationCommand * num;
		if (num >= Mathf.Clamp01(boundaryEscapeGateThreshold) || boundaryDriveBlockNormal.sqrMagnitude <= 0.0001f)
		{
			return num2;
		}
		if (Mathf.Abs(currentVelocityX) > Mathf.Max(0f, boundaryEscapeSpeedThreshold))
		{
			return num2;
		}
		float num3 = Mathf.Sign(boundaryDriveBlockNormal.x);
		if (Mathf.Abs(num3) <= 0.0001f)
		{
			return num2;
		}
		float num4 = Mathf.Max(0.1f, Mathf.Abs(accelerationCap) * Mathf.Clamp01(boundaryEscapeAccelerationScale));
		float num5 = num3 * num4 * (1f - Mathf.Clamp01(num));
		if (Mathf.Abs(num2) <= Mathf.Abs(num5) || Mathf.Sign(num2) != Mathf.Sign(num5))
		{
			return num5;
		}
		return num2;
	}

	private static bool IsBoundaryColliderName(string colliderName)
	{
		if (!string.IsNullOrEmpty(colliderName))
		{
			return colliderName.StartsWith("Boundary");
		}
		return false;
	}

	protected bool IsWeaponFireUnlockedAfterSpawn()
	{
		return weaponFireUnlockedAfterSpawn;
	}

	protected void ResetWeaponFireSpawnLock()
	{
		weaponFireUnlockedAfterSpawn = false;
		weaponFireSupportStableElapsed = 0f;
		weaponFireLandingDetectedAfterSpawn = false;
		ResetSpawnEntryAnimationState();
		spawnDriveRampStartAt = Time.time;
		spawnDriveConditionStableElapsed = 0f;
		spawnDriveBlend = 0f;
	}

	protected void TickWeaponFireSpawnLock(float deltaTime)
	{
		if (weaponFireUnlockedAfterSpawn && spawnEntryLandingAnimationPlayed)
		{
			return;
		}
		float num = ComputeWeaponFireSupportRatio();
		if (!weaponFireLandingDetectedAfterSpawn && !(num >= 0.2f))
		{
			weaponFireSupportStableElapsed = 0f;
			return;
		}
		weaponFireSupportStableElapsed += Mathf.Max(0f, deltaTime);
		if (!spawnEntryLandingAnimationPlayed && weaponFireSupportStableElapsed + 0.0001f >= 0.04f && IsSpawnLandingFallbackReady())
		{
			AcceptSpawnLandingContact();
		}
		if (!weaponFireUnlockedAfterSpawn && weaponFireSupportStableElapsed + 0.0001f >= 0.04f)
		{
			weaponFireUnlockedAfterSpawn = true;
		}
	}

	private float ComputeWeaponFireSupportRatio()
	{
		Rigidbody2D body = RequirePhysicsBodyReady("ComputeWeaponFireSupportRatio");
		float ratio = 0f;
		float weight = 0f;
		AccumulateWeaponFireSupport(in lastFrontWheelContact, body, ref ratio, ref weight);
		AccumulateWeaponFireSupport(in lastBackWheelContact, body, ref ratio, ref weight);
		if (weight <= 0f)
		{
			return 0f;
		}
		return Mathf.Clamp01(ratio / weight);
	}

	protected void NotifySpawnLandingContact(Vector2 contactNormal)
	{
		if ((!weaponFireUnlockedAfterSpawn || !spawnEntryLandingAnimationPlayed) && !(contactNormal.sqrMagnitude <= 0.0001f) && !(contactNormal.normalized.y + 0.0001f < 0.1f))
		{
			weaponFireLandingDetectedAfterSpawn = true;
			AcceptSpawnLandingContact();
		}
	}

	private bool IsSpawnLandingFallbackReady()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("IsSpawnLandingFallbackReady");
		if (rigidbody2D.simulated)
		{
			return Mathf.Abs(rigidbody2D.velocity.y) <= 0.08f;
		}
		return false;
	}

	private void AcceptSpawnLandingContact()
	{
		weaponFireLandingDetectedAfterSpawn = true;
		if (!spawnEntryLandingAnimationPlayed)
		{
			spawnEntryLandingAnimationPlayed = true;
			OnSpawnLandingContactAccepted();
		}
	}

	protected virtual void OnSpawnEntryAnimationReset()
	{
	}

	protected virtual void OnSpawnLandingContactAccepted()
	{
	}

	private void ResetSpawnEntryAnimationState()
	{
		spawnEntryLandingAnimationPlayed = false;
		OnSpawnEntryAnimationReset();
	}

	private static void AccumulateWeaponFireSupport(in WheelContactData contact, Rigidbody2D body, ref float ratio, ref float weight)
	{
		if (IsSupportContact(in contact, 0.1f, body))
		{
			ratio += Mathf.Clamp01(contact.compression);
			weight++;
		}
	}

	protected float ResolveSpawnDriveCommandScale(float surfaceGapAbsX, float supportRatio, float deltaTime)
	{
		RequireFiniteValue(surfaceGapAbsX, "ResolveSpawnDriveCommandScale.surfaceGapAbsX");
		RequireFiniteValue(supportRatio, "ResolveSpawnDriveCommandScale.supportRatio");
		RequireFiniteValue(deltaTime, "ResolveSpawnDriveCommandScale.deltaTime");
		float num = Mathf.Clamp(spawnDriveMinScale, 0.05f, 1f);
		float num2 = Mathf.Max(0f, deltaTime);
		if (Time.time - spawnDriveRampStartAt < Mathf.Max(0f, spawnDriveGraceSeconds))
		{
			spawnDriveBlend = 0f;
			spawnDriveConditionStableElapsed = 0f;
			return num;
		}
		float num3 = Mathf.Max(0f, spawnDriveDistanceTolerance);
		float num4 = Mathf.Clamp01(spawnDriveSupportTolerance);
		float num5 = Mathf.Max(0.12f, num3 * 0.18f);
		float num6 = Mathf.Max(0.04f, num4 * 0.18f);
		bool num7 = surfaceGapAbsX + 0.0001f >= Mathf.Max(0f, num3 - num5);
		bool flag = supportRatio + 0.0001f >= Mathf.Clamp01(num4 - num6);
		if (num7 & flag)
		{
			spawnDriveConditionStableElapsed += num2;
		}
		else
		{
			spawnDriveConditionStableElapsed = Mathf.Max(0f, spawnDriveConditionStableElapsed - num2 * 0.95f);
		}
		float num8 = ((spawnDriveConditionStableElapsed + 0.0001f >= Mathf.Max(0f, spawnDriveConditionHoldSeconds)) ? 1f : 0f);
		float num9 = 1f / Mathf.Max(0.05f, spawnDriveRampSeconds);
		float num10 = num9 * 0.78f;
		spawnDriveBlend = Mathf.MoveTowards(spawnDriveBlend, num8, ((num8 > spawnDriveBlend) ? num9 : num10) * num2);
		float t = spawnDriveBlend * spawnDriveBlend * (3f - 2f * spawnDriveBlend);
		return Mathf.Lerp(num, 1f, t);
	}
}
