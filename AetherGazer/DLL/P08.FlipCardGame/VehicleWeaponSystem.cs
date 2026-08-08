using System;
using System.Collections;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

[DisallowMultipleComponent]
public class VehicleWeaponSystem : MonoBehaviour
{
	public readonly struct WeaponSlotSnapshot(int slotIndex, bool isValid, bool isSelected, bool isReady, bool isBurstInProgress, float cooldownRemaining, float nextFireTime, string label, WeaponAimMode aimMode, Vector2 muzzleLocalOffset, float energyCost, float fireInterval, float projectileSpeed, float projectileLifetime, float recoilImpulse, int burstCount, bool isAutoFire, bool isMelee, float attackRange)
	{
		public readonly int SlotIndex = slotIndex;

		public readonly bool IsValid = isValid;

		public readonly bool IsSelected = isSelected;

		public readonly bool IsReady = isReady;

		public readonly bool IsBurstInProgress = isBurstInProgress;

		public readonly float CooldownRemaining = cooldownRemaining;

		public readonly float NextFireTime = nextFireTime;

		public readonly string Label = label;

		public readonly WeaponAimMode AimMode = aimMode;

		public readonly Vector2 MuzzleLocalOffset = muzzleLocalOffset;

		public readonly float EnergyCost = energyCost;

		public readonly float FireInterval = fireInterval;

		public readonly float ProjectileSpeed = projectileSpeed;

		public readonly float ProjectileLifetime = projectileLifetime;

		public readonly float RecoilImpulse = recoilImpulse;

		public readonly int BurstCount = burstCount;

		public readonly bool IsAutoFire = isAutoFire;

		public readonly bool IsMelee = isMelee;

		public readonly float AttackRange = attackRange;
	}

	private sealed class WeaponRuntime
	{
		public int slotIndex;

		public MountPoint mount;

		public WeaponModuleDefinition def;

		public Vector2 authoredLocalRight;

		public Vector2 authoredLocalUp;

		public Vector3 authoredLocalPosition;

		public Quaternion authoredLocalRotation;

		public SummerRaceWeaponSpec spec;

		public CombatImpactPayload meleeImpactPayload;

		public CombatImpactPayload projectileImpactPayload;

		public WeaponRuntimeState state;

		public Coroutine burstRoutine;

		public float lastSpreadUpdateTime;

		public bool continuousMeleeWindowOpen;

		public float continuousMeleeUntil;

		public float nextContinuousMeleeTickAt;

		public float continuousMeleeTickInterval;

		public Vector2 lastContinuousMeleeOrigin;

		public Vector2 lastContinuousMeleeDirection;

		public int muzzleAlternatingStep;

		public int laserCycleDamageBudget;

		public int laserCycleExpectedTicks;

		public int laserCycleAppliedTicks;

		public int laserCycleAppliedDamage;

		public bool sawVisualPoseCaptured;

		public Vector3 sawVisualAuthoredLocalPosition;

		public Quaternion sawVisualAuthoredLocalRotation;

		public Vector3 sawVisualAuthoredLocalEuler;

		public Vector2 sawPivotLocalPoint;

		public float sawVisualSpinDegrees;

		public float sawVisualSpinSpeedDegPerSec;

		public bool overloadVisualActive;
	}

	private sealed class WeaponImpactSourceContext : ICombatSourceContext
	{
		private readonly IWeaponOwnerContext owner;

		private readonly int slotIndex;

		public Transform CombatSourceTransform => owner.CombatSourceTransform;

		public Rigidbody2D CombatSourceRigidbody => owner.CombatSourceRigidbody;

		public SummerRaceCombatTeam CombatTeam => owner.CombatTeam;

		public bool OverclockDamageTextActive => Time.time < owner.ResolveWeaponOverloadUntil(slotIndex);

		public WeaponImpactSourceContext(IWeaponOwnerContext owner, int slotIndex)
		{
			this.owner = owner;
			this.slotIndex = slotIndex;
		}

		public void NotifyCombatDamageDealt(int amount)
		{
			owner.NotifyCombatDamageDealt(amount);
		}
	}

	private sealed class MountedProjectilePreviewRuntime
	{
		public WeaponRuntime slot;

		public Transform root;

		public SkeletonAnimation skeletonAnimation;

		public SkeletonAnimation mountSkeletonAnimation;

		public string anchorSlotName;

		public float respawnAt;

		public bool visible;

		public bool pendingRespawn;
	}

	private sealed class MountedRocketRuntime
	{
		public WeaponRuntime slot;

		public VehicleSimpleProjectile projectile;

		public SkeletonAnimation mountSkeletonAnimation;

		public string anchorSlotName;

		public float respawnAt;

		public bool pendingRespawn;

		public bool mounted;
	}

	private readonly struct DrillHitboxRect(Vector2 center, Vector2 size, float angleDeg)
	{
		public readonly Vector2 Center = center;

		public readonly Vector2 Size = size;

		public readonly float AngleDeg = angleDeg;
	}

	private sealed class ShovelColliderRuntime
	{
		public WeaponRuntime slot;

		public Transform root;

		public PolygonCollider2D collider;

		public SkeletonAnimation mountSkeletonAnimation;

		public string anchorSlotName;

		public float lastObservationLogAt;

		public bool anchorBaselineCaptured;

		public float anchorDefaultAngleDeg;

		public float pivotDefaultAngleDeg;

		public Vector2 anchorDefaultLocalPos;

		public Vector2 anchorDefaultDirectionFromCenterLocal;

		public Vector2 colliderDefaultDirectionFromCenterLocal;

		public Vector2 colliderDefaultOffsetFromAnchorLocal;

		public float lastComputedDeltaAngleDeg;

		public Vector2 lastComputedColliderLocalPos;

		public Vector2 lastComputedCenterLocal;

		public Vector2 lastAnchorLocalPos;

		public bool hasPreviousSampleWorldPos;

		public Vector2 previousSampleWorldPos;

		public float previousSampleTime;

		public Vector2 lastSampleVelocity;
	}

	private readonly struct ProjectileImpactContext(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection, SummerRacePresentationDeliveryKind deliveryKind, Transform presentationSourceTransform)
	{
		public readonly WeaponRuntime Slot = slot;

		public readonly Vector2 SourcePoint = sourcePoint;

		public readonly Vector2 FireDirection = fireDirection;

		public readonly SummerRacePresentationDeliveryKind DeliveryKind = deliveryKind;

		public readonly Transform PresentationSourceTransform = presentationSourceTransform;
	}

	private readonly struct WeaponImpactContext(WeaponRuntime slot, CombatImpactPayload payload, Vector2 sourcePoint, Vector2 hitDirection, int targetCount)
	{
		public readonly WeaponRuntime Slot = slot;

		public readonly CombatImpactPayload Payload = payload;

		public readonly Vector2 SourcePoint = sourcePoint;

		public readonly Vector2 HitDirection = hitDirection;

		public readonly int TargetCount = Mathf.Max(1, targetCount);
	}

	private const float DirectionEpsilon = 0.0001f;

	private const bool TraceWeaponSpawnLog = true;

	private const float DefaultRotatingSawSpinDegreesPerSecond = 900f;

	private const float RocketArcadeMinDeltaV = 2f;

	private const float RocketArcadeDeltaVPerKnockback = 0.55f;

	private const float RocketArcadeApproachScale = 0.25f;

	private const float RocketArcadeMaxApproachBonus = 1.2f;

	private const float RocketArcadeUpwardBias = 0.12f;

	private const string ShovelAnchorSlotName = "chandou2";

	private const string ShovelPivotSlotName = "chandou1";

	private const float ShovelSpineObserveIntervalSeconds = 0.12f;

	private static readonly Vector2 ShovelRotationCenterVisualLocal = new Vector2(-0.06f, 0f);

	private static readonly Vector2 ShovelDefaultColliderVisualLocalPosition = new Vector2(-3.7f, 0f);

	private static readonly Vector2 DrillHitboxReferenceVisualLocalCenter = new Vector2(-2.94f, 0f);

	private static readonly Vector2 DrillHitboxReferenceLocalSize = new Vector2(2.5f, 0.9f);

	private static readonly Vector2[] ShovelHitboxLocalPoints = new Vector2[11]
	{
		new Vector2(1.2161f, 1.30744f),
		new Vector2(1.3285f, 1.13316f),
		new Vector2(0.665f, 0.49641f),
		new Vector2(0.2316f, 0.44361f),
		new Vector2(0.1166f, -0.06095f),
		new Vector2(0f, 0f),
		new Vector2(-0.1327f, -0.04425f),
		new Vector2(-0.2104f, 0.47878f),
		new Vector2(-0.5909f, 0.45706f),
		new Vector2(-1.2971f, 1.15076f),
		new Vector2(-1.2109f, 1.33696f)
	};

	private const int BodyBand = 0;

	private const int ProjectileBand = 2;

	private const int WeaponEquipBand = 3;

	private const int MountedHostSortingOrder = 37;

	private const int MountedObjectSortingOrder = 36;

	private static readonly Vector3 ProjectilePoolParkLocalPosition = new Vector3(4096f, 4096f, 0f);

	private static float[] MountedPreviewBoundsVertexBuffer = new float[1024];

	[Header("Refs")]
	[SerializeField]
	private VehicleAssembler assembler;

	[SerializeField]
	private VehiclePhysicsController physicsController;

	[SerializeField]
	private Transform aimTarget;

	[Header("Projectile")]
	[SerializeField]
	private VehicleSimpleProjectile projectilePrefab;

	[SerializeField]
	private LayerMask hitMask = -1;

	[Header("Runtime")]
	[SerializeField]
	private int selectedWeaponIndex;

	[SerializeField]
	private Vector2 manualAimDirection = Vector2.zero;

	[SerializeField]
	private bool preferManualAimDirection;

	[SerializeField]
	private bool enableRecoilTraceLog = true;

	private readonly List<VehicleAssembler.InstalledModuleRecord> weaponRecords = new List<VehicleAssembler.InstalledModuleRecord>(8);

	private readonly List<WeaponRuntime> weaponSlots = new List<WeaponRuntime>(8);

	private readonly Queue<VehicleSimpleProjectile> projectilePool = new Queue<VehicleSimpleProjectile>(16);

	private readonly Dictionary<VehicleSimpleProjectile, ProjectileImpactContext> projectileImpactContexts = new Dictionary<VehicleSimpleProjectile, ProjectileImpactContext>(16);

	private readonly Dictionary<int, VehicleSimpleProjectile> boomerangProjectilesBySlot = new Dictionary<int, VehicleSimpleProjectile>(4);

	private readonly Dictionary<int, VehicleSimpleProjectile> persistentBoomerangProjectilesBySlot = new Dictionary<int, VehicleSimpleProjectile>(4);

	private readonly Dictionary<int, MountedProjectilePreviewRuntime> mountedProjectilePreviewBySlot = new Dictionary<int, MountedProjectilePreviewRuntime>(4);

	private readonly Dictionary<int, MountedRocketRuntime> mountedRocketBySlot = new Dictionary<int, MountedRocketRuntime>(2);

	private readonly Dictionary<VehicleSimpleProjectile, MountedRocketRuntime> mountedRocketByProjectile = new Dictionary<VehicleSimpleProjectile, MountedRocketRuntime>(2);

	private readonly Dictionary<int, ShovelColliderRuntime> shovelColliderBySlot = new Dictionary<int, ShovelColliderRuntime>(2);

	private readonly HashSet<VehicleSimpleProjectile> projectileImpactedSet = new HashSet<VehicleSimpleProjectile>();

	private readonly List<ICombatStatusHost> meleeTargets = new List<ICombatStatusHost>(8);

	private readonly HashSet<Transform> meleeTargetTransforms = new HashSet<Transform>();

	private readonly List<Vector2> projectileDirectionBuffer = new List<Vector2>(8);

	private readonly Vector2[] shovelHeadPolygon = new Vector2[16];

	private int shovelHeadPolygonCount;

	private readonly Collider2D[] shovelOverlapBuffer = new Collider2D[32];

	private readonly Collider2D[] laserOverlapBuffer = new Collider2D[64];

	private readonly Collider2D[] drillOverlapBuffer = new Collider2D[32];

	private readonly RaycastHit2D[] shovelCastBuffer = new RaycastHit2D[32];

	private ContactFilter2D shovelOverlapFilter;

	private int characterLayer = -1;

	private LayerMask characterLayerMask;

	private bool warnedMissingProjectilePrefab;

	private Transform projectilePoolRoot;

	private IWeaponOwnerContext ownerContext;

	private Coroutine continuousMeleeTickRoutine;

	private bool runtimePaused;

	private float runtimePauseStartedAt;

	public int WeaponCount => weaponSlots.Count;

	public int SelectedWeaponIndex => selectedWeaponIndex;

	public Transform AimTarget => aimTarget;

	public bool HasWeaponSlots => weaponSlots.Count > 0;

	private static bool IsFinite(Vector2 value)
	{
		if (!float.IsNaN(value.x) && !float.IsInfinity(value.x) && !float.IsNaN(value.y))
		{
			return !float.IsInfinity(value.y);
		}
		return false;
	}

	private static void TraceLog(string message)
	{
		if (SummerRaceRuntimeLog.IsGameplayVerboseEnabled)
		{
			SummerRaceRuntimeLog.Verbose(message);
		}
	}

	private static bool ShouldTraceMachineGunProjectile(WeaponRuntime slot)
	{
		if (SummerRaceRuntimeLog.IsGameplayVerboseEnabled && slot != null && slot.def != null)
		{
			return SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) == WeaponKind.MachineGun;
		}
		return false;
	}

	private static void TraceMachineGunProjectileSpawn(WeaponRuntime slot, string stage, VehicleSimpleProjectile projectile)
	{
		if (ShouldTraceMachineGunProjectile(slot))
		{
			if (projectile == null)
			{
				SummerRaceRuntimeLog.Verbose("[SummerRace][WeaponSpawn][MG-TRACE] stage=" + stage + " projectile=<null>");
				return;
			}
			Transform transform = projectile.transform;
			SummerRaceRuntimeLog.Verbose("[SummerRace][WeaponSpawn][MG-TRACE] stage=" + stage + " frame=" + Time.frameCount + " t=" + Time.time.ToString("F3") + " slot=" + slot.slotIndex + " id=" + projectile.GetInstanceID() + " active=" + projectile.gameObject.activeInHierarchy + " parent=" + ((transform.parent != null) ? transform.parent.name : "<null>") + " worldPos=" + transform.position.ToString() + " localPos=" + transform.localPosition.ToString() + " rotZ=" + transform.eulerAngles.z.ToString("F1"));
		}
	}

	private bool TryGetWeaponSlotSnapshot(int slotIndex, out WeaponSlotSnapshot snapshot)
	{
		snapshot = default(WeaponSlotSnapshot);
		if (slotIndex < 0 || slotIndex >= weaponSlots.Count)
		{
			return false;
		}
		snapshot = BuildWeaponSlotSnapshot(slotIndex, weaponSlots[slotIndex]);
		return true;
	}

	public bool TryGetRuntimeSnapshot(int slotIndex, out WeaponRuntimeSnapshot snapshot)
	{
		snapshot = default(WeaponRuntimeSnapshot);
		if (!IsSlotValid(slotIndex))
		{
			return false;
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		SyncRuntimeStateFromOwner(weaponRuntime);
		float num = Mathf.Max(0f, weaponRuntime.state.CooldownUntil - Time.time);
		float overloadRemaining = Mathf.Max(0f, weaponRuntime.state.OverloadUntil - Time.time);
		snapshot = new WeaponRuntimeSnapshot(weaponRuntime.state.SlotIndex, weaponRuntime.burstRoutine == null && num <= 0f, num, Mathf.Max(0f, weaponRuntime.state.DynamicSpread), overloadRemaining);
		return true;
	}

	public void SetOwnerContext(IWeaponOwnerContext context)
	{
		ownerContext = context;
	}

	public void SetRuntimePaused(bool paused)
	{
		if (runtimePaused == paused)
		{
			return;
		}
		runtimePaused = paused;
		if (paused)
		{
			runtimePauseStartedAt = Time.time;
			return;
		}
		float num = Mathf.Max(0f, Time.time - runtimePauseStartedAt);
		runtimePauseStartedAt = 0f;
		if (num > 0f)
		{
			ShiftContinuousMeleeWindows(num);
		}
	}

	public void SetProjectilePrefab(VehicleSimpleProjectile prefab)
	{
		if (prefab == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Projectile prefab is required.");
		}
		projectilePrefab = prefab;
		warnedMissingProjectilePrefab = false;
	}

	private WeaponSlotSnapshot BuildWeaponSlotSnapshot(int slotIndex, WeaponRuntime slot)
	{
		bool flag = slot != null && slot.mount != null && slot.def != null && slot.state != null;
		if (flag)
		{
			SyncRuntimeStateFromOwner(slot);
		}
		float num = (flag ? Mathf.Max(0f, slot.state.CooldownUntil - Time.time) : 0f);
		bool flag2 = flag && slot.burstRoutine != null;
		bool isReady = flag && !flag2 && num <= 0f;
		string label = ((flag && !string.IsNullOrEmpty(slot.def.DisplayName)) ? slot.def.DisplayName : string.Empty);
		int burstCount = (flag ? ResolveRuntimeBurstCount(slot.def) : 0);
		bool isAutoFire = flag && slot.def.FireMode == SummerRaceWeaponFireModeConfig.FullAuto;
		bool flag3 = flag && slot.def.IsMelee;
		float attackRange = (flag ? Mathf.Max(0f, flag3 ? slot.def.MeleeRange : slot.def.Range) : 0f);
		return new WeaponSlotSnapshot(slotIndex, flag, slotIndex == selectedWeaponIndex, isReady, flag2, num, flag ? slot.state.CooldownUntil : 0f, label, flag ? slot.def.AimModeValue : WeaponAimMode.FixedForward, flag ? slot.def.MuzzleLocalOffsetValue : Vector2.zero, flag ? slot.def.EnergyCost : 0f, flag ? ResolveRuntimeFireInterval(slot.def) : 0f, flag ? slot.def.ProjectileSpeedValue : 0f, flag ? slot.def.ProjectileLifetime : 0f, flag ? slot.def.RecoilImpulseValue : 0f, burstCount, isAutoFire, flag3, attackRange);
	}

	private void StopAllBurstCoroutines()
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && weaponRuntime.burstRoutine != null)
			{
				StopCoroutine(weaponRuntime.burstRoutine);
				weaponRuntime.burstRoutine = null;
			}
		}
	}

	private void ClearContinuousMeleeWindows(bool emitActiveExpired)
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null)
			{
				if (emitActiveExpired && weaponRuntime.continuousMeleeWindowOpen)
				{
					EmitWeaponActiveExpired(weaponRuntime, weaponRuntime.lastContinuousMeleeOrigin, weaponRuntime.lastContinuousMeleeDirection);
				}
				weaponRuntime.continuousMeleeWindowOpen = false;
				weaponRuntime.continuousMeleeUntil = 0f;
				weaponRuntime.nextContinuousMeleeTickAt = 0f;
				weaponRuntime.continuousMeleeTickInterval = 0f;
				weaponRuntime.lastContinuousMeleeOrigin = Vector2.zero;
				weaponRuntime.lastContinuousMeleeDirection = Vector2.right;
			}
		}
	}

	private void ShiftContinuousMeleeWindows(float deltaTime)
	{
		if (deltaTime <= 0f)
		{
			return;
		}
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && weaponRuntime.continuousMeleeWindowOpen)
			{
				if (!float.IsInfinity(weaponRuntime.continuousMeleeUntil))
				{
					weaponRuntime.continuousMeleeUntil += deltaTime;
				}
				if (weaponRuntime.nextContinuousMeleeTickAt > 0f)
				{
					weaponRuntime.nextContinuousMeleeTickAt += deltaTime;
				}
			}
		}
	}

	private void Awake()
	{
		if (assembler == null)
		{
			assembler = GetComponent<VehicleAssembler>();
		}
		if (physicsController == null)
		{
			physicsController = GetComponent<VehiclePhysicsController>();
		}
		characterLayer = LayerMask.NameToLayer("Character");
		if (characterLayer < 0)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Layer 'Character' is required for shovel collision filtering.");
		}
		characterLayerMask = 1 << characterLayer;
		shovelOverlapFilter = new ContactFilter2D
		{
			useTriggers = true,
			useLayerMask = true,
			layerMask = characterLayerMask,
			useDepth = false
		};
	}

	private void LateUpdate()
	{
		LockWeaponMountAuthoringPose();
		if (!runtimePaused)
		{
			TickRotatingSawVisuals();
			TickShovelColliderPoses();
		}
	}

	private void Update()
	{
		if (!runtimePaused)
		{
			TickWeaponOverloadVisuals();
			TickMountedProjectilePreviews();
			TickMountedRockets();
		}
	}

	private void OnEnable()
	{
		if (assembler != null)
		{
			assembler.OnAssemblyChanged += RefreshWeapons;
		}
		RefreshWeapons();
	}

	private void OnDisable()
	{
		if (assembler != null)
		{
			assembler.OnAssemblyChanged -= RefreshWeapons;
		}
		DetachProjectileCallbacksBeforeTeardown();
		StopAllBurstCoroutines();
		StopContinuousMeleeTickLoop();
		ClearContinuousMeleeWindows(emitActiveExpired: true);
		runtimePaused = false;
		runtimePauseStartedAt = 0f;
		ClearWeaponOverloadVisuals();
		boomerangProjectilesBySlot.Clear();
		ClearPersistentBoomerangProjectiles();
		ClearMountedProjectilePreviews();
		ClearMountedRockets();
		ClearShovelColliderRuntimes();
		ClearProjectilePoolRuntimes(destroyPoolRoot: true);
	}

	public void RefreshWeapons()
	{
		StopAllBurstCoroutines();
		StopContinuousMeleeTickLoop();
		ClearContinuousMeleeWindows(emitActiveExpired: true);
		ClearWeaponOverloadVisuals();
		boomerangProjectilesBySlot.Clear();
		ClearPersistentBoomerangProjectiles();
		ClearMountedProjectilePreviews();
		ClearMountedRockets();
		ClearShovelColliderRuntimes();
		ClearProjectilePoolRuntimes(destroyPoolRoot: false);
		weaponSlots.Clear();
		if (assembler == null)
		{
			return;
		}
		assembler.GetInstalledWeapons(weaponRecords);
		ISummerRaceCombatPayloadOverrideProvider summerRaceCombatPayloadOverrideProvider = ownerContext as ISummerRaceCombatPayloadOverrideProvider;
		for (int i = 0; i < weaponRecords.Count; i++)
		{
			VehicleAssembler.InstalledModuleRecord installedModuleRecord = weaponRecords[i];
			if (!(installedModuleRecord.mountPoint == null) && installedModuleRecord.module is WeaponModuleDefinition weaponModuleDefinition)
			{
				weaponSlots.Add(new WeaponRuntime
				{
					slotIndex = weaponSlots.Count,
					mount = installedModuleRecord.mountPoint,
					def = weaponModuleDefinition,
					authoredLocalRight = ResolveAuthoredLocalAxis(installedModuleRecord.mountPoint.transform.localRotation * Vector3.right, Vector2.right),
					authoredLocalUp = ResolveAuthoredLocalAxis(installedModuleRecord.mountPoint.transform.localRotation * Vector3.up, Vector2.up),
					authoredLocalPosition = installedModuleRecord.mountPoint.transform.localPosition,
					authoredLocalRotation = installedModuleRecord.mountPoint.transform.localRotation,
					spec = weaponModuleDefinition.summerRaceWeaponDef.ToRuntimeSpec(SummerRaceConfigLoader.ToRuntimeWeaponKind(weaponModuleDefinition.WeaponType)),
					meleeImpactPayload = ((summerRaceCombatPayloadOverrideProvider != null) ? summerRaceCombatPayloadOverrideProvider.CreateWeaponImpactPayload(weaponModuleDefinition, CombatTriggerType.MeleeHit) : SummerRaceCombatEffectFactory.CreateWeaponImpactPayload(weaponModuleDefinition, CombatTriggerType.MeleeHit)),
					projectileImpactPayload = ((summerRaceCombatPayloadOverrideProvider != null) ? summerRaceCombatPayloadOverrideProvider.CreateWeaponImpactPayload(weaponModuleDefinition, CombatTriggerType.ProjectileHit) : SummerRaceCombatEffectFactory.CreateWeaponImpactPayload(weaponModuleDefinition, CombatTriggerType.ProjectileHit)),
					state = new WeaponRuntimeState
					{
						SlotIndex = weaponSlots.Count,
						CooldownUntil = 0f,
						DynamicSpread = 0f,
						OverloadUntil = ((ownerContext != null) ? ownerContext.ResolveWeaponOverloadUntil(weaponSlots.Count) : 0f)
					},
					lastSpreadUpdateTime = Time.time,
					continuousMeleeWindowOpen = false,
					continuousMeleeUntil = 0f,
					nextContinuousMeleeTickAt = 0f,
					continuousMeleeTickInterval = 0f,
					lastContinuousMeleeOrigin = Vector2.zero,
					lastContinuousMeleeDirection = Vector2.right,
					laserCycleDamageBudget = 0,
					laserCycleExpectedTicks = 0,
					laserCycleAppliedTicks = 0,
					laserCycleAppliedDamage = 0,
					sawVisualPoseCaptured = false,
					sawVisualAuthoredLocalPosition = Vector3.zero,
					sawVisualAuthoredLocalRotation = Quaternion.identity,
					sawVisualAuthoredLocalEuler = Vector3.zero,
					sawPivotLocalPoint = Vector2.zero,
					sawVisualSpinDegrees = 0f,
					sawVisualSpinSpeedDegPerSec = ResolveRotatingSawSpinSpeed(weaponModuleDefinition),
					overloadVisualActive = false
				});
				ApplyMountVisualSortingOrder(installedModuleRecord.mountPoint, ResolveWeaponEquipSortingOrderOrFallback());
				EnsureShovelColliderRuntimeForSlot(weaponSlots[weaponSlots.Count - 1]);
			}
		}
		selectedWeaponIndex = Mathf.Clamp(selectedWeaponIndex, 0, Mathf.Max(0, weaponSlots.Count - 1));
		if (projectilePrefab != null && base.isActiveAndEnabled && base.gameObject.activeInHierarchy)
		{
			EnsurePersistentBoomerangProjectiles();
			EnsureMountedProjectilePreviews();
			EnsureMountedRockets();
		}
		else
		{
			ClearPersistentBoomerangProjectiles();
			ClearMountedProjectilePreviews();
			ClearMountedRockets();
		}
	}

	private void LockWeaponMountAuthoringPose()
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && !(weaponRuntime.mount == null))
			{
				Transform obj = weaponRuntime.mount.transform;
				obj.localPosition = weaponRuntime.authoredLocalPosition;
				obj.localRotation = weaponRuntime.authoredLocalRotation;
			}
		}
	}

	private void TickShovelColliderPoses()
	{
		if (shovelColliderBySlot.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, ShovelColliderRuntime> item in shovelColliderBySlot)
		{
			ShovelColliderRuntime value = item.Value;
			if (value != null && !(value.root == null) && !(value.collider == null))
			{
				SyncShovelColliderPose(value);
			}
		}
	}

	private void TickRotatingSawVisuals()
	{
		if (weaponSlots.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (!IsRotatingSawWeapon(weaponRuntime))
			{
				continue;
			}
			Transform transform = ResolveRotatingSawVisualTransform(weaponRuntime);
			if (transform == null)
			{
				weaponRuntime.sawVisualPoseCaptured = false;
				weaponRuntime.sawVisualSpinDegrees = 0f;
				continue;
			}
			EnsureRotatingSawAuthoredPoseCaptured(weaponRuntime, transform);
			if (!weaponRuntime.sawVisualPoseCaptured)
			{
				continue;
			}
			if (!weaponRuntime.continuousMeleeWindowOpen)
			{
				RestoreRotatingSawAuthoredPose(weaponRuntime, transform);
				continue;
			}
			float num = Mathf.Max(0f, weaponRuntime.sawVisualSpinSpeedDegPerSec * weaponRuntime.def.RotatingSawSpinSpeedScale);
			if (!(num <= 0f))
			{
				weaponRuntime.sawVisualSpinDegrees = Mathf.Repeat(weaponRuntime.sawVisualSpinDegrees - num * Time.deltaTime, 360f);
				ApplyRotatingSawPose(weaponRuntime, transform, weaponRuntime.sawVisualSpinDegrees);
			}
		}
	}

	private static Transform ResolveRotatingSawVisualTransform(WeaponRuntime slot)
	{
		if (slot == null || !(slot.mount != null))
		{
			return null;
		}
		if (!(slot.mount.VisualInstance != null))
		{
			return null;
		}
		return slot.mount.VisualInstance.transform;
	}

	private static void EnsureRotatingSawAuthoredPoseCaptured(WeaponRuntime slot, Transform sawVisual)
	{
		if (slot != null && !(sawVisual == null) && !slot.sawVisualPoseCaptured)
		{
			slot.sawVisualAuthoredLocalPosition = sawVisual.localPosition;
			slot.sawVisualAuthoredLocalRotation = sawVisual.localRotation;
			slot.sawVisualAuthoredLocalEuler = sawVisual.localEulerAngles;
			slot.sawPivotLocalPoint = ResolveRotatingSawPivotLocalPointFromSpineOrThrow(slot.def, sawVisual);
			slot.sawVisualPoseCaptured = true;
			SummerRaceRuntimeLog.Verbose("[SummerRace][RotatingSaw] captured pivot. weapon=" + ((slot.def != null) ? slot.def.name : "<null>") + " pivotLocal=" + slot.sawPivotLocalPoint.ToString("F4") + " authoredLocalPos=" + slot.sawVisualAuthoredLocalPosition.ToString("F4") + " authoredLocalEuler=" + slot.sawVisualAuthoredLocalEuler.ToString("F2"));
		}
	}

	private static void RestoreRotatingSawAuthoredPose(WeaponRuntime slot, Transform sawVisual)
	{
		if (slot != null && !(sawVisual == null) && slot.sawVisualPoseCaptured)
		{
			slot.sawVisualSpinDegrees = 0f;
			sawVisual.localPosition = slot.sawVisualAuthoredLocalPosition;
			sawVisual.localEulerAngles = slot.sawVisualAuthoredLocalEuler;
		}
	}

	private static void ApplyRotatingSawPose(WeaponRuntime slot, Transform sawVisual, float spinDegrees)
	{
		if (slot != null && !(sawVisual == null) && slot.sawVisualPoseCaptured)
		{
			Vector2 sawPivotLocalPoint = slot.sawPivotLocalPoint;
			Vector3 sawVisualAuthoredLocalPosition = slot.sawVisualAuthoredLocalPosition;
			Vector2 vector = new Vector2(sawVisualAuthoredLocalPosition.x - sawPivotLocalPoint.x, sawVisualAuthoredLocalPosition.y - sawPivotLocalPoint.y);
			float f = spinDegrees * (MathF.PI / 180f);
			float num = Mathf.Cos(f);
			float num2 = Mathf.Sin(f);
			Vector2 vector2 = new Vector2(vector.x * num - vector.y * num2, vector.x * num2 + vector.y * num);
			sawVisual.localPosition = new Vector3(sawPivotLocalPoint.x + vector2.x, sawPivotLocalPoint.y + vector2.y, sawVisualAuthoredLocalPosition.z);
			float z = Mathf.Repeat(slot.sawVisualAuthoredLocalEuler.z + spinDegrees, 360f);
			sawVisual.localEulerAngles = new Vector3(slot.sawVisualAuthoredLocalEuler.x, slot.sawVisualAuthoredLocalEuler.y, z);
		}
	}

	private static float ResolveRotatingSawSpinSpeed(WeaponModuleDefinition def)
	{
		if (def == null)
		{
			return 900f;
		}
		if (SummerRaceCombatPresentationRouter.ResolveWeaponKind(def) != WeaponKind.RotatingSaw)
		{
			return 0f;
		}
		float num = Mathf.Abs(SummerRaceWeaponPresentationProfileResolver.Resolve(def).ContinuousSpinDegreesPerSecond);
		if (!(num > 0.01f))
		{
			return 900f;
		}
		return num;
	}

	private static Vector2 ResolveRotatingSawPivotLocalPointFromSpineOrThrow(WeaponModuleDefinition def, Transform sawVisual)
	{
		if (def == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] RotatingSaw pivot resolution requires weapon definition.");
		}
		Vector2 modularSpinePivotLocalOffset = def.ModularSpinePivotLocalOffset;
		if (float.IsNaN(modularSpinePivotLocalOffset.x) || float.IsInfinity(modularSpinePivotLocalOffset.x) || float.IsNaN(modularSpinePivotLocalOffset.y) || float.IsInfinity(modularSpinePivotLocalOffset.y))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] RotatingSaw modularSpinePivotLocalOffset is invalid. weapon=" + def.name);
		}
		return modularSpinePivotLocalOffset;
	}

	public void SelectWeapon(int index)
	{
		selectedWeaponIndex = Mathf.Clamp(index, 0, Mathf.Max(0, weaponSlots.Count - 1));
	}

	public void SelectNextWeapon()
	{
		if (weaponSlots.Count > 1)
		{
			selectedWeaponIndex = (selectedWeaponIndex + 1) % weaponSlots.Count;
		}
	}

	public bool FireSelectedWeapon()
	{
		if (weaponSlots.Count <= 0)
		{
			return false;
		}
		return TryFireSlot(weaponSlots[selectedWeaponIndex]);
	}

	public void SetAimTarget(Transform target)
	{
		aimTarget = target;
	}

	public void SetManualAimDirection(Vector2 direction)
	{
		if (!(direction.sqrMagnitude <= 0.0001f))
		{
			manualAimDirection = direction.normalized;
		}
	}

	public void ForceInterruptActiveFire(string reason, bool emitActiveExpired = true)
	{
		StopAllBurstCoroutines();
		StopContinuousMeleeTickLoop();
		ClearContinuousMeleeWindows(emitActiveExpired);
		TraceLog("[SummerRace][WeaponInterrupt] owner=" + base.name + " reason=" + (string.IsNullOrEmpty(reason) ? "unknown" : reason) + " emitActiveExpired=" + emitActiveExpired);
	}

	public void ClearProjectilesForWaveTransition()
	{
		DetachProjectileCallbacksBeforeTeardown();
		boomerangProjectilesBySlot.Clear();
		ClearPersistentBoomerangProjectiles();
		ClearMountedRockets();
		ClearProjectilePoolRuntimes(destroyPoolRoot: false);
		if (projectilePrefab != null && base.isActiveAndEnabled && base.gameObject.activeInHierarchy)
		{
			EnsurePersistentBoomerangProjectiles();
			EnsureMountedRockets();
		}
		TraceLog("[SummerRace][ProjectileClear] owner=" + base.name + " reason=wave_transition");
	}

	public bool IsSlotValid(int slotIndex)
	{
		if (slotIndex >= 0)
		{
			return slotIndex < weaponSlots.Count;
		}
		return false;
	}

	public bool TryGetSlotSnapshot(int slotIndex, out WeaponSlotSnapshot snapshot)
	{
		return TryGetWeaponSlotSnapshot(slotIndex, out snapshot);
	}

	public bool IsSlotReady(int slotIndex)
	{
		if (!IsSlotValid(slotIndex))
		{
			return false;
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		if (weaponRuntime == null)
		{
			return false;
		}
		SyncRuntimeStateFromOwner(weaponRuntime);
		if (weaponRuntime.burstRoutine == null)
		{
			return Time.time >= weaponRuntime.state.CooldownUntil;
		}
		return false;
	}

	public float GetSlotCooldownRemaining(int slotIndex)
	{
		if (!IsSlotValid(slotIndex))
		{
			return 0f;
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		if (weaponRuntime == null)
		{
			return 0f;
		}
		SyncRuntimeStateFromOwner(weaponRuntime);
		return Mathf.Max(0f, weaponRuntime.state.CooldownUntil - Time.time);
	}

	public string GetSlotLabel(int slotIndex)
	{
		if (!TryGetWeaponSlotSnapshot(slotIndex, out var snapshot) || !snapshot.IsValid)
		{
			return "Weapon N/A";
		}
		string text = (string.IsNullOrEmpty(snapshot.Label) ? "Weapon" : snapshot.Label);
		string text2 = ((snapshot.BurstCount > 1) ? "BURST" : "SEMI");
		string[] obj = new string[6] { text, " [", text2, "] (E", null, null };
		float energyCost = snapshot.EnergyCost;
		obj[4] = energyCost.ToString("F0");
		obj[5] = ")";
		return string.Concat(obj);
	}

	public bool TryFireSlot(int slotIndex)
	{
		if (!IsSlotValid(slotIndex))
		{
			return false;
		}
		return TryFireSlot(weaponSlots[slotIndex]);
	}

	private bool TryFireSlot(WeaponRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.def == null)
		{
			return false;
		}
		if (ownerContext == null)
		{
			EmitWeaponRejected(slot, "owner_missing");
			return false;
		}
		if (runtimePaused)
		{
			EmitWeaponRejected(slot, "runtime_paused");
			return false;
		}
		SyncRuntimeStateFromOwner(slot);
		if (Time.time < slot.state.CooldownUntil)
		{
			EmitWeaponRejected(slot, "cooldown");
			return false;
		}
		if (slot.burstRoutine != null)
		{
			EmitWeaponRejected(slot, "burst_busy");
			return false;
		}
		if (IsContinuousLaserBeamWeapon(slot) && slot.continuousMeleeWindowOpen)
		{
			EmitWeaponRejected(slot, "laser_beam_active");
			return false;
		}
		if (IsContinuousMeleeWeapon(slot) && slot.continuousMeleeWindowOpen)
		{
			EmitWeaponRejected(slot, "spin_melee_active");
			return false;
		}
		if (IsBoomerangWeapon(slot.def) && IsBoomerangProjectileInFlight(slot.slotIndex))
		{
			EmitWeaponRejected(slot, "boomerang_in_flight");
			return false;
		}
		bool flag = IsBoomerangWeapon(slot.def) || IsContinuousLaserBeamWeapon(slot);
		int num = ResolveRuntimeBurstCount(slot.def);
		if (num <= 1)
		{
			if (!FireOnce(slot))
			{
				return false;
			}
			if (!flag)
			{
				slot.state.CooldownUntil = Time.time + ResolveCooldown(slot);
			}
			return true;
		}
		if (!FireOnce(slot))
		{
			return false;
		}
		if (flag)
		{
			return true;
		}
		slot.state.CooldownUntil = Time.time + ResolveCooldown(slot);
		slot.burstRoutine = StartCoroutine(FireBurst(slot, num - 1));
		return true;
	}

	private IEnumerator FireBurst(WeaponRuntime slot, int remainingShots)
	{
		float burstDelta = Mathf.Max(0.02f, slot.def.BurstInterval);
		for (int i = 0; i < remainingShots; i++)
		{
			yield return new WaitForSeconds(burstDelta);
			if (!FireOnce(slot))
			{
				break;
			}
		}
		slot.burstRoutine = null;
	}

	private bool FireOnce(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null || slot.state == null || ownerContext == null)
		{
			return false;
		}
		DecayDynamicSpread(slot);
		float num = ResolveRuntimeBaseSpread(slot.def);
		float spread = Mathf.Max(0f, num + slot.state.DynamicSpread);
		Vector2 muzzleWorld = Vector2.zero;
		Vector2 fireDirection = Vector2.right;
		bool flag = IsContinuousMeleeWeapon(slot);
		bool flag2 = IsContinuousLaserBeamWeapon(slot);
		bool flag3 = flag | flag2;
		if (flag3)
		{
			if (!TryResolveContinuousWindowPose(slot, out muzzleWorld, out fireDirection))
			{
				throw new InvalidOperationException("[VehicleWeaponSystem] Continuous weapon pose resolution unexpectedly failed.");
			}
		}
		else if (!TryResolveFireContext(slot, out muzzleWorld, out fireDirection))
		{
			slot.state.LastRejectReason = "fire_context";
			EmitWeaponRejected(slot, slot.state.LastRejectReason);
			return false;
		}
		Vector2 spawnPosition = muzzleWorld;
		if (!flag3 && slot != null && slot.def != null && !slot.def.IsMelee)
		{
			if (IsMountedRocketWeapon(slot.def))
			{
				EnsureMountedRockets();
			}
			if (!TryResolveProjectileSpawnPosition(slot, muzzleWorld, out spawnPosition))
			{
				slot.state.LastRejectReason = "mounted_rocket_not_ready";
				EmitWeaponRejected(slot, slot.state.LastRejectReason);
				return false;
			}
		}
		if (!(flag ? TryStartContinuousMelee(slot, muzzleWorld, fireDirection) : (flag2 ? TryStartContinuousLaserBeam(slot, muzzleWorld, fireDirection) : (slot.def.IsMelee ? TryResolveMelee(slot, muzzleWorld, fireDirection) : TrySpawnProjectiles(slot, spawnPosition, fireDirection, spread)))))
		{
			slot.state.LastRejectReason = "fire_failed";
			EmitWeaponRejected(slot, slot.state.LastRejectReason);
			return false;
		}
		slot.state.DynamicSpread = Mathf.Clamp(slot.state.DynamicSpread + Mathf.Max(0f, slot.def.SpreadIncreasePerShot), 0f, Mathf.Max(num, slot.def.MaxSpread));
		slot.lastSpreadUpdateTime = Time.time;
		if (physicsController != null)
		{
			float num2 = Mathf.Max(0f, slot.def.RecoilImpulseValue);
			float num3 = ((!flag3 && !slot.def.IsMelee) ? Mathf.Max(1f, slot.def.ProjectileCount) : 1f);
			float num4 = Mathf.Max(0.01f, slot.def.RecoilAmplifyForGameplayValue);
			Vector2 vector = -fireDirection * num2;
			Vector2 vector2 = ResolveAuthoredAxisWorld(slot, slot.authoredLocalUp);
			Vector2 vector3 = vector2 * Mathf.Max(0f, slot.def.RecoilUpImpulse) * 0.35f;
			Vector2 vector4 = (vector + vector3) * num3 * num4;
			if (!IsFinite(vector4))
			{
				string[] obj = new string[12]
				{
					"[VehicleWeaponSystem] Non-finite recoil force detected. slot=",
					slot.slotIndex.ToString(),
					" recoil=",
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
				Vector2 vector5 = vector4;
				obj[3] = vector5.ToString();
				obj[4] = " fireDir=";
				vector5 = fireDirection;
				obj[5] = vector5.ToString();
				obj[6] = " recoilUpAxis=";
				vector5 = vector2;
				obj[7] = vector5.ToString();
				obj[8] = " volleyMultiplier=";
				obj[9] = num3.ToString("F3");
				obj[10] = " weaponRecoilMultiplier=";
				obj[11] = num4.ToString("F3");
				throw new InvalidOperationException(string.Concat(obj));
			}
			if (enableRecoilTraceLog && SummerRaceRuntimeLog.IsGameplayVerboseEnabled)
			{
				string[] obj2 = new string[26]
				{
					"[SummerRace][RecoilTrace][Weapon] owner=",
					base.name,
					" slot=",
					slot.slotIndex.ToString(),
					" weapon=",
					slot.def.WeaponType.ToString(),
					" recoilBack=",
					num2.ToString("F3"),
					" recoilUp=",
					slot.def.RecoilUpImpulse.ToString("F3"),
					" projectileCount=",
					slot.def.ProjectileCount.ToString(),
					" volleyMultiplier=",
					num3.ToString("F3"),
					" weaponRecoilMultiplier=",
					num4.ToString("F3"),
					" fireDir=",
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
				Vector2 vector5 = fireDirection;
				obj2[17] = vector5.ToString();
				obj2[18] = " recoilRaw=";
				vector5 = vector4;
				obj2[19] = vector5.ToString();
				obj2[20] = " muzzle=";
				vector5 = muzzleWorld;
				obj2[21] = vector5.ToString();
				obj2[22] = " t=";
				obj2[23] = Time.time.ToString("F3");
				obj2[24] = " frame=";
				obj2[25] = Time.frameCount.ToString();
				SummerRaceRuntimeLog.Verbose(string.Concat(obj2));
			}
			Vector2 velocityWorld = physicsController.VelocityWorld;
			physicsController.ApplyWeaponRecoil(vector4, muzzleWorld, slot.def.RecoilSpring, slot.def.RecoilDamping);
			if (enableRecoilTraceLog && SummerRaceRuntimeLog.IsGameplayVerboseEnabled)
			{
				Vector2 velocityWorld2 = physicsController.VelocityWorld;
				string[] obj3 = new string[18]
				{
					"[SummerRace][RecoilTrace][Apply] owner=",
					base.name,
					" slot=",
					slot.slotIndex.ToString(),
					" weapon=",
					slot.def.WeaponType.ToString(),
					" velBefore=",
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
				Vector2 vector5 = velocityWorld;
				obj3[7] = vector5.ToString();
				obj3[8] = " velAfter=";
				vector5 = velocityWorld2;
				obj3[9] = vector5.ToString();
				obj3[10] = " velDelta=";
				obj3[11] = (velocityWorld2 - velocityWorld).ToString();
				obj3[12] = " recoilRaw=";
				vector5 = vector4;
				obj3[13] = vector5.ToString();
				obj3[14] = " t=";
				obj3[15] = Time.time.ToString("F3");
				obj3[16] = " frame=";
				obj3[17] = Time.frameCount.ToString();
				SummerRaceRuntimeLog.Verbose(string.Concat(obj3));
			}
		}
		if (!flag3 && !slot.def.IsMelee)
		{
			MarkMountedProjectileConsumed(slot);
			ownerContext.OnWeaponRuntimeFire(slot.slotIndex, slot.spec);
			Vector2 muzzle = (IsMountedRocketWeapon(slot.def) ? spawnPosition : muzzleWorld);
			EmitWeaponFired(slot, muzzle, fireDirection);
			if (slot.def.WeaponType == SummerRaceWeaponTypeConfig.MachineGun && slot.def.MuzzleAlternatingYOffsetValue > 0f)
			{
				slot.muzzleAlternatingStep++;
			}
		}
		slot.state.LastRejectReason = string.Empty;
		return true;
	}

	private bool TryResolveMelee(WeaponRuntime slot, Vector2 muzzle, Vector2 fireDir)
	{
		if (!TryCreateMeleeImpactContext(slot, muzzle, fireDir, out var impactContext))
		{
			return false;
		}
		ownerContext.OnWeaponRuntimeFire(slot.slotIndex, slot.spec);
		EmitWeaponFired(slot, muzzle, fireDir);
		return ApplyCollectedMeleeImpacts(impactContext);
	}

	private bool TryStartContinuousMelee(WeaponRuntime slot, Vector2 attackOrigin, Vector2 attackDirection)
	{
		float num = ResolveContinuousMeleeTickInterval(slot);
		ownerContext.OnWeaponRuntimeFire(slot.slotIndex, slot.spec);
		EmitWeaponFired(slot, attackOrigin, attackDirection);
		slot.continuousMeleeWindowOpen = true;
		slot.continuousMeleeUntil = float.PositiveInfinity;
		slot.nextContinuousMeleeTickAt = Time.time + num;
		slot.continuousMeleeTickInterval = num;
		slot.lastContinuousMeleeOrigin = attackOrigin;
		slot.lastContinuousMeleeDirection = attackDirection.normalized;
		EmitWeaponActivated(slot, attackOrigin, attackDirection);
		EnsureContinuousMeleeTickLoopRunning();
		if (TryCreateMeleeImpactContext(slot, attackOrigin, attackDirection, out var impactContext))
		{
			return ApplyCollectedMeleeImpacts(impactContext);
		}
		return true;
	}

	private bool TryStartContinuousLaserBeam(WeaponRuntime slot, Vector2 attackOrigin, Vector2 attackDirection)
	{
		float num = ResolveContinuousLaserBeamTickInterval(slot);
		float num2 = ResolveContinuousLaserBeamDuration(slot);
		Vector2 vector = ResolveContinuousLaserDirection(slot, attackDirection);
		InitializeContinuousLaserDamageBudget(slot, num, num2);
		ownerContext.OnWeaponRuntimeFire(slot.slotIndex, slot.spec);
		EmitWeaponFired(slot, attackOrigin, vector);
		slot.continuousMeleeWindowOpen = true;
		slot.continuousMeleeUntil = Mathf.Max(slot.continuousMeleeUntil, Time.time + num2);
		slot.nextContinuousMeleeTickAt = Time.time + num;
		slot.continuousMeleeTickInterval = num;
		slot.lastContinuousMeleeOrigin = attackOrigin;
		slot.lastContinuousMeleeDirection = vector;
		EmitWeaponActivated(slot, attackOrigin, vector);
		EnsureContinuousMeleeTickLoopRunning();
		EmitWeaponImpact(slot, attackOrigin, vector, null, 0);
		return TryApplyContinuousLaserBeamDamage(slot, attackOrigin, vector);
	}

	private bool TryApplyContinuousLaserBeamDamage(WeaponRuntime slot, Vector2 sourcePoint, Vector2 attackDirection)
	{
		int tickDamage = ResolveAndConsumeContinuousLaserTickDamage(slot);
		CombatImpactPayload combatImpactPayload = BuildContinuousLaserTickPayload(slot.projectileImpactPayload, tickDamage);
		if (combatImpactPayload == null)
		{
			return false;
		}
		if (!TryCollectLaserBeamTargets(slot, sourcePoint, attackDirection, out var resolvedDirection))
		{
			return false;
		}
		if (!TryCreateWeaponImpactContext(slot, combatImpactPayload, sourcePoint, resolvedDirection, meleeTargets.Count, out var impactContext))
		{
			meleeTargets.Clear();
			return false;
		}
		bool flag = false;
		meleeTargetTransforms.Clear();
		for (int i = 0; i < meleeTargets.Count; i++)
		{
			ICombatStatusHost combatStatusHost = meleeTargets[i];
			if (combatStatusHost != null)
			{
				Transform combatTransform = combatStatusHost.CombatTransform;
				if (!(combatTransform != null) || meleeTargetTransforms.Add(combatTransform))
				{
					flag |= ApplyWeaponImpactWithoutPresentation(impactContext, combatStatusHost).Success;
				}
			}
		}
		meleeTargets.Clear();
		meleeTargetTransforms.Clear();
		return flag;
	}

	private bool TryCollectLaserBeamTargets(WeaponRuntime slot, Vector2 sourcePoint, Vector2 attackDirection, out Vector2 resolvedDirection)
	{
		resolvedDirection = ResolveContinuousLaserDirection(slot, attackDirection);
		float num = Mathf.Max(0.1f, ResolveWeaponReach(slot));
		float num2 = Mathf.Max(0.1f, Mathf.Abs(slot.def.MeleeRadius) * 0.5f, Mathf.Abs(slot.def.ProjectileColliderRadius), Mathf.Abs(slot.def.ProjectileVisualSize.y) * 0.5f);
		Vector2 point = sourcePoint + resolvedDirection * (num * 0.5f);
		float num3 = Mathf.Sqrt(num * 0.5f * (num * 0.5f) + num2 * num2) + 0.15f;
		Vector2 size = new Vector2(num, num2 * 2f);
		float angle = Mathf.Atan2(resolvedDirection.y, resolvedDirection.x) * 57.29578f;
		meleeTargets.Clear();
		meleeTargetTransforms.Clear();
		int num4 = Physics2D.OverlapBox(point, size, angle, shovelOverlapFilter, laserOverlapBuffer);
		for (int i = 0; i < num4; i++)
		{
			TryAppendShovelMeleeTarget(laserOverlapBuffer[i]);
		}
		Vector2 vector;
		if (meleeTargets.Count <= 0)
		{
			string[] obj = new string[16]
			{
				"[SummerRace][LaserHit] no overlapped targets slot=",
				(slot?.slotIndex ?? (-1)).ToString(),
				" source=",
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
			vector = sourcePoint;
			obj[3] = vector.ToString();
			obj[4] = " dir=";
			vector = resolvedDirection;
			obj[5] = vector.ToString();
			obj[6] = " len=";
			obj[7] = num.ToString("F2");
			obj[8] = " halfWidth=";
			obj[9] = num2.ToString("F2");
			obj[10] = " angle=";
			obj[11] = angle.ToString("F2");
			obj[12] = " overlaps=";
			obj[13] = num4.ToString();
			obj[14] = " coarseRadius=";
			obj[15] = num3.ToString("F2");
			TraceLog(string.Concat(obj));
			meleeTargetTransforms.Clear();
			meleeTargets.Clear();
			return false;
		}
		string[] obj2 = new string[18]
		{
			"[SummerRace][LaserHit] overlap-box resolved slot=",
			(slot?.slotIndex ?? (-1)).ToString(),
			" overlaps=",
			num4.ToString(),
			" targets=",
			meleeTargets.Count.ToString(),
			" source=",
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
		vector = sourcePoint;
		obj2[7] = vector.ToString();
		obj2[8] = " dir=";
		vector = resolvedDirection;
		obj2[9] = vector.ToString();
		obj2[10] = " len=";
		obj2[11] = num.ToString("F2");
		obj2[12] = " halfWidth=";
		obj2[13] = num2.ToString("F2");
		obj2[14] = " angle=";
		obj2[15] = angle.ToString("F2");
		obj2[16] = " coarseRadius=";
		obj2[17] = num3.ToString("F2");
		TraceLog(string.Concat(obj2));
		meleeTargetTransforms.Clear();
		return meleeTargets.Count > 0;
	}

	private IEnumerator ContinuousMeleeTickLoop()
	{
		while (HasOpenContinuousMeleeWindows())
		{
			if (runtimePaused)
			{
				yield return null;
				continue;
			}
			TickContinuousMeleeWindows();
			yield return null;
		}
		continuousMeleeTickRoutine = null;
	}

	private void TickContinuousMeleeWindows()
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime == null || !weaponRuntime.continuousMeleeWindowOpen)
			{
				continue;
			}
			if (IsContinuousLaserBeamWeapon(weaponRuntime) && Time.time >= weaponRuntime.continuousMeleeUntil)
			{
				weaponRuntime.continuousMeleeWindowOpen = false;
				if (IsContinuousLaserBeamWeapon(weaponRuntime))
				{
					weaponRuntime.state.CooldownUntil = Mathf.Max(weaponRuntime.state.CooldownUntil, Time.time + ResolveCooldown(weaponRuntime));
				}
				EmitWeaponActiveExpired(weaponRuntime, weaponRuntime.lastContinuousMeleeOrigin, weaponRuntime.lastContinuousMeleeDirection);
			}
			else if (!(Time.time < weaponRuntime.nextContinuousMeleeTickAt))
			{
				if (!TryResolveContinuousWindowPose(weaponRuntime, out var attackOrigin, out var attackDirection))
				{
					throw new InvalidOperationException("[VehicleWeaponSystem] Continuous weapon pose resolution unexpectedly failed during tick.");
				}
				float num = (weaponRuntime.continuousMeleeTickInterval = (IsContinuousLaserBeamWeapon(weaponRuntime) ? ResolveContinuousLaserBeamTickInterval(weaponRuntime) : ResolveContinuousMeleeTickInterval(weaponRuntime)));
				weaponRuntime.nextContinuousMeleeTickAt = Time.time + num;
				weaponRuntime.lastContinuousMeleeOrigin = attackOrigin;
				if (IsContinuousLaserBeamWeapon(weaponRuntime))
				{
					weaponRuntime.lastContinuousMeleeDirection = ResolveContinuousLaserDirection(weaponRuntime, attackDirection);
				}
				else
				{
					weaponRuntime.lastContinuousMeleeDirection = attackDirection.normalized;
				}
				WeaponImpactContext impactContext;
				if (IsContinuousLaserBeamWeapon(weaponRuntime))
				{
					TryApplyContinuousLaserBeamDamage(weaponRuntime, attackOrigin, weaponRuntime.lastContinuousMeleeDirection);
				}
				else if (TryCreateMeleeImpactContext(weaponRuntime, attackOrigin, attackDirection, out impactContext))
				{
					ApplyCollectedMeleeImpacts(impactContext);
				}
			}
		}
	}

	private bool HasOpenContinuousMeleeWindows()
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && weaponRuntime.continuousMeleeWindowOpen)
			{
				return true;
			}
		}
		return false;
	}

	private void EnsureContinuousMeleeTickLoopRunning()
	{
		if (continuousMeleeTickRoutine == null)
		{
			continuousMeleeTickRoutine = StartCoroutine(ContinuousMeleeTickLoop());
		}
	}

	private void StopContinuousMeleeTickLoop()
	{
		if (continuousMeleeTickRoutine != null)
		{
			StopCoroutine(continuousMeleeTickRoutine);
			continuousMeleeTickRoutine = null;
		}
	}

	private bool IsContinuousMeleeWeapon(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null && slot.def.IsMelee)
		{
			if (SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) != WeaponKind.RotatingSaw && SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) != WeaponKind.Drill)
			{
				return SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) == WeaponKind.Shovel;
			}
			return true;
		}
		return false;
	}

	private static bool IsRotatingSawWeapon(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null)
		{
			return SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) == WeaponKind.RotatingSaw;
		}
		return false;
	}

	private bool IsContinuousLaserBeamWeapon(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null && !slot.def.IsMelee)
		{
			return SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) == WeaponKind.LaserCannon;
		}
		return false;
	}

	private static int ResolveContinuousLaserExpectedTickCount(float tickInterval, float activeDuration)
	{
		float num = Mathf.Max(0.0001f, tickInterval);
		float num2 = Mathf.Max(0.0001f, activeDuration);
		return Mathf.Max(1, Mathf.CeilToInt(num2 / num));
	}

	private void InitializeContinuousLaserDamageBudget(WeaponRuntime slot, float tickInterval, float activeDuration)
	{
		if (slot != null)
		{
			slot.laserCycleDamageBudget = Mathf.Max(0, (slot.def != null) ? slot.def.Damage : 0);
			slot.laserCycleExpectedTicks = ResolveContinuousLaserExpectedTickCount(tickInterval, activeDuration);
			slot.laserCycleAppliedTicks = 0;
			slot.laserCycleAppliedDamage = 0;
			TraceLog("[SummerRace][LaserDamageBudget] init slot=" + slot.slotIndex + " budget=" + slot.laserCycleDamageBudget + " expectedTicks=" + slot.laserCycleExpectedTicks + " tickInterval=" + tickInterval.ToString("F3") + " duration=" + activeDuration.ToString("F3"));
		}
	}

	private static int ResolveAndConsumeContinuousLaserTickDamage(WeaponRuntime slot)
	{
		if (slot == null)
		{
			return 0;
		}
		int num = Mathf.Max(1, slot.laserCycleExpectedTicks - slot.laserCycleAppliedTicks);
		int num2 = Mathf.Max(0, slot.laserCycleDamageBudget - slot.laserCycleAppliedDamage);
		int num3 = ((num == 1) ? num2 : Mathf.Clamp(Mathf.CeilToInt((float)num2 / (float)num), 0, num2));
		slot.laserCycleAppliedTicks++;
		slot.laserCycleAppliedDamage += num3;
		return num3;
	}

	private static CombatImpactPayload BuildContinuousLaserTickPayload(CombatImpactPayload basePayload, int tickDamage)
	{
		if (basePayload == null)
		{
			return null;
		}
		CombatEffectSpec[] effects = basePayload.effects;
		if (effects == null || effects.Length == 0)
		{
			return basePayload;
		}
		CombatEffectSpec[] array = new CombatEffectSpec[effects.Length];
		for (int i = 0; i < effects.Length; i++)
		{
			CombatEffectSpec combatEffectSpec = effects[i];
			if (combatEffectSpec != null)
			{
				CombatEffectSpec combatEffectSpec2 = new CombatEffectSpec
				{
					effectKind = combatEffectSpec.effectKind,
					trigger = combatEffectSpec.trigger,
					targetSelector = combatEffectSpec.targetSelector,
					magnitude = combatEffectSpec.magnitude,
					duration = combatEffectSpec.duration,
					radius = combatEffectSpec.radius,
					enabled = combatEffectSpec.enabled
				};
				if (combatEffectSpec2.effectKind == CombatEffectKind.Damage)
				{
					combatEffectSpec2.magnitude = tickDamage;
				}
				array[i] = combatEffectSpec2;
			}
		}
		return new CombatImpactPayload
		{
			trigger = basePayload.trigger,
			effects = array,
			boomerangFlight = basePayload.boomerangFlight
		};
	}

	private Vector2 ResolveContinuousLaserDirection(WeaponRuntime slot, Vector2 fallbackDirection)
	{
		if (slot != null && TryResolveFireDirection(slot, out var direction))
		{
			return direction;
		}
		if (fallbackDirection.sqrMagnitude > 0.0001f)
		{
			return fallbackDirection.normalized;
		}
		return ResolveWeaponDirection(slot);
	}

	private bool TryResolveContinuousWindowPose(WeaponRuntime slot, out Vector2 attackOrigin, out Vector2 attackDirection)
	{
		attackOrigin = Vector2.zero;
		attackDirection = Vector2.zero;
		if (slot == null || slot.mount == null || slot.def == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Continuous window slot is invalid.");
		}
		if (!TryResolveFireContext(slot, out attackOrigin, out attackDirection))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Continuous window pose is invalid from mount authored axis.");
		}
		return true;
	}

	private float ResolveContinuousMeleeTickInterval(WeaponRuntime slot)
	{
		float num = ((ownerContext as IWeaponContinuousMeleeContextProvider) ?? throw new InvalidOperationException("[VehicleWeaponSystem] Owner context must implement IWeaponContinuousMeleeContextProvider for RotatingSaw.")).ResolveContinuousMeleeTickInterval(slot.slotIndex, slot.spec);
		if (num <= 0f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Continuous melee tick interval must be positive.");
		}
		if (IsRotatingSawWeapon(slot))
		{
			float num2 = Mathf.Clamp01(slot.def.RotatingSawSpinSpeedScale);
			if (num2 <= 0f)
			{
				return float.PositiveInfinity;
			}
			num /= num2;
		}
		if (IsShovelWeapon(slot))
		{
			float b = Mathf.Max(0.016f, Time.fixedDeltaTime);
			num = Mathf.Min(num, b);
		}
		return num;
	}

	private float ResolveContinuousMeleeWindowDuration(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null || slot.def.summerRaceWeaponDef == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Continuous melee window duration requires authored weapon definition.");
		}
		return Mathf.Max(0.1f, SummerRaceBuildScoring.ResolveRuntimeWeaponCycleDuration(slot.def.summerRaceWeaponDef));
	}

	private float ResolveContinuousLaserBeamTickInterval(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Continuous laser tick interval requires valid slot.");
		}
		return Mathf.Clamp((slot.def.BurstInterval > 0f) ? slot.def.BurstInterval : Mathf.Max(0.05f, slot.def.FireIntervalValue * 0.2f), 0.05f, 0.25f);
	}

	private float ResolveContinuousLaserBeamDuration(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Continuous laser duration requires valid slot.");
		}
		return Mathf.Max(0.1f, slot.def.ProjectileLifetime);
	}

	private bool TryCreateMeleeImpactContext(WeaponRuntime slot, Vector2 sourcePoint, Vector2 attackDirection, out WeaponImpactContext impactContext)
	{
		impactContext = default(WeaponImpactContext);
		if (slot == null || slot.def == null)
		{
			return false;
		}
		if (IsRotatingSawWeapon(slot) && Mathf.Clamp01(slot.def.RotatingSawSpinSpeedScale) <= 0f)
		{
			return false;
		}
		Vector2 vector = ((attackDirection.sqrMagnitude > 0.0001f) ? attackDirection.normalized : ResolveWeaponDirection(slot));
		if (IsShovelWeapon(slot))
		{
			CollectShovelTargetsAtHeadPolygon(slot, vector);
		}
		else if (IsDrillWeapon(slot))
		{
			CollectDrillTargetsAlongVisualRange(slot, sourcePoint, vector);
		}
		else
		{
			float radius = Mathf.Max(0.1f, slot.def.MeleeRadius);
			Vector2 center = (IsRotatingSawWeapon(slot) ? ResolveRotatingSawDamageCenterOrThrow(slot) : (sourcePoint + vector * Mathf.Max(0.1f, slot.def.MeleeRange)));
			SummerRaceCombatResolver.CollectTargetsNearPoint(ownerContext, center, radius, meleeTargets);
		}
		if (IsShovelWeapon(slot))
		{
			TraceShovelMeleeProbe(slot, sourcePoint, vector, meleeTargets.Count);
		}
		if (meleeTargets.Count <= 0)
		{
			meleeTargets.Clear();
			return false;
		}
		if (!TryCreateWeaponImpactContext(slot, slot.meleeImpactPayload, sourcePoint, vector, meleeTargets.Count, out impactContext))
		{
			meleeTargets.Clear();
			return false;
		}
		return true;
	}

	private static Vector2 ResolveRotatingSawDamageCenterOrThrow(WeaponRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] RotatingSaw damage center requires mount visual instance.");
		}
		Vector3 position = slot.mount.VisualInstance.transform.position;
		if (float.IsNaN(position.x) || float.IsInfinity(position.x) || float.IsNaN(position.y) || float.IsInfinity(position.y))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] RotatingSaw damage center resolved to non-finite world position.");
		}
		return new Vector2(position.x, position.y);
	}

	private bool IsDrillWeapon(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null)
		{
			return SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) == WeaponKind.Drill;
		}
		return false;
	}

	private bool IsShovelWeapon(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null)
		{
			return SummerRaceCombatPresentationRouter.ResolveWeaponKind(slot.def) == WeaponKind.Shovel;
		}
		return false;
	}

	private static bool IsRocketWeapon(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null && slot.def.WeaponType == SummerRaceWeaponTypeConfig.RocketLauncher)
		{
			return !slot.def.IsMelee;
		}
		return false;
	}

	private void CollectDrillTargetsAlongVisualRange(WeaponRuntime slot, Vector2 sourcePoint, Vector2 direction)
	{
		if (slot != null && !(slot.def == null))
		{
			Vector2 direction2 = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : ResolveWeaponDirection(slot));
			DrillHitboxRect drillHitboxRect = ResolveDrillReferenceHitboxOrThrow(slot);
			meleeTargets.Clear();
			meleeTargetTransforms.Clear();
			int num = Physics2D.OverlapBox(drillHitboxRect.Center, drillHitboxRect.Size, drillHitboxRect.AngleDeg, shovelOverlapFilter, drillOverlapBuffer);
			for (int i = 0; i < num; i++)
			{
				TryAppendShovelMeleeTarget(drillOverlapBuffer[i]);
			}
			TraceDrillMeleeProbe(slot, sourcePoint, direction2, drillHitboxRect.Center, Mathf.Max(drillHitboxRect.Size.x, drillHitboxRect.Size.y) * 0.5f, meleeTargets.Count);
			string[] obj = new string[14]
			{
				"[SummerRace][DrillHitBox] slot=",
				slot.slotIndex.ToString(),
				" source=",
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
			Vector2 vector = sourcePoint;
			obj[3] = vector.ToString();
			obj[4] = " center=";
			obj[5] = drillHitboxRect.Center.ToString();
			obj[6] = " size=";
			obj[7] = drillHitboxRect.Size.ToString();
			obj[8] = " angle=";
			float angleDeg = drillHitboxRect.AngleDeg;
			obj[9] = angleDeg.ToString("F1");
			obj[10] = " source=VisualReference overlaps=";
			obj[11] = num.ToString();
			obj[12] = " targets=";
			obj[13] = meleeTargets.Count.ToString();
			TraceLog(string.Concat(obj));
		}
	}

	private static DrillHitboxRect ResolveDrillReferenceHitboxOrThrow(WeaponRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Drill hitbox requires mount visual instance.");
		}
		Transform transform = slot.mount.VisualInstance.transform;
		Transform transform2 = transform.Find("Visual");
		if (transform2 == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Drill hitbox requires child 'Visual' under mount visual instance. mount=" + transform.name);
		}
		Vector3 vector = transform2.TransformPoint(DrillHitboxReferenceVisualLocalCenter);
		Vector3 lossyScale = transform2.lossyScale;
		Vector2 vector2 = new Vector2(Mathf.Abs(DrillHitboxReferenceLocalSize.x * lossyScale.x), Mathf.Abs(DrillHitboxReferenceLocalSize.y * lossyScale.y));
		if (vector2.x <= 0.0001f || vector2.y <= 0.0001f)
		{
			string text = transform2.name;
			Vector2 vector3 = vector2;
			throw new InvalidOperationException("[VehicleWeaponSystem] Drill hitbox reference resolved non-positive size. visual=" + text + " size=" + vector3.ToString());
		}
		Vector2 vector4 = new Vector2(vector.x, vector.y);
		if (!IsFinite(vector4))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Drill hitbox reference resolved non-finite center. visual=" + transform2.name);
		}
		return new DrillHitboxRect(vector4, vector2, transform2.eulerAngles.z);
	}

	private void CollectShovelTargetsAtHeadPolygon(WeaponRuntime slot, Vector2 direction)
	{
		meleeTargets.Clear();
		if (!TryEnsureShovelColliderRuntime(slot, out var runtime) || runtime == null)
		{
			return;
		}
		Vector2 previousSampleWorldPos = runtime.previousSampleWorldPos;
		bool hasPreviousSampleWorldPos = runtime.hasPreviousSampleWorldPos;
		SyncShovelColliderPose(runtime);
		Physics2D.SyncTransforms();
		Vector2 vector = runtime.root.position;
		float time = Time.time;
		float num = (hasPreviousSampleWorldPos ? Mathf.Max(0.001f, time - runtime.previousSampleTime) : Mathf.Max(0.001f, Time.deltaTime));
		runtime.lastSampleVelocity = (hasPreviousSampleWorldPos ? ((vector - previousSampleWorldPos) / num) : Vector2.zero);
		runtime.previousSampleWorldPos = vector;
		runtime.previousSampleTime = time;
		runtime.hasPreviousSampleWorldPos = true;
		shovelHeadPolygonCount = FillShovelHeadPolygonFromCollider(runtime, shovelHeadPolygon);
		TraceShovelSpineObservation(runtime);
		meleeTargetTransforms.Clear();
		int num2 = runtime.collider.OverlapCollider(shovelOverlapFilter, shovelOverlapBuffer);
		for (int i = 0; i < num2; i++)
		{
			Collider2D other = shovelOverlapBuffer[i];
			TryAppendShovelMeleeTarget(other);
		}
		int num3 = 0;
		float num4 = 0f;
		if (hasPreviousSampleWorldPos)
		{
			Vector2 vector2 = vector - previousSampleWorldPos;
			num4 = vector2.magnitude;
			if (num4 > 0.0005f)
			{
				Vector2 direction2 = vector2 / num4;
				num3 = runtime.collider.Cast(direction2, shovelOverlapFilter, shovelCastBuffer, num4 + 0.02f);
				for (int j = 0; j < num3; j++)
				{
					Collider2D collider = shovelCastBuffer[j].collider;
					TryAppendShovelMeleeTarget(collider);
				}
			}
		}
		string[] obj = new string[12]
		{
			"[SummerRace][ShovelProbe] slot=",
			slot.slotIndex.ToString(),
			" overlap=",
			num2.ToString(),
			" cast=",
			num3.ToString(),
			" travel=",
			num4.ToString("F4"),
			" sampleVel=",
			null,
			null,
			null
		};
		Vector2 lastSampleVelocity = runtime.lastSampleVelocity;
		obj[9] = lastSampleVelocity.ToString();
		obj[10] = " targets=";
		obj[11] = meleeTargets.Count.ToString();
		TraceLog(string.Concat(obj));
		meleeTargetTransforms.Clear();
	}

	private void TryAppendShovelMeleeTarget(Collider2D other)
	{
		if (!(other == null) && other.gameObject.layer == characterLayer && SummerRaceCombatResolver.TryResolveStatusHost(other, out var statusHost) && statusHost != null && statusHost.IsCombatAlive && IsOpponentHost(statusHost))
		{
			Transform combatTransform = statusHost.CombatTransform;
			if (!(combatTransform == null) && meleeTargetTransforms.Add(combatTransform))
			{
				meleeTargets.Add(statusHost);
			}
		}
	}

	private bool IsOpponentHost(ICombatStatusHost host)
	{
		if (ownerContext == null || host == null)
		{
			return false;
		}
		SummerRaceCombatTeam combatTeam = ownerContext.CombatTeam;
		SummerRaceCombatTeam combatTeam2 = host.CombatTeam;
		if (combatTeam == SummerRaceCombatTeam.None || combatTeam2 == SummerRaceCombatTeam.None)
		{
			return false;
		}
		return combatTeam != combatTeam2;
	}

	private void EnsureShovelColliderRuntimeForSlot(WeaponRuntime slot)
	{
		if (IsShovelWeapon(slot))
		{
			TryEnsureShovelColliderRuntime(slot, out var _);
		}
	}

	private bool TryEnsureShovelColliderRuntime(WeaponRuntime slot, out ShovelColliderRuntime runtime)
	{
		runtime = null;
		if (!IsShovelWeapon(slot))
		{
			return false;
		}
		Transform transform = ResolveShovelVisualParentOrThrow(slot);
		if (shovelColliderBySlot.TryGetValue(slot.slotIndex, out var value) && value != null)
		{
			if (value.root != null && value.collider != null && value.root.parent == transform)
			{
				runtime = value;
				return true;
			}
			if (value.root != null)
			{
				UnityEngine.Object.Destroy(value.root.gameObject);
			}
			shovelColliderBySlot.Remove(slot.slotIndex);
		}
		GameObject gameObject = new GameObject("ShovelHitbox_" + slot.slotIndex);
		gameObject.layer = characterLayer;
		gameObject.transform.SetParent(transform, worldPositionStays: false);
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.localRotation = Quaternion.identity;
		gameObject.transform.localScale = Vector3.one;
		PolygonCollider2D polygonCollider2D = gameObject.AddComponent<PolygonCollider2D>();
		polygonCollider2D.isTrigger = true;
		polygonCollider2D.includeLayers = characterLayerMask;
		polygonCollider2D.excludeLayers = ~(int)characterLayerMask;
		polygonCollider2D.pathCount = 1;
		SkeletonAnimation mountSkeletonAnimation = ResolveMountSkeletonAnimation(slot);
		string text = ResolveShovelAnchorSlotNameOrThrow(slot, mountSkeletonAnimation);
		runtime = new ShovelColliderRuntime
		{
			slot = slot,
			root = gameObject.transform,
			collider = polygonCollider2D,
			mountSkeletonAnimation = mountSkeletonAnimation,
			anchorSlotName = text
		};
		ApplyShovelColliderShape(runtime);
		SyncShovelColliderPose(runtime);
		shovelColliderBySlot[slot.slotIndex] = runtime;
		TraceLog("[SummerRace][ShovelCollider] built slot=" + slot.slotIndex + " parent=" + transform.name + " anchorSlot=" + text);
		return true;
	}

	private static Transform ResolveShovelVisualParentOrThrow(WeaponRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider requires mount visual instance.");
		}
		Transform transform = slot.mount.VisualInstance.transform;
		Transform obj = transform.Find("Visual");
		if (obj == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider requires child 'Visual' under mount visual instance. mount=" + transform.name);
		}
		return obj;
	}

	private static int FillShovelHeadPolygonFromCollider(ShovelColliderRuntime runtime, Vector2[] polygon)
	{
		if (runtime == null || runtime.root == null || runtime.collider == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider runtime is invalid.");
		}
		if (polygon == null || polygon.Length < 3)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel polygon buffer must contain at least 3 points.");
		}
		Vector2[] path = runtime.collider.GetPath(0);
		int num = Mathf.Min(polygon.Length, path.Length);
		for (int i = 0; i < num; i++)
		{
			polygon[i] = runtime.root.TransformPoint(path[i]);
		}
		for (int j = num; j < polygon.Length; j++)
		{
			polygon[j] = runtime.root.position;
		}
		return num;
	}

	private static void ApplyShovelColliderShape(ShovelColliderRuntime runtime)
	{
		if (runtime == null || runtime.collider == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider shape apply requires valid runtime.");
		}
		Vector2[] array = new Vector2[ShovelHitboxLocalPoints.Length];
		for (int i = 0; i < ShovelHitboxLocalPoints.Length; i++)
		{
			array[i] = ShovelHitboxLocalPoints[i];
		}
		runtime.collider.pathCount = 1;
		runtime.collider.SetPath(0, array);
	}

	private static string ResolveShovelAnchorSlotNameOrThrow(WeaponRuntime slot, SkeletonAnimation mountSkeletonAnimation)
	{
		if (mountSkeletonAnimation == null || mountSkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider anchor resolve requires emitter skeleton. weapon=" + ((slot != null && slot.def != null) ? slot.def.name : "<null>"));
		}
		if (mountSkeletonAnimation.Skeleton.FindSlot("chandou2") == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider anchor slot not found. weapon=" + ((slot != null && slot.def != null) ? slot.def.name : "<null>") + " requiredSlot=chandou2");
		}
		return "chandou2";
	}

	private static void SyncShovelColliderPose(ShovelColliderRuntime runtime)
	{
		if (runtime == null || runtime.root == null || runtime.mountSkeletonAnimation == null || runtime.mountSkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider pose sync requires valid runtime refs.");
		}
		Slot obj = runtime.mountSkeletonAnimation.Skeleton.FindSlot(runtime.anchorSlotName) ?? throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider anchor slot missing at runtime. slot=" + runtime.anchorSlotName);
		Slot slot = runtime.mountSkeletonAnimation.Skeleton.FindSlot("chandou1");
		if (slot == null || slot.Bone == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider pivot slot missing at runtime. slot=chandou1");
		}
		Bone bone = obj.Bone;
		Bone bone2 = slot.Bone;
		Transform parent = runtime.root.parent;
		if (parent == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel collider root parent is missing.");
		}
		Vector3 position = new Vector3(bone.WorldX, bone.WorldY, 0f);
		Vector3 position2 = runtime.mountSkeletonAnimation.transform.TransformPoint(position);
		Vector2 vector = parent.InverseTransformPoint(position2);
		Vector2 shovelRotationCenterVisualLocal = ShovelRotationCenterVisualLocal;
		Vector2 anchorDefaultDirectionFromCenterLocal = vector - shovelRotationCenterVisualLocal;
		if (anchorDefaultDirectionFromCenterLocal.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel anchor local direction-from-center is invalid. slot=" + runtime.anchorSlotName);
		}
		if (!runtime.anchorBaselineCaptured)
		{
			runtime.anchorDefaultAngleDeg = bone.WorldRotationX;
			runtime.pivotDefaultAngleDeg = bone2.WorldRotationX;
			runtime.anchorDefaultLocalPos = vector;
			runtime.anchorDefaultDirectionFromCenterLocal = anchorDefaultDirectionFromCenterLocal;
			runtime.colliderDefaultOffsetFromAnchorLocal = ShovelDefaultColliderVisualLocalPosition - vector;
			runtime.anchorBaselineCaptured = true;
		}
		Vector2 vector2 = (runtime.colliderDefaultDirectionFromCenterLocal = ShovelDefaultColliderVisualLocalPosition - shovelRotationCenterVisualLocal);
		if (vector2.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Shovel default collider direction-from-center is invalid.");
		}
		float num = Mathf.DeltaAngle(runtime.pivotDefaultAngleDeg, bone2.WorldRotationX);
		Vector2 vector3 = RotateVector(runtime.colliderDefaultOffsetFromAnchorLocal, 0f - num);
		Vector2 lastComputedColliderLocalPos = vector + vector3;
		runtime.lastComputedDeltaAngleDeg = num;
		runtime.lastComputedColliderLocalPos = lastComputedColliderLocalPos;
		runtime.lastComputedCenterLocal = shovelRotationCenterVisualLocal;
		runtime.lastAnchorLocalPos = vector;
		runtime.root.localPosition = new Vector3(lastComputedColliderLocalPos.x, lastComputedColliderLocalPos.y, 0f);
		runtime.root.localRotation = Quaternion.identity;
	}

	private void TraceShovelSpineObservation(ShovelColliderRuntime runtime)
	{
		if (runtime == null || runtime.mountSkeletonAnimation == null)
		{
			return;
		}
		SkeletonAnimation mountSkeletonAnimation = runtime.mountSkeletonAnimation;
		if (mountSkeletonAnimation.Skeleton == null || mountSkeletonAnimation.AnimationState == null)
		{
			return;
		}
		float time = Time.time;
		if (time - runtime.lastObservationLogAt < 0.12f)
		{
			return;
		}
		runtime.lastObservationLogAt = time;
		TrackEntry current = mountSkeletonAnimation.AnimationState.GetCurrent(0);
		string text = ((current != null && current.Animation != null) ? current.Animation.Name : "<none>");
		float num = current?.TrackTime ?? 0f;
		Bone bone = mountSkeletonAnimation.Skeleton.FindSlot(runtime.anchorSlotName)?.Bone;
		Bone bone2 = mountSkeletonAnimation.Skeleton.FindSlot("chandou1")?.Bone;
		float num2 = bone?.WorldRotationX ?? 0f;
		float num3 = (runtime.anchorBaselineCaptured ? (num2 - runtime.anchorDefaultAngleDeg) : 0f);
		float target = bone2?.WorldRotationX ?? 0f;
		float num4 = (runtime.anchorBaselineCaptured ? Mathf.DeltaAngle(runtime.pivotDefaultAngleDeg, target) : 0f);
		Vector2 vector = ((runtime.root != null) ? ((Vector2)runtime.root.position) : Vector2.zero);
		float num5 = ((runtime.root != null) ? runtime.root.eulerAngles.z : 0f);
		ExposedList<Slot> slots = mountSkeletonAnimation.Skeleton.Slots;
		int num6 = slots?.Count ?? 0;
		string text2 = string.Empty;
		for (int i = 0; i < num6; i++)
		{
			Slot slot = slots.Items[i];
			if (slot != null && slot.Bone != null && slot.Data != null)
			{
				Bone bone3 = slot.Bone;
				string text3 = slot.Data.Name + "@(" + bone3.WorldX.ToString("F3") + "," + bone3.WorldY.ToString("F3") + ",a=" + bone3.WorldRotationX.ToString("F1") + ")";
				text2 = (string.IsNullOrEmpty(text2) ? text3 : (text2 + " | " + text3));
			}
		}
		string text4 = ((bone == null) ? "anchor=<missing>" : ("anchorPos=(" + bone.WorldX.ToString("F3") + "," + bone.WorldY.ToString("F3") + ") anchorAngle=" + num2.ToString("F1")));
		float magnitude = (runtime.lastComputedColliderLocalPos - runtime.lastComputedCenterLocal).magnitude;
		string[] obj = new string[49]
		{
			"[SummerRace][ShovelSpineObserve] slot=",
			(runtime.slot != null) ? runtime.slot.slotIndex.ToString() : "-1",
			" anim=",
			text,
			" t=",
			num.ToString("F3"),
			" anchor=",
			runtime.anchorSlotName,
			" ",
			text4,
			" anchorLocal=(",
			runtime.lastAnchorLocalPos.x.ToString("F4"),
			",",
			runtime.lastAnchorLocalPos.y.ToString("F4"),
			") anchorDefaultAngle=",
			runtime.anchorDefaultAngleDeg.ToString("F1"),
			" deltaAngle=",
			num3.ToString("F2"),
			" pivotAngle=",
			target.ToString("F1"),
			" pivotDeltaAngle=",
			num4.ToString("F2"),
			" computedDeltaAngle=",
			runtime.lastComputedDeltaAngleDeg.ToString("F2"),
			" centerLocal=(",
			runtime.lastComputedCenterLocal.x.ToString("F4"),
			",",
			runtime.lastComputedCenterLocal.y.ToString("F4"),
			") defaultColliderLocal=(",
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
			null,
			null,
			null,
			null
		};
		float x = ShovelDefaultColliderVisualLocalPosition.x;
		obj[29] = x.ToString("F4");
		obj[30] = ",";
		x = ShovelDefaultColliderVisualLocalPosition.y;
		obj[31] = x.ToString("F4");
		obj[32] = ") defaultAnchorToCollider=(";
		obj[33] = runtime.colliderDefaultOffsetFromAnchorLocal.x.ToString("F4");
		obj[34] = ",";
		obj[35] = runtime.colliderDefaultOffsetFromAnchorLocal.y.ToString("F4");
		obj[36] = ") solvedRadius=";
		obj[37] = magnitude.ToString("F4");
		obj[38] = " computedLocalPos=(";
		obj[39] = runtime.lastComputedColliderLocalPos.x.ToString("F4");
		obj[40] = ",";
		obj[41] = runtime.lastComputedColliderLocalPos.y.ToString("F4");
		obj[42] = ",0) colliderPos=";
		Vector2 vector2 = vector;
		obj[43] = vector2.ToString();
		obj[44] = " colliderAngle=";
		obj[45] = num5.ToString("F1");
		obj[46] = " slots={";
		obj[47] = text2;
		obj[48] = "}";
		TraceLog(string.Concat(obj));
	}

	private void TraceShovelMeleeProbe(WeaponRuntime slot, Vector2 sourcePoint, Vector2 direction, int hitCount)
	{
		int num = Mathf.Max(1, Mathf.Min(shovelHeadPolygonCount, shovelHeadPolygon.Length));
		Vector2 zero = Vector2.zero;
		for (int i = 0; i < num; i++)
		{
			zero += shovelHeadPolygon[i];
		}
		zero /= (float)num;
		string[] obj = new string[24]
		{
			"[SummerRace][ShovelHitTrace] slot=",
			slot.slotIndex.ToString(),
			" source=",
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
			null,
			null,
			null,
			null,
			null
		};
		Vector2 vector = sourcePoint;
		obj[3] = vector.ToString();
		obj[4] = " dir=";
		vector = direction;
		obj[5] = vector.ToString();
		obj[6] = " center=";
		vector = zero;
		obj[7] = vector.ToString();
		obj[8] = " hits=";
		obj[9] = hitCount.ToString();
		obj[10] = " points=";
		obj[11] = num.ToString();
		obj[12] = " p0=";
		vector = shovelHeadPolygon[0];
		obj[13] = vector.ToString();
		obj[14] = " p1=";
		obj[15] = ((num > 1) ? shovelHeadPolygon[1] : Vector2.zero).ToString();
		obj[16] = " p2=";
		obj[17] = ((num > 2) ? shovelHeadPolygon[2] : Vector2.zero).ToString();
		obj[18] = " p3=";
		obj[19] = ((num > 3) ? shovelHeadPolygon[3] : Vector2.zero).ToString();
		obj[20] = " p4=";
		obj[21] = ((num > 4) ? shovelHeadPolygon[4] : Vector2.zero).ToString();
		obj[22] = " p5=";
		obj[23] = ((num > 5) ? shovelHeadPolygon[5] : Vector2.zero).ToString();
		TraceLog(string.Concat(obj));
	}

	private void TraceDrillMeleeProbe(WeaponRuntime slot, Vector2 sourcePoint, Vector2 direction, Vector2 hitCenter, float radius, int hitCount)
	{
		ICombatStatusHost combatStatusHost = FindNearestHostForDrillTrace(hitCenter);
		Vector2 vector;
		if (combatStatusHost == null || combatStatusHost.CombatTransform == null)
		{
			string[] obj = new string[13]
			{
				"[SummerRace][DrillHitTrace] slot=",
				slot.slotIndex.ToString(),
				" source=",
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
			vector = sourcePoint;
			obj[3] = vector.ToString();
			obj[4] = " dir=";
			vector = direction;
			obj[5] = vector.ToString();
			obj[6] = " center=";
			vector = hitCenter;
			obj[7] = vector.ToString();
			obj[8] = " radius=";
			obj[9] = radius.ToString("F3");
			obj[10] = " hits=";
			obj[11] = hitCount.ToString();
			obj[12] = " nearest=<none>";
			TraceLog(string.Concat(obj));
			return;
		}
		Vector2 b = combatStatusHost.CombatTransform.position;
		float num = Vector2.Distance(hitCenter, b);
		float num2 = num;
		Collider2D collider2D = ResolveHostColliderForTrace(combatStatusHost, hitCenter);
		if (collider2D != null)
		{
			Vector2 b2 = collider2D.ClosestPoint(hitCenter);
			num2 = Vector2.Distance(hitCenter, b2);
		}
		string[] obj2 = new string[18]
		{
			"[SummerRace][DrillHitTrace] slot=",
			slot.slotIndex.ToString(),
			" source=",
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
		vector = sourcePoint;
		obj2[3] = vector.ToString();
		obj2[4] = " dir=";
		vector = direction;
		obj2[5] = vector.ToString();
		obj2[6] = " center=";
		vector = hitCenter;
		obj2[7] = vector.ToString();
		obj2[8] = " radius=";
		obj2[9] = radius.ToString("F3");
		obj2[10] = " hits=";
		obj2[11] = hitCount.ToString();
		obj2[12] = " nearest=";
		obj2[13] = combatStatusHost.CombatTransform.name;
		obj2[14] = " centerDist=";
		obj2[15] = num.ToString("F3");
		obj2[16] = " colliderDist=";
		obj2[17] = num2.ToString("F3");
		TraceLog(string.Concat(obj2));
	}

	private ICombatStatusHost FindNearestHostForDrillTrace(Vector2 center)
	{
		if (ownerContext == null)
		{
			return null;
		}
		ICombatStatusHost result = null;
		float num = float.MaxValue;
		if (ownerContext.CombatTeam == SummerRaceCombatTeam.Player)
		{
			for (int i = 0; i < SummerRaceEnemyRegistry.Count; i++)
			{
				SummerRaceEnemy summerRaceEnemy = SummerRaceEnemyRegistry.Get(i);
				if (!(summerRaceEnemy == null) && summerRaceEnemy.IsCombatAlive && !(summerRaceEnemy.CombatTransform == null))
				{
					float sqrMagnitude = ((Vector2)summerRaceEnemy.CombatTransform.position - center).sqrMagnitude;
					if (sqrMagnitude < num)
					{
						num = sqrMagnitude;
						result = summerRaceEnemy;
					}
				}
			}
			return result;
		}
		if (ownerContext.CombatTeam == SummerRaceCombatTeam.Enemy)
		{
			SummerRacePlayerController summerRacePlayerController = ((SummerRaceFightManager.Instance != null) ? SummerRaceFightManager.Instance.CurrentPlayer : null);
			if (summerRacePlayerController == null || !summerRacePlayerController.IsCombatAlive || summerRacePlayerController.CombatTransform == null)
			{
				return null;
			}
			return summerRacePlayerController;
		}
		return null;
	}

	private static Collider2D ResolveHostColliderForTrace(ICombatStatusHost host, Vector2 referencePoint)
	{
		if (host == null || host.CombatTransform == null)
		{
			return null;
		}
		Collider2D[] componentsInChildren = host.CombatTransform.GetComponentsInChildren<Collider2D>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return null;
		}
		Collider2D result = null;
		float num = float.MaxValue;
		foreach (Collider2D collider2D in componentsInChildren)
		{
			if (!(collider2D == null) && collider2D.enabled && collider2D.gameObject.activeInHierarchy)
			{
				float sqrMagnitude = (collider2D.ClosestPoint(referencePoint) - referencePoint).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					num = sqrMagnitude;
					result = collider2D;
				}
			}
		}
		return result;
	}

	private bool ApplyCollectedMeleeImpacts(WeaponImpactContext impactContext)
	{
		bool flag = false;
		int num = 0;
		int num2 = 0;
		float a = -1f;
		float a2 = -1f;
		meleeTargetTransforms.Clear();
		for (int i = 0; i < meleeTargets.Count; i++)
		{
			ICombatStatusHost combatStatusHost = meleeTargets[i];
			if (IsShovelWeapon(impactContext.Slot) && combatStatusHost != null && combatStatusHost.CombatRigidbody != null)
			{
				a = Mathf.Max(a, combatStatusHost.CombatRigidbody.velocity.magnitude);
				ApplyShovelContactImpulse(impactContext, combatStatusHost);
				num2++;
			}
			CombatExecutionResult combatExecutionResult = ApplyWeaponImpact(impactContext, combatStatusHost, meleeTargetTransforms);
			flag |= combatExecutionResult.Success;
			if (combatExecutionResult.Success)
			{
				if (IsShovelWeapon(impactContext.Slot))
				{
					a2 = Mathf.Max(a2, combatStatusHost.CombatRigidbody.velocity.magnitude);
				}
				num++;
			}
		}
		if (IsShovelWeapon(impactContext.Slot))
		{
			TraceLog("[SummerRace][ShovelImpact] slot=" + impactContext.Slot.slotIndex + " candidates=" + meleeTargets.Count + " applied=" + num + " physicsApplied=" + num2 + " dir=" + impactContext.HitDirection.ToString() + " targetSpeedBefore=" + a.ToString("F3") + " targetSpeedAfter=" + a2.ToString("F3"));
		}
		meleeTargets.Clear();
		meleeTargetTransforms.Clear();
		return flag;
	}

	private void ApplyShovelContactImpulse(WeaponImpactContext impactContext, ICombatStatusHost target)
	{
		if (impactContext.Slot == null || impactContext.Slot.def == null || target == null)
		{
			return;
		}
		Rigidbody2D combatRigidbody = target.CombatRigidbody;
		if (combatRigidbody == null)
		{
			return;
		}
		Vector2 vector = Vector2.zero;
		Vector2 vector2 = ((impactContext.HitDirection.sqrMagnitude > 0.0001f) ? impactContext.HitDirection.normalized : ResolveWeaponDirection(impactContext.Slot));
		Vector2 vector3 = combatRigidbody.worldCenterOfMass;
		Vector2 vector4 = vector3;
		Collider2D collider2D = ResolveHostColliderForTrace(target, vector4);
		RigidbodyType2D bodyType = combatRigidbody.bodyType;
		if (shovelColliderBySlot.TryGetValue(impactContext.Slot.slotIndex, out var value) && value != null && value.root != null)
		{
			vector4 = value.root.position;
			vector = value.lastSampleVelocity;
			Vector2 vector5 = ((value.collider != null) ? value.collider.ClosestPoint(combatRigidbody.worldCenterOfMass) : vector4);
			collider2D = ResolveHostColliderForTrace(target, vector5);
			vector3 = ((collider2D != null) ? collider2D.ClosestPoint(vector5) : vector5);
		}
		if (vector.sqrMagnitude <= 0.0001f && ownerContext != null && ownerContext.CombatSourceRigidbody != null)
		{
			vector = ownerContext.CombatSourceRigidbody.velocity;
		}
		if (vector.sqrMagnitude > 0.0001f)
		{
			vector2 = vector.normalized;
		}
		else if (collider2D != null)
		{
			Vector2 vector6 = (Vector2)collider2D.bounds.center - vector4;
			if (vector6.sqrMagnitude > 0.0001f)
			{
				vector2 = vector6.normalized;
			}
		}
		Vector2 rhs = combatRigidbody.worldCenterOfMass - vector4;
		if (rhs.sqrMagnitude > 0.0001f && Vector2.Dot(vector2, rhs) < 0f)
		{
			vector2 = -vector2;
		}
		Vector2 lhs = vector - combatRigidbody.velocity;
		float num = Mathf.Max(0f, Vector2.Dot(lhs, vector2));
		float num2 = Mathf.Max(0f, impactContext.Slot.def.Knockback);
		float num3 = Mathf.Max(0.9f, num2 * 0.35f) + Mathf.Clamp(num * 0.75f, 0f, 6f);
		float num4 = Mathf.Max(0f, combatRigidbody.mass * num3);
		if (num3 <= 0f)
		{
			return;
		}
		switch (bodyType)
		{
		case RigidbodyType2D.Dynamic:
			if (num4 <= 0f)
			{
				return;
			}
			combatRigidbody.AddForceAtPosition(vector2 * num4, vector3, ForceMode2D.Impulse);
			break;
		case RigidbodyType2D.Kinematic:
			combatRigidbody.velocity += vector2 * num3;
			break;
		default:
			return;
		}
		string[] obj = new string[20]
		{
			"[SummerRace][ShovelPhysics] slot=",
			impactContext.Slot.slotIndex.ToString(),
			" dir=",
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
		Vector2 vector7 = vector2;
		obj[3] = vector7.ToString();
		obj[4] = " baseKnockback=";
		obj[5] = num2.ToString("F2");
		obj[6] = " shovelVel=";
		vector7 = vector;
		obj[7] = vector7.ToString();
		obj[8] = " targetVel=";
		obj[9] = combatRigidbody.velocity.ToString();
		obj[10] = " approachSpeed=";
		obj[11] = num.ToString("F2");
		obj[12] = " desiredDeltaV=";
		obj[13] = num3.ToString("F2");
		obj[14] = " impulse=";
		obj[15] = num4.ToString("F2");
		obj[16] = " bodyType=";
		obj[17] = bodyType.ToString();
		obj[18] = " contact=";
		vector7 = vector3;
		obj[19] = vector7.ToString();
		TraceLog(string.Concat(obj));
	}

	private void ApplyRocketArcadeImpactImpulse(WeaponImpactContext impactContext, ICombatStatusHost target)
	{
		if (!IsRocketWeapon(impactContext.Slot) || target == null)
		{
			return;
		}
		Rigidbody2D combatRigidbody = target.CombatRigidbody;
		if (combatRigidbody == null)
		{
			return;
		}
		Vector2 vector = ((impactContext.HitDirection.sqrMagnitude > 0.0001f) ? impactContext.HitDirection.normalized : ResolveWeaponDirection(impactContext.Slot));
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return;
		}
		vector = (vector + Vector2.up * 0.12f).normalized;
		Vector2 sourcePoint = impactContext.SourcePoint;
		Collider2D collider2D = ResolveHostColliderForTrace(target, sourcePoint);
		Vector2 vector2 = ((collider2D != null) ? collider2D.ClosestPoint(sourcePoint) : combatRigidbody.worldCenterOfMass);
		Vector2 vector3 = ((ownerContext != null && ownerContext.CombatSourceRigidbody != null) ? ownerContext.CombatSourceRigidbody.velocity : Vector2.zero);
		Vector2 lhs = vector3 - combatRigidbody.velocity;
		float num = Mathf.Max(0f, Vector2.Dot(lhs, vector));
		float num2 = Mathf.Max(0f, impactContext.Slot.def.Knockback);
		float num3 = Mathf.Max(2f, num2 * 0.55f) + Mathf.Clamp(num * 0.25f, 0f, 1.2f);
		if (num3 <= 0f)
		{
			return;
		}
		RigidbodyType2D bodyType = combatRigidbody.bodyType;
		switch (bodyType)
		{
		case RigidbodyType2D.Dynamic:
		{
			float num4 = Mathf.Max(0f, combatRigidbody.mass * num3);
			if (num4 <= 0f)
			{
				return;
			}
			combatRigidbody.AddForceAtPosition(vector * num4, vector2, ForceMode2D.Impulse);
			break;
		}
		case RigidbodyType2D.Kinematic:
			combatRigidbody.velocity += vector * num3;
			break;
		default:
			return;
		}
		string[] obj = new string[18]
		{
			"[SummerRace][RocketPhysics] slot=",
			impactContext.Slot.slotIndex.ToString(),
			" dir=",
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
		Vector2 vector4 = vector;
		obj[3] = vector4.ToString();
		obj[4] = " baseKnockback=";
		obj[5] = num2.ToString("F2");
		obj[6] = " sourceVel=";
		vector4 = vector3;
		obj[7] = vector4.ToString();
		obj[8] = " targetVel=";
		obj[9] = combatRigidbody.velocity.ToString();
		obj[10] = " approachSpeed=";
		obj[11] = num.ToString("F2");
		obj[12] = " desiredDeltaV=";
		obj[13] = num3.ToString("F2");
		obj[14] = " bodyType=";
		obj[15] = bodyType.ToString();
		obj[16] = " contact=";
		vector4 = vector2;
		obj[17] = vector4.ToString();
		TraceLog(string.Concat(obj));
	}

	private bool TrySpawnProjectiles(WeaponRuntime slot, Vector2 muzzle, Vector2 dir, float spread)
	{
		if (slot == null || slot.def == null)
		{
			return false;
		}
		WeaponModuleDefinition def = slot.def;
		projectileDirectionBuffer.Clear();
		ResolveProjectileDirections(dir, Mathf.Max(1, def.ProjectileCount), Mathf.Max(0f, spread), projectileDirectionBuffer);
		bool flag = false;
		for (int i = 0; i < projectileDirectionBuffer.Count; i++)
		{
			flag |= TrySpawnSingleProjectile(slot, muzzle, projectileDirectionBuffer[i]);
		}
		return flag;
	}

	private bool TrySpawnSingleProjectile(WeaponRuntime slot, Vector2 muzzle, Vector2 dir)
	{
		if (slot == null || slot.def == null)
		{
			return false;
		}
		WeaponModuleDefinition def = slot.def;
		if (projectilePrefab == null)
		{
			if (!warnedMissingProjectilePrefab)
			{
				warnedMissingProjectilePrefab = true;
				SummerRaceRuntimeLog.Error("[VehicleWeaponSystem] Missing projectile prefab on " + base.name + ", fire request rejected.");
			}
			return false;
		}
		bool flag = def.WeaponType == SummerRaceWeaponTypeConfig.Boomerang && def.BoomerangFlight;
		bool flag2 = IsMountedRocketWeapon(def);
		if (flag && IsBoomerangProjectileInFlight(slot.slotIndex))
		{
			return false;
		}
		Vector2 vector = muzzle;
		bool flag3 = false;
		VehicleSimpleProjectile vehicleSimpleProjectile;
		if (flag2)
		{
			if (!mountedRocketBySlot.TryGetValue(slot.slotIndex, out var value) || value == null || value.projectile == null || !value.mounted)
			{
				return false;
			}
			vehicleSimpleProjectile = value.projectile;
			vector = vehicleSimpleProjectile.transform.position;
			vehicleSimpleProjectile.transform.SetParent(EnsureProjectilePoolRoot(), worldPositionStays: true);
			value.mounted = false;
			value.pendingRespawn = false;
			flag3 = false;
		}
		else
		{
			vehicleSimpleProjectile = (flag ? AcquirePersistentBoomerangProjectile(slot) : AcquireProjectile());
			flag3 = !flag;
		}
		if (vehicleSimpleProjectile == null)
		{
			return false;
		}
		TraceMachineGunProjectileSpawn(slot, "after_acquire", vehicleSimpleProjectile);
		Transform transform = vehicleSimpleProjectile.transform;
		if (!flag2)
		{
			transform.SetParent(EnsureProjectilePoolRoot(), worldPositionStays: false);
			transform.position = vector;
			TraceMachineGunProjectileSpawn(slot, "after_set_spawn_position", vehicleSimpleProjectile);
		}
		else
		{
			transform.position = vector;
		}
		transform.rotation = Quaternion.identity;
		TraceMachineGunProjectileSpawn(slot, "after_set_spawn_rotation", vehicleSimpleProjectile);
		float lifetime = Mathf.Max(0.05f, def.ProjectileLifetime);
		Vector2 vector2 = ((dir.sqrMagnitude > 0.0001f) ? dir.normalized : ResolveWeaponDirection(slot));
		SummerRacePresentationDeliveryKind deliveryKind = SummerRaceCombatPresentationRouter.ResolveWeaponDeliveryKind(def);
		Transform transform2 = ResolvePresentationSourceTransform();
		projectileImpactContexts[vehicleSimpleProjectile] = new ProjectileImpactContext(slot, vector, vector2, deliveryKind, transform2);
		vehicleSimpleProjectile.Init(vector2, def.ProjectileSpeedValue, flag, flag3, slot.slotIndex, ownerContext, lifetime, hitMask, HandleProjectilePhase, HandleProjectileImpact, flag ? new Action<VehicleSimpleProjectile>(HandlePersistentBoomerangRecycle) : (flag2 ? new Action<VehicleSimpleProjectile>(HandleMountedRocketRecycle) : new Action<VehicleSimpleProjectile>(ReleaseProjectile)));
		vehicleSimpleProjectile.ConfigurePresentation(transform2, slot.slotIndex, slot.mount, def, (ownerContext != null) ? ownerContext.CombatTeam : SummerRaceCombatTeam.None);
		TraceMachineGunProjectileSpawn(slot, "after_init_and_config", vehicleSimpleProjectile);
		string[] obj = new string[28]
		{
			"[SummerRace][WeaponSpawn] weapon=",
			def.name,
			" slot=",
			slot.slotIndex.ToString(),
			" muzzle=",
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
			null,
			null,
			null,
			null,
			null,
			null,
			null
		};
		Vector2 vector3 = vector;
		obj[5] = vector3.ToString();
		obj[6] = " dir=";
		vector3 = vector2;
		obj[7] = vector3.ToString();
		obj[8] = " speed=";
		obj[9] = def.ProjectileSpeedValue.ToString();
		obj[10] = " life=";
		obj[11] = lifetime.ToString();
		obj[12] = " boomerang=";
		obj[13] = flag.ToString();
		obj[14] = " mountedRocket=";
		obj[15] = flag2.ToString();
		obj[16] = " projectileSize=";
		obj[17] = def.ProjectileVisualSize.ToString();
		obj[18] = " colliderRadius=";
		obj[19] = def.ProjectileColliderRadius.ToString();
		obj[20] = " spinePath=";
		obj[21] = def.ProjectileSpineSkeletonDataPath ?? string.Empty;
		obj[22] = " spineScale=";
		obj[23] = def.ProjectileSpineScale.ToString();
		obj[24] = " spineOffset=";
		obj[25] = def.ProjectileSpineLocalOffset.ToString();
		obj[26] = " spineAngle=";
		obj[27] = def.ProjectileSpineLocalAngle.ToString();
		TraceLog(string.Concat(obj));
		if (flag)
		{
			boomerangProjectilesBySlot[slot.slotIndex] = vehicleSimpleProjectile;
		}
		vehicleSimpleProjectile.gameObject.SetActive(value: true);
		TraceMachineGunProjectileSpawn(slot, "after_set_active_true", vehicleSimpleProjectile);
		EmitProjectileTravelPhaseStart(slot, vector, vector2, deliveryKind, transform2);
		return true;
	}

	private CombatExecutionResult HandleProjectileImpact(VehicleSimpleProjectile projectile, ICombatStatusHost target, Vector2 hitDirection)
	{
		if (projectile == null || target == null)
		{
			return CombatExecutionResult.Failed("Projectile impact target is missing.");
		}
		if (!projectileImpactContexts.TryGetValue(projectile, out var value))
		{
			return CombatExecutionResult.Failed("Projectile impact context is missing.");
		}
		projectileImpactedSet.Add(projectile);
		Vector2 hitDirection2 = ((hitDirection.sqrMagnitude > 0.0001f) ? hitDirection.normalized : value.FireDirection);
		if (!TryCreateWeaponImpactContext(value.Slot, (value.Slot != null) ? value.Slot.projectileImpactPayload : null, value.SourcePoint, hitDirection2, 1, out var impactContext))
		{
			return CombatExecutionResult.Failed("Projectile impact payload is missing.");
		}
		CombatExecutionResult result = ApplyWeaponImpact(impactContext, target, null);
		if (!result.Success)
		{
			return result;
		}
		if (SummerRaceCombatPresentationRouter.TryResolveWeaponBridgePhaseFromProjectile(value.DeliveryKind, SummerRacePresentationPhase.Hit, out var _))
		{
			_ = 8;
		}
		return result;
	}

	private CombatExecutionResult ApplyWeaponImpact(WeaponImpactContext impactContext, ICombatStatusHost target, HashSet<Transform> emittedTargets)
	{
		if (target == null || impactContext.Payload == null || ownerContext == null)
		{
			return CombatExecutionResult.Failed("Weapon impact context is incomplete.");
		}
		CombatExecutionResult result = SummerRaceCombatEffectExecutor.Shared.ExecuteImpact(target, impactContext.Payload, impactContext.HitDirection, CreateWeaponImpactSourceContext(impactContext));
		if (!result.Success)
		{
			return result;
		}
		ApplyRocketArcadeImpactImpulse(impactContext, target);
		Transform combatTransform = target.CombatTransform;
		if (emittedTargets != null && combatTransform != null && !emittedTargets.Add(combatTransform))
		{
			return result;
		}
		EmitWeaponImpact(impactContext.Slot, impactContext.SourcePoint, impactContext.HitDirection, target, impactContext.TargetCount);
		return result;
	}

	private CombatExecutionResult ApplyWeaponImpactWithoutPresentation(WeaponImpactContext impactContext, ICombatStatusHost target)
	{
		if (target == null || impactContext.Payload == null || ownerContext == null)
		{
			return CombatExecutionResult.Failed("Weapon impact context is incomplete.");
		}
		return SummerRaceCombatEffectExecutor.Shared.ExecuteImpact(target, impactContext.Payload, impactContext.HitDirection, CreateWeaponImpactSourceContext(impactContext));
	}

	private ICombatSourceContext CreateWeaponImpactSourceContext(WeaponImpactContext impactContext)
	{
		int slotIndex = ((impactContext.Slot != null) ? impactContext.Slot.slotIndex : (-1));
		return new WeaponImpactSourceContext(ownerContext, slotIndex);
	}

	private bool TryCreateWeaponImpactContext(WeaponRuntime slot, CombatImpactPayload payload, Vector2 sourcePoint, Vector2 hitDirection, int targetCount, out WeaponImpactContext impactContext)
	{
		impactContext = default(WeaponImpactContext);
		if (slot == null || payload == null)
		{
			return false;
		}
		Vector2 hitDirection2 = ((hitDirection.sqrMagnitude > 0.0001f) ? hitDirection.normalized : ResolveWeaponDirection(slot));
		impactContext = new WeaponImpactContext(slot, payload, sourcePoint, hitDirection2, targetCount);
		return true;
	}

	private void HandleProjectilePhase(VehicleSimpleProjectile projectile, SummerRacePresentationPhase phase)
	{
		if (!(projectile == null) && phase == SummerRacePresentationPhase.ReturnStarted && projectileImpactContexts.TryGetValue(projectile, out var value) && SummerRaceCombatPresentationRouter.TryResolveWeaponBridgePhaseFromProjectile(value.DeliveryKind, phase, out var weaponPhase) && weaponPhase == SummerRacePresentationPhase.ReturnStarted)
		{
			Vector2 vector = projectile.transform.position;
			Vector2 vector2 = value.SourcePoint;
			if (value.Slot != null && value.Slot.mount != null)
			{
				vector2 = value.Slot.mount.transform.position;
			}
			Vector2 direction = vector2 - vector;
			if (direction.sqrMagnitude <= 0.0001f)
			{
				direction = -value.FireDirection;
			}
			string[] obj = new string[8]
			{
				"[SummerRace][WeaponSpawn] boomerang_return_phase slot=",
				((value.Slot != null) ? value.Slot.slotIndex : (-1)).ToString(),
				" projectilePos=",
				null,
				null,
				null,
				null,
				null
			};
			Vector2 vector3 = vector;
			obj[3] = vector3.ToString();
			obj[4] = " returnTarget=";
			vector3 = vector2;
			obj[5] = vector3.ToString();
			obj[6] = " distance=";
			obj[7] = Vector2.Distance(vector, vector2).ToString("F3");
			TraceLog(string.Concat(obj));
			EmitWeaponEvent(value.Slot, weaponPhase, vector, direction, string.Empty, value.SourcePoint, vector2, null, Mathf.Max(0f, Vector2.Distance(vector, vector2)), 0);
		}
	}

	private void EmitProjectileTravelPhaseStart(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection, SummerRacePresentationDeliveryKind deliveryKind, Transform presentationSourceTransform)
	{
		if (SummerRaceCombatPresentationRouter.TryResolveTransientPhasePolicy(deliveryKind, out var policy) && policy.HasStartPhase)
		{
			EmitWeaponEvent(slot, SummerRacePresentationPhase.Spawned, sourcePoint, fireDirection, string.Empty, sourcePoint, ResolveNominalWeaponTargetPoint(slot, sourcePoint, fireDirection), null, ResolveWeaponReach(slot), 0, presentationSourceTransform);
		}
	}

	private void EmitProjectileTravelPhaseEnd(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection, SummerRacePresentationDeliveryKind deliveryKind, Vector2 endPoint, bool impacted, Transform presentationSourceTransform)
	{
		if (SummerRaceCombatPresentationRouter.TryResolveTransientPhasePolicy(deliveryKind, out var policy))
		{
			EmitWeaponEvent(slot, policy.EndPhase, endPoint, fireDirection, string.Empty, sourcePoint, endPoint, null, Mathf.Max(0f, Vector2.Distance(sourcePoint, endPoint)), impacted ? 1 : 0, presentationSourceTransform);
		}
	}

	private void EmitWeaponRejected(WeaponRuntime slot, string rejectReason)
	{
		Vector2 vector = ResolveWeaponSourcePoint(slot);
		EmitWeaponEvent(slot, SummerRacePresentationPhase.Rejected, vector, ResolveWeaponDirection(slot), rejectReason, vector, ResolveNominalWeaponTargetPoint(slot, vector, ResolveWeaponDirection(slot)), null, ResolveWeaponReach(slot), 0);
	}

	private void EmitWeaponFired(WeaponRuntime slot, Vector2 muzzle, Vector2 fireDirection)
	{
		EmitWeaponEvent(slot, SummerRacePresentationPhase.Fired, muzzle, fireDirection, string.Empty, muzzle, ResolveNominalWeaponTargetPoint(slot, muzzle, fireDirection), null, ResolveWeaponReach(slot), 0);
	}

	private void EmitWeaponActivated(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection)
	{
		EmitWeaponEvent(slot, SummerRacePresentationPhase.Activated, sourcePoint, fireDirection, string.Empty, sourcePoint, ResolveNominalWeaponTargetPoint(slot, sourcePoint, fireDirection), null, ResolveWeaponReach(slot), 0);
	}

	private void EmitWeaponActiveExpired(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection)
	{
		EmitWeaponEvent(slot, SummerRacePresentationPhase.ActiveExpired, sourcePoint, fireDirection, string.Empty, sourcePoint, ResolveNominalWeaponTargetPoint(slot, sourcePoint, fireDirection), null, ResolveWeaponReach(slot), 0);
	}

	private void TickWeaponOverloadVisuals()
	{
		if (weaponSlots.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && weaponRuntime.state != null)
			{
				SyncRuntimeStateFromOwner(weaponRuntime);
				bool flag = Time.time < weaponRuntime.state.OverloadUntil;
				if (flag != weaponRuntime.overloadVisualActive)
				{
					weaponRuntime.overloadVisualActive = flag;
					EmitWeaponOverloadEvent(weaponRuntime, flag ? SummerRacePresentationPhase.Activated : SummerRacePresentationPhase.ActiveExpired);
				}
			}
		}
	}

	private void ClearWeaponOverloadVisuals()
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && weaponRuntime.overloadVisualActive)
			{
				weaponRuntime.overloadVisualActive = false;
				EmitWeaponOverloadEvent(weaponRuntime, SummerRacePresentationPhase.ActiveExpired);
			}
		}
	}

	private void EmitWeaponOverloadEvent(WeaponRuntime slot, SummerRacePresentationPhase phase)
	{
		if (slot != null)
		{
			Transform transform = ResolvePresentationSourceTransform();
			if (!(transform == null))
			{
				Vector2 position = ResolveWeaponSourcePoint(slot);
				Vector2 direction = ResolveWeaponDirection(slot);
				SummerRaceCombatPresentationRouter.PublishWeaponOverload(transform, new SummerRaceWeaponOverloadPresentationEvent(phase, slot.slotIndex, position, direction, transform, slot.mount, slot.def));
			}
		}
	}

	private void EmitWeaponEvent(WeaponRuntime slot, SummerRacePresentationPhase phase, Vector2 position, Vector2 direction, string rejectReason, Vector2 sourcePoint, Vector2 targetPoint, Transform targetTransform, float reachDistance, int targetCount, Transform sourceTransformOverride = null)
	{
		Transform transform = ((sourceTransformOverride != null) ? sourceTransformOverride : ResolvePresentationSourceTransform());
		if (!(transform == null))
		{
			WeaponModuleDefinition weaponDefinition = slot?.def;
			SummerRaceCombatPresentationRouter.PublishWeapon(transform, new SummerRaceWeaponPresentationEvent(phase, SummerRaceCombatPresentationRouter.ResolveWeaponDeliveryKind(weaponDefinition), SummerRaceCombatPresentationRouter.ResolveWeaponKind(weaponDefinition), slot?.slotIndex ?? (-1), position, (direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right, rejectReason, sourcePoint, targetPoint, targetTransform, reachDistance, targetCount, transform, slot?.mount, weaponDefinition));
		}
	}

	private void EmitWeaponImpact(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection, ICombatStatusHost target, int targetCount)
	{
		Transform transform = target?.CombatTransform;
		Vector2 vector = ((transform != null) ? ((Vector2)transform.position) : ResolveNominalWeaponTargetPoint(slot, sourcePoint, fireDirection));
		EmitWeaponEvent(slot, SummerRacePresentationPhase.Impact, vector, fireDirection, string.Empty, sourcePoint, vector, transform, Mathf.Max(0f, Vector2.Distance(sourcePoint, vector)), targetCount);
	}

	private Transform ResolvePresentationSourceTransform()
	{
		if (ownerContext != null)
		{
			if (ownerContext is UnityEngine.Object obj && obj == null)
			{
				return base.transform;
			}
			Transform combatSourceTransform = ownerContext.CombatSourceTransform;
			if (combatSourceTransform != null)
			{
				return combatSourceTransform;
			}
		}
		return base.transform;
	}

	private Vector2 ResolveWeaponSourcePoint(WeaponRuntime slot)
	{
		if (slot != null && slot.mount != null)
		{
			return slot.mount.transform.position;
		}
		if (!(ResolvePresentationSourceTransform() != null))
		{
			return Vector2.zero;
		}
		return ResolvePresentationSourceTransform().position;
	}

	private Vector2 ResolveWeaponDirection(WeaponRuntime slot)
	{
		if (slot == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] ResolveWeaponDirection requires a valid slot.");
		}
		if (!TryResolveFireDirection(slot, out var direction))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Failed to resolve authored fire direction. slot=" + slot.slotIndex);
		}
		return direction;
	}

	private Vector2 ResolveNominalWeaponTargetPoint(WeaponRuntime slot, Vector2 sourcePoint, Vector2 fireDirection)
	{
		return sourcePoint + ((fireDirection.sqrMagnitude > 0.0001f) ? fireDirection.normalized : Vector2.right) * ResolveWeaponReach(slot);
	}

	private float ResolveWeaponReach(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null)
		{
			return 0f;
		}
		if (slot.def.IsMelee)
		{
			return Mathf.Max(slot.def.MeleeRange, slot.def.MeleeRadius);
		}
		return Mathf.Max(Mathf.Max(0f, slot.def.ProjectileSpeedValue) * Mathf.Max(0.05f, slot.def.ProjectileLifetime), slot.def.Range);
	}

	private static bool ShouldUseMountedProjectilePreview(WeaponRuntime slot)
	{
		if (slot != null && slot.def != null && slot.mount != null && slot.def.EnableMountedProjectilePreview && !IsMountedRocketWeapon(slot.def))
		{
			return !slot.def.IsMelee;
		}
		return false;
	}

	private static bool IsMountedRocketWeapon(WeaponModuleDefinition def)
	{
		if (def != null && def.EnableMountedProjectilePreview && def.WeaponType == SummerRaceWeaponTypeConfig.RocketLauncher)
		{
			return !def.IsMelee;
		}
		return false;
	}

	private void EnsureMountedProjectilePreviews()
	{
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (ShouldUseMountedProjectilePreview(weaponRuntime))
			{
				if (mountedProjectilePreviewBySlot.TryGetValue(weaponRuntime.slotIndex, out var value) && value != null && value.root != null)
				{
					ApplyMountedProjectilePreviewTransform(value);
					SetMountedProjectilePreviewVisible(value, visible: true);
					continue;
				}
				MountedProjectilePreviewRuntime mountedProjectilePreviewRuntime = CreateMountedProjectilePreview(weaponRuntime);
				mountedProjectilePreviewBySlot[weaponRuntime.slotIndex] = mountedProjectilePreviewRuntime;
				ApplyMountedProjectilePreviewTransform(mountedProjectilePreviewRuntime);
				SetMountedProjectilePreviewVisible(mountedProjectilePreviewRuntime, visible: true);
			}
		}
	}

	private MountedProjectilePreviewRuntime CreateMountedProjectilePreview(WeaponRuntime slot)
	{
		if (!ShouldUseMountedProjectilePreview(slot))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview requires a valid ranged slot.");
		}
		WeaponModuleDefinition def = slot.def;
		string projectileSpineSkeletonDataPath = def.ProjectileSpineSkeletonDataPath;
		if (string.IsNullOrWhiteSpace(projectileSpineSkeletonDataPath))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview requires projectile spine path. slot=" + slot.slotIndex);
		}
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow(projectileSpineSkeletonDataPath, "weapon=" + def.name + " field=projectileSpineSkeletonDataPath");
		GameObject obj = new GameObject("MountedProjectilePreview_" + slot.slotIndex);
		Transform transform = obj.transform;
		GameObject visualInstance = slot.mount.VisualInstance;
		Transform parent = ((visualInstance != null) ? visualInstance.transform : slot.mount.transform);
		transform.SetParent(parent, worldPositionStays: false);
		SkeletonAnimation skeletonAnimation = obj.AddComponent<SkeletonAnimation>();
		skeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		skeletonAnimation.Initialize(overwrite: true);
		MeshRenderer component = skeletonAnimation.GetComponent<MeshRenderer>();
		if (component != null)
		{
			component.sortingOrder = ResolveMountedObjectSortingOrder(slot);
		}
		SkeletonAnimation mountSkeletonAnimation = ResolveMountSkeletonAnimation(slot);
		string text = ResolveMountedProjectileAnchorSlotName(def);
		if (!string.IsNullOrWhiteSpace(text))
		{
			ValidateMountedProjectileAnchorSlotOrThrow(mountSkeletonAnimation, text, def.name);
		}
		PlayMountedProjectilePreviewAnimationOrThrow(skeletonAnimation, def);
		return new MountedProjectilePreviewRuntime
		{
			slot = slot,
			root = transform,
			skeletonAnimation = skeletonAnimation,
			mountSkeletonAnimation = mountSkeletonAnimation,
			anchorSlotName = text,
			respawnAt = 0f,
			visible = true,
			pendingRespawn = false
		};
	}

	private static int ResolveMountVisualSortingOrder(WeaponRuntime slot)
	{
		if (slot != null && slot.mount != null && slot.mount.VisualInstance != null)
		{
			Renderer[] componentsInChildren = slot.mount.VisualInstance.GetComponentsInChildren<Renderer>(includeInactive: true);
			int num = int.MaxValue;
			foreach (Renderer renderer in componentsInChildren)
			{
				if (!(renderer == null))
				{
					num = Mathf.Min(num, renderer.sortingOrder);
				}
			}
			if (num != int.MaxValue)
			{
				return num;
			}
		}
		return 37;
	}

	private int ResolveWeaponEquipSortingOrderOrFallback()
	{
		if (TryResolveBodySortingOrder(out var bodySortingOrder))
		{
			return bodySortingOrder + 3;
		}
		return 37;
	}

	private static int ResolveMountedObjectSortingOrder(WeaponRuntime slot)
	{
		return ResolveMountVisualSortingOrder(slot) - 1;
	}

	private bool TryResolveBodySortingOrder(out int bodySortingOrder)
	{
		Transform transform = base.transform.Find("BodyVisual");
		if (transform != null)
		{
			Renderer componentInChildren = transform.GetComponentInChildren<Renderer>(includeInactive: true);
			if (componentInChildren != null)
			{
				bodySortingOrder = componentInChildren.sortingOrder;
				return true;
			}
		}
		bodySortingOrder = 0;
		return false;
	}

	private static void ApplyMountVisualSortingOrder(MountPoint mountPoint, int targetMinSortingOrder)
	{
		if (mountPoint == null || mountPoint.VisualInstance == null)
		{
			return;
		}
		Renderer[] componentsInChildren = mountPoint.VisualInstance.GetComponentsInChildren<Renderer>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return;
		}
		int num = int.MaxValue;
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer == null))
			{
				num = Mathf.Min(num, renderer.sortingOrder);
			}
		}
		if (num == int.MaxValue)
		{
			return;
		}
		int num2 = targetMinSortingOrder - num;
		foreach (Renderer renderer2 in componentsInChildren)
		{
			if (!(renderer2 == null))
			{
				renderer2.sortingOrder += num2;
			}
		}
	}

	private static SkeletonAnimation ResolveMountSkeletonAnimation(WeaponRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview requires mount visual instance.");
		}
		SkeletonAnimation componentInChildren = slot.mount.VisualInstance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		if (componentInChildren == null || componentInChildren.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview requires emitter SkeletonAnimation. weapon=" + ((slot.def != null) ? slot.def.name : "<null>"));
		}
		return componentInChildren;
	}

	private static string ResolveMountedProjectileAnchorSlotName(WeaponModuleDefinition def)
	{
		if (def == null)
		{
			return string.Empty;
		}
		string mountedProjectileAnchorSlotName = def.MountedProjectileAnchorSlotName;
		if (!string.IsNullOrWhiteSpace(mountedProjectileAnchorSlotName))
		{
			return mountedProjectileAnchorSlotName.Trim();
		}
		return string.Empty;
	}

	private static void ValidateMountedProjectileAnchorSlotOrThrow(SkeletonAnimation mountSkeletonAnimation, string anchorSlotName, string weaponName)
	{
		if (mountSkeletonAnimation == null || mountSkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile anchor validation requires emitter skeleton. weapon=" + weaponName);
		}
		if (mountSkeletonAnimation.Skeleton.FindSlot(anchorSlotName) == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile anchor slot not found. weapon=" + weaponName + " slot=" + anchorSlotName);
		}
	}

	private static void PlayMountedProjectilePreviewAnimationOrThrow(SkeletonAnimation animation, WeaponModuleDefinition def)
	{
		if (animation == null || def == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile loop animation requires valid refs.");
		}
		if (animation.AnimationState == null || animation.Skeleton == null || animation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview missing spine state. weapon=" + def.name);
		}
		string mountedProjectileAnimName = def.MountedProjectileAnimName;
		if (string.IsNullOrWhiteSpace(mountedProjectileAnimName))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview animation is empty. weapon=" + def.name);
		}
		if (string.Equals(mountedProjectileAnimName, "none", StringComparison.OrdinalIgnoreCase))
		{
			animation.AnimationState.ClearTracks();
			animation.Skeleton.SetToSetupPose();
			animation.AnimationState.Apply(animation.Skeleton);
			return;
		}
		Spine.Animation animation2 = animation.Skeleton.Data.FindAnimation(mountedProjectileAnimName);
		if (animation2 == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview missing animation clip '" + mountedProjectileAnimName + "'. weapon=" + def.name);
		}
		animation.AnimationState.SetAnimation(0, animation2.Name, loop: true);
	}

	private static void ApplyMountedProjectilePreviewTransform(MountedProjectilePreviewRuntime preview)
	{
		if (preview == null || preview.slot == null || preview.slot.def == null || preview.root == null || preview.skeletonAnimation == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview transform requires valid runtime refs.");
		}
		WeaponModuleDefinition def = preview.slot.def;
		if (!string.IsNullOrWhiteSpace(preview.anchorSlotName))
		{
			ApplyMountedProjectileAnchorTransformOrThrow(preview);
		}
		else
		{
			preview.root.localPosition = new Vector3(def.MountedProjectileLocalOffset.x, def.MountedProjectileLocalOffset.y, 0f);
			preview.root.localRotation = ResolveMountedProjectilePreviewLocalRotation(def.ProjectileSpineLocalAngle);
		}
		Vector2 vector = ResolveMountedProjectilePreviewBoundsOrThrow(preview.skeletonAnimation, def.name);
		float num = Mathf.Max(0.01f, def.ProjectileSpineScale);
		float x = Mathf.Max(0.01f, Mathf.Max(0.01f, def.ProjectileVisualSize.x) / vector.x * num);
		float y = Mathf.Max(0.01f, Mathf.Max(0.01f, def.ProjectileVisualSize.y) / vector.y * num);
		preview.root.localScale = new Vector3(x, y, 1f);
	}

	private static void ApplyMountedProjectileAnchorTransformOrThrow(MountedProjectilePreviewRuntime preview)
	{
		if (preview.mountSkeletonAnimation == null || preview.mountSkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile anchor requires emitter skeleton. weapon=" + ((preview.slot != null && preview.slot.def != null) ? preview.slot.def.name : "<null>"));
		}
		string anchorSlotName = preview.anchorSlotName;
		Bone bone = (preview.mountSkeletonAnimation.Skeleton.FindSlot(anchorSlotName) ?? throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile anchor slot missing at runtime. weapon=" + ((preview.slot != null && preview.slot.def != null) ? preview.slot.def.name : "<null>") + " slot=" + anchorSlotName)).Bone;
		Transform parent = preview.root.parent;
		if (parent == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview root parent is missing.");
		}
		Vector3 position = new Vector3(bone.WorldX, bone.WorldY, 0f);
		Vector3 position2 = new Vector3(bone.WorldX + bone.A, bone.WorldY + bone.C, 0f);
		Vector3 vector = preview.mountSkeletonAnimation.transform.TransformPoint(position);
		Vector3 vector2 = preview.mountSkeletonAnimation.transform.TransformPoint(position2) - vector;
		if (vector2.sqrMagnitude <= 1E-06f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile anchor axis is invalid. weapon=" + ((preview.slot != null && preview.slot.def != null) ? preview.slot.def.name : "<null>") + " slot=" + anchorSlotName);
		}
		Vector3 vector3 = parent.InverseTransformDirection(vector2.normalized);
		Vector2 vector4 = new Vector2(vector3.x, vector3.y);
		if (vector4.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile anchor local direction is invalid. weapon=" + ((preview.slot != null && preview.slot.def != null) ? preview.slot.def.name : "<null>") + " slot=" + anchorSlotName);
		}
		float z = Mathf.Atan2(vector4.y, vector4.x) * 57.29578f;
		preview.root.localPosition = parent.InverseTransformPoint(vector);
		preview.root.localRotation = Quaternion.Euler(0f, 0f, z);
	}

	private static void ApplyMountedProjectileAnchorTransformOrThrow(SkeletonAnimation mountSkeletonAnimation, string anchorSlotName, Transform targetRoot, string weaponName)
	{
		if (mountSkeletonAnimation == null || mountSkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket anchor requires emitter skeleton. weapon=" + weaponName);
		}
		if (targetRoot == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket anchor target root is null.");
		}
		Bone bone = (mountSkeletonAnimation.Skeleton.FindSlot(anchorSlotName) ?? throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket anchor slot missing at runtime. weapon=" + weaponName + " slot=" + anchorSlotName)).Bone;
		Transform parent = targetRoot.parent;
		if (parent == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket anchor target parent is missing.");
		}
		Vector3 position = new Vector3(bone.WorldX, bone.WorldY, 0f);
		Vector3 position2 = new Vector3(bone.WorldX + bone.A, bone.WorldY + bone.C, 0f);
		Vector3 vector = mountSkeletonAnimation.transform.TransformPoint(position);
		Vector3 vector2 = mountSkeletonAnimation.transform.TransformPoint(position2) - vector;
		if (vector2.sqrMagnitude <= 1E-06f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket anchor axis is invalid. weapon=" + weaponName + " slot=" + anchorSlotName);
		}
		Vector3 vector3 = parent.InverseTransformDirection(vector2.normalized);
		Vector2 vector4 = new Vector2(vector3.x, vector3.y);
		if (vector4.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket anchor local direction is invalid. weapon=" + weaponName + " slot=" + anchorSlotName);
		}
		float z = Mathf.Atan2(vector4.y, vector4.x) * 57.29578f;
		targetRoot.localPosition = parent.InverseTransformPoint(vector);
		targetRoot.localRotation = Quaternion.Euler(0f, 0f, z);
	}

	private static Quaternion ResolveMountedProjectilePreviewLocalRotation(float authoredZAngle)
	{
		return Quaternion.Euler(0f, 0f, authoredZAngle) * Quaternion.Euler(0f, 180f, 0f);
	}

	private static Vector2 ResolveMountedProjectilePreviewBoundsOrThrow(SkeletonAnimation animation, string weaponName)
	{
		if (animation == null || animation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview missing skeleton while resolving bounds. weapon=" + weaponName);
		}
		Skeleton skeleton = animation.Skeleton;
		skeleton.UpdateWorldTransform();
		skeleton.GetBounds(out var _, out var _, out var width, out var height, ref MountedPreviewBoundsVertexBuffer);
		if (width <= 0.0001f || height <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mounted projectile preview invalid bounds. weapon=" + weaponName + " width=" + width.ToString("F6") + " height=" + height.ToString("F6"));
		}
		return new Vector2(width, height);
	}

	private static void SetMountedProjectilePreviewVisible(MountedProjectilePreviewRuntime preview, bool visible)
	{
		if (preview != null && !(preview.root == null) && (preview.visible != visible || preview.root.gameObject.activeSelf != visible))
		{
			preview.root.gameObject.SetActive(visible);
			preview.visible = visible;
		}
	}

	private void TickMountedProjectilePreviews()
	{
		if (mountedProjectilePreviewBySlot.Count <= 0)
		{
			return;
		}
		float time = Time.time;
		foreach (KeyValuePair<int, MountedProjectilePreviewRuntime> item in mountedProjectilePreviewBySlot)
		{
			MountedProjectilePreviewRuntime value = item.Value;
			if (value != null && value.slot != null && !(value.slot.def == null) && !(value.root == null))
			{
				ApplyMountedProjectilePreviewTransform(value);
				if (value.pendingRespawn && !(time < value.respawnAt))
				{
					value.pendingRespawn = false;
					SetMountedProjectilePreviewVisible(value, visible: true);
				}
			}
		}
	}

	private void MarkMountedProjectileConsumed(WeaponRuntime slot)
	{
		if (slot != null && (!(slot.def != null) || !IsMountedRocketWeapon(slot.def)) && mountedProjectilePreviewBySlot.TryGetValue(slot.slotIndex, out var value) && value != null)
		{
			SetMountedProjectilePreviewVisible(value, visible: false);
			float a = Mathf.Max(0f, slot.def.MountedProjectileRespawnDelay);
			float b = ResolveRuntimeFireInterval(slot.def) * 0.6f;
			float b2 = Mathf.Max(0f, b);
			value.respawnAt = Time.time + Mathf.Min(a, b2);
			value.pendingRespawn = true;
		}
	}

	private bool TryResolveProjectileSpawnPosition(WeaponRuntime slot, Vector2 fallbackMuzzle, out Vector2 spawnPosition)
	{
		spawnPosition = fallbackMuzzle;
		if (slot != null && slot.def != null && IsMountedRocketWeapon(slot.def))
		{
			if (!mountedRocketBySlot.TryGetValue(slot.slotIndex, out var value) || value == null || value.projectile == null || !value.mounted)
			{
				TraceLog("[SummerRace][WeaponSpawn] mounted_rocket_not_ready slot=" + slot.slotIndex + " hasRuntime=" + mountedRocketBySlot.ContainsKey(slot.slotIndex) + " runtimeNull=" + (value == null) + " projectileNull=" + (value == null || value.projectile == null) + " mounted=" + (value?.mounted ?? false));
				return false;
			}
			spawnPosition = value.projectile.transform.position;
			return true;
		}
		if (slot != null && mountedProjectilePreviewBySlot.TryGetValue(slot.slotIndex, out var value2) && value2 != null && value2.root != null && value2.visible)
		{
			spawnPosition = value2.root.position;
			return true;
		}
		return true;
	}

	private void ClearMountedProjectilePreviews()
	{
		foreach (KeyValuePair<int, MountedProjectilePreviewRuntime> item in mountedProjectilePreviewBySlot)
		{
			MountedProjectilePreviewRuntime value = item.Value;
			if (value != null && !(value.root == null))
			{
				UnityEngine.Object.Destroy(value.root.gameObject);
			}
		}
		mountedProjectilePreviewBySlot.Clear();
	}

	private void EnsureMountedRockets()
	{
		if (projectilePrefab == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Projectile prefab is required to create mounted rockets.");
		}
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime == null || weaponRuntime.def == null || weaponRuntime.mount == null || !IsMountedRocketWeapon(weaponRuntime.def))
			{
				continue;
			}
			if (mountedRocketBySlot.TryGetValue(weaponRuntime.slotIndex, out var value) && value != null && value.projectile != null)
			{
				if (value.mounted)
				{
					ApplyMountedRocketTransformOrThrow(value);
				}
				continue;
			}
			VehicleSimpleProjectile vehicleSimpleProjectile = UnityEngine.Object.Instantiate(projectilePrefab, weaponRuntime.mount.transform);
			vehicleSimpleProjectile.gameObject.SetActive(value: true);
			MountedRocketRuntime mountedRocketRuntime = new MountedRocketRuntime
			{
				slot = weaponRuntime,
				projectile = vehicleSimpleProjectile,
				mountSkeletonAnimation = ResolveMountSkeletonAnimation(weaponRuntime),
				anchorSlotName = ResolveMountedProjectileAnchorSlotName(weaponRuntime.def),
				respawnAt = 0f,
				pendingRespawn = false,
				mounted = false
			};
			if (string.IsNullOrWhiteSpace(mountedRocketRuntime.anchorSlotName))
			{
				throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket requires mountedProjectileAnchorSlotName. weapon=" + weaponRuntime.def.name);
			}
			if (!string.IsNullOrWhiteSpace(mountedRocketRuntime.anchorSlotName))
			{
				ValidateMountedProjectileAnchorSlotOrThrow(mountedRocketRuntime.mountSkeletonAnimation, mountedRocketRuntime.anchorSlotName, weaponRuntime.def.name);
			}
			mountedRocketBySlot[weaponRuntime.slotIndex] = mountedRocketRuntime;
			mountedRocketByProjectile[vehicleSimpleProjectile] = mountedRocketRuntime;
			EnterMountedRocketIdleOrThrow(mountedRocketRuntime);
		}
	}

	private void TickMountedRockets()
	{
		if (mountedRocketBySlot.Count <= 0)
		{
			return;
		}
		float time = Time.time;
		foreach (KeyValuePair<int, MountedRocketRuntime> item in mountedRocketBySlot)
		{
			MountedRocketRuntime value = item.Value;
			if (value != null && value.slot != null && !(value.projectile == null))
			{
				if (value.pendingRespawn && time >= value.respawnAt)
				{
					value.pendingRespawn = false;
					EnterMountedRocketIdleOrThrow(value);
				}
				else if (value.mounted)
				{
					ApplyMountedRocketTransformOrThrow(value);
				}
			}
		}
	}

	private void EnterMountedRocketIdleOrThrow(MountedRocketRuntime runtime)
	{
		if (runtime == null || runtime.slot == null || runtime.slot.mount == null || runtime.projectile == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] EnterMountedRocketIdle requires valid runtime references.");
		}
		WeaponRuntime slot = runtime.slot;
		Transform parent = ((slot.mount.VisualInstance != null) ? slot.mount.VisualInstance.transform : slot.mount.transform);
		runtime.projectile.gameObject.SetActive(value: true);
		runtime.projectile.transform.SetParent(parent, worldPositionStays: false);
		ApplyMountedProjectileAnchorTransformOrThrow(runtime.mountSkeletonAnimation, runtime.anchorSlotName, runtime.projectile.transform, slot.def.name);
		Transform sourceTransform = ResolvePresentationSourceTransform();
		runtime.projectile.ConfigurePresentation(sourceTransform, slot.slotIndex, slot.mount, slot.def, (ownerContext != null) ? ownerContext.CombatTeam : SummerRaceCombatTeam.None);
		MeshRenderer componentInChildren = runtime.projectile.GetComponentInChildren<MeshRenderer>(includeInactive: true);
		if (componentInChildren != null)
		{
			componentInChildren.sortingOrder = ResolveMountedObjectSortingOrder(slot);
		}
		SpriteRenderer componentInChildren2 = runtime.projectile.GetComponentInChildren<SpriteRenderer>(includeInactive: true);
		if (componentInChildren2 != null)
		{
			componentInChildren2.sortingOrder = ResolveMountedObjectSortingOrder(slot);
		}
		runtime.projectile.ApplyMountedPreviewAnimationOrThrow(slot.def.MountedProjectileAnimName);
		runtime.projectile.DetachRuntimeCallbacksAndStop();
		runtime.mounted = true;
	}

	private static void ApplyMountedRocketTransformOrThrow(MountedRocketRuntime runtime)
	{
		if (runtime == null || runtime.slot == null || runtime.slot.mount == null || runtime.projectile == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] ApplyMountedRocketTransform requires valid runtime references.");
		}
		ApplyMountedProjectileAnchorTransformOrThrow(runtime.mountSkeletonAnimation, runtime.anchorSlotName, runtime.projectile.transform, runtime.slot.def.name);
	}

	private void ClearMountedRockets()
	{
		foreach (KeyValuePair<int, MountedRocketRuntime> item in mountedRocketBySlot)
		{
			MountedRocketRuntime value = item.Value;
			if (value != null && !(value.projectile == null))
			{
				projectileImpactContexts.Remove(value.projectile);
				projectileImpactedSet.Remove(value.projectile);
				UnityEngine.Object.Destroy(value.projectile.gameObject);
			}
		}
		mountedRocketBySlot.Clear();
		mountedRocketByProjectile.Clear();
	}

	private void ClearShovelColliderRuntimes()
	{
		foreach (KeyValuePair<int, ShovelColliderRuntime> item in shovelColliderBySlot)
		{
			ShovelColliderRuntime value = item.Value;
			if (value != null && !(value.root == null))
			{
				UnityEngine.Object.Destroy(value.root.gameObject);
			}
		}
		shovelColliderBySlot.Clear();
	}

	private void EnsurePersistentBoomerangProjectiles()
	{
		if (projectilePrefab == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Projectile prefab is required to create persistent boomerang instances.");
		}
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && !(weaponRuntime.def == null) && !(weaponRuntime.mount == null) && IsBoomerangWeapon(weaponRuntime.def) && (!persistentBoomerangProjectilesBySlot.TryGetValue(weaponRuntime.slotIndex, out var value) || !(value != null)))
			{
				VehicleSimpleProjectile vehicleSimpleProjectile = UnityEngine.Object.Instantiate(projectilePrefab, weaponRuntime.mount.transform);
				vehicleSimpleProjectile.gameObject.SetActive(value: true);
				vehicleSimpleProjectile.ConfigurePresentation(ResolvePresentationSourceTransform(), weaponRuntime.slotIndex, weaponRuntime.mount, weaponRuntime.def, (ownerContext != null) ? ownerContext.CombatTeam : SummerRaceCombatTeam.None);
				vehicleSimpleProjectile.ConfigureBoomerangMount(weaponRuntime.mount.transform, weaponRuntime.def.BoomerangMountLocalOffset);
				persistentBoomerangProjectilesBySlot[weaponRuntime.slotIndex] = vehicleSimpleProjectile;
			}
		}
	}

	private void ClearPersistentBoomerangProjectiles()
	{
		foreach (KeyValuePair<int, VehicleSimpleProjectile> item in persistentBoomerangProjectilesBySlot)
		{
			VehicleSimpleProjectile value = item.Value;
			if (!(value == null))
			{
				projectileImpactContexts.Remove(value);
				projectileImpactedSet.Remove(value);
				UnityEngine.Object.Destroy(value.gameObject);
			}
		}
		persistentBoomerangProjectilesBySlot.Clear();
	}

	private void DetachProjectileCallbacksBeforeTeardown()
	{
		if (projectileImpactContexts.Count > 0)
		{
			List<VehicleSimpleProjectile> list = new List<VehicleSimpleProjectile>(projectileImpactContexts.Keys);
			for (int i = 0; i < list.Count; i++)
			{
				VehicleSimpleProjectile vehicleSimpleProjectile = list[i];
				if (vehicleSimpleProjectile != null)
				{
					vehicleSimpleProjectile.DetachRuntimeCallbacksAndStop();
				}
			}
		}
		foreach (KeyValuePair<int, VehicleSimpleProjectile> item in persistentBoomerangProjectilesBySlot)
		{
			VehicleSimpleProjectile value = item.Value;
			if (value != null)
			{
				value.DetachRuntimeCallbacksAndStop();
			}
		}
		foreach (KeyValuePair<int, MountedRocketRuntime> item2 in mountedRocketBySlot)
		{
			MountedRocketRuntime value2 = item2.Value;
			if (value2 != null && value2.projectile != null)
			{
				value2.projectile.DetachRuntimeCallbacksAndStop();
			}
		}
	}

	private void ClearProjectilePoolRuntimes(bool destroyPoolRoot)
	{
		projectileImpactContexts.Clear();
		projectileImpactedSet.Clear();
		projectilePool.Clear();
		if (projectilePoolRoot == null)
		{
			return;
		}
		for (int num = projectilePoolRoot.childCount - 1; num >= 0; num--)
		{
			Transform child = projectilePoolRoot.GetChild(num);
			if (child != null)
			{
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
		if (destroyPoolRoot)
		{
			UnityEngine.Object.Destroy(projectilePoolRoot.gameObject);
			projectilePoolRoot = null;
		}
	}

	private VehicleSimpleProjectile AcquireProjectile()
	{
		EnsureProjectilePoolRoot();
		while (projectilePool.Count > 0)
		{
			VehicleSimpleProjectile vehicleSimpleProjectile = projectilePool.Dequeue();
			if (vehicleSimpleProjectile != null)
			{
				return vehicleSimpleProjectile;
			}
		}
		VehicleSimpleProjectile vehicleSimpleProjectile2 = UnityEngine.Object.Instantiate(projectilePrefab, projectilePoolRoot);
		vehicleSimpleProjectile2.gameObject.SetActive(value: false);
		Transform obj = vehicleSimpleProjectile2.transform;
		obj.SetParent(projectilePoolRoot, worldPositionStays: false);
		obj.localPosition = ProjectilePoolParkLocalPosition;
		obj.localRotation = Quaternion.identity;
		return vehicleSimpleProjectile2;
	}

	private VehicleSimpleProjectile AcquirePersistentBoomerangProjectile(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null || slot.mount == null || !IsBoomerangWeapon(slot.def))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] AcquirePersistentBoomerangProjectile requires a boomerang slot.");
		}
		if (!persistentBoomerangProjectilesBySlot.TryGetValue(slot.slotIndex, out var value) || value == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Persistent boomerang projectile is missing. slot=" + slot.slotIndex);
		}
		value.ConfigureBoomerangMount(slot.mount.transform, slot.def.BoomerangMountLocalOffset);
		return value;
	}

	private void ReleaseProjectile(VehicleSimpleProjectile projectile)
	{
		if (projectile == null)
		{
			return;
		}
		WeaponRuntime slot = null;
		if (projectileImpactContexts.TryGetValue(projectile, out var value))
		{
			slot = value.Slot;
		}
		if (ShouldTraceMachineGunProjectile(slot))
		{
			TraceMachineGunProjectileSpawn(slot, "release_before_set_inactive", projectile);
		}
		if (projectileImpactContexts.TryGetValue(projectile, out var value2))
		{
			if (value2.Slot != null && IsBoomerangWeapon(value2.Slot.def) && boomerangProjectilesBySlot.TryGetValue(value2.Slot.slotIndex, out var value3) && value3 == projectile)
			{
				boomerangProjectilesBySlot.Remove(value2.Slot.slotIndex);
			}
			bool impacted = projectileImpactedSet.Remove(projectile);
			EmitProjectileTravelPhaseEnd(value2.Slot, value2.SourcePoint, value2.FireDirection, value2.DeliveryKind, projectile.transform.position, impacted, value2.PresentationSourceTransform);
			projectileImpactContexts.Remove(projectile);
		}
		else
		{
			projectileImpactedSet.Remove(projectile);
		}
		projectile.gameObject.SetActive(value: false);
		Transform obj = projectile.transform;
		obj.SetParent(EnsureProjectilePoolRoot(), worldPositionStays: false);
		obj.localPosition = ProjectilePoolParkLocalPosition;
		obj.localRotation = Quaternion.identity;
		if (ShouldTraceMachineGunProjectile(slot))
		{
			TraceMachineGunProjectileSpawn(slot, "release_after_pool_park", projectile);
		}
		projectilePool.Enqueue(projectile);
	}

	private void HandlePersistentBoomerangRecycle(VehicleSimpleProjectile projectile)
	{
		if (projectile == null)
		{
			return;
		}
		if (projectileImpactContexts.TryGetValue(projectile, out var value))
		{
			if (value.Slot != null && boomerangProjectilesBySlot.TryGetValue(value.Slot.slotIndex, out var value2) && value2 == projectile)
			{
				boomerangProjectilesBySlot.Remove(value.Slot.slotIndex);
			}
			bool impacted = projectileImpactedSet.Remove(projectile);
			EmitProjectileTravelPhaseEnd(value.Slot, value.SourcePoint, value.FireDirection, value.DeliveryKind, projectile.transform.position, impacted, value.PresentationSourceTransform);
			if (value.Slot != null && value.Slot.state != null)
			{
				value.Slot.state.CooldownUntil = Time.time + ResolveCooldown(value.Slot);
			}
			projectileImpactContexts.Remove(projectile);
		}
		else
		{
			projectileImpactedSet.Remove(projectile);
		}
	}

	private void HandleMountedRocketRecycle(VehicleSimpleProjectile projectile)
	{
		if (!(projectile == null))
		{
			if (projectileImpactContexts.TryGetValue(projectile, out var value))
			{
				bool impacted = projectileImpactedSet.Remove(projectile);
				EmitProjectileTravelPhaseEnd(value.Slot, value.SourcePoint, value.FireDirection, value.DeliveryKind, projectile.transform.position, impacted, value.PresentationSourceTransform);
				projectileImpactContexts.Remove(projectile);
			}
			else
			{
				projectileImpactedSet.Remove(projectile);
			}
			if (!mountedRocketByProjectile.TryGetValue(projectile, out var value2) || value2 == null || value2.slot == null)
			{
				throw new InvalidOperationException("[VehicleWeaponSystem] Mounted rocket recycle runtime is missing.");
			}
			value2.mounted = false;
			projectile.DetachRuntimeCallbacksAndStop();
			projectile.gameObject.SetActive(value: false);
			float a = Mathf.Max(0f, value2.slot.def.MountedProjectileRespawnDelay);
			float b = ResolveRuntimeFireInterval(value2.slot.def) * 0.6f;
			float b2 = Mathf.Max(0f, b);
			value2.respawnAt = Time.time + Mathf.Min(a, b2);
			value2.pendingRespawn = true;
		}
	}

	private static bool IsBoomerangWeapon(WeaponModuleDefinition weapon)
	{
		if (weapon != null && weapon.WeaponType == SummerRaceWeaponTypeConfig.Boomerang)
		{
			return weapon.BoomerangFlight;
		}
		return false;
	}

	private bool IsBoomerangProjectileInFlight(int slotIndex)
	{
		if (!boomerangProjectilesBySlot.TryGetValue(slotIndex, out var value))
		{
			return false;
		}
		if (value == null || !value.IsInFlight)
		{
			boomerangProjectilesBySlot.Remove(slotIndex);
			return false;
		}
		return true;
	}

	private Transform EnsureProjectilePoolRoot()
	{
		if (projectilePoolRoot != null)
		{
			return projectilePoolRoot;
		}
		GameObject gameObject = new GameObject(base.name + "_ProjectilePool");
		projectilePoolRoot = gameObject.transform;
		return projectilePoolRoot;
	}

	private bool TryResolveFireContext(WeaponRuntime slot, out Vector2 muzzleWorld, out Vector2 fireDirection)
	{
		muzzleWorld = Vector2.zero;
		fireDirection = Vector2.zero;
		if (slot == null || slot.mount == null || slot.def == null)
		{
			return false;
		}
		muzzleWorld = ResolveMuzzleWorldPosition(slot);
		return TryResolveFireDirection(slot, out fireDirection);
	}

	private bool TryResolveFireDirection(WeaponRuntime slot, out Vector2 direction)
	{
		direction = Vector2.zero;
		if (slot == null || slot.mount == null || slot.def == null)
		{
			return false;
		}
		if (!TryResolveAuthoredFireDirection(slot, out var direction2))
		{
			return false;
		}
		float num = ResolveTeamFireDirectionSign();
		direction = direction2 * num;
		if (direction.sqrMagnitude <= 0.0001f)
		{
			return false;
		}
		direction.Normalize();
		return true;
	}

	private float ResolveTeamFireDirectionSign()
	{
		if (ownerContext == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Owner context is missing while resolving fire direction.");
		}
		if (ownerContext.CombatTeam != SummerRaceCombatTeam.Enemy)
		{
			return 1f;
		}
		return -1f;
	}

	private Vector2 ResolveMuzzleWorldPosition(WeaponRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.def == null)
		{
			return Vector2.zero;
		}
		Vector2 vector = slot.mount.transform.position;
		Vector2 vector2 = ResolveMuzzleOffsetAxis(ResolveAuthoredAxisWorld(slot, slot.authoredLocalRight), (ownerContext != null) ? ownerContext.CombatTeam : SummerRaceCombatTeam.None);
		Vector2 vector3 = ResolveAuthoredAxisWorld(slot, slot.authoredLocalUp);
		Vector2 muzzleLocalOffsetValue = slot.def.MuzzleLocalOffsetValue;
		float num = ResolveMuzzleAlternatingYOffset(slot);
		if (Mathf.Abs(num) > 0f)
		{
			muzzleLocalOffsetValue.y += num;
		}
		return vector + vector2 * muzzleLocalOffsetValue.x + vector3 * muzzleLocalOffsetValue.y;
	}

	private static Vector2 ResolveMuzzleOffsetAxis(Vector2 authoredRight, SummerRaceCombatTeam ownerTeam)
	{
		if (authoredRight.sqrMagnitude <= 0.0001f)
		{
			return Vector2.right;
		}
		if (ownerTeam != SummerRaceCombatTeam.Enemy)
		{
			return authoredRight.normalized;
		}
		return -authoredRight.normalized;
	}

	private static float ResolveMuzzleAlternatingYOffset(WeaponRuntime slot)
	{
		if (slot == null || slot.def == null || slot.def.WeaponType != SummerRaceWeaponTypeConfig.MachineGun)
		{
			return 0f;
		}
		float num = Mathf.Abs(slot.def.MuzzleAlternatingYOffsetValue);
		if (num <= 0f)
		{
			return 0f;
		}
		if ((slot.muzzleAlternatingStep & 1) != 0)
		{
			return 0f - num;
		}
		return num;
	}

	private static bool TryResolveAuthoredFireDirection(WeaponRuntime slot, out Vector2 direction)
	{
		direction = Vector2.zero;
		if (slot == null || slot.mount == null)
		{
			return false;
		}
		Vector2 vector = ResolveAuthoredAxisWorld(slot, slot.authoredLocalRight);
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return false;
		}
		direction = vector.normalized;
		return true;
	}

	private static Vector2 ResolveAuthoredAxisWorld(WeaponRuntime slot, Vector2 localAxis)
	{
		if (slot == null || slot.mount == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] ResolveAuthoredAxisWorld requires mount slot.");
		}
		if (!IsFinite(localAxis))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Non-finite authored local axis. slot=" + slot.slotIndex + " axis=(" + localAxis.x + "," + localAxis.y + ")");
		}
		Transform parent = slot.mount.transform.parent;
		if (parent == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Mount parent is missing while resolving authored axis. slot=" + slot.slotIndex);
		}
		Vector3 vector = parent.TransformVector(new Vector3(localAxis.x, localAxis.y, 0f));
		Vector2 value = new Vector2(vector.x, vector.y);
		if (!IsFinite(value))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Non-finite authored axis world transform. slot=" + slot.slotIndex + " localAxis=(" + localAxis.x + "," + localAxis.y + ")");
		}
		if (value.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Authored axis resolved to zero. slot=" + slot.slotIndex + " localAxis=(" + localAxis.x.ToString("F4") + "," + localAxis.y.ToString("F4") + ")");
		}
		return value.normalized;
	}

	private static Vector2 ResolveAuthoredLocalAxis(Vector3 axis, Vector2 axisSemantic)
	{
		Vector2 value = new Vector2(axis.x, axis.y);
		if (!IsFinite(value))
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Non-finite authored local axis from mount rotation. semantic=(" + axisSemantic.x.ToString("F4") + "," + axisSemantic.y.ToString("F4") + ")");
		}
		if (value.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Invalid authored local axis from mount rotation. semantic=(" + axisSemantic.x.ToString("F4") + "," + axisSemantic.y.ToString("F4") + ")");
		}
		return value.normalized;
	}

	private static Vector2 Rotate(Vector2 dir, float degrees)
	{
		float f = degrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(dir.x * num - dir.y * num2, dir.x * num2 + dir.y * num).normalized;
	}

	private static Vector2 RotateVector(Vector2 v, float degrees)
	{
		float f = degrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(v.x * num - v.y * num2, v.x * num2 + v.y * num);
	}

	private void SyncRuntimeStateFromOwner(WeaponRuntime slot)
	{
		if (slot != null && slot.state != null && ownerContext != null)
		{
			slot.state.OverloadUntil = ownerContext.ResolveWeaponOverloadUntil(slot.slotIndex);
		}
	}

	private void DecayDynamicSpread(WeaponRuntime slot)
	{
		if (slot == null || slot.state == null)
		{
			return;
		}
		float time = Time.time;
		float num = Mathf.Max(0f, time - slot.lastSpreadUpdateTime);
		slot.lastSpreadUpdateTime = time;
		if (!(num <= 0f))
		{
			float num2 = Mathf.Max(0f, slot.def.SpreadDecayPerSecond);
			if (!(num2 <= 0f))
			{
				slot.state.DynamicSpread = Mathf.Max(0f, slot.state.DynamicSpread - num2 * num);
			}
		}
	}

	private static int ResolveRuntimeBurstCount(WeaponModuleDefinition def)
	{
		if (!(def != null))
		{
			return 1;
		}
		return Mathf.Max(1, def.OptionalBurstCountValue);
	}

	private static float ResolveRuntimeFireInterval(WeaponModuleDefinition def)
	{
		if (!(def != null))
		{
			return 0.02f;
		}
		return Mathf.Max(0.02f, def.FireIntervalValue);
	}

	private static float ResolveRuntimeBaseSpread(WeaponModuleDefinition def)
	{
		if (!(def != null))
		{
			return 0f;
		}
		return Mathf.Max(0f, def.OptionalSpreadValue);
	}

	private static void ResolveProjectileDirections(Vector2 fireDir, int projectileCount, float spreadDegrees, List<Vector2> output)
	{
		if (output == null)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Projectile direction output buffer is required.");
		}
		output.Clear();
		if (fireDir.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleWeaponSystem] Projectile fire direction is invalid.");
		}
		Vector2 normalized = fireDir.normalized;
		int num = Mathf.Max(1, projectileCount);
		float num2 = Mathf.Max(0f, spreadDegrees);
		if (num == 1)
		{
			output.Add((num2 > 0.001f) ? Rotate(normalized, UnityEngine.Random.Range(0f - num2, num2)) : normalized);
			return;
		}
		Vector2 dir = ((num2 > 0.001f) ? Rotate(normalized, UnityEngine.Random.Range((0f - num2) * 0.15f, num2 * 0.15f)) : normalized);
		float num3 = ((num > 1) ? (num2 * 2f / (float)(num - 1)) : 0f);
		for (int i = 0; i < num; i++)
		{
			float degrees = ((num > 1) ? (0f - num2 + num3 * (float)i) : 0f);
			output.Add(Rotate(dir, degrees));
		}
	}

	private static float ResolveCooldown(WeaponRuntime slot)
	{
		float num = ResolveRuntimeFireInterval(slot?.def);
		if (Time.time < slot.state.OverloadUntil)
		{
			num *= 0.6f;
		}
		return num;
	}
}
