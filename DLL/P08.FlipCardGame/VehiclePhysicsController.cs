using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
[RequireComponent(typeof(Rigidbody2D))]
public class VehiclePhysicsController : MonoBehaviour
{
	public enum WheelSupportSource
	{
		None,
		Primary,
		Secondary
	}

	private sealed class WheelRuntime
	{
		public MountPoint mount;

		public WheelModuleDefinition def;

		public bool grounded;

		public float compression;

		public float smoothedCompression;

		public float compressionVelocity;

		public RigidbodyType2D surfaceBodyType;

		public WheelSupportSource supportSource;

		public float primarySupportWeight;

		public float secondarySupportWeight;

		public float relativeNormalSpeed;

		public float supportSwitchTimer;

		public int supportSwitchAccumulator;

		public int supportSwitchCount1s;

		public Vector2 smoothedNormal;

		public bool hasSmoothedContact;

		public Vector2 contactPoint;

		public Vector2 contactNormal;

		public Vector2 contactTangent;

		public Vector2 appliedMotorForce;

		public float slipRatio;

		public float smoothedTargetCompression;
	}

	private struct QueuedRecoilImpulse
	{
		public Vector2 remainingImpulse;

		public Vector2 worldPos;

		public float duration;

		public float elapsed;
	}

	private struct SupportContactCandidate
	{
		public bool found;

		public Vector2 point;

		public Vector2 normal;

		public Rigidbody2D body;

		public RigidbodyType2D bodyType;

		public float relativeNormalSpeed;

		public float centerToSurface;

		public float supportDot;

		public float score;

		public bool isPenetrating;

		public float penetrationDepth;
	}

	private struct WheelSupportBlend
	{
		public bool grounded;

		public SupportContactCandidate primary;

		public SupportContactCandidate secondary;

		public float primaryWeight;

		public float secondaryWeight;

		public Vector2 contactPoint;

		public Vector2 contactNormal;

		public Rigidbody2D contactBody;

		public RigidbodyType2D contactBodyType;

		public WheelSupportSource dominantSource;

		public float relativeNormalSpeed;

		public float centerToSurface;
	}

	public struct DebugWheelState
	{
		public Vector2 worldPos;

		public float radius;

		public bool grounded;

		public RigidbodyType2D surfaceBodyType;

		public WheelSupportSource supportSource;

		public float primarySupportWeight;

		public float secondarySupportWeight;

		public float compression;

		public float compressionVelocity;

		public float supportSwitchCount1s;

		public float relativeNormalSpeed;

		public Vector2 contactPoint;

		public Vector2 contactNormal;

		public Vector2 contactTangent;

		public Vector2 motorForce;

		public float slipRatio;
	}

	[Header("Refs")]
	[SerializeField]
	private VehicleAssembler assembler;

	[SerializeField]
	private Rigidbody2D rb;

	[Header("Ground")]
	[SerializeField]
	private LayerMask groundMask = -1;

	[SerializeField]
	private bool useContactProbe = true;

	[SerializeField]
	private float suspensionProbeExtra = 0.25f;

	[SerializeField]
	private int maxContactPerWheel = 24;

	[SerializeField]
	[Range(0.05f, 0.99f)]
	private float minSupportNormalY = 0.3f;

	[SerializeField]
	[Range(1f, 40f)]
	private float contactNormalSmoothing = 24f;

	[SerializeField]
	[Range(1f, 40f)]
	private float compressionSmoothing = 26f;

	[SerializeField]
	[Range(0.1f, 2f)]
	private float contactSupportScoreWeight = 0.72f;

	[SerializeField]
	[Range(0.1f, 2f)]
	private float contactDistanceScoreWeight = 0.28f;

	[SerializeField]
	[Range(0.05f, 0.99f)]
	private float dynamicSupportNormalYMin = 0.18f;

	[SerializeField]
	[Range(0f, 8f)]
	private float dynamicSupportMaxRelativeNormalSpeed = 2.4f;

	[SerializeField]
	[Range(0f, 1f)]
	private float dynamicSupportScoreAdvantage = 0.1f;

	[SerializeField]
	[Range(0f, 0.5f)]
	private float supportSwitchHysteresis = 0.05f;

	[SerializeField]
	[Range(0f, 1f)]
	private float penetratingContactScoreBonus = 0.35f;

	[SerializeField]
	[Min(0.01f)]
	private float overlapDepenetrationForcePerMass = 28f;

	[SerializeField]
	[Min(0.01f)]
	private float overlapDepenetrationMaxForcePerMass = 72f;

	[SerializeField]
	[Range(0f, 1f)]
	private float penetratingContactMinSupportWeight = 0.55f;

	[Header("Suspension Dynamics")]
	[SerializeField]
	[Range(0.2f, 1.8f)]
	private float minCriticalDampingRatio = 0.9f;

	[SerializeField]
	[Range(0.4f, 2.5f)]
	private float compressionDampingScale = 0.78f;

	[SerializeField]
	[Range(0.4f, 2.5f)]
	private float reboundDampingScale = 1.3f;

	[SerializeField]
	[Range(0f, 1f)]
	private float bumpStopStart = 0.72f;

	[SerializeField]
	[Range(0.05f, 0.6f)]
	private float bumpStopRange = 0.24f;

	[SerializeField]
	[Range(0f, 2f)]
	private float bumpStopStrength = 0.25f;

	[Header("Gameplay Amplify")]
	[SerializeField]
	private bool exaggerateBuildDifference = true;

	[SerializeField]
	private float massDistributionAmplify = 1.6f;

	[SerializeField]
	private bool enableRecoilTraceLog;

	[SerializeField]
	private float recoilAmplify = 3.2f;

	[SerializeField]
	[Range(0f, 1f)]
	private float recoilImmediateFraction = 0.9f;

	[SerializeField]
	[Min(0f)]
	private float recoilTailDurationCap = 0.06f;

	[SerializeField]
	[Range(0f, 0.5f)]
	private float recoilDriveSuppressionDuration = 0.26f;

	[SerializeField]
	[Range(0f, 1f)]
	private float recoilDriveSuppressionMinScale = 0.02f;

	[SerializeField]
	private Vector2 centerOfMassOffsetAmplify = new Vector2(1.55f, 1.35f);

	[SerializeField]
	private float wheelAsymmetryYawAmplify = 75f;

	[SerializeField]
	private float comBiasYawAmplify = 50f;

	[SerializeField]
	private float recoilMassReference = 55f;

	[Header("Drive")]
	[SerializeField]
	private float driveForceAmplify = 1.55f;

	[SerializeField]
	private float tractionAmplify = 1.35f;

	[SerializeField]
	[Range(0f, 0.45f)]
	private float driveLoadTransferStrength = 0.18f;

	[SerializeField]
	[Range(0f, 1f)]
	private float dynamicSupportDriveScale = 0.58f;

	[SerializeField]
	[Range(0f, 1f)]
	private float dynamicSupportRollingDragScale = 0.4f;

	[SerializeField]
	[Range(0.2f, 1f)]
	private float dynamicSupportSpringScale = 0.72f;

	[SerializeField]
	[Range(0f, 1f)]
	private float wallContactDriveScale = 0.22f;

	[SerializeField]
	[Range(0f, 1f)]
	private float wallContactRollingDragScale = 0.28f;

	[SerializeField]
	private float steerTorque = 22f;

	[SerializeField]
	private float speedClampMultiplier = 1.25f;

	[SerializeField]
	private float slipToForceGain = 24f;

	[Header("Stability")]
	[SerializeField]
	private float maxAngularSpeedDegPerSec = 430f;

	[SerializeField]
	private float angularExcessDampingGain = 0.55f;

	[SerializeField]
	private float uprightAssistDamping = 1.2f;

	[SerializeField]
	private float minUprightAssist = 2f;

	[SerializeField]
	private float maxUprightAssist = 18f;

	[Header("Flip Rescue")]
	[SerializeField]
	private bool allowTimedFlipRescue = true;

	[SerializeField]
	private float flipRescueDelay = 1.1f;

	[SerializeField]
	private float flipRescueDuration = 0.65f;

	[SerializeField]
	private float flipRescueTorque = 85f;

	[SerializeField]
	private float flipRescueMaxSpeed = 1.8f;

	[SerializeField]
	private float flipRescueMaxAngularSpeed = 60f;

	[SerializeField]
	[Range(-1f, 1f)]
	private float flipRescueUpsideDotThreshold = -0.2f;

	[SerializeField]
	[Range(0f, 180f)]
	private float flipRescueTiltAngleThreshold = 78f;

	[SerializeField]
	[Range(0f, 1f)]
	private float flipRescueGroundedRatioMax = 0.35f;

	[SerializeField]
	[Min(0.01f)]
	private float flipRescueForwardForcePerMass = 7.5f;

	[SerializeField]
	[Min(0f)]
	private float flipRescueForceLiftOffset = 0.45f;

	[Header("Wall Stuck Rescue")]
	[SerializeField]
	[Min(0.05f)]
	private float wallStuckRescueDelay = 0.75f;

	[SerializeField]
	[Range(0.1f, 1f)]
	private float wallStuckRescueMinNormalX = 0.6f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckRescueMaxSpeed = 0.4f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckRescueMinEscapeSpeed = 1.1f;

	[SerializeField]
	[Min(0.05f)]
	private float wallStuckRescueCooldown = 1.1f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckRescueTorque = 95f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckRescueForcePerMass = 4.2f;

	[SerializeField]
	[Min(0.05f)]
	private float wallStuckRescueForceDuration = 0.45f;

	[SerializeField]
	[Range(0f, 1f)]
	private float vehicleStuckRescueMinThrottle = 0.55f;

	[SerializeField]
	[Range(0f, 1f)]
	private float vehicleStuckRescueMinContactDot = 0.35f;

	[SerializeField]
	[Min(0.05f)]
	private float vehicleStuckRescueContactHold = 0.28f;

	[SerializeField]
	[Min(0.05f)]
	private float vehicleStuckPairRescueMinHold = 1.05f;

	[SerializeField]
	[Min(0f)]
	private float vehicleStuckPairMaxRelativeSpeed = 2.8f;

	[SerializeField]
	[Range(-1f, 1f)]
	private float vehicleStuckPairFacingDotMax = -0.35f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckRescueImpulsePerMass = 3.8f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckRescueLiftImpulsePerMass = 1.4f;

	[SerializeField]
	[Min(0.05f)]
	private float wallStuckPairIgnoreDuration = 0.3f;

	[SerializeField]
	[Min(0.05f)]
	private float wallStuckDriveSuppressDuration = 0.45f;

	[SerializeField]
	[Range(0f, 1f)]
	private float wallStuckDriveSuppressScale = 0.12f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckChaosImpulsePerMass = 8.5f;

	[SerializeField]
	[Min(0f)]
	private float wallStuckChaosLiftPerMass = 3.6f;

	[SerializeField]
	[Range(0f, 1f)]
	private float wallStuckChaosRandomness = 0.65f;

	[SerializeField]
	[Range(0.25f, 1f)]
	private float wallStuckRescueBaseForceScale = 0.55f;

	[SerializeField]
	[Range(0f, 1f)]
	private float wallStuckRescueForceScaleStep = 0.2f;

	[SerializeField]
	[Min(1f)]
	private int wallStuckRescueMaxEscalationSteps = 3;

	[SerializeField]
	[Range(0.35f, 1f)]
	private float suspensionTravelScale = 0.72f;

	[SerializeField]
	[Min(0.05f)]
	private float rescueDisableWheelColliderDuration = 0.55f;

	[Header("Collision Force")]
	[SerializeField]
	[Min(0f)]
	private float collisionForceScale = 0.072f;

	[SerializeField]
	[Min(0f)]
	private float collisionStayImpactCooldown = 0.08f;

	[SerializeField]
	[Min(0f)]
	private float collisionStayImpactMinApproachSpeed = 1.25f;

	private readonly List<VehicleAssembler.InstalledModuleRecord> wheelRecords = new List<VehicleAssembler.InstalledModuleRecord>(8);

	private readonly List<WheelRuntime> wheels = new List<WheelRuntime>(8);

	private readonly List<DebugWheelState> debugWheels = new List<DebugWheelState>(8);

	private readonly List<QueuedRecoilImpulse> pendingRecoilImpulses = new List<QueuedRecoilImpulse>(8);

	private readonly List<CircleCollider2D> wheelVisualColliders = new List<CircleCollider2D>(4);

	private ContactFilter2D wheelContactFilter;

	private ContactFilter2D penetrationContactFilter;

	private Collider2D[] contactBuffer;

	private readonly Collider2D[] dynamicContactBuffer = new Collider2D[12];

	private readonly Collider2D[] penetrationContactBuffer = new Collider2D[8];

	private float throttleInput;

	private float steerInput;

	private float totalMass;

	private Vector2 centerOfMassLocal;

	private float derivedMaxLinearSpeed = 8f;

	private float derivedDriveForce = 90f;

	private float utilityEnginePowerBonus;

	private float utilityStabilityBonus;

	private float utilityBatteryBonus;

	private float utilityArmorBonus;

	private float targetRideHeightWorld;

	private Vector2 lastRecoilForce;

	private Vector2 lastRecoilPoint;

	private float lastRecoilTime = -99f;

	private float recoilDriveSuppressionUntil = -99f;

	private Vector2 lastWheelMotorForceSum;

	private float lastWheelMaxSlipRatio;

	private float smoothedAssistTorque;

	private float smoothedLaneAssistForce;

	private float lastUprightAssistTorque;

	private float lastFlipAssistTorque;

	private float lastLaneAssistForce;

	private float lastAngularAssistTorque;

	private bool runtimeTuningReady;

	private bool rebuildSuspended;

	private int groundedWheelCount;

	private float flipRescueEligibleTimer;

	private bool flipRescueActive;

	private float flipRescueUntil;

	private float wallStuckContactTimer;

	private float wallStuckCooldownUntil;

	private Vector2 wallStuckNormalAccumulator;

	private float wallBoundaryTouchUntil;

	private Vector2 wallBoundaryTouchNormal;

	private bool wallStuckRescueActive;

	private float wallStuckRescueUntil;

	private float wallStuckRescueSign;

	private bool driveAudioActive;

	private float vehicleStuckContactTimer;

	private Vector2 vehicleStuckNormalAccumulator;

	private Rigidbody2D vehicleStuckCandidatePairBody;

	private Rigidbody2D wallStuckPairBody;

	private float wallStuckPairIgnoreUntil = -1f;

	private float wallStuckDriveSuppressUntil = -1f;

	private Rigidbody2D recentDynamicContactBody;

	private Vector2 recentDynamicContactNormal;

	private float recentDynamicContactRelativeSpeed;

	private float recentDynamicContactUntil = -1f;

	private float nextCollisionStayImpactAt;

	private float collisionImpactSuppressUntil = -1f;

	private float hookMotionSuppressUntil = -1f;

	private float hookMotionSuppressHorizontalSpeedLimit;

	private float hookMotionSuppressVerticalSpeedLimit;

	private float hookMotionSuppressAngularSpeedLimit;

	private float nextVehicleStuckBlockedLogAt = -1f;

	private SummerRaceEnemy cachedEnemyHost;

	private int wallStuckRescueEscalationStep;

	private float wheelColliderRestoreAt = -1f;

	public float TotalMass => totalMass;

	public Vector2 CenterOfMassLocal => centerOfMassLocal;

	public Vector2 CenterOfMassWorld
	{
		get
		{
			if (!Application.isPlaying)
			{
				if (!(rb != null))
				{
					return base.transform.position;
				}
				return rb.worldCenterOfMass;
			}
			return RequireRuntimeBody("CenterOfMassWorld").worldCenterOfMass;
		}
	}

	public float DerivedMaxLinearSpeed => derivedMaxLinearSpeed;

	public float DerivedDriveForce => derivedDriveForce;

	public float UtilityBatteryBonus => utilityBatteryBonus;

	public float UtilityArmorBonus => utilityArmorBonus;

	public float LastRecoilAge => Time.time - lastRecoilTime;

	public Vector2 LastRecoilForce => lastRecoilForce;

	public Vector2 LastRecoilPoint => lastRecoilPoint;

	public float TargetRideHeightWorld => targetRideHeightWorld;

	public Vector2 VelocityWorld
	{
		get
		{
			if (!Application.isPlaying)
			{
				if (!(rb != null))
				{
					return Vector2.zero;
				}
				return rb.velocity;
			}
			return RequireRuntimeBody("VelocityWorld").velocity;
		}
	}

	public bool IsFlipRescueActive => flipRescueActive;

	private bool IsCollisionImpactSuppressed => Time.time < collisionImpactSuppressUntil;

	private bool IsHookMotionSuppressed => Time.time < hookMotionSuppressUntil;

	public float DebugAssistTorqueUpright => lastUprightAssistTorque;

	public float DebugAssistTorqueFlip => lastFlipAssistTorque;

	public float DebugAssistTorqueLane => lastLaneAssistForce;

	public int ActiveRecoilPulseCount => pendingRecoilImpulses.Count;

	private bool IsPlayerVehicleAudioSource => GetComponent<SummerRacePlayerController>() != null;

	public void SuppressCollisionImpactForce(float duration)
	{
		if (!(duration <= 0f))
		{
			collisionImpactSuppressUntil = Mathf.Max(collisionImpactSuppressUntil, Time.time + duration);
			nextCollisionStayImpactAt = Mathf.Max(nextCollisionStayImpactAt, collisionImpactSuppressUntil);
			CancelWallStuckRescueForCollisionSuppression();
		}
	}

	public void SuppressHookLatchMotion(float duration, float horizontalSpeedLimit, float verticalSpeedLimit, float angularSpeedLimit)
	{
		if (!(duration <= 0f))
		{
			hookMotionSuppressUntil = Mathf.Max(hookMotionSuppressUntil, Time.time + duration);
			hookMotionSuppressHorizontalSpeedLimit = Mathf.Max(hookMotionSuppressHorizontalSpeedLimit, Mathf.Max(0f, horizontalSpeedLimit));
			hookMotionSuppressVerticalSpeedLimit = Mathf.Max(hookMotionSuppressVerticalSpeedLimit, Mathf.Max(0f, verticalSpeedLimit));
			hookMotionSuppressAngularSpeedLimit = Mathf.Max(hookMotionSuppressAngularSpeedLimit, Mathf.Max(0f, angularSpeedLimit));
			SuppressCollisionImpactForce(duration);
			ClearHookSuppressedDriveInputs();
			ApplyHookLatchMotionSuppression();
		}
	}

	public void ClearHookLatchMotionSuppression()
	{
		hookMotionSuppressUntil = -1f;
		hookMotionSuppressHorizontalSpeedLimit = 0f;
		hookMotionSuppressVerticalSpeedLimit = 0f;
		hookMotionSuppressAngularSpeedLimit = 0f;
	}

	private void Reset()
	{
		rb = GetComponent<Rigidbody2D>();
		assembler = GetComponent<VehicleAssembler>();
	}

	private void Awake()
	{
		if (rb == null)
		{
			rb = GetComponent<Rigidbody2D>();
		}
		if (assembler == null)
		{
			assembler = GetComponent<VehicleAssembler>();
		}
		BuildContactFilter();
		EnsureConstraintPolicy(RequireRuntimeBody("Awake"));
	}

	private void OnEnable()
	{
		if (assembler != null)
		{
			assembler.OnAssemblyChanged += RebuildVehiclePhysics;
		}
		BuildContactFilter();
		EnsureConstraintPolicy(RequireRuntimeBody("OnEnable"));
		if (runtimeTuningReady)
		{
			RebuildVehiclePhysics();
		}
	}

	private void OnDisable()
	{
		if (assembler != null)
		{
			assembler.OnAssemblyChanged -= RebuildVehiclePhysics;
		}
		StopDriveAudio();
		ClearWallStuckPairIgnoreCollision(forceRelease: true);
	}

	private void OnValidate()
	{
		maxContactPerWheel = Mathf.Clamp(maxContactPerWheel, 4, 64);
		BuildContactFilter();
	}

	private void BuildContactFilter()
	{
		maxContactPerWheel = Mathf.Max(1, maxContactPerWheel);
		wheelContactFilter = new ContactFilter2D
		{
			useLayerMask = true,
			layerMask = groundMask,
			useTriggers = false
		};
		penetrationContactFilter = new ContactFilter2D
		{
			useLayerMask = false,
			useTriggers = false
		};
		if (contactBuffer == null || contactBuffer.Length != maxContactPerWheel)
		{
			contactBuffer = new Collider2D[maxContactPerWheel];
		}
	}

	public void ApplyRuntimeTuning(SummerRaceRuntimePhysicsTuningData tuning)
	{
		if (tuning == null)
		{
			throw new ArgumentNullException("tuning");
		}
		useContactProbe = tuning.useContactProbe;
		suspensionProbeExtra = tuning.suspensionProbeExtra;
		maxContactPerWheel = Mathf.Max(1, tuning.maxContactPerWheel);
		exaggerateBuildDifference = tuning.exaggerateBuildDifference;
		massDistributionAmplify = tuning.massDistributionAmplify;
		recoilAmplify = tuning.recoilAmplify;
		centerOfMassOffsetAmplify = tuning.centerOfMassOffsetAmplify;
		wheelAsymmetryYawAmplify = tuning.wheelAsymmetryYawAmplify;
		comBiasYawAmplify = tuning.comBiasYawAmplify;
		recoilMassReference = tuning.recoilMassReference;
		driveForceAmplify = tuning.driveForceAmplify;
		tractionAmplify = tuning.tractionAmplify;
		driveLoadTransferStrength = Mathf.Max(0f, tuning.driveLoadTransferStrength);
		dynamicSupportDriveScale = Mathf.Clamp01(tuning.dynamicSupportDriveScale);
		dynamicSupportRollingDragScale = Mathf.Clamp01(tuning.dynamicSupportRollingDragScale);
		dynamicSupportSpringScale = Mathf.Clamp(tuning.dynamicSupportSpringScale, 0.2f, 1f);
		steerTorque = tuning.steerTorque;
		speedClampMultiplier = tuning.speedClampMultiplier;
		slipToForceGain = tuning.slipToForceGain;
		maxAngularSpeedDegPerSec = tuning.maxAngularSpeedDegPerSec;
		uprightAssistDamping = tuning.uprightAssistDamping;
		minUprightAssist = tuning.minUprightAssist;
		maxUprightAssist = tuning.maxUprightAssist;
		collisionForceScale = Mathf.Max(0f, tuning.collisionForceScale);
		flipRescueForwardForcePerMass = Mathf.Max(0.01f, tuning.flipRescueForwardForcePerMass);
		flipRescueForceLiftOffset = Mathf.Max(0f, tuning.flipRescueForceLiftOffset);
		flipRescueTiltAngleThreshold = Mathf.Clamp(flipRescueTiltAngleThreshold, 45f, 170f);
		wallStuckRescueDelay = Mathf.Clamp(tuning.wallStuckRescueDelay * 0.45f, 0.08f, 0.28f);
		wallStuckRescueMinNormalX = Mathf.Clamp(tuning.wallStuckRescueMinNormalX, 0.1f, 1f);
		wallStuckRescueMaxSpeed = Mathf.Max(1.2f, tuning.wallStuckRescueMaxSpeed * 2.2f);
		wallStuckRescueMinEscapeSpeed = Mathf.Max(3.6f, tuning.wallStuckRescueMinEscapeSpeed * 2.8f);
		wallStuckRescueCooldown = Mathf.Clamp(tuning.wallStuckRescueCooldown * 0.5f, 0.18f, 0.55f);
		wallStuckRescueTorque = Mathf.Max(220f, tuning.wallStuckRescueTorque * 2.2f);
		wallStuckRescueForcePerMass = Mathf.Max(9.5f, tuning.wallStuckRescueForcePerMass * 2.6f);
		wallStuckRescueForceDuration = Mathf.Max(0.72f, tuning.wallStuckRescueForceDuration * 1.8f);
		vehicleStuckRescueMinThrottle = Mathf.Clamp(Mathf.Max(0.35f, tuning.vehicleStuckRescueMinThrottle), 0.25f, 0.75f);
		vehicleStuckRescueMinContactDot = Mathf.Clamp(Mathf.Max(0.65f, tuning.vehicleStuckRescueMinContactDot), 0.45f, 0.95f);
		vehicleStuckRescueContactHold = Mathf.Clamp(Mathf.Max(0.6f, tuning.vehicleStuckRescueContactHold), 0.45f, 1.1f);
		vehicleStuckPairRescueMinHold = Mathf.Clamp(vehicleStuckPairRescueMinHold, 0.9f, 1.6f);
		vehicleStuckPairMaxRelativeSpeed = Mathf.Clamp(vehicleStuckPairMaxRelativeSpeed, 0.15f, 4.5f);
		vehicleStuckPairFacingDotMax = Mathf.Clamp(vehicleStuckPairFacingDotMax, -1f, 0.2f);
		wallStuckRescueImpulsePerMass = Mathf.Max(0f, wallStuckRescueImpulsePerMass);
		wallStuckRescueLiftImpulsePerMass = Mathf.Max(0f, wallStuckRescueLiftImpulsePerMass);
		wallStuckPairIgnoreDuration = Mathf.Clamp(wallStuckPairIgnoreDuration, 0.05f, 0.45f);
		wallStuckDriveSuppressDuration = Mathf.Clamp(wallStuckDriveSuppressDuration, 0.05f, 0.65f);
		wallStuckDriveSuppressScale = Mathf.Clamp01(wallStuckDriveSuppressScale);
		wallStuckChaosImpulsePerMass = Mathf.Max(0f, wallStuckChaosImpulsePerMass);
		wallStuckChaosLiftPerMass = Mathf.Max(0f, wallStuckChaosLiftPerMass);
		wallStuckChaosRandomness = Mathf.Clamp01(wallStuckChaosRandomness);
		wallStuckRescueBaseForceScale = Mathf.Clamp(wallStuckRescueBaseForceScale, 0.25f, 1f);
		wallStuckRescueForceScaleStep = Mathf.Clamp01(wallStuckRescueForceScaleStep);
		wallStuckRescueMaxEscalationSteps = Mathf.Max(1, wallStuckRescueMaxEscalationSteps);
		suspensionTravelScale = Mathf.Clamp(suspensionTravelScale, 0.35f, 1f);
		rescueDisableWheelColliderDuration = Mathf.Clamp(rescueDisableWheelColliderDuration, 0.05f, 1.5f);
		ValidateRuntimeTuning();
		BuildContactFilter();
		runtimeTuningReady = true;
	}

	public void SetRebuildSuspended(bool suspended)
	{
		rebuildSuspended = suspended;
	}

	private void ValidateRuntimeTuning()
	{
		if (!useContactProbe || suspensionProbeExtra <= 0f || maxContactPerWheel <= 0 || massDistributionAmplify <= 0f || recoilAmplify <= 0f || centerOfMassOffsetAmplify.x <= 0f || centerOfMassOffsetAmplify.y <= 0f || recoilMassReference <= 0f || driveForceAmplify <= 0f || tractionAmplify <= 0f || driveLoadTransferStrength < 0f || dynamicSupportDriveScale < 0f || dynamicSupportRollingDragScale < 0f || dynamicSupportSpringScale <= 0f || dynamicSupportSpringScale > 1f || steerTorque <= 0f || speedClampMultiplier <= 0f || slipToForceGain <= 0f || maxAngularSpeedDegPerSec <= 0f || angularExcessDampingGain <= 0f || uprightAssistDamping < 0f || minUprightAssist < 0f || maxUprightAssist < minUprightAssist || collisionForceScale < 0f || minSupportNormalY <= 0f || minSupportNormalY >= 1f || contactNormalSmoothing <= 0f || compressionSmoothing <= 0f || contactSupportScoreWeight <= 0f || contactDistanceScoreWeight <= 0f || dynamicSupportNormalYMin <= 0f || dynamicSupportNormalYMin >= 1f || dynamicSupportMaxRelativeNormalSpeed < 0f || dynamicSupportScoreAdvantage < 0f || supportSwitchHysteresis < 0f || penetratingContactScoreBonus < 0f || overlapDepenetrationForcePerMass <= 0f || overlapDepenetrationMaxForcePerMass <= 0f || penetratingContactMinSupportWeight < 0f || penetratingContactMinSupportWeight > 1f || minCriticalDampingRatio <= 0f || compressionDampingScale <= 0f || reboundDampingScale <= 0f || wallContactDriveScale < 0f || wallContactDriveScale > 1f || wallContactRollingDragScale < 0f || wallContactRollingDragScale > 1f || flipRescueForwardForcePerMass <= 0f || flipRescueForceLiftOffset < 0f || flipRescueTiltAngleThreshold < 0f || flipRescueTiltAngleThreshold > 180f || wallStuckRescueDelay <= 0f || wallStuckRescueMinNormalX <= 0f || wallStuckRescueMinNormalX > 1f || wallStuckRescueMaxSpeed < 0f || wallStuckRescueMinEscapeSpeed < 0f || wallStuckRescueCooldown <= 0f || wallStuckRescueTorque < 0f || wallStuckRescueForcePerMass < 0f || wallStuckRescueForceDuration <= 0f || vehicleStuckRescueMinThrottle < 0f || vehicleStuckRescueMinThrottle > 1f || vehicleStuckRescueMinContactDot < 0f || vehicleStuckRescueMinContactDot > 1f || vehicleStuckRescueContactHold <= 0f || vehicleStuckPairRescueMinHold <= 0f || vehicleStuckPairMaxRelativeSpeed < 0f || vehicleStuckPairFacingDotMax < -1f || vehicleStuckPairFacingDotMax > 1f || wallStuckRescueImpulsePerMass < 0f || wallStuckRescueLiftImpulsePerMass < 0f || wallStuckPairIgnoreDuration <= 0f || wallStuckDriveSuppressDuration <= 0f || wallStuckDriveSuppressScale < 0f || wallStuckDriveSuppressScale > 1f || wallStuckChaosImpulsePerMass < 0f || wallStuckChaosLiftPerMass < 0f || wallStuckChaosRandomness < 0f || wallStuckChaosRandomness > 1f || wallStuckRescueBaseForceScale <= 0f || wallStuckRescueBaseForceScale > 1f || wallStuckRescueForceScaleStep < 0f || wallStuckRescueForceScaleStep > 1f || wallStuckRescueMaxEscalationSteps <= 0 || suspensionTravelScale <= 0f || suspensionTravelScale > 1f || rescueDisableWheelColliderDuration <= 0f || bumpStopStart < 0f || bumpStopStart >= 1f || bumpStopRange <= 0f || bumpStopStrength < 0f)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Invalid runtime tuning.");
		}
	}

	public void RebuildVehiclePhysics()
	{
		if (!rebuildSuspended && runtimeTuningReady)
		{
			Rigidbody2D rigidbody2D = RequireRuntimeBody("RebuildVehiclePhysics");
			VehicleAssembler vehicleAssembler = RequireRuntimeAssembler("RebuildVehiclePhysics");
			ChassisDefinition chassis = RequireRuntimeChassis("RebuildVehiclePhysics");
			IReadOnlyList<VehicleAssembler.InstalledModuleRecord> installedModules = vehicleAssembler.InstalledModules;
			EnsureConstraintPolicy(rigidbody2D);
			totalMass = ComputeTotalMass(chassis, installedModules);
			centerOfMassLocal = ComputeCenterOfMass(chassis, installedModules);
			rigidbody2D.mass = Mathf.Max(0.01f, totalMass);
			rigidbody2D.centerOfMass = centerOfMassLocal;
			BuildWheelRuntime(vehicleAssembler);
			ComputeDerivedDriveData(rigidbody2D, chassis);
			ApplyBaseDragAndInertiaTrend(rigidbody2D, chassis, installedModules);
			wallStuckContactTimer = 0f;
			wallStuckNormalAccumulator = Vector2.zero;
			vehicleStuckContactTimer = 0f;
			vehicleStuckNormalAccumulator = Vector2.zero;
			vehicleStuckCandidatePairBody = null;
			wallBoundaryTouchUntil = -1f;
			wallBoundaryTouchNormal = Vector2.zero;
			wallStuckRescueActive = false;
			wallStuckRescueUntil = -1f;
			wallStuckRescueSign = 0f;
			wallStuckDriveSuppressUntil = -1f;
			wallStuckRescueEscalationStep = 0;
			wheelColliderRestoreAt = -1f;
			recentDynamicContactBody = null;
			recentDynamicContactNormal = Vector2.zero;
			recentDynamicContactRelativeSpeed = 0f;
			recentDynamicContactUntil = -1f;
			ClearWallStuckPairIgnoreCollision(forceRelease: true);
		}
	}

	private void EnsureConstraintPolicy(Rigidbody2D body)
	{
		RigidbodyConstraints2D constraints = body.constraints;
		constraints &= ~RigidbodyConstraints2D.FreezePositionY;
		constraints &= ~RigidbodyConstraints2D.FreezeRotation;
		body.constraints = constraints;
	}

	public float ComputeTotalMass()
	{
		ChassisDefinition chassis = RequireRuntimeChassis("ComputeTotalMass");
		IReadOnlyList<VehicleAssembler.InstalledModuleRecord> installedModules = RequireRuntimeAssembler("ComputeTotalMass").InstalledModules;
		return ComputeTotalMass(chassis, installedModules);
	}

	private float ComputeTotalMass(ChassisDefinition chassis, IReadOnlyList<VehicleAssembler.InstalledModuleRecord> installed)
	{
		float num = Mathf.Max(0.01f, chassis.baseMass);
		utilityEnginePowerBonus = 0f;
		utilityStabilityBonus = 0f;
		utilityBatteryBonus = 0f;
		utilityArmorBonus = 0f;
		for (int i = 0; i < installed.Count; i++)
		{
			ModuleDefinition module = installed[i].module;
			if (!(module == null))
			{
				num += Mathf.Max(0f, module.mass);
				if (module is UtilityModuleDefinition utilityModuleDefinition)
				{
					num += Mathf.Max(0f, utilityModuleDefinition.ExtraMassValue);
					utilityEnginePowerBonus += utilityModuleDefinition.EnginePowerBonusValue;
					utilityStabilityBonus += utilityModuleDefinition.StabilityBonusValue;
					utilityBatteryBonus += utilityModuleDefinition.BatteryBonusValue;
					utilityArmorBonus += utilityModuleDefinition.ArmorBonusValue;
				}
			}
		}
		return Mathf.Max(0.01f, num);
	}

	public Vector2 ComputeCenterOfMass()
	{
		ChassisDefinition chassis = RequireRuntimeChassis("ComputeCenterOfMass");
		IReadOnlyList<VehicleAssembler.InstalledModuleRecord> installedModules = RequireRuntimeAssembler("ComputeCenterOfMass").InstalledModules;
		return ComputeCenterOfMass(chassis, installedModules);
	}

	private Vector2 ComputeCenterOfMass(ChassisDefinition chassis, IReadOnlyList<VehicleAssembler.InstalledModuleRecord> installed)
	{
		float num = Mathf.Max(0.01f, chassis.baseMass);
		Vector2 vector = chassis.baseCenterOfMassOffset * num;
		for (int i = 0; i < installed.Count; i++)
		{
			VehicleAssembler.InstalledModuleRecord installedModuleRecord = installed[i];
			if (!(installedModuleRecord.mountPoint == null) && !(installedModuleRecord.module == null))
			{
				ModuleDefinition module = installedModuleRecord.module;
				Vector2 vector2 = (Vector2)base.transform.InverseTransformPoint(installedModuleRecord.mountPoint.transform.position) + module.localMassOffset;
				float num2 = Mathf.Max(0f, module.mass);
				Vector2 vector3 = vector2;
				if (module is UtilityModuleDefinition utilityModuleDefinition)
				{
					num2 += Mathf.Max(0f, utilityModuleDefinition.ExtraMassValue);
					vector3 += utilityModuleDefinition.CenterOfMassOffsetContributionValue;
				}
				if (!(num2 <= 0f))
				{
					num += num2;
					vector += vector3 * num2;
				}
			}
		}
		return vector / Mathf.Max(0.01f, num);
	}

	public void ApplyDrive(float throttle)
	{
		throttleInput = Mathf.Clamp(throttle, -1f, 1f);
		TickDriveAudioState();
	}

	public void ApplySteering(float steer)
	{
		steerInput = Mathf.Clamp(steer, -1f, 1f);
	}

	public void ApplyWeaponRecoil(Vector2 force, Vector2 worldPos)
	{
		ApplyWeaponRecoil(force, worldPos, 0f, 0f);
	}

	public void ApplyWeaponRecoil(Vector2 force, Vector2 worldPos, float recoilSpring, float recoilDamping)
	{
		if (float.IsNaN(force.x) || float.IsInfinity(force.x) || float.IsNaN(force.y) || float.IsInfinity(force.y))
		{
			Vector2 vector = force;
			throw new InvalidOperationException("[VehiclePhysicsController] Non-finite recoil force rejected. force=" + vector.ToString());
		}
		if (float.IsNaN(worldPos.x) || float.IsInfinity(worldPos.x) || float.IsNaN(worldPos.y) || float.IsInfinity(worldPos.y))
		{
			Vector2 vector = worldPos;
			throw new InvalidOperationException("[VehiclePhysicsController] Non-finite recoil worldPos rejected. worldPos=" + vector.ToString());
		}
		if (force.sqrMagnitude <= 0.0001f)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ApplyWeaponRecoil");
		Vector2 vector2 = ResolveGameplayRecoilImpulse(force, rigidbody2D.mass);
		if (float.IsNaN(vector2.x) || float.IsInfinity(vector2.x) || float.IsNaN(vector2.y) || float.IsInfinity(vector2.y))
		{
			string[] obj = new string[6] { "[VehiclePhysicsController] Non-finite gameplay recoil impulse detected. impulse=", null, null, null, null, null };
			Vector2 vector = vector2;
			obj[1] = vector.ToString();
			obj[2] = " rawForce=";
			vector = force;
			obj[3] = vector.ToString();
			obj[4] = " mass=";
			obj[5] = rigidbody2D.mass.ToString("F4");
			throw new InvalidOperationException(string.Concat(obj));
		}
		if (vector2.sqrMagnitude <= 0.0001f)
		{
			return;
		}
		float num = Mathf.Clamp01(recoilImmediateFraction);
		Vector2 vector3 = vector2 * num;
		Vector2 velocity = rigidbody2D.velocity;
		if (vector3.sqrMagnitude > 0.0001f)
		{
			rigidbody2D.AddForceAtPosition(vector3, worldPos, ForceMode2D.Impulse);
		}
		Vector2 vector4 = vector2 - vector3;
		if (vector4.sqrMagnitude > 0.0001f)
		{
			float num2 = Mathf.Max(0.0001f, Time.fixedDeltaTime);
			float num3 = ResolveRecoilPulseDuration(recoilSpring, recoilDamping, num2);
			if (recoilTailDurationCap > 0f)
			{
				num3 = Mathf.Min(num3, recoilTailDurationCap);
			}
			pendingRecoilImpulses.Add(new QueuedRecoilImpulse
			{
				remainingImpulse = vector4,
				worldPos = worldPos,
				duration = Mathf.Max(num2, num3),
				elapsed = 0f
			});
		}
		if (enableRecoilTraceLog && SummerRaceRuntimeLog.IsGameplayVerboseEnabled)
		{
			string[] array = new string[30];
			array[0] = "[SummerRace][RecoilTrace][Physics] owner=";
			array[1] = base.name;
			array[2] = " rawForce=";
			Vector2 vector = force;
			array[3] = vector.ToString();
			array[4] = " gameplayImpulse=";
			vector = vector2;
			array[5] = vector.ToString();
			array[6] = " immediateFraction=";
			array[7] = num.ToString("F3");
			array[8] = " immediateImpulse=";
			vector = vector3;
			array[9] = vector.ToString();
			array[10] = " tailImpulse=";
			vector = vector4;
			array[11] = vector.ToString();
			array[12] = " rb.mass=";
			array[13] = rigidbody2D.mass.ToString("F3");
			array[14] = " recoilAmplify=";
			array[15] = recoilAmplify.ToString("F3");
			array[16] = " recoilMassReference=";
			array[17] = recoilMassReference.ToString("F3");
			array[18] = " worldPos=";
			vector = worldPos;
			array[19] = vector.ToString();
			array[20] = " velBefore=";
			vector = velocity;
			array[21] = vector.ToString();
			array[22] = " velAfter=";
			array[23] = rigidbody2D.velocity.ToString();
			array[24] = " queuedTailCount=";
			array[25] = pendingRecoilImpulses.Count.ToString();
			array[26] = " t=";
			array[27] = Time.time.ToString("F3");
			array[28] = " frame=";
			array[29] = Time.frameCount.ToString();
			SummerRaceRuntimeLog.Verbose(string.Concat(array));
		}
		lastRecoilForce = vector2;
		lastRecoilPoint = worldPos;
		lastRecoilTime = Time.time;
		recoilDriveSuppressionUntil = Mathf.Max(recoilDriveSuppressionUntil, Time.time + Mathf.Max(0f, recoilDriveSuppressionDuration));
	}

	private Rigidbody2D RequireRuntimeBody(string context)
	{
		if (rb == null)
		{
			rb = GetComponent<Rigidbody2D>();
			if (rb == null)
			{
				throw new InvalidOperationException("[VehiclePhysicsController] Rigidbody is missing (" + context + ") on " + base.name);
			}
		}
		return rb;
	}

	private VehicleAssembler RequireRuntimeAssembler(string context)
	{
		if (assembler == null)
		{
			assembler = GetComponent<VehicleAssembler>();
			if (assembler == null)
			{
				throw new InvalidOperationException("[VehiclePhysicsController] Vehicle assembler is missing (" + context + ") on " + base.name);
			}
		}
		return assembler;
	}

	private ChassisDefinition RequireRuntimeChassis(string context)
	{
		VehicleAssembler vehicleAssembler = RequireRuntimeAssembler(context);
		if (vehicleAssembler.ChassisDefinition == null)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Chassis definition is missing (" + context + ") on " + base.name);
		}
		return vehicleAssembler.ChassisDefinition;
	}

	private int RequireRuntimeWheelCount(string context)
	{
		if (wheels == null || wheels.Count <= 0)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Wheel runtime is missing (" + context + ") on " + base.name);
		}
		return wheels.Count;
	}

	public void CopyDebugWheelStates(List<DebugWheelState> outStates)
	{
		if (outStates != null)
		{
			outStates.Clear();
			outStates.AddRange(debugWheels);
		}
	}

	private void FixedUpdate()
	{
		FlushQueuedWeaponRecoil();
		if (!runtimeTuningReady)
		{
			return;
		}
		RequireRuntimeBody("FixedUpdate");
		RequireRuntimeChassis("FixedUpdate");
		TickRescueWheelColliderState();
		TickWallStuckPairIgnoreState();
		if (IsHookMotionSuppressed)
		{
			ClearHookSuppressedDriveInputs();
		}
		SimulateWheelSuspensionAndTraction();
		if (!IsHookMotionSuppressed)
		{
			ApplySteerAndMassBiasTorque();
		}
		TickWallStuckRescue();
		ApplyLinearAndAngularSpeedPolicy();
		ApplyHookLatchMotionSuppression();
		if (enableRecoilTraceLog && SummerRaceRuntimeLog.IsGameplayVerboseEnabled && Time.time - lastRecoilTime <= 0.2f)
		{
			Rigidbody2D rigidbody2D = RequireRuntimeBody("FixedUpdate.RecoilChainTrace");
			Vector2 rhs = rigidbody2D.transform.right;
			if (rhs.sqrMagnitude > 0.0001f)
			{
				rhs.Normalize();
			}
			else
			{
				rhs = Vector2.right;
			}
			float num = Vector2.Dot(rigidbody2D.velocity, rhs);
			string[] obj = new string[20]
			{
				"[SummerRace][RecoilTrace][Chain] owner=",
				base.name,
				" age=",
				(Time.time - lastRecoilTime).ToString("F3"),
				" throttle=",
				throttleInput.ToString("F3"),
				" forwardSpeed=",
				num.ToString("F3"),
				" velocity=",
				rigidbody2D.velocity.ToString(),
				" motorForceSum=",
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
			Vector2 vector = lastWheelMotorForceSum;
			obj[11] = vector.ToString();
			obj[12] = " maxSlip=";
			obj[13] = lastWheelMaxSlipRatio.ToString("F3");
			obj[14] = " derivedDriveForce=";
			obj[15] = derivedDriveForce.ToString("F3");
			obj[16] = " pendingTailCount=";
			obj[17] = pendingRecoilImpulses.Count.ToString();
			obj[18] = " frame=";
			obj[19] = Time.frameCount.ToString();
			SummerRaceRuntimeLog.Verbose(string.Concat(obj));
		}
		TickDriveAudioState();
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		TryApplyCollisionImpactForce(collision, isStayContact: false);
		TrackWallBoundaryContact(collision);
		TrackDynamicVehicleContact(collision);
	}

	private void OnCollisionStay2D(Collision2D collision)
	{
		TryApplyCollisionImpactForce(collision, isStayContact: true);
		TrackWallBoundaryContact(collision);
		TrackDynamicVehicleContact(collision);
	}

	private void FlushQueuedWeaponRecoil()
	{
		if (pendingRecoilImpulses.Count <= 0)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequireRuntimeBody("FlushQueuedWeaponRecoil");
		float num = Mathf.Max(0.0001f, Time.fixedDeltaTime);
		for (int num2 = pendingRecoilImpulses.Count - 1; num2 >= 0; num2--)
		{
			QueuedRecoilImpulse value = pendingRecoilImpulses[num2];
			float num3 = Mathf.Max(0f, value.duration - value.elapsed);
			Vector2 vector;
			if (num3 <= num || value.remainingImpulse.sqrMagnitude <= 0.0001f)
			{
				vector = value.remainingImpulse;
				pendingRecoilImpulses.RemoveAt(num2);
			}
			else
			{
				float num4 = Mathf.Clamp01(num / num3);
				vector = value.remainingImpulse * num4;
				value.remainingImpulse -= vector;
				value.elapsed += num;
				pendingRecoilImpulses[num2] = value;
			}
			if (vector.sqrMagnitude > 0.0001f)
			{
				if (float.IsNaN(vector.x) || float.IsInfinity(vector.x) || float.IsNaN(vector.y) || float.IsInfinity(vector.y))
				{
					Vector2 vector2 = vector;
					throw new InvalidOperationException("[VehiclePhysicsController] Non-finite recoil impulse step detected. impulseStep=" + vector2.ToString());
				}
				rigidbody2D.AddForceAtPosition(vector, value.worldPos, ForceMode2D.Impulse);
			}
		}
	}

	private static float ResolveRecoilPulseDuration(float recoilSpring, float recoilDamping, float fixedDt)
	{
		float num = Mathf.Max(0.0001f, fixedDt);
		if (recoilSpring <= 0f || recoilDamping <= 0f)
		{
			return num;
		}
		float num2 = 2f / Mathf.Max(1f, recoilSpring);
		float num3 = 1f / Mathf.Max(0.1f, recoilDamping);
		return Mathf.Max(num, num2 + num3);
	}

	private Vector2 ResolveGameplayRecoilImpulse(Vector2 rawImpulse, float bodyMass)
	{
		float num = Mathf.Max(0.01f, bodyMass);
		float num2 = Mathf.Clamp(recoilMassReference / num, 0.35f, 2.5f);
		return rawImpulse * recoilAmplify * num2;
	}

	private void TryApplyCollisionImpactForce(Collision2D collision, bool isStayContact)
	{
		if (collision == null || collision.contactCount <= 0 || IsCollisionImpactSuppressed)
		{
			return;
		}
		Rigidbody2D runtimeBody = RequireRuntimeBody("TryApplyCollisionImpactForce");
		if (!TryResolveCollisionBodies(collision, runtimeBody, out var selfBody, out var otherBody))
		{
			return;
		}
		Vector2 relativeVelocity = collision.relativeVelocity;
		if (relativeVelocity.magnitude <= 0.01f)
		{
			return;
		}
		ContactPoint2D contact = collision.GetContact(0);
		Vector2 vector = contact.normal;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			vector = -relativeVelocity.normalized;
		}
		else
		{
			vector.Normalize();
		}
		float num = Mathf.Max(0f, Vector2.Dot(-relativeVelocity, vector));
		if (num <= 0.01f)
		{
			return;
		}
		if (isStayContact)
		{
			if (Time.time < nextCollisionStayImpactAt || num < collisionStayImpactMinApproachSpeed)
			{
				return;
			}
			if (collisionStayImpactCooldown > 0f)
			{
				nextCollisionStayImpactAt = Time.time + collisionStayImpactCooldown;
			}
		}
		if (!(collisionForceScale <= 0f))
		{
			float num2 = 0f;
			if (otherBody != null && otherBody.bodyType == RigidbodyType2D.Dynamic)
			{
				num2 = Mathf.Max(0f, otherBody.mass);
			}
			float num3 = Mathf.Max(0.01f, selfBody.mass);
			float num4 = ((num2 > 0f) ? (num3 * num2 / Mathf.Max(0.01f, num3 + num2)) : num3);
			float num5 = num * num4 * collisionForceScale;
			if (!(num5 <= 0.001f))
			{
				Vector2 force = -vector * num5;
				selfBody.AddForceAtPosition(force, contact.point, ForceMode2D.Impulse);
			}
		}
	}

	private bool TryResolveCollisionBodies(Collision2D collision, Rigidbody2D runtimeBody, out Rigidbody2D selfBody, out Rigidbody2D otherBody)
	{
		selfBody = null;
		otherBody = null;
		if (collision == null || runtimeBody == null)
		{
			return false;
		}
		if (collision.otherRigidbody == runtimeBody)
		{
			selfBody = runtimeBody;
			otherBody = collision.rigidbody;
			return true;
		}
		if (collision.rigidbody == runtimeBody)
		{
			selfBody = runtimeBody;
			otherBody = collision.otherRigidbody;
			return true;
		}
		return false;
	}

	private static float StepSignedCommand(float current, float target, float riseRate, float fallRate, float dt)
	{
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

	private void BuildWheelRuntime(VehicleAssembler runtimeAssembler)
	{
		wheels.Clear();
		wheelVisualColliders.Clear();
		runtimeAssembler.GetInstalledWheels(wheelRecords);
		for (int i = 0; i < wheelRecords.Count; i++)
		{
			VehicleAssembler.InstalledModuleRecord installedModuleRecord = wheelRecords[i];
			if (!(installedModuleRecord.mountPoint == null) && installedModuleRecord.module is WheelModuleDefinition def)
			{
				wheels.Add(new WheelRuntime
				{
					mount = installedModuleRecord.mountPoint,
					def = def,
					grounded = false,
					compression = 0f,
					smoothedCompression = 0f,
					compressionVelocity = 0f,
					surfaceBodyType = RigidbodyType2D.Static,
					supportSource = WheelSupportSource.None,
					relativeNormalSpeed = 0f,
					supportSwitchTimer = 0f,
					supportSwitchAccumulator = 0,
					supportSwitchCount1s = 0,
					smoothedNormal = Vector2.up,
					hasSmoothedContact = false,
					contactPoint = installedModuleRecord.mountPoint.transform.position,
					contactNormal = Vector2.zero,
					contactTangent = Vector2.zero,
					appliedMotorForce = Vector2.zero,
					slipRatio = 0f,
					smoothedTargetCompression = 0f
				});
				CircleCollider2D componentInChildren = installedModuleRecord.mountPoint.GetComponentInChildren<CircleCollider2D>(includeInactive: true);
				if (componentInChildren != null)
				{
					wheelVisualColliders.Add(componentInChildren);
				}
			}
		}
	}

	private void ComputeDerivedDriveData(Rigidbody2D body, ChassisDefinition chassis)
	{
		int num = RequireRuntimeWheelCount("ComputeDerivedDriveData");
		float num2 = 0f;
		float num3 = 0f;
		float num4 = 0f;
		float num5 = 0f;
		int num6 = 0;
		for (int i = 0; i < num; i++)
		{
			WheelModuleDefinition def = wheels[i].def;
			num2 += def.radius;
			num3 += def.suspensionLength;
			num4 += def.maxAngularVelocity * def.radius;
			if (def.powered)
			{
				num6++;
				num5 += def.maxMotorTorque / Mathf.Max(0.05f, def.radius);
			}
		}
		float num7 = num2 / (float)num;
		float num8 = num3 / (float)num;
		float num9 = num4 / (float)num;
		float num10 = 1f + utilityEnginePowerBonus;
		derivedMaxLinearSpeed = Mathf.Max(2f, num9 * num10 * speedClampMultiplier);
		float num11 = Mathf.Max(0.5f, (float)num6 / (float)num);
		derivedDriveForce = num5 * num10 * num11 * driveForceAmplify;
		float num12 = body.position.y - centerOfMassLocal.y;
		targetRideHeightWorld = num12 + num7 + num8 + chassis.chassisClearance;
	}

	private void ApplyBaseDragAndInertiaTrend(Rigidbody2D body, ChassisDefinition chassis, IReadOnlyList<VehicleAssembler.InstalledModuleRecord> installed)
	{
		float num = 0f;
		for (int i = 0; i < installed.Count; i++)
		{
			VehicleAssembler.InstalledModuleRecord installedModuleRecord = installed[i];
			if (!(installedModuleRecord.mountPoint == null) && !(installedModuleRecord.module == null))
			{
				Vector2 vector = base.transform.InverseTransformPoint(installedModuleRecord.mountPoint.transform.position);
				vector += installedModuleRecord.module.localMassOffset;
				float num2 = Mathf.Max(0f, installedModuleRecord.module.mass);
				if (installedModuleRecord.module is UtilityModuleDefinition utilityModuleDefinition)
				{
					num2 += Mathf.Max(0f, utilityModuleDefinition.ExtraMassValue);
					vector += utilityModuleDefinition.CenterOfMassOffsetContributionValue;
				}
				num += num2 * (vector - centerOfMassLocal).sqrMagnitude;
			}
		}
		float num3 = (exaggerateBuildDifference ? massDistributionAmplify : 1f);
		body.drag = Mathf.Max(0f, chassis.baseDrag + Mathf.Abs(centerOfMassLocal.x) * 0.08f);
		body.angularDrag = Mathf.Max(0f, chassis.baseAngularDrag + num * 0.015f * num3);
	}

	private void SimulateWheelSuspensionAndTraction()
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("SimulateWheelSuspensionAndTraction");
		int num = RequireRuntimeWheelCount("SimulateWheelSuspensionAndTraction");
		float throttle = ResolveWallStuckEffectiveThrottle();
		debugWheels.Clear();
		Vector2 zero = Vector2.zero;
		float a = 0f;
		groundedWheelCount = 0;
		float wheelBaseHalfSpan = ResolveWheelBaseHalfSpan();
		for (int i = 0; i < num; i++)
		{
			WheelRuntime wheel = wheels[i];
			if (wheel.mount == null || wheel.def == null)
			{
				continue;
			}
			Vector2 vector = wheel.mount.transform.position;
			float radius = wheel.def.radius;
			float num2 = Mathf.Max(0.01f, wheel.def.suspensionLength * suspensionTravelScale);
			bool flag = false;
			float num3 = 0f;
			float num4 = 0f;
			_ = suspensionProbeExtra;
			Vector2 contactPoint = vector;
			Vector2 vector2 = Vector2.zero;
			RigidbodyType2D rigidbodyType2D = RigidbodyType2D.Static;
			WheelSupportSource wheelSupportSource = WheelSupportSource.None;
			float num5 = 0f;
			Vector2 contactTangent = Vector2.zero;
			Vector2 accumulatedMotorForce = Vector2.zero;
			float accumulatedSlipRatio = 0f;
			WheelSupportBlend wheelSupportBlend = TrySampleWheelContact(rigidbody2D, wheel, vector, radius, num2);
			if (wheelSupportBlend.grounded)
			{
				flag = true;
				groundedWheelCount++;
				contactPoint = wheelSupportBlend.contactPoint;
				vector2 = wheelSupportBlend.contactNormal;
				rigidbodyType2D = wheelSupportBlend.contactBodyType;
				wheelSupportSource = wheelSupportBlend.dominantSource;
				num5 = wheelSupportBlend.relativeNormalSpeed;
				float centerToSurface = wheelSupportBlend.centerToSurface;
				wheel.surfaceBodyType = rigidbodyType2D;
				float num6 = centerToSurface - radius;
				num4 = Mathf.Clamp01((num2 - num6) / Mathf.Max(0.01f, num2));
			}
			float num7 = Mathf.Max(0.0001f, Time.fixedDeltaTime);
			float t = 1f - Mathf.Exp((0f - Mathf.Max(0.01f, contactNormalSmoothing)) * num7);
			float targetCompression = num4;
			if (flag)
			{
				if (!wheel.hasSmoothedContact || wheel.smoothedNormal.sqrMagnitude <= 0.0001f)
				{
					wheel.smoothedNormal = vector2;
					wheel.hasSmoothedContact = true;
				}
				else
				{
					Vector2 vector3 = Vector2.Lerp(wheel.smoothedNormal, vector2, t);
					wheel.smoothedNormal = ((vector3.sqrMagnitude > 0.0001f) ? vector3.normalized : vector2);
				}
				vector2 = wheel.smoothedNormal;
			}
			else
			{
				targetCompression = 0f;
			}
			num3 = StepWheelCompressionState(rigidbody2D, num, ref wheel, targetCompression, num2, num7);
			if (flag)
			{
				contactTangent = ComputeForwardTangent(vector2, throttle);
			}
			wheel.grounded = flag;
			wheel.compression = num3;
			wheel.contactPoint = contactPoint;
			wheel.contactNormal = vector2;
			wheel.contactTangent = contactTangent;
			wheel.surfaceBodyType = (flag ? rigidbodyType2D : RigidbodyType2D.Static);
			wheel.primarySupportWeight = (flag ? wheelSupportBlend.primaryWeight : 0f);
			wheel.secondarySupportWeight = (flag ? wheelSupportBlend.secondaryWeight : 0f);
			WheelSupportSource wheelSupportSource2 = (flag ? wheelSupportSource : WheelSupportSource.None);
			if (wheel.supportSource != WheelSupportSource.None && wheel.supportSource != wheelSupportSource2)
			{
				wheel.supportSwitchAccumulator++;
			}
			wheel.supportSwitchTimer += num7;
			if (wheel.supportSwitchTimer >= 1f)
			{
				wheel.supportSwitchTimer--;
				wheel.supportSwitchCount1s = wheel.supportSwitchAccumulator;
				wheel.supportSwitchAccumulator = 0;
			}
			wheel.supportSource = wheelSupportSource2;
			wheel.relativeNormalSpeed = (flag ? num5 : 0f);
			wheel.appliedMotorForce = Vector2.zero;
			wheel.slipRatio = 0f;
			if (flag)
			{
				float b = rigidbody2D.mass / (float)num;
				float b2 = 2f * Mathf.Sqrt(Mathf.Max(0.001f, wheel.def.springStrength) * Mathf.Max(0.01f, b)) * Mathf.Max(0.01f, minCriticalDampingRatio);
				float num8 = Mathf.Max(wheel.def.damping, b2);
				float num9 = ResolveWheelSpringVelocityForForce(wheel.compressionVelocity, num5);
				float dampingScale = ((num9 > 0f) ? Mathf.Max(0.01f, compressionDampingScale) : Mathf.Max(0.01f, reboundDampingScale));
				float value = ResolveWheelSpringMagnitude(wheel.def.springStrength, num2, num3, num9, num8, dampingScale, bumpStopStart, bumpStopRange, bumpStopStrength);
				float num10 = Mathf.Abs(num9) * num8 * 0.45f;
				float max = Mathf.Max(1f, wheel.def.springStrength * (1.05f + bumpStopStrength) + num10);
				value = Mathf.Clamp(value, 0f, max);
				ApplySupportCandidateForces(rigidbody2D, num, vector, wheel, wheelBaseHalfSpan, wheelSupportBlend.primary, wheelSupportBlend.primaryWeight, throttle, num3, value, ref accumulatedMotorForce, ref accumulatedSlipRatio);
				ApplySupportCandidateForces(rigidbody2D, num, vector, wheel, wheelBaseHalfSpan, wheelSupportBlend.secondary, wheelSupportBlend.secondaryWeight, throttle, num3, value, ref accumulatedMotorForce, ref accumulatedSlipRatio);
			}
			wheel.appliedMotorForce = accumulatedMotorForce;
			wheel.slipRatio = accumulatedSlipRatio;
			wheels[i] = wheel;
			zero += accumulatedMotorForce;
			a = Mathf.Max(a, accumulatedSlipRatio);
			debugWheels.Add(new DebugWheelState
			{
				worldPos = vector,
				radius = radius,
				grounded = flag,
				surfaceBodyType = (flag ? rigidbodyType2D : RigidbodyType2D.Static),
				supportSource = wheel.supportSource,
				primarySupportWeight = wheel.primarySupportWeight,
				secondarySupportWeight = wheel.secondarySupportWeight,
				compression = num3,
				compressionVelocity = wheel.compressionVelocity,
				supportSwitchCount1s = ((wheel.supportSwitchTimer > 0.0001f) ? Mathf.Max(wheel.supportSwitchCount1s, (float)wheel.supportSwitchAccumulator / wheel.supportSwitchTimer) : ((float)wheel.supportSwitchCount1s)),
				relativeNormalSpeed = wheel.relativeNormalSpeed,
				contactPoint = contactPoint,
				contactNormal = vector2,
				contactTangent = contactTangent,
				motorForce = accumulatedMotorForce,
				slipRatio = accumulatedSlipRatio
			});
		}
		lastWheelMotorForceSum = zero;
		lastWheelMaxSlipRatio = a;
	}

	private float StepWheelCompressionState(Rigidbody2D body, int wheelCount, ref WheelRuntime wheel, float targetCompression, float suspensionLength, float dt)
	{
		float num = Mathf.Max(0.01f, suspensionLength);
		float num2 = Mathf.Max(0.01f, body.mass / (float)wheelCount);
		float num3 = Mathf.Max(0.001f, (wheel.def != null) ? wheel.def.springStrength : 1f);
		float num4 = Mathf.Sqrt(num3 / num2);
		float num5 = 2f * Mathf.Sqrt(num3 * num2);
		float b = ((wheel.def != null && num5 > 0.0001f) ? (wheel.def.damping / num5) : 1f);
		float num6 = Mathf.Max(Mathf.Max(0.01f, minCriticalDampingRatio), b);
		float b2 = Mathf.Clamp01(targetCompression);
		float t = 1f - Mathf.Exp((0f - Mathf.Max(0.01f, compressionSmoothing)) * dt);
		wheel.smoothedTargetCompression = Mathf.Lerp(Mathf.Clamp01(wheel.smoothedTargetCompression), b2, t);
		float num7 = wheel.smoothedTargetCompression * num;
		float num8 = Mathf.Clamp01(wheel.smoothedCompression) * num;
		float compressionVelocity = wheel.compressionVelocity;
		float num9 = (num7 - num8) * num4 * num4 - 2f * num6 * num4 * compressionVelocity;
		compressionVelocity += num9 * dt;
		float num10 = Mathf.Max(0.01f, num * Mathf.Max(2.5f, compressionSmoothing * 0.12f));
		compressionVelocity = Mathf.Clamp(compressionVelocity, 0f - num10, num10);
		num8 += compressionVelocity * dt;
		if (num8 <= 0f)
		{
			num8 = 0f;
			if (compressionVelocity < 0f)
			{
				compressionVelocity = DampBoundaryCompressionVelocity(compressionVelocity, num4, num6, dt);
			}
		}
		else if (num8 >= num)
		{
			num8 = num;
			if (compressionVelocity > 0f)
			{
				compressionVelocity = DampBoundaryCompressionVelocity(compressionVelocity, num4, num6, dt);
			}
		}
		wheel.compressionVelocity = compressionVelocity;
		wheel.smoothedCompression = num8 / num;
		return wheel.smoothedCompression;
	}

	private static float ResolveWheelSpringMagnitude(float springStrength, float suspensionLength, float compression, float springVelocity, float effectiveDamping, float dampingScale, float bumpStopStart01, float bumpStopRange01, float bumpStopStrength01)
	{
		float num = Mathf.Max(0.01f, suspensionLength);
		float num2 = Mathf.Clamp01(compression);
		float num3 = num2 * num;
		float num4 = Mathf.Max(0f, springStrength) * num3 + springVelocity * Mathf.Max(0f, effectiveDamping) * Mathf.Max(0.01f, dampingScale);
		if (num2 > bumpStopStart01)
		{
			float num5 = Mathf.Clamp01((num2 - bumpStopStart01) / Mathf.Max(0.0001f, bumpStopRange01));
			num4 += Mathf.Max(0f, springStrength) * num5 * num5 * Mathf.Max(0f, bumpStopStrength01);
		}
		return num4;
	}

	private static float ResolveWheelSpringVelocityForForce(float compressionVelocity, float relativeNormalSpeed)
	{
		if (Mathf.Abs(compressionVelocity) > 0.0001f)
		{
			return compressionVelocity;
		}
		return 0f - relativeNormalSpeed;
	}

	private static Vector2 ResolveContainedContactNormal(Collider2D col, Vector2 point, Vector2 fallbackUp)
	{
		Bounds bounds = col.bounds;
		Vector2 vector = bounds.center;
		Vector2 vector2 = bounds.extents;
		Vector2 vector3 = point - vector;
		float num = Mathf.Max(0.0001f, vector2.x - Mathf.Abs(vector3.x));
		float num2 = Mathf.Max(0.0001f, vector2.y - Mathf.Abs(vector3.y));
		Vector2 vector4;
		if (num < num2)
		{
			float x = ((Mathf.Abs(vector3.x) > 0.0001f) ? Mathf.Sign(vector3.x) : ((fallbackUp.x >= 0f) ? 1f : (-1f)));
			vector4 = new Vector2(x, 0f);
		}
		else
		{
			float y = ((Mathf.Abs(vector3.y) > 0.0001f) ? Mathf.Sign(vector3.y) : ((fallbackUp.y >= 0f) ? 1f : (-1f)));
			vector4 = new Vector2(0f, y);
		}
		if (vector4.sqrMagnitude <= 0.0001f)
		{
			if (!(fallbackUp.sqrMagnitude > 0.0001f))
			{
				return Vector2.up;
			}
			return fallbackUp.normalized;
		}
		return vector4.normalized;
	}

	private float ResolveWheelBaseHalfSpan()
	{
		int num = RequireRuntimeWheelCount("ResolveWheelBaseHalfSpan");
		float num2 = 0f;
		for (int i = 0; i < num; i++)
		{
			WheelRuntime wheelRuntime = wheels[i];
			if (!(wheelRuntime.mount == null))
			{
				num2 = Mathf.Max(num2, Mathf.Abs(wheelRuntime.mount.transform.localPosition.x));
			}
		}
		return Mathf.Max(0.01f, num2);
	}

	private static float ResolveDriveLoadTransferScale(float wheelLocalX, float wheelBaseHalfSpan, float throttle, float supportUpDot, float loadTransferStrength)
	{
		float num = Mathf.Max(0.01f, wheelBaseHalfSpan);
		float num2 = Mathf.Max(0f, loadTransferStrength);
		if (num2 <= 0.0001f || Mathf.Abs(throttle) <= 0.0001f)
		{
			return 1f;
		}
		float num3 = Mathf.Clamp(wheelLocalX / num, -1f, 1f);
		float num4 = Mathf.Clamp01(Mathf.InverseLerp(0.35f, 1f, supportUpDot));
		float num5 = (0f - num3) * throttle * num2 * num4;
		float min = Mathf.Max(0.45f, 1f - num2);
		float max = 1f + num2;
		return Mathf.Clamp(1f + num5, min, max);
	}

	private static float ResolveSupportComplianceScale(RigidbodyType2D bodyType, float dynamicSupportScale)
	{
		if (bodyType != RigidbodyType2D.Dynamic)
		{
			return 1f;
		}
		return Mathf.Clamp(dynamicSupportScale, 0.2f, 1f);
	}

	private static float DampBoundaryCompressionVelocity(float strokeVelocity, float naturalFrequency, float dampingRatio, float dt)
	{
		float num = Mathf.Exp(-2f * Mathf.Max(0.01f, dampingRatio) * Mathf.Max(0.01f, naturalFrequency) * Mathf.Max(0.0001f, dt));
		float num2 = strokeVelocity * num;
		if (!(Mathf.Abs(num2) <= 0.0001f))
		{
			return num2;
		}
		return 0f;
	}

	private void ApplyLinkedSurfaceForce(Vector2 selfPoint, Rigidbody2D surfaceBody, Vector2 surfacePoint, Vector2 force)
	{
		if (!(force.sqrMagnitude <= 0.0001f))
		{
			RequireRuntimeBody("ApplyLinkedSurfaceForce").AddForceAtPosition(force, selfPoint, ForceMode2D.Force);
			if (surfaceBody != null && surfaceBody.bodyType == RigidbodyType2D.Dynamic)
			{
				surfaceBody.AddForceAtPosition(-force, surfacePoint, ForceMode2D.Force);
			}
		}
	}

	private WheelSupportBlend TrySampleWheelContact(Rigidbody2D body, WheelRuntime wheel, Vector2 mountPos, float radius, float suspension)
	{
		WheelSupportBlend result = new WheelSupportBlend
		{
			contactPoint = mountPos,
			contactNormal = Vector2.zero,
			contactBodyType = RigidbodyType2D.Static,
			centerToSurface = radius + suspension + suspensionProbeExtra
		};
		if (!useContactProbe)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Contact probe must stay enabled.");
		}
		float radius2 = Mathf.Max(0.02f, radius + suspension + suspensionProbeExtra);
		if (contactBuffer == null || contactBuffer.Length != maxContactPerWheel)
		{
			contactBuffer = new Collider2D[Mathf.Clamp(maxContactPerWheel, 4, 64)];
		}
		int num = Physics2D.OverlapCircle(mountPos, radius2, wheelContactFilter, contactBuffer);
		if (num < 0)
		{
			num = 0;
		}
		float radius3 = Mathf.Max(0.06f, radius * 1.08f);
		int num2 = Physics2D.OverlapCircle(mountPos, radius3, penetrationContactFilter, dynamicContactBuffer);
		if (num2 > 0)
		{
			for (int i = 0; i < num2; i++)
			{
				Collider2D collider2D = dynamicContactBuffer[i];
				if (collider2D == null || collider2D.attachedRigidbody == body)
				{
					continue;
				}
				Rigidbody2D attachedRigidbody = collider2D.attachedRigidbody;
				if (attachedRigidbody == null || attachedRigidbody.bodyType != RigidbodyType2D.Dynamic)
				{
					continue;
				}
				bool flag = false;
				for (int j = 0; j < num; j++)
				{
					if (contactBuffer[j] == collider2D)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					if (num >= contactBuffer.Length)
					{
						break;
					}
					contactBuffer[num] = collider2D;
					num++;
				}
			}
		}
		int num3 = Physics2D.OverlapPoint(mountPos, penetrationContactFilter, penetrationContactBuffer);
		if (num3 > 0)
		{
			for (int k = 0; k < num3; k++)
			{
				Collider2D collider2D2 = penetrationContactBuffer[k];
				if (collider2D2 == null || collider2D2.attachedRigidbody == body)
				{
					continue;
				}
				Rigidbody2D attachedRigidbody2 = collider2D2.attachedRigidbody;
				if (attachedRigidbody2 == null || attachedRigidbody2.bodyType != RigidbodyType2D.Dynamic)
				{
					continue;
				}
				bool flag2 = false;
				for (int l = 0; l < num; l++)
				{
					if (contactBuffer[l] == collider2D2)
					{
						flag2 = true;
						break;
					}
				}
				if (!flag2)
				{
					if (num >= contactBuffer.Length)
					{
						break;
					}
					contactBuffer[num] = collider2D2;
					num++;
				}
			}
		}
		if (num <= 0)
		{
			return result;
		}
		SupportContactCandidate supportContactCandidate = default(SupportContactCandidate);
		SupportContactCandidate supportContactCandidate2 = default(SupportContactCandidate);
		Vector2 up = Vector2.up;
		Vector2 pointVelocity = body.GetPointVelocity(mountPos);
		float num4 = radius + suspension + suspensionProbeExtra;
		for (int m = 0; m < num; m++)
		{
			Collider2D collider2D3 = contactBuffer[m];
			if (collider2D3 == null || collider2D3.attachedRigidbody == body)
			{
				continue;
			}
			Vector2 vector = collider2D3.ClosestPoint(mountPos);
			Vector2 vector2 = mountPos - vector;
			float magnitude = vector2.magnitude;
			float num5 = Mathf.Max(0f, radius - magnitude);
			bool flag3 = num5 > 0.0001f;
			if (magnitude <= 0.0001f)
			{
				if (!collider2D3.OverlapPoint(mountPos) && !flag3)
				{
					continue;
				}
				flag3 = true;
				vector = mountPos;
			}
			if (magnitude > num4)
			{
				continue;
			}
			Vector2 vector3 = ((magnitude <= 0.0001f) ? ResolveContainedContactNormal(collider2D3, mountPos, up) : (vector2 / magnitude));
			float num6 = Vector2.Dot(vector3, up);
			RigidbodyType2D rigidbodyType2D = ((collider2D3.attachedRigidbody != null) ? collider2D3.attachedRigidbody.bodyType : RigidbodyType2D.Static);
			float num7 = ((rigidbodyType2D == RigidbodyType2D.Dynamic) ? dynamicSupportNormalYMin : minSupportNormalY);
			if (!flag3 && num6 < num7)
			{
				continue;
			}
			Vector2 vector4 = ((collider2D3.attachedRigidbody != null) ? collider2D3.attachedRigidbody.GetPointVelocity(vector) : Vector2.zero);
			float relativeNormalSpeed = Vector2.Dot(pointVelocity - vector4, vector3);
			float num8 = Mathf.Clamp01(magnitude / Mathf.Max(0.0001f, num4));
			float num9 = (flag3 ? Mathf.Max(num6, num7) : num6);
			float num10 = num9 * contactSupportScoreWeight - num8 * contactDistanceScoreWeight;
			if (flag3)
			{
				num10 += penetratingContactScoreBonus;
			}
			if (rigidbodyType2D == RigidbodyType2D.Dynamic)
			{
				if (!supportContactCandidate2.found || num10 > supportContactCandidate2.score || (Mathf.Abs(num10 - supportContactCandidate2.score) <= 0.0001f && magnitude < supportContactCandidate2.centerToSurface))
				{
					supportContactCandidate2 = new SupportContactCandidate
					{
						found = true,
						point = vector,
						normal = vector3,
						body = collider2D3.attachedRigidbody,
						bodyType = rigidbodyType2D,
						relativeNormalSpeed = relativeNormalSpeed,
						centerToSurface = magnitude,
						supportDot = num9,
						score = num10,
						isPenetrating = flag3,
						penetrationDepth = num5
					};
				}
			}
			else if (!supportContactCandidate.found || num10 > supportContactCandidate.score || (Mathf.Abs(num10 - supportContactCandidate.score) <= 0.0001f && magnitude < supportContactCandidate.centerToSurface))
			{
				supportContactCandidate = new SupportContactCandidate
				{
					found = true,
					point = vector,
					normal = vector3,
					body = collider2D3.attachedRigidbody,
					bodyType = rigidbodyType2D,
					relativeNormalSpeed = relativeNormalSpeed,
					centerToSurface = magnitude,
					supportDot = num9,
					score = num10,
					isPenetrating = flag3,
					penetrationDepth = num5
				};
			}
		}
		if (!supportContactCandidate.found && !supportContactCandidate2.found)
		{
			return result;
		}
		result.grounded = true;
		result.primary = supportContactCandidate;
		result.secondary = supportContactCandidate2;
		Vector2 vector5 = ResolveSteppedSupportBlendWeights(targetWeights: (supportContactCandidate.found && supportContactCandidate2.found) ? ResolveSupportBlendWeights(supportContactCandidate.score, supportContactCandidate.centerToSurface, supportContactCandidate.supportDot, supportContactCandidate2.score, supportContactCandidate2.centerToSurface, supportContactCandidate2.supportDot, supportContactCandidate2.relativeNormalSpeed, num4, dynamicSupportMaxRelativeNormalSpeed, dynamicSupportScoreAdvantage, supportSwitchHysteresis, wheel.supportSource) : ((!supportContactCandidate2.found) ? new Vector2(1f, 0f) : new Vector2(0f, 1f)), currentWeights: new Vector2(wheel.primarySupportWeight, wheel.secondarySupportWeight), transferRate: Mathf.Max(1f, contactNormalSmoothing), dt: Time.fixedDeltaTime);
		result.primaryWeight = vector5.x;
		result.secondaryWeight = vector5.y;
		SupportContactCandidate supportContactCandidate3 = ((result.secondaryWeight > result.primaryWeight && supportContactCandidate2.found) ? supportContactCandidate2 : (supportContactCandidate.found ? supportContactCandidate : supportContactCandidate2));
		result.dominantSource = ((supportContactCandidate3.bodyType == RigidbodyType2D.Dynamic) ? WheelSupportSource.Secondary : (supportContactCandidate3.found ? WheelSupportSource.Primary : WheelSupportSource.None));
		result.contactBody = supportContactCandidate3.body;
		result.contactBodyType = supportContactCandidate3.bodyType;
		if (result.primaryWeight > 0f && result.secondaryWeight > 0f)
		{
			float num11 = result.primaryWeight + result.secondaryWeight;
			float num12 = ((num11 > 0.0001f) ? (1f / num11) : 1f);
			Vector2 vector6 = supportContactCandidate.point * result.primaryWeight + supportContactCandidate2.point * result.secondaryWeight;
			Vector2 vector7 = supportContactCandidate.normal * result.primaryWeight + supportContactCandidate2.normal * result.secondaryWeight;
			result.contactPoint = vector6 * num12;
			result.contactNormal = ((vector7.sqrMagnitude > 0.0001f) ? vector7.normalized : supportContactCandidate3.normal);
			result.relativeNormalSpeed = (supportContactCandidate.relativeNormalSpeed * result.primaryWeight + supportContactCandidate2.relativeNormalSpeed * result.secondaryWeight) * num12;
			result.centerToSurface = (supportContactCandidate.centerToSurface * result.primaryWeight + supportContactCandidate2.centerToSurface * result.secondaryWeight) * num12;
			return result;
		}
		result.contactPoint = supportContactCandidate3.point;
		result.contactNormal = supportContactCandidate3.normal;
		result.relativeNormalSpeed = supportContactCandidate3.relativeNormalSpeed;
		result.centerToSurface = supportContactCandidate3.centerToSurface;
		return result;
	}

	private static Vector2 ResolveSupportBlendWeights(float primaryScore, float primaryDistance, float primarySupportDot, float secondaryScore, float secondaryDistance, float secondarySupportDot, float secondaryRelativeNormalSpeed, float maxReach, float maxRelativeNormalSpeed, float dynamicSupportAdvantage, float hysteresis, WheelSupportSource currentSource)
	{
		float num = Mathf.Max(0.0001f, maxReach);
		float num2 = Mathf.Clamp01(primaryScore) * Mathf.Clamp01(primarySupportDot) * (1f - Mathf.Clamp01(primaryDistance / num));
		float num3 = 1f - Mathf.Clamp01(Mathf.Abs(secondaryRelativeNormalSpeed) / Mathf.Max(0.0001f, maxRelativeNormalSpeed));
		float num4 = Mathf.Clamp01(secondaryScore) * Mathf.Clamp01(secondarySupportDot) * (1f - Mathf.Clamp01(secondaryDistance / num)) * num3;
		if (secondaryDistance + 0.0001f < primaryDistance)
		{
			num4 += Mathf.Max(0f, dynamicSupportAdvantage) * Mathf.Clamp01(secondarySupportDot) * num3;
		}
		switch (currentSource)
		{
		case WheelSupportSource.Primary:
			num2 += Mathf.Max(0f, hysteresis);
			break;
		case WheelSupportSource.Secondary:
			num4 += Mathf.Max(0f, hysteresis);
			break;
		}
		float num5 = num2 + num4;
		if (num5 <= 0.0001f)
		{
			return new Vector2(1f, 0f);
		}
		return new Vector2(num2 / num5, num4 / num5);
	}

	private static Vector2 StepSupportBlendWeights(Vector2 currentWeights, Vector2 targetWeights, float transferRate, float dt)
	{
		Vector2 fallback = NormalizeSupportBlendWeights(targetWeights, Vector2.zero);
		if (fallback.sqrMagnitude <= 0.0001f)
		{
			return Vector2.zero;
		}
		Vector2 result = NormalizeSupportBlendWeights(currentWeights, fallback);
		float num = 1f - Mathf.Exp((0f - Mathf.Max(0f, transferRate)) * Mathf.Max(0.0001f, dt));
		if (num <= 0.0001f)
		{
			return result;
		}
		float num2 = Mathf.Lerp(result.y, fallback.y, num);
		return NormalizeSupportBlendWeights(new Vector2(1f - num2, num2), fallback);
	}

	private static Vector2 ResolveSteppedSupportBlendWeights(Vector2 currentWeights, Vector2 targetWeights, float transferRate, float dt)
	{
		Vector2 targetWeights2 = NormalizeSupportBlendWeights(targetWeights, Vector2.zero);
		if (targetWeights2.sqrMagnitude <= 0.0001f)
		{
			return Vector2.zero;
		}
		return StepSupportBlendWeights(currentWeights, targetWeights2, transferRate, dt);
	}

	private static Vector2 NormalizeSupportBlendWeights(Vector2 weights, Vector2 fallback)
	{
		float num = Mathf.Max(0f, weights.x);
		float num2 = Mathf.Max(0f, weights.y);
		float num3 = num + num2;
		if (num3 <= 0.0001f)
		{
			return fallback;
		}
		return new Vector2(num / num3, num2 / num3);
	}

	private void ApplySupportCandidateForces(Rigidbody2D body, int wheelCount, Vector2 mountPos, WheelRuntime wheel, float wheelBaseHalfSpan, SupportContactCandidate candidate, float supportWeight, float throttle, float compression, float springMagnitude, ref Vector2 accumulatedMotorForce, ref float accumulatedSlipRatio)
	{
		if (!candidate.found || supportWeight <= 0.0001f)
		{
			return;
		}
		Vector2 vector = ComputeForwardTangent(candidate.normal, throttle);
		float num = ResolveDriveLoadTransferScale((wheel.mount != null) ? wheel.mount.transform.localPosition.x : 0f, wheelBaseHalfSpan, throttle, candidate.normal.y, driveLoadTransferStrength);
		float t = Mathf.Clamp01(Mathf.InverseLerp(0.72f, 0.12f, candidate.supportDot));
		float num2 = Mathf.Lerp(1f, wallContactDriveScale, t);
		float num3 = Mathf.Lerp(1f, wallContactRollingDragScale, t);
		float num4 = ResolveSupportComplianceScale(candidate.bodyType, dynamicSupportSpringScale);
		float num5 = 0f;
		if (candidate.isPenetrating && candidate.penetrationDepth > 0.0001f)
		{
			float num6 = Mathf.Min(overlapDepenetrationForcePerMass * candidate.penetrationDepth, overlapDepenetrationMaxForcePerMass);
			num5 = body.mass * num6;
		}
		float num7 = (candidate.isPenetrating ? Mathf.Max(supportWeight, penetratingContactMinSupportWeight) : supportWeight);
		Vector2 force = candidate.normal * springMagnitude * supportWeight * num * num4 + candidate.normal * num5 * num7;
		ApplyLinkedSurfaceForce(mountPos, candidate.body, candidate.point, force);
		Vector2 pointVelocity = body.GetPointVelocity(mountPos);
		Vector2 vector2 = ((candidate.body != null) ? candidate.body.GetPointVelocity(candidate.point) : Vector2.zero);
		float num8 = Vector2.Dot(pointVelocity - vector2, vector);
		float num9 = ((candidate.bodyType == RigidbodyType2D.Dynamic) ? dynamicSupportRollingDragScale : 1f);
		float num10 = (0f - num8) * wheel.def.rollingResistance * body.mass * 0.1f * num9 * num3 * supportWeight;
		ApplyLinkedSurfaceForce(mountPos, candidate.body, candidate.point, vector * num10);
		if (wheel.def.powered && !(Mathf.Abs(throttle) <= 0.0001f))
		{
			Vector2 vector3 = ComputeWheelMotorForce(wheel.def, wheelCount, throttle, compression, num8, vector, out var slipRatio) * supportWeight * num2;
			float num11 = ResolveRecoilDriveScale();
			if (num11 < 1f)
			{
				vector3 *= num11;
			}
			if (candidate.bodyType == RigidbodyType2D.Dynamic)
			{
				vector3 *= dynamicSupportDriveScale;
			}
			ApplyLinkedSurfaceForce(mountPos, candidate.body, candidate.point, vector3);
			accumulatedMotorForce += vector3;
			accumulatedSlipRatio = Mathf.Max(accumulatedSlipRatio, slipRatio * supportWeight);
		}
	}

	private Vector2 ComputeForwardTangent(Vector2 normal, float throttle)
	{
		Vector2 normalized = normal.normalized;
		Vector2 vector = new Vector2(normalized.y, 0f - normalized.x);
		if (vector.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Invalid contact normal for tangent solve.");
		}
		vector.Normalize();
		Vector2 rhs = RequireRuntimeBody("ResolveWheelContactTangent").transform.right;
		if (rhs.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Chassis forward axis is invalid.");
		}
		rhs.Normalize();
		if (Vector2.Dot(vector, rhs) < 0f)
		{
			vector = -vector;
		}
		if (throttle < 0f)
		{
			vector = -vector;
		}
		return vector;
	}

	private Vector2 ComputeWheelMotorForce(WheelModuleDefinition wheelDef, int wheelCount, float throttle, float compression, float tangentVelocity, Vector2 tangent, out float slipRatio)
	{
		float num = Mathf.Max(0.2f, wheelDef.maxAngularVelocity * wheelDef.radius);
		float num2 = num * Mathf.Abs(throttle);
		float f = num2 - Mathf.Abs(tangentVelocity);
		slipRatio = Mathf.Clamp01(Mathf.Abs(f) / Mathf.Max(0.2f, num2));
		float num3 = wheelDef.maxMotorTorque / Mathf.Max(0.08f, wheelDef.radius);
		float num4 = wheelDef.grip * tractionAmplify;
		float num5 = Mathf.Clamp01(compression);
		float t = num5 * num5 * (3f - 2f * num5);
		float num6 = Mathf.Lerp(0.24f, 1f, t);
		float t2 = Mathf.Clamp01(Mathf.Abs(tangentVelocity) / Mathf.Max(0.2f, num * 0.35f));
		float t3 = Mathf.Clamp01(slipRatio * slipToForceGain * Time.fixedDeltaTime * Mathf.Lerp(0.55f, 1f, t2));
		float num7 = Mathf.Lerp(1f, 0.58f, t3);
		float num8 = Mathf.Clamp01(Mathf.Abs(tangentVelocity) / num);
		float a = 1f - num8;
		float b = 1f - num8 * num8;
		float t4 = Mathf.Clamp01(num8 / 0.45f);
		float num9 = Mathf.Clamp01(Mathf.Lerp(a, b, t4));
		float a2 = num3 * Mathf.Abs(throttle) * num4 * num6 * num7 * num9;
		float b2 = Mathf.Max(15f, derivedDriveForce / (float)wheelCount);
		a2 = Mathf.Min(a2, b2);
		return tangent * a2;
	}

	private float ResolveRecoilDriveScale()
	{
		if (Time.time >= recoilDriveSuppressionUntil)
		{
			return 1f;
		}
		float num = Mathf.Max(0.0001f, recoilDriveSuppressionDuration);
		float t = Mathf.Clamp01((recoilDriveSuppressionUntil - Time.time) / num);
		float b = Mathf.Clamp01(recoilDriveSuppressionMinScale);
		return Mathf.Lerp(1f, b, t);
	}

	private void ApplySteerAndMassBiasTorque()
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ApplySteerAndMassBiasTorque");
		ChassisDefinition chassisDefinition = RequireRuntimeChassis("ApplySteerAndMassBiasTorque");
		int num = RequireRuntimeWheelCount("ApplySteerAndMassBiasTorque");
		float num2 = Mathf.Clamp01((float)groundedWheelCount / (float)num);
		float dt = Mathf.Max(0.0001f, Time.fixedDeltaTime);
		float num3 = steerInput * steerTorque * num2;
		float target = ComputeUprightAssistTorque(num2);
		float target2 = ComputeTimedFlipRescueTorque(num2);
		float target3 = ComputeAngularExcessDampingTorque();
		float num4 = Mathf.Max(20f, maxUprightAssist * 18f + Mathf.Max(0f, flipRescueTorque) * 0.2f);
		float num5 = num4 * 1.25f;
		lastUprightAssistTorque = StepSignedCommand(lastUprightAssistTorque, target, num4, num5, dt);
		lastFlipAssistTorque = StepSignedCommand(lastFlipAssistTorque, target2, num4 * 1.4f, num5 * 1.4f, dt);
		lastAngularAssistTorque = StepSignedCommand(lastAngularAssistTorque, target3, num4 * 1.6f, num5 * 1.6f, dt);
		smoothedAssistTorque = lastUprightAssistTorque + lastFlipAssistTorque + lastAngularAssistTorque;
		float num6 = num3 + smoothedAssistTorque;
		if (Mathf.Abs(num6) <= 0.0001f)
		{
			smoothedAssistTorque = 0f;
		}
		else
		{
			rigidbody2D.AddTorque(num6, ForceMode2D.Force);
		}
		float target4 = ComputeLaneAssistForce(num2);
		float riseRate = Mathf.Max(8f, chassisDefinition.LaneSpring * Mathf.Max(1f, rigidbody2D.mass));
		float fallRate = Mathf.Max(8f, chassisDefinition.LaneDamping * Mathf.Max(1f, rigidbody2D.mass) * 2f);
		smoothedLaneAssistForce = StepSignedCommand(smoothedLaneAssistForce, target4, riseRate, fallRate, dt);
		lastLaneAssistForce = smoothedLaneAssistForce;
		if (Mathf.Abs(smoothedLaneAssistForce) > 0.0001f)
		{
			rigidbody2D.AddForce(Vector2.up * smoothedLaneAssistForce, ForceMode2D.Force);
		}
	}

	private float ComputeUprightAssistTorque(float groundedRatio)
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ComputeUprightAssistTorque");
		Vector2 vector = rigidbody2D.transform.up;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Chassis up axis is invalid during upright assist torque solve.");
		}
		vector.Normalize();
		float num = Vector2.SignedAngle(vector, Vector2.up);
		if (Mathf.Abs(num) > 125f && groundedRatio < 0.2f)
		{
			return 0f;
		}
		float num2 = ComputeFlatSupportRatio();
		float num3 = ResolveFlatGroundSettleMultiplier(num2, Mathf.Abs(num));
		float num4 = Mathf.Lerp(minUprightAssist, maxUprightAssist, groundedRatio);
		float b = Mathf.Lerp(11f, Mathf.Max(11f, maxUprightAssist), num2);
		num4 = Mathf.Min(num4 * num3, b);
		float num5 = rigidbody2D.angularVelocity * (uprightAssistDamping + num4 * 0.14f);
		float value = num * num4 - num5;
		float num6 = Mathf.Max(10f, num4 * 120f);
		return Mathf.Clamp(value, 0f - num6, num6);
	}

	private float ComputeFlatSupportRatio()
	{
		int num = RequireRuntimeWheelCount("ComputeFlatSupportRatio");
		float num2 = 0f;
		float num3 = 0f;
		for (int i = 0; i < num; i++)
		{
			WheelRuntime wheelRuntime = wheels[i];
			if (wheelRuntime != null && wheelRuntime.grounded)
			{
				Vector2 vector = ((wheelRuntime.smoothedNormal.sqrMagnitude > 0.0001f) ? wheelRuntime.smoothedNormal.normalized : Vector2.zero);
				if (!(vector.sqrMagnitude <= 0.0001f))
				{
					num2 += Mathf.Clamp01(Mathf.InverseLerp(minSupportNormalY, 1f, vector.y));
					num3++;
				}
			}
		}
		if (!(num3 > 0f))
		{
			return 0f;
		}
		return Mathf.Clamp01(num2 / num3);
	}

	private static float ResolveFlatGroundSettleMultiplier(float flatSupportRatio, float absUprightErrorDeg)
	{
		float num = Mathf.Clamp01(flatSupportRatio);
		if (num <= 0.0001f)
		{
			return 1f;
		}
		float num2 = 1f - Mathf.Clamp01(Mathf.Max(0f, absUprightErrorDeg) / 12f);
		return 1f + num * num2 * 0.75f;
	}

	private int CountNonDynamicGroundedWheels()
	{
		int num = RequireRuntimeWheelCount("CountNonDynamicGroundedWheels");
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			WheelRuntime wheelRuntime = wheels[i];
			if (wheelRuntime != null && wheelRuntime.grounded && wheelRuntime.surfaceBodyType != RigidbodyType2D.Dynamic)
			{
				num2++;
			}
		}
		return num2;
	}

	private float ResolveFlipRescueTiltAngleThreshold(ChassisDefinition chassis)
	{
		return ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType) switch
		{
			SummerRaceBodyTypeConfig.Heavy => Mathf.Clamp(Mathf.Min(flipRescueTiltAngleThreshold, 60f), 45f, 170f), 
			SummerRaceBodyTypeConfig.Medium => Mathf.Clamp(Mathf.Min(flipRescueTiltAngleThreshold, 62f), 45f, 170f), 
			_ => Mathf.Clamp(flipRescueTiltAngleThreshold, 45f, 170f), 
		};
	}

	private float ResolveFlipRescueGroundedRatioMax(ChassisDefinition chassis)
	{
		SummerRaceBodyTypeConfig summerRaceBodyTypeConfig = ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType);
		if ((uint)(summerRaceBodyTypeConfig - 1) <= 1u)
		{
			return Mathf.Clamp01(Mathf.Max(flipRescueGroundedRatioMax, 0.5f));
		}
		return Mathf.Clamp01(flipRescueGroundedRatioMax);
	}

	private int ResolveFlipRescueMaxStaticGroundedWheels(ChassisDefinition chassis, int wheelCount)
	{
		SummerRaceBodyTypeConfig summerRaceBodyTypeConfig = ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType);
		if ((uint)(summerRaceBodyTypeConfig - 1) <= 1u)
		{
			return Mathf.Min(1, Mathf.Max(0, wheelCount - 1));
		}
		return 0;
	}

	private float ResolveFlipRescueMaxAngularSpeed(ChassisDefinition chassis)
	{
		return ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType) switch
		{
			SummerRaceBodyTypeConfig.Heavy => Mathf.Max(flipRescueMaxAngularSpeed, 95f), 
			SummerRaceBodyTypeConfig.Medium => Mathf.Max(flipRescueMaxAngularSpeed, 80f), 
			_ => flipRescueMaxAngularSpeed, 
		};
	}

	private float ResolveFlipRescueAngularSpeedGate(ChassisDefinition chassis, float upsideDot, float tiltAbsDeg, float resolvedTiltThreshold, int staticGroundedWheelCount)
	{
		float num = ResolveFlipRescueMaxAngularSpeed(chassis);
		if ((!(upsideDot <= -0.45f) && !(tiltAbsDeg >= Mathf.Max(resolvedTiltThreshold, 115f))) || staticGroundedWheelCount > 0)
		{
			return num;
		}
		return Mathf.Max(num, maxAngularSpeedDegPerSec * 0.45f);
	}

	private float ResolveFlipRescueTorqueScale(ChassisDefinition chassis)
	{
		return ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType) switch
		{
			SummerRaceBodyTypeConfig.Heavy => 2f, 
			SummerRaceBodyTypeConfig.Medium => 1.45f, 
			_ => 1f, 
		};
	}

	private float ResolveFlipRescueForwardForceScale(ChassisDefinition chassis)
	{
		return ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType) switch
		{
			SummerRaceBodyTypeConfig.Heavy => 1.35f, 
			SummerRaceBodyTypeConfig.Medium => 1.15f, 
			_ => 1f, 
		};
	}

	private float ResolvePairFacingDotMax(ChassisDefinition chassis)
	{
		return ((!(chassis != null)) ? SummerRaceBodyTypeConfig.Medium : chassis.BodyType) switch
		{
			SummerRaceBodyTypeConfig.Heavy => Mathf.Clamp(Mathf.Max(vehicleStuckPairFacingDotMax, -0.1f), -1f, 0.2f), 
			SummerRaceBodyTypeConfig.Medium => Mathf.Clamp(Mathf.Max(vehicleStuckPairFacingDotMax, -0.22f), -1f, 0.2f), 
			_ => Mathf.Clamp(vehicleStuckPairFacingDotMax, -1f, 0.2f), 
		};
	}

	private float ComputeTimedFlipRescueTorque(float groundedRatio)
	{
		if (!allowTimedFlipRescue)
		{
			flipRescueEligibleTimer = 0f;
			flipRescueActive = false;
			return 0f;
		}
		RequireRuntimeWheelCount("ComputeTimedFlipRescueTorque");
		ChassisDefinition chassis = RequireRuntimeChassis("ComputeTimedFlipRescueTorque");
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ComputeTimedFlipRescueTorque");
		Vector2 vector = rigidbody2D.transform.up;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Chassis up axis is invalid during timed flip rescue solve.");
		}
		vector.Normalize();
		float num = Vector2.Dot(vector, Vector2.up);
		float num2 = Mathf.Abs(Vector2.SignedAngle(vector, Vector2.up));
		float magnitude = rigidbody2D.velocity.magnitude;
		float num3 = Mathf.Abs(rigidbody2D.angularVelocity);
		int num4 = RequireRuntimeWheelCount("ComputeTimedFlipRescueTorque.StaticSupport");
		int num5 = CountNonDynamicGroundedWheels();
		float num6 = Mathf.Clamp01((float)num5 / (float)Mathf.Max(1, num4));
		float num7 = ResolveFlipRescueTiltAngleThreshold(chassis);
		float num8 = ResolveFlipRescueGroundedRatioMax(chassis);
		int num9 = ResolveFlipRescueMaxStaticGroundedWheels(chassis, num4);
		float num10 = ResolveFlipRescueAngularSpeedGate(chassis, num, num2, num7, num5);
		bool flag = num <= flipRescueUpsideDotThreshold || num2 >= num7;
		bool flag2 = magnitude <= flipRescueMaxSpeed && num3 <= num10;
		bool flag3 = num6 <= num8;
		if (flipRescueActive)
		{
			if (Time.time >= flipRescueUntil || num >= 0.7f)
			{
				flipRescueActive = false;
				flipRescueEligibleTimer = 0f;
				SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Flip rescue cleared on " + base.name);
				return 0f;
			}
			float f = Vector2.SignedAngle(vector, Vector2.up);
			if (Mathf.Abs(f) <= 0.5f)
			{
				return 0f;
			}
			float num11 = Mathf.Sign(f);
			float num12 = rigidbody2D.angularVelocity * (uprightAssistDamping + 0.6f);
			float num13 = Mathf.Max(0f, flipRescueTorque) * ResolveFlipRescueTorqueScale(chassis);
			TryApplyForwardFlipRescueForce(rigidbody2D, chassis);
			return num11 * num13 - num12;
		}
		bool flag4 = num5 <= num9;
		if (!(flag & flag2 & flag3 & flag4))
		{
			flipRescueEligibleTimer = 0f;
			return 0f;
		}
		flipRescueEligibleTimer += Time.fixedDeltaTime;
		if (flipRescueEligibleTimer < Mathf.Max(0.1f, flipRescueDelay))
		{
			return 0f;
		}
		flipRescueActive = true;
		flipRescueUntil = Time.time + Mathf.Max(0.1f, flipRescueDuration);
		SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Flip rescue activated on " + base.name + " speed=" + magnitude.ToString("F2") + " ang=" + rigidbody2D.angularVelocity.ToString("F1") + " support=" + groundedRatio.ToString("F2") + " staticSupport=" + num6.ToString("F2"));
		return 0f;
	}

	private void TryApplyForwardFlipRescueForce(Rigidbody2D body, ChassisDefinition chassis)
	{
		if (body == null || flipRescueForwardForcePerMass <= 0f)
		{
			return;
		}
		Vector2 vector = body.transform.right;
		if (!(vector.sqrMagnitude <= 0.0001f))
		{
			vector.Normalize();
			Vector2 vector2 = body.transform.up;
			if (vector2.sqrMagnitude <= 0.0001f)
			{
				vector2 = Vector2.up;
			}
			else
			{
				vector2.Normalize();
			}
			float num = Mathf.Max(0.01f, body.mass) * flipRescueForwardForcePerMass * ResolveFlipRescueForwardForceScale(chassis);
			Vector2 force = vector * num;
			Vector2 position = body.worldCenterOfMass - vector2 * Mathf.Max(0f, flipRescueForceLiftOffset);
			body.AddForceAtPosition(force, position, ForceMode2D.Force);
		}
	}

	private float ComputeLaneAssistForce(float groundedRatio)
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ComputeLaneAssistForce");
		ChassisDefinition chassisDefinition = RequireRuntimeChassis("ComputeLaneAssistForce");
		float num = 1f - Mathf.Clamp01(groundedRatio);
		if (num <= 0.0001f)
		{
			return 0f;
		}
		float num2 = (targetRideHeightWorld - rigidbody2D.worldCenterOfMass.y) * chassisDefinition.LaneSpring * rigidbody2D.mass - rigidbody2D.velocity.y * chassisDefinition.LaneDamping * rigidbody2D.mass;
		float num3 = Mathf.Max(2f, chassisDefinition.stabilityAssist * rigidbody2D.mass);
		return Mathf.Clamp(num2 * num, 0f - num3, num3);
	}

	private void TickWallStuckRescue()
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("TickWallStuckRescue");
		int num = RequireRuntimeWheelCount("TickWallStuckRescue");
		if (IsCollisionImpactSuppressed)
		{
			CancelWallStuckRescueForCollisionSuppression();
			return;
		}
		bool flag = TryResolvePersistentPairStuckNormal(rigidbody2D, out var rescueNormal, out var pairBody);
		bool flag2 = ShouldBlockRescueByDamageWindow();
		bool flag3 = IsCollisionImpactSuppressed || IsPairCollisionImpactSuppressed(pairBody);
		bool flag4 = flag && !flag3 && !flag2 && CanTriggerPairRescueByEnemyDamageWindow(rigidbody2D, pairBody);
		if (flag && !flag4)
		{
			vehicleStuckContactTimer = 0f;
			vehicleStuckNormalAccumulator = Vector2.zero;
			vehicleStuckCandidatePairBody = null;
		}
		if (flag4 && Time.time >= wallStuckCooldownUntil)
		{
			AccumulateVehicleStuckCandidate(pairBody, rescueNormal);
			if (vehicleStuckContactTimer >= Mathf.Max(0.05f, vehicleStuckPairRescueMinHold))
			{
				Vector2 wallNormal = ((vehicleStuckNormalAccumulator.sqrMagnitude > 0.0001f) ? vehicleStuckNormalAccumulator.normalized : rescueNormal);
				TriggerWallStuckRescue(rigidbody2D, wallNormal, pairBody);
				SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Vehicle pair stuck rescue activated on " + base.name + " speed=" + rigidbody2D.velocity.magnitude.ToString("F2") + " pair=" + ((pairBody != null) ? pairBody.name : "null"));
				wallStuckCooldownUntil = Time.time + Mathf.Max(0.05f, wallStuckRescueCooldown);
				wallStuckContactTimer = 0f;
				wallStuckNormalAccumulator = Vector2.zero;
				vehicleStuckContactTimer = 0f;
				vehicleStuckNormalAccumulator = Vector2.zero;
				vehicleStuckCandidatePairBody = null;
				return;
			}
		}
		if (groundedWheelCount < Mathf.Max(1, num - 1))
		{
			if (!TryTickVehicleStuckRescueFallback(rigidbody2D, flag2, allowDynamicPair: true, forceStaticObstacle: true, out var hasVehicleStuckCandidate) && !flag && !hasVehicleStuckCandidate)
			{
				ResetWallStuckState();
			}
			return;
		}
		if (wallStuckRescueActive)
		{
			if (Time.time >= wallStuckRescueUntil)
			{
				wallStuckRescueActive = false;
				wallStuckRescueSign = 0f;
				SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Wall stuck rescue cleared on " + base.name);
			}
			else
			{
				ApplyWallStuckRescueForces(rigidbody2D);
			}
			return;
		}
		Vector2 vector = ResolveCurrentWallContactNormal();
		bool flag5 = vector.sqrMagnitude > 0.0001f;
		if (!flag5 && Time.time <= wallBoundaryTouchUntil && wallBoundaryTouchNormal.sqrMagnitude > 0.0001f)
		{
			vector = wallBoundaryTouchNormal.normalized;
			flag5 = true;
		}
		float b = Mathf.Max(wallStuckRescueMaxSpeed, wallStuckRescueMinEscapeSpeed * 0.95f);
		bool flag6 = rigidbody2D.velocity.magnitude <= Mathf.Max(0f, b);
		if (!flag5 || !flag6 || Time.time < wallStuckCooldownUntil)
		{
			if (!flag)
			{
				LogVehicleStuckBlocked("persistent-pair-miss", rigidbody2D, null, 0f, vehicleStuckPairMaxRelativeSpeed, 0);
			}
			if (flag6 && Time.time >= wallStuckCooldownUntil)
			{
				if (TryTickVehicleStuckRescueFallback(rigidbody2D, flag2, allowDynamicPair: true, forceStaticObstacle: false, out var hasVehicleStuckCandidate2))
				{
					return;
				}
				if (!flag && !hasVehicleStuckCandidate2)
				{
					vehicleStuckContactTimer = 0f;
					vehicleStuckNormalAccumulator = Vector2.zero;
					vehicleStuckCandidatePairBody = null;
				}
			}
			else if (!flag)
			{
				vehicleStuckContactTimer = 0f;
				vehicleStuckNormalAccumulator = Vector2.zero;
				vehicleStuckCandidatePairBody = null;
			}
			if (!flag5 || !flag6)
			{
				wallStuckContactTimer = 0f;
				wallStuckNormalAccumulator = Vector2.zero;
			}
		}
		else
		{
			if (!flag)
			{
				vehicleStuckContactTimer = 0f;
				vehicleStuckNormalAccumulator = Vector2.zero;
				vehicleStuckCandidatePairBody = null;
			}
			wallStuckContactTimer += Mathf.Max(0.0001f, Time.fixedDeltaTime);
			wallStuckNormalAccumulator += vector;
			if (!(wallStuckContactTimer < Mathf.Max(0.05f, wallStuckRescueDelay)))
			{
				Vector2 wallNormal2 = ((wallStuckNormalAccumulator.sqrMagnitude > 0.0001f) ? wallStuckNormalAccumulator.normalized : vector);
				TriggerWallStuckRescue(rigidbody2D, wallNormal2);
				wallStuckCooldownUntil = Time.time + Mathf.Max(0.05f, wallStuckRescueCooldown);
				wallStuckContactTimer = 0f;
				wallStuckNormalAccumulator = Vector2.zero;
			}
		}
	}

	private void ResetWallStuckState()
	{
		wallStuckContactTimer = 0f;
		wallStuckNormalAccumulator = Vector2.zero;
		vehicleStuckContactTimer = 0f;
		vehicleStuckNormalAccumulator = Vector2.zero;
		vehicleStuckCandidatePairBody = null;
		if (!wallStuckRescueActive)
		{
			wallStuckRescueSign = 0f;
		}
	}

	private void CancelWallStuckRescueForCollisionSuppression()
	{
		wallStuckRescueActive = false;
		wallStuckRescueSign = 0f;
		wallStuckContactTimer = 0f;
		wallStuckNormalAccumulator = Vector2.zero;
		vehicleStuckContactTimer = 0f;
		vehicleStuckNormalAccumulator = Vector2.zero;
		vehicleStuckCandidatePairBody = null;
	}

	private float ResolveWallStuckEffectiveThrottle()
	{
		if (Time.time >= wallStuckDriveSuppressUntil)
		{
			return throttleInput;
		}
		return throttleInput * Mathf.Clamp01(wallStuckDriveSuppressScale);
	}

	private bool TryTickVehicleStuckRescueFallback(Rigidbody2D body, bool blockedByDamageWindow, bool allowDynamicPair, bool forceStaticObstacle, out bool hasVehicleStuckCandidate)
	{
		hasVehicleStuckCandidate = false;
		float b = Mathf.Max(wallStuckRescueMaxSpeed, wallStuckRescueMinEscapeSpeed * 0.95f);
		if (!(body != null) || !(body.velocity.magnitude <= Mathf.Max(0f, b)) || Time.time < wallStuckCooldownUntil)
		{
			return false;
		}
		if (!TryResolveVehicleStuckNormal(body, allowDynamicPair, forceStaticObstacle, out var rescueNormal, out var pairBody))
		{
			return false;
		}
		hasVehicleStuckCandidate = true;
		if (pairBody != null && (blockedByDamageWindow || !CanTriggerPairRescueByEnemyDamageWindow(body, pairBody)))
		{
			hasVehicleStuckCandidate = false;
			vehicleStuckContactTimer = 0f;
			vehicleStuckNormalAccumulator = Vector2.zero;
			vehicleStuckCandidatePairBody = null;
			return false;
		}
		AccumulateVehicleStuckCandidate(pairBody, rescueNormal);
		float num = ((pairBody != null) ? Mathf.Max(vehicleStuckRescueContactHold, vehicleStuckPairRescueMinHold) : Mathf.Max(0.05f, vehicleStuckRescueContactHold));
		if (vehicleStuckContactTimer < num)
		{
			return false;
		}
		Vector2 wallNormal = ((vehicleStuckNormalAccumulator.sqrMagnitude > 0.0001f) ? vehicleStuckNormalAccumulator.normalized : rescueNormal);
		TriggerWallStuckRescue(body, wallNormal, pairBody);
		SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Vehicle stuck rescue activated on " + base.name + " throttle=" + throttleInput.ToString("F2") + " speed=" + body.velocity.magnitude.ToString("F2") + " pair=" + ((pairBody != null) ? pairBody.name : "null"));
		wallStuckCooldownUntil = Time.time + Mathf.Max(0.05f, wallStuckRescueCooldown);
		wallStuckContactTimer = 0f;
		wallStuckNormalAccumulator = Vector2.zero;
		vehicleStuckContactTimer = 0f;
		vehicleStuckNormalAccumulator = Vector2.zero;
		vehicleStuckCandidatePairBody = null;
		return true;
	}

	private bool ShouldBlockRescueByDamageWindow()
	{
		return false;
	}

	private float ResolveRescueForceScale()
	{
		return Mathf.Clamp(wallStuckRescueBaseForceScale + (float)wallStuckRescueEscalationStep * wallStuckRescueForceScaleStep, wallStuckRescueBaseForceScale, 1f);
	}

	private void OnRescueTriggered()
	{
		wallStuckRescueEscalationStep = Mathf.Min(wallStuckRescueEscalationStep + 1, Mathf.Max(1, wallStuckRescueMaxEscalationSteps));
		SetWheelVisualColliderEnabled(enabled: false);
		wheelColliderRestoreAt = Time.time + Mathf.Max(0.05f, rescueDisableWheelColliderDuration);
	}

	private void TickRescueWheelColliderState()
	{
		if (!(wheelColliderRestoreAt < 0f) && !(Time.time < wheelColliderRestoreAt))
		{
			wheelColliderRestoreAt = -1f;
			SetWheelVisualColliderEnabled(enabled: true);
		}
	}

	private void SetWheelVisualColliderEnabled(bool enabled)
	{
		for (int i = 0; i < wheelVisualColliders.Count; i++)
		{
			CircleCollider2D circleCollider2D = wheelVisualColliders[i];
			if (!(circleCollider2D == null))
			{
				circleCollider2D.enabled = enabled;
			}
		}
	}

	private void TickWallStuckPairIgnoreState()
	{
		if (wallStuckPairBody == null)
		{
			wallStuckPairIgnoreUntil = -1f;
		}
		else if (!(Time.time < wallStuckPairIgnoreUntil))
		{
			ClearWallStuckPairIgnoreCollision(forceRelease: true);
		}
	}

	private void ActivatePairUnstick(Rigidbody2D body, Rigidbody2D pairBody, Vector2 wallNormal)
	{
		if (body == null || pairBody == null || pairBody == body || IsCollisionImpactSuppressed || IsPairCollisionImpactSuppressed(pairBody))
		{
			return;
		}
		float num = ResolveRescueForceScale();
		float num2 = Mathf.Max(0.05f, wallStuckPairIgnoreDuration);
		float num3 = Time.time + num2;
		wallStuckPairBody = pairBody;
		wallStuckPairIgnoreUntil = num3;
		VehiclePhysicsController component = pairBody.GetComponent<VehiclePhysicsController>();
		if (component != null)
		{
			component.wallStuckPairBody = body;
			component.wallStuckPairIgnoreUntil = num3;
			component.wallStuckDriveSuppressUntil = Mathf.Max(component.wallStuckDriveSuppressUntil, Time.time + Mathf.Max(0.05f, component.wallStuckDriveSuppressDuration));
		}
		float num4 = 0f - Mathf.Sign(wallNormal.x);
		if (Mathf.Abs(num4) <= 0.0001f)
		{
			num4 = Mathf.Sign(body.transform.right.x);
			if (Mathf.Abs(num4) <= 0.0001f)
			{
				num4 = 1f;
			}
		}
		float num5 = Mathf.Clamp01(wallStuckChaosRandomness);
		float num6 = Mathf.Max(0f, wallStuckChaosImpulsePerMass) * num;
		if (num6 > 0f)
		{
			float num7 = UnityEngine.Random.Range(0f - num5, num5);
			float num8 = UnityEngine.Random.Range(0f - num5, num5);
			float num9 = Mathf.Sign(num4 + num7);
			float num10 = Mathf.Sign(0f - num4 + num8);
			if (Mathf.Abs(num9) <= 0.0001f)
			{
				num9 = num4;
			}
			if (Mathf.Abs(num10) <= 0.0001f)
			{
				num10 = 0f - num4;
			}
			float num11 = UnityEngine.Random.Range(1f - num5 * 0.55f, 1f + num5 * 0.75f);
			float num12 = UnityEngine.Random.Range(1f - num5 * 0.55f, 1f + num5 * 0.75f);
			Vector2 force = Vector2.right * (num9 * num6 * Mathf.Max(0.01f, body.mass) * num11);
			Vector2 force2 = Vector2.right * (num10 * num6 * Mathf.Max(0.01f, pairBody.mass) * num12);
			body.AddForce(force, ForceMode2D.Impulse);
			pairBody.AddForce(force2, ForceMode2D.Impulse);
		}
		float num13 = Mathf.Max(0f, wallStuckChaosLiftPerMass) * num;
		if (num13 > 0f)
		{
			float num14 = UnityEngine.Random.Range(1f - num5 * 0.45f, 1f + num5 * 0.65f);
			float num15 = UnityEngine.Random.Range(1f - num5 * 0.45f, 1f + num5 * 0.65f);
			Vector2 force3 = Vector2.up * (num13 * Mathf.Max(0.01f, body.mass) * num14);
			Vector2 force4 = Vector2.up * (num13 * Mathf.Max(0.01f, pairBody.mass) * num15);
			body.AddForce(force3, ForceMode2D.Impulse);
			pairBody.AddForce(force4, ForceMode2D.Impulse);
		}
		float num16 = Mathf.Max(0f, wallStuckRescueMinEscapeSpeed) * Mathf.Lerp(0.82f, 1f, num);
		if (num16 > 0f)
		{
			float num17 = num4;
			if (Mathf.Abs(num17) <= 0.0001f)
			{
				num17 = Mathf.Sign(body.transform.right.x);
			}
			float num18 = 0f - num17;
			Vector2 velocity = body.velocity;
			if (Mathf.Abs(velocity.x) < num16 || Mathf.Sign(velocity.x) != Mathf.Sign(num17))
			{
				velocity.x = num17 * num16;
				body.velocity = velocity;
			}
			Vector2 velocity2 = pairBody.velocity;
			if (Mathf.Abs(velocity2.x) < num16 || Mathf.Sign(velocity2.x) != Mathf.Sign(num18))
			{
				velocity2.x = num18 * num16;
				pairBody.velocity = velocity2;
			}
		}
	}

	private static bool IsPairCollisionImpactSuppressed(Rigidbody2D pairBody)
	{
		VehiclePhysicsController vehiclePhysicsController = ((pairBody != null) ? pairBody.GetComponent<VehiclePhysicsController>() : null);
		if (vehiclePhysicsController == null && pairBody != null)
		{
			vehiclePhysicsController = pairBody.GetComponentInParent<VehiclePhysicsController>();
		}
		if (vehiclePhysicsController != null)
		{
			return vehiclePhysicsController.IsCollisionImpactSuppressed;
		}
		return false;
	}

	private void ClearWallStuckPairIgnoreCollision(bool forceRelease)
	{
		if (wallStuckPairBody == null)
		{
			wallStuckPairIgnoreUntil = -1f;
		}
		else if (forceRelease || !(Time.time < wallStuckPairIgnoreUntil))
		{
			wallStuckPairBody = null;
			wallStuckPairIgnoreUntil = -1f;
		}
	}

	private static void SetPairIgnoreCollision(Rigidbody2D selfBody, Rigidbody2D otherBody, bool ignore)
	{
	}

	private void TrackWallBoundaryContact(Collision2D collision)
	{
		if (collision == null || collision.collider == null || collision.contactCount <= 0)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequireRuntimeBody("TrackWallBoundaryContact");
		if (collision.rigidbody != rigidbody2D)
		{
			return;
		}
		string text = collision.collider.name;
		if (string.IsNullOrEmpty(text) || !text.StartsWith("Boundary"))
		{
			return;
		}
		Vector2 zero = Vector2.zero;
		int contactCount = collision.contactCount;
		float num = Mathf.Clamp(wallStuckRescueMinNormalX, 0.1f, 1f);
		for (int i = 0; i < contactCount; i++)
		{
			Vector2 normal = collision.GetContact(i).normal;
			if (!(normal.sqrMagnitude <= 0.0001f))
			{
				normal.Normalize();
				if (!(Mathf.Abs(normal.x) < num))
				{
					zero += normal;
				}
			}
		}
		if (!(zero.sqrMagnitude <= 0.0001f))
		{
			wallBoundaryTouchNormal = zero.normalized;
			wallBoundaryTouchUntil = Mathf.Max(wallBoundaryTouchUntil, Time.time + Mathf.Max(0.05f, Time.fixedDeltaTime * 2f));
		}
	}

	private void TrackDynamicVehicleContact(Collision2D collision)
	{
		if (collision == null || collision.contactCount <= 0)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequireRuntimeBody("TrackDynamicVehicleContact");
		Rigidbody2D rigidbody2D2 = collision.rigidbody;
		if (rigidbody2D2 == rigidbody2D || rigidbody2D2 == null)
		{
			rigidbody2D2 = collision.otherRigidbody;
		}
		if (rigidbody2D2 == null || rigidbody2D2 == rigidbody2D || rigidbody2D2.bodyType != RigidbodyType2D.Dynamic)
		{
			return;
		}
		Vector2 vector = rigidbody2D.worldCenterOfMass - rigidbody2D2.worldCenterOfMass;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			vector = Vector2.zero;
			for (int i = 0; i < collision.contactCount; i++)
			{
				Vector2 normal = collision.GetContact(i).normal;
				if (normal.sqrMagnitude > 0.0001f)
				{
					vector += normal.normalized;
				}
			}
		}
		if (!(vector.sqrMagnitude <= 0.0001f))
		{
			recentDynamicContactBody = rigidbody2D2;
			recentDynamicContactNormal = vector.normalized;
			recentDynamicContactRelativeSpeed = (rigidbody2D.velocity - rigidbody2D2.velocity).magnitude;
			recentDynamicContactUntil = Time.time + Mathf.Max(0.08f, Time.fixedDeltaTime * 4f);
		}
	}

	private Vector2 ResolveCurrentWallContactNormal()
	{
		Vector2 zero = Vector2.zero;
		int num = 0;
		int num2 = RequireRuntimeWheelCount("ResolveCurrentWallContactNormal");
		float num3 = Mathf.Clamp(wallStuckRescueMinNormalX, 0.1f, 1f);
		for (int i = 0; i < num2; i++)
		{
			WheelRuntime wheelRuntime = wheels[i];
			if (wheelRuntime != null && wheelRuntime.grounded && !(wheelRuntime.contactNormal.sqrMagnitude <= 0.0001f))
			{
				Vector2 normalized = wheelRuntime.contactNormal.normalized;
				if (!(Mathf.Abs(normalized.x) < num3))
				{
					zero += normalized;
					num++;
				}
			}
		}
		if (num <= 0 || zero.sqrMagnitude <= 0.0001f)
		{
			return Vector2.zero;
		}
		return zero.normalized;
	}

	private void AccumulateVehicleStuckCandidate(Rigidbody2D pairBody, Vector2 normal)
	{
		if (vehicleStuckCandidatePairBody != null && vehicleStuckCandidatePairBody != pairBody)
		{
			vehicleStuckContactTimer = 0f;
			vehicleStuckNormalAccumulator = Vector2.zero;
		}
		vehicleStuckCandidatePairBody = pairBody;
		vehicleStuckContactTimer += Mathf.Max(0.0001f, Time.fixedDeltaTime);
		vehicleStuckNormalAccumulator += normal;
	}

	private bool CanTriggerPairRescueByEnemyDamageWindow(Rigidbody2D body, Rigidbody2D pairBody)
	{
		float windowStartTime = Time.time - Mathf.Max(0.05f, vehicleStuckPairRescueMinHold);
		if (!HasReceivedDamageSince(ResolveEnemyHost(body)))
		{
			return !HasReceivedDamageSince(ResolveEnemyHost(pairBody));
		}
		return false;
		bool HasReceivedDamageSince(SummerRaceEnemy enemy)
		{
			if (enemy != null)
			{
				return enemy.LastDamageReceivedTime >= windowStartTime;
			}
			return false;
		}
	}

	private SummerRaceEnemy ResolveEnemyHost(Rigidbody2D sourceBody = null)
	{
		if (sourceBody == null)
		{
			if (cachedEnemyHost == null)
			{
				cachedEnemyHost = GetComponent<SummerRaceEnemy>();
			}
			return cachedEnemyHost;
		}
		return sourceBody.GetComponent<SummerRaceEnemy>();
	}

	private bool TryResolvePersistentPairStuckNormal(Rigidbody2D body, out Vector2 rescueNormal, out Rigidbody2D pairBody)
	{
		rescueNormal = Vector2.zero;
		pairBody = null;
		ChassisDefinition chassis = RequireRuntimeChassis("TryResolvePersistentPairStuckNormal");
		float num = ResolvePairFacingDotMax(chassis);
		float num2 = Mathf.Max(0f, vehicleStuckPairMaxRelativeSpeed);
		if (body != null && recentDynamicContactBody != null && Time.time <= recentDynamicContactUntil && recentDynamicContactNormal.sqrMagnitude > 0.0001f)
		{
			if (recentDynamicContactRelativeSpeed <= num2)
			{
				Vector2 lhs = body.transform.right;
				Vector2 rhs = recentDynamicContactBody.transform.right;
				if (lhs.sqrMagnitude > 0.0001f && rhs.sqrMagnitude > 0.0001f)
				{
					lhs.Normalize();
					rhs.Normalize();
					float num3 = Vector2.Dot(lhs, rhs);
					if (num3 <= num)
					{
						SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Pair stuck facing-lock candidate on " + base.name + " facingDot=" + num3.ToString("F2") + " other=" + recentDynamicContactBody.name);
						rescueNormal = recentDynamicContactNormal.normalized;
						pairBody = recentDynamicContactBody;
						return true;
					}
				}
				rescueNormal = recentDynamicContactNormal.normalized;
				pairBody = recentDynamicContactBody;
				return true;
			}
			LogVehicleStuckBlocked("cached-relative-speed", body, recentDynamicContactBody, recentDynamicContactRelativeSpeed, num2, 1);
		}
		int num4 = ((!(body == null)) ? body.GetContacts(penetrationContactFilter, penetrationContactBuffer) : 0);
		if (num4 <= 0)
		{
			return false;
		}
		Vector2 zero = Vector2.zero;
		int num5 = 0;
		for (int i = 0; i < num4; i++)
		{
			Collider2D collider2D = penetrationContactBuffer[i];
			if (collider2D == null)
			{
				continue;
			}
			Rigidbody2D attachedRigidbody = collider2D.attachedRigidbody;
			if (attachedRigidbody == null || attachedRigidbody == body || attachedRigidbody.bodyType != RigidbodyType2D.Dynamic)
			{
				continue;
			}
			Vector2 vector = body.velocity - attachedRigidbody.velocity;
			if (vector.magnitude > num2)
			{
				LogVehicleStuckBlocked("relative-speed", body, attachedRigidbody, vector.magnitude, num2, num4);
				continue;
			}
			Vector2 vector2 = body.worldCenterOfMass - attachedRigidbody.worldCenterOfMass;
			if (!(vector2.sqrMagnitude <= 0.0001f))
			{
				vector2.Normalize();
				zero += vector2;
				num5++;
				pairBody = attachedRigidbody;
			}
		}
		if (num5 <= 0 || zero.sqrMagnitude <= 0.0001f || pairBody == null)
		{
			return false;
		}
		rescueNormal = zero.normalized;
		return true;
	}

	private bool TryResolveVehicleStuckNormal(Rigidbody2D body, bool allowDynamicPair, bool forceStaticObstacle, out Vector2 rescueNormal, out Rigidbody2D pairBody)
	{
		rescueNormal = Vector2.zero;
		pairBody = null;
		int num = ((!(body == null)) ? body.GetContacts(penetrationContactFilter, penetrationContactBuffer) : 0);
		if (num <= 0)
		{
			return false;
		}
		bool flag = Mathf.Abs(throttleInput) >= Mathf.Max(0f, vehicleStuckRescueMinThrottle);
		Vector2 lhs = (flag ? ((Vector2)(body.transform.right * Mathf.Sign(throttleInput))) : Vector2.zero);
		if (lhs.sqrMagnitude > 0.0001f)
		{
			lhs.Normalize();
		}
		float num2 = Mathf.Clamp01(vehicleStuckRescueMinContactDot);
		float num3 = Mathf.Clamp(wallStuckRescueMinNormalX, 0.1f, 1f);
		Vector2 zero = Vector2.zero;
		int num4 = 0;
		float num5 = float.NegativeInfinity;
		for (int i = 0; i < num; i++)
		{
			Collider2D collider2D = penetrationContactBuffer[i];
			if (collider2D == null)
			{
				continue;
			}
			Rigidbody2D attachedRigidbody = collider2D.attachedRigidbody;
			if (attachedRigidbody == body)
			{
				continue;
			}
			bool flag2 = attachedRigidbody != null && attachedRigidbody.bodyType == RigidbodyType2D.Dynamic;
			if ((flag2 && !allowDynamicPair) || ((!flag2 & forceStaticObstacle) && !IsStaticSideObstacleCandidate(body, collider2D)))
			{
				continue;
			}
			Vector2 vector = (flag2 ? (body.worldCenterOfMass - attachedRigidbody.worldCenterOfMass) : ResolveStaticObstaclePushAway(body, collider2D));
			if (vector.sqrMagnitude <= 0.0001f)
			{
				continue;
			}
			vector.Normalize();
			float num6 = float.NegativeInfinity;
			if (flag && lhs.sqrMagnitude > 0.0001f)
			{
				num6 = Vector2.Dot(lhs, -vector);
				if (num6 < num2)
				{
					LogVehicleStuckBlocked("direction", body, attachedRigidbody, num6, num2, num);
					continue;
				}
			}
			else
			{
				num6 = Mathf.Abs(vector.x);
				if (num6 < num3)
				{
					LogVehicleStuckBlocked(flag2 ? "no-drive-intent" : "static-side-normal", body, attachedRigidbody, num6, num3, num);
					continue;
				}
			}
			zero += vector;
			num4++;
			if (flag2 && num6 > num5)
			{
				num5 = num6;
				pairBody = attachedRigidbody;
			}
		}
		if (num4 <= 0 || zero.sqrMagnitude <= 0.0001f)
		{
			LogVehicleStuckBlocked("no-valid-contact", body, null, num5, num2, num);
			return false;
		}
		rescueNormal = zero.normalized;
		return true;
	}

	private Vector2 ResolveStaticObstaclePushAway(Rigidbody2D body, Collider2D obstacle)
	{
		if (body == null || obstacle == null)
		{
			return Vector2.zero;
		}
		Vector2 worldCenterOfMass = body.worldCenterOfMass;
		Vector2 vector = obstacle.ClosestPoint(worldCenterOfMass);
		Vector2 result = worldCenterOfMass - vector;
		if (result.sqrMagnitude > 0.0001f)
		{
			return result;
		}
		return worldCenterOfMass - (Vector2)obstacle.bounds.center;
	}

	private bool IsStaticSideObstacleCandidate(Rigidbody2D body, Collider2D obstacle)
	{
		if (body == null || obstacle == null)
		{
			return false;
		}
		Bounds bounds = obstacle.bounds;
		if (bounds.size.x <= 0.0001f || bounds.size.y <= 0.0001f)
		{
			return false;
		}
		Vector2 worldCenterOfMass = body.worldCenterOfMass;
		float num = Mathf.Max(0.05f, bounds.extents.y + targetRideHeightWorld * 0.65f);
		if (Mathf.Abs(worldCenterOfMass.y - bounds.center.y) > num)
		{
			return false;
		}
		return true;
	}

	private void LogVehicleStuckBlocked(string reason, Rigidbody2D body, Rigidbody2D otherBody, float dot, float minDot, int contactCount)
	{
		if (SummerRaceRuntimeLog.IsGameplayVerboseEnabled && !(Time.time < nextVehicleStuckBlockedLogAt))
		{
			nextVehicleStuckBlockedLogAt = Time.time + 0.35f;
			SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Vehicle stuck rescue blocked on " + base.name + " reason=" + reason + " throttle=" + throttleInput.ToString("F2") + " speed=" + ((body != null) ? body.velocity.magnitude.ToString("F2") : "null") + " grounded=" + groundedWheelCount + " contacts=" + contactCount + " dot=" + dot.ToString("F2") + " minDot=" + minDot.ToString("F2") + " other=" + ((otherBody != null) ? otherBody.name : "null"));
		}
	}

	private void TriggerWallStuckRescue(Rigidbody2D body, Vector2 wallNormal, Rigidbody2D pairBody = null)
	{
		if (body == null || IsCollisionImpactSuppressed || IsPairCollisionImpactSuppressed(pairBody))
		{
			return;
		}
		float f = ResolveWallStuckEscapeSign(body, wallNormal, pairBody);
		if (!(Mathf.Abs(f) <= 0.0001f))
		{
			wallStuckRescueActive = true;
			wallStuckRescueUntil = Time.time + Mathf.Max(0.05f, wallStuckRescueForceDuration);
			wallStuckRescueSign = f;
			wallStuckDriveSuppressUntil = Mathf.Max(wallStuckDriveSuppressUntil, Time.time + Mathf.Max(0.05f, wallStuckDriveSuppressDuration));
			float num = ResolveRescueForceScale();
			float num2 = Mathf.Max(0f, wallStuckRescueImpulsePerMass) * num;
			if (num2 > 0f)
			{
				Vector2 force = Vector2.right * (wallStuckRescueSign * num2 * Mathf.Max(0.01f, body.mass));
				body.AddForce(force, ForceMode2D.Impulse);
			}
			float num3 = Mathf.Max(0f, wallStuckRescueLiftImpulsePerMass) * num;
			if (num3 > 0f)
			{
				Vector2 force2 = Vector2.up * (num3 * Mathf.Max(0.01f, body.mass));
				body.AddForce(force2, ForceMode2D.Impulse);
			}
			OnRescueTriggered();
			ActivatePairUnstick(body, pairBody, wallNormal);
			SummerRaceRuntimeLog.Verbose("[VehiclePhysicsController] Wall stuck rescue activated on " + base.name + " sign=" + wallStuckRescueSign.ToString("F1") + " speed=" + body.velocity.magnitude.ToString("F2") + " grounded=" + groundedWheelCount);
			ApplyWallStuckRescueForces(body);
		}
	}

	private float ResolveWallStuckEscapeSign(Rigidbody2D body, Vector2 wallNormal, Rigidbody2D pairBody)
	{
		if (Mathf.Abs(wallNormal.x) > 0.0001f)
		{
			return 0f - Mathf.Sign(wallNormal.x);
		}
		if (pairBody == null || pairBody == body)
		{
			return 0f;
		}
		if (wallBoundaryTouchNormal.sqrMagnitude > 0.0001f && Mathf.Abs(wallBoundaryTouchNormal.x) > 0.0001f)
		{
			return 0f - Mathf.Sign(wallBoundaryTouchNormal.x);
		}
		Vector2 vector = body.transform.right;
		if (Mathf.Abs(vector.x) > 0.0001f)
		{
			return Mathf.Sign(vector.x);
		}
		float f = body.worldCenterOfMass.x - pairBody.worldCenterOfMass.x;
		if (Mathf.Abs(f) > 0.0001f)
		{
			return Mathf.Sign(f);
		}
		return 0f;
	}

	private void ApplyWallStuckRescueForces(Rigidbody2D body)
	{
		if (body == null || !wallStuckRescueActive || IsCollisionImpactSuppressed || Mathf.Abs(wallStuckRescueSign) <= 0.0001f)
		{
			return;
		}
		float num = ResolveRescueForceScale();
		float num2 = wallStuckRescueSign * Mathf.Max(0f, wallStuckRescueTorque) * num;
		if (Mathf.Abs(num2) > 0.0001f)
		{
			float num3 = body.angularVelocity * Mathf.Max(0f, uprightAssistDamping + 0.8f);
			body.AddTorque(num2 - num3, ForceMode2D.Force);
		}
		float num4 = Mathf.Max(0f, wallStuckRescueForcePerMass) * num;
		if (num4 > 0f)
		{
			Vector2 force = Vector2.right * (wallStuckRescueSign * num4 * Mathf.Max(0.01f, body.mass));
			body.AddForce(force, ForceMode2D.Force);
		}
		float num5 = Mathf.Max(0f, wallStuckRescueMinEscapeSpeed) * Mathf.Lerp(0.82f, 1f, num);
		if (num5 > 0f)
		{
			Vector2 velocity = body.velocity;
			if (Mathf.Sign(velocity.x) != Mathf.Sign(wallStuckRescueSign) || Mathf.Abs(velocity.x) < num5)
			{
				velocity.x = wallStuckRescueSign * num5;
				body.velocity = velocity;
			}
		}
	}

	private void ApplyLinearAndAngularSpeedPolicy()
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ApplyLinearAndAngularSpeedPolicy");
		float num = Mathf.Max(0.5f, derivedMaxLinearSpeed);
		Vector2 velocity = rigidbody2D.velocity;
		Vector2 vector = rigidbody2D.transform.right;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehiclePhysicsController] Chassis forward axis is invalid during speed policy solve.");
		}
		vector.Normalize();
		float f = Vector2.Dot(velocity, vector);
		float num2 = Mathf.Abs(f);
		if (num2 > num)
		{
			float num3 = num2 - num;
			float num4 = 16f + Mathf.Max(0f, utilityStabilityBonus) * 4f;
			Vector2 force = (0f - Mathf.Sign(f)) * vector * num3 * rigidbody2D.mass * num4;
			rigidbody2D.AddForce(force, ForceMode2D.Force);
		}
	}

	private void ApplyHookLatchMotionSuppression()
	{
		if (IsHookMotionSuppressed)
		{
			Rigidbody2D rigidbody2D = RequireRuntimeBody("ApplyHookLatchMotionSuppression");
			Vector2 velocity = rigidbody2D.velocity;
			float num = Mathf.Max(0f, hookMotionSuppressHorizontalSpeedLimit);
			float num2 = Mathf.Max(0f, hookMotionSuppressVerticalSpeedLimit);
			float num3 = Mathf.Max(0f, hookMotionSuppressAngularSpeedLimit);
			if (num > 0f)
			{
				velocity.x = Mathf.Clamp(velocity.x, 0f - num, num);
			}
			if (num2 > 0f)
			{
				velocity.y = Mathf.Clamp(velocity.y, 0f - num2, num2);
			}
			rigidbody2D.velocity = velocity;
			if (num3 > 0f)
			{
				rigidbody2D.angularVelocity = Mathf.Clamp(rigidbody2D.angularVelocity, 0f - num3, num3);
			}
		}
	}

	private void ClearHookSuppressedDriveInputs()
	{
		throttleInput = 0f;
		steerInput = 0f;
		TickDriveAudioState();
		smoothedAssistTorque = 0f;
		smoothedLaneAssistForce = 0f;
		lastUprightAssistTorque = 0f;
		lastFlipAssistTorque = 0f;
		lastAngularAssistTorque = 0f;
		lastLaneAssistForce = 0f;
	}

	private void TickDriveAudioState()
	{
		bool flag = IsPlayerVehicleAudioSource && runtimeTuningReady && !IsHookMotionSuppressed && throttleInput > 0.05f;
		if (flag != driveAudioActive)
		{
			driveAudioActive = flag;
			SummerRaceCombatAudioEventRouter.Publish(base.transform, driveAudioActive ? SummerRaceCombatAudioEvent.VehicleDriveStarted(base.transform) : SummerRaceCombatAudioEvent.VehicleDriveStopped(base.transform));
		}
	}

	private void StopDriveAudio()
	{
		if (driveAudioActive)
		{
			driveAudioActive = false;
			SummerRaceCombatAudioEventRouter.Publish(base.transform, SummerRaceCombatAudioEvent.VehicleDriveStopped(base.transform));
		}
	}

	private float ComputeAngularExcessDampingTorque()
	{
		Rigidbody2D rigidbody2D = RequireRuntimeBody("ComputeAngularExcessDampingTorque");
		float num = Mathf.Max(1f, maxAngularSpeedDegPerSec);
		float num2 = Mathf.Abs(rigidbody2D.angularVelocity);
		if (num2 > num)
		{
			float num3 = num2 - num;
			float num4 = Mathf.Max(0.0001f, Time.fixedDeltaTime);
			float num5 = num3 * (MathF.PI / 180f) / num4;
			float num6 = Mathf.Max(0.05f, angularExcessDampingGain);
			return (0f - Mathf.Sign(rigidbody2D.angularVelocity)) * rigidbody2D.inertia * num5 * num6;
		}
		return 0f;
	}

	private float ComputeWheelAsymmetry()
	{
		float num = 0f;
		float num2 = 0f;
		int num3 = 0;
		int num4 = 0;
		for (int i = 0; i < wheels.Count; i++)
		{
			WheelRuntime wheelRuntime = wheels[i];
			if (!(wheelRuntime.mount == null) && !(wheelRuntime.def == null))
			{
				if (wheelRuntime.mount.transform.localPosition.x < 0f)
				{
					num += wheelRuntime.def.radius;
					num3++;
				}
				else
				{
					num2 += wheelRuntime.def.radius;
					num4++;
				}
			}
		}
		if (num3 == 0 || num4 == 0)
		{
			return 0f;
		}
		return num / (float)num3 - num2 / (float)num4;
	}
}
