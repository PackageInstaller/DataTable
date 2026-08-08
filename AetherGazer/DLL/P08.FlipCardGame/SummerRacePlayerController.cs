using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

public class SummerRacePlayerController : SummerRaceCharacterBase, ISummerRaceBuildProfileProvider, ICombatStatusHost, IWeaponOwnerContext, ICombatSourceContext, IWeaponContinuousMeleeContextProvider, IEquipOwnerContext
{
	public sealed class BodyProfileOverrideSpec
	{
		public bool HasMaxHp;

		public float MaxHp;

		public bool HasCostCap;

		public int CostCap;

		public bool HasCruiseSpeed;

		public float CruiseSpeed;

		public bool HasForwardAcceleration;

		public float ForwardAcceleration;

		public bool HasMass;

		public float Mass;

		public bool HasDrag;

		public float Drag;

		public bool HasAngularDrag;

		public float AngularDrag;

		public bool HasGravityScale;

		public float GravityScale;

		public bool HasTractionGain;

		public float TractionGain;

		public bool HasCollisionImpulseScale;

		public float CollisionImpulseScale;

		public bool HasAnyOverride
		{
			get
			{
				if (!HasMaxHp && !HasCostCap && !HasCruiseSpeed && !HasForwardAcceleration && !HasMass && !HasDrag && !HasAngularDrag && !HasGravityScale && !HasTractionGain)
				{
					return HasCollisionImpulseScale;
				}
				return true;
			}
		}

		public BodyProfileOverrideSpec Clone()
		{
			return new BodyProfileOverrideSpec
			{
				HasMaxHp = HasMaxHp,
				MaxHp = MaxHp,
				HasCostCap = HasCostCap,
				CostCap = CostCap,
				HasCruiseSpeed = HasCruiseSpeed,
				CruiseSpeed = CruiseSpeed,
				HasForwardAcceleration = HasForwardAcceleration,
				ForwardAcceleration = ForwardAcceleration,
				HasMass = HasMass,
				Mass = Mass,
				HasDrag = HasDrag,
				Drag = Drag,
				HasAngularDrag = HasAngularDrag,
				AngularDrag = AngularDrag,
				HasGravityScale = HasGravityScale,
				GravityScale = GravityScale,
				HasTractionGain = HasTractionGain,
				TractionGain = TractionGain,
				HasCollisionImpulseScale = HasCollisionImpulseScale,
				CollisionImpulseScale = CollisionImpulseScale
			};
		}
	}

	public sealed class WeaponProfileOverrideSpec
	{
		public WeaponKind WeaponKind;

		public int Cost;

		public float EnergyCost;

		public int Damage;

		public float FireInterval;

		public bool HasBurnOverride;

		public int BurnDps;

		public float BurnDuration;

		public float[] EffectParams = Array.Empty<float>();

		public WeaponProfileOverrideSpec Clone()
		{
			return new WeaponProfileOverrideSpec
			{
				WeaponKind = WeaponKind,
				Cost = Cost,
				EnergyCost = EnergyCost,
				Damage = Damage,
				FireInterval = FireInterval,
				HasBurnOverride = HasBurnOverride,
				BurnDps = BurnDps,
				BurnDuration = BurnDuration,
				EffectParams = ((EffectParams != null) ? ((float[])EffectParams.Clone()) : Array.Empty<float>())
			};
		}
	}

	public sealed class EquipProfileOverrideSpec
	{
		public EquipKind EquipKind;

		public int Cost;

		public float EnergyCost;

		public EquipProfileOverrideSpec Clone()
		{
			return new EquipProfileOverrideSpec
			{
				EquipKind = EquipKind,
				Cost = Cost,
				EnergyCost = EnergyCost
			};
		}
	}

	private sealed class BodyProfile
	{
		public string Label;

		public int CostCap;

		public float MaxHP;

		public float Mass;

		public float Drag;

		public float AngularDrag;

		public float GravityScale;

		public float CruiseSpeed;

		public float ForwardAcceleration;

		public float TractionGain;

		public float CollisionImpulseScale;

		public Vector2 BodyComOffset;

		public Color BodyColor;

		public Vector3 BodyScale;

		public Vector2 FrontWheelPos;

		public Vector2 BackWheelPos;

		public float FrontWheelRadius;

		public float BackWheelRadius;
	}

	private sealed class WeaponRuntime
	{
		public SummerRaceWeaponDefSO Def;

		public CombatImpactPayload MeleeImpactPayload;
	}

	private readonly struct WeaponShotFeedbackProfile(WeaponKind weaponKind, float adsRecoilMultiplier, float recoilSpring, float recoilDamping, float recoilBackImpulse, float recoilUpImpulse, float recoilSideImpulse, float viewPunchUp, float viewPunchSide, float viewSpring, float viewDamping, bool enableShake, float shakeAmplitude, float shakeDuration)
	{
		public readonly WeaponKind WeaponKind = weaponKind;

		public readonly float AdsRecoilMultiplier = adsRecoilMultiplier;

		public readonly float RecoilSpring = recoilSpring;

		public readonly float RecoilDamping = recoilDamping;

		public readonly float RecoilBackImpulse = recoilBackImpulse;

		public readonly float RecoilUpImpulse = recoilUpImpulse;

		public readonly float RecoilSideImpulse = recoilSideImpulse;

		public readonly float ViewPunchUp = viewPunchUp;

		public readonly float ViewPunchSide = viewPunchSide;

		public readonly float ViewSpring = viewSpring;

		public readonly float ViewDamping = viewDamping;

		public readonly bool EnableShake = enableShake;

		public readonly float ShakeAmplitude = shakeAmplitude;

		public readonly float ShakeDuration = shakeDuration;
	}

	private sealed class EquipRuntime
	{
		public SummerRaceEquipDefSO Def;
	}

	private const int PlayerBodySortingOrder = 26;

	private const int PlayerWheelSortingOrder = 27;

	private const int PlayerAdminSortingOrder = 25;

	private const float PlayerBodyAuthoringToRuntimeXSign = -1f;

	private const string PlayerAdminRootName = "AdminRoot";

	private const string PlayerAdminSpineName = "AdminSpine";

	private const string PlayerBattleAdminSkeletonDataPath = "Assets/ABResources/SummerRaceActivity/Spine/Admin/Battle/SummerRace_admin_SkeletonData.asset";

	private const string PlayerBattleAdminSkinName = "1001";

	private const string PlayerBattleAdminIdleAnimationName = "idle";

	private const string PlayerBattleAdminInAnimationName = "out";

	private const string PlayerBattleAdminSpecialDefeatInAnimationName = "in";

	private static readonly Vector2 RuntimeBodyColliderLocalOffset = new Vector2(0f, -0.2f);

	private static readonly Vector2 PlayerBattleAdminUiCarContentPosition = new Vector2(-450f, -200f);

	private static readonly Vector2 PlayerBattleAdminUiCarContentSize = new Vector2(840f, 440f);

	private static readonly Vector2 PlayerBattleAdminLightUiPosition = new Vector2(-364f, -60f);

	private static readonly Vector2 PlayerBattleAdminMediumUiPosition = new Vector2(-430f, -44f);

	private static readonly Vector2 PlayerBattleAdminHeavyUiPosition = new Vector2(-528f, 20f);

	private const float PlayerBattleAdminLightBodyAnchorY = 0.35f;

	private const float PlayerBattleAdminMediumBodyAnchorY = 0.45f;

	private const float PlayerBattleAdminHeavyBodyAnchorY = 0.85f;

	[Header("Loadout")]
	[SerializeField]
	private string configuredBuildName = string.Empty;

	[SerializeField]
	private SummerRaceWeaponDefSO[] weaponConfigOverrides;

	[Header("Weapon Feel")]
	[SerializeField]
	private bool adsActive;

	[SerializeField]
	private bool debugWeaponGizmos = true;

	[SerializeField]
	private Vector2 weaponMountLocalOffset = new Vector2(0.5f, 0.12f);

	[SerializeField]
	private bool drawWheelContactDebug = true;

	[SerializeField]
	private Color playerBodyOutlineColor = new Color(0.2f, 0.7f, 1f, 0.95f);

	[SerializeField]
	private Color playerWheelOutlineColor = new Color(1f, 0.92f, 0.2f, 0.95f);

	[Header("Resources")]
	[SerializeField]
	private float maxEnergy = 10f;

	[SerializeField]
	private float damageToEnergyRatio = 0.25f;

	[SerializeField]
	private float energyRegenPerSecond = 1.8f;

	[SerializeField]
	private float manualAccelerationMax = 10f;

	[SerializeField]
	private bool invincibleForPhysicsTest;

	[SerializeField]
	private LayerMask driveContactMask = -1;

	[SerializeField]
	private float maxDriveAcceleration = 20f;

	[SerializeField]
	private float debugContactVectorLength = 0.34f;

	[Header("Auto Drive Control")]
	[SerializeField]
	private float autoDriveStopDistance = 0.45f;

	[SerializeField]
	private float autoDriveFullDistance = 2.4f;

	[SerializeField]
	private float throttleRiseRate = 4.5f;

	[SerializeField]
	private float throttleFallRate = 10f;

	[SerializeField]
	private float driveAuthorityRiseRate = 12f;

	[SerializeField]
	private float driveAuthorityFallRate = 6f;

	[Header("Wave Entry")]
	[SerializeField]
	private float waveEntryDropHeight = 2.2f;

	[Header("Debug")]
	private PolygonCollider2D poly;

	private Transform bodyVisual;

	private SkeletonAnimation bodySkeletonAnimation;

	private Transform playerAdminRoot;

	private SkeletonAnimation playerAdminSkeletonAnimation;

	private TrackEntry playerBattleAdminOpeningOutTrackEntry;

	private bool playerBattleAdminOpeningOutCompleted;

	private BodyProfile currentBodyProfile;

	private readonly List<WeaponRuntime> weaponSlots = new List<WeaponRuntime>();

	private readonly List<EquipRuntime> equipSlots = new List<EquipRuntime>();

	private readonly List<float> weaponOverloadActiveUntilBySlot = new List<float>();

	private readonly List<float> weaponOverloadCooldownUntilBySlot = new List<float>();

	private int currentCost;

	private float manualAccelerationInputNormalized;

	private bool movementLocked = true;

	private int autoMoveDirection;

	private Transform cachedTargetEnemy;

	private float nextTargetScanAt;

	private float smoothedDriveAcceleration;

	private float hintUntil;

	private string skillHint = string.Empty;

	private float nextCollisionLogAt;

	private float nextWheelVisualLogAt;

	private float smoothedThrottleInput;

	private float smoothedDriveSupportRatio;

	private float smoothedDriveAlignmentRatio;

	private float recoilPitch;

	private float recoilPitchVel;

	private float recoilYaw;

	private float recoilYawVel;

	private float recoilSpringK = 60f;

	private float recoilDamp = 12f;

	private Camera cachedMainCamera;

	private Vector3 cameraBasePos;

	private float cameraViewY;

	private float cameraViewYVel;

	private float cameraRoll;

	private float cameraRollVel;

	private float cameraSpringK = 48f;

	private float cameraDamp = 8f;

	private float cameraShakeTimer;

	private float cameraShakeDuration;

	private float cameraShakeAmplitude;

	[SerializeField]
	private bool enableWeaponCameraFeedback;

	private Vector3 cameraAppliedOffset;

	private readonly Dictionary<WeaponKind, SummerRaceWeaponDefSO> weaponConfigLookup = new Dictionary<WeaponKind, SummerRaceWeaponDefSO>(8);

	private int lastFiredWeaponSlot = -1;

	private SummerRaceBuildProfile cachedBuildProfile;

	private SummerRaceBuildRating cachedBuildRating;

	private SummerRaceBuildArchetype cachedBuildArchetype;

	private string cachedBuildSummary = "Build -";

	private string cachedBuildSignature = "-";

	private bool runtimePreparedForBattle;

	private float stunUntil;

	private float disarmUntil;

	private bool hookLatchMovementFrozen;

	private float slowUntil;

	private float slowMoveMultiplier = 1f;

	private int burnDps;

	private float burnUntil;

	private float nextBurnTickAt;

	private ICombatSourceContext burnSourceContext;

	private CombatImpactPayload burnTickImpactPayload;

	private string lastSkillAction = string.Empty;

	private string lastSkillReason = string.Empty;

	private int lastSkillSlotIndex = -1;

	private bool lastSkillSuccess;

	private bool hasRuntimeBuildOverride;

	private SummerRaceBodyType runtimeOverrideBodyType = SummerRaceBodyType.Medium;

	private WeaponKind[] runtimeOverrideWeapons = Array.Empty<WeaponKind>();

	private int[] runtimeOverrideWeaponSlotIndices = Array.Empty<int>();

	private WeaponProfileOverrideSpec[] runtimeWeaponProfileOverrides = Array.Empty<WeaponProfileOverrideSpec>();

	private EquipKind[] runtimeOverrideEquips = Array.Empty<EquipKind>();

	private int[] runtimeOverrideEquipSlotIndices = Array.Empty<int>();

	private EquipProfileOverrideSpec[] runtimeEquipProfileOverrides = Array.Empty<EquipProfileOverrideSpec>();

	private BodyProfileOverrideSpec runtimeBodyProfileOverride;

	private readonly List<SummerRaceWeaponDefSO> runtimeClonedWeaponDefs = new List<SummerRaceWeaponDefSO>(8);

	private readonly List<SummerRaceEquipDefSO> runtimeClonedEquipDefs = new List<SummerRaceEquipDefSO>(5);

	public float CurrentHP => currentHP;

	public float MaxHP
	{
		get
		{
			if (!Application.isPlaying)
			{
				if (currentBodyProfile == null)
				{
					return 1f;
				}
				return currentBodyProfile.MaxHP;
			}
			return RequireCurrentBodyProfile("Player.MaxHP").MaxHP;
		}
	}

	public float CurrentEnergy => currentEnergy;

	public float MaxEnergy => maxEnergy;

	public float CurrentSpeedX => RequirePhysicsBodyReady("Player.CurrentSpeedX").velocity.x;

	public float MaxSpeedX
	{
		get
		{
			if (!Application.isPlaying)
			{
				if (currentBodyProfile == null)
				{
					return 8f;
				}
				return currentBodyProfile.CruiseSpeed * 2.1f;
			}
			return RequireCurrentBodyProfile("Player.MaxSpeedX").CruiseSpeed * 2.1f;
		}
	}

	public float ManualAccelerationNormalized => manualAccelerationInputNormalized;

	public float ManualAcceleration => manualAccelerationInputNormalized * manualAccelerationMax;

	public int WeaponSlotCount
	{
		get
		{
			if (!(modularWeaponSystem != null))
			{
				return 0;
			}
			return modularWeaponSystem.WeaponCount;
		}
	}

	public int EquipSlotCount => equipSlots.Count;

	public int CurrentCost => currentCost;

	public int CostCap
	{
		get
		{
			if (!Application.isPlaying)
			{
				if (currentBodyProfile == null)
				{
					return 0;
				}
				return currentBodyProfile.CostCap;
			}
			return RequireCurrentBodyProfile("Player.CostCap").CostCap;
		}
	}

	public string SkillHint => skillHint;

	public string LastSkillAction => lastSkillAction;

	public string LastSkillReason => lastSkillReason;

	public int LastSkillSlotIndex => lastSkillSlotIndex;

	public bool LastSkillSuccess => lastSkillSuccess;

	public string BodyLabel
	{
		get
		{
			if (!Application.isPlaying)
			{
				if (currentBodyProfile == null)
				{
					return bodyType.ToString();
				}
				return currentBodyProfile.Label;
			}
			return RequireCurrentBodyProfile("Player.BodyLabel").Label;
		}
	}

	public bool IsAdsActive => adsActive;

	public float DebugSpread => ResolveDebugSpread();

	public float DebugRecoil => recoilKick;

	public string BuildSummary => ResolveBuildSummary();

	public SummerRaceBuildArchetype BuildArchetype => cachedBuildArchetype;

	public string BuildSignature => cachedBuildSignature;

	public string DebugExplainabilityEvent => FormatExplainabilityEventLabel();

	public string DebugWheelContactSummary => "F:" + SummerRaceCharacterBase.DescribeWheelContact(lastFrontWheelContact) + " B:" + SummerRaceCharacterBase.DescribeWheelContact(lastBackWheelContact);

	public bool IsSkillInputBlocked
	{
		get
		{
			if (!hookLatchMovementFrozen)
			{
				return Time.time < stunUntil;
			}
			return true;
		}
	}

	public Transform CombatSourceTransform => base.transform;

	public Rigidbody2D CombatSourceRigidbody
	{
		get
		{
			if (!Application.isPlaying)
			{
				return rb;
			}
			return RequirePhysicsBodyReady("Player.CombatSourceRigidbody");
		}
	}

	public Transform CombatTransform => base.transform;

	public Rigidbody2D CombatRigidbody
	{
		get
		{
			if (!Application.isPlaying)
			{
				return rb;
			}
			return RequirePhysicsBodyReady("Player.CombatRigidbody");
		}
	}

	public SummerRaceBodyType CombatBodyType => bodyType;

	public SummerRaceCombatTeam CombatTeam => SummerRaceCombatTeam.Player;

	public bool OverclockDamageTextActive => false;

	public bool IsCombatAlive
	{
		get
		{
			if (currentHP > 0f && base.gameObject != null)
			{
				return base.gameObject.activeInHierarchy;
			}
			return false;
		}
	}

	private float RuntimeDebugLineDuration
	{
		get
		{
			float num = (Application.isPlaying ? Time.fixedDeltaTime : 0.02f);
			return Mathf.Max(debugLinePersistSeconds, num * 1.8f);
		}
	}

	private float WheelDebugLineDuration => 0f;

	public SummerRaceBuildProfile GetBuildProfile()
	{
		return cachedBuildProfile;
	}

	public void SetConfiguredBuildNameForRuntime(string buildName)
	{
		if (string.IsNullOrWhiteSpace(buildName))
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime build name must not be empty.");
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime build override must happen before RuntimePrepareForBattle.");
		}
		hasRuntimeBuildOverride = false;
		runtimeOverrideWeapons = Array.Empty<WeaponKind>();
		runtimeOverrideWeaponSlotIndices = Array.Empty<int>();
		runtimeWeaponProfileOverrides = Array.Empty<WeaponProfileOverrideSpec>();
		runtimeOverrideEquips = Array.Empty<EquipKind>();
		runtimeOverrideEquipSlotIndices = Array.Empty<int>();
		runtimeEquipProfileOverrides = Array.Empty<EquipProfileOverrideSpec>();
		runtimeBodyProfileOverride = null;
		ClearRuntimeWeaponConfigOverrides();
		ClearRuntimeEquipConfigOverrides();
		configuredBuildName = buildName.Trim();
	}

	public void SetRuntimeBuildOverride(SummerRaceBodyType bodyTypeOverride, WeaponKind[] weapons, WeaponProfileOverrideSpec[] weaponProfileOverrides, EquipKind[] equips, EquipProfileOverrideSpec[] equipProfileOverrides, BodyProfileOverrideSpec bodyProfileOverride = null, int[] weaponSlotIndices = null, int[] equipSlotIndices = null)
	{
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime build override must happen before RuntimePrepareForBattle.");
		}
		hasRuntimeBuildOverride = true;
		runtimeOverrideBodyType = bodyTypeOverride;
		runtimeOverrideWeapons = ((weapons != null && weapons.Length != 0) ? ((WeaponKind[])weapons.Clone()) : Array.Empty<WeaponKind>());
		runtimeOverrideWeaponSlotIndices = CloneRuntimeSlotIndices(weaponSlotIndices, runtimeOverrideWeapons.Length, "weapon");
		runtimeWeaponProfileOverrides = CloneWeaponProfileOverrides(weaponProfileOverrides);
		if (runtimeWeaponProfileOverrides.Length != 0 && runtimeWeaponProfileOverrides.Length != runtimeOverrideWeapons.Length)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime weapon override count mismatch: weapons=" + runtimeOverrideWeapons.Length + " overrides=" + runtimeWeaponProfileOverrides.Length);
		}
		runtimeOverrideEquips = ((equips != null && equips.Length != 0) ? ((EquipKind[])equips.Clone()) : Array.Empty<EquipKind>());
		runtimeOverrideEquipSlotIndices = CloneRuntimeSlotIndices(equipSlotIndices, runtimeOverrideEquips.Length, "equip");
		runtimeEquipProfileOverrides = CloneEquipProfileOverrides(equipProfileOverrides);
		if (runtimeEquipProfileOverrides.Length != 0 && runtimeEquipProfileOverrides.Length != runtimeOverrideEquips.Length)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime equip override count mismatch: equips=" + runtimeOverrideEquips.Length + " overrides=" + runtimeEquipProfileOverrides.Length);
		}
		runtimeBodyProfileOverride = ((bodyProfileOverride != null && bodyProfileOverride.HasAnyOverride) ? bodyProfileOverride.Clone() : null);
		ClearRuntimeWeaponConfigOverrides();
		ClearRuntimeEquipConfigOverrides();
	}

	private static int[] CloneRuntimeSlotIndices(int[] slotIndices, int moduleCount, string slotTypeLabel)
	{
		if (moduleCount <= 0)
		{
			return Array.Empty<int>();
		}
		if (slotIndices == null || slotIndices.Length == 0)
		{
			int[] array = new int[moduleCount];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = i;
			}
			return array;
		}
		if (slotIndices.Length != moduleCount)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime " + slotTypeLabel + " slot index count mismatch: slots=" + slotIndices.Length + " modules=" + moduleCount);
		}
		int[] array2 = (int[])slotIndices.Clone();
		for (int j = 0; j < array2.Length; j++)
		{
			if (array2[j] < 0)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime " + slotTypeLabel + " slot index must be >= 0. index=" + j + " slot=" + array2[j]);
			}
		}
		return array2;
	}

	private static WeaponProfileOverrideSpec[] CloneWeaponProfileOverrides(WeaponProfileOverrideSpec[] overrides)
	{
		if (overrides == null || overrides.Length == 0)
		{
			return Array.Empty<WeaponProfileOverrideSpec>();
		}
		WeaponProfileOverrideSpec[] array = new WeaponProfileOverrideSpec[overrides.Length];
		for (int i = 0; i < overrides.Length; i++)
		{
			if (overrides[i] == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime weapon override contains null entry. index=" + i);
			}
			array[i] = overrides[i].Clone();
		}
		return array;
	}

	private static EquipProfileOverrideSpec[] CloneEquipProfileOverrides(EquipProfileOverrideSpec[] overrides)
	{
		if (overrides == null || overrides.Length == 0)
		{
			return Array.Empty<EquipProfileOverrideSpec>();
		}
		EquipProfileOverrideSpec[] array = new EquipProfileOverrideSpec[overrides.Length];
		for (int i = 0; i < overrides.Length; i++)
		{
			if (overrides[i] == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime equip override contains null entry. index=" + i);
			}
			array[i] = overrides[i].Clone();
		}
		return array;
	}

	private void ClearRuntimeWeaponConfigOverrides()
	{
		for (int i = 0; i < runtimeClonedWeaponDefs.Count; i++)
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = runtimeClonedWeaponDefs[i];
			if (!(summerRaceWeaponDefSO == null))
			{
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(summerRaceWeaponDefSO);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(summerRaceWeaponDefSO);
				}
			}
		}
		runtimeClonedWeaponDefs.Clear();
	}

	private void ClearRuntimeEquipConfigOverrides()
	{
		for (int i = 0; i < runtimeClonedEquipDefs.Count; i++)
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = runtimeClonedEquipDefs[i];
			if (!(summerRaceEquipDefSO == null))
			{
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(summerRaceEquipDefSO);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(summerRaceEquipDefSO);
				}
			}
		}
		runtimeClonedEquipDefs.Clear();
	}

	public bool TryApplyCombatEffect(CombatEffectSpec effect, Vector2 hitDirection, ICombatSourceContext sourceContext, out int damageDealt)
	{
		damageDealt = 0;
		SummerRaceFightManager instance = SummerRaceFightManager.Instance;
		if (effect == null || !IsCombatAlive || (instance != null && !instance.IsBattleActive))
		{
			return false;
		}
		switch (effect.effectKind)
		{
		case CombatEffectKind.Damage:
		{
			int num = Mathf.Max(0, Mathf.RoundToInt(effect.magnitude));
			if (num <= 0)
			{
				return false;
			}
			float num2 = currentHP;
			TakeDamage(num);
			int num3 = Mathf.Max(0, Mathf.RoundToInt(num2 - currentHP));
			if (num3 <= 0)
			{
				return false;
			}
			damageDealt = num3;
			sourceContext?.NotifyCombatDamageDealt(num3);
			SummerRaceLuaBridge.PushDamageTextEvent(num3, CombatTeam, (CombatTransform != null) ? CombatTransform.position : Vector3.zero, effect.trigger.ToString(), sourceContext);
			return true;
		}
		case CombatEffectKind.Knockback:
			return TryApplyKnockbackEffect(hitDirection, effect.magnitude, sourceContext);
		case CombatEffectKind.Stun:
			stunUntil = Mathf.Max(stunUntil, Time.time + Mathf.Max(0f, effect.duration));
			return effect.duration > 0f;
		case CombatEffectKind.Slow:
			slowMoveMultiplier = Mathf.Clamp(effect.magnitude, 0.2f, 1f);
			slowUntil = Mathf.Max(slowUntil, Time.time + Mathf.Max(0f, effect.duration));
			return effect.duration > 0f;
		case CombatEffectKind.Burn:
			burnDps = Mathf.Max(burnDps, Mathf.RoundToInt(effect.magnitude));
			burnUntil = Mathf.Max(burnUntil, Time.time + Mathf.Max(0f, effect.duration));
			burnSourceContext = sourceContext;
			burnTickImpactPayload = SummerRaceCombatEffectFactory.CreateDamageImpactPayload(burnDps, CombatTriggerType.StatusTick);
			nextBurnTickAt = Mathf.Min((nextBurnTickAt > 0f) ? nextBurnTickAt : float.PositiveInfinity, Time.time + 0.1f);
			if (burnDps > 0)
			{
				return effect.duration > 0f;
			}
			return false;
		case CombatEffectKind.Disarm:
			disarmUntil = Mathf.Max(disarmUntil, Time.time + Mathf.Max(0f, effect.duration));
			if (modularWeaponSystem != null)
			{
				modularWeaponSystem.ForceInterruptActiveFire("player_disarm");
			}
			return effect.duration > 0f;
		case CombatEffectKind.SelfDash:
			ApplySelfDashEffect(effect.magnitude, effect.duration);
			if (!(effect.duration > 0f))
			{
				return effect.magnitude > 0f;
			}
			return true;
		case CombatEffectKind.PullTarget:
			return TryApplyPullTargetEffect(sourceContext, effect.magnitude);
		case CombatEffectKind.Shield:
			shieldUntil = Mathf.Max(shieldUntil, Time.time + Mathf.Max(0f, effect.duration));
			return effect.duration > 0f;
		default:
			return false;
		}
	}

	private void EnsureCurrentBodyProfileInitialized(string context)
	{
		if (currentBodyProfile == null && Application.isPlaying)
		{
			ApplyConfiguredBuildDefinition();
			ApplyBodyProfile();
			if (currentBodyProfile != null)
			{
				SummerRaceRuntimeLog.Warning("[SummerRace][Player] Rebuilt missing body profile (" + context + ").");
			}
		}
	}

	private BodyProfile RequireCurrentBodyProfile(string context)
	{
		EnsureCurrentBodyProfileInitialized(context);
		if (currentBodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body profile is missing (" + context + ").");
		}
		return currentBodyProfile;
	}

	public void NotifyCombatDamageDealt(int amount)
	{
	}

	public bool CanSpendWeaponEnergy(float amount)
	{
		if (Time.time >= disarmUntil)
		{
			return currentEnergy >= Mathf.Max(0f, amount);
		}
		return false;
	}

	public void SpendWeaponEnergy(float amount)
	{
		currentEnergy = Mathf.Max(0f, currentEnergy - Mathf.Max(0f, amount));
	}

	public void RefundWeaponEnergy(float amount)
	{
		currentEnergy = Mathf.Clamp(currentEnergy + Mathf.Max(0f, amount), 0f, maxEnergy);
	}

	public float ResolveWeaponOverloadUntil(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return 0f;
		}
		return weaponOverloadActiveUntilBySlot[slotIndex];
	}

	public float ResolveWeaponOverloadCooldownUntil(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return 0f;
		}
		return weaponOverloadCooldownUntilBySlot[slotIndex];
	}

	public void OnWeaponRuntimeFire(int slotIndex, SummerRaceWeaponSpec spec)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid weapon slot fired. slot=" + slotIndex);
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		if (weaponRuntime == null || weaponRuntime.Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while handling weapon fire. slot=" + slotIndex);
		}
		WeaponShotFeedbackProfile feedbackProfile = ResolveWeaponShotFeedbackProfile(weaponRuntime.Def);
		float volleyFeedbackMultiplier = ResolveVolleyFeedbackMultiplier(weaponRuntime.Def);
		ApplyWeaponShotFeedback(feedbackProfile, volleyFeedbackMultiplier);
		lastFiredWeaponSlot = slotIndex;
	}

	public bool TryResolveContinuousMeleeContext(int slotIndex, SummerRaceWeaponSpec spec, out Vector2 attackOrigin, out Vector2 attackDirection)
	{
		attackOrigin = Vector2.zero;
		attackDirection = Vector2.zero;
		if (!IsValidWeaponSlot(slotIndex))
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid continuous melee slot. slot=" + slotIndex);
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.TryResolveContinuousMeleeContext");
		attackDirection = GetWeaponForwardVector();
		if (rigidbody2D.velocity.sqrMagnitude > 0.02f)
		{
			attackDirection = rigidbody2D.velocity.normalized;
		}
		if (attackDirection.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Continuous melee direction is invalid. slot=" + slotIndex);
		}
		attackOrigin = rigidbody2D.position + Vector2.up * 0.05f;
		return true;
	}

	public float ResolveContinuousMeleeTickInterval(int slotIndex, SummerRaceWeaponSpec spec)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid continuous melee cadence slot. slot=" + slotIndex);
		}
		return 0.16f;
	}

	public bool CanSpendEquipEnergy(float amount)
	{
		return currentEnergy >= Mathf.Max(0f, amount);
	}

	public void SpendEquipEnergy(float amount)
	{
		currentEnergy = Mathf.Max(0f, currentEnergy - Mathf.Max(0f, amount));
	}

	public bool CanActivateEquip()
	{
		if (!movementLocked && !hookLatchMovementFrozen && currentHP > 0f)
		{
			return Time.time >= stunUntil;
		}
		return false;
	}

	public void SetHookLatchMovementFreeze(bool frozen, string reason)
	{
		if (hookLatchMovementFrozen == frozen)
		{
			return;
		}
		hookLatchMovementFrozen = frozen;
		if (frozen)
		{
			smoothedDriveAcceleration = 0f;
			smoothedThrottleInput = 0f;
			autoMoveDirection = 0;
			cachedTargetEnemy = null;
			nextTargetScanAt = 0f;
			if (runtimePreparedForBattle)
			{
				RequireModularBackendReady("Player.SetHookLatchMovementFreeze");
				ApplyModularDrive(0f, 0f);
			}
		}
		SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][FreezeState] host=Player frozen=" + frozen + " reason=" + (reason ?? string.Empty));
	}

	public SummerRaceBuildRating GetBuildRating()
	{
		return cachedBuildRating;
	}

	public SummerRaceBuildBlueprint ExportRuntimeBlueprint()
	{
		return new SummerRaceBuildBlueprint
		{
			SourceTag = cachedBuildProfile.SourceTag,
			BodyType = bodyType,
			Weapons = ((cachedBuildProfile.Weapons != null) ? ((WeaponKind[])cachedBuildProfile.Weapons.Clone()) : Array.Empty<WeaponKind>()),
			Equips = ((cachedBuildProfile.Equips != null) ? ((EquipKind[])cachedBuildProfile.Equips.Clone()) : Array.Empty<EquipKind>()),
			Rating = cachedBuildRating,
			Archetype = cachedBuildArchetype,
			Signature = SummerRaceBuildScoring.BuildSignature(cachedBuildProfile)
		};
	}

	private new void Awake()
	{
		base.Awake();
		EnsureRuntimeRefs();
	}

	private void OnValidate()
	{
		driveContactFilter = new ContactFilter2D
		{
			useLayerMask = true,
			layerMask = driveContactMask,
			useTriggers = false
		};
	}

	private void EnsureRuntimeRefs()
	{
		rb = GetComponent<Rigidbody2D>();
		poly = GetComponent<PolygonCollider2D>();
		EnsureBodyVisualRefs();
		driveContactFilter = new ContactFilter2D
		{
			useLayerMask = true,
			layerMask = driveContactMask,
			useTriggers = false
		};
	}

	private new void Update()
	{
		TickCombatStatusRuntime();
		TickHintState();
		TickEnergyRegen();
	}

	private new void LateUpdate()
	{
		TickWeaponFeedbackVisual(Time.deltaTime);
	}

	private void OnDisable()
	{
		if (cachedMainCamera != null)
		{
			cachedMainCamera.transform.position -= cameraAppliedOffset;
			cameraAppliedOffset = Vector3.zero;
		}
	}

	private new void FixedUpdate()
	{
		if (runtimePreparedForBattle)
		{
			RequireModularBackendReady("Player.FixedUpdate");
			Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.FixedUpdate");
			bool num = !movementLocked && !hookLatchMovementFrozen && (SummerRaceFightManager.Instance == null || SummerRaceFightManager.Instance.IsBattleActive);
			Vector2 vector = SummerRaceCharacterBase.ResolveSmoothedDriveAuthorityPair(smoothedDriveSupportRatio, smoothedDriveAlignmentRatio, ComputeRawDriveSupportRatio(), ComputeRawDriveAlignmentRatio(), driveAuthorityRiseRate, driveAuthorityFallRate, Time.fixedDeltaTime);
			smoothedDriveSupportRatio = vector.x;
			smoothedDriveAlignmentRatio = vector.y;
			float driveAcceleration = (num ? ResolveDriveAcceleration() : 0f);
			ApplyDrivePhysics(driveAcceleration);
			ApplyThrusterSustainedForce(Time.fixedDeltaTime);
			ApplyOutOfBoundsGuard("Player.FixedUpdate");
			TickWeaponFireSpawnLock(Time.fixedDeltaTime);
			TickAutoWeaponFire();
			UpdateWheelVisual(rigidbody2D.velocity.x, Time.fixedDeltaTime);
			SetModularAimDirection(GetWeaponForwardVector());
			EmitDebugState(driveAcceleration);
		}
	}

	public void SetLaneY(float value)
	{
		laneY = value;
		SnapToLaneImmediate();
	}

	public override float ResolveLaneYFromGround(float groundTopY)
	{
		float num = Mathf.Max(0.08f, (frontWheelRadius + backWheelRadius) * 0.5f);
		float num2 = Mathf.Lerp(Mathf.Max(0.05f, (GetSuspensionReach(frontWheelRadius) + GetSuspensionReach(backWheelRadius)) * 0.5f), 0f, Mathf.Clamp01(spawnCompressionNormalized));
		float num3 = Mathf.Min(frontWheelLocal.y, backWheelLocal.y);
		float num4 = Mathf.Max(0.01f, Mathf.Abs(base.transform.lossyScale.y));
		float num5 = num3 * num4;
		return groundTopY + num + num2 - num5;
	}

	public void RuntimePrepareForBattle(float laneYValue)
	{
		if (rb == null || poly == null || bodyVisual == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime refs missing before battle prepare.");
		}
		laneY = laneYValue;
		ApplyConfiguredBuildDefinition();
		ApplyBodyProfile();
		BuildLoadout();
		maxEnergy = Mathf.Clamp(maxEnergy, 8f, 12f);
		currentHP = MaxHP;
		currentEnergy = 0f;
		movementLocked = false;
		manualAccelerationInputNormalized = 0f;
		burnDps = 0;
		burnUntil = 0f;
		nextBurnTickAt = 0f;
		burnSourceContext = null;
		burnTickImpactPayload = null;
		shieldUntil = 0f;
		thrusterUntil = 0f;
		thrusterBoostStrength = 0f;
		thrusterImpulseGuardUntil = 0f;
		cachedTargetEnemy = null;
		skillHint = string.Empty;
		hintUntil = 0f;
		recoilKick = (recoilKickVel = 0f);
		recoilPitch = (recoilPitchVel = 0f);
		recoilYaw = (recoilYawVel = 0f);
		smoothedDriveAcceleration = 0f;
		smoothedDriveSupportRatio = 0f;
		smoothedDriveAlignmentRatio = 0f;
		cameraViewY = (cameraViewYVel = 0f);
		cameraRoll = (cameraRollVel = 0f);
		cameraShakeTimer = 0f;
		cameraShakeDuration = 0f;
		cameraShakeAmplitude = 0f;
		lastFiredWeaponSlot = -1;
		nextDebugLogAt = 0f;
		nextCollisionLogAt = 0f;
		SnapToLaneImmediate();
		ResetWeaponFireSpawnLock();
		runtimePreparedForBattle = true;
		RecordExplainabilityEvent("Ready", "body=" + BodyLabel + " sig=" + cachedBuildSignature, logToConsole: false);
	}

	public void ResetRuntimePreparationForBattleRestart()
	{
		if (modularEquipSystem != null)
		{
			modularEquipSystem.ForceResetHookStates("battle_restart");
		}
		runtimePreparedForBattle = false;
		movementLocked = true;
		hookLatchMovementFrozen = false;
		manualAccelerationInputNormalized = 0f;
		cachedTargetEnemy = null;
		adsActive = false;
		skillHint = string.Empty;
		hintUntil = 0f;
		stunUntil = 0f;
		disarmUntil = 0f;
		slowUntil = 0f;
		slowMoveMultiplier = 1f;
		burnDps = 0;
		burnUntil = 0f;
		nextBurnTickAt = 0f;
		burnSourceContext = null;
		burnTickImpactPayload = null;
		shieldUntil = 0f;
		thrusterUntil = 0f;
		thrusterBoostStrength = 0f;
		thrusterImpulseGuardUntil = 0f;
		lastFiredWeaponSlot = -1;
		lastSkillAction = string.Empty;
		lastSkillReason = string.Empty;
		lastSkillSlotIndex = -1;
		lastSkillSuccess = false;
		smoothedThrottleInput = 0f;
		smoothedDriveAcceleration = 0f;
		smoothedDriveSupportRatio = 0f;
		smoothedDriveAlignmentRatio = 0f;
		ResetWeaponFireSpawnLock();
		autoMoveDirection = 0;
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.ResetRuntimePreparationForBattleRestart");
		rigidbody2D.velocity = Vector2.zero;
		rigidbody2D.angularVelocity = 0f;
	}

	public void EnsureModularBackendInitialized()
	{
		if (!runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] RuntimePrepareForBattle must run before modular backend initialization.");
		}
		RebuildModularBackend();
	}

	public void SetMovementLocked(bool locked)
	{
		movementLocked = locked;
		if (locked && runtimePreparedForBattle)
		{
			RequireModularBackendReady("Player.SetMovementLocked");
			ApplyModularDrive(0f, 0f);
		}
	}

	public void RequestSetManualAccelerationNormalized(float normalized)
	{
		manualAccelerationInputNormalized = Mathf.Clamp(normalized, -1f, 1f);
	}

	public bool IsWeaponSlotAutoFire(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return false;
		}
		if (TryGetWeaponSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return snapshot.IsAutoFire;
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while resolving auto-fire semantics. slot=" + slotIndex);
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		if (weaponRuntime == null || weaponRuntime.Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while resolving auto-fire semantics. slot=" + slotIndex);
		}
		return weaponRuntime.Def.fireMode == SummerRaceWeaponFireModeConfig.FullAuto;
	}

	public void RequestToggleAds()
	{
		adsActive = !adsActive;
		SetSkillHint(adsActive ? "ADS ON" : "ADS OFF", 0.6f);
	}

	public void SetInvincibleForPhysicsTest(bool value)
	{
		invincibleForPhysicsTest = value;
	}

	public void RestoreToFullBetweenWaves()
	{
		RestoreToFullBetweenWaves(float.NaN);
	}

	public void RestoreToFullBetweenWaves(float spawnX)
	{
		ResetBetweenWavesCore(spawnX, restoreFullHp: true, 0f);
	}

	public void RestoreToFullBetweenWaves(float spawnX, float spawnY)
	{
		ResetBetweenWavesCore(spawnX, restoreFullHp: true, 0f, spawnY);
	}

	public void RestorePartialHpBetweenWaves(float healRatio, float spawnX)
	{
		ResetBetweenWavesCore(spawnX, restoreFullHp: false, healRatio);
	}

	public void RestorePartialHpBetweenWaves(float healRatio, float spawnX, float spawnY)
	{
		ResetBetweenWavesCore(spawnX, restoreFullHp: false, healRatio, spawnY);
	}

	public float ResolveWaveEntrySpawnY()
	{
		return ResolveWaveEntrySpawnYFromBase(ResolveWaveEntryBaseSpawnY("Player.ResolveWaveEntrySpawnY"));
	}

	public void SetDamageToEnergyRatio(float ratio)
	{
		if (float.IsNaN(ratio) || float.IsInfinity(ratio) || ratio < 0f)
		{
			throw new InvalidOperationException("[SummerRace][Player] damageToEnergyRatio must be finite and >= 0, got " + ratio);
		}
		damageToEnergyRatio = ratio;
	}

	public void SetEnergyRegenPerSecond(float regenPerSecond)
	{
		if (float.IsNaN(regenPerSecond) || float.IsInfinity(regenPerSecond) || regenPerSecond < 0f)
		{
			throw new InvalidOperationException("[SummerRace][Player] energyRegenPerSecond must be finite and >= 0, got " + regenPerSecond);
		}
		energyRegenPerSecond = regenPerSecond;
	}

	public void SetMaxEnergy(float value)
	{
		if (float.IsNaN(value) || float.IsInfinity(value) || value <= 0f)
		{
			throw new InvalidOperationException("[SummerRace][Player] maxEnergy must be finite and > 0, got " + value);
		}
		maxEnergy = value;
		currentEnergy = Mathf.Clamp(currentEnergy, 0f, maxEnergy);
	}

	public void RestoreEnergyForWaveEntrySnapshot(float energy)
	{
		if (float.IsNaN(energy) || float.IsInfinity(energy))
		{
			throw new InvalidOperationException("[SummerRace][Player] wave entry energy must be finite, got " + energy);
		}
		currentEnergy = Mathf.Clamp(energy, 0f, maxEnergy);
	}

	private void ResetBetweenWavesCore(float spawnX, bool restoreFullHp, float healRatio)
	{
		ResetBetweenWavesCore(spawnX, restoreFullHp, healRatio, float.NaN);
	}

	private void ResetBetweenWavesCore(float spawnX, bool restoreFullHp, float healRatio, float spawnY)
	{
		if (modularEquipSystem != null)
		{
			modularEquipSystem.ForceResetHookStates("wave_transition");
		}
		if (restoreFullHp)
		{
			currentHP = MaxHP;
		}
		else
		{
			float num = MaxHP * Mathf.Clamp01(healRatio);
			currentHP = Mathf.Clamp(currentHP + num, 0f, MaxHP);
		}
		currentEnergy = Mathf.Clamp(currentEnergy, 0f, maxEnergy);
		movementLocked = true;
		hookLatchMovementFrozen = false;
		manualAccelerationInputNormalized = 0f;
		cachedTargetEnemy = null;
		nextTargetScanAt = 0f;
		autoMoveDirection = 0;
		smoothedThrottleInput = 0f;
		smoothedDriveAcceleration = 0f;
		smoothedDriveSupportRatio = 0f;
		smoothedDriveAlignmentRatio = 0f;
		stunUntil = 0f;
		disarmUntil = 0f;
		slowUntil = 0f;
		slowMoveMultiplier = 1f;
		burnDps = 0;
		burnUntil = 0f;
		nextBurnTickAt = 0f;
		burnSourceContext = null;
		burnTickImpactPayload = null;
		shieldUntil = 0f;
		thrusterUntil = 0f;
		thrusterBoostStrength = 0f;
		thrusterImpulseGuardUntil = 0f;
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			weaponOverloadActiveUntilBySlot[i] = 0f;
			weaponOverloadCooldownUntilBySlot[i] = 0f;
		}
		if (float.IsNaN(spawnX))
		{
			SnapToLaneImmediate();
		}
		else
		{
			SnapToWaveEntryAtX(spawnX, spawnY);
		}
		ResetWeaponFireSpawnLock();
	}

	public void TakeDamage(int amount)
	{
		if (amount <= 0 || invincibleForPhysicsTest)
		{
			return;
		}
		if (Time.time < shieldUntil)
		{
			SetSkillHint("Shield active", 0.5f);
			return;
		}
		currentHP = Mathf.Max(0f, currentHP - (float)amount);
		if (!(currentHP > 0f))
		{
			currentHP = 0f;
			movementLocked = true;
			if (SummerRaceFightManager.Instance != null)
			{
				SummerRaceFightManager.Instance.OnPlayerDefeated();
			}
		}
	}

	public bool IsWeaponSlotReady(int slotIndex)
	{
		RequireModularBackendReady("IsWeaponSlotReady");
		return modularWeaponSystem.IsSlotReady(slotIndex);
	}

	public float GetWeaponSlotEnergyCost(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return 0f;
		}
		if (TryGetWeaponSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.EnergyCost);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while resolving energy cost. slot=" + slotIndex);
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		if (weaponRuntime == null || weaponRuntime.Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while resolving energy cost. slot=" + slotIndex);
		}
		return Mathf.Max(0f, weaponRuntime.Def.energyCost);
	}

	public float GetWeaponSlotCooldownDuration(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return 0f;
		}
		if (TryGetWeaponSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.FireInterval);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while resolving cooldown duration. slot=" + slotIndex);
		}
		WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
		if (weaponRuntime == null || weaponRuntime.Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while resolving cooldown duration. slot=" + slotIndex);
		}
		return Mathf.Max(0f, weaponRuntime.Def.modularFireInterval);
	}

	public float GetWeaponSlotCooldownRemain(int slotIndex)
	{
		RequireModularBackendReady("GetWeaponSlotCooldownRemain");
		return modularWeaponSystem.GetSlotCooldownRemaining(slotIndex);
	}

	public string GetWeaponSlotLabel(int slotIndex)
	{
		RequireModularBackendReady("GetWeaponSlotLabel");
		string slotLabel = modularWeaponSystem.GetSlotLabel(slotIndex);
		if (!IsValidWeaponSlot(slotIndex))
		{
			return slotLabel;
		}
		string text = (IsWeaponSlotOverloaded(slotIndex) ? " OVL" : string.Empty);
		return slotLabel + text;
	}

	public bool IsWeaponSlotOverloaded(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return false;
		}
		return Time.time < ResolveWeaponOverloadUntil(slotIndex);
	}

	public float GetWeaponSlotOverloadRemaining(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return 0f;
		}
		return Mathf.Max(0f, ResolveWeaponOverloadCooldownUntil(slotIndex) - Time.time);
	}

	public float GetWeaponSlotOverloadActiveRemaining(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return 0f;
		}
		return Mathf.Max(0f, ResolveWeaponOverloadUntil(slotIndex) - Time.time);
	}

	public bool CanTriggerWeaponOverload(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			return false;
		}
		if (movementLocked || hookLatchMovementFrozen || currentHP <= 0f || Time.time < stunUntil)
		{
			return false;
		}
		RequireModularBackendReady("Player.CanTriggerWeaponOverload");
		if (GetWeaponSlotOverloadRemaining(slotIndex) > 0f)
		{
			return false;
		}
		return currentEnergy >= GetWeaponSlotEnergyCost(slotIndex);
	}

	private void LogSkillRequestResult(string action, int slotIndex, bool success, string reason)
	{
		lastSkillAction = action ?? string.Empty;
		lastSkillReason = reason ?? string.Empty;
		lastSkillSlotIndex = slotIndex;
		lastSkillSuccess = success;
		SummerRaceRuntimeLog.Log("[SummerRace][PlayerSkill] action=" + action + " slot=" + slotIndex + " success=" + success + " reason=" + reason + " hp=" + currentHP.ToString("F1") + "/" + MaxHP.ToString("F1") + " energy=" + currentEnergy.ToString("F1") + "/" + maxEnergy.ToString("F1") + " locked=" + movementLocked + " stun=" + (Time.time < stunUntil) + " disarm=" + (Time.time < disarmUntil));
	}

	public bool RequestOverloadWeaponSlot(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			LogSkillRequestResult("weapon_overload", slotIndex, success: false, "invalid_slot");
			return false;
		}
		if (movementLocked || currentHP <= 0f)
		{
			LogSkillRequestResult("weapon_overload", slotIndex, success: false, "blocked_state");
			return false;
		}
		RequireModularBackendReady("Player.RequestOverloadWeaponSlot");
		bool flag = TryGetWeaponSlotRuntimeSnapshot(slotIndex, out var snapshot);
		if (runtimePreparedForBattle && !flag)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while requesting overload. slot=" + slotIndex);
		}
		string text = ResolveWeaponSlotDisplayLabel(slotIndex, snapshot);
		if (GetWeaponSlotOverloadRemaining(slotIndex) > 0f)
		{
			if (GetWeaponSlotOverloadActiveRemaining(slotIndex) > 0f)
			{
				SetSkillHint(text + " overload active", 0.7f);
				LogSkillRequestResult("weapon_overload", slotIndex, success: false, "overload_active");
			}
			else
			{
				SetSkillHint(text + " overload cooldown", 0.7f);
				LogSkillRequestResult("weapon_overload", slotIndex, success: false, "overload_cooldown");
			}
			return false;
		}
		float weaponSlotEnergyCost = GetWeaponSlotEnergyCost(slotIndex);
		if (currentEnergy < weaponSlotEnergyCost)
		{
			SetSkillHint("Not enough energy for overload", 0.9f);
			LogSkillRequestResult("weapon_overload", slotIndex, success: false, "not_enough_energy");
			return false;
		}
		currentEnergy -= weaponSlotEnergyCost;
		float num = Time.time + 3f;
		weaponOverloadActiveUntilBySlot[slotIndex] = num;
		weaponOverloadCooldownUntilBySlot[slotIndex] = num + 3f;
		LogSkillRequestResult("weapon_overload", slotIndex, success: true, "ok");
		return true;
	}

	public bool RequestUseWeaponSlot(int slotIndex)
	{
		return TryActivateWeaponSlot(slotIndex);
	}

	public bool RequestUsePrimarySkill()
	{
		return RequestUseWeaponSlot(0);
	}

	private void TickAutoWeaponFire()
	{
		if (movementLocked || hookLatchMovementFrozen || currentHP <= 0f || Time.time < stunUntil || Time.time < disarmUntil || (SummerRaceFightManager.Instance != null && !SummerRaceFightManager.Instance.IsBattleActive))
		{
			return;
		}
		RequireModularBackendReady("Player.TickAutoWeaponFire");
		SetModularAimDirection(GetWeaponForwardVector());
		int weaponSlotCount = WeaponSlotCount;
		for (int i = 0; i < weaponSlotCount; i++)
		{
			if (!modularWeaponSystem.IsSlotReady(i))
			{
				continue;
			}
			if (!TryGetWeaponSlotRuntimeSnapshot(i, out var _))
			{
				if (runtimePreparedForBattle)
				{
					throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while ticking auto fire. slot=" + i);
				}
			}
			else
			{
				TryFireModularWeaponSlot(i);
			}
		}
	}

	private bool TryActivateWeaponSlot(int slotIndex)
	{
		if (!IsValidWeaponSlot(slotIndex))
		{
			LogSkillRequestResult("weapon_use", slotIndex, success: false, "invalid_slot");
			return false;
		}
		if (movementLocked || hookLatchMovementFrozen || currentHP <= 0f || Time.time < stunUntil)
		{
			SetSkillHint("Unavailable now", 0.8f);
			LogSkillRequestResult("weapon_use", slotIndex, success: false, hookLatchMovementFrozen ? "hook_frozen" : "blocked_state");
			return false;
		}
		if (Time.time < disarmUntil)
		{
			SetSkillHint("Weapons disabled", 0.8f);
			LogSkillRequestResult("weapon_use", slotIndex, success: false, "disarmed");
			return false;
		}
		RequireModularBackendReady("Player.TryActivateWeaponSlot");
		bool flag = TryGetWeaponSlotRuntimeSnapshot(slotIndex, out var snapshot);
		if (runtimePreparedForBattle && !flag)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while requesting weapon use. slot=" + slotIndex);
		}
		string text = ResolveWeaponSlotDisplayLabel(slotIndex, snapshot);
		if (!modularWeaponSystem.IsSlotReady(slotIndex))
		{
			SetSkillHint(text + " cooling down", 0.8f);
			LogSkillRequestResult("weapon_use", slotIndex, success: false, "cooldown");
			return false;
		}
		SetModularAimDirection(GetWeaponForwardVector());
		if (!TryFireModularWeaponSlot(slotIndex))
		{
			LogSkillRequestResult("weapon_use", slotIndex, success: false, "fire_failed");
			return false;
		}
		LogSkillRequestResult("weapon_use", slotIndex, success: true, "ok");
		return true;
	}

	private static WeaponShotFeedbackProfile ResolveWeaponShotFeedbackProfile(SummerRaceWeaponDefSO weaponDef)
	{
		if (weaponDef == null)
		{
			throw new ArgumentNullException("weaponDef");
		}
		return new WeaponShotFeedbackProfile(SummerRaceConfigLoader.ToRuntimeWeaponKind(weaponDef.weaponType), Mathf.Clamp(weaponDef.adsRecoilMultiplier, 0.05f, 1f), Mathf.Max(1f, weaponDef.recoilSpring), Mathf.Max(0.1f, weaponDef.recoilDamping), Mathf.Max(0f, weaponDef.recoilBackImpulse), Mathf.Max(0f, weaponDef.recoilUpImpulse), Mathf.Max(0f, weaponDef.recoilSideImpulse), Mathf.Max(0f, weaponDef.viewPunchUp), Mathf.Max(0f, weaponDef.viewPunchSide), Mathf.Max(1f, weaponDef.viewSpring), Mathf.Max(0.1f, weaponDef.viewDamping), weaponDef.enableShake, Mathf.Max(0f, weaponDef.shakeAmplitude), Mathf.Max(0f, weaponDef.shakeDuration));
	}

	private static float ResolveVolleyFeedbackMultiplier(SummerRaceWeaponDefSO weaponDef)
	{
		if (weaponDef == null || weaponDef.isMelee)
		{
			return 1f;
		}
		int num = Mathf.Max(1, weaponDef.projectileCount);
		if (num <= 1)
		{
			return 1f;
		}
		return 1f + (float)(num - 1) * 0.4f;
	}

	private void ApplyWeaponShotFeedback(WeaponShotFeedbackProfile feedbackProfile, float volleyFeedbackMultiplier)
	{
		float num = (adsActive ? feedbackProfile.AdsRecoilMultiplier : 1f);
		num *= Mathf.Max(1f, volleyFeedbackMultiplier);
		float facingSign = ResolveFacingSign();
		ResolveWeaponMountPose(facingSign, out var _, out var mountForward);
		mountForward = ((mountForward.sqrMagnitude > 0.0001f) ? mountForward.normalized : GetChassisForwardVector(facingSign));
		recoilSpringK = feedbackProfile.RecoilSpring;
		recoilDamp = feedbackProfile.RecoilDamping;
		recoilKickVel += feedbackProfile.RecoilBackImpulse * num * 2.6f;
		recoilPitchVel += feedbackProfile.RecoilUpImpulse * num * 1.35f;
		recoilYawVel += UnityEngine.Random.Range(-1f, 1f) * feedbackProfile.RecoilSideImpulse * num;
		if (!enableWeaponCameraFeedback)
		{
			cameraViewY = (cameraViewYVel = 0f);
			cameraRoll = (cameraRollVel = 0f);
			cameraShakeTimer = 0f;
			cameraShakeDuration = 0f;
			cameraShakeAmplitude = 0f;
			return;
		}
		cameraSpringK = feedbackProfile.ViewSpring;
		cameraDamp = feedbackProfile.ViewDamping;
		cameraViewYVel += feedbackProfile.ViewPunchUp * num;
		cameraRollVel += UnityEngine.Random.Range(-1f, 1f) * feedbackProfile.ViewPunchSide * num;
		if (feedbackProfile.EnableShake && feedbackProfile.ShakeDuration > 0f && feedbackProfile.ShakeAmplitude > 0f)
		{
			cameraShakeTimer = 0f;
			cameraShakeDuration = feedbackProfile.ShakeDuration;
			cameraShakeAmplitude = feedbackProfile.ShakeAmplitude * num;
		}
	}

	private void TickWeaponFeedbackVisual(float dt)
	{
		if (dt <= 0f)
		{
			return;
		}
		SummerRaceCharacterBase.IntegrateSpring(ref recoilKick, ref recoilKickVel, recoilSpringK, recoilDamp, dt);
		SummerRaceCharacterBase.IntegrateSpring(ref recoilPitch, ref recoilPitchVel, recoilSpringK, recoilDamp, dt);
		SummerRaceCharacterBase.IntegrateSpring(ref recoilYaw, ref recoilYawVel, recoilSpringK, recoilDamp, dt);
		if (cachedMainCamera == null)
		{
			cachedMainCamera = Camera.main;
		}
		if (cachedMainCamera == null)
		{
			return;
		}
		cachedMainCamera.transform.position -= cameraAppliedOffset;
		cameraAppliedOffset = Vector3.zero;
		if (!enableWeaponCameraFeedback)
		{
			cameraViewY = (cameraViewYVel = 0f);
			cameraRoll = (cameraRollVel = 0f);
			cameraShakeTimer = 0f;
			cameraShakeDuration = 0f;
			cameraShakeAmplitude = 0f;
			return;
		}
		SummerRaceCharacterBase.IntegrateSpring(ref cameraViewY, ref cameraViewYVel, cameraSpringK, cameraDamp, dt);
		SummerRaceCharacterBase.IntegrateSpring(ref cameraRoll, ref cameraRollVel, cameraSpringK, cameraDamp, dt);
		Vector3 vector = Vector3.zero;
		if (cameraShakeDuration > 0f && cameraShakeTimer < cameraShakeDuration)
		{
			cameraShakeTimer += dt;
			float num = Mathf.Clamp01(cameraShakeTimer / cameraShakeDuration);
			float num2 = 1f - num;
			vector = new Vector3(UnityEngine.Random.Range(-1f, 1f), UnityEngine.Random.Range(-1f, 1f), 0f) * (cameraShakeAmplitude * num2);
		}
		cameraAppliedOffset = new Vector3(cameraRoll * 0.03f, cameraViewY * 0.05f, 0f) + vector;
		cachedMainCamera.transform.position += cameraAppliedOffset;
	}

	public bool IsEquipSlotReady(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return false;
		}
		RequireModularBackendReady("Player.IsEquipSlotReady");
		return modularEquipSystem.IsSlotReady(slotIndex);
	}

	public float GetEquipSlotEnergyCost(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return 0f;
		}
		if (TryGetEquipSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.EnergyCost);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip runtime snapshot while resolving equip energy cost. slot=" + slotIndex);
		}
		EquipRuntime equipRuntime = equipSlots[slotIndex];
		if (equipRuntime == null || equipRuntime.Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip def while resolving equip energy cost. slot=" + slotIndex);
		}
		return Mathf.Max(0f, equipRuntime.Def.energyCost);
	}

	public float GetEquipSlotCooldownDuration(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return 0f;
		}
		if (TryGetEquipSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.CooldownDuration);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip runtime snapshot while resolving equip cooldown. slot=" + slotIndex);
		}
		EquipRuntime equipRuntime = equipSlots[slotIndex];
		if (equipRuntime == null || equipRuntime.Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip def while resolving equip cooldown. slot=" + slotIndex);
		}
		return Mathf.Max(0f, equipRuntime.Def.cooldown);
	}

	public float GetEquipSlotCooldownRemain(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return 0f;
		}
		RequireModularBackendReady("Player.GetEquipSlotCooldownRemain");
		return modularEquipSystem.GetSlotCooldownRemaining(slotIndex);
	}

	public float GetEquipSlotActiveRemain(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return 0f;
		}
		if (TryGetEquipSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.ActiveRemaining);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip runtime snapshot while resolving equip active remain. slot=" + slotIndex);
		}
		return 0f;
	}

	public float GetEquipSlotActiveDuration(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return 0f;
		}
		if (TryGetEquipSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.ActiveDuration);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip runtime snapshot while resolving equip active duration. slot=" + slotIndex);
		}
		return 0f;
	}

	public string GetEquipSlotLabel(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return "Equip N/A";
		}
		if (TryGetEquipSlotRuntimeSnapshot(slotIndex, out var snapshot))
		{
			string text = ResolveEquipSlotDisplayLabel(slotIndex, snapshot);
			float energyCost = snapshot.EnergyCost;
			return text + " (E" + energyCost.ToString("F0") + ")";
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip runtime snapshot while resolving equip label. slot=" + slotIndex);
		}
		return ResolveEquipSlotDisplayLabel(slotIndex, snapshot) + " (E" + GetEquipSlotEnergyCost(slotIndex).ToString("F0") + ")";
	}

	public bool CanTriggerEquipSlot(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return false;
		}
		if (movementLocked || hookLatchMovementFrozen || currentHP <= 0f || Time.time < stunUntil)
		{
			return false;
		}
		RequireModularBackendReady("Player.CanTriggerEquipSlot");
		if (!modularEquipSystem.IsSlotReady(slotIndex))
		{
			return false;
		}
		string rejectReason;
		return modularEquipSystem.CanActivateSlot(slotIndex, GetWeaponForwardVector(), out rejectReason);
	}

	public bool CanPresentEquipSlotAsReady(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			return false;
		}
		if (movementLocked || currentHP <= 0f)
		{
			return false;
		}
		RequireModularBackendReady("Player.CanPresentEquipSlotAsReady");
		return modularEquipSystem.IsSlotReady(slotIndex);
	}

	public bool RequestUseEquipSlot(int slotIndex)
	{
		if (!IsValidEquipSlot(slotIndex))
		{
			LogSkillRequestResult("equip_use", slotIndex, success: false, "invalid_slot");
			return false;
		}
		if (movementLocked || hookLatchMovementFrozen || currentHP <= 0f || Time.time < stunUntil)
		{
			SetSkillHint("Unavailable now", 0.8f);
			LogSkillRequestResult("equip_use", slotIndex, success: false, hookLatchMovementFrozen ? "hook_frozen" : "blocked_state");
			return false;
		}
		RequireModularBackendReady("Player.RequestUseEquipSlot");
		bool flag = TryGetEquipSlotRuntimeSnapshot(slotIndex, out var snapshot);
		if (runtimePreparedForBattle && !flag)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing equip runtime snapshot while requesting equip use. slot=" + slotIndex);
		}
		string text = ResolveEquipSlotDisplayLabel(slotIndex, snapshot);
		if (!modularEquipSystem.CanActivateSlot(slotIndex, GetWeaponForwardVector(), out var rejectReason))
		{
			if (rejectReason == "cooldown")
			{
				SetSkillHint(text + " cooling down", 0.8f);
				LogSkillRequestResult("equip_use", slotIndex, success: false, "cooldown");
			}
			else if (rejectReason == "energy")
			{
				SetSkillHint("Not enough energy", 1f);
				LogSkillRequestResult("equip_use", slotIndex, success: false, "not_enough_energy");
			}
			else
			{
				SetSkillHint("Equip failed", 0.8f);
				LogSkillRequestResult("equip_use", slotIndex, success: false, "equip_reject:" + rejectReason);
			}
			return false;
		}
		CombatExecutionResult combatExecutionResult = TryUseModularEquipSlot(slotIndex, GetWeaponForwardVector());
		if (!combatExecutionResult.Success)
		{
			string text2 = combatExecutionResult.FailureReason ?? string.Empty;
			if (modularEquipSystem.GetSlotCooldownRemaining(slotIndex) > 0f)
			{
				SetSkillHint(text + " cooling down", 0.8f);
				LogSkillRequestResult("equip_use", slotIndex, success: false, "cooldown");
			}
			else if (text2.Contains("energy"))
			{
				SetSkillHint("Not enough energy", 1f);
				LogSkillRequestResult("equip_use", slotIndex, success: false, "not_enough_energy");
			}
			else
			{
				SetSkillHint("Equip failed", 0.8f);
				LogSkillRequestResult("equip_use", slotIndex, success: false, "equip_failed:" + text2);
			}
			return false;
		}
		LogSkillRequestResult("equip_use", slotIndex, success: true, "ok");
		return true;
	}

	public bool RequestUseEquipSkill()
	{
		return RequestUseEquipSlot(0);
	}

	private bool TryGetEquipSlotRuntimeSnapshot(int slotIndex, out EquipRuntimeSnapshot snapshot)
	{
		snapshot = default(EquipRuntimeSnapshot);
		if (runtimePreparedForBattle)
		{
			RequireModularBackendReady("Player.TryGetEquipSlotRuntimeSnapshot");
		}
		if (modularEquipSystem != null && modularEquipSystem.TryGetRuntimeSnapshot(slotIndex, out snapshot))
		{
			return snapshot.SlotIndex == slotIndex;
		}
		return false;
	}

	private bool TryGetWeaponSlotRuntimeSnapshot(int slotIndex, out VehicleWeaponSystem.WeaponSlotSnapshot snapshot)
	{
		snapshot = default(VehicleWeaponSystem.WeaponSlotSnapshot);
		if (runtimePreparedForBattle)
		{
			RequireModularBackendReady("Player.TryGetWeaponSlotRuntimeSnapshot");
		}
		if (modularWeaponSystem != null && modularWeaponSystem.TryGetSlotSnapshot(slotIndex, out snapshot))
		{
			return snapshot.IsValid;
		}
		return false;
	}

	private string ResolveWeaponSlotDisplayLabel(int slotIndex, VehicleWeaponSystem.WeaponSlotSnapshot snapshot)
	{
		if (!string.IsNullOrEmpty(snapshot.Label))
		{
			return snapshot.Label;
		}
		if (IsValidWeaponSlot(slotIndex))
		{
			WeaponRuntime weaponRuntime = weaponSlots[slotIndex];
			if (weaponRuntime == null || weaponRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while resolving weapon label. slot=" + slotIndex);
			}
			if (!string.IsNullOrEmpty(weaponRuntime.Def.displayName))
			{
				return weaponRuntime.Def.displayName;
			}
			return weaponRuntime.Def.weaponType.ToString();
		}
		return "Weapon";
	}

	private string ResolveEquipSlotDisplayLabel(int slotIndex, EquipRuntimeSnapshot snapshot)
	{
		if (!string.IsNullOrEmpty(snapshot.Label))
		{
			return snapshot.Label;
		}
		if (IsValidEquipSlot(slotIndex))
		{
			EquipRuntime equipRuntime = equipSlots[slotIndex];
			if (equipRuntime == null || equipRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Missing equip def while resolving equip label. slot=" + slotIndex);
			}
			if (!string.IsNullOrEmpty(equipRuntime.Def.displayName))
			{
				return equipRuntime.Def.displayName;
			}
			return equipRuntime.Def.equipType.ToString();
		}
		return "Equip";
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		if (collision != null)
		{
			NotifySpawnLandingContact(SummerRaceCharacterBase.ResolveBestSupportNormal(collision));
			RegisterBoundaryContact(collision);
			TryPublishVehicleCollisionAudio(collision);
			if (((collision.collider != null) ? collision.collider.GetComponentInParent<SummerRaceEnemy>() : null) != null && SummerRaceFightManager.Instance != null)
			{
				SummerRaceFightManager.Instance.NotifyVehicleCollisionForCameraShake(collision.relativeVelocity.magnitude);
			}
		}
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		if (!(other == null) && other is CircleCollider2D && !(other.GetComponentInParent<MountPoint>() != null))
		{
			_ = other.GetComponentInParent<VehicleSimpleProjectile>() != null;
		}
	}

	private void OnCollisionStay2D(Collision2D collision)
	{
		if (collision != null && !(collision.collider == null))
		{
			NotifySpawnLandingContact(SummerRaceCharacterBase.ResolveBestSupportNormal(collision));
			RegisterBoundaryContact(collision);
			if (base.IsRuntimeDebugLogEnabled && !(Time.time < nextCollisionLogAt))
			{
				nextCollisionLogAt = Time.time + 0.8f;
				RecordExplainabilityEvent("Contact", "with=" + collision.collider.name + " pointCount=" + collision.contactCount + " normal=" + ((collision.contactCount > 0) ? collision.GetContact(0).normal.ToString("F3") : "None") + " wheels=" + DebugWheelContactSummary);
			}
		}
	}

	private void TickHintState()
	{
		if (!(Time.time < hintUntil))
		{
			skillHint = string.Empty;
		}
	}

	private void TickEnergyRegen()
	{
		if (!movementLocked && !(currentHP <= 0f))
		{
			currentEnergy = Mathf.Clamp(currentEnergy + energyRegenPerSecond * Time.deltaTime, 0f, maxEnergy);
		}
	}

	private float ResolveDriveAcceleration()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.ResolveDriveAcceleration");
		if (currentBodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body profile is missing during drive acceleration resolution.");
		}
		if (Time.time < stunUntil)
		{
			smoothedDriveAcceleration = 0f;
			return 0f;
		}
		if (Time.time >= nextTargetScanAt)
		{
			nextTargetScanAt = Time.time + 0.25f;
			cachedTargetEnemy = FindClosestEnemy();
		}
		float num = ComputeDriveSupportRatio();
		float rawSupportRatio = ComputeRawDriveSupportRatio();
		float num2 = ComputeDriveAlignmentRatio();
		float num3 = ResolveThrusterSpeedMultiplier();
		float num4 = SummerRaceCharacterBase.ResolveHardSupportAuthorityGate(rawSupportRatio);
		float num5 = ResolveAutoDriveDirectionSign();
		float surfaceGapAbsX = ((cachedTargetEnemy != null) ? Mathf.Abs(ResolveTargetSurfaceGapX(cachedTargetEnemy)) : Mathf.Max(0.5f, autoDriveFullDistance));
		float num6 = ResolveSpawnDriveCommandScale(surfaceGapAbsX, num, Time.fixedDeltaTime);
		float desiredSpeedX = num5 * Mathf.Max(0.25f, currentBodyProfile.CruiseSpeed * num3);
		float t = Mathf.Clamp01(num * num2) * num4;
		float num7 = Mathf.Lerp(0.28f, 1f, t);
		float num8 = Mathf.Max(0.8f, currentBodyProfile.ForwardAcceleration * num3);
		num8 *= num6 * num7;
		Vector2 vector = SummerRaceCharacterBase.ResolveDriveAccelerationStepRates(Mathf.Max(0.01f, num8));
		float x = vector.x;
		float y = vector.y;
		float accelerationCommand = num5 * num8;
		accelerationCommand = ResolveBoundaryAdjustedAcceleration(desiredSpeedX, accelerationCommand, num8, rigidbody2D.velocity.x);
		accelerationCommand = ResolveThrusterImpulseProtectedAcceleration(accelerationCommand, num8, out var reverseSuppressedByThruster);
		if (reverseSuppressedByThruster)
		{
			smoothedDriveAcceleration = 0f;
			smoothedThrottleInput = 0f;
		}
		smoothedDriveAcceleration = SummerRaceCharacterBase.StepSignedCommand(smoothedDriveAcceleration, accelerationCommand, x, y, Time.fixedDeltaTime);
		float num9 = manualAccelerationInputNormalized * manualAccelerationMax;
		float value = smoothedDriveAcceleration + num9;
		float num10 = Mathf.Max(1f, maxDriveAcceleration);
		return Mathf.Clamp(value, 0f - num10, num10) * ResolveMoveStatusMultiplier();
	}

	private float ResolveMoveStatusMultiplier()
	{
		if (Time.time >= slowUntil)
		{
			slowMoveMultiplier = 1f;
			return 1f;
		}
		return Mathf.Clamp(slowMoveMultiplier, 0.2f, 1f);
	}

	private void TickCombatStatusRuntime()
	{
		if (burnDps > 0 && Time.time < burnUntil && Time.time >= nextBurnTickAt)
		{
			nextBurnTickAt = Time.time + 1f;
			if (burnTickImpactPayload != null && burnSourceContext != null)
			{
				SummerRaceCombatEffectExecutor.Shared.ExecuteImpact(this, burnTickImpactPayload, Vector2.zero, burnSourceContext);
			}
		}
		if (Time.time >= burnUntil)
		{
			burnDps = 0;
			burnSourceContext = null;
			burnTickImpactPayload = null;
		}
	}

	private float ResolveDebugSpread()
	{
		if (lastFiredWeaponSlot < 0)
		{
			return 0f;
		}
		if (runtimePreparedForBattle)
		{
			RequireModularBackendReady("Player.ResolveDebugSpread");
		}
		if (modularWeaponSystem != null && modularWeaponSystem.TryGetRuntimeSnapshot(lastFiredWeaponSlot, out var snapshot))
		{
			return Mathf.Max(0f, snapshot.DynamicSpread);
		}
		if (runtimePreparedForBattle)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing weapon runtime snapshot while resolving debug spread. slot=" + lastFiredWeaponSlot);
		}
		return 0f;
	}

	private float ResolveAutoDriveDirectionSign()
	{
		RequirePhysicsBodyReady("Player.ResolveAutoDriveDirectionSign");
		if (currentBodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body profile is missing during auto drive direction resolution.");
		}
		float num = ((autoMoveDirection > 0) ? 1f : ((autoMoveDirection < 0) ? (-1f) : ((Mathf.Abs(base.transform.right.x) > 0.0001f) ? Mathf.Sign(base.transform.right.x) : 1f)));
		if (cachedTargetEnemy == null)
		{
			autoMoveDirection = ((num > 0f) ? 1 : (-1));
			return num;
		}
		float deltaX = ResolveTargetSurfaceGapX(cachedTargetEnemy);
		float holdDistance = Mathf.Max(0.05f, autoDriveStopDistance);
		float commitDistance = ResolveDirectionCommitDistance(holdDistance);
		float num2 = SummerRaceCharacterBase.ResolveLatchedDirectionSign(autoMoveDirection, deltaX, holdDistance, commitDistance, num);
		autoMoveDirection = ((num2 > 0f) ? 1 : (-1));
		return num2;
	}

	private float ComputeDriveSupportRatio()
	{
		return Mathf.Clamp01(smoothedDriveSupportRatio);
	}

	private float ComputeRawDriveSupportRatio()
	{
		Rigidbody2D body = RequirePhysicsBodyReady("Player.ComputeRawDriveSupportRatio");
		float num = 0f;
		float num2 = 0f;
		if (SummerRaceCharacterBase.IsDriveSupportContact(in lastFrontWheelContact, body))
		{
			num += Mathf.Clamp01(lastFrontWheelContact.compression);
			num2++;
		}
		if (SummerRaceCharacterBase.IsDriveSupportContact(in lastBackWheelContact, body))
		{
			num += Mathf.Clamp01(lastBackWheelContact.compression);
			num2++;
		}
		if (num2 <= 0f)
		{
			return 0f;
		}
		return Mathf.Clamp01(num / num2);
	}

	private float ComputeDriveAlignmentRatio()
	{
		return Mathf.Clamp01(smoothedDriveAlignmentRatio);
	}

	private float ComputeRawDriveAlignmentRatio()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.ComputeRawDriveAlignmentRatio");
		Vector2 forward = rigidbody2D.transform.right;
		if (forward.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Chassis forward axis is invalid during drive alignment resolution.");
		}
		forward.Normalize();
		float num = 0f;
		float weight = 0f;
		num += ComputeSingleWheelAlignmentScore(lastFrontWheelContact, forward, rigidbody2D, ref weight);
		num += ComputeSingleWheelAlignmentScore(lastBackWheelContact, forward, rigidbody2D, ref weight);
		if (weight <= 0f)
		{
			return 0f;
		}
		return Mathf.Clamp01(num / weight) * ResolveDrivePostureTractionScale(lastFrontWheelContact, lastBackWheelContact);
	}

	private float ComputeSingleWheelAlignmentScore(WheelContactData contact, Vector2 forward, Rigidbody2D body, ref float weight)
	{
		if (!SummerRaceCharacterBase.IsDriveSupportContact(in contact, body) || contact.tangent.sqrMagnitude <= 0.0001f)
		{
			return 0f;
		}
		Vector2 normalized = contact.tangent.normalized;
		float num = Mathf.Abs(Vector2.Dot(forward, normalized));
		float num2 = Mathf.Clamp(contact.compression, 0.2f, 1f);
		weight += num2;
		return num * num2;
	}

	protected override void ApplyDrivePhysics(float driveAcceleration)
	{
		RequirePhysicsBodyReady("Player.ApplyDrivePhysics");
		if (currentBodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body profile is missing during drive physics application.");
		}
		float target = SummerRaceCharacterBase.ResolveNormalizedAccelerationCommand(driveAcceleration, Mathf.Max(0.1f, maxDriveAcceleration));
		smoothedThrottleInput = SummerRaceCharacterBase.StepSignedCommand(smoothedThrottleInput, target, throttleRiseRate, throttleFallRate, Time.fixedDeltaTime);
		ApplyModularDrive(smoothedThrottleInput, 0f);
		SyncLegacyWheelContactsFromModular();
		bool fireDriveStress = Mathf.Abs(driveAcceleration) > 0.15f && recoilKick > 0.08f;
		if (mirrorModularWheelDebug)
		{
			UpdateWheelFeelTelemetry(lastFrontWheelContact, lastBackWheelContact, fireDriveStress);
		}
	}

	private void DrawWheelContactDebug(WheelContactData contact, Vector2 wheelLocal, float driveSign, float throttle)
	{
		if (!drawRuntimeGizmos || !drawWheelContactDebug || rb == null)
		{
			return;
		}
		float wheelDebugLineDuration = WheelDebugLineDuration;
		Vector2 vector = base.transform.TransformPoint(wheelLocal);
		if (!contact.hasContact)
		{
			Debug.DrawLine(vector, vector + Vector2.down * 0.08f, new Color(1f, 0.2f, 0.2f, 0.9f), wheelDebugLineDuration, depthTest: false);
			return;
		}
		float num = Mathf.Max(0.1f, debugContactVectorLength);
		Debug.DrawLine(contact.point, contact.point + contact.normal * num, Color.green, wheelDebugLineDuration, depthTest: false);
		Debug.DrawLine(contact.point, contact.point + contact.tangent * num, Color.yellow, wheelDebugLineDuration, depthTest: false);
		Vector2 vector2 = contact.tangent;
		Vector2 normalized = ((Vector2)rb.transform.right).normalized;
		if (normalized.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Chassis forward axis is invalid in wheel debug.");
		}
		if (Vector2.Dot(vector2, normalized * driveSign) < 0f)
		{
			vector2 = -vector2;
		}
		float num2 = num * Mathf.Clamp01(throttle);
		Debug.DrawLine(vector, vector + vector2 * num2, Color.red, wheelDebugLineDuration, depthTest: false);
		Color color = ((contact.surfaceBodyType == RigidbodyType2D.Dynamic) ? new Color(1f, 0.5f, 0.15f, 0.9f) : new Color(0.2f, 0.9f, 1f, 0.9f));
		Debug.DrawLine(vector, contact.point, color, wheelDebugLineDuration, depthTest: false);
	}

	private void DrawCenterOfMassDebug()
	{
		if (drawRuntimeGizmos && drawWheelContactDebug && !(rb == null))
		{
			Vector2 worldCenterOfMass = rb.worldCenterOfMass;
			Debug.DrawLine(worldCenterOfMass, worldCenterOfMass + Vector2.up * 0.28f, new Color(1f, 0.25f, 0.9f, 0.95f), 0f, depthTest: false);
		}
	}

	protected override void DrawWheelCircleDebug()
	{
		if (drawRuntimeGizmos && drawColliderOutlineInGame)
		{
			if (frontWheel != null)
			{
				DrawDebugCircle(frontWheel.position, frontWheelRadius, playerWheelOutlineColor);
			}
			if (backWheel != null)
			{
				DrawDebugCircle(backWheel.position, backWheelRadius, playerWheelOutlineColor);
			}
		}
	}

	private void DrawDebugCircle(Vector2 center, float radius, Color color)
	{
		float wheelDebugLineDuration = WheelDebugLineDuration;
		float num = Mathf.Max(0.02f, radius);
		Vector2 vector = center + new Vector2(num, 0f);
		for (int i = 1; i <= 24; i++)
		{
			float f = (float)i / 24f * MathF.PI * 2f;
			Vector2 vector2 = center + new Vector2(Mathf.Cos(f) * num, Mathf.Sin(f) * num);
			Debug.DrawLine(vector, vector2, color, wheelDebugLineDuration, depthTest: false);
			vector = vector2;
		}
	}

	private void DrawWeaponDirectionDebug()
	{
		if (drawRuntimeGizmos && drawWeaponDirectionDebug && !(rb == null))
		{
			float facingSign = ResolveFacingSign();
			ResolveWeaponMountPose(facingSign, out var mountPos, out var mountForward);
			Vector2 chassisForwardVector = GetChassisForwardVector(facingSign);
			Vector2 vector = ((mountForward.sqrMagnitude > 0.0001f) ? mountForward.normalized : chassisForwardVector);
			float num = Mathf.Max(0.3f, weaponDirectionDebugLength);
			Debug.DrawLine(rb.worldCenterOfMass, rb.worldCenterOfMass + chassisForwardVector * num, Color.cyan, 0f, depthTest: false);
			Debug.DrawLine(mountPos, mountPos + vector * num, new Color(1f, 0f, 1f, 0.95f), 0f, depthTest: false);
			Debug.DrawLine(mountPos, mountPos + Rotate(vector, 0f) * (num * 0.85f), Color.white, 0f, depthTest: false);
		}
	}

	private void UpdateWheelFeelTelemetry(WheelContactData frontContact, WheelContactData backContact, bool fireDriveStress)
	{
		Rigidbody2D body = RequirePhysicsBodyReady("Player.UpdateWheelFeelTelemetry");
		debugWheelEmbedRatio = ComputeWheelEmbedRatio(frontContact, backContact);
		debugRearCompressionNormalized = (SummerRaceCharacterBase.IsSupportContact(in backContact, 0.08f, body) ? Mathf.Clamp01(backContact.compression) : 0f);
	}

	private float ComputeWheelEmbedRatio(WheelContactData frontContact, WheelContactData backContact)
	{
		float num = ComputeSingleWheelEmbedRatio(frontContact);
		float num2 = ComputeSingleWheelEmbedRatio(backContact);
		if (frontContact.hasContact && backContact.hasContact)
		{
			return (num + num2) * 0.5f;
		}
		if (frontContact.hasContact)
		{
			return num;
		}
		if (backContact.hasContact)
		{
			return num2;
		}
		return 0f;
	}

	private float ComputeSingleWheelEmbedRatio(WheelContactData contact)
	{
		if (!SummerRaceCharacterBase.IsSupportContact(in contact, 0.08f, RequirePhysicsBodyReady("Player.ComputeSingleWheelEmbedRatio")))
		{
			return 0f;
		}
		return Mathf.Clamp01((contact.compression - 0.7f) / 0.3f);
	}

	protected override void ApplyCompressionHardLimits(ref WheelContactData frontContact, ref WheelContactData backContact, bool fireDriveStress)
	{
	}

	protected override void UpdateWheelVisual(float targetSpeed, float dt)
	{
		SyncModularVisualMirror();
		float num = Mathf.Clamp(Mathf.Abs(targetSpeed) * 220f, 90f, 520f);
		float deltaZ = ((targetSpeed >= 0f) ? (0f - num) : num) * Mathf.Max(0.0001f, dt);
		if (frontWheel != null)
		{
			SummerRaceCharacterBase.RotateWheelVisual(frontWheel, deltaZ);
			frontWheelVisualWorld = ResolveWheelVisualWorldPos(frontWheelLocal, frontWheelRadius, lastFrontWheelContact, frontWheelVisualWorld, ref frontWheelVisualVelY, ref frontWheelVisualInitialized, dt);
			frontWheel.position = frontWheelVisualWorld;
		}
		if (backWheel != null)
		{
			SummerRaceCharacterBase.RotateWheelVisual(backWheel, deltaZ);
			backWheelVisualWorld = ResolveWheelVisualWorldPos(backWheelLocal, backWheelRadius, lastBackWheelContact, backWheelVisualWorld, ref backWheelVisualVelY, ref backWheelVisualInitialized, dt);
			backWheel.position = backWheelVisualWorld;
		}
		if (drawWheelContactDebug && SummerRaceRuntimeLog.IsGameplayVerboseEnabled && Time.time >= nextWheelVisualLogAt)
		{
			nextWheelVisualLogAt = Time.time + 0.5f;
			SummerRaceRuntimeLog.Verbose("[SummerRace][Player][WheelVisual] speedX=" + targetSpeed.ToString("F3") + " dt=" + dt.ToString("F4") + " step=" + deltaZ.ToString("F3") + " frontZ=" + ResolveWheelInnerRotorZ(frontWheel).ToString("F2") + " backZ=" + ResolveWheelInnerRotorZ(backWheel).ToString("F2"));
		}
	}

	protected override Vector2 ResolveWheelVisualWorldPos(Vector2 wheelLocal, float wheelRadius, WheelContactData contact, Vector2 cachedWorld, ref float yVelocity, ref bool initialized, float dt)
	{
		return base.ResolveWheelVisualWorldPos(wheelLocal, wheelRadius, contact, cachedWorld, ref yVelocity, ref initialized, dt);
	}

	private static float ResolveWheelInnerRotorZ(Transform wheelRoot)
	{
		if (wheelRoot == null)
		{
			return 0f;
		}
		Transform transform = wheelRoot.Find("Visual/InnerTireVisual");
		if (transform == null)
		{
			return 0f;
		}
		return transform.localEulerAngles.z;
	}

	private new void ResetWheelVisualState()
	{
		frontWheelVisualWorld = base.transform.TransformPoint(frontWheelLocal);
		backWheelVisualWorld = base.transform.TransformPoint(backWheelLocal);
		frontWheelVisualVelY = 0f;
		backWheelVisualVelY = 0f;
		frontWheelVisualInitialized = false;
		backWheelVisualInitialized = false;
	}

	private Vector2 GetForwardVector()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.GetForwardVector");
		if (Mathf.Abs(rigidbody2D.velocity.x) > 0.15f)
		{
			return new Vector2(Mathf.Sign(rigidbody2D.velocity.x), 0f);
		}
		return new Vector2(ResolveAutoMoveDirectionSign(), 0f);
	}

	private float ResolveFacingSign()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.ResolveFacingSign");
		if (Mathf.Abs(rigidbody2D.velocity.x) > 0.08f)
		{
			return Mathf.Sign(rigidbody2D.velocity.x);
		}
		return ResolveAutoMoveDirectionSign();
	}

	private float ResolveAutoMoveDirectionSign()
	{
		if (autoMoveDirection > 0)
		{
			return 1f;
		}
		if (autoMoveDirection < 0)
		{
			return -1f;
		}
		float x = base.transform.right.x;
		if (Mathf.Abs(x) <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Unable to resolve auto move direction sign.");
		}
		return Mathf.Sign(x);
	}

	protected override float ResolveFacingDirection()
	{
		return ResolveFacingSign();
	}

	protected override float GetCruiseSpeed()
	{
		return currentBodyProfile.CruiseSpeed;
	}

	protected override float GetTractionGain()
	{
		return currentBodyProfile.TractionGain;
	}

	protected override float GetTractionCompressionMultiplier()
	{
		return 1.25f;
	}

	protected override float GetDesiredWheelLinearMultiplier()
	{
		return 2f;
	}

	protected override Vector2 GetWheelRadiusClampRange()
	{
		return new Vector2(0.7f, 1.35f);
	}

	protected override float ResolveModularMountXSign()
	{
		return -1f;
	}

	protected override Vector2 ResolveRuntimeMountLocalPosition(SummerRaceMountPointDefConfig mount, float mountXSign)
	{
		if (mount == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Null mount config while resolving runtime mount position.");
		}
		SummerRaceConfigLoader.BodyPrefabRuntimeData bodyPrefabRuntimeData = SummerRaceConfigLoader.LoadBodyPrefabRuntimeData(bodyType);
		return SummerRaceBodyLayoutMapper.ResolveRuntimeLocalFromBodyVisual(bodyVisual, mount.localPosition, bodyPrefabRuntimeData.BodyVisualLocalPosition, bodyPrefabRuntimeData.BodyVisualLocalScale, "[SummerRace][Player] RuntimeMount slotType=" + mount.slotType.ToString() + " slotIndex=" + mount.slotIndex);
	}

	protected override bool ShouldRotateMountedVisualY180(MountPoint mount)
	{
		if (mount == null || mount.InstalledModule == null)
		{
			return false;
		}
		VehicleMountType mountType = mount.InstalledModule.MountType;
		if (mountType != VehicleMountType.Weapon)
		{
			return mountType == VehicleMountType.Utility;
		}
		return true;
	}

	private Vector2 GetChassisForwardVector(float facingSign)
	{
		Vector2 vector = base.transform.right;
		if (facingSign < 0f)
		{
			vector = -vector;
		}
		if (vector.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Chassis forward is invalid.");
		}
		return vector.normalized;
	}

	private void ResolveWeaponMountPose(float facingSign, out Vector2 mountPos, out Vector2 mountForward)
	{
		Vector2 vector = new Vector2(Mathf.Abs(weaponMountLocalOffset.x) * ((facingSign >= 0f) ? 1f : (-1f)), weaponMountLocalOffset.y);
		mountPos = base.transform.TransformPoint(vector);
		Vector2 chassisForwardVector = GetChassisForwardVector(facingSign);
		mountForward = Rotate(chassisForwardVector, weaponMountLocalAngle * ((facingSign >= 0f) ? 1f : (-1f)));
	}

	private Vector2 GetWeaponForwardVector()
	{
		float facingSign = ResolveFacingSign();
		ResolveWeaponMountPose(facingSign, out var _, out var mountForward);
		if (!(mountForward.sqrMagnitude > 0.0001f))
		{
			return GetChassisForwardVector(facingSign);
		}
		return mountForward.normalized;
	}

	private Transform FindClosestEnemy()
	{
		if (SummerRaceEnemyRegistry.Count == 0)
		{
			return null;
		}
		Transform result = null;
		float num = float.MaxValue;
		for (int i = 0; i < SummerRaceEnemyRegistry.Count; i++)
		{
			SummerRaceEnemy summerRaceEnemy = SummerRaceEnemyRegistry.Get(i);
			if (!(summerRaceEnemy == null))
			{
				float num2 = Mathf.Abs(summerRaceEnemy.transform.position.x - base.transform.position.x);
				if (num2 < num)
				{
					num = num2;
					result = summerRaceEnemy.transform;
				}
			}
		}
		return result;
	}

	private BodyProfile GetBodyProfile(SummerRaceBodyType type)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyDef(type);
		if (summerRaceBodyDefSO == null)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][Player] Missing body config: " + type);
			throw new Exception("Missing body config: " + type);
		}
		if (summerRaceBodyDefSO.forwardAcceleration <= 0f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body forwardAcceleration must be > 0: body=" + type.ToString() + " value=" + summerRaceBodyDefSO.forwardAcceleration);
		}
		BodyProfile bodyProfile = new BodyProfile
		{
			Label = summerRaceBodyDefSO.displayName,
			CostCap = summerRaceBodyDefSO.costCap,
			MaxHP = summerRaceBodyDefSO.baseHp,
			Mass = summerRaceBodyDefSO.mass,
			Drag = summerRaceBodyDefSO.drag,
			AngularDrag = summerRaceBodyDefSO.angularDrag,
			GravityScale = summerRaceBodyDefSO.gravityScale,
			CruiseSpeed = summerRaceBodyDefSO.moveSpeed,
			ForwardAcceleration = summerRaceBodyDefSO.forwardAcceleration,
			TractionGain = summerRaceBodyDefSO.tractionGain,
			CollisionImpulseScale = summerRaceBodyDefSO.collisionImpulseScale,
			BodyComOffset = summerRaceBodyDefSO.centerOfMassOffset,
			BodyColor = summerRaceBodyDefSO.bodyColor,
			BodyScale = summerRaceBodyDefSO.bodyScale
		};
		if (summerRaceBodyDefSO.wheels != null && summerRaceBodyDefSO.wheels.Count >= 2)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = summerRaceBodyDefSO.wheels[0];
			SummerRaceWheelDefConfig summerRaceWheelDefConfig2 = summerRaceBodyDefSO.wheels[1];
			if (summerRaceWheelDefConfig != null)
			{
				bodyProfile.FrontWheelPos = summerRaceWheelDefConfig.localPosition;
				bodyProfile.FrontWheelRadius = summerRaceWheelDefConfig.radius;
			}
			if (summerRaceWheelDefConfig2 != null)
			{
				bodyProfile.BackWheelPos = summerRaceWheelDefConfig2.localPosition;
				bodyProfile.BackWheelRadius = summerRaceWheelDefConfig2.radius;
			}
			ApplyRuntimeBodyProfileOverride(bodyProfile);
			return bodyProfile;
		}
		SummerRaceRuntimeLog.Error("[SummerRace][Player] Body wheel config missing for " + type);
		throw new Exception("Body wheel config missing for " + type);
	}

	private void ApplyRuntimeBodyProfileOverride(BodyProfile profile)
	{
		if (!hasRuntimeBuildOverride || runtimeBodyProfileOverride == null || !runtimeBodyProfileOverride.HasAnyOverride)
		{
			return;
		}
		if (runtimeBodyProfileOverride.HasMaxHp)
		{
			profile.MaxHP = Mathf.Max(1f, runtimeBodyProfileOverride.MaxHp);
		}
		if (runtimeBodyProfileOverride.HasCostCap)
		{
			profile.CostCap = Mathf.Max(0, runtimeBodyProfileOverride.CostCap);
		}
		if (runtimeBodyProfileOverride.HasCruiseSpeed)
		{
			profile.CruiseSpeed = Mathf.Max(0f, runtimeBodyProfileOverride.CruiseSpeed);
		}
		if (runtimeBodyProfileOverride.HasForwardAcceleration)
		{
			if (runtimeBodyProfileOverride.ForwardAcceleration <= 0f)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime body override forwardAcceleration must be > 0. value=" + runtimeBodyProfileOverride.ForwardAcceleration);
			}
			profile.ForwardAcceleration = runtimeBodyProfileOverride.ForwardAcceleration;
		}
		if (runtimeBodyProfileOverride.HasMass)
		{
			profile.Mass = Mathf.Max(0.01f, runtimeBodyProfileOverride.Mass);
		}
		if (runtimeBodyProfileOverride.HasDrag)
		{
			profile.Drag = Mathf.Max(0f, runtimeBodyProfileOverride.Drag);
		}
		if (runtimeBodyProfileOverride.HasAngularDrag)
		{
			profile.AngularDrag = Mathf.Max(0f, runtimeBodyProfileOverride.AngularDrag);
		}
		if (runtimeBodyProfileOverride.HasGravityScale)
		{
			profile.GravityScale = Mathf.Max(0f, runtimeBodyProfileOverride.GravityScale);
		}
		if (runtimeBodyProfileOverride.HasTractionGain)
		{
			profile.TractionGain = Mathf.Max(0f, runtimeBodyProfileOverride.TractionGain);
		}
		if (runtimeBodyProfileOverride.HasCollisionImpulseScale)
		{
			profile.CollisionImpulseScale = Mathf.Max(0f, runtimeBodyProfileOverride.CollisionImpulseScale);
		}
	}

	private void ApplyBodyProfile()
	{
		EnsureBodyVisualRefs();
		currentBodyProfile = GetBodyProfile(bodyType);
		currentHP = Mathf.Clamp(currentHP, 0f, currentBodyProfile.MaxHP);
		SummerRaceConfigLoader.BodyPrefabRuntimeData bodyPrefabRuntimeData = SummerRaceConfigLoader.LoadBodyPrefabRuntimeData(bodyType);
		rb.bodyType = RigidbodyType2D.Dynamic;
		rb.mass = currentBodyProfile.Mass;
		rb.gravityScale = currentBodyProfile.GravityScale;
		rb.drag = currentBodyProfile.Drag;
		rb.angularDrag = currentBodyProfile.AngularDrag;
		rb.interpolation = RigidbodyInterpolation2D.Interpolate;
		rb.collisionDetectionMode = CollisionDetectionMode2D.Continuous;
		rb.constraints = RigidbodyConstraints2D.None;
		if (bodyPrefabRuntimeData.ColliderPoints == null || bodyPrefabRuntimeData.ColliderPoints.Length < 3)
		{
			throw new InvalidOperationException("Body prefab colliderPoints are missing for " + bodyType);
		}
		SummerRaceCharacterBase.BindBodySkeletonAnimation(bodyVisual, ref bodySkeletonAnimation, bodyPrefabRuntimeData.BodySkeletonData, 26, "[SummerRace][Player] BodyVisual", SummerRaceCharacterBase.BattleBodyPlayerSkinStack);
		bodyVisual.localPosition = ConvertBodyAuthoringPointToPlayerLocal(bodyPrefabRuntimeData.BodyVisualLocalPosition);
		bodyVisual.localRotation = bodyPrefabRuntimeData.BodyVisualLocalRotation;
		bodyVisual.localScale = ConvertBodyAuthoringScaleToPlayerLocal(bodyPrefabRuntimeData.BodyVisualLocalScale);
		SummerRaceCharacterBase.FitBodySkeletonVisualToTargetSize(bodyVisual, bodySkeletonAnimation, bodyPrefabRuntimeData.BodyVisualTargetSize, "[SummerRace][Player] BodyVisualFit");
		bodyVisual.localScale = new Vector3(bodyVisual.localScale.x * bodyPrefabRuntimeData.BattleBodyVisualScale, bodyVisual.localScale.y * bodyPrefabRuntimeData.BattleBodyVisualScale, bodyVisual.localScale.z);
		EnsurePlayerBattleAdmin();
		poly.pathCount = 1;
		poly.SetPath(0, SummerRaceCharacterBase.OffsetColliderPath(SummerRaceCharacterBase.FitColliderPathToBodySkeletonBounds(bodyVisual, bodySkeletonAnimation, poly, ConvertBodyAuthoringColliderPathToPlayerLocal(bodyPrefabRuntimeData.ColliderPoints), "[SummerRace][Player] BodyColliderFit"), RuntimeBodyColliderLocalOffset, "[SummerRace][Player] BodyColliderOffset"));
		int num = LayerMask.NameToLayer("Character");
		if (num < 0)
		{
			throw new InvalidOperationException("[SummerRace][Player] Layer 'Character' is required for body layer.");
		}
		base.gameObject.layer = num;
		base.transform.localScale = currentBodyProfile.BodyScale;
		frontWheelLocal = ConvertBodyAuthoringPointToPlayerLocal(currentBodyProfile.FrontWheelPos);
		backWheelLocal = ConvertBodyAuthoringPointToPlayerLocal(currentBodyProfile.BackWheelPos);
		float num2 = Mathf.Max(0.01f, bodyPrefabRuntimeData.FrontWheelVisualScale);
		float num3 = Mathf.Max(0.01f, bodyPrefabRuntimeData.BackWheelVisualScale);
		frontWheelRadius = currentBodyProfile.FrontWheelRadius * num2;
		backWheelRadius = currentBodyProfile.BackWheelRadius * num3;
		frontWheel = EnsureWheel("FrontWheel", frontWheelLocal, frontWheelRadius, ConvertBodyAuthoringPointToPlayerLocal(bodyPrefabRuntimeData.FrontWheelVisualLocalPosition), bodyPrefabRuntimeData.FrontWheelVisualLocalRotation, bodyPrefabRuntimeData.FrontWheelVisualLocalScale, bodyPrefabRuntimeData.FrontWheelOuterSprite, bodyPrefabRuntimeData.FrontWheelInnerSprite);
		backWheel = EnsureWheel("BackWheel", backWheelLocal, backWheelRadius, ConvertBodyAuthoringPointToPlayerLocal(bodyPrefabRuntimeData.BackWheelVisualLocalPosition), bodyPrefabRuntimeData.BackWheelVisualLocalRotation, bodyPrefabRuntimeData.BackWheelVisualLocalScale, bodyPrefabRuntimeData.BackWheelOuterSprite, bodyPrefabRuntimeData.BackWheelInnerSprite);
		EnsureSoftOvalShadow();
		ResetWheelVisualState();
		EnsurePlayerColliderOutlines();
		UpdateBuildAnalyticsCache();
	}

	private void EnsureSoftOvalShadow()
	{
		VehicleSoftOvalShadowController vehicleSoftOvalShadowController = GetComponent<VehicleSoftOvalShadowController>();
		if (vehicleSoftOvalShadowController == null)
		{
			vehicleSoftOvalShadowController = base.gameObject.AddComponent<VehicleSoftOvalShadowController>();
		}
		MeshRenderer bodyRenderer = ((bodySkeletonAnimation != null) ? bodySkeletonAnimation.GetComponent<MeshRenderer>() : null);
		vehicleSoftOvalShadowController.ConfigureRuntime(bodySkeletonAnimation, bodyVisual, frontWheel, backWheel, frontWheelRadius, backWheelRadius, bodyRenderer, driveContactMask);
	}

	private void ApplyConfiguredBuildDefinition()
	{
		if (hasRuntimeBuildOverride)
		{
			bodyType = runtimeOverrideBodyType;
			return;
		}
		SummerRaceBuildDefSO summerRaceBuildDefSO = RequireConfiguredBuildDefinition();
		bodyType = SummerRaceConfigLoader.ToRuntimeBodyType(summerRaceBuildDefSO.body.bodyType);
	}

	private SummerRaceBuildDefSO RequireConfiguredBuildDefinition()
	{
		if (string.IsNullOrWhiteSpace(configuredBuildName))
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing configured build name.");
		}
		SummerRaceBuildDefSO summerRaceBuildDefSO = SummerRaceConfigLoader.LoadBuildDef(configuredBuildName);
		if (summerRaceBuildDefSO == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Configured build asset not found: " + configuredBuildName);
		}
		if (summerRaceBuildDefSO.body == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Configured build body is null: " + summerRaceBuildDefSO.name);
		}
		if (summerRaceBuildDefSO.weapons == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Configured build weapons list is null: " + summerRaceBuildDefSO.name);
		}
		if (summerRaceBuildDefSO.equips == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Configured build equips list is null: " + summerRaceBuildDefSO.name);
		}
		if (!summerRaceBuildDefSO.ValidateBuild(out var reason))
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid configured build '" + summerRaceBuildDefSO.buildName + "': " + reason);
		}
		return summerRaceBuildDefSO;
	}

	private void EnsurePlayerColliderOutlines()
	{
		if (!drawColliderOutlineInGame || !SummerRaceFightManager.IsArenaColliderOutlineInGameEnabled())
		{
			SummerRaceColliderOutline component = base.gameObject.GetComponent<SummerRaceColliderOutline>();
			if (component != null)
			{
				UnityEngine.Object.Destroy(component);
			}
			LineRenderer component2 = base.gameObject.GetComponent<LineRenderer>();
			if (component2 != null)
			{
				UnityEngine.Object.Destroy(component2);
			}
		}
		else
		{
			SummerRaceColliderOutline.Ensure(base.gameObject, playerBodyOutlineColor, 0.024f, 174);
		}
	}

	private void EnsureBodyVisualRefs()
	{
		if (bodyVisual == null)
		{
			bodyVisual = base.transform.Find("BodyVisual");
			if (bodyVisual == null)
			{
				GameObject gameObject = new GameObject("BodyVisual");
				gameObject.transform.SetParent(base.transform, worldPositionStays: false);
				bodyVisual = gameObject.transform;
			}
		}
	}

	private void EnsurePlayerBattleAdmin()
	{
		if (bodyVisual == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] BodyVisual is required before mounting admin spine.");
		}
		if (playerAdminRoot == null)
		{
			playerAdminRoot = base.transform.Find("AdminRoot");
			if (playerAdminRoot == null)
			{
				playerAdminRoot = bodyVisual.Find("AdminRoot");
			}
			if (playerAdminRoot == null)
			{
				GameObject gameObject = new GameObject("AdminRoot");
				gameObject.hideFlags = HideFlags.DontSave;
				gameObject.transform.SetParent(base.transform, worldPositionStays: false);
				playerAdminRoot = gameObject.transform;
			}
		}
		if (playerAdminRoot.parent != base.transform)
		{
			playerAdminRoot.SetParent(base.transform, worldPositionStays: false);
		}
		playerAdminRoot.localPosition = ResolvePlayerBattleAdminRootLocalPosition();
		playerAdminRoot.localRotation = Quaternion.identity;
		playerAdminRoot.localScale = Vector3.one;
		Transform transform = playerAdminRoot.Find("AdminSpine");
		if (transform == null)
		{
			GameObject obj = new GameObject("AdminSpine");
			obj.hideFlags = HideFlags.DontSave;
			obj.transform.SetParent(playerAdminRoot, worldPositionStays: false);
			transform = obj.transform;
		}
		transform.localPosition = Vector3.zero;
		transform.localRotation = Quaternion.Euler(0f, 180f, 0f);
		transform.localScale = Vector3.one;
		playerAdminSkeletonAnimation = transform.GetComponent<SkeletonAnimation>();
		if (playerAdminSkeletonAnimation == null)
		{
			playerAdminSkeletonAnimation = transform.gameObject.AddComponent<SkeletonAnimation>();
		}
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow("Assets/ABResources/SummerRaceActivity/Spine/Admin/Battle/SummerRace_admin_SkeletonData.asset", "[SummerRace][Player] BattleAdmin");
		playerAdminSkeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		playerAdminSkeletonAnimation.Initialize(overwrite: true);
		if (playerAdminSkeletonAnimation.Skeleton == null || playerAdminSkeletonAnimation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Battle admin skeleton runtime data is missing.");
		}
		ApplyBattleAdminSkinOrThrow(playerAdminSkeletonAnimation, "1001", "[SummerRace][Player] BattleAdmin");
		ClearPlayerBattleAdminOpeningOutTrackEntry();
		playerBattleAdminOpeningOutCompleted = false;
		PlayPlayerBattleAdminAnimation("idle", loop: true, throwIfMissing: true);
		MeshRenderer component = playerAdminSkeletonAnimation.GetComponent<MeshRenderer>();
		if (component == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Battle admin MeshRenderer is missing.");
		}
		MeshRenderer meshRenderer = ((bodySkeletonAnimation != null) ? bodySkeletonAnimation.GetComponent<MeshRenderer>() : null);
		if (meshRenderer != null)
		{
			component.sortingLayerID = meshRenderer.sortingLayerID;
		}
		component.sortingOrder = 25;
		component.enabled = true;
	}

	protected override void OnSpawnEntryAnimationReset()
	{
		ClearPlayerBattleAdminOpeningOutTrackEntry();
		playerBattleAdminOpeningOutCompleted = false;
		PlayPlayerBattleAdminAnimation("idle", loop: true, throwIfMissing: false);
	}

	protected override void OnSpawnLandingContactAccepted()
	{
		PlayPlayerBattleAdminAnimation("out", loop: false, throwIfMissing: true);
		RegisterPlayerBattleAdminOpeningOutTrackEntry();
	}

	public void PlaySpecialDefeatBattleAdminIntro()
	{
		PlayPlayerBattleAdminAnimationThenIdle("in", throwIfMissing: true);
	}

	private void PlayPlayerBattleAdminAnimation(string animationName, bool loop, bool throwIfMissing)
	{
		PlayBattleAdminAnimation(playerAdminSkeletonAnimation, animationName, loop, throwIfMissing, "[SummerRace][Player] BattleAdmin");
	}

	private void PlayPlayerBattleAdminAnimationThenIdle(string animationName, bool throwIfMissing)
	{
		PlayBattleAdminAnimationThenIdle(playerAdminSkeletonAnimation, animationName, "idle", throwIfMissing, "[SummerRace][Player] BattleAdmin");
	}

	public Vector3 ResolvePlayerBattleAdminLabelWorldPosition()
	{
		if (playerAdminRoot != null)
		{
			return playerAdminRoot.position;
		}
		return base.transform.position;
	}

	public float ResolvePlayerBattleAdminLabelScreenOffsetY()
	{
		if (!playerBattleAdminOpeningOutCompleted)
		{
			return 150f;
		}
		return 75f;
	}

	private static void ApplyBattleAdminSkinOrThrow(SkeletonAnimation skeletonAnimation, string skinName, string context)
	{
		if (skeletonAnimation == null || skeletonAnimation.Skeleton == null || skeletonAnimation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace] Battle admin skeleton runtime data is missing. context=" + context);
		}
		string text = (string.IsNullOrWhiteSpace(skinName) ? "1001" : skinName.Trim());
		Skin skin = skeletonAnimation.Skeleton.Data.FindSkin(text);
		if (skin == null)
		{
			throw new InvalidOperationException("[SummerRace] Battle admin skeleton missing skin '" + text + "'. context=" + context);
		}
		skeletonAnimation.Skeleton.SetSkin(skin);
		skeletonAnimation.Skeleton.SetSlotsToSetupPose();
		skeletonAnimation.Skeleton.UpdateWorldTransform();
		skeletonAnimation.LateUpdate();
	}

	private static void PlayBattleAdminAnimation(SkeletonAnimation skeletonAnimation, string animationName, bool loop, bool throwIfMissing, string context)
	{
		if (skeletonAnimation == null || skeletonAnimation.Skeleton == null || skeletonAnimation.Skeleton.Data == null)
		{
			if (throwIfMissing)
			{
				throw new InvalidOperationException("[SummerRace] Battle admin skeleton runtime data is missing. context=" + context);
			}
			return;
		}
		Spine.Animation animation = skeletonAnimation.Skeleton.Data.FindAnimation(animationName);
		if (animation == null)
		{
			if (throwIfMissing)
			{
				throw new InvalidOperationException("[SummerRace] Battle admin skeleton missing animation '" + animationName + "'. context=" + context);
			}
		}
		else
		{
			skeletonAnimation.loop = loop;
			skeletonAnimation.AnimationState.SetAnimation(0, animation.Name, loop);
		}
	}

	private static void PlayBattleAdminAnimationThenIdle(SkeletonAnimation skeletonAnimation, string animationName, string idleAnimationName, bool throwIfMissing, string context)
	{
		if (skeletonAnimation == null || skeletonAnimation.Skeleton == null || skeletonAnimation.Skeleton.Data == null)
		{
			if (throwIfMissing)
			{
				throw new InvalidOperationException("[SummerRace] Battle admin skeleton runtime data is missing. context=" + context);
			}
			return;
		}
		Spine.Animation animation = skeletonAnimation.Skeleton.Data.FindAnimation(animationName);
		Spine.Animation animation2 = skeletonAnimation.Skeleton.Data.FindAnimation(idleAnimationName);
		if (animation == null || animation2 == null)
		{
			if (throwIfMissing)
			{
				throw new InvalidOperationException("[SummerRace] Battle admin skeleton missing animation '" + animationName + "' or '" + idleAnimationName + "'. context=" + context);
			}
		}
		else
		{
			skeletonAnimation.loop = false;
			skeletonAnimation.AnimationState.SetAnimation(0, animation.Name, loop: false);
			skeletonAnimation.AnimationState.AddAnimation(0, animation2.Name, loop: true, 0f);
		}
	}

	private void RegisterPlayerBattleAdminOpeningOutTrackEntry()
	{
		if (!(playerAdminSkeletonAnimation == null) && playerAdminSkeletonAnimation.AnimationState != null)
		{
			ClearPlayerBattleAdminOpeningOutTrackEntry();
			TrackEntry current = playerAdminSkeletonAnimation.AnimationState.GetCurrent(0);
			if (current != null && current.Animation != null && !(current.Animation.Name != "out"))
			{
				playerBattleAdminOpeningOutTrackEntry = current;
				playerBattleAdminOpeningOutTrackEntry.Complete += OnPlayerBattleAdminOpeningOutTrackEntryComplete;
			}
		}
	}

	private void ClearPlayerBattleAdminOpeningOutTrackEntry()
	{
		if (playerBattleAdminOpeningOutTrackEntry != null)
		{
			playerBattleAdminOpeningOutTrackEntry.Complete -= OnPlayerBattleAdminOpeningOutTrackEntryComplete;
			playerBattleAdminOpeningOutTrackEntry = null;
		}
	}

	private void OnPlayerBattleAdminOpeningOutTrackEntryComplete(TrackEntry trackEntry)
	{
		if (trackEntry != null && trackEntry.Animation != null && trackEntry.Animation.Name == "out")
		{
			playerBattleAdminOpeningOutCompleted = true;
		}
		ClearPlayerBattleAdminOpeningOutTrackEntry();
	}

	private Vector3 ResolvePlayerBattleAdminRootLocalPosition()
	{
		if (bodyVisual == null || bodySkeletonAnimation == null || bodySkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body skeleton is required before resolving admin root position.");
		}
		GetBodySkeletonLocalBounds(bodySkeletonAnimation, "[SummerRace][Player] BattleAdminPosition", out var center, out var size);
		float num = ResolvePlayerBattleAdminBodyAnchorX();
		Vector3 position = new Vector3(center.x + size.x * num, center.y, 0f);
		Vector3 position2 = bodyVisual.TransformPoint(position);
		return new Vector3(base.transform.InverseTransformPoint(position2).x, ResolvePlayerBattleAdminRootLocalY(), 0f);
	}

	private float ResolvePlayerBattleAdminBodyAnchorX()
	{
		return (bodyType switch
		{
			SummerRaceBodyType.Light => PlayerBattleAdminLightUiPosition, 
			SummerRaceBodyType.Heavy => PlayerBattleAdminHeavyUiPosition, 
			_ => PlayerBattleAdminMediumUiPosition, 
		} - PlayerBattleAdminUiCarContentPosition).x / PlayerBattleAdminUiCarContentSize.x;
	}

	private float ResolvePlayerBattleAdminRootLocalY()
	{
		return bodyType switch
		{
			SummerRaceBodyType.Light => 0.35f, 
			SummerRaceBodyType.Heavy => 0.85f, 
			_ => 0.45f, 
		};
	}

	private static void GetBodySkeletonLocalBounds(SkeletonAnimation skeletonAnimation, string context, out Vector2 center, out Vector2 size)
	{
		if (skeletonAnimation == null || skeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing body skeleton for bounds query. context=" + context);
		}
		float x = 0f;
		float y = 0f;
		float width = 0f;
		float height = 0f;
		float[] vertexBuffer = null;
		skeletonAnimation.Skeleton.UpdateWorldTransform();
		skeletonAnimation.Skeleton.GetBounds(out x, out y, out width, out height, ref vertexBuffer);
		if (width <= 0.0001f || height <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid body skeleton bounds. context=" + context + " size=(" + width + "," + height + ")");
		}
		center = new Vector2(x + width * 0.5f, y + height * 0.5f);
		size = new Vector2(width, height);
	}

	private void BuildLoadout()
	{
		weaponSlots.Clear();
		weaponOverloadActiveUntilBySlot.Clear();
		weaponOverloadCooldownUntilBySlot.Clear();
		equipSlots.Clear();
		BuildWeaponConfigLookup();
		currentCost = 0;
		currentLoadWeight = 0f;
		if (hasRuntimeBuildOverride)
		{
			BuildLoadoutFromRuntimeOverride();
		}
		else
		{
			SummerRaceBuildDefSO summerRaceBuildDefSO = RequireConfiguredBuildDefinition();
			for (int i = 0; i < summerRaceBuildDefSO.weapons.Count; i++)
			{
				SummerRaceWeaponDefSO summerRaceWeaponDefSO = summerRaceBuildDefSO.weapons[i];
				if (summerRaceWeaponDefSO == null)
				{
					throw new InvalidOperationException("[SummerRace][Player] Null weapon entry in configured build: " + summerRaceBuildDefSO.name + " index=" + i);
				}
				WeaponKind weaponKind = SummerRaceConfigLoader.ToRuntimeWeaponKind(summerRaceWeaponDefSO.weaponType);
				AppendWeaponRuntime(ResolveWeaponDef(weaponKind), weaponKind);
			}
			for (int j = 0; j < summerRaceBuildDefSO.equips.Count; j++)
			{
				SummerRaceEquipDefSO summerRaceEquipDefSO = summerRaceBuildDefSO.equips[j];
				if (summerRaceEquipDefSO == null)
				{
					throw new InvalidOperationException("[SummerRace][Player] Null equip entry in configured build: " + summerRaceBuildDefSO.name + " index=" + j);
				}
				EquipKind equipKind = SummerRaceConfigLoader.ToRuntimeEquipKind(summerRaceEquipDefSO.equipType);
				AppendEquipRuntime(summerRaceEquipDefSO, equipKind);
			}
		}
		if (currentCost > currentBodyProfile.CostCap)
		{
			throw new InvalidOperationException("[SummerRace][Player] Loadout cost exceeds body cap: cost=" + currentCost + " cap=" + currentBodyProfile.CostCap + " body=" + BodyLabel);
		}
		RecomputeRuntimeCenterOfMass();
		UpdateBuildAnalyticsCache();
	}

	private void BuildLoadoutFromRuntimeOverride()
	{
		for (int i = 0; i < runtimeOverrideWeapons.Length; i++)
		{
			WeaponKind weaponKind = runtimeOverrideWeapons[i];
			AppendWeaponRuntime(ResolveWeaponDef(weaponKind), weaponKind);
		}
		for (int j = 0; j < runtimeOverrideEquips.Length; j++)
		{
			EquipKind equipKind = runtimeOverrideEquips[j];
			AppendEquipRuntime(ResolveEquipDef(equipKind), equipKind);
		}
	}

	private void AppendWeaponRuntime(SummerRaceWeaponDefSO weaponDef, WeaponKind weaponKind)
	{
		if (weaponDef == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime weapon definition is null: " + weaponKind);
		}
		SummerRaceWeaponSpec summerRaceWeaponSpec = weaponDef.ToRuntimeSpec(weaponKind);
		WeaponRuntime item = new WeaponRuntime
		{
			Def = weaponDef,
			MeleeImpactPayload = SummerRaceCombatEffectFactory.CreateWeaponImpactPayload(summerRaceWeaponSpec, CombatTriggerType.MeleeHit)
		};
		weaponSlots.Add(item);
		weaponOverloadActiveUntilBySlot.Add(0f);
		weaponOverloadCooldownUntilBySlot.Add(0f);
		currentCost += summerRaceWeaponSpec.Cost;
		currentLoadWeight += summerRaceWeaponSpec.LoadWeight;
	}

	private void AppendEquipRuntime(SummerRaceEquipDefSO equipDef, EquipKind equipKind)
	{
		if (equipDef == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Runtime equip definition is null: " + equipKind);
		}
		SummerRaceEquipSpec summerRaceEquipSpec = equipDef.ToRuntimeSpec(equipKind);
		EquipRuntime item = new EquipRuntime
		{
			Def = equipDef
		};
		equipSlots.Add(item);
		currentCost += summerRaceEquipSpec.Cost;
		currentLoadWeight += summerRaceEquipSpec.LoadWeight;
	}

	private void RebuildModularBackend()
	{
		List<SummerRaceWeaponDefSO> list = new List<SummerRaceWeaponDefSO>(weaponSlots.Count);
		List<int> list2 = (hasRuntimeBuildOverride ? new List<int>(weaponSlots.Count) : null);
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime != null && weaponRuntime.Def != null)
			{
				list.Add(weaponRuntime.Def);
				list2?.Add(runtimeOverrideWeaponSlotIndices[i]);
			}
		}
		List<SummerRaceEquipDefSO> list3 = new List<SummerRaceEquipDefSO>(equipSlots.Count);
		List<int> list4 = (hasRuntimeBuildOverride ? new List<int>(equipSlots.Count) : null);
		for (int j = 0; j < equipSlots.Count; j++)
		{
			EquipRuntime equipRuntime = equipSlots[j];
			if (equipRuntime != null && equipRuntime.Def != null)
			{
				list3.Add(equipRuntime.Def);
				list4?.Add(runtimeOverrideEquipSlotIndices[j]);
			}
		}
		RebuildModularBackend(bodyType, list, list3, cachedTargetEnemy, GetWeaponForwardVector(), list2, list4);
	}

	private void RecomputeRuntimeCenterOfMass()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Player.RecomputeRuntimeCenterOfMass");
		if (currentBodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body profile is missing while recomputing COM.");
		}
		float num = Mathf.Max(0.01f, currentBodyProfile.Mass);
		Vector2 vector = ConvertBodyAuthoringPointToPlayerLocal(currentBodyProfile.BodyComOffset) * num;
		float num2 = Mathf.Max(0.4f, frontWheelRadius * 5.5f);
		float num3 = Mathf.Max(0.4f, backWheelRadius * 5.5f);
		vector += frontWheelLocal * num2;
		vector += backWheelLocal * num3;
		num += num2 + num3;
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime == null || weaponRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while recomputing COM. slot=" + i);
			}
			float num4 = Mathf.Max(0.2f, Mathf.Max(0f, weaponRuntime.Def.loadWeight) * 2.2f);
			Vector2 vector2 = ResolveMountMassPointLocal(SummerRaceMountSlotTypeConfig.Weapon, i);
			vector += vector2 * num4;
			num += num4;
		}
		for (int j = 0; j < equipSlots.Count; j++)
		{
			EquipRuntime equipRuntime = equipSlots[j];
			if (equipRuntime == null || equipRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Missing equip def while recomputing COM. slot=" + j);
			}
			float num5 = Mathf.Max(0.15f, Mathf.Max(0f, equipRuntime.Def.loadWeight) * 1.8f);
			Vector2 vector3 = ResolveMountMassPointLocal(SummerRaceMountSlotTypeConfig.Equip, j);
			vector += vector3 * num5;
			num += num5;
		}
		rigidbody2D.mass = num;
		rigidbody2D.centerOfMass = vector / Mathf.Max(0.01f, num);
	}

	private Vector2 ResolveMountMassPointLocal(SummerRaceMountSlotTypeConfig slotType, int slotIndex)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyDef(bodyType);
		if (summerRaceBodyDefSO == null || summerRaceBodyDefSO.mountPoints == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing body mount definitions for COM solve.");
		}
		for (int i = 0; i < summerRaceBodyDefSO.mountPoints.Count; i++)
		{
			SummerRaceMountPointDefConfig summerRaceMountPointDefConfig = summerRaceBodyDefSO.mountPoints[i];
			if (summerRaceMountPointDefConfig != null && summerRaceMountPointDefConfig.slotType == slotType && summerRaceMountPointDefConfig.slotIndex == slotIndex)
			{
				return ConvertBodyAuthoringPointToPlayerLocal(summerRaceMountPointDefConfig.localPosition);
			}
		}
		throw new InvalidOperationException("[SummerRace][Player] Missing mount point for COM solve: " + slotType.ToString() + " index=" + slotIndex);
	}

	private static Vector2 ConvertBodyAuthoringPointToPlayerLocal(Vector2 point)
	{
		return new Vector2(point.x * -1f, point.y);
	}

	private static Vector3 ConvertBodyAuthoringPointToPlayerLocal(Vector3 point)
	{
		return new Vector3(point.x * -1f, point.y, point.z);
	}

	private static Vector3 ConvertBodyAuthoringScaleToPlayerLocal(Vector3 scale)
	{
		return new Vector3(scale.x * -1f, scale.y, scale.z);
	}

	private static Vector2[] ConvertBodyAuthoringColliderPathToPlayerLocal(Vector2[] authoringPath)
	{
		if (authoringPath == null || authoringPath.Length < 3)
		{
			throw new InvalidOperationException("[SummerRace][Player] Body authoring collider path is invalid.");
		}
		Vector2[] array = new Vector2[authoringPath.Length];
		for (int i = 0; i < authoringPath.Length; i++)
		{
			array[i] = ConvertBodyAuthoringPointToPlayerLocal(authoringPath[authoringPath.Length - 1 - i]);
		}
		return array;
	}

	private void UpdateBuildAnalyticsCache()
	{
		RequireCurrentBodyProfile("Player.UpdateBuildAnalyticsCache");
		WeaponKind[] array = new WeaponKind[weaponSlots.Count];
		EquipKind[] array2 = new EquipKind[equipSlots.Count];
		float num = 0f;
		float num2 = 0f;
		for (int i = 0; i < weaponSlots.Count; i++)
		{
			WeaponRuntime weaponRuntime = weaponSlots[i];
			if (weaponRuntime == null || weaponRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Invalid weapon runtime while rebuilding build analytics. slot=" + i);
			}
			array[i] = SummerRaceConfigLoader.ToRuntimeWeaponKind(weaponRuntime.Def.weaponType);
			SummerRaceWeaponAnalyticsEstimate summerRaceWeaponAnalyticsEstimate = SummerRaceBuildScoring.EstimateWeaponOutput(weaponRuntime.Def);
			num += summerRaceWeaponAnalyticsEstimate.EstimatedDps;
			num2 += summerRaceWeaponAnalyticsEstimate.RecoilLoad;
		}
		for (int j = 0; j < equipSlots.Count; j++)
		{
			EquipRuntime equipRuntime = equipSlots[j];
			if (equipRuntime == null || equipRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Invalid equip runtime while rebuilding build analytics. slot=" + j);
			}
			array2[j] = SummerRaceConfigLoader.ToRuntimeEquipKind(equipRuntime.Def.equipType);
		}
		float num3 = Mathf.Abs(frontWheelLocal.x - backWheelLocal.x);
		Vector2 centerOfMass = RequirePhysicsBodyReady("Player.UpdateBuildAnalyticsCache").centerOfMass;
		float frontRearMassBias = ((num3 > 0.001f) ? Mathf.Clamp(centerOfMass.x / Mathf.Max(0.01f, num3 * 0.5f), -1f, 1f) : 0f);
		cachedBuildProfile = new SummerRaceBuildProfile
		{
			SourceTag = "Player",
			BodyType = bodyType,
			BodyLabel = BodyLabel,
			Weapons = array,
			Equips = array2,
			TotalMass = RequirePhysicsBodyReady("Player.UpdateBuildAnalyticsCache").mass,
			CenterOfMassLocal = centerOfMass,
			FrontWheelRadius = frontWheelRadius,
			BackWheelRadius = backWheelRadius,
			WheelBase = num3,
			FrontRearMassBias = frontRearMassBias,
			CruiseSpeed = currentBodyProfile.CruiseSpeed,
			TractionGain = currentBodyProfile.TractionGain,
			EstimatedDps = num,
			RecoilLoad = num2,
			CostUsed = currentCost,
			CostCap = CostCap
		};
		cachedBuildRating = SummerRaceBuildScoring.Evaluate(cachedBuildProfile);
		cachedBuildArchetype = SummerRaceBuildScoring.Classify(cachedBuildProfile, cachedBuildRating);
		cachedBuildSignature = SummerRaceBuildScoring.BuildSignature(cachedBuildProfile);
		cachedBuildSummary = cachedBuildRating.ToShortLabel() + " | " + SummerRaceBuildScoring.GetArchetypeLabel(cachedBuildArchetype) + " | " + SummerRaceBuildScoring.Describe(cachedBuildProfile, cachedBuildRating);
	}

	private string ResolveBuildSummary()
	{
		if (!Application.isPlaying)
		{
			string text = ((currentBodyProfile != null) ? currentBodyProfile.Label : bodyType.ToString());
			string text2 = ((weaponSlots.Count > 0 && weaponSlots[0] != null && weaponSlots[0].Def != null) ? weaponSlots[0].Def.displayName : "Weapon");
			string text3 = ((equipSlots.Count > 0 && equipSlots[0] != null && equipSlots[0].Def != null) ? equipSlots[0].Def.displayName : "Equip");
			return text + " | " + text2 + " | " + text3;
		}
		RequireCurrentBodyProfile("Player.ResolveBuildSummary");
		if (weaponSlots.Count <= 0 || weaponSlots[0] == null || weaponSlots[0].Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing primary weapon runtime while resolving build summary.");
		}
		if (equipSlots.Count <= 0 || equipSlots[0] == null || equipSlots[0].Def == null)
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing primary equip runtime while resolving build summary.");
		}
		if (string.IsNullOrWhiteSpace(cachedBuildSummary))
		{
			throw new InvalidOperationException("[SummerRace][Player] Missing cached build summary during runtime.");
		}
		return cachedBuildSummary;
	}

	private void BuildWeaponConfigLookup()
	{
		ClearRuntimeWeaponConfigOverrides();
		ClearRuntimeEquipConfigOverrides();
		weaponConfigLookup.Clear();
		if (weaponConfigOverrides != null)
		{
			for (int i = 0; i < weaponConfigOverrides.Length; i++)
			{
				SummerRaceWeaponDefSO summerRaceWeaponDefSO = weaponConfigOverrides[i];
				if (!(summerRaceWeaponDefSO == null))
				{
					WeaponKind weaponType = (WeaponKind)summerRaceWeaponDefSO.weaponType;
					if (Enum.IsDefined(typeof(WeaponKind), weaponType))
					{
						weaponConfigLookup[weaponType] = summerRaceWeaponDefSO;
					}
				}
			}
		}
		if (!hasRuntimeBuildOverride || runtimeWeaponProfileOverrides == null || runtimeWeaponProfileOverrides.Length == 0)
		{
			return;
		}
		for (int j = 0; j < runtimeWeaponProfileOverrides.Length; j++)
		{
			WeaponProfileOverrideSpec weaponProfileOverrideSpec = runtimeWeaponProfileOverrides[j];
			if (weaponProfileOverrideSpec == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime weapon override spec is null. index=" + j);
			}
			if (weaponProfileOverrideSpec.Damage < 0)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime weapon override damage must be >= 0. kind=" + weaponProfileOverrideSpec.WeaponKind.ToString() + " damage=" + weaponProfileOverrideSpec.Damage);
			}
			if (weaponProfileOverrideSpec.FireInterval <= 0f)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime weapon override fireInterval must be > 0. kind=" + weaponProfileOverrideSpec.WeaponKind.ToString() + " fireInterval=" + weaponProfileOverrideSpec.FireInterval);
			}
			if (!weaponConfigLookup.TryGetValue(weaponProfileOverrideSpec.WeaponKind, out var value) || value == null)
			{
				value = SummerRaceConfigLoader.LoadWeaponDef(weaponProfileOverrideSpec.WeaponKind);
			}
			if (value == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Runtime weapon override source config not found: " + weaponProfileOverrideSpec.WeaponKind);
			}
			SummerRaceWeaponDefSO summerRaceWeaponDefSO2 = UnityEngine.Object.Instantiate(value);
			summerRaceWeaponDefSO2.name = value.name + "_RuntimeOverride";
			summerRaceWeaponDefSO2.cost = Mathf.Max(0, weaponProfileOverrideSpec.Cost);
			summerRaceWeaponDefSO2.energyCost = Mathf.Max(0f, weaponProfileOverrideSpec.EnergyCost);
			summerRaceWeaponDefSO2.damage = weaponProfileOverrideSpec.Damage;
			summerRaceWeaponDefSO2.modularFireInterval = weaponProfileOverrideSpec.FireInterval;
			if (weaponProfileOverrideSpec.HasBurnOverride)
			{
				summerRaceWeaponDefSO2.burnDps = Mathf.Max(0, weaponProfileOverrideSpec.BurnDps);
				summerRaceWeaponDefSO2.burnDuration = Mathf.Max(0f, weaponProfileOverrideSpec.BurnDuration);
			}
			SummerRaceWeaponRuntimeOverrideUtility.ApplyScatterShellEffectParams(summerRaceWeaponDefSO2, weaponProfileOverrideSpec.EffectParams);
			SummerRaceWeaponRuntimeOverrideUtility.ApplyRotatingSawSpinSpeedScale(summerRaceWeaponDefSO2, weaponProfileOverrideSpec.EffectParams);
			runtimeClonedWeaponDefs.Add(summerRaceWeaponDefSO2);
			weaponConfigLookup[weaponProfileOverrideSpec.WeaponKind] = summerRaceWeaponDefSO2;
		}
	}

	private SummerRaceEquipDefSO ResolveEquipDef(EquipKind kind)
	{
		if (hasRuntimeBuildOverride && runtimeEquipProfileOverrides != null && runtimeEquipProfileOverrides.Length != 0)
		{
			for (int i = 0; i < runtimeEquipProfileOverrides.Length; i++)
			{
				EquipProfileOverrideSpec equipProfileOverrideSpec = runtimeEquipProfileOverrides[i];
				if (equipProfileOverrideSpec != null && equipProfileOverrideSpec.EquipKind == kind)
				{
					SummerRaceEquipDefSO summerRaceEquipDefSO = SummerRaceConfigLoader.LoadEquipDef(kind);
					if (summerRaceEquipDefSO == null)
					{
						throw new InvalidOperationException("[SummerRace][Player] Runtime equip override source config not found: " + kind);
					}
					SummerRaceEquipDefSO summerRaceEquipDefSO2 = UnityEngine.Object.Instantiate(summerRaceEquipDefSO);
					summerRaceEquipDefSO2.name = summerRaceEquipDefSO.name + "_RuntimeOverride";
					summerRaceEquipDefSO2.cost = Mathf.Max(0, equipProfileOverrideSpec.Cost);
					summerRaceEquipDefSO2.energyCost = Mathf.Max(0f, equipProfileOverrideSpec.EnergyCost);
					runtimeClonedEquipDefs.Add(summerRaceEquipDefSO2);
					return summerRaceEquipDefSO2;
				}
			}
		}
		return SummerRaceConfigLoader.LoadEquipDef(kind);
	}

	private SummerRaceWeaponDefSO ResolveWeaponDef(WeaponKind kind)
	{
		if (weaponConfigLookup.TryGetValue(kind, out var value) && value != null)
		{
			return value;
		}
		return SummerRaceConfigLoader.LoadWeaponDef(kind);
	}

	private void SnapToLaneImmediate()
	{
		if (!(SummerRaceFightManager.Instance != null) || !SummerRaceFightManager.Instance.IsBattleActive || movementLocked)
		{
			float minX = -6.7999997f;
			float maxX = 6.7999997f;
			float spawnX = ResolveAuthoredSpawnAnchorX(minX, maxX);
			SnapToLaneImmediateAtX(spawnX);
		}
	}

	private void SnapToLaneImmediateAtX(float spawnX)
	{
		float min = -6.7999997f;
		float max = 6.7999997f;
		float x = Mathf.Clamp(spawnX, min, max);
		float y = ResolveSpawnYAlignedToArenaFloor(laneY + ResolveSpawnLaneLift(), "Player.SnapToLaneImmediate");
		ApplySpawnPoseImmediate(x, y);
	}

	private void SnapToWaveEntryAtX(float spawnX, float spawnY)
	{
		if (float.IsNaN(spawnX) || float.IsInfinity(spawnX))
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid wave entry spawnX: " + spawnX);
		}
		float num = (float.IsNaN(spawnY) ? ResolveWaveEntryBaseSpawnY("Player.SnapToWaveEntry") : spawnY);
		if (float.IsInfinity(num))
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid wave entry spawnY: " + num);
		}
		ApplySpawnPoseImmediate(spawnX, num);
	}

	private float ResolveWaveEntrySpawnYFromBase(float baseSpawnY)
	{
		return baseSpawnY + Mathf.Max(0f, waveEntryDropHeight);
	}

	private float ResolveWaveEntryBaseSpawnY(string context)
	{
		return ResolveSpawnYAlignedToArenaFloor(laneY + ResolveSpawnLaneLift(), context);
	}

	private float ResolveSpawnLaneLift()
	{
		float num = Mathf.Max(0.05f, (GetSuspensionReach(frontWheelRadius) + GetSuspensionReach(backWheelRadius)) * 0.5f);
		float num2 = Mathf.Clamp01(spawnCompressionNormalized);
		return Mathf.Clamp(num * (1f - num2), 0.04f, 0.42f);
	}

	private Transform EnsureWheel(string wheelName, Vector2 localPos, float wheelRadius, Vector3 visualLocalPosition, Quaternion visualLocalRotation, Vector3 visualLocalScale, Sprite wheelOuterSprite, Sprite wheelInnerSprite)
	{
		Transform transform = base.transform.Find(wheelName);
		if (transform == null)
		{
			GameObject obj = new GameObject(wheelName);
			obj.transform.SetParent(base.transform, worldPositionStays: false);
			transform = obj.transform;
		}
		transform.localPosition = localPos;
		transform.localRotation = Quaternion.identity;
		Vector3 lossyScale = base.transform.lossyScale;
		float x = ((Mathf.Abs(lossyScale.x) > 0.0001f) ? (1f / Mathf.Abs(lossyScale.x)) : 1f);
		float y = ((Mathf.Abs(lossyScale.y) > 0.0001f) ? (1f / Mathf.Abs(lossyScale.y)) : 1f);
		transform.localScale = new Vector3(x, y, 1f);
		Transform transform2 = transform.Find("Visual");
		if (transform2 == null)
		{
			GameObject obj2 = new GameObject("Visual");
			obj2.transform.SetParent(transform, worldPositionStays: false);
			transform2 = obj2.transform;
		}
		transform2.localPosition = visualLocalPosition;
		transform2.localRotation = visualLocalRotation;
		int num = LayerMask.NameToLayer("Character");
		if (num < 0)
		{
			throw new InvalidOperationException("[SummerRace][Player] Layer 'Character' is required for wheel collider layer.");
		}
		transform2.gameObject.layer = num;
		transform2.localScale = SummerRaceCharacterBase.ResolveWheelVisualScaleForRadius(wheelOuterSprite, wheelRadius, visualLocalScale.z, "[SummerRace][Player] " + wheelName);
		SpriteRenderer component = transform.GetComponent<SpriteRenderer>();
		if (component != null)
		{
			UnityEngine.Object.Destroy(component);
		}
		CircleCollider2D component2 = transform.GetComponent<CircleCollider2D>();
		if (component2 != null)
		{
			UnityEngine.Object.Destroy(component2);
		}
		SummerRaceCharacterBase.BindWheelVisualSprites(transform2, wheelOuterSprite, wheelInnerSprite, 27, 28, ConvertBodyAuthoringPointToPlayerLocal(SummerRaceCharacterBase.WheelInnerTireVisualAuthoringOffset), "[SummerRace][Player] " + wheelName);
		SummerRaceCharacterBase.SyncWheelVisualSortingToBody(transform2, bodySkeletonAnimation, "[SummerRace][Player] " + wheelName + ".Sorting");
		LogWheelVisualRendererState(transform2, "[SummerRace][Player] " + wheelName);
		CircleCollider2D circleCollider2D = transform2.GetComponent<CircleCollider2D>();
		if (circleCollider2D == null)
		{
			circleCollider2D = transform2.gameObject.AddComponent<CircleCollider2D>();
		}
		float num2 = Mathf.Max(Mathf.Abs(transform2.lossyScale.x), Mathf.Abs(transform2.lossyScale.y));
		if (num2 <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Player] Invalid wheel world scale while fitting wheel collider.");
		}
		circleCollider2D.radius = Mathf.Max(0.01f, wheelRadius / num2);
		circleCollider2D.isTrigger = true;
		if (base.IsRuntimeDebugLogEnabled)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][Player][WheelColliderFit] wheel=" + wheelName + " wheelRadius=" + wheelRadius.ToString("F4") + " worldScale=" + num2.ToString("F4") + " colliderRadius=" + circleCollider2D.radius.ToString("F4") + " lossyScale=" + transform2.lossyScale.ToString("F4") + " localScale=" + transform2.localScale.ToString("F4") + " layer=" + LayerMask.LayerToName(transform2.gameObject.layer) + " isTrigger=" + circleCollider2D.isTrigger);
		}
		Rigidbody2D component3 = transform.GetComponent<Rigidbody2D>();
		if (component3 != null)
		{
			UnityEngine.Object.Destroy(component3);
		}
		WheelJoint2D component4 = transform.GetComponent<WheelJoint2D>();
		if (component4 != null)
		{
			UnityEngine.Object.Destroy(component4);
		}
		SummerRaceColliderOutline component5 = transform.GetComponent<SummerRaceColliderOutline>();
		if (component5 != null)
		{
			UnityEngine.Object.Destroy(component5);
		}
		LineRenderer component6 = transform.GetComponent<LineRenderer>();
		if (component6 != null)
		{
			UnityEngine.Object.Destroy(component6);
		}
		return transform;
	}

	private void EmitDebugState(float driveAcceleration)
	{
		if (base.IsRuntimeDebugLogEnabled && !(Time.time < nextDebugLogAt) && !(rb == null))
		{
			nextDebugLogAt = Time.time + 1f;
			float num = Mathf.Max(Mathf.Abs(lastFrontWheelContact.compressionVelocity), Mathf.Abs(lastBackWheelContact.compressionVelocity));
			float num2 = Mathf.Max(lastFrontWheelContact.supportSwitchCount1s, lastBackWheelContact.supportSwitchCount1s);
			float num3 = Mathf.Max(Mathf.Abs(lastFrontWheelContact.relativeNormalSpeed), Mathf.Abs(lastBackWheelContact.relativeNormalSpeed));
			SummerRaceRuntimeLog.Log("[SummerRace][Player] bodyType=" + BodyLabel + " build=" + cachedBuildSummary + " archetype=" + SummerRaceBuildScoring.GetArchetypeLabel(cachedBuildArchetype) + " sig=" + cachedBuildSignature + " body=" + rb.position.ToString("F3") + " vel=" + rb.velocity.ToString("F3") + " driveAccel=" + driveAcceleration.ToString("F2") + " hp=" + currentHP.ToString("F1") + "/" + MaxHP.ToString("F1") + " energy=" + currentEnergy.ToString("F1") + "/" + maxEnergy.ToString("F1") + " cost=" + currentCost + "/" + CostCap + " rot=" + rb.rotation.ToString("F2") + " contact=" + DebugWheelContactSummary + " event=" + FormatExplainabilityEventLabel() + " supportSource=F:" + lastFrontWheelContact.supportSource.ToString() + " B:" + lastBackWheelContact.supportSource.ToString() + " compressionVelPeak=" + num.ToString("F2") + " supportSwitchCount1s=" + num2.ToString("F1") + " relativeNormalSpeedPeak=" + num3.ToString("F2") + " wheelEmbedRatio=" + debugWheelEmbedRatio.ToString("F3") + " rearCompression=" + debugRearCompressionNormalized.ToString("F3") + "s targetEmbed<=" + wheelEmbedTargetRatio.ToString("F2") + " rearCap<=" + rearCompressionCapUnderFireDrive.ToString("F2"));
		}
	}

	protected override void RecordExplainabilityEvent(string category, string detail, bool logToConsole = true)
	{
		lastExplainabilityEvent = category + " | " + detail;
		lastExplainabilityEventAt = (Application.isPlaying ? Time.time : 0f);
		if (base.IsRuntimeDebugLogEnabled & logToConsole)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][Player][" + category + "] " + detail);
		}
	}

	private void OnDrawGizmos()
	{
		if (drawRuntimeGizmos)
		{
			DrawRuntimeContactGizmos();
			DrawWeaponAimGizmos(includeMeleeRange: false);
		}
	}

	private void OnDrawGizmosSelected()
	{
		if (drawRuntimeGizmos)
		{
			DrawRuntimeContactGizmos();
			DrawWeaponAimGizmos(includeMeleeRange: true);
		}
	}

	private void DrawWeaponAimGizmos(bool includeMeleeRange)
	{
		if (!debugWeaponGizmos)
		{
			return;
		}
		float facingSign = (Application.isPlaying ? ResolveFacingSign() : 1f);
		Vector2 chassisForwardVector = GetChassisForwardVector(facingSign);
		ResolveWeaponMountPose(facingSign, out var mountPos, out var mountForward);
		Vector2 vector = ((mountForward.sqrMagnitude > 0.0001f) ? mountForward : chassisForwardVector);
		Vector3 vector2 = mountPos;
		float num = (Application.isPlaying ? Mathf.Max(0f, DebugSpread) : 0.6f);
		float num2 = (adsActive ? 0.6f : 1f);
		float num3 = num * num2;
		float num4 = 2.2f;
		Gizmos.color = Color.cyan;
		Vector3 obj = ((Application.isPlaying && rb != null) ? ((Vector3)rb.worldCenterOfMass) : base.transform.position);
		Gizmos.DrawLine(obj, obj + (Vector3)(chassisForwardVector * (num4 * 0.85f)));
		Gizmos.color = Color.magenta;
		Gizmos.DrawLine(vector2, vector2 + (Vector3)(vector * (num4 * 0.85f)));
		Gizmos.color = Color.yellow;
		Gizmos.DrawLine(vector2, vector2 + (Vector3)(vector * num4));
		Gizmos.color = new Color(0.2f, 1f, 0.6f, 1f);
		Gizmos.DrawLine(vector2, vector2 + (Vector3)(Rotate(vector, num3) * num4));
		Gizmos.DrawLine(vector2, vector2 + (Vector3)(Rotate(vector, 0f - num3) * num4));
		if (includeMeleeRange && Application.isPlaying && IsValidWeaponSlot(lastFiredWeaponSlot))
		{
			WeaponRuntime weaponRuntime = weaponSlots[lastFiredWeaponSlot];
			if (weaponRuntime == null || weaponRuntime.Def == null)
			{
				throw new InvalidOperationException("[SummerRace][Player] Missing weapon def while drawing melee range gizmo. slot=" + lastFiredWeaponSlot);
			}
			if (weaponRuntime.Def.isMelee)
			{
				Gizmos.color = new Color(1f, 0.45f, 0.2f, 0.9f);
				Gizmos.DrawWireSphere(vector2 + (Vector3)(vector * Mathf.Max(0f, weaponRuntime.Def.meleeRange)), Mathf.Max(0f, weaponRuntime.Def.meleeRadius));
			}
		}
	}

	private void DrawRuntimeContactGizmos()
	{
		if (drawWheelContactDebug)
		{
			if (!Application.isPlaying)
			{
				DrawWheelAnchorGizmo(frontWheelLocal, frontWheelRadius, new Color(1f, 0.82f, 0.25f, 0.9f));
				DrawWheelAnchorGizmo(backWheelLocal, backWheelRadius, new Color(1f, 0.82f, 0.25f, 0.9f));
			}
			else
			{
				DrawWheelContactGizmo(lastFrontWheelContact, frontWheelLocal, frontWheelRadius, new Color(0.2f, 1f, 0.45f, 0.95f));
				DrawWheelContactGizmo(lastBackWheelContact, backWheelLocal, backWheelRadius, new Color(0.2f, 0.9f, 1f, 0.95f));
			}
		}
	}

	private void DrawWheelAnchorGizmo(Vector2 wheelLocal, float wheelRadius, Color color)
	{
		Vector3 center = base.transform.TransformPoint(new Vector3(wheelLocal.x, wheelLocal.y, 0f));
		Gizmos.color = color;
		Gizmos.DrawWireSphere(center, Mathf.Max(0.04f, wheelRadius * 0.3f));
	}

	private void DrawWheelContactGizmo(WheelContactData contact, Vector2 wheelLocal, float wheelRadius, Color color)
	{
		Vector3 vector = base.transform.TransformPoint(new Vector3(wheelLocal.x, wheelLocal.y, 0f));
		Gizmos.color = color;
		Gizmos.DrawWireSphere(vector, Mathf.Max(0.04f, wheelRadius * 0.3f));
		DrawWheelSuspensionLimitGizmo(wheelLocal, wheelRadius, in contact, new Color(0.9f, 0.7f, 0.2f, 0.8f), new Color(0.95f, 0.3f, 0.95f, 0.9f));
		if (contact.hasContact)
		{
			Vector3 vector2 = new Vector3(contact.point.x, contact.point.y, 0f);
			Vector3 to = vector2 + (Vector3)(contact.normal * 0.32f);
			Vector3 to2 = vector2 + (Vector3)(contact.tangent * 0.26f);
			Gizmos.DrawLine(vector, vector2);
			Gizmos.color = Color.green;
			Gizmos.DrawLine(vector2, to);
			Gizmos.color = Color.yellow;
			Gizmos.DrawLine(vector2, to2);
		}
	}

	private void SetSkillHint(string text, float showSeconds)
	{
		skillHint = text;
		hintUntil = Time.time + Mathf.Max(0.2f, showSeconds);
	}

	private bool IsValidWeaponSlot(int slotIndex)
	{
		if (slotIndex >= 0)
		{
			return slotIndex < WeaponSlotCount;
		}
		return false;
	}

	private bool IsValidEquipSlot(int slotIndex)
	{
		if (slotIndex >= 0)
		{
			return slotIndex < equipSlots.Count;
		}
		return false;
	}
}
