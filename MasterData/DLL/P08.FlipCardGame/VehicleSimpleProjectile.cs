using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.Rendering;

[DisallowMultipleComponent]
[RequireComponent(typeof(CircleCollider2D))]
[RequireComponent(typeof(Rigidbody2D))]
public class VehicleSimpleProjectile : MonoBehaviour
{
	private sealed class ProjectileSourceContext : ICombatSourceContext
	{
		private readonly ICombatSourceContext notifySource;

		private readonly Transform sourceTransform;

		private readonly Rigidbody2D sourceRigidbody;

		private readonly int weaponSlotIndex;

		public Transform CombatSourceTransform => sourceTransform;

		public Rigidbody2D CombatSourceRigidbody => sourceRigidbody;

		public SummerRaceCombatTeam CombatTeam { get; }

		public bool OverclockDamageTextActive
		{
			get
			{
				if (notifySource is IWeaponOwnerContext weaponOwnerContext && weaponSlotIndex >= 0)
				{
					return Time.time < weaponOwnerContext.ResolveWeaponOverloadUntil(weaponSlotIndex);
				}
				if (notifySource != null)
				{
					return notifySource.OverclockDamageTextActive;
				}
				return false;
			}
		}

		public ProjectileSourceContext(ICombatSourceContext source, int weaponSlotIndex)
		{
			if (source == null)
			{
				throw new InvalidOperationException("[VehicleSimpleProjectile] Combat source context is required.");
			}
			notifySource = source;
			sourceTransform = source.CombatSourceTransform;
			sourceRigidbody = source.CombatSourceRigidbody;
			CombatTeam = source.CombatTeam;
			this.weaponSlotIndex = weaponSlotIndex;
		}

		public void NotifyCombatDamageDealt(int amount)
		{
			if (notifySource != null && (!(notifySource is UnityEngine.Object obj) || !(obj == null)))
			{
				notifySource.NotifyCombatDamageDealt(amount);
			}
		}
	}

	private const float DirectionEpsilon = 0.0001f;

	private const int BodyBand = 0;

	private const int WeaponEquipEffectBackBand = 1;

	private const int ProjectileBand = 2;

	private const int WeaponEquipBand = 3;

	private const int WeaponEquipEffectFrontBand = 4;

	private const int ProjectileSpineVisualSortingOrder = 30;

	private const float BoomerangCatchDistance = 0.12f;

	private const float BoomerangOutwardDistanceRatio = 0.48f;

	private const float BoomerangOutwardDistanceMin = 1.2f;

	private const float BoomerangReturnSteerStrength = 0.72f;

	private const bool TraceProjectileVisualLog = true;

	private const string MachineGunWeaponDefinitionName = "SummerRaceWeapon_MachineGun";

	private const int MachineGunInterpolationRestoreDelayFixedSteps = 2;

	private static float[] ProjectileBoundsVertexBuffer = new float[1024];

	private static Material cachedTrailMaterial;

	private Vector2 direction;

	private Vector2 visualDirection;

	private float visualSpinDegrees;

	private float speed;

	private float lifeUntil;

	private float lifeDuration;

	private LayerMask hitMask;

	private Rigidbody2D rb;

	private bool initialized;

	private bool recycled;

	private bool despawning;

	private float despawnUntil;

	private bool returnPhaseEventSent;

	private bool boomerangFlight;

	private bool boomerangReturnStarted;

	private float boomerangOutwardDistanceLimit;

	private float boomerangDistanceTraveled;

	private bool persistentBoomerangMountEnabled;

	private Transform boomerangMountTransform;

	private Vector2 boomerangMountLocalOffset;

	private Action<VehicleSimpleProjectile, SummerRacePresentationPhase> phaseCallback;

	private Func<VehicleSimpleProjectile, ICombatStatusHost, Vector2, CombatExecutionResult> impactCallback;

	private Action<VehicleSimpleProjectile> recycleCallback;

	private UnityEngine.Object recycleCallbackOwner;

	private ProjectileSourceContext sourceContext;

	private Vector2 spawnPoint;

	private Transform presentationSourceTransform;

	private SummerRaceCombatTeam sourceTeam;

	private WeaponKind weaponKind;

	private int weaponSlotIndex = -1;

	private MountPoint weaponMountPoint;

	private WeaponModuleDefinition weaponDefinition;

	private SummerRacePresentationDeliveryKind deliveryKind;

	private SummerRacePresentationPhaseContract presentationContract;

	private SummerRaceWeaponPresentationProfile presentationProfile;

	private CircleCollider2D circleCollider;

	private SpriteRenderer spriteRenderer;

	private TrailRenderer trailRenderer;

	private Transform spineVisualRoot;

	private SkeletonAnimation projectileSkeletonAnimation;

	private MeshRenderer projectileSpineRenderer;

	private readonly HashSet<int> boomerangHitTargetIds = new HashSet<int>();

	private int spawnTraceFixedFramesRemaining;

	private bool interpolationRestorePending;

	private int interpolationRestoreCountdown;

	private bool spawnedFromPoolReuse;

	public bool IsInFlight { get; private set; }

	public bool TryGetVisualSortAnchor(out int sortingOrder, out int sortingLayerId)
	{
		if (projectileSpineRenderer != null)
		{
			sortingOrder = projectileSpineRenderer.sortingOrder;
			sortingLayerId = projectileSpineRenderer.sortingLayerID;
			return true;
		}
		if (spriteRenderer != null)
		{
			sortingOrder = spriteRenderer.sortingOrder;
			sortingLayerId = spriteRenderer.sortingLayerID;
			return true;
		}
		sortingOrder = 0;
		sortingLayerId = 0;
		return false;
	}

	private static void TraceLog(string message)
	{
		if (SummerRaceRuntimeLog.IsGameplayVerboseEnabled)
		{
			SummerRaceRuntimeLog.Verbose(message);
		}
	}

	private bool ShouldTraceMachineGun()
	{
		if (SummerRaceRuntimeLog.IsGameplayVerboseEnabled && weaponKind == WeaponKind.MachineGun && weaponDefinition != null)
		{
			return string.Equals(weaponDefinition.name, "SummerRaceWeapon_MachineGun", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private bool ShouldUseInterpolationLifecycleForCurrentWeapon()
	{
		if (weaponKind != WeaponKind.MachineGun)
		{
			if (weaponDefinition != null)
			{
				return string.Equals(weaponDefinition.name, "SummerRaceWeapon_MachineGun", StringComparison.OrdinalIgnoreCase);
			}
			return false;
		}
		return true;
	}

	private void ApplySpawnInterpolationLifecycleForCurrentWeapon()
	{
		if (rb == null)
		{
			return;
		}
		if (ShouldUseInterpolationLifecycleForCurrentWeapon())
		{
			if (spawnedFromPoolReuse)
			{
				rb.interpolation = RigidbodyInterpolation2D.None;
				interpolationRestorePending = true;
				interpolationRestoreCountdown = 2;
			}
			else
			{
				rb.interpolation = RigidbodyInterpolation2D.Interpolate;
				interpolationRestorePending = false;
				interpolationRestoreCountdown = 0;
			}
		}
		else
		{
			rb.interpolation = RigidbodyInterpolation2D.Interpolate;
			interpolationRestorePending = false;
			interpolationRestoreCountdown = 0;
		}
	}

	private void TraceMachineGunSpawnState(string stage)
	{
		if (ShouldTraceMachineGun())
		{
			string text = ((rb != null) ? rb.interpolation.ToString() : "<no-rb>");
			Vector2 vector = ((rb != null) ? rb.position : Vector2.zero);
			Vector2 vector2 = ((rb != null) ? rb.velocity : Vector2.zero);
			float num = ((rb != null) ? rb.angularVelocity : 0f);
			bool flag = rb != null && rb.simulated;
			string[] obj = new string[38]
			{
				"[SummerRace][ProjectileMG-TRACE] stage=",
				stage,
				" frame=",
				Time.frameCount.ToString(),
				" t=",
				Time.time.ToString("F3"),
				" id=",
				GetInstanceID().ToString(),
				" active=",
				base.gameObject.activeInHierarchy.ToString(),
				" initialized=",
				initialized.ToString(),
				" recycled=",
				recycled.ToString(),
				" pos=",
				base.transform.position.ToString(),
				" rotZ=",
				base.transform.eulerAngles.z.ToString("F1"),
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
				null,
				null,
				null
			};
			Vector2 vector3 = direction;
			obj[19] = vector3.ToString();
			obj[20] = " speed=";
			obj[21] = speed.ToString("F3");
			obj[22] = " fromPool=";
			obj[23] = spawnedFromPoolReuse.ToString();
			obj[24] = " rbPos=";
			vector3 = vector;
			obj[25] = vector3.ToString();
			obj[26] = " rbVel=";
			vector3 = vector2;
			obj[27] = vector3.ToString();
			obj[28] = " rbAVel=";
			obj[29] = num.ToString("F3");
			obj[30] = " rbSim=";
			obj[31] = flag.ToString();
			obj[32] = " rbInterp=";
			obj[33] = text;
			obj[34] = " interpPending=";
			obj[35] = interpolationRestorePending.ToString();
			obj[36] = " interpCountdown=";
			obj[37] = interpolationRestoreCountdown.ToString();
			SummerRaceRuntimeLog.Verbose(string.Concat(obj));
		}
	}

	private void Awake()
	{
		rb = GetComponent<Rigidbody2D>();
		rb.bodyType = RigidbodyType2D.Kinematic;
		rb.gravityScale = 0f;
		rb.drag = 0f;
		rb.angularDrag = 0f;
		rb.collisionDetectionMode = CollisionDetectionMode2D.Continuous;
		rb.interpolation = RigidbodyInterpolation2D.Interpolate;
		circleCollider = GetComponent<CircleCollider2D>();
		circleCollider.isTrigger = true;
		circleCollider.radius = 0.5f;
		spriteRenderer = GetComponent<SpriteRenderer>();
		spriteRenderer.sortingOrder = 320;
		SummerRaceSpriteMaterialUtility.ApplyDefault2D(spriteRenderer);
		spriteRenderer.enabled = false;
		spineVisualRoot = new GameObject("ProjectileSpineVisual").transform;
		spineVisualRoot.SetParent(base.transform, worldPositionStays: false);
		spineVisualRoot.gameObject.SetActive(value: false);
		base.transform.localScale = Vector3.one;
		initialized = false;
		recycled = false;
	}

	public void Init(Vector2 dir, float speedValue, bool isBoomerangFlight, bool fromPoolReuse, int weaponSlotIndex, ICombatSourceContext ownerContext, float lifetime, LayerMask mask, Action<VehicleSimpleProjectile, SummerRacePresentationPhase> onPhase, Func<VehicleSimpleProjectile, ICombatStatusHost, Vector2, CombatExecutionResult> onImpact, Action<VehicleSimpleProjectile> onRecycle)
	{
		if (dir.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Fire direction is invalid.");
		}
		if (onRecycle == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Recycle callback is required.");
		}
		direction = dir.normalized;
		visualDirection = direction;
		visualSpinDegrees = 0f;
		this.weaponSlotIndex = weaponSlotIndex;
		spawnPoint = base.transform.position;
		speed = Mathf.Max(0f, speedValue);
		spawnedFromPoolReuse = fromPoolReuse;
		boomerangFlight = isBoomerangFlight;
		if (!boomerangFlight)
		{
			persistentBoomerangMountEnabled = false;
			boomerangMountTransform = null;
			boomerangMountLocalOffset = Vector2.zero;
		}
		else if (persistentBoomerangMountEnabled && boomerangMountTransform == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Boomerang mount state is enabled but mount transform is missing.");
		}
		int num = ((ownerContext is IWeaponOwnerContext) ? weaponSlotIndex : (-1));
		sourceContext = new ProjectileSourceContext(ownerContext, num);
		sourceTeam = sourceContext.CombatTeam;
		lifeDuration = Mathf.Max(0.05f, lifetime);
		lifeUntil = Time.time + lifeDuration;
		hitMask = mask;
		phaseCallback = onPhase;
		impactCallback = onImpact;
		recycleCallback = onRecycle;
		recycleCallbackOwner = onRecycle.Target as UnityEngine.Object;
		initialized = true;
		recycled = false;
		IsInFlight = true;
		despawning = false;
		despawnUntil = 0f;
		returnPhaseEventSent = false;
		boomerangReturnStarted = false;
		boomerangDistanceTraveled = 0f;
		boomerangOutwardDistanceLimit = (boomerangFlight ? ResolveBoomerangOutwardDistanceLimit(speed, lifeDuration) : 0f);
		boomerangHitTargetIds.Clear();
		if (rb != null)
		{
			ResetRigidbodyForSpawn(base.transform.position);
		}
		TraceMachineGunSpawnState("init_after_reset_rigidbody");
		if (circleCollider != null)
		{
			circleCollider.enabled = true;
		}
		ConfigureTrailEmission(enabled: false);
		ClearTrail();
		ApplyVisualDirection(direction, forceImmediate: true);
		ConfigureTrailEmission(presentationProfile.EnableTrail);
	}

	public void ConfigurePresentation(Transform sourceTransform, int slotIndex, MountPoint mountPoint, WeaponModuleDefinition weaponDefinition, SummerRaceCombatTeam ownerTeam)
	{
		presentationSourceTransform = sourceTransform;
		sourceTeam = ownerTeam;
		weaponSlotIndex = slotIndex;
		weaponMountPoint = mountPoint;
		this.weaponDefinition = weaponDefinition;
		weaponKind = SummerRaceCombatPresentationRouter.ResolveWeaponKind(weaponDefinition);
		deliveryKind = SummerRaceCombatPresentationRouter.ResolveWeaponDeliveryKind(weaponDefinition);
		presentationContract = SummerRaceCombatPresentationRouter.ResolveProjectilePresentationContract(deliveryKind);
		presentationProfile = SummerRaceWeaponPresentationProfileResolver.Resolve(weaponDefinition);
		ApplySpawnInterpolationLifecycleForCurrentWeapon();
		ApplyProjectileSortingOrder();
		ApplyPresentationProfile(presentationProfile);
		ApplyProjectileSpineVisualOrThrow();
		string[] obj = new string[10]
		{
			"[SummerRace][ProjectileVisual] bind weapon=",
			(weaponDefinition != null) ? weaponDefinition.name : string.Empty,
			" slot=",
			slotIndex.ToString(),
			" profileSize=",
			presentationProfile.ProjectileSize.ToString(),
			" colliderRadius=",
			null,
			null,
			null
		};
		float colliderRadius = presentationProfile.ColliderRadius;
		obj[7] = colliderRadius.ToString();
		obj[8] = " source=";
		obj[9] = ((sourceTransform != null) ? sourceTransform.name : "null");
		TraceLog(string.Concat(obj));
		if (direction.sqrMagnitude > 0.0001f)
		{
			ApplyVisualDirection(direction, forceImmediate: true);
		}
		spawnTraceFixedFramesRemaining = 3;
		TraceMachineGunSpawnState("configure_presentation_done");
		if (initialized)
		{
			EmitProjectileEventIfSupported(SummerRacePresentationPhase.Spawned, null, 0, 0);
		}
	}

	public void ConfigureBoomerangMount(Transform mountTransform, Vector2 mountLocalOffset)
	{
		if (mountTransform == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Boomerang mount transform is required.");
		}
		persistentBoomerangMountEnabled = true;
		boomerangMountTransform = mountTransform;
		boomerangMountLocalOffset = mountLocalOffset;
		EnterMountedIdlePose();
	}

	public void ApplyMountedPreviewAnimationOrThrow(string animationName)
	{
		if (projectileSkeletonAnimation == null || projectileSkeletonAnimation.Skeleton == null || projectileSkeletonAnimation.AnimationState == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Mounted preview animation requires initialized projectile skeleton.");
		}
		if (string.IsNullOrWhiteSpace(animationName))
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Mounted preview animation name is empty.");
		}
		if (string.Equals(animationName, "none", StringComparison.OrdinalIgnoreCase))
		{
			projectileSkeletonAnimation.AnimationState.ClearTracks();
			projectileSkeletonAnimation.Skeleton.SetToSetupPose();
			projectileSkeletonAnimation.AnimationState.Apply(projectileSkeletonAnimation.Skeleton);
			return;
		}
		Spine.Animation animation = projectileSkeletonAnimation.Skeleton.Data.FindAnimation(animationName);
		if (animation == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing mounted preview animation '" + animationName + "' for weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : "<null>"));
		}
		projectileSkeletonAnimation.AnimationState.SetAnimation(0, animation.Name, loop: true);
	}

	public void DetachRuntimeCallbacksAndStop()
	{
		initialized = false;
		recycled = true;
		IsInFlight = false;
		despawning = false;
		despawnUntil = 0f;
		boomerangFlight = false;
		boomerangReturnStarted = false;
		boomerangOutwardDistanceLimit = 0f;
		boomerangDistanceTraveled = 0f;
		returnPhaseEventSent = false;
		phaseCallback = null;
		impactCallback = null;
		recycleCallback = null;
		recycleCallbackOwner = null;
		sourceContext = null;
		sourceTeam = SummerRaceCombatTeam.None;
		presentationSourceTransform = null;
		weaponMountPoint = null;
		lifeUntil = float.PositiveInfinity;
		lifeDuration = 0f;
		boomerangHitTargetIds.Clear();
		if (rb != null)
		{
			rb.velocity = Vector2.zero;
			rb.angularVelocity = 0f;
			rb.simulated = false;
			rb.interpolation = RigidbodyInterpolation2D.None;
		}
		spawnedFromPoolReuse = false;
		interpolationRestorePending = false;
		interpolationRestoreCountdown = 0;
		if (circleCollider != null)
		{
			circleCollider.enabled = false;
		}
		ConfigureTrailEmission(enabled: false);
		ClearTrail();
	}

	private void Update()
	{
		if (!initialized || recycled)
		{
			return;
		}
		if (despawning)
		{
			if (Time.time >= despawnUntil)
			{
				RecycleSelf();
			}
		}
		else if (boomerangFlight)
		{
			if (!boomerangReturnStarted)
			{
				if (Time.time >= lifeUntil)
				{
					TraceLog("[SummerRace][ProjectileVisual] boomerang return started by life timeout. weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : string.Empty));
					StartBoomerangReturn();
				}
			}
			else if (Time.time >= lifeUntil + lifeDuration)
			{
				TraceLog("[SummerRace][ProjectileVisual] recycle by boomerang return timeout. weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : string.Empty));
				RecycleSelf();
			}
		}
		else if (Time.time >= lifeUntil && !TryBeginDespawnOnProjectileSpine(direction))
		{
			TraceLog("[SummerRace][ProjectileVisual] recycle by life timeout. weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : string.Empty));
			RecycleSelf();
		}
	}

	private void FixedUpdate()
	{
		if (rb == null || !initialized || recycled)
		{
			return;
		}
		if (interpolationRestorePending)
		{
			if (interpolationRestoreCountdown > 0)
			{
				interpolationRestoreCountdown--;
				TraceMachineGunSpawnState("fixed_wait_restore_interpolation");
			}
			else
			{
				rb.interpolation = RigidbodyInterpolation2D.Interpolate;
				interpolationRestorePending = false;
				TraceMachineGunSpawnState("fixed_restore_interpolation");
			}
		}
		if (despawning)
		{
			return;
		}
		float num = speed * Time.fixedDeltaTime;
		if (spawnTraceFixedFramesRemaining > 0)
		{
			TraceMachineGunSpawnState("fixed_before_move step=" + num.ToString("F3"));
		}
		if (boomerangFlight && boomerangReturnStarted)
		{
			Vector2 vector = ResolveBoomerangReturnTarget();
			Vector2 vector2 = vector - rb.position;
			float magnitude = vector2.magnitude;
			float num2 = Mathf.Max(0.12f, num);
			if (magnitude <= num2)
			{
				string[] obj = new string[8]
				{
					"[SummerRace][ProjectileVisual] recycle by boomerang catch. weapon=",
					(weaponDefinition != null) ? weaponDefinition.name : string.Empty,
					" projectilePos=",
					rb.position.ToString(),
					" returnTarget=",
					null,
					null,
					null
				};
				Vector2 vector3 = vector;
				obj[5] = vector3.ToString();
				obj[6] = " distance=";
				obj[7] = magnitude.ToString("F3");
				TraceLog(string.Concat(obj));
				SnapBoomerangToReturnTarget(vector);
				RecycleSelf();
			}
			else
			{
				Vector2 vector4 = vector2 / magnitude;
				Vector2 a = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : vector4);
				direction = Vector2.Lerp(a, vector4, 0.72f).normalized;
				float num3 = Mathf.Min(num, magnitude);
				rb.MovePosition(rb.position + direction * num3);
				if (spawnTraceFixedFramesRemaining > 0)
				{
					TraceMachineGunSpawnState("fixed_after_move_return step=" + num3.ToString("F3"));
					spawnTraceFixedFramesRemaining--;
				}
				ApplyVisualDirection(direction, forceImmediate: false);
			}
		}
		else
		{
			if (boomerangFlight && !boomerangReturnStarted && boomerangDistanceTraveled >= boomerangOutwardDistanceLimit)
			{
				TraceLog("[SummerRace][ProjectileVisual] boomerang return started by outward distance. weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : string.Empty) + " distance=" + boomerangDistanceTraveled.ToString("F3") + " limit=" + boomerangOutwardDistanceLimit.ToString("F3"));
				StartBoomerangReturn();
			}
			rb.MovePosition(rb.position + direction * num);
			if (spawnTraceFixedFramesRemaining > 0)
			{
				TraceMachineGunSpawnState("fixed_after_move step=" + num.ToString("F3"));
				spawnTraceFixedFramesRemaining--;
			}
			if (boomerangFlight && !boomerangReturnStarted && num > 0f)
			{
				boomerangDistanceTraveled += num;
			}
			ApplyVisualDirection(direction, forceImmediate: false);
		}
	}

	private Vector2 ResolveBoomerangReturnTarget()
	{
		if (persistentBoomerangMountEnabled && boomerangMountTransform != null)
		{
			return boomerangMountTransform.TransformPoint(boomerangMountLocalOffset);
		}
		if (weaponMountPoint != null)
		{
			return weaponMountPoint.transform.position;
		}
		if (sourceContext != null && sourceContext.CombatSourceTransform != null)
		{
			return sourceContext.CombatSourceTransform.position;
		}
		if (!(rb != null))
		{
			return base.transform.position;
		}
		return rb.position;
	}

	private void SnapBoomerangToReturnTarget(Vector2 returnTarget)
	{
		if (rb != null)
		{
			rb.position = returnTarget;
			rb.velocity = Vector2.zero;
			rb.angularVelocity = 0f;
		}
		base.transform.position = returnTarget;
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		if (other == null || !initialized || recycled || despawning)
		{
			return;
		}
		int num = 1 << other.gameObject.layer;
		if ((hitMask.value & num) == 0 || ShouldIgnoreCollision(other))
		{
			return;
		}
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		if (SummerRaceCombatResolver.TryResolveStatusHost(other, out var statusHost))
		{
			if (!SummerRaceCombatResolver.IsHostile(sourceContext, statusHost) || (!boomerangFlight && !IsTargetInProjectileForwardHalfPlane(spawnPoint, vector, statusHost.CombatTransform)))
			{
				return;
			}
			if (boomerangFlight)
			{
				int item = ResolveBoomerangTargetId(statusHost);
				if (boomerangHitTargetIds.Contains(item))
				{
					return;
				}
				boomerangHitTargetIds.Add(item);
			}
			CombatExecutionResult combatExecutionResult = ((impactCallback != null) ? impactCallback(this, statusHost, vector) : CombatExecutionResult.Failed("Projectile impact callback is missing."));
			EmitProjectileEventIfSupported(SummerRacePresentationPhase.Hit, statusHost, combatExecutionResult.AppliedEffects, combatExecutionResult.DamageDealt);
			if (!boomerangFlight && !TryBeginDespawnOnProjectileSpine(vector))
			{
				EmitImpactSpineIfConfigured(vector);
				RecycleSelf();
			}
		}
		else if ((!(weaponDefinition != null) || weaponDefinition.ProjectileHitPolicy != SummerRaceProjectileHitPolicyConfig.HostileOnly) && !other.isTrigger && !boomerangFlight && !TryBeginDespawnOnProjectileSpine(vector))
		{
			EmitImpactSpineIfConfigured(vector);
			RecycleSelf();
		}
	}

	private static int ResolveBoomerangTargetId(ICombatStatusHost host)
	{
		if (host == null)
		{
			return 0;
		}
		Transform combatTransform = host.CombatTransform;
		if (!(combatTransform != null))
		{
			return host.GetHashCode();
		}
		return combatTransform.GetInstanceID();
	}

	private void RecycleSelf()
	{
		if (recycled)
		{
			return;
		}
		if (persistentBoomerangMountEnabled)
		{
			if (!boomerangFlight)
			{
				throw new InvalidOperationException("[VehicleSimpleProjectile] Non-boomerang projectile entered mounted recycle path. weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : "<null>"));
			}
			EmitProjectileEventIfSupported(SummerRacePresentationPhase.Recycled, null, 0, 0);
			EnterMountedIdlePose();
			TryInvokeRecycleCallback();
			recycleCallback = null;
			recycleCallbackOwner = null;
			return;
		}
		EmitProjectileEventIfSupported(SummerRacePresentationPhase.Recycled, null, 0, 0);
		recycled = true;
		initialized = false;
		IsInFlight = false;
		direction = Vector2.zero;
		visualDirection = Vector2.right;
		visualSpinDegrees = 0f;
		speed = 0f;
		boomerangFlight = false;
		boomerangReturnStarted = false;
		boomerangOutwardDistanceLimit = 0f;
		boomerangDistanceTraveled = 0f;
		boomerangHitTargetIds.Clear();
		sourceContext = null;
		spawnPoint = Vector2.zero;
		presentationSourceTransform = null;
		weaponKind = WeaponKind.MachineGun;
		weaponSlotIndex = -1;
		weaponMountPoint = null;
		weaponDefinition = null;
		deliveryKind = SummerRacePresentationDeliveryKind.None;
		presentationContract = default(SummerRacePresentationPhaseContract);
		presentationProfile = default(SummerRaceWeaponPresentationProfile);
		despawning = false;
		despawnUntil = 0f;
		returnPhaseEventSent = false;
		lifeUntil = float.PositiveInfinity;
		lifeDuration = 0f;
		hitMask = default(LayerMask);
		phaseCallback = null;
		impactCallback = null;
		if (rb != null)
		{
			rb.velocity = Vector2.zero;
			rb.angularVelocity = 0f;
			rb.simulated = false;
			rb.interpolation = RigidbodyInterpolation2D.None;
		}
		spawnedFromPoolReuse = false;
		interpolationRestorePending = false;
		interpolationRestoreCountdown = 0;
		ConfigureTrailEmission(enabled: false);
		ClearTrail();
		if (spineVisualRoot != null)
		{
			spineVisualRoot.gameObject.SetActive(value: false);
		}
		if (spriteRenderer != null)
		{
			spriteRenderer.enabled = true;
		}
		if (circleCollider != null)
		{
			circleCollider.enabled = false;
		}
		TryInvokeRecycleCallback();
		recycleCallback = null;
		recycleCallbackOwner = null;
	}

	private void TryInvokeRecycleCallback()
	{
		if (recycleCallback != null)
		{
			UnityEngine.Object obj = recycleCallbackOwner;
			if ((object)obj == null || !(obj == null))
			{
				recycleCallback(this);
			}
		}
	}

	private void EnterMountedIdlePose()
	{
		if (!persistentBoomerangMountEnabled || boomerangMountTransform == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Persistent boomerang mount is not configured.");
		}
		recycled = true;
		initialized = false;
		IsInFlight = false;
		despawning = false;
		despawnUntil = 0f;
		returnPhaseEventSent = false;
		boomerangFlight = false;
		boomerangReturnStarted = false;
		boomerangOutwardDistanceLimit = 0f;
		boomerangDistanceTraveled = 0f;
		boomerangHitTargetIds.Clear();
		direction = Vector2.right;
		visualDirection = Vector2.right;
		visualSpinDegrees = 0f;
		speed = 0f;
		lifeUntil = float.PositiveInfinity;
		lifeDuration = 0f;
		hitMask = default(LayerMask);
		phaseCallback = null;
		impactCallback = null;
		sourceContext = null;
		spawnPoint = Vector2.zero;
		if (rb != null)
		{
			rb.velocity = Vector2.zero;
			rb.angularVelocity = 0f;
			rb.simulated = false;
			rb.interpolation = RigidbodyInterpolation2D.None;
		}
		spawnedFromPoolReuse = false;
		interpolationRestorePending = false;
		interpolationRestoreCountdown = 0;
		if (circleCollider != null)
		{
			circleCollider.enabled = false;
		}
		ConfigureTrailEmission(enabled: false);
		ClearTrail();
		base.transform.SetParent(boomerangMountTransform, worldPositionStays: false);
		base.transform.localPosition = boomerangMountLocalOffset;
		base.transform.localRotation = Quaternion.identity;
		if (spineVisualRoot != null)
		{
			spineVisualRoot.gameObject.SetActive(value: true);
		}
		if (projectileSkeletonAnimation != null && weaponDefinition != null)
		{
			PlayLoopAnimationOrThrow(projectileSkeletonAnimation, weaponDefinition.name, "projectile", weaponDefinition.ProjectileLoopAnimName);
		}
		if (spriteRenderer != null)
		{
			spriteRenderer.enabled = projectileSkeletonAnimation == null;
		}
	}

	private void ApplyPresentationProfile(SummerRaceWeaponPresentationProfile profile)
	{
		if (spriteRenderer == null || circleCollider == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Visual components are missing.");
		}
		circleCollider.radius = Mathf.Max(0.02f, profile.ColliderRadius);
		TrailRenderer obj = EnsureTrailRenderer();
		obj.time = (profile.EnableTrail ? Mathf.Max(0.01f, profile.TrailTime) : 0f);
		obj.startWidth = Mathf.Max(0f, profile.TrailStartWidth);
		obj.endWidth = Mathf.Max(0f, profile.TrailEndWidth);
		obj.startColor = profile.TrailColor;
		obj.endColor = new Color(profile.TrailColor.r, profile.TrailColor.g, profile.TrailColor.b, 0f);
		obj.sortingOrder = spriteRenderer.sortingOrder - 1;
		ClearTrail();
	}

	private void ApplyProjectileSortingOrder()
	{
		if (!(spriteRenderer == null))
		{
			int sortingOrder = spriteRenderer.sortingOrder;
			int sortingLayerID = spriteRenderer.sortingLayerID;
			if (TryResolveBodySortAnchor(out var bodySortingOrder, out var sortingLayerId))
			{
				sortingOrder = bodySortingOrder + 2;
				sortingLayerID = sortingLayerId;
			}
			spriteRenderer.sortingLayerID = sortingLayerID;
			spriteRenderer.sortingOrder = sortingOrder;
		}
	}

	private bool TryResolveBodySortAnchor(out int bodySortingOrder, out int sortingLayerId)
	{
		if (TryResolveBodySortAnchorFromTransform(presentationSourceTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (weaponMountPoint != null && weaponMountPoint.VisualInstance != null)
		{
			Renderer componentInChildren = weaponMountPoint.VisualInstance.GetComponentInChildren<Renderer>(includeInactive: true);
			if (componentInChildren != null)
			{
				bodySortingOrder = componentInChildren.sortingOrder - 3;
				sortingLayerId = componentInChildren.sortingLayerID;
				return true;
			}
		}
		bodySortingOrder = 0;
		sortingLayerId = 0;
		return false;
	}

	private static bool TryResolveBodySortAnchorFromTransform(Transform anchor, out int bodySortingOrder, out int sortingLayerId)
	{
		Transform transform = anchor;
		while (transform != null)
		{
			Transform transform2 = transform.Find("BodyVisual");
			if (transform2 != null)
			{
				Renderer componentInChildren = transform2.GetComponentInChildren<Renderer>(includeInactive: true);
				if (componentInChildren != null)
				{
					bodySortingOrder = componentInChildren.sortingOrder;
					sortingLayerId = componentInChildren.sortingLayerID;
					return true;
				}
			}
			transform = transform.parent;
		}
		bodySortingOrder = 0;
		sortingLayerId = 0;
		return false;
	}

	private void ApplyProjectileSpineVisualOrThrow()
	{
		if (weaponDefinition == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Weapon definition is missing for projectile spine binding.");
		}
		string projectileSpineSkeletonDataPath = weaponDefinition.ProjectileSpineSkeletonDataPath;
		if (string.IsNullOrWhiteSpace(projectileSpineSkeletonDataPath))
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing projectile spine path. weapon=" + weaponDefinition.name);
		}
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow(projectileSpineSkeletonDataPath, "weapon=" + weaponDefinition.name + " field=projectileSpineSkeletonDataPath");
		if (spineVisualRoot == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] spineVisualRoot is missing.");
		}
		if (projectileSkeletonAnimation == null)
		{
			projectileSkeletonAnimation = spineVisualRoot.GetComponent<SkeletonAnimation>();
			if (projectileSkeletonAnimation == null)
			{
				projectileSkeletonAnimation = spineVisualRoot.gameObject.AddComponent<SkeletonAnimation>();
			}
		}
		projectileSkeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		projectileSkeletonAnimation.Initialize(overwrite: true);
		projectileSpineRenderer = projectileSkeletonAnimation.GetComponent<MeshRenderer>();
		if (projectileSpineRenderer == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing MeshRenderer on projectile spine visual.");
		}
		projectileSpineRenderer.sortingOrder = 30;
		Vector2 vector = ResolveProjectileSkeletonLocalBoundsSizeOrThrow(projectileSkeletonAnimation, weaponDefinition.name);
		float num = Mathf.Max(0.01f, weaponDefinition.ProjectileSpineScale);
		float x = Mathf.Max(0.01f, Mathf.Max(0.01f, presentationProfile.ProjectileSize.x) / vector.x * num);
		float y = Mathf.Max(0.01f, Mathf.Max(0.01f, presentationProfile.ProjectileSize.y) / vector.y * num);
		spineVisualRoot.localPosition = weaponDefinition.ProjectileSpineLocalOffset;
		spineVisualRoot.localRotation = ResolveProjectileSpineLocalRotation(weaponDefinition.ProjectileSpineLocalAngle);
		spineVisualRoot.localScale = new Vector3(x, y, 1f);
		string[] obj = new string[18]
		{
			"[SummerRace][ProjectileVisual] spine_apply weapon=", weaponDefinition.name, " path=", projectileSpineSkeletonDataPath, " localBounds=", null, null, null, null, null,
			null, null, null, null, null, null, null, null
		};
		Vector2 vector2 = vector;
		obj[5] = vector2.ToString();
		obj[6] = " desiredSize=";
		obj[7] = presentationProfile.ProjectileSize.ToString();
		obj[8] = " authoredScale=";
		obj[9] = num.ToString("F3");
		obj[10] = " finalScale=(";
		obj[11] = x.ToString("F3");
		obj[12] = ",";
		obj[13] = y.ToString("F3");
		obj[14] = ") localOffset=";
		obj[15] = weaponDefinition.ProjectileSpineLocalOffset.ToString();
		obj[16] = " localAngle=";
		obj[17] = weaponDefinition.ProjectileSpineLocalAngle.ToString("F2");
		TraceLog(string.Concat(obj));
		spineVisualRoot.gameObject.SetActive(value: true);
		PlayLoopAnimationOrThrow(projectileSkeletonAnimation, weaponDefinition.name, "projectile", weaponDefinition.ProjectileLoopAnimName);
		if (spriteRenderer != null)
		{
			spriteRenderer.enabled = false;
		}
	}

	private Quaternion ResolveProjectileSpineLocalRotation(float authoredZAngle)
	{
		Quaternion quaternion = Quaternion.Euler(0f, 0f, authoredZAngle);
		if (weaponKind == WeaponKind.Boomerang && sourceTeam == SummerRaceCombatTeam.Enemy)
		{
			return quaternion;
		}
		return quaternion * Quaternion.Euler(0f, 180f, 0f);
	}

	private bool ShouldIgnoreCollision(Collider2D other)
	{
		if (other == null)
		{
			return true;
		}
		VehicleSimpleProjectile componentInParent = other.GetComponentInParent<VehicleSimpleProjectile>();
		if (componentInParent != null && componentInParent != this)
		{
			return true;
		}
		if (sourceContext == null || sourceContext.CombatSourceTransform == null)
		{
			return false;
		}
		Transform combatSourceTransform = sourceContext.CombatSourceTransform;
		Transform transform = other.transform;
		if (transform == combatSourceTransform || transform.IsChildOf(combatSourceTransform))
		{
			return true;
		}
		MountPoint componentInParent2 = other.GetComponentInParent<MountPoint>();
		if (componentInParent2 != null && (componentInParent2.transform == combatSourceTransform || componentInParent2.transform.IsChildOf(combatSourceTransform)))
		{
			return true;
		}
		return false;
	}

	private static bool IsTargetInProjectileForwardHalfPlane(Vector2 projectileSpawnPoint, Vector2 projectileDirection, Transform targetTransform)
	{
		if (targetTransform == null)
		{
			return false;
		}
		return IsTargetInProjectileForwardHalfPlane(projectileSpawnPoint, projectileDirection, targetTransform.position);
	}

	private static bool IsTargetInProjectileForwardHalfPlane(Vector2 projectileSpawnPoint, Vector2 projectileDirection, Vector2 targetPosition)
	{
		if (projectileDirection.sqrMagnitude <= 0.0001f)
		{
			return true;
		}
		Vector2 vector = targetPosition - projectileSpawnPoint;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return true;
		}
		return Vector2.Dot(projectileDirection.normalized, vector.normalized) >= -0.01f;
	}

	private static float ResolveBoomerangOutwardDistanceLimit(float projectileSpeed, float projectileLifeDuration)
	{
		float num = Mathf.Max(0f, projectileSpeed);
		float num2 = Mathf.Max(0.05f, projectileLifeDuration);
		float num3 = num * num2;
		return Mathf.Max(1.2f, num3 * 0.48f);
	}

	private void StartBoomerangReturn()
	{
		if (boomerangReturnStarted)
		{
			return;
		}
		boomerangReturnStarted = true;
		TraceLog("[SummerRace][ProjectileVisual] boomerang return phase flag on. weapon=" + ((weaponDefinition != null) ? weaponDefinition.name : string.Empty));
		if (!returnPhaseEventSent)
		{
			returnPhaseEventSent = true;
			if (presentationContract.SupportsPhase(SummerRacePresentationPhase.ReturnStarted))
			{
				EmitProjectileEvent(SummerRacePresentationPhase.ReturnStarted, null, 0, 0);
				phaseCallback?.Invoke(this, SummerRacePresentationPhase.ReturnStarted);
			}
		}
	}

	private static Vector2 ResolveProjectileSkeletonLocalBoundsSizeOrThrow(SkeletonAnimation animation, string weaponName)
	{
		if (animation == null || animation.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing skeleton while resolving projectile bounds. weapon=" + weaponName);
		}
		Skeleton skeleton = animation.Skeleton;
		skeleton.UpdateWorldTransform();
		skeleton.GetBounds(out var _, out var _, out var width, out var height, ref ProjectileBoundsVertexBuffer);
		if (width <= 0.0001f || height <= 0.0001f)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Invalid projectile skeleton bounds. weapon=" + weaponName + " width=" + width.ToString("F6") + " height=" + height.ToString("F6"));
		}
		return new Vector2(width, height);
	}

	private void EmitImpactSpineIfConfigured(Vector2 hitDirection)
	{
		if (weaponDefinition == null)
		{
			return;
		}
		string impactSpineSkeletonDataPath = weaponDefinition.ImpactSpineSkeletonDataPath;
		if (!string.IsNullOrWhiteSpace(impactSpineSkeletonDataPath))
		{
			SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow(impactSpineSkeletonDataPath, "weapon=" + weaponDefinition.name + " field=impactSpineSkeletonDataPath");
			GameObject gameObject = new GameObject("ProjectileImpactSpine");
			gameObject.transform.position = base.transform.position;
			float num = ((hitDirection.sqrMagnitude > 0.0001f) ? (Mathf.Atan2(hitDirection.y, hitDirection.x) * 57.29578f) : 0f);
			gameObject.transform.rotation = Quaternion.Euler(0f, 0f, num + weaponDefinition.ImpactSpineLocalAngle);
			gameObject.transform.position += (Vector3)weaponDefinition.ImpactSpineLocalOffset;
			SkeletonAnimation skeletonAnimation = gameObject.AddComponent<SkeletonAnimation>();
			skeletonAnimation.skeletonDataAsset = skeletonDataAsset;
			skeletonAnimation.Initialize(overwrite: true);
			Vector2 vector = ResolveProjectileSkeletonLocalBoundsSizeOrThrow(skeletonAnimation, weaponDefinition.name + "_impact");
			float num2 = Mathf.Max(0.01f, weaponDefinition.ImpactSpineScale);
			float x = Mathf.Max(0.01f, Mathf.Max(0.01f, presentationProfile.ProjectileSize.x) / vector.x * num2);
			float y = Mathf.Max(0.01f, Mathf.Max(0.01f, presentationProfile.ProjectileSize.y) / vector.y * num2);
			gameObject.transform.localScale = new Vector3(x, y, 1f);
			MeshRenderer component = skeletonAnimation.GetComponent<MeshRenderer>();
			if (component != null)
			{
				component.sortingLayerID = ((projectileSpineRenderer != null) ? projectileSpineRenderer.sortingLayerID : ((spriteRenderer != null) ? spriteRenderer.sortingLayerID : component.sortingLayerID));
				component.sortingOrder = ((projectileSpineRenderer != null) ? (projectileSpineRenderer.sortingOrder + 2) : ((spriteRenderer != null) ? (spriteRenderer.sortingOrder + 2) : 321));
			}
			float num3 = PlayOneShotAnimationOrThrow(skeletonAnimation, weaponDefinition.name, "impact", weaponDefinition.ProjectileDespawnAnimName);
			UnityEngine.Object.Destroy(gameObject, Mathf.Max(0.05f, num3 + 0.03f));
		}
	}

	private bool TryBeginDespawnOnProjectileSpine(Vector2 hitDirection)
	{
		if (weaponDefinition == null || projectileSkeletonAnimation == null)
		{
			return false;
		}
		string projectileDespawnAnimName = weaponDefinition.ProjectileDespawnAnimName;
		if (string.IsNullOrWhiteSpace(projectileDespawnAnimName))
		{
			return false;
		}
		if (projectileSkeletonAnimation.Skeleton == null || projectileSkeletonAnimation.Skeleton.Data == null || projectileSkeletonAnimation.Skeleton.Data.FindAnimation(projectileDespawnAnimName) == null)
		{
			return false;
		}
		string impactSpineSkeletonDataPath = weaponDefinition.ImpactSpineSkeletonDataPath;
		if (!string.IsNullOrWhiteSpace(impactSpineSkeletonDataPath))
		{
			string projectileSpineSkeletonDataPath = weaponDefinition.ProjectileSpineSkeletonDataPath;
			string a = SummerRaceConfigLoader.NormalizeAssetRuntimePath(impactSpineSkeletonDataPath);
			string b = SummerRaceConfigLoader.NormalizeAssetRuntimePath(projectileSpineSkeletonDataPath);
			if (!string.Equals(a, b, StringComparison.Ordinal))
			{
				EmitImpactSpineIfConfigured(hitDirection);
			}
		}
		float z = ((hitDirection.sqrMagnitude > 0.0001f) ? (Mathf.Atan2(hitDirection.y, hitDirection.x) * 57.29578f) : 0f);
		base.transform.rotation = Quaternion.Euler(0f, 0f, z);
		float num = PlayOneShotAnimationOrThrow(projectileSkeletonAnimation, weaponDefinition.name, "projectile_despawn", weaponDefinition.ProjectileDespawnAnimName);
		string[] obj = new string[8]
		{
			"[SummerRace][ProjectileVisual] despawn_anim weapon=",
			weaponDefinition.name,
			" duration=",
			num.ToString("F3"),
			" hitDir=",
			null,
			null,
			null
		};
		Vector2 vector = hitDirection;
		obj[5] = vector.ToString();
		obj[6] = " pos=";
		obj[7] = base.transform.position.ToString();
		TraceLog(string.Concat(obj));
		despawning = true;
		despawnUntil = Time.time + Mathf.Max(0.05f, num + 0.03f);
		if (circleCollider != null)
		{
			circleCollider.enabled = false;
		}
		if (rb != null)
		{
			rb.velocity = Vector2.zero;
			rb.angularVelocity = 0f;
			rb.simulated = false;
		}
		ConfigureTrailEmission(enabled: false);
		return true;
	}

	private static void PlayLoopAnimationOrThrow(SkeletonAnimation animation, string weaponName, string role, string animationName)
	{
		if (animation == null || animation.AnimationState == null || animation.Skeleton == null || animation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing spine animation state for " + role + ". weapon=" + weaponName);
		}
		if (string.IsNullOrWhiteSpace(animationName))
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing " + role + " loop animation contract. weapon=" + weaponName);
		}
		Spine.Animation animation2 = animation.Skeleton.Data.FindAnimation(animationName);
		if (animation2 == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing " + role + " loop animation '" + animationName + "'. weapon=" + weaponName);
		}
		animation.AnimationState.SetAnimation(0, animation2.Name, loop: true);
	}

	private static float PlayOneShotAnimationOrThrow(SkeletonAnimation animation, string weaponName, string role, string animationName)
	{
		if (animation == null || animation.AnimationState == null || animation.Skeleton == null || animation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing spine animation state for " + role + ". weapon=" + weaponName);
		}
		if (string.IsNullOrWhiteSpace(animationName))
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing " + role + " despawn animation contract. weapon=" + weaponName);
		}
		Spine.Animation animation2 = animation.Skeleton.Data.FindAnimation(animationName);
		if (animation2 == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing " + role + " despawn animation '" + animationName + "'. weapon=" + weaponName);
		}
		animation.AnimationState.SetAnimation(0, animation2.Name, loop: false);
		return Mathf.Max(0.05f, animation2.Duration);
	}

	private void ApplyVisualDirection(Vector2 targetDirection, bool forceImmediate)
	{
		if (!(targetDirection.sqrMagnitude <= 0.0001f))
		{
			Vector2 normalized = targetDirection.normalized;
			if (forceImmediate || visualDirection.sqrMagnitude <= 0.0001f)
			{
				visualDirection = normalized;
			}
			else
			{
				float num = Mathf.Max(1f, presentationProfile.RotationLerp);
				visualDirection = Vector2.Lerp(visualDirection.normalized, normalized, Mathf.Clamp01(num * Time.fixedDeltaTime)).normalized;
			}
			if (Mathf.Abs(presentationProfile.ContinuousSpinDegreesPerSecond) > 0.001f)
			{
				visualSpinDegrees = Mathf.Repeat(visualSpinDegrees + presentationProfile.ContinuousSpinDegreesPerSecond * Time.fixedDeltaTime, 360f);
			}
			float num2 = (presentationProfile.FaceAlongVelocity ? (Mathf.Atan2(visualDirection.y, visualDirection.x) * 57.29578f) : 0f);
			num2 += visualSpinDegrees;
			base.transform.rotation = Quaternion.Euler(0f, 0f, num2);
		}
	}

	private TrailRenderer EnsureTrailRenderer()
	{
		if (trailRenderer != null)
		{
			return trailRenderer;
		}
		trailRenderer = GetComponent<TrailRenderer>();
		if (trailRenderer == null)
		{
			trailRenderer = base.gameObject.AddComponent<TrailRenderer>();
		}
		trailRenderer.alignment = LineAlignment.View;
		trailRenderer.textureMode = LineTextureMode.Stretch;
		trailRenderer.shadowCastingMode = ShadowCastingMode.Off;
		trailRenderer.receiveShadows = false;
		trailRenderer.numCapVertices = 2;
		trailRenderer.numCornerVertices = 2;
		trailRenderer.minVertexDistance = 0.02f;
		trailRenderer.sharedMaterial = GetTrailMaterial();
		return trailRenderer;
	}

	private void ConfigureTrailEmission(bool enabled)
	{
		TrailRenderer obj = EnsureTrailRenderer();
		obj.emitting = enabled;
		obj.enabled = enabled;
	}

	private void ClearTrail()
	{
		if (trailRenderer != null)
		{
			trailRenderer.Clear();
		}
	}

	private void ResetRigidbodyForSpawn(Vector2 spawnPosition)
	{
		if (!(rb == null))
		{
			RigidbodyInterpolation2D interpolation = rb.interpolation;
			rb.simulated = false;
			rb.interpolation = RigidbodyInterpolation2D.None;
			rb.position = spawnPosition;
			rb.velocity = Vector2.zero;
			rb.angularVelocity = 0f;
			base.transform.position = spawnPosition;
			rb.simulated = true;
			rb.interpolation = interpolation;
			TraceMachineGunSpawnState("reset_rigidbody_for_spawn_done");
		}
	}

	private static Material GetTrailMaterial()
	{
		if (cachedTrailMaterial != null)
		{
			return cachedTrailMaterial;
		}
		Shader shader = Shader.Find("Sprites/Default");
		if (shader == null)
		{
			throw new InvalidOperationException("[VehicleSimpleProjectile] Missing Sprites/Default shader for projectile trails.");
		}
		cachedTrailMaterial = new Material(shader)
		{
			name = "SummerRace_ProjectileTrailMaterial",
			hideFlags = HideFlags.DontSave
		};
		return cachedTrailMaterial;
	}

	private void EmitProjectileEventIfSupported(SummerRacePresentationPhase phase, ICombatStatusHost target, int appliedEffects, int damageDealt)
	{
		if (presentationContract.SupportsPhase(phase))
		{
			EmitProjectileEvent(phase, target, appliedEffects, damageDealt);
		}
	}

	private void EmitProjectileEvent(SummerRacePresentationPhase phase, ICombatStatusHost target, int appliedEffects, int damageDealt)
	{
		Transform transform = presentationSourceTransform;
		if (!(transform == null))
		{
			SummerRaceCombatPresentationRouter.PublishProjectile(transform, new SummerRaceProjectilePresentationEvent(phase, deliveryKind, weaponKind, GetInstanceID(), weaponSlotIndex, (rb != null) ? rb.position : ((Vector2)base.transform.position), (direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right, transform, base.transform, weaponMountPoint, weaponDefinition, target, appliedEffects, damageDealt));
		}
	}
}
