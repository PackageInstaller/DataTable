using System;
using System.Collections.Generic;
using System.Text;
using Spine;
using Spine.Unity;
using UnityEngine;

[DisallowMultipleComponent]
public class VehicleEquipSystem : MonoBehaviour
{
	private readonly struct EquipPresentationContext
	{
		public readonly bool IsValid;

		public readonly Vector2 SourcePoint;

		public readonly Vector2 TargetPoint;

		public readonly Transform TargetTransform;

		public readonly float ReachDistance;

		public readonly int TargetCount;

		public readonly float Radius;

		public readonly bool HasSelfTargetEffect;

		public bool HasAnyTarget
		{
			get
			{
				if (!HasSelfTargetEffect)
				{
					return TargetCount > 0;
				}
				return true;
			}
		}

		public EquipPresentationContext(Vector2 sourcePoint, Vector2 targetPoint, Transform targetTransform, float reachDistance, int targetCount, float radius, bool hasSelfTargetEffect)
		{
			IsValid = true;
			SourcePoint = sourcePoint;
			TargetPoint = targetPoint;
			TargetTransform = targetTransform;
			ReachDistance = reachDistance;
			TargetCount = targetCount;
			Radius = radius;
			HasSelfTargetEffect = hasSelfTargetEffect;
		}
	}

	private sealed class EquipRuntime
	{
		public MountPoint mount;

		public UtilityModuleDefinition def;

		public EquipRuntimeState state;

		public CombatEffectSpec[] effects;

		public bool activeWindowOpen;

		public Vector2 lastPresentationDirection;

		public EquipPresentationContext lastPresentationContext;

		public readonly HashSet<Transform> boxingGloveHitTransforms = new HashSet<Transform>();

		public BoxingGloveHitboxRuntime boxingGloveHitboxRuntime;
	}

	private sealed class BoxingGloveHitboxRuntime
	{
		public EquipRuntime slot;

		public Transform root;

		public CircleCollider2D collider;
	}

	private sealed class HookHitboxRuntime
	{
		public EquipRuntime slot;

		public Transform root;

		public BoxCollider2D collider;

		public bool active;

		public bool returning;

		public bool latched;

		public bool pullResolved;

		public bool pulling;

		public Vector2 launchPoint;

		public Vector2 currentPoint;

		public Vector2 travelDirection;

		public float travelSpeed;

		public float travelDistance;

		public float maxTravelDistance;

		public float pullStrength;

		public float latchAt;

		public float pullResolveAt;

		public float pullEndAt;

		public float pullBaseDeltaV;

		public HookPullMatrixOutcome pullMatrix;

		public ICombatStatusHost pullSourceHost;

		public ICombatStatusHost pullTargetHost;

		public Transform latchedTargetTransform;

		public ICombatStatusHost latchedTargetHost;

		public bool latchFreezeApplied;

		public ICombatStatusHost latchFreezeSourceHost;

		public ICombatStatusHost latchFreezeTargetHost;
	}

	private enum HookPullMatrixOutcome
	{
		SourceOnly,
		TargetOnly,
		Both
	}

	private const int BodyBand = 0;

	private const int WeaponEquipBand = 3;

	private const int MountedHostSortingOrder = 37;

	private const string BoxingGloveCenterSlotName = "quantao1";

	private static readonly Vector3 BoxingGloveHitboxDefaultLocalPosition = new Vector3(-3f, 0f, 0f);

	private static readonly Vector3 BoxingGloveHitboxDefaultLocalEulerAngles = new Vector3(0f, 180f, 0f);

	private const float BoxingGloveHitboxColliderRadius = 1f;

	private static readonly Vector2 BoxingGloveArcadeLiftDirection = new Vector2(1f, 0.38f);

	private const float BoxingGloveArcadeMinDeltaSpeed = 12.5f;

	private const float BoxingGloveArcadeBaseStrengthSpeedScale = 1.45f;

	private const float BoxingGloveArcadeApproachSpeedScale = 1.05f;

	private const float BoxingGloveArcadeApproachSpeedMaxBoost = 14f;

	private const float BoxingGloveArcadeHeavyMassBaseline = 4.8f;

	private const float BoxingGloveArcadeHeavyMassBonusScale = 0.95f;

	private const float BoxingGloveArcadeHeavyMassBonusMax = 7.5f;

	private const float BoxingGloveArcadeMinLaunchSpeed = 11f;

	private const float BoxingGloveArcadeMinLiftSpeed = 5.2f;

	private static readonly Vector2 HookHitboxDefaultLocalPosition = new Vector2(-1f, 0f);

	private static readonly Vector2 HookHitboxSize = new Vector2(1.65f, 1f);

	private const string HookPointRightName = "HookPointRight";

	private const float HookLatchDelaySeconds = 1f;

	private const float HookLatchFreezeDurationSeconds = 1f;

	private const float HookLatchVelocityDampSeconds = 1.08f;

	private const float HookPostPullDriveFreezeSeconds = 0.26f;

	private const float HookCollisionImpactSuppressPaddingSeconds = 1.4f;

	private const float HookPullForceDurationSeconds = 0.45f;

	private const float HookPullStartupDeltaVScale = 0.18f;

	private const float HookPullForceDeltaVScale = 1f;

	private const float HookPullForceMaxSpeed = 18f;

	private const float HookPullForceMinDistance = 0.65f;

	private const float HookPullSuppressionRefreshSeconds = 0.16f;

	private const float HookLatchedForwardVelocityLimit = 0.45f;

	private const float HookLatchedVerticalVelocityLimit = 1.2f;

	private const float HookLatchedAngularVelocityLimit = 70f;

	private const float HookMaxLifetimePaddingSeconds = 1.8f;

	private const float HookMinFlightSeconds = 0.24f;

	private const float HookReturnSpeedMin = 8f;

	private const float HookImpulseDistanceScale = 0.28f;

	private const float HookImpulseDistanceCap = 6f;

	private const float HookPullResolveDeltaVMin = 3.5f;

	private const float HookArcadeLightDeltaVMax = 24f;

	private const float HookArcadeUpwardBias = 0.08f;

	private const float HookArcadeForwardBias = 1.65f;

	private const float HookArcadeMinLaunchSpeed = 6.5f;

	private const float HookArcadeCounterVelocityCancelScale = 0.9f;

	private const string BoundaryNamePrefix = "Boundary";

	[Header("Refs")]
	[SerializeField]
	private VehicleAssembler assembler;

	[Header("Debug")]
	[SerializeField]
	private bool hookPresentationTraceLog;

	private readonly List<VehicleAssembler.InstalledModuleRecord> utilityRecords = new List<VehicleAssembler.InstalledModuleRecord>(8);

	private readonly List<EquipRuntime> equipSlots = new List<EquipRuntime>(8);

	private readonly List<ICombatStatusHost> resolveScratchTargets = new List<ICombatStatusHost>(8);

	private readonly List<ICombatStatusHost> impactTargets = new List<ICombatStatusHost>(8);

	private readonly HashSet<Transform> impactTargetTransforms = new HashSet<Transform>();

	private readonly Dictionary<Transform, Vector2> impactTargetContactPoints = new Dictionary<Transform, Vector2>(8);

	private readonly List<ICombatStatusHost> boxingGloveTickTargets = new List<ICombatStatusHost>(8);

	private readonly Dictionary<Transform, Vector2> boxingGloveTickContactPoints = new Dictionary<Transform, Vector2>(8);

	private readonly Dictionary<int, BoxingGloveHitboxRuntime> boxingGloveHitboxBySlot = new Dictionary<int, BoxingGloveHitboxRuntime>(2);

	private readonly Dictionary<int, HookHitboxRuntime> hookHitboxBySlot = new Dictionary<int, HookHitboxRuntime>(2);

	private readonly Collider2D[] boxingGloveOverlapBuffer = new Collider2D[32];

	private readonly Collider2D[] hookOverlapBuffer = new Collider2D[32];

	private ContactFilter2D boxingGloveOverlapFilter;

	private ContactFilter2D hookBoundaryOverlapFilter;

	private int characterLayer = -1;

	private IEquipOwnerContext ownerContext;

	private bool ShouldHookTraceLog
	{
		get
		{
			if (hookPresentationTraceLog)
			{
				return SummerRaceRuntimeLog.IsGameplayVerboseEnabled;
			}
			return false;
		}
	}

	public int EquipCount => equipSlots.Count;

	private void Awake()
	{
		if (assembler == null)
		{
			assembler = GetComponent<VehicleAssembler>();
		}
		characterLayer = LayerMask.NameToLayer("Character");
		if (characterLayer < 0)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] Layer 'Character' is required for boxing glove hitbox filtering.");
		}
		boxingGloveOverlapFilter = new ContactFilter2D
		{
			useLayerMask = true,
			layerMask = 1 << characterLayer,
			useTriggers = true
		};
		hookBoundaryOverlapFilter = new ContactFilter2D
		{
			useLayerMask = false,
			useTriggers = true
		};
	}

	private void OnEnable()
	{
		if (assembler != null)
		{
			assembler.OnAssemblyChanged += RefreshUtilities;
		}
		RefreshUtilities();
	}

	private void OnDisable()
	{
		if (assembler != null)
		{
			assembler.OnAssemblyChanged -= RefreshUtilities;
		}
		ClearBoxingGloveHitboxes();
		ClearHookHitboxes();
	}

	private void Update()
	{
		TickHookActiveWindows();
		TickActivePresentationWindows();
	}

	private void FixedUpdate()
	{
		TickBoxingGloveActiveWindows();
		TickHookContinuousPullForces();
	}

	public void SetAssembler(VehicleAssembler value)
	{
		assembler = value;
		RefreshUtilities();
	}

	public void SetOwnerContext(IEquipOwnerContext context)
	{
		ownerContext = context;
		if (ownerContext != null)
		{
			RefreshUtilities();
		}
	}

	public void ForceResetHookStates(string reason)
	{
		string text = (string.IsNullOrWhiteSpace(reason) ? "unspecified" : reason.Trim());
		for (int i = 0; i < equipSlots.Count; i++)
		{
			EquipRuntime equipRuntime = equipSlots[i];
			if (equipRuntime == null || equipRuntime.state == null || !IsHookEquip(equipRuntime))
			{
				continue;
			}
			bool flag = hookHitboxBySlot.TryGetValue(equipRuntime.state.SlotIndex, out var value) && value != null && (value.active || value.returning || value.latched || value.latchFreezeApplied);
			if (equipRuntime.activeWindowOpen || flag)
			{
				Vector2 vector = ResolveEquipSourcePoint(equipRuntime);
				Vector2 direction = (equipRuntime.lastPresentationDirection = ((equipRuntime.lastPresentationDirection.sqrMagnitude > 0.0001f) ? equipRuntime.lastPresentationDirection.normalized : ResolveEquipDirection(equipRuntime)));
				equipRuntime.lastPresentationContext = new EquipPresentationContext(vector, vector, null, 0.1f, 0, ResolveEquipPresentationRadius(equipRuntime, equipRuntime.effects), hasSelfTargetEffect: false);
				if (value != null)
				{
					value.currentPoint = vector;
					value.travelDistance = 0f;
					value.pullResolveAt = 0f;
					value.latchAt = 0f;
				}
				ForceCompleteHookSlot(equipRuntime, direction);
				if (ShouldHookTraceLog)
				{
					SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][ForceReset] slot=" + equipRuntime.state.SlotIndex + " reason=" + text + " source=" + vector.ToString("F4"));
				}
			}
		}
	}

	public void RefreshUtilities()
	{
		ClearBoxingGloveHitboxes();
		ClearHookHitboxes();
		equipSlots.Clear();
		if (assembler == null)
		{
			return;
		}
		assembler.GetInstalledUtilities(utilityRecords);
		ISummerRaceCombatPayloadOverrideProvider summerRaceCombatPayloadOverrideProvider = ownerContext as ISummerRaceCombatPayloadOverrideProvider;
		for (int i = 0; i < utilityRecords.Count; i++)
		{
			VehicleAssembler.InstalledModuleRecord installedModuleRecord = utilityRecords[i];
			if (!(installedModuleRecord.mountPoint == null) && installedModuleRecord.module is UtilityModuleDefinition def)
			{
				equipSlots.Add(new EquipRuntime
				{
					mount = installedModuleRecord.mountPoint,
					def = def,
					state = new EquipRuntimeState
					{
						SlotIndex = equipSlots.Count,
						CooldownUntil = 0f,
						ActiveUntil = 0f
					},
					effects = ((summerRaceCombatPayloadOverrideProvider != null) ? summerRaceCombatPayloadOverrideProvider.CreateEquipEffects(def) : SummerRaceCombatEffectFactory.CreateEquipEffects(def))
				});
				ApplyMountVisualSortingOrder(installedModuleRecord.mountPoint, ResolveWeaponEquipSortingOrderOrFallback());
				EnsureBoxingGloveHitboxRuntimeForSlot(equipSlots[equipSlots.Count - 1]);
				EnsureHookHitboxRuntimeForSlot(equipSlots[equipSlots.Count - 1]);
				EquipRuntime equipRuntime = equipSlots[equipSlots.Count - 1];
				if (IsHookEquip(equipRuntime))
				{
					Vector2 vector = ResolveEquipSourcePoint(equipRuntime);
					EmitEquipEvent(equipRuntime, SummerRacePresentationPhase.ActiveExpired, ResolveEquipDirection(equipRuntime), string.Empty, 0f, vector, vector, null, 0f, ResolveEquipPresentationRadius(equipRuntime, equipRuntime.effects), 0);
				}
			}
		}
	}

	private int ResolveWeaponEquipSortingOrderOrFallback()
	{
		if (TryResolveBodySortingOrder(out var bodySortingOrder))
		{
			return bodySortingOrder + 3;
		}
		return 37;
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

	public bool IsSlotValid(int slotIndex)
	{
		if (slotIndex >= 0)
		{
			return slotIndex < equipSlots.Count;
		}
		return false;
	}

	public bool IsSlotReady(int slotIndex)
	{
		if (!IsSlotValid(slotIndex))
		{
			return false;
		}
		return Time.time >= equipSlots[slotIndex].state.CooldownUntil;
	}

	public float GetSlotCooldownRemaining(int slotIndex)
	{
		if (!IsSlotValid(slotIndex))
		{
			return 0f;
		}
		return Mathf.Max(0f, equipSlots[slotIndex].state.CooldownUntil - Time.time);
	}

	public bool CanActivateSlot(int slotIndex, Vector2 aimDirection, out string rejectReason)
	{
		rejectReason = string.Empty;
		if (!IsSlotValid(slotIndex))
		{
			rejectReason = "invalid_slot";
			return false;
		}
		if (ownerContext == null)
		{
			rejectReason = "owner_missing";
			return false;
		}
		if (!ownerContext.CanActivateEquip())
		{
			rejectReason = "blocked_state";
			return false;
		}
		EquipRuntime equipRuntime = equipSlots[slotIndex];
		if (equipRuntime == null || equipRuntime.def == null || equipRuntime.state == null)
		{
			rejectReason = "runtime_incomplete";
			return false;
		}
		if (Time.time < equipRuntime.state.CooldownUntil)
		{
			rejectReason = "cooldown";
			return false;
		}
		if ((equipRuntime.effects ?? Array.Empty<CombatEffectSpec>()).Length == 0)
		{
			rejectReason = "empty_effects";
			return false;
		}
		float amount = Mathf.Max(0f, equipRuntime.def.EnergyCost);
		if (!ownerContext.CanSpendEquipEnergy(amount))
		{
			rejectReason = "energy";
			return false;
		}
		return true;
	}

	public bool TryGetRuntimeSnapshot(int slotIndex, out EquipRuntimeSnapshot snapshot)
	{
		snapshot = default(EquipRuntimeSnapshot);
		if (!IsSlotValid(slotIndex))
		{
			return false;
		}
		EquipRuntimeState state = equipSlots[slotIndex].state;
		UtilityModuleDefinition def = equipSlots[slotIndex].def;
		CombatEffectSpec[] effects = equipSlots[slotIndex].effects ?? Array.Empty<CombatEffectSpec>();
		snapshot = new EquipRuntimeSnapshot(state.SlotIndex, Time.time >= state.CooldownUntil, Mathf.Max(0f, state.CooldownUntil - Time.time), Mathf.Max(0f, state.ActiveUntil - Time.time), (def != null) ? Mathf.Max(0.02f, def.Cooldown) : 0f, ResolveActiveDuration(effects), (def != null) ? Mathf.Max(0f, def.EnergyCost) : 0f, (def != null) ? def.DisplayName : string.Empty);
		return true;
	}

	public CombatExecutionResult TryActivateSlot(int slotIndex, Vector2 aimDirection)
	{
		if (!CanActivateSlot(slotIndex, aimDirection, out var rejectReason))
		{
			EmitEquipRejected(slotIndex, aimDirection, rejectReason);
			if (IsSlotValid(slotIndex))
			{
				EquipRuntime equipRuntime = equipSlots[slotIndex];
				if (equipRuntime != null && equipRuntime.state != null)
				{
					equipRuntime.state.LastRejectReason = rejectReason;
				}
			}
			return CombatExecutionResult.Failed("Equip activation rejected: " + rejectReason);
		}
		EquipRuntime equipRuntime2 = equipSlots[slotIndex];
		CombatEffectSpec[] effects = equipRuntime2.effects ?? Array.Empty<CombatEffectSpec>();
		float amount = Mathf.Max(0f, equipRuntime2.def.EnergyCost);
		Vector2 vector = ((aimDirection.sqrMagnitude > 0.0001f) ? aimDirection.normalized : ((Vector2)ownerContext.CombatSourceTransform.right));
		bool flag = IsBoxingGloveEquip(equipRuntime2);
		bool flag2 = IsHookEquip(equipRuntime2);
		if (flag2)
		{
			Vector2 vector2 = ResolveEquipDirection(equipRuntime2);
			vector = ((vector2.sqrMagnitude > 0.0001f) ? vector2.normalized : Vector2.right);
		}
		EquipPresentationContext presentationContext;
		if (flag2)
		{
			Vector2 vector3 = ResolveEquipSourcePoint(equipRuntime2);
			float num = ResolveEquipPresentationRadius(equipRuntime2, effects);
			Vector2 vector4 = vector3 + vector * Mathf.Max(0.05f, num);
			presentationContext = new EquipPresentationContext(vector3, vector4, null, Mathf.Max(0.1f, Vector2.Distance(vector3, vector4)), 0, num, hasSelfTargetEffect: false);
		}
		else
		{
			presentationContext = ResolveEquipPresentationContext(equipRuntime2, vector, effects, impactTargets, impactTargetTransforms, impactTargetContactPoints);
		}
		CombatExecutionResult result = (flag2 ? (TryActivateHookSlot(equipRuntime2, vector, effects, ref presentationContext, out var rejectReason2) ? CombatExecutionResult.Succeeded(0, 0) : CombatExecutionResult.Failed(rejectReason2)) : ((!flag) ? (CanReuseResolvedTargetsForEffects(effects) ? SummerRaceCombatEffectExecutor.Shared.ExecuteResolvedEffects(ownerContext, vector, effects, impactTargets) : SummerRaceCombatEffectExecutor.Shared.ExecuteEffects(ownerContext, vector, effects)) : CombatExecutionResult.Succeeded(0, 0)));
		if (!result.Success)
		{
			equipRuntime2.state.LastRejectReason = result.FailureReason;
			EmitEquipRejected(slotIndex, vector, result.FailureReason);
			SummerRaceRuntimeLog.Verbose("[SummerRace][EquipSystem] execute_failed slot=" + slotIndex + " reason=" + (result.FailureReason ?? string.Empty) + " effects=" + BuildEffectSummary(effects));
			return result;
		}
		ownerContext.SpendEquipEnergy(amount);
		equipRuntime2.state.CooldownUntil = Time.time + Mathf.Max(0.02f, equipRuntime2.def.Cooldown);
		equipRuntime2.state.ActiveUntil = ResolveRuntimeActiveUntil(equipRuntime2, effects);
		equipRuntime2.activeWindowOpen = equipRuntime2.state.ActiveUntil > Time.time;
		equipRuntime2.lastPresentationDirection = vector;
		equipRuntime2.lastPresentationContext = presentationContext;
		equipRuntime2.boxingGloveHitTransforms.Clear();
		equipRuntime2.state.LastRejectReason = string.Empty;
		EmitEquipActivated(equipRuntime2, vector, presentationContext);
		EmitEquipTravelPhaseStart(equipRuntime2, vector, presentationContext);
		float activeDuration = ((equipRuntime2 != null && equipRuntime2.state != null) ? Mathf.Max(0f, equipRuntime2.state.ActiveUntil - Time.time) : 0f);
		if (flag)
		{
			TickBoxingGloveSlot(equipRuntime2, vector);
		}
		else if (!flag2)
		{
			EmitEquipImpacts(equipRuntime2, vector, presentationContext, impactTargets, impactTargetContactPoints, activeDuration);
			EmitEquipTravelPhaseEnd(equipRuntime2, vector, presentationContext);
		}
		return result;
	}

	private void TickActivePresentationWindows()
	{
		for (int i = 0; i < equipSlots.Count; i++)
		{
			EquipRuntime equipRuntime = equipSlots[i];
			if (equipRuntime == null || !equipRuntime.activeWindowOpen || Time.time < equipRuntime.state.ActiveUntil)
			{
				continue;
			}
			if (IsHookEquip(equipRuntime))
			{
				ForceCompleteHookSlot(equipRuntime, equipRuntime.lastPresentationDirection);
				continue;
			}
			equipRuntime.activeWindowOpen = false;
			EquipPresentationContext lastPresentationContext = equipRuntime.lastPresentationContext;
			if (IsBoxingGloveEquip(equipRuntime))
			{
				EmitEquipTravelPhaseEnd(equipRuntime, equipRuntime.lastPresentationDirection, lastPresentationContext);
				equipRuntime.boxingGloveHitTransforms.Clear();
			}
			float num = ((lastPresentationContext.Radius > 0f) ? lastPresentationContext.Radius : ResolveEquipPresentationRadius(equipRuntime, equipRuntime?.effects));
			Vector2 vector = (lastPresentationContext.IsValid ? lastPresentationContext.SourcePoint : ResolveEquipSourcePoint(equipRuntime));
			Vector2 direction = ((equipRuntime.lastPresentationDirection.sqrMagnitude > 0.0001f) ? equipRuntime.lastPresentationDirection.normalized : ResolveEquipDirection(equipRuntime));
			EmitEquipEvent(equipRuntime, SummerRacePresentationPhase.ActiveExpired, direction, string.Empty, 0f, vector, lastPresentationContext.IsValid ? lastPresentationContext.TargetPoint : vector, lastPresentationContext.TargetTransform, (lastPresentationContext.ReachDistance > 0f) ? lastPresentationContext.ReachDistance : num, num, lastPresentationContext.TargetCount);
		}
	}

	private void TickBoxingGloveActiveWindows()
	{
		if (ownerContext == null || equipSlots.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < equipSlots.Count; i++)
		{
			EquipRuntime equipRuntime = equipSlots[i];
			if (equipRuntime != null && equipRuntime.activeWindowOpen && IsBoxingGloveEquip(equipRuntime) && !(Time.time >= equipRuntime.state.ActiveUntil))
			{
				Vector2 direction = ((equipRuntime.lastPresentationDirection.sqrMagnitude > 0.0001f) ? equipRuntime.lastPresentationDirection.normalized : ResolveEquipDirection(equipRuntime));
				TickBoxingGloveSlot(equipRuntime, direction);
			}
		}
	}

	private void TickHookActiveWindows()
	{
		if (ownerContext == null || hookHitboxBySlot.Count <= 0)
		{
			return;
		}
		float time = Time.time;
		for (int i = 0; i < equipSlots.Count; i++)
		{
			EquipRuntime equipRuntime = equipSlots[i];
			if (!IsHookEquip(equipRuntime) || equipRuntime == null || equipRuntime.state == null || !hookHitboxBySlot.TryGetValue(equipRuntime.state.SlotIndex, out var value) || value == null || value.root == null || value.collider == null || !value.active)
			{
				continue;
			}
			Vector2 vector = ResolveEquipSourcePoint(equipRuntime);
			equipRuntime.lastPresentationDirection = ((value.travelDirection.sqrMagnitude > 0.0001f) ? value.travelDirection : equipRuntime.lastPresentationDirection);
			if (value.returning)
			{
				float num = Mathf.Max(8f, value.travelSpeed) * Mathf.Max(0.0001f, Time.deltaTime);
				Vector2 vector2 = vector - value.currentPoint;
				float magnitude = vector2.magnitude;
				if (magnitude <= num)
				{
					ForceCompleteHookSlot(equipRuntime, equipRuntime.lastPresentationDirection);
					continue;
				}
				value.currentPoint += vector2 / magnitude * num;
				equipRuntime.lastPresentationContext = new EquipPresentationContext(vector, value.currentPoint, null, Mathf.Max(0.1f, Vector2.Distance(vector, value.currentPoint)), 0, ResolveEquipPresentationRadius(equipRuntime, equipRuntime.effects), hasSelfTargetEffect: false);
				continue;
			}
			if (value.latched)
			{
				if (!IsCombatHostAlive(value.latchedTargetHost) || value.latchedTargetTransform == null)
				{
					value.latched = false;
					value.returning = true;
					ResetHookPullRuntimeState(value);
					ReleaseHookLatchFreeze(value, "target_invalid_or_dead");
					EmitEquipTravelPhaseEnd(equipRuntime, equipRuntime.lastPresentationDirection, equipRuntime.lastPresentationContext);
					continue;
				}
				if (value.pulling)
				{
					RefreshHookPullSuppression(value);
				}
				else
				{
					ApplyHookLatchMotionGate(value);
				}
				value.currentPoint = value.latchedTargetTransform.position;
				equipRuntime.lastPresentationContext = new EquipPresentationContext(vector, value.currentPoint, value.latchedTargetTransform, Mathf.Max(0.1f, Vector2.Distance(vector, value.currentPoint)), 1, ResolveEquipPresentationRadius(equipRuntime, equipRuntime.effects), hasSelfTargetEffect: false);
				if (!value.pullResolved && time >= value.pullResolveAt)
				{
					ResolveHookLatchedPull(equipRuntime, value, vector);
					value.pullResolved = true;
					if (!value.pulling)
					{
						value.latched = false;
						value.returning = true;
						ReleaseHookLatchFreeze(value, "pull_resolve_failed");
						EmitEquipTravelPhaseEnd(equipRuntime, equipRuntime.lastPresentationDirection, equipRuntime.lastPresentationContext);
					}
				}
				continue;
			}
			float num2 = Mathf.Max(0.01f, value.travelSpeed) * Mathf.Max(0.0001f, Time.deltaTime);
			value.currentPoint += value.travelDirection * num2;
			value.travelDistance += num2;
			equipRuntime.lastPresentationContext = new EquipPresentationContext(vector, value.currentPoint, null, Mathf.Max(0.1f, Vector2.Distance(vector, value.currentPoint)), 0, ResolveEquipPresentationRadius(equipRuntime, equipRuntime.effects), hasSelfTargetEffect: false);
			EmitHookTravelTick(equipRuntime);
			SyncHookHitboxPose(value, value.currentPoint, value.travelDirection);
			Physics2D.SyncTransforms();
			ICombatStatusHost hitHost;
			Transform hitTransform;
			Vector2 hitPoint;
			if (TryResolveHookBoundaryHit(value, out var boundaryCollider))
			{
				value.returning = true;
				value.collider.enabled = false;
				EmitEquipTravelPhaseEnd(equipRuntime, equipRuntime.lastPresentationDirection, equipRuntime.lastPresentationContext);
				if (ShouldHookTraceLog)
				{
					SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][BoundaryHit] slot=" + equipRuntime.state.SlotIndex + " collider=" + ((boundaryCollider != null) ? boundaryCollider.name : "<null>") + " point=" + value.currentPoint.ToString("F4"));
				}
			}
			else if (TryResolveHookHit(value, out hitHost, out hitTransform, out hitPoint))
			{
				value.latched = true;
				value.latchAt = time;
				value.pullResolveAt = time + 1f;
				value.latchedTargetHost = hitHost;
				value.latchedTargetTransform = hitTransform;
				ApplyHookLatchFreeze(value, equipRuntime.lastPresentationDirection);
				value.currentPoint = hitPoint;
				value.collider.enabled = false;
				impactTargetContactPoints.Clear();
				if (hitTransform != null)
				{
					impactTargetContactPoints[hitTransform] = hitPoint;
				}
				SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][LatchHit] slot=" + equipRuntime.state.SlotIndex + " target=" + ((hitHost != null && hitHost.CombatTransform != null) ? hitHost.CombatTransform.name : "<null>") + " now=" + time.ToString("F4") + " pullResolveAt=" + value.pullResolveAt.ToString("F4") + " pullStrength=" + value.pullStrength.ToString("F4") + " activeUntil=" + equipRuntime.state.ActiveUntil.ToString("F4") + " hitPoint=" + hitPoint.ToString("F4") + " sourcePoint=" + vector.ToString("F4"));
				equipRuntime.lastPresentationContext = new EquipPresentationContext(vector, hitPoint, hitTransform, Mathf.Max(0.1f, Vector2.Distance(vector, hitPoint)), 1, ResolveEquipPresentationRadius(equipRuntime, equipRuntime.effects), hasSelfTargetEffect: false);
				EmitEquipImpacts(equipRuntime, equipRuntime.lastPresentationDirection, equipRuntime.lastPresentationContext, BuildSingleTargetBuffer(hitHost), impactTargetContactPoints, Mathf.Max(0f, equipRuntime.state.ActiveUntil - time));
			}
			else if (value.travelDistance >= value.maxTravelDistance || time >= equipRuntime.state.ActiveUntil)
			{
				value.returning = true;
				EmitEquipTravelPhaseEnd(equipRuntime, equipRuntime.lastPresentationDirection, equipRuntime.lastPresentationContext);
			}
		}
	}

	private void TickBoxingGloveSlot(EquipRuntime slot, Vector2 direction)
	{
		if (slot == null || ownerContext == null || !IsBoxingGloveEquip(slot))
		{
			return;
		}
		CombatEffectSpec[] effects = slot.effects ?? Array.Empty<CombatEffectSpec>();
		Vector2 vector = ResolveEquipSourcePoint(slot);
		float num = ResolveEquipPresentationRadius(slot, effects);
		bool hasSelfTargetEffect = false;
		ResolveEquipTargetsFromHitbox(slot, vector, effects, impactTargets, impactTargetTransforms, impactTargetContactPoints, ref hasSelfTargetEffect);
		Transform transform = null;
		Vector2 vector2 = vector;
		if (impactTargets.Count > 0)
		{
			ICombatStatusHost combatStatusHost = impactTargets[0];
			if (combatStatusHost != null)
			{
				transform = combatStatusHost.CombatTransform;
				if (transform != null && impactTargetContactPoints.TryGetValue(transform, out var value))
				{
					vector2 = value;
				}
				else if (transform != null)
				{
					vector2 = transform.position;
				}
			}
		}
		slot.lastPresentationDirection = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : ResolveEquipDirection(slot));
		slot.lastPresentationContext = new EquipPresentationContext(vector, vector2, transform, Mathf.Max(num, Vector2.Distance(vector, vector2)), impactTargets.Count, num, hasSelfTargetEffect);
		if (impactTargets.Count <= 0)
		{
			return;
		}
		boxingGloveTickTargets.Clear();
		boxingGloveTickContactPoints.Clear();
		for (int i = 0; i < impactTargets.Count; i++)
		{
			ICombatStatusHost combatStatusHost2 = impactTargets[i];
			if (combatStatusHost2 == null)
			{
				continue;
			}
			Transform combatTransform = combatStatusHost2.CombatTransform;
			if (!(combatTransform != null) || !slot.boxingGloveHitTransforms.Contains(combatTransform))
			{
				boxingGloveTickTargets.Add(combatStatusHost2);
				if (combatTransform != null && impactTargetContactPoints.TryGetValue(combatTransform, out var value2))
				{
					boxingGloveTickContactPoints[combatTransform] = value2;
				}
			}
		}
		if (boxingGloveTickTargets.Count <= 0 || !ExecuteBoxingGloveEffects(slot.lastPresentationDirection, effects, boxingGloveTickTargets, boxingGloveTickContactPoints, vector).Success)
		{
			return;
		}
		for (int j = 0; j < boxingGloveTickTargets.Count; j++)
		{
			Transform transform2 = boxingGloveTickTargets[j]?.CombatTransform;
			if (transform2 != null)
			{
				slot.boxingGloveHitTransforms.Add(transform2);
			}
		}
		EmitEquipImpacts(slot, slot.lastPresentationDirection, slot.lastPresentationContext, boxingGloveTickTargets, boxingGloveTickContactPoints, Mathf.Max(0f, (slot.state != null) ? (slot.state.ActiveUntil - Time.time) : 0f));
	}

	private bool TryActivateHookSlot(EquipRuntime slot, Vector2 direction, CombatEffectSpec[] effects, ref EquipPresentationContext presentationContext, out string rejectReason)
	{
		rejectReason = string.Empty;
		if (slot == null || slot.state == null)
		{
			rejectReason = "hook_runtime_incomplete";
			return false;
		}
		if (!TryEnsureHookHitboxRuntime(slot, out var runtime) || runtime == null)
		{
			rejectReason = "hook_hitbox_missing";
			return false;
		}
		Vector2 vector = ResolveEquipSourcePoint(slot);
		Vector2 vector2 = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : ResolveEquipDirection(slot));
		float num = ResolveEquipPresentationRadius(slot, effects);
		float num2 = Mathf.Max(0.8f, num);
		float b = Mathf.Max(0.24f, (slot.def != null) ? Mathf.Max(0f, slot.def.Duration) : 0f);
		float travelSpeed = Mathf.Max(1f, num2 / Mathf.Max(0.02f, b));
		runtime.slot = slot;
		runtime.active = true;
		runtime.returning = false;
		runtime.latched = false;
		runtime.pullResolved = false;
		ResetHookPullRuntimeState(runtime);
		runtime.launchPoint = vector;
		runtime.currentPoint = vector;
		runtime.travelDirection = vector2;
		runtime.travelSpeed = travelSpeed;
		runtime.travelDistance = 0f;
		runtime.maxTravelDistance = num2;
		runtime.pullStrength = ResolveHookPullStrength(effects, slot);
		runtime.latchAt = 0f;
		runtime.pullResolveAt = 0f;
		runtime.latchedTargetTransform = null;
		runtime.latchedTargetHost = null;
		runtime.collider.enabled = true;
		SyncHookHitboxPose(runtime, vector, vector2);
		Vector2 vector3 = vector + vector2 * 0.1f;
		presentationContext = new EquipPresentationContext(vector, vector3, runtime.root, Mathf.Max(0.1f, Vector2.Distance(vector, vector3)), 0, num, hasSelfTargetEffect: false);
		slot.lastPresentationContext = presentationContext;
		slot.lastPresentationDirection = vector2;
		return true;
	}

	private void ForceCompleteHookSlot(EquipRuntime slot, Vector2 direction)
	{
		if (slot == null || slot.state == null || !IsHookEquip(slot))
		{
			return;
		}
		if (hookHitboxBySlot.TryGetValue(slot.state.SlotIndex, out var value) && value != null)
		{
			ReleaseHookLatchFreeze(value, "force_complete");
			value.active = false;
			value.returning = false;
			value.latched = false;
			value.pullResolved = false;
			ResetHookPullRuntimeState(value);
			value.latchedTargetHost = null;
			value.latchedTargetTransform = null;
			if (value.collider != null)
			{
				value.collider.enabled = false;
			}
		}
		slot.activeWindowOpen = false;
		EmitEquipEvent(slot, SummerRacePresentationPhase.ActiveExpired, direction, string.Empty, 0f, slot.lastPresentationContext.SourcePoint, slot.lastPresentationContext.TargetPoint, slot.lastPresentationContext.TargetTransform, slot.lastPresentationContext.ReachDistance, slot.lastPresentationContext.Radius, slot.lastPresentationContext.TargetCount);
	}

	private void ResolveHookLatchedPull(EquipRuntime slot, HookHitboxRuntime runtime, Vector2 sourcePoint)
	{
		if (runtime == null)
		{
			return;
		}
		if (!IsCombatHostAlive(runtime.latchedTargetHost))
		{
			string text = ((slot != null && slot.state != null) ? slot.state.SlotIndex.ToString() : "<null>");
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][PullResolveSkip] slot=" + text + " reason=target_missing_or_dead");
			return;
		}
		Rigidbody2D rigidbody2D = ((ownerContext != null) ? ownerContext.CombatSourceRigidbody : null);
		Rigidbody2D combatRigidbody = runtime.latchedTargetHost.CombatRigidbody;
		if (rigidbody2D == null || combatRigidbody == null)
		{
			string text2 = ((slot != null && slot.state != null) ? slot.state.SlotIndex.ToString() : "<null>");
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][PullResolveSkip] slot=" + text2 + " reason=body_missing sourceBody=" + (rigidbody2D != null) + " targetBody=" + (combatRigidbody != null));
			return;
		}
		float num = Mathf.Max(0.1f, rigidbody2D.mass);
		float num2 = Mathf.Max(0.1f, combatRigidbody.mass);
		Vector2 currentPoint = runtime.currentPoint;
		Vector2 worldCenterOfMass = rigidbody2D.worldCenterOfMass;
		Vector2 worldCenterOfMass2 = combatRigidbody.worldCenterOfMass;
		Vector2 vector = worldCenterOfMass2 - worldCenterOfMass;
		Vector2 vector2 = ((slot != null && slot.lastPresentationDirection.sqrMagnitude > 0.0001f) ? slot.lastPresentationDirection.normalized : Vector2.right);
		Vector2 vector3 = ((vector.sqrMagnitude > 0.0001f) ? vector.normalized : vector2);
		float magnitude = vector.magnitude;
		float b = Mathf.Max(0f, runtime.pullStrength) + Mathf.Min(6f, magnitude) * 0.28f;
		float num3 = Mathf.Max(3.5f, b);
		ICombatStatusHost combatStatusHost = ownerContext as ICombatStatusHost;
		if (combatStatusHost == null && ownerContext != null && ownerContext.CombatSourceTransform != null)
		{
			combatStatusHost = ownerContext.CombatSourceTransform.GetComponentInParent<ICombatStatusHost>();
		}
		SummerRaceBodyType sourceBodyType = combatStatusHost?.CombatBodyType ?? SummerRaceBodyType.Medium;
		SummerRaceBodyType combatBodyType = runtime.latchedTargetHost.CombatBodyType;
		HookPullMatrixOutcome hookPullMatrixOutcome = ResolveHookPullMatrixOutcome(sourceBodyType, combatBodyType);
		bool flag = hookPullMatrixOutcome == HookPullMatrixOutcome.SourceOnly || hookPullMatrixOutcome == HookPullMatrixOutcome.Both;
		bool flag2 = hookPullMatrixOutcome == HookPullMatrixOutcome.TargetOnly || hookPullMatrixOutcome == HookPullMatrixOutcome.Both;
		ClearHostHookMotionSuppression(combatStatusHost);
		ClearHostHookMotionSuppression(runtime.latchedTargetHost);
		float desiredDeltaV = 0f;
		float desiredDeltaV2 = 0f;
		float impulseMagnitude = 0f;
		float impulseMagnitude2 = 0f;
		Vector2 launchDir = Vector2.zero;
		Vector2 launchDir2 = Vector2.zero;
		Vector2 launchImpulse = Vector2.zero;
		Vector2 launchImpulse2 = Vector2.zero;
		runtime.pulling = true;
		runtime.pullEndAt = Time.time + Mathf.Max(0.01f, 0.45f);
		runtime.pullBaseDeltaV = num3;
		runtime.pullMatrix = hookPullMatrixOutcome;
		runtime.pullSourceHost = combatStatusHost;
		runtime.pullTargetHost = runtime.latchedTargetHost;
		if (flag)
		{
			ApplyHookPullStartupImpulse(rigidbody2D, combatRigidbody, vector3, num3, out desiredDeltaV, out impulseMagnitude, out launchDir, out launchImpulse);
		}
		if (flag2)
		{
			ApplyHookPullStartupImpulse(combatRigidbody, rigidbody2D, -vector3, num3, out desiredDeltaV2, out impulseMagnitude2, out launchDir2, out launchImpulse2);
		}
		ApplyHookPostPullDriveFreeze(combatStatusHost, runtime.latchedTargetHost);
		RefreshHookPullSuppression(runtime);
		SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][PullResolveSummary] slot=" + ((slot != null && slot.state != null) ? slot.state.SlotIndex.ToString() : "<null>") + " sourceBodyType=" + sourceBodyType.ToString() + " targetBodyType=" + combatBodyType.ToString() + " matrix=" + hookPullMatrixOutcome.ToString() + " configuredDeltaV=" + b.ToString("F4") + " baseDeltaV=" + num3.ToString("F4") + " sourceApply=" + flag + " sourceLaunchDir=" + launchDir.ToString("F4") + " sourceImpulse=" + launchImpulse.ToString("F4") + " targetApply=" + flag2 + " targetLaunchDir=" + launchDir2.ToString("F4") + " targetImpulse=" + launchImpulse2.ToString("F4") + " sourcePos=" + worldCenterOfMass.ToString("F4") + " targetPos=" + worldCenterOfMass2.ToString("F4") + " pullDuration=" + 0.45f.ToString("F3"));
		if (ShouldHookTraceLog)
		{
			string[] obj = new string[48]
			{
				"[SummerRace][HookTrace][PullResolve] slot=",
				slot.state.SlotIndex.ToString(),
				" sourceBodyType=",
				sourceBodyType.ToString(),
				" targetBodyType=",
				combatBodyType.ToString(),
				" matrix=",
				hookPullMatrixOutcome.ToString(),
				" sourcePoint=",
				sourcePoint.ToString("F4"),
				" runtimePoint=",
				currentPoint.ToString("F4"),
				" sourceBodyPoint=",
				worldCenterOfMass.ToString("F4"),
				" targetBodyPoint=",
				worldCenterOfMass2.ToString("F4"),
				" sourceMass=",
				num.ToString("F3"),
				" targetMass=",
				num2.ToString("F3"),
				" distance=",
				magnitude.ToString("F3"),
				" baseDeltaV=",
				num3.ToString("F3"),
				" sourceApply=",
				flag.ToString(),
				" sourceDesiredDeltaV=",
				desiredDeltaV.ToString("F3"),
				" sourceImpulseMag=",
				impulseMagnitude.ToString("F3"),
				" sourceLaunchDir=",
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
			Vector2 vector4 = launchDir;
			obj[31] = vector4.ToString();
			obj[32] = " sourceLaunchImpulse=";
			vector4 = launchImpulse;
			obj[33] = vector4.ToString();
			obj[34] = " targetApply=";
			obj[35] = flag2.ToString();
			obj[36] = " targetDesiredDeltaV=";
			obj[37] = desiredDeltaV2.ToString("F3");
			obj[38] = " targetImpulseMag=";
			obj[39] = impulseMagnitude2.ToString("F3");
			obj[40] = " targetLaunchDir=";
			vector4 = launchDir2;
			obj[41] = vector4.ToString();
			obj[42] = " targetLaunchImpulse=";
			vector4 = launchImpulse2;
			obj[43] = vector4.ToString();
			obj[44] = " postPullFreeze=";
			obj[45] = 0.26f.ToString("F3");
			obj[46] = " pullEndAt=";
			obj[47] = runtime.pullEndAt.ToString("F3");
			SummerRaceRuntimeLog.Verbose(string.Concat(obj));
		}
	}

	private void TickHookContinuousPullForces()
	{
		if (hookHitboxBySlot.Count <= 0)
		{
			return;
		}
		float time = Time.time;
		foreach (KeyValuePair<int, HookHitboxRuntime> item in hookHitboxBySlot)
		{
			HookHitboxRuntime value = item.Value;
			if (value == null || !value.active || !value.pulling)
			{
				continue;
			}
			EquipRuntime slot = value.slot;
			if (slot == null || slot.state == null)
			{
				CompleteHookContinuousPull(slot, value, "slot_missing");
				continue;
			}
			ICombatStatusHost combatStatusHost = (IsHostReferenceValid(value.pullSourceHost) ? value.pullSourceHost : ResolveOwnerCombatStatusHost());
			ICombatStatusHost combatStatusHost2 = (IsHostReferenceValid(value.pullTargetHost) ? value.pullTargetHost : value.latchedTargetHost);
			if (!IsCombatHostAlive(combatStatusHost) || !IsCombatHostAlive(combatStatusHost2))
			{
				CompleteHookContinuousPull(slot, value, "body_or_target_invalid");
				continue;
			}
			Rigidbody2D combatRigidbody = combatStatusHost.CombatRigidbody;
			Rigidbody2D combatRigidbody2 = combatStatusHost2.CombatRigidbody;
			if (combatRigidbody == null || combatRigidbody2 == null)
			{
				CompleteHookContinuousPull(slot, value, "body_or_target_invalid");
				continue;
			}
			Vector2 worldCenterOfMass = combatRigidbody.worldCenterOfMass;
			Vector2 worldCenterOfMass2 = combatRigidbody2.worldCenterOfMass;
			Vector2 vector = worldCenterOfMass2 - worldCenterOfMass;
			float magnitude = vector.magnitude;
			if (magnitude <= 0.65f || time >= value.pullEndAt)
			{
				CompleteHookContinuousPull(slot, value, (time >= value.pullEndAt) ? "duration_complete" : "min_distance");
				continue;
			}
			Vector2 vector2 = vector / magnitude;
			bool flag = value.pullMatrix == HookPullMatrixOutcome.SourceOnly || value.pullMatrix == HookPullMatrixOutcome.Both;
			bool flag2 = value.pullMatrix == HookPullMatrixOutcome.TargetOnly || value.pullMatrix == HookPullMatrixOutcome.Both;
			Vector2 vector3 = Vector2.zero;
			Vector2 vector4 = Vector2.zero;
			if (flag)
			{
				vector3 = ApplyHookContinuousPullForce(combatRigidbody, vector2, value.pullBaseDeltaV);
			}
			if (flag2)
			{
				vector4 = ApplyHookContinuousPullForce(combatRigidbody2, -vector2, value.pullBaseDeltaV);
			}
			RefreshHookPullSuppression(value);
			value.currentPoint = ((value.latchedTargetTransform != null) ? ((Vector2)value.latchedTargetTransform.position) : worldCenterOfMass2);
			if (ShouldHookTraceLog)
			{
				SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][PullForceTick] slot=" + slot.state.SlotIndex + " matrix=" + value.pullMatrix.ToString() + " sourceApply=" + flag + " targetApply=" + flag2 + " dirToTarget=" + vector2.ToString("F4") + " distance=" + magnitude.ToString("F3") + " sourceForce=" + vector3.ToString("F4") + " targetForce=" + vector4.ToString("F4") + " sourceVel=" + combatRigidbody.velocity.ToString("F4") + " targetVel=" + combatRigidbody2.velocity.ToString("F4"));
			}
		}
	}

	private Vector2 ApplyHookContinuousPullForce(Rigidbody2D body, Vector2 pullDirTowardOther, float baseDeltaV)
	{
		if (body == null)
		{
			return Vector2.zero;
		}
		Vector2 vector = ((pullDirTowardOther.sqrMagnitude > 0.0001f) ? pullDirTowardOther.normalized : Vector2.right);
		float num = Vector2.Dot(body.velocity, vector);
		float num2 = Mathf.Max(0f, 18f - num);
		if (num2 <= 0.001f)
		{
			return Vector2.zero;
		}
		float num3 = Mathf.Max(3.5f, baseDeltaV) * 1f;
		float num4 = Mathf.Min(num2 / Mathf.Max(0.001f, Time.fixedDeltaTime), num3 / Mathf.Max(0.001f, 0.45f));
		Vector2 vector2 = vector * Mathf.Max(0.1f, body.mass) * num4;
		body.AddForce(vector2, ForceMode2D.Force);
		return vector2;
	}

	private void CompleteHookContinuousPull(EquipRuntime slot, HookHitboxRuntime runtime, string reason)
	{
		if (runtime != null)
		{
			if (ShouldHookTraceLog && slot != null && slot.state != null)
			{
				SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][PullForceEnd] slot=" + slot.state.SlotIndex + " reason=" + reason + " pullEndAt=" + runtime.pullEndAt.ToString("F3") + " now=" + Time.time.ToString("F3"));
			}
			ReleaseHookLatchFreeze(runtime, "pull_force_end_" + reason);
			runtime.pulling = false;
			runtime.latched = false;
			runtime.returning = true;
			if (slot != null)
			{
				EmitEquipTravelPhaseEnd(slot, slot.lastPresentationDirection, slot.lastPresentationContext);
			}
			ResetHookPullRuntimeState(runtime);
		}
	}

	private static void ResetHookPullRuntimeState(HookHitboxRuntime runtime)
	{
		if (runtime != null)
		{
			runtime.pulling = false;
			runtime.pullEndAt = 0f;
			runtime.pullBaseDeltaV = 0f;
			runtime.pullMatrix = HookPullMatrixOutcome.TargetOnly;
			runtime.pullSourceHost = null;
			runtime.pullTargetHost = null;
		}
	}

	private static void RefreshHookPullSuppression(HookHitboxRuntime runtime)
	{
		if (runtime != null)
		{
			SuppressHostCollisionImpactForce(runtime.pullSourceHost, 0.16f);
			SuppressHostCollisionImpactForce(runtime.pullTargetHost, 0.16f);
		}
	}

	private static HookPullMatrixOutcome ResolveHookPullMatrixOutcome(SummerRaceBodyType sourceBodyType, SummerRaceBodyType targetBodyType)
	{
		int num = ResolveBodyTypeRank(sourceBodyType);
		int num2 = ResolveBodyTypeRank(targetBodyType);
		if (num == num2)
		{
			return HookPullMatrixOutcome.TargetOnly;
		}
		if (num <= num2)
		{
			return HookPullMatrixOutcome.SourceOnly;
		}
		return HookPullMatrixOutcome.TargetOnly;
	}

	private static int ResolveBodyTypeRank(SummerRaceBodyType bodyType)
	{
		return bodyType switch
		{
			SummerRaceBodyType.Light => 0, 
			SummerRaceBodyType.Medium => 1, 
			SummerRaceBodyType.Heavy => 2, 
			_ => 1, 
		};
	}

	private static void ApplyHookPostPullDriveFreeze(ICombatStatusHost sourceHost, ICombatStatusHost targetHost)
	{
		ApplyHostStunForHookDriveFreeze(sourceHost);
		ApplyHostStunForHookDriveFreeze(targetHost);
	}

	private static bool IsHostReferenceValid(ICombatStatusHost host)
	{
		if (host == null)
		{
			return false;
		}
		if (host is UnityEngine.Object obj)
		{
			return obj != null;
		}
		return true;
	}

	private static bool IsCombatHostAlive(ICombatStatusHost host)
	{
		if (IsHostReferenceValid(host))
		{
			return host.IsCombatAlive;
		}
		return false;
	}

	private void ApplyHookLatchMotionGate(HookHitboxRuntime runtime)
	{
		if (runtime != null)
		{
			DampHostForwardVelocityForHookLatch(ResolveOwnerCombatStatusHost());
			DampHostForwardVelocityForHookLatch(runtime.latchedTargetHost);
		}
	}

	private static void ApplyHostStunForHookDriveFreeze(ICombatStatusHost host)
	{
		if (IsCombatHostAlive(host))
		{
			CombatEffectSpec effect = new CombatEffectSpec
			{
				trigger = CombatTriggerType.EquipActivated,
				effectKind = CombatEffectKind.Stun,
				targetSelector = CombatTargetSelector.HitTarget,
				magnitude = 0f,
				duration = 0.26f,
				radius = 0f,
				maxTargets = 1,
				enabled = true
			};
			host.TryApplyCombatEffect(effect, Vector2.zero, null, out var _);
		}
	}

	private static void DampHostForwardVelocityForHookLatch(ICombatStatusHost host)
	{
		VehiclePhysicsController vehiclePhysicsController = ResolveHostPhysicsController(host);
		if (!(vehiclePhysicsController == null))
		{
			vehiclePhysicsController.SuppressHookLatchMotion(1.08f, 0.45f, 1.2f, 70f);
		}
	}

	private void ApplyHookPullStartupImpulse(Rigidbody2D receiverBody, Rigidbody2D otherBody, Vector2 pullDirTowardOther, float baseDeltaV, out float desiredDeltaV, out float impulseMagnitude, out Vector2 launchDir, out Vector2 launchImpulse)
	{
		desiredDeltaV = 0f;
		impulseMagnitude = 0f;
		launchDir = Vector2.zero;
		launchImpulse = Vector2.zero;
		if (!(receiverBody == null) && !(otherBody == null))
		{
			Vector2 vector = ((pullDirTowardOther.sqrMagnitude > 0.0001f) ? pullDirTowardOther.normalized : Vector2.right);
			launchDir = new Vector2(vector.x * 1.65f, vector.y + 0.08f);
			if (launchDir.sqrMagnitude <= 0.0001f)
			{
				launchDir = Vector2.up;
			}
			launchDir.Normalize();
			float num = Mathf.Max(0.1f, receiverBody.mass);
			desiredDeltaV = Mathf.Clamp(Mathf.Max(3.5f, baseDeltaV) * 0.18f, 0.6f, 4.32f);
			impulseMagnitude = num * desiredDeltaV;
			Vector2 velocity = receiverBody.velocity;
			float num2 = Mathf.Max(0f, 0f - Vector2.Dot(velocity, vector));
			if (num2 > 0.01f)
			{
				receiverBody.velocity = velocity + vector * (num2 * 0.9f);
			}
			launchImpulse = new Vector2(vector.x * impulseMagnitude, vector.y * impulseMagnitude * 0.03f);
			Vector2 worldCenterOfMass = receiverBody.worldCenterOfMass;
			receiverBody.AddForceAtPosition(launchImpulse, worldCenterOfMass, ForceMode2D.Impulse);
			if (ShouldHookTraceLog)
			{
				Vector2 velocity2 = receiverBody.velocity;
				float num3 = ((Mathf.Abs(launchDir.x) > 0.0001f) ? Mathf.Sign(launchDir.x) : 1f);
				float num4 = Mathf.Max(6.5f, desiredDeltaV * 0.92f);
				SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][PullImpulse] body=" + receiverBody.name + " mass=" + num.ToString("F3") + " desiredDeltaV=" + desiredDeltaV.ToString("F3") + " impulse=" + launchImpulse.ToString("F4") + " forcePoint=" + worldCenterOfMass.ToString("F4") + " launchDir=" + launchDir.ToString("F4") + " forwardSign=" + num3.ToString("F1") + " minForwardSpeed=" + num4.ToString("F3") + " velBefore=" + velocity.ToString("F4") + " velAfter=" + velocity2.ToString("F4"));
			}
		}
	}

	private void ApplyHookLatchFreeze(HookHitboxRuntime runtime, Vector2 hitDirection)
	{
		if (runtime != null)
		{
			ReleaseHookLatchFreeze(runtime, "refresh");
			ICombatStatusHost combatStatusHost = ResolveOwnerCombatStatusHost();
			ICombatStatusHost latchedTargetHost = runtime.latchedTargetHost;
			CombatEffectSpec effect = new CombatEffectSpec
			{
				trigger = CombatTriggerType.EquipActivated,
				effectKind = CombatEffectKind.Stun,
				targetSelector = CombatTargetSelector.HitTarget,
				magnitude = 0f,
				duration = 1f,
				radius = 0f,
				maxTargets = 1,
				enabled = true
			};
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			int damageDealt;
			if (IsCombatHostAlive(combatStatusHost))
			{
				flag = combatStatusHost.TryApplyCombatEffect(effect, hitDirection, ownerContext, out damageDealt);
				flag3 = SetHostHookFreeze(combatStatusHost, frozen: true, "hook_latched");
				DampHostForwardVelocityForHookLatch(combatStatusHost);
			}
			if (IsCombatHostAlive(latchedTargetHost))
			{
				flag2 = latchedTargetHost.TryApplyCombatEffect(effect, -hitDirection, ownerContext, out damageDealt);
				flag4 = SetHostHookFreeze(latchedTargetHost, frozen: true, "hook_latched");
				DampHostForwardVelocityForHookLatch(latchedTargetHost);
			}
			runtime.latchFreezeSourceHost = combatStatusHost;
			runtime.latchFreezeTargetHost = latchedTargetHost;
			runtime.latchFreezeApplied = flag | flag2 | flag3 | flag4;
			if (ShouldHookTraceLog)
			{
				SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][LatchFreeze] slot=" + ((runtime.slot != null && runtime.slot.state != null) ? runtime.slot.state.SlotIndex.ToString() : "<null>") + " duration=" + 1f.ToString("F3") + " source=" + ((combatStatusHost != null && combatStatusHost.CombatTransform != null) ? combatStatusHost.CombatTransform.name : "<null>") + " sourceApplied=" + flag + " target=" + ((latchedTargetHost != null && latchedTargetHost.CombatTransform != null) ? latchedTargetHost.CombatTransform.name : "<null>") + " targetApplied=" + flag2);
			}
		}
	}

	private void ReleaseHookLatchFreeze(HookHitboxRuntime runtime, string reason)
	{
		if (runtime == null)
		{
			return;
		}
		if (!runtime.latchFreezeApplied)
		{
			ClearHostHookMotionSuppression(runtime.latchFreezeSourceHost);
			ClearHostHookMotionSuppression(runtime.latchFreezeTargetHost);
			runtime.latchFreezeSourceHost = null;
			runtime.latchFreezeTargetHost = null;
			return;
		}
		bool flag = ClearHostHookFreeze(runtime.latchFreezeSourceHost, reason);
		bool flag2 = ClearHostHookFreeze(runtime.latchFreezeTargetHost, reason);
		ClearHostHookMotionSuppression(runtime.latchFreezeSourceHost);
		ClearHostHookMotionSuppression(runtime.latchFreezeTargetHost);
		if (ShouldHookTraceLog)
		{
			SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][LatchFreezeRelease] slot=" + ((runtime.slot != null && runtime.slot.state != null) ? runtime.slot.state.SlotIndex.ToString() : "<null>") + " reason=" + (reason ?? string.Empty) + " sourceReleased=" + flag + " targetReleased=" + flag2);
		}
		runtime.latchFreezeApplied = false;
		runtime.latchFreezeSourceHost = null;
		runtime.latchFreezeTargetHost = null;
	}

	private static bool ClearHostHookFreeze(ICombatStatusHost host, string reason)
	{
		if (!IsHostReferenceValid(host) || host.CombatTransform == null)
		{
			return false;
		}
		SummerRacePlayerController componentInParent = host.CombatTransform.GetComponentInParent<SummerRacePlayerController>();
		if (componentInParent != null)
		{
			componentInParent.SetHookLatchMovementFreeze(frozen: false, reason ?? "hook_release");
			return true;
		}
		SummerRaceEnemy componentInParent2 = host.CombatTransform.GetComponentInParent<SummerRaceEnemy>();
		if (componentInParent2 != null)
		{
			componentInParent2.SetHookLatchMovementFreeze(frozen: false, reason ?? "hook_release");
			return true;
		}
		return false;
	}

	private static bool SetHostHookFreeze(ICombatStatusHost host, bool frozen, string reason)
	{
		if (!IsHostReferenceValid(host) || host.CombatTransform == null)
		{
			return false;
		}
		SummerRacePlayerController componentInParent = host.CombatTransform.GetComponentInParent<SummerRacePlayerController>();
		if (componentInParent != null)
		{
			componentInParent.SetHookLatchMovementFreeze(frozen, reason ?? "hook_latched");
			return true;
		}
		SummerRaceEnemy componentInParent2 = host.CombatTransform.GetComponentInParent<SummerRaceEnemy>();
		if (componentInParent2 != null)
		{
			componentInParent2.SetHookLatchMovementFreeze(frozen, reason ?? "hook_latched");
			return true;
		}
		return false;
	}

	private static VehiclePhysicsController ResolveHostPhysicsController(ICombatStatusHost host)
	{
		if (!IsHostReferenceValid(host))
		{
			return null;
		}
		VehiclePhysicsController vehiclePhysicsController = ((host.CombatTransform != null) ? host.CombatTransform.GetComponentInParent<VehiclePhysicsController>() : null);
		if (vehiclePhysicsController == null && host.CombatRigidbody != null)
		{
			vehiclePhysicsController = host.CombatRigidbody.GetComponent<VehiclePhysicsController>();
		}
		return vehiclePhysicsController;
	}

	private static void SuppressHostCollisionImpactForce(ICombatStatusHost host, float duration)
	{
		if (!(duration <= 0f))
		{
			VehiclePhysicsController vehiclePhysicsController = ResolveHostPhysicsController(host);
			if (vehiclePhysicsController != null)
			{
				vehiclePhysicsController.SuppressCollisionImpactForce(duration);
			}
		}
	}

	private static void ClearHostHookMotionSuppression(ICombatStatusHost host)
	{
		VehiclePhysicsController vehiclePhysicsController = ResolveHostPhysicsController(host);
		if (vehiclePhysicsController != null)
		{
			vehiclePhysicsController.ClearHookLatchMotionSuppression();
		}
	}

	private ICombatStatusHost ResolveOwnerCombatStatusHost()
	{
		ICombatStatusHost combatStatusHost = ownerContext as ICombatStatusHost;
		if (combatStatusHost == null && ownerContext != null && ownerContext.CombatSourceTransform != null)
		{
			combatStatusHost = ownerContext.CombatSourceTransform.GetComponentInParent<ICombatStatusHost>();
		}
		return combatStatusHost;
	}

	private bool TryResolveHookHit(HookHitboxRuntime runtime, out ICombatStatusHost hitHost, out Transform hitTransform, out Vector2 hitPoint)
	{
		hitHost = null;
		hitTransform = null;
		hitPoint = runtime?.currentPoint ?? Vector2.zero;
		if (runtime == null || runtime.collider == null || ownerContext == null)
		{
			return false;
		}
		int num = runtime.collider.OverlapCollider(hookBoundaryOverlapFilter, hookOverlapBuffer);
		if (num <= 0)
		{
			return false;
		}
		float num2 = float.MaxValue;
		for (int i = 0; i < num; i++)
		{
			Collider2D collider2D = hookOverlapBuffer[i];
			if (collider2D == null || !SummerRaceCombatResolver.TryResolveStatusHost(collider2D, out var statusHost) || !IsCombatHostAlive(statusHost) || !SummerRaceCombatResolver.IsHostile(ownerContext, statusHost))
			{
				continue;
			}
			Transform combatTransform = statusHost.CombatTransform;
			if (!(combatTransform == null))
			{
				Vector2 vector = collider2D.ClosestPoint(runtime.currentPoint);
				float sqrMagnitude = (vector - runtime.currentPoint).sqrMagnitude;
				if (sqrMagnitude < num2)
				{
					num2 = sqrMagnitude;
					hitHost = statusHost;
					hitTransform = combatTransform;
					hitPoint = vector;
				}
			}
		}
		if (hitHost != null)
		{
			return hitTransform != null;
		}
		return false;
	}

	private bool TryResolveHookBoundaryHit(HookHitboxRuntime runtime, out Collider2D boundaryCollider)
	{
		boundaryCollider = null;
		if (runtime == null || runtime.collider == null)
		{
			return false;
		}
		int num = runtime.collider.OverlapCollider(boxingGloveOverlapFilter, hookOverlapBuffer);
		if (num <= 0)
		{
			return false;
		}
		for (int i = 0; i < num; i++)
		{
			Collider2D collider2D = hookOverlapBuffer[i];
			if (!(collider2D == null) && !string.IsNullOrEmpty(collider2D.name) && collider2D.name.StartsWith("Boundary", StringComparison.Ordinal))
			{
				boundaryCollider = collider2D;
				return true;
			}
		}
		return false;
	}

	private static float ResolveHookPullStrength(CombatEffectSpec[] effects, EquipRuntime slot)
	{
		float num = ((slot != null && slot.def != null) ? Mathf.Max(0f, slot.def.Strength) : 0f);
		if (effects == null)
		{
			return num;
		}
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled && combatEffectSpec.effectKind == CombatEffectKind.PullTarget)
			{
				num = Mathf.Max(num, Mathf.Max(0f, combatEffectSpec.magnitude));
			}
		}
		return num;
	}

	private List<ICombatStatusHost> BuildSingleTargetBuffer(ICombatStatusHost host)
	{
		impactTargets.Clear();
		if (host != null)
		{
			impactTargets.Add(host);
		}
		return impactTargets;
	}

	private void EmitEquipActivated(EquipRuntime slot, Vector2 direction, EquipPresentationContext presentationContext)
	{
		float activeDuration = ((slot != null && slot.state != null) ? Mathf.Max(0f, slot.state.ActiveUntil - Time.time) : 0f);
		EmitEquipEvent(slot, SummerRacePresentationPhase.Activated, direction, string.Empty, activeDuration, presentationContext.SourcePoint, presentationContext.TargetPoint, presentationContext.TargetTransform, presentationContext.ReachDistance, presentationContext.Radius, presentationContext.TargetCount);
	}

	private void EmitEquipRejected(int slotIndex, Vector2 aimDirection, string rejectReason)
	{
		EquipRuntime equipRuntime = (IsSlotValid(slotIndex) ? equipSlots[slotIndex] : null);
		Vector2 vector = ResolveEquipSourcePoint(equipRuntime);
		float num = ResolveEquipPresentationRadius(equipRuntime, equipRuntime?.effects);
		EmitEquipEvent(equipRuntime, SummerRacePresentationPhase.Rejected, aimDirection, rejectReason ?? string.Empty, 0f, vector, vector, null, num, num, 0);
	}

	private void EmitEquipTravelPhaseStart(EquipRuntime slot, Vector2 direction, EquipPresentationContext presentationContext)
	{
		if (ShouldEmitEquipTravelPhase(slot))
		{
			EmitEquipEvent(slot, SummerRacePresentationPhase.Spawned, direction, string.Empty, 0f, presentationContext.SourcePoint, presentationContext.TargetPoint, presentationContext.TargetTransform, presentationContext.ReachDistance, presentationContext.Radius, presentationContext.TargetCount);
		}
	}

	private void EmitHookTravelTick(EquipRuntime slot)
	{
		if (IsHookEquip(slot) && slot != null)
		{
			EquipPresentationContext lastPresentationContext = slot.lastPresentationContext;
			if (lastPresentationContext.IsValid)
			{
				EmitEquipEvent(slot, SummerRacePresentationPhase.Spawned, (slot.lastPresentationDirection.sqrMagnitude > 0.0001f) ? slot.lastPresentationDirection.normalized : ResolveEquipDirection(slot), string.Empty, 0f, lastPresentationContext.SourcePoint, lastPresentationContext.TargetPoint, lastPresentationContext.TargetTransform, lastPresentationContext.ReachDistance, lastPresentationContext.Radius, lastPresentationContext.TargetCount);
			}
		}
	}

	private void EmitEquipTravelPhaseEnd(EquipRuntime slot, Vector2 direction, EquipPresentationContext presentationContext)
	{
		if (ShouldEmitEquipTravelPhase(slot))
		{
			EmitEquipEvent(slot, SummerRacePresentationPhase.Recycled, direction, string.Empty, 0f, presentationContext.SourcePoint, presentationContext.TargetPoint, presentationContext.TargetTransform, presentationContext.ReachDistance, presentationContext.Radius, presentationContext.TargetCount);
		}
	}

	private void EmitEquipEvent(EquipRuntime slot, SummerRacePresentationPhase phase, Vector2 direction, string rejectReason, float activeDuration, Vector2 sourcePoint, Vector2 targetPoint, Transform targetTransform, float reachDistance, float radius, int targetCount)
	{
		if (ownerContext == null)
		{
			return;
		}
		Transform combatSourceTransform = ownerContext.CombatSourceTransform;
		if (!(combatSourceTransform == null))
		{
			UtilityModuleDefinition utilityModuleDefinition = slot?.def;
			SummerRaceCombatPresentationRouter.PublishEquip(combatSourceTransform, new SummerRaceEquipPresentationEvent(phase, SummerRaceCombatPresentationRouter.ResolveEquipDeliveryKind(utilityModuleDefinition), SummerRaceCombatPresentationRouter.ResolveEquipKind(utilityModuleDefinition), (slot != null && slot.state != null) ? slot.state.SlotIndex : (-1), combatSourceTransform.position, (direction.sqrMagnitude > 0.0001f) ? direction.normalized : ResolveEquipDirection(slot), rejectReason, activeDuration, (utilityModuleDefinition != null) ? Mathf.Max(0f, utilityModuleDefinition.Strength) : 0f, Mathf.Max(0f, radius), sourcePoint, targetPoint, targetTransform, reachDistance, targetCount, combatSourceTransform, slot?.mount, utilityModuleDefinition));
			if (ShouldHookTraceLog && IsHookEquip(slot) && (phase == SummerRacePresentationPhase.Activated || phase == SummerRacePresentationPhase.Spawned || phase == SummerRacePresentationPhase.Impact || phase == SummerRacePresentationPhase.Recycled))
			{
				string[] obj = new string[14]
				{
					"[SummerRace][HookTrace][EquipEvent] phase=",
					phase.ToString(),
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
				obj[4] = " target=";
				vector = targetPoint;
				obj[5] = vector.ToString();
				obj[6] = " reach=";
				obj[7] = reachDistance.ToString("F3");
				obj[8] = " radius=";
				obj[9] = radius.ToString("F3");
				obj[10] = " targetCount=";
				obj[11] = targetCount.ToString();
				obj[12] = " slot=";
				obj[13] = ((slot != null && slot.state != null) ? slot.state.SlotIndex : (-1)).ToString();
				SummerRaceRuntimeLog.Verbose(string.Concat(obj));
			}
		}
	}

	private void EmitEquipImpacts(EquipRuntime slot, Vector2 direction, EquipPresentationContext presentationContext, List<ICombatStatusHost> resolvedTargets, Dictionary<Transform, Vector2> contactPoints, float activeDuration)
	{
		if (slot == null || ownerContext == null || resolvedTargets == null || resolvedTargets.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < resolvedTargets.Count; i++)
		{
			Transform combatTransform = resolvedTargets[i].CombatTransform;
			Vector2 vector = presentationContext.SourcePoint;
			if (combatTransform != null)
			{
				vector = ((contactPoints == null || !contactPoints.TryGetValue(combatTransform, out var value)) ? ((Vector2)combatTransform.position) : value);
			}
			float reachDistance = Mathf.Max(presentationContext.Radius, Vector2.Distance(presentationContext.SourcePoint, vector));
			EmitEquipEvent(slot, SummerRacePresentationPhase.Impact, direction, string.Empty, Mathf.Max(0f, activeDuration), presentationContext.SourcePoint, vector, combatTransform, reachDistance, presentationContext.Radius, presentationContext.TargetCount);
		}
	}

	private Vector2 ResolveEquipSourcePoint(EquipRuntime slot)
	{
		if (IsBoxingGloveEquip(slot))
		{
			return ResolveBoxingGloveSourcePointOrThrow(slot);
		}
		if (slot != null && slot.mount != null)
		{
			return slot.mount.transform.position;
		}
		if (ownerContext != null && ownerContext.CombatSourceTransform != null)
		{
			return ownerContext.CombatSourceTransform.position;
		}
		return base.transform.position;
	}

	private Vector2 ResolveBoxingGloveSourcePointOrThrow(EquipRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove source-point requires mounted visual instance.");
		}
		SkeletonAnimation componentInChildren = slot.mount.VisualInstance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		if (componentInChildren == null || componentInChildren.Skeleton == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove source-point requires SkeletonAnimation. equip=" + ((slot.def != null) ? slot.def.name : "<null>"));
		}
		componentInChildren.Skeleton.UpdateWorldTransform();
		Slot slot2 = componentInChildren.Skeleton.FindSlot("quantao1");
		if (slot2 == null || slot2.Bone == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove center slot missing. equip=" + ((slot.def != null) ? slot.def.name : "<null>") + " requiredSlot=quantao1");
		}
		Bone bone = slot2.Bone;
		Vector3 position = new Vector3(bone.WorldX, bone.WorldY, 0f);
		Vector3 vector = componentInChildren.transform.TransformPoint(position);
		if (ShouldHookTraceLog)
		{
			SummerRaceRuntimeLog.Verbose("[SummerRace][BoxingGloveCenter] slot=" + ((slot.state != null) ? slot.state.SlotIndex.ToString() : "-1") + " source=" + new Vector2(vector.x, vector.y).ToString() + " sourceSlot=quantao1 equip=" + ((slot.def != null) ? slot.def.name : "<null>"));
		}
		return new Vector2(vector.x, vector.y);
	}

	private Vector2 ResolveEquipDirection(EquipRuntime slot)
	{
		if (slot != null && slot.mount != null)
		{
			Vector2 vector = slot.mount.transform.right;
			if (vector.sqrMagnitude > 0.0001f)
			{
				return ResolveEquipTeamDirection(vector.normalized);
			}
		}
		if (ownerContext != null && ownerContext.CombatSourceTransform != null)
		{
			Vector2 vector2 = ownerContext.CombatSourceTransform.right;
			if (vector2.sqrMagnitude > 0.0001f)
			{
				return ResolveEquipTeamDirection(vector2.normalized);
			}
		}
		return Vector2.right;
	}

	private Vector2 ResolveEquipTeamDirection(Vector2 authoredDirection)
	{
		if (authoredDirection.sqrMagnitude <= 0.0001f)
		{
			return Vector2.right;
		}
		float num = ((ownerContext != null && ownerContext.CombatTeam == SummerRaceCombatTeam.Enemy) ? (-1f) : 1f);
		return (authoredDirection.normalized * num).normalized;
	}

	private EquipPresentationContext ResolveEquipPresentationContext(EquipRuntime slot, Vector2 aimDirection, CombatEffectSpec[] effects, List<ICombatStatusHost> targetBuffer, HashSet<Transform> targetTransforms, Dictionary<Transform, Vector2> contactPoints)
	{
		Vector2 vector = ResolveEquipSourcePoint(slot);
		float num = ResolveEquipPresentationRadius(slot, effects);
		Vector2 vector2 = ((aimDirection.sqrMagnitude > 0.0001f) ? aimDirection.normalized : ResolveEquipDirection(slot));
		bool num2 = IsHookEquip(slot);
		bool flag = IsBoxingGloveEquip(slot);
		bool hasSelfTargetEffect = false;
		ResolveEquipTargets(slot, ownerContext, vector, vector2, effects, targetBuffer, targetTransforms, contactPoints, ref hasSelfTargetEffect);
		Transform transform = null;
		Vector2 vector3 = (num2 ? (vector + vector2 * num) : vector);
		if (targetBuffer != null)
		{
			for (int i = 0; i < targetBuffer.Count; i++)
			{
				ICombatStatusHost combatStatusHost = targetBuffer[i];
				if (combatStatusHost != null && !(combatStatusHost.CombatTransform == null))
				{
					transform = combatStatusHost.CombatTransform;
					vector3 = ((!flag || contactPoints == null || !contactPoints.TryGetValue(transform, out var value)) ? ((Vector2)transform.position) : value);
					break;
				}
			}
		}
		float reachDistance = Mathf.Max(num, Vector2.Distance(vector, vector3));
		int targetCount = targetBuffer?.Count ?? 0;
		return new EquipPresentationContext(vector, vector3, transform, reachDistance, targetCount, num, hasSelfTargetEffect);
	}

	private void ResolveEquipTargets(EquipRuntime slot, ICombatSourceContext sourceContext, Vector2 sourcePoint, Vector2 aimDirection, CombatEffectSpec[] effects, List<ICombatStatusHost> targetBuffer, HashSet<Transform> targetTransforms, Dictionary<Transform, Vector2> contactPoints, ref bool hasSelfTargetEffect)
	{
		targetBuffer?.Clear();
		targetTransforms?.Clear();
		contactPoints?.Clear();
		if (sourceContext == null || effects == null)
		{
			return;
		}
		if (IsBoxingGloveEquip(slot))
		{
			ResolveBoxingGloveTargets(sourceContext, sourcePoint, aimDirection, effects, targetBuffer, targetTransforms, contactPoints, ref hasSelfTargetEffect);
			return;
		}
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec == null || !combatEffectSpec.enabled)
			{
				continue;
			}
			if (combatEffectSpec.targetSelector == CombatTargetSelector.Self)
			{
				hasSelfTargetEffect = true;
				continue;
			}
			SummerRaceCombatResolver.ResolveTargets(sourceContext, combatEffectSpec.targetSelector, aimDirection, combatEffectSpec.radius, resolveScratchTargets);
			if (targetBuffer == null)
			{
				continue;
			}
			for (int j = 0; j < resolveScratchTargets.Count; j++)
			{
				ICombatStatusHost combatStatusHost = resolveScratchTargets[j];
				if (combatStatusHost != null)
				{
					Transform combatTransform = combatStatusHost.CombatTransform;
					if (!(combatTransform != null) || targetTransforms == null || targetTransforms.Add(combatTransform))
					{
						targetBuffer.Add(combatStatusHost);
					}
				}
			}
		}
	}

	private void ResolveBoxingGloveTargets(ICombatSourceContext sourceContext, Vector2 sourcePoint, Vector2 aimDirection, CombatEffectSpec[] effects, List<ICombatStatusHost> targetBuffer, HashSet<Transform> targetTransforms, Dictionary<Transform, Vector2> contactPoints, ref bool hasSelfTargetEffect)
	{
		float num = 0f;
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled)
			{
				if (combatEffectSpec.targetSelector == CombatTargetSelector.Self)
				{
					hasSelfTargetEffect = true;
				}
				else
				{
					num = Mathf.Max(num, Mathf.Max(0f, combatEffectSpec.radius));
				}
			}
		}
		if (num <= 0f || targetBuffer == null)
		{
			return;
		}
		SummerRaceCombatResolver.CollectTargetsNearPoint(sourceContext, sourcePoint, num, resolveScratchTargets);
		ICombatStatusHost combatStatusHost = null;
		Vector2 value = sourcePoint;
		float num2 = float.MaxValue;
		float num3 = num * num;
		for (int j = 0; j < resolveScratchTargets.Count; j++)
		{
			ICombatStatusHost combatStatusHost2 = resolveScratchTargets[j];
			if (combatStatusHost2 != null && combatStatusHost2.IsCombatAlive && !(combatStatusHost2.CombatTransform == null))
			{
				if (!TryResolveHostContactPoint(combatStatusHost2, sourcePoint, out var contactPoint))
				{
					contactPoint = combatStatusHost2.CombatTransform.position;
				}
				float sqrMagnitude = (contactPoint - sourcePoint).sqrMagnitude;
				if (!(sqrMagnitude > num3) && sqrMagnitude < num2)
				{
					combatStatusHost = combatStatusHost2;
					value = contactPoint;
					num2 = sqrMagnitude;
				}
			}
		}
		if (combatStatusHost == null)
		{
			return;
		}
		targetBuffer.Add(combatStatusHost);
		Transform combatTransform = combatStatusHost.CombatTransform;
		if (combatTransform != null)
		{
			targetTransforms?.Add(combatTransform);
			if (contactPoints != null)
			{
				contactPoints[combatTransform] = value;
			}
		}
	}

	private void ResolveEquipTargetsFromHitbox(EquipRuntime slot, Vector2 sourcePoint, CombatEffectSpec[] effects, List<ICombatStatusHost> targetBuffer, HashSet<Transform> targetTransforms, Dictionary<Transform, Vector2> contactPoints, ref bool hasSelfTargetEffect)
	{
		targetBuffer?.Clear();
		targetTransforms?.Clear();
		contactPoints?.Clear();
		float num = 0f;
		if (effects != null)
		{
			foreach (CombatEffectSpec combatEffectSpec in effects)
			{
				if (combatEffectSpec != null && combatEffectSpec.enabled)
				{
					if (combatEffectSpec.targetSelector == CombatTargetSelector.Self)
					{
						hasSelfTargetEffect = true;
					}
					else
					{
						num = Mathf.Max(num, Mathf.Max(0f, combatEffectSpec.radius));
					}
				}
			}
		}
		if (num <= 0f || targetBuffer == null || !TryEnsureBoxingGloveHitboxRuntime(slot, out var runtime) || runtime == null)
		{
			return;
		}
		SyncBoxingGloveHitboxPose(runtime, sourcePoint);
		Physics2D.SyncTransforms();
		Vector2 vector = runtime.root.TransformPoint(runtime.collider.offset);
		int num2 = runtime.collider.OverlapCollider(boxingGloveOverlapFilter, boxingGloveOverlapBuffer);
		if (num2 <= 0)
		{
			if (ShouldHookTraceLog)
			{
				string[] obj = new string[10] { "[SummerRace][BoxingGloveHitbox] overlap=0 center=", null, null, null, null, null, null, null, null, null };
				Vector2 vector2 = vector;
				obj[1] = vector2.ToString();
				obj[2] = " slot=";
				obj[3] = ((slot != null && slot.state != null) ? slot.state.SlotIndex.ToString() : "-1");
				obj[4] = " source=";
				vector2 = sourcePoint;
				obj[5] = vector2.ToString();
				obj[6] = " configuredRadius=";
				obj[7] = num.ToString("F3");
				obj[8] = " colliderRadius=";
				obj[9] = runtime.collider.radius.ToString("F3");
				SummerRaceRuntimeLog.Verbose(string.Concat(obj));
			}
			return;
		}
		ICombatStatusHost combatStatusHost = null;
		Vector2 vector3 = vector;
		float num3 = float.MaxValue;
		for (int j = 0; j < num2; j++)
		{
			Collider2D collider2D = boxingGloveOverlapBuffer[j];
			if (!(collider2D == null) && SummerRaceCombatResolver.TryResolveStatusHost(collider2D, out var statusHost) && statusHost != null && statusHost.IsCombatAlive && SummerRaceCombatResolver.IsHostile(ownerContext, statusHost) && !(statusHost.CombatTransform == null))
			{
				Vector2 vector4 = collider2D.ClosestPoint(vector);
				float sqrMagnitude = (vector4 - vector).sqrMagnitude;
				if (sqrMagnitude < num3)
				{
					combatStatusHost = statusHost;
					vector3 = vector4;
					num3 = sqrMagnitude;
				}
			}
		}
		if (combatStatusHost == null)
		{
			return;
		}
		targetBuffer.Add(combatStatusHost);
		Transform combatTransform = combatStatusHost.CombatTransform;
		if (combatTransform != null)
		{
			targetTransforms?.Add(combatTransform);
			if (contactPoints != null)
			{
				contactPoints[combatTransform] = vector3;
			}
		}
		if (ShouldHookTraceLog)
		{
			string[] obj2 = new string[16]
			{
				"[SummerRace][BoxingGloveHitbox] overlap=",
				num2.ToString(),
				" center=",
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
			Vector2 vector2 = vector;
			obj2[3] = vector2.ToString();
			obj2[4] = " slot=";
			obj2[5] = ((slot != null && slot.state != null) ? slot.state.SlotIndex.ToString() : "-1");
			obj2[6] = " source=";
			vector2 = sourcePoint;
			obj2[7] = vector2.ToString();
			obj2[8] = " configuredRadius=";
			obj2[9] = num.ToString("F3");
			obj2[10] = " colliderRadius=";
			obj2[11] = runtime.collider.radius.ToString("F3");
			obj2[12] = " hitTarget=";
			obj2[13] = combatTransform.name;
			obj2[14] = " hitPoint=";
			vector2 = vector3;
			obj2[15] = vector2.ToString();
			SummerRaceRuntimeLog.Verbose(string.Concat(obj2));
		}
	}

	private static bool TryResolveHostContactPoint(ICombatStatusHost target, Vector2 center, out Vector2 contactPoint)
	{
		contactPoint = center;
		if (target == null || target.CombatTransform == null)
		{
			return false;
		}
		Collider2D[] componentsInChildren = target.CombatTransform.GetComponentsInChildren<Collider2D>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return false;
		}
		float num = float.MaxValue;
		bool result = false;
		foreach (Collider2D collider2D in componentsInChildren)
		{
			if (!(collider2D == null) && collider2D.enabled && collider2D.gameObject.activeInHierarchy)
			{
				Vector2 vector = collider2D.ClosestPoint(center);
				float sqrMagnitude = (vector - center).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					num = sqrMagnitude;
					contactPoint = vector;
					result = true;
				}
			}
		}
		return result;
	}

	private CombatExecutionResult ExecuteBoxingGloveEffects(Vector2 aimDirection, CombatEffectSpec[] effects, IList<ICombatStatusHost> resolvedTargets, Dictionary<Transform, Vector2> contactPoints, Vector2 sourcePoint)
	{
		if (ownerContext == null)
		{
			return CombatExecutionResult.Failed("Combat source context is missing.");
		}
		int num = 0;
		int num2 = 0;
		CombatEffectSpec[] array = effects ?? Array.Empty<CombatEffectSpec>();
		ICombatStatusHost combatStatusHost = ownerContext as ICombatStatusHost;
		if ((combatStatusHost == null || !combatStatusHost.IsCombatAlive) && ownerContext != null && ownerContext.CombatSourceTransform != null)
		{
			combatStatusHost = ownerContext.CombatSourceTransform.GetComponentInParent<ICombatStatusHost>();
		}
		foreach (CombatEffectSpec combatEffectSpec in array)
		{
			if (combatEffectSpec == null || !combatEffectSpec.enabled)
			{
				continue;
			}
			if (combatEffectSpec.targetSelector == CombatTargetSelector.Self)
			{
				if (combatStatusHost != null && combatStatusHost.IsCombatAlive)
				{
					Vector2 hitDirection = ((aimDirection.sqrMagnitude > 0.0001f) ? aimDirection.normalized : Vector2.right);
					if (combatStatusHost.TryApplyCombatEffect(combatEffectSpec, hitDirection, ownerContext, out var damageDealt))
					{
						num++;
						num2 += Mathf.Max(0, damageDealt);
					}
				}
			}
			else
			{
				if (resolvedTargets == null || resolvedTargets.Count <= 0)
				{
					continue;
				}
				int num3 = ((combatEffectSpec.maxTargets <= 0) ? resolvedTargets.Count : Mathf.Min(resolvedTargets.Count, combatEffectSpec.maxTargets));
				for (int j = 0; j < num3; j++)
				{
					ICombatStatusHost combatStatusHost2 = resolvedTargets[j];
					if (combatStatusHost2 == null)
					{
						continue;
					}
					Vector2 hitDirection2 = ((aimDirection.sqrMagnitude > 0.0001f) ? aimDirection.normalized : Vector2.right);
					Transform combatTransform = combatStatusHost2.CombatTransform;
					if (combatTransform != null)
					{
						if (contactPoints != null && contactPoints.TryGetValue(combatTransform, out var value))
						{
							Vector2 vector = value - sourcePoint;
							if (vector.sqrMagnitude > 0.0001f)
							{
								hitDirection2 = vector.normalized;
							}
						}
						else
						{
							Vector2 vector2 = (Vector2)combatTransform.position - sourcePoint;
							if (vector2.sqrMagnitude > 0.0001f)
							{
								hitDirection2 = vector2.normalized;
							}
						}
					}
					if (combatStatusHost2.TryApplyCombatEffect(combatEffectSpec, hitDirection2, ownerContext, out var damageDealt2))
					{
						if (combatEffectSpec.effectKind == CombatEffectKind.Knockback)
						{
							ApplyBoxingGloveArcadeLaunchImpulse(combatStatusHost2, combatTransform, hitDirection2, combatEffectSpec.magnitude, sourcePoint, contactPoints);
						}
						num++;
						num2 += Mathf.Max(0, damageDealt2);
					}
				}
			}
		}
		if (num <= 0)
		{
			return CombatExecutionResult.Failed("Combat effect execution found no valid boxing glove targets.");
		}
		return CombatExecutionResult.Succeeded(num, num2);
	}

	private void ApplyBoxingGloveArcadeLaunchImpulse(ICombatStatusHost target, Transform targetTransform, Vector2 hitDirection, float baseStrength, Vector2 sourcePoint, Dictionary<Transform, Vector2> contactPoints)
	{
		if (target == null)
		{
			return;
		}
		Rigidbody2D combatRigidbody = target.CombatRigidbody;
		if (combatRigidbody == null)
		{
			return;
		}
		Vector2 vector = ((hitDirection.sqrMagnitude > 0.0001f) ? hitDirection.normalized : Vector2.right);
		Vector2 vector2 = new Vector2(vector.x * BoxingGloveArcadeLiftDirection.x, vector.y + Mathf.Abs(vector.x) * BoxingGloveArcadeLiftDirection.y);
		if (vector2.sqrMagnitude <= 0.0001f)
		{
			vector2 = Vector2.right;
		}
		vector2.Normalize();
		Rigidbody2D rigidbody2D = ((ownerContext != null) ? ownerContext.CombatSourceRigidbody : null);
		Vector2 vector3 = ((rigidbody2D != null) ? rigidbody2D.velocity : Vector2.zero);
		float num = Mathf.Max(0f, Vector2.Dot(vector3 - combatRigidbody.velocity, vector2));
		float num2 = Mathf.Max(12.5f, Mathf.Max(0f, baseStrength) * 1.45f);
		num2 += Mathf.Clamp(num * 1.05f, 0f, 14f);
		float num3 = Mathf.Clamp((combatRigidbody.mass - 4.8f) * 0.95f, 0f, 7.5f);
		num2 += num3;
		Vector2 vector4 = combatRigidbody.worldCenterOfMass;
		if (targetTransform != null && contactPoints != null && contactPoints.TryGetValue(targetTransform, out var value))
		{
			vector4 = value;
		}
		else if (targetTransform != null)
		{
			vector4 = targetTransform.position;
		}
		if (combatRigidbody.bodyType == RigidbodyType2D.Dynamic)
		{
			float num4 = Mathf.Max(0f, combatRigidbody.mass * num2);
			if (!(num4 <= 0f))
			{
				combatRigidbody.AddForceAtPosition(vector2 * num4, vector4, ForceMode2D.Impulse);
				EnsureArcadeLaunchVelocityFloor(combatRigidbody, vector2, num2);
				if (ShouldHookTraceLog)
				{
					string[] obj = new string[20]
					{
						"[SummerRace][BoxingGloveArcadeLaunch] target=",
						(targetTransform != null) ? targetTransform.name : "<null>",
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
					Vector2 vector5 = vector2;
					obj[3] = vector5.ToString();
					obj[4] = " baseStrength=";
					obj[5] = baseStrength.ToString("F3");
					obj[6] = " approachSpeed=";
					obj[7] = num.ToString("F3");
					obj[8] = " heavyMassBonus=";
					obj[9] = num3.ToString("F3");
					obj[10] = " desiredDeltaV=";
					obj[11] = num2.ToString("F3");
					obj[12] = " mass=";
					obj[13] = combatRigidbody.mass.ToString("F3");
					obj[14] = " impulse=";
					obj[15] = num4.ToString("F3");
					obj[16] = " source=";
					vector5 = sourcePoint;
					obj[17] = vector5.ToString();
					obj[18] = " contact=";
					vector5 = vector4;
					obj[19] = vector5.ToString();
					SummerRaceRuntimeLog.Verbose(string.Concat(obj));
				}
			}
		}
		else if (combatRigidbody.bodyType == RigidbodyType2D.Kinematic)
		{
			combatRigidbody.velocity += vector2 * num2;
			EnsureArcadeLaunchVelocityFloor(combatRigidbody, vector2, num2);
			if (ShouldHookTraceLog && targetTransform != null)
			{
				string[] obj2 = new string[16]
				{
					"[SummerRace][BoxingGloveArcadeLaunch] target=", targetTransform.name, " dir=", null, null, null, null, null, null, null,
					null, null, null, null, null, null
				};
				Vector2 vector5 = vector2;
				obj2[3] = vector5.ToString();
				obj2[4] = " baseStrength=";
				obj2[5] = baseStrength.ToString("F3");
				obj2[6] = " approachSpeed=";
				obj2[7] = num.ToString("F3");
				obj2[8] = " heavyMassBonus=";
				obj2[9] = num3.ToString("F3");
				obj2[10] = " desiredDeltaV=";
				obj2[11] = num2.ToString("F3");
				obj2[12] = " bodyType=Kinematic source=";
				vector5 = sourcePoint;
				obj2[13] = vector5.ToString();
				obj2[14] = " contact=";
				vector5 = vector4;
				obj2[15] = vector5.ToString();
				SummerRaceRuntimeLog.Verbose(string.Concat(obj2));
			}
		}
	}

	private static void EnsureArcadeLaunchVelocityFloor(Rigidbody2D targetBody, Vector2 launchDir, float desiredDeltaV)
	{
		if (!(targetBody == null))
		{
			Vector2 velocity = targetBody.velocity;
			float num = Vector2.Dot(velocity, launchDir);
			float num2 = Mathf.Max(11f, desiredDeltaV * 0.82f);
			if (num < num2)
			{
				velocity += launchDir * (num2 - num);
			}
			if (velocity.y < 5.2f)
			{
				velocity.y = 5.2f;
			}
			targetBody.velocity = velocity;
		}
	}

	private float ResolveEquipPresentationRadius(EquipRuntime slot, CombatEffectSpec[] effects)
	{
		float num = ((slot != null && slot.def != null) ? Mathf.Max(0f, slot.def.Radius) : 0f);
		if (effects == null)
		{
			return num;
		}
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled)
			{
				num = Mathf.Max(num, Mathf.Max(0f, combatEffectSpec.radius));
			}
		}
		return num;
	}

	private static bool ShouldEmitEquipTravelPhase(EquipRuntime slot)
	{
		if (slot == null || slot.def == null)
		{
			return false;
		}
		if (SummerRaceCombatPresentationRouter.TryResolveTransientPhasePolicy(SummerRaceCombatPresentationRouter.ResolveEquipDeliveryKind(slot.def), out var policy))
		{
			return policy.HasStartPhase;
		}
		return false;
	}

	private static bool IsHookEquip(EquipRuntime slot)
	{
		if (slot != null && slot.def != null)
		{
			return SummerRaceCombatPresentationRouter.ResolveEquipKind(slot.def) == EquipKind.Hook;
		}
		return false;
	}

	private static bool IsBoxingGloveEquip(EquipRuntime slot)
	{
		if (slot != null && slot.def != null)
		{
			return SummerRaceCombatPresentationRouter.ResolveEquipKind(slot.def) == EquipKind.BoxingGlove;
		}
		return false;
	}

	private static bool ShouldTreatHookMissAsSuccessfulActivation(EquipRuntime slot, IList<ICombatStatusHost> resolvedTargets)
	{
		if (!IsHookEquip(slot))
		{
			return false;
		}
		if (resolvedTargets != null)
		{
			return resolvedTargets.Count <= 0;
		}
		return true;
	}

	private static bool CanReuseResolvedTargetsForEffects(CombatEffectSpec[] effects)
	{
		if (effects == null || effects.Length == 0)
		{
			return false;
		}
		bool flag = false;
		CombatTargetSelector combatTargetSelector = CombatTargetSelector.HitTarget;
		float b = 0f;
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled && combatEffectSpec.targetSelector != CombatTargetSelector.Self)
			{
				if (!flag)
				{
					flag = true;
					combatTargetSelector = combatEffectSpec.targetSelector;
					b = combatEffectSpec.radius;
				}
				else if (combatEffectSpec.targetSelector != combatTargetSelector || !Mathf.Approximately(combatEffectSpec.radius, b))
				{
					return false;
				}
			}
		}
		return true;
	}

	private float ResolveRuntimeActiveUntil(EquipRuntime slot, CombatEffectSpec[] effects)
	{
		float num = ResolveActiveDuration(effects);
		if (slot != null && slot.def != null)
		{
			if (IsBoxingGloveEquip(slot))
			{
				num = Mathf.Max(num, Mathf.Max(0f, slot.def.Duration));
			}
			else if (IsHookEquip(slot))
			{
				float num2 = Mathf.Max(0.8f, slot.def.Radius);
				float num3 = Mathf.Max(1f, num2 / Mathf.Max(0.02f, Mathf.Max(0.24f, slot.def.Duration)));
				float num4 = num2 / num3;
				float num5 = num2 / Mathf.Max(8f, num3);
				float b = num4 + num5 + 1f + 1.8f;
				num = Mathf.Max(num, b);
			}
		}
		if (!(num > 0f))
		{
			return 0f;
		}
		return Time.time + num;
	}

	private static float ResolveActiveDuration(CombatEffectSpec[] effects)
	{
		if (effects == null || effects.Length == 0)
		{
			return 0f;
		}
		float num = 0f;
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled && (combatEffectSpec.effectKind == CombatEffectKind.SelfDash || combatEffectSpec.effectKind == CombatEffectKind.Shield || combatEffectSpec.effectKind == CombatEffectKind.Disarm))
			{
				num = Mathf.Max(num, Mathf.Max(0f, combatEffectSpec.duration));
			}
		}
		return num;
	}

	private static string BuildEffectSummary(CombatEffectSpec[] effects)
	{
		if (effects == null || effects.Length == 0)
		{
			return "none";
		}
		StringBuilder stringBuilder = new StringBuilder(64);
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled)
			{
				if (stringBuilder.Length > 0)
				{
					stringBuilder.Append("|");
				}
				stringBuilder.Append(combatEffectSpec.effectKind);
				stringBuilder.Append("@");
				stringBuilder.Append(combatEffectSpec.targetSelector);
				stringBuilder.Append("(r=");
				stringBuilder.Append(combatEffectSpec.radius.ToString("F2"));
				stringBuilder.Append(")");
			}
		}
		if (stringBuilder.Length <= 0)
		{
			return "none";
		}
		return stringBuilder.ToString();
	}

	private void EnsureBoxingGloveHitboxRuntimeForSlot(EquipRuntime slot)
	{
		if (IsBoxingGloveEquip(slot))
		{
			TryEnsureBoxingGloveHitboxRuntime(slot, out var _);
		}
	}

	private bool TryEnsureBoxingGloveHitboxRuntime(EquipRuntime slot, out BoxingGloveHitboxRuntime runtime)
	{
		runtime = null;
		if (slot == null || slot.state == null || !IsBoxingGloveEquip(slot))
		{
			return false;
		}
		int slotIndex = slot.state.SlotIndex;
		if (boxingGloveHitboxBySlot.TryGetValue(slotIndex, out var value) && value != null && value.root != null && value.collider != null)
		{
			runtime = value;
			runtime.slot = slot;
			return true;
		}
		if (slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove hitbox requires mount visual instance.");
		}
		Transform parent = ResolveBoxingGloveVisualParentOrThrow(slot);
		GameObject gameObject = new GameObject("BoxingGloveHitbox_" + slotIndex);
		gameObject.hideFlags = HideFlags.DontSave;
		gameObject.transform.SetParent(parent, worldPositionStays: false);
		gameObject.transform.localPosition = BoxingGloveHitboxDefaultLocalPosition;
		gameObject.transform.localRotation = Quaternion.Euler(BoxingGloveHitboxDefaultLocalEulerAngles);
		gameObject.transform.localScale = Vector3.one;
		CircleCollider2D circleCollider2D = gameObject.AddComponent<CircleCollider2D>();
		circleCollider2D.isTrigger = true;
		circleCollider2D.offset = Vector2.zero;
		circleCollider2D.radius = 1f;
		circleCollider2D.enabled = true;
		runtime = new BoxingGloveHitboxRuntime
		{
			slot = slot,
			root = gameObject.transform,
			collider = circleCollider2D
		};
		boxingGloveHitboxBySlot[slotIndex] = runtime;
		slot.boxingGloveHitboxRuntime = runtime;
		return true;
	}

	private static Transform ResolveBoxingGloveVisualParentOrThrow(EquipRuntime slot)
	{
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove hitbox requires mount visual instance.");
		}
		Transform transform = slot.mount.VisualInstance.transform;
		Transform obj = transform.Find("Visual");
		if (obj == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove hitbox requires child 'Visual' under mount visual instance. mount=" + transform.name);
		}
		return obj;
	}

	private static string BuildTransformPath(Transform node)
	{
		if (node == null)
		{
			return "<null>";
		}
		List<string> list = new List<string>(16);
		Transform transform = node;
		while (transform != null)
		{
			list.Add(transform.name);
			transform = transform.parent;
		}
		list.Reverse();
		return string.Join("/", list);
	}

	private static Transform EnsureChildTransform(Transform parent, string childName)
	{
		if (parent == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] Cannot ensure child on null parent. child=" + childName);
		}
		if (string.IsNullOrWhiteSpace(childName))
		{
			throw new InvalidOperationException("[VehicleEquipSystem] Child name is empty while ensuring transform.");
		}
		Transform transform = parent.Find(childName);
		if (transform != null)
		{
			return transform;
		}
		transform = new GameObject(childName).transform;
		transform.SetParent(parent, worldPositionStays: false);
		transform.localPosition = Vector3.zero;
		transform.localRotation = Quaternion.identity;
		transform.localScale = Vector3.one;
		return transform;
	}

	private bool TryResolveHookHeadHitboxTransform(EquipRuntime slot, int slotIndex, out Transform hitboxRoot)
	{
		hitboxRoot = null;
		if (slot == null || slot.mount == null || slot.mount.VisualInstance == null)
		{
			return false;
		}
		Transform transform = slot.mount.VisualInstance.transform;
		for (int num = transform.childCount - 1; num >= 0; num--)
		{
			Transform child = transform.GetChild(num);
			if (!(child == null) && child.name.StartsWith("HookLineSpine_", StringComparison.Ordinal))
			{
				if (ShouldHookTraceLog)
				{
					SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][Cleanup] removeLegacy=" + BuildTransformPath(child));
				}
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(child.gameObject);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(child.gameObject);
				}
			}
		}
		Transform parent = EnsureChildTransform(EnsureChildTransform(transform, "Visual"), "HookHead");
		hitboxRoot = EnsureChildTransform(parent, "HookHitBox");
		hitboxRoot.localPosition = Vector3.zero;
		hitboxRoot.localRotation = Quaternion.identity;
		hitboxRoot.localScale = Vector3.one;
		Transform obj = EnsureChildTransform(hitboxRoot, "HookPointRight");
		obj.localPosition = new Vector3(1f, 0f, 0f);
		obj.localRotation = Quaternion.identity;
		obj.localScale = Vector3.one;
		return true;
	}

	private static void SyncBoxingGloveHitboxPose(BoxingGloveHitboxRuntime runtime, Vector2 sourcePoint)
	{
		if (runtime == null || runtime.root == null || runtime.collider == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] BoxingGlove hitbox sync requires valid runtime.");
		}
		Vector3 position = new Vector3(sourcePoint.x, sourcePoint.y, runtime.root.position.z);
		runtime.root.localPosition = BoxingGloveHitboxDefaultLocalPosition;
		runtime.root.localRotation = Quaternion.Euler(BoxingGloveHitboxDefaultLocalEulerAngles);
		runtime.root.localScale = Vector3.one;
		runtime.collider.offset = runtime.root.InverseTransformPoint(position);
		runtime.collider.radius = 1f;
	}

	private bool TryEnsureHookHitboxRuntime(EquipRuntime slot, out HookHitboxRuntime runtime)
	{
		runtime = null;
		if (slot == null || slot.state == null || !IsHookEquip(slot))
		{
			return false;
		}
		int slotIndex = slot.state.SlotIndex;
		if (hookHitboxBySlot.TryGetValue(slotIndex, out var value) && value != null && value.root != null && value.collider != null)
		{
			if (!TryResolveHookHeadHitboxTransform(slot, slotIndex, out var hitboxRoot))
			{
				throw new InvalidOperationException("[VehicleEquipSystem] Hook hitbox requires HookHitBox path. slot=" + slotIndex);
			}
			if (value.root != hitboxRoot)
			{
				throw new InvalidOperationException("[VehicleEquipSystem] Hook hitbox root drifted from HookHitBox. slot=" + slotIndex + " cached=" + BuildTransformPath(value.root) + " expected=" + BuildTransformPath(hitboxRoot));
			}
			runtime = value;
			runtime.slot = slot;
			return true;
		}
		if (!TryResolveHookHeadHitboxTransform(slot, slotIndex, out var hitboxRoot2))
		{
			throw new InvalidOperationException("[VehicleEquipSystem] Hook hitbox requires HookHitBox path. slot=" + slotIndex);
		}
		Transform transform = hitboxRoot2.Find("HookPointRight");
		if (transform == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] Hook hitbox requires HookPointRight path. slot=" + slotIndex);
		}
		GameObject gameObject = hitboxRoot2.gameObject;
		gameObject.hideFlags = HideFlags.DontSave;
		BoxCollider2D boxCollider2D = gameObject.GetComponent<BoxCollider2D>();
		if (boxCollider2D == null)
		{
			boxCollider2D = gameObject.AddComponent<BoxCollider2D>();
		}
		boxCollider2D.isTrigger = true;
		boxCollider2D.enabled = false;
		boxCollider2D.size = HookHitboxSize;
		boxCollider2D.offset = HookHitboxDefaultLocalPosition;
		runtime = new HookHitboxRuntime
		{
			slot = slot,
			root = hitboxRoot2,
			collider = boxCollider2D
		};
		hookHitboxBySlot[slotIndex] = runtime;
		if (ShouldHookTraceLog)
		{
			SummerRaceRuntimeLog.Verbose("[SummerRace][HookTrace][HitboxBind] slot=" + slotIndex + " source=HookHitBox path=" + BuildTransformPath(hitboxRoot2) + " localPos=" + hitboxRoot2.localPosition.ToString() + " localRot=" + hitboxRoot2.localRotation.eulerAngles.ToString() + " hookPointRightLocalPos=" + transform.localPosition.ToString() + " offset=" + boxCollider2D.offset.ToString() + " colliderSize=" + boxCollider2D.size.ToString());
		}
		return true;
	}

	private void EnsureHookHitboxRuntimeForSlot(EquipRuntime slot)
	{
		if (IsHookEquip(slot))
		{
			TryEnsureHookHitboxRuntime(slot, out var _);
		}
	}

	private static void SyncHookHitboxPose(HookHitboxRuntime runtime, Vector2 worldPoint, Vector2 travelDirection)
	{
		if (runtime == null || runtime.root == null || runtime.collider == null)
		{
			throw new InvalidOperationException("[VehicleEquipSystem] Hook hitbox sync requires valid runtime.");
		}
		runtime.root.localPosition = Vector3.zero;
		runtime.root.localRotation = Quaternion.identity;
		runtime.root.localScale = Vector3.one;
		Vector3 position = new Vector3(worldPoint.x, worldPoint.y, runtime.root.position.z);
		Vector2 vector = runtime.root.InverseTransformPoint(position);
		runtime.collider.offset = HookHitboxDefaultLocalPosition + vector;
		runtime.collider.size = HookHitboxSize;
	}

	private void ClearBoxingGloveHitboxes()
	{
		foreach (KeyValuePair<int, BoxingGloveHitboxRuntime> item in boxingGloveHitboxBySlot)
		{
			BoxingGloveHitboxRuntime value = item.Value;
			if (value != null && !(value.root == null))
			{
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(value.root.gameObject);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(value.root.gameObject);
				}
			}
		}
		boxingGloveHitboxBySlot.Clear();
	}

	private void ClearHookHitboxes()
	{
		foreach (KeyValuePair<int, HookHitboxRuntime> item in hookHitboxBySlot)
		{
			HookHitboxRuntime value = item.Value;
			if (value == null)
			{
				continue;
			}
			ReleaseHookLatchFreeze(value, "clear_hook_hitboxes");
			if (!(value.root == null))
			{
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(value.root.gameObject);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(value.root.gameObject);
				}
			}
		}
		hookHitboxBySlot.Clear();
	}
}
