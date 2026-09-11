using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

public class SummerRaceEnemy : SummerRaceCharacterBase, ISummerRaceBuildProfileProvider, ICombatStatusHost, IWeaponOwnerContext, ICombatSourceContext, IWeaponContinuousMeleeContextProvider, IEquipOwnerContext, ISummerRaceCombatPayloadOverrideProvider
{
	private sealed class BodyProfile
	{
		public string Label;

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

	private const int EnemyBodySortingOrder = 25;

	private const int EnemyWheelSortingOrder = 26;

	private const int EnemyAdminSortingOrder = 24;

	private const string SpecialDefeatLoseStartAnimationName = "lose_1";

	private const string SpecialDefeatLoseLoopAnimationName = "lose_2";

	private const string EnemyAdminRootName = "AdminRoot";

	private const string EnemyAdminSpineName = "AdminSpine";

	private const string EnemyBattleAdminSkeletonDataPath = "Assets/ABResources/SummerRaceActivity/Spine/Admin/Battle/SummerRace_admin_SkeletonData.asset";

	private const string EnemyBattleAdminFallbackSkinName = "9001";

	private const string EnemyBattleAdminIdleAnimationName = "idle";

	private const string EnemyBattleAdminInAnimationName = "out";

	private const string EnemyBattleAdminSpecialDefeatInAnimationName = "in";

	private static readonly Vector2 RuntimeBodyColliderLocalOffset = new Vector2(0f, -0.2f);

	private static readonly Vector2 EnemyBattleAdminUiCarContentPosition = new Vector2(-450f, -200f);

	private static readonly Vector2 EnemyBattleAdminUiCarContentSize = new Vector2(840f, 440f);

	private static readonly Vector2 EnemyBattleAdminLightUiPosition = new Vector2(-364f, -60f);

	private static readonly Vector2 EnemyBattleAdminMediumUiPosition = new Vector2(-430f, -44f);

	private static readonly Vector2 EnemyBattleAdminHeavyUiPosition = new Vector2(-528f, 20f);

	private const float EnemyBattleAdminLightBodyAnchorY = 0.35f;

	private const float EnemyBattleAdminMediumBodyAnchorY = 0.45f;

	private const float EnemyBattleAdminHeavyBodyAnchorY = 0.85f;

	[SerializeField]
	private Vector2 weaponMountLocalOffset = new Vector2(0.5f, 0.12f);

	[SerializeField]
	private LayerMask driveContactMask = -1;

	[Header("Pursuit Control")]
	[SerializeField]
	private float pursuitDeadZone = 0.25f;

	[SerializeField]
	private float throttleRiseRate = 4.2f;

	[SerializeField]
	private float throttleFallRate = 10f;

	[SerializeField]
	private float driveAuthorityRiseRate = 12f;

	[SerializeField]
	private float driveAuthorityFallRate = 6f;

	private PolygonCollider2D poly;

	private Transform bodyVisual;

	private SkeletonAnimation bodySkeletonAnimation;

	private Transform enemyAdminRoot;

	private SkeletonAnimation enemyAdminSkeletonAnimation;

	private Transform player;

	private Rigidbody2D playerRb;

	private float baseMoveSpeed = 2.8f;

	private int baseHp = 3;

	private float enemyDamageMultiplier = 1f;

	[SerializeField]
	private float maxEnergy = 10f;

	[SerializeField]
	private float energyRegenPerSecond = 1.8f;

	private float maxHp;

	[NonSerialized]
	private float currentHp;

	private float currentMoveSpeed;

	private WeaponKind[] weaponTypes = new WeaponKind[1] { WeaponKind.MachineGun };

	private EquipKind[] equipTypes = new EquipKind[1];

	private SummerRaceWeaponDefSO[] weaponDefs = Array.Empty<SummerRaceWeaponDefSO>();

	private SummerRaceEquipDefSO[] equipDefs = Array.Empty<SummerRaceEquipDefSO>();

	private BodyProfile bodyProfile;

	private CombatImpactPayload[] weaponMeleeImpactPayloads;

	private float nextOverloadCheckAt;

	private float[] weaponOverloadUntilBySlot = Array.Empty<float>();

	private float nextPlayerResolveAt = -1f;

	private float smoothedThrottle;

	private float smoothedDriveAcceleration;

	private float smoothedDriveSupportRatio;

	private float smoothedDriveAlignmentRatio;

	private int chaseDirection = -1;

	private float slowMultiplier = 1f;

	private float slowUntil;

	private float stunUntil;

	private bool hookLatchMovementFrozen;

	private float disarmUntil;

	private bool normalDefeatPending;

	private int burnDps;

	private float burnUntil;

	private float nextBurnTickAt;

	private SummerRacePlayerController burnSource;

	private CombatImpactPayload burnTickImpactPayload;

	private SummerRaceBuildProfile cachedBuildProfile;

	private SummerRaceBuildRating cachedBuildRating;

	private SummerRaceBuildArchetype cachedBuildArchetype;

	private string cachedBuildSignature = "-";

	private string catalogDisplayName = string.Empty;

	private string catalogEnemyId = string.Empty;

	private string catalogBodyIcon = string.Empty;

	private string catalogLogoSkinName = string.Empty;

	private string overclockBubbleText = string.Empty;

	private int spawnWaveIndex = 1;

	private bool hasExplicitBuildConfig;

	private float nextDisarmTraceLogAt;

	public string BuildSummary => ResolveBuildSummary();

	public string BuildRatingSummary => cachedBuildRating.ToShortLabel();

	public SummerRaceBuildArchetype BuildArchetype => cachedBuildArchetype;

	public string BuildSignature => cachedBuildSignature;

	public string DebugExplainabilityEvent => FormatExplainabilityEventLabel();

	public string DebugWheelContactSummary => "F:" + SummerRaceCharacterBase.DescribeWheelContact(lastFrontWheelContact) + " B:" + SummerRaceCharacterBase.DescribeWheelContact(lastBackWheelContact);

	public float CurrentHP => currentHp;

	public float MaxHP => maxHp;

	public string CatalogEnemyId => catalogEnemyId;

	public string OverclockBubbleText => overclockBubbleText;

	public int SpawnWaveIndex => spawnWaveIndex;

	public string DisplayName
	{
		get
		{
			if (!string.IsNullOrWhiteSpace(catalogDisplayName))
			{
				return catalogDisplayName;
			}
			if (!Application.isPlaying)
			{
				if (bodyProfile == null)
				{
					return base.name;
				}
				return bodyProfile.Label;
			}
			return RequireBodyProfileReady("Enemy.DisplayName").Label;
		}
	}

	public float CurrentMass => RequirePhysicsBodyReady("Enemy.CurrentMass").mass;

	public Transform CombatSourceTransform => base.transform;

	public Rigidbody2D CombatSourceRigidbody
	{
		get
		{
			if (!Application.isPlaying)
			{
				return rb;
			}
			return RequirePhysicsBodyReady("Enemy.CombatSourceRigidbody");
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
			return RequirePhysicsBodyReady("Enemy.CombatRigidbody");
		}
	}

	public SummerRaceBodyType CombatBodyType => bodyType;

	public SummerRaceCombatTeam CombatTeam => SummerRaceCombatTeam.Enemy;

	public bool OverclockDamageTextActive => false;

	public bool IsCombatAlive
	{
		get
		{
			if (currentHp > 0f && base.gameObject != null)
			{
				return base.gameObject.activeInHierarchy;
			}
			return false;
		}
	}

	public bool IsNormalDefeatPending
	{
		get
		{
			if (normalDefeatPending && base.gameObject != null)
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

	private BodyProfile RequireBodyProfileReady(string context)
	{
		if (bodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Body profile is missing (" + context + ").");
		}
		return bodyProfile;
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
			float num2 = currentHp;
			TakeDamage(num);
			int num3 = Mathf.Max(0, Mathf.RoundToInt(num2 - currentHp));
			if (num3 <= 0)
			{
				return false;
			}
			damageDealt = num3;
			sourceContext?.NotifyCombatDamageDealt(num3);
			SummerRaceLuaBridge.PushDamageTextEvent(num3, CombatTeam, (CombatTransform != null) ? CombatTransform.position : Vector3.zero, effect.trigger.ToString(), sourceContext);
			return true;
		}
		case CombatEffectKind.Stun:
			ApplyStun(effect.duration);
			return effect.duration > 0f;
		case CombatEffectKind.Slow:
			ApplySlow(effect.magnitude, effect.duration);
			return effect.duration > 0f;
		case CombatEffectKind.Burn:
			ApplyBurn(Mathf.Max(0, Mathf.RoundToInt(effect.magnitude)), effect.duration, ResolveCombatPlayerSource(sourceContext));
			if (effect.duration > 0f)
			{
				return effect.magnitude > 0f;
			}
			return false;
		case CombatEffectKind.Disarm:
		{
			bool flag = base.IsRuntimeDebugLogEnabled && Time.time >= nextDisarmTraceLogAt;
			if (base.IsRuntimeDebugLogEnabled && Time.time >= nextDisarmTraceLogAt)
			{
				float num4 = Mathf.Max(0f, disarmUntil - Time.time);
				SummerRaceRuntimeLog.Log("[SummerRace][Enemy][DisarmTrace] apply enemy=" + base.name + " from=" + ((sourceContext != null && sourceContext.CombatSourceTransform != null) ? sourceContext.CombatSourceTransform.name : "<null>") + " duration=" + Mathf.Max(0f, effect.duration).ToString("F3") + " remainBefore=" + num4.ToString("F3") + " t=" + Time.time.ToString("F3"));
				nextDisarmTraceLogAt = Time.time + 0.1f;
			}
			ApplyDisarm(effect.duration);
			if (flag)
			{
				float num5 = Mathf.Max(0f, disarmUntil - Time.time);
				SummerRaceRuntimeLog.Log("[SummerRace][Enemy][DisarmTrace] applied enemy=" + base.name + " remainAfter=" + num5.ToString("F3") + " disarmUntil=" + disarmUntil.ToString("F3") + " t=" + Time.time.ToString("F3"));
			}
			return effect.duration > 0f;
		}
		case CombatEffectKind.Knockback:
			return TryApplyKnockbackEffect(hitDirection, effect.magnitude, sourceContext);
		case CombatEffectKind.PullTarget:
			return TryApplyPullTargetEffect(sourceContext, effect.magnitude);
		case CombatEffectKind.Shield:
			shieldUntil = Mathf.Max(shieldUntil, Time.time + Mathf.Max(0f, effect.duration));
			return effect.duration > 0f;
		case CombatEffectKind.SelfDash:
			ApplySelfDashEffect(effect.magnitude, effect.duration);
			if (!(effect.duration > 0f))
			{
				return effect.magnitude > 0f;
			}
			return true;
		default:
			return false;
		}
	}

	private static SummerRacePlayerController ResolveCombatPlayerSource(ICombatSourceContext sourceContext)
	{
		if (sourceContext == null || sourceContext.CombatSourceTransform == null)
		{
			return null;
		}
		return sourceContext.CombatSourceTransform.GetComponent<SummerRacePlayerController>();
	}

	public SummerRaceBuildRating GetBuildRating()
	{
		return cachedBuildRating;
	}

	public void NotifyCombatDamageDealt(int amount)
	{
	}

	public bool CanSpendWeaponEnergy(float amount)
	{
		if (currentHp > 0f && Time.time >= disarmUntil)
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

	public void SetEnergyRegenPerSecond(float regenPerSecond)
	{
		if (float.IsNaN(regenPerSecond) || float.IsInfinity(regenPerSecond) || regenPerSecond < 0f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] energyRegenPerSecond must be finite and >= 0, got " + regenPerSecond);
		}
		energyRegenPerSecond = regenPerSecond;
	}

	public void SetMaxEnergy(float value)
	{
		if (float.IsNaN(value) || float.IsInfinity(value) || value <= 0f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] maxEnergy must be finite and > 0, got " + value);
		}
		maxEnergy = value;
		currentEnergy = Mathf.Clamp(currentEnergy, 0f, maxEnergy);
	}

	public float ResolveWeaponOverloadUntil(int slotIndex)
	{
		if (slotIndex < 0 || slotIndex >= weaponOverloadUntilBySlot.Length)
		{
			return 0f;
		}
		return weaponOverloadUntilBySlot[slotIndex];
	}

	public void OnWeaponRuntimeFire(int slotIndex, SummerRaceWeaponSpec spec)
	{
		if (slotIndex < 0)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Invalid weapon slot fired. slot=" + slotIndex);
		}
	}

	public bool TryResolveContinuousMeleeContext(int slotIndex, SummerRaceWeaponSpec spec, out Vector2 attackOrigin, out Vector2 attackDirection)
	{
		attackOrigin = Vector2.zero;
		attackDirection = Vector2.zero;
		if (slotIndex < 0 || slotIndex >= weaponDefs.Length)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Invalid continuous melee slot. slot=" + slotIndex);
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.TryResolveContinuousMeleeContext");
		attackDirection = ResolveCurrentAimDirection();
		if (attackDirection.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Continuous melee direction is invalid. slot=" + slotIndex);
		}
		attackOrigin = rigidbody2D.position + Vector2.up * 0.05f;
		return true;
	}

	public float ResolveContinuousMeleeTickInterval(int slotIndex, SummerRaceWeaponSpec spec)
	{
		if (slotIndex < 0 || slotIndex >= weaponDefs.Length)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Invalid continuous melee cadence slot. slot=" + slotIndex);
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
		if (currentHp > 0f && !hookLatchMovementFrozen)
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
			smoothedThrottle = 0f;
			if (modularBackendReady)
			{
				ApplyModularDrive(0f, 0f);
			}
		}
		SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][FreezeState] host=Enemy name=" + base.name + " frozen=" + frozen + " reason=" + (reason ?? string.Empty));
	}

	public CombatImpactPayload CreateWeaponImpactPayload(WeaponModuleDefinition def, CombatTriggerType trigger)
	{
		return ScaleDamageImpactPayloadForPlayer(SummerRaceCombatEffectFactory.CreateWeaponImpactPayload(def, trigger));
	}

	public CombatEffectSpec[] CreateEquipEffects(UtilityModuleDefinition def)
	{
		return CloneAndScaleDamageEffectsForPlayer(SummerRaceCombatEffectFactory.CreateEquipEffects(def));
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

	public void ConfigureCatalogBuild(SummerRaceActivityEnemyContract contract)
	{
		if (contract == null)
		{
			throw new InvalidOperationException("ConfigureCatalogBuild received null contract.");
		}
		if (contract.Weapons == null || contract.Weapons.Length == 0)
		{
			throw new InvalidOperationException("ConfigureCatalogBuild requires explicit weapon definitions.");
		}
		if (contract.Equips == null)
		{
			throw new InvalidOperationException("ConfigureCatalogBuild requires explicit equip definitions.");
		}
		bodyType = contract.BodyType;
		catalogEnemyId = (string.IsNullOrWhiteSpace(contract.Id) ? string.Empty : contract.Id.Trim());
		catalogDisplayName = (string.IsNullOrWhiteSpace(contract.DisplayName) ? string.Empty : contract.DisplayName.Trim());
		catalogLogoSkinName = (string.IsNullOrWhiteSpace(contract.LogoSkinName) ? string.Empty : contract.LogoSkinName.Trim());
		catalogBodyIcon = (string.IsNullOrWhiteSpace(contract.BodyIcon) ? string.Empty : contract.BodyIcon.Trim());
		overclockBubbleText = (string.IsNullOrWhiteSpace(contract.OverclockBubbleText) ? string.Empty : contract.OverclockBubbleText.Trim());
		baseHp = Mathf.Max(1, contract.BaseHp);
		baseMoveSpeed = Mathf.Max(0.5f, contract.MoveSpeed);
		enemyDamageMultiplier = Mathf.Max(0f, contract.DamageMultiplier);
		List<WeaponKind> list = new List<WeaponKind>(contract.Weapons.Length);
		for (int i = 0; i < contract.Weapons.Length; i++)
		{
			list.Add(contract.Weapons[i]);
		}
		List<EquipKind> list2 = new List<EquipKind>(contract.Equips.Length);
		for (int j = 0; j < contract.Equips.Length; j++)
		{
			list2.Add(contract.Equips[j]);
		}
		weaponTypes = list.ToArray();
		equipTypes = list2.ToArray();
		bodyProfile = GetBodyProfile(bodyType);
		weaponDefs = new SummerRaceWeaponDefSO[weaponTypes.Length];
		weaponMeleeImpactPayloads = new CombatImpactPayload[weaponTypes.Length];
		weaponOverloadUntilBySlot = new float[weaponTypes.Length];
		for (int k = 0; k < weaponTypes.Length; k++)
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = ResolveRuntimeWeaponDef(weaponTypes[k]);
			if (summerRaceWeaponDefSO == null)
			{
				throw new InvalidOperationException("[SummerRace][Enemy] Missing weapon def for " + weaponTypes[k]);
			}
			weaponDefs[k] = summerRaceWeaponDefSO;
			weaponMeleeImpactPayloads[k] = CreateScaledWeaponImpactPayloadForPlayer(summerRaceWeaponDefSO, weaponTypes[k], CombatTriggerType.MeleeHit);
		}
		equipDefs = new SummerRaceEquipDefSO[equipTypes.Length];
		for (int l = 0; l < equipTypes.Length; l++)
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = SummerRaceConfigLoader.LoadEquipDef(equipTypes[l]);
			if (summerRaceEquipDefSO == null)
			{
				throw new InvalidOperationException("[SummerRace][Enemy] Missing equip def for " + equipTypes[l]);
			}
			equipDefs[l] = summerRaceEquipDefSO;
		}
		bool flag = hasExplicitBuildConfig;
		hasExplicitBuildConfig = true;
		try
		{
			ApplyBodyProfile();
			ApplyScaledStats(1);
		}
		catch
		{
			hasExplicitBuildConfig = flag;
			throw;
		}
		if (base.IsRuntimeDebugLogEnabled)
		{
			string text = string.Join(", ", Array.ConvertAll(weaponDefs, ResolveWeaponDefinitionLabel));
			string text2 = string.Join(", ", Array.ConvertAll(equipDefs, ResolveEquipDefinitionLabel));
			SummerRaceRuntimeLog.Log("[SummerRace][EnemyBuild] name=" + base.name + " catalogId=" + contract.Id + " body=" + bodyProfile.Label + " weapons=[" + text + "] equips=[" + text2 + "] archetype=" + SummerRaceBuildScoring.GetArchetypeLabel(cachedBuildArchetype) + " rating=" + cachedBuildRating.ToShortLabel() + " sig=" + cachedBuildSignature);
		}
		RecordExplainabilityEvent("CatalogBuild", "id=" + contract.Id + " archetype=" + SummerRaceBuildScoring.GetArchetypeLabel(cachedBuildArchetype) + " sig=" + cachedBuildSignature, logToConsole: false);
	}

	private string[] BuildEnemyBodySkinStack()
	{
		if (string.IsNullOrWhiteSpace(catalogLogoSkinName))
		{
			return SummerRaceCharacterBase.BattleBodyEnemySkinStack;
		}
		string[] array = new string[SummerRaceCharacterBase.BattleBodyEnemySkinStack.Length + 1];
		Array.Copy(SummerRaceCharacterBase.BattleBodyEnemySkinStack, array, SummerRaceCharacterBase.BattleBodyEnemySkinStack.Length);
		array[array.Length - 1] = catalogLogoSkinName.Trim();
		return array;
	}

	public void SetLaneY(float value)
	{
		laneY = value;
		if (!Application.isPlaying || !(SummerRaceFightManager.Instance != null) || !SummerRaceFightManager.Instance.IsBattleActive)
		{
			SnapToLaneImmediate();
		}
	}

	public void SetCombatTarget(SummerRacePlayerController target)
	{
		if (target == null)
		{
			player = null;
			playerRb = null;
			return;
		}
		player = target.transform;
		playerRb = target.GetComponent<Rigidbody2D>();
		if (modularBackendReady)
		{
			SetModularAimTarget(player);
		}
	}

	public float ResolveSpawnPlacementY(float laneBaseY)
	{
		laneY = laneBaseY;
		return laneY + ResolveSpawnLaneLift();
	}

	public void ApplyWaveEntrySpawnPose(float spawnX, float spawnY)
	{
		ApplySpawnPoseImmediate(spawnX, spawnY);
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

	private new void Awake()
	{
		base.Awake();
		rb = GetComponent<Rigidbody2D>();
		poly = GetComponent<PolygonCollider2D>();
		EnsureBodyVisualRefs();
		lockToXAxisMotion = false;
		driveContactFilter = new ContactFilter2D
		{
			useLayerMask = true,
			layerMask = driveContactMask,
			useTriggers = false
		};
		rb.gravityScale = 2.2f;
		rb.drag = 0.25f;
		rb.constraints = RigidbodyConstraints2D.None;
		rb.interpolation = RigidbodyInterpolation2D.Interpolate;
		rb.collisionDetectionMode = CollisionDetectionMode2D.Continuous;
		smoothedThrottle = 0f;
		smoothedDriveAcceleration = 0f;
		smoothedDriveSupportRatio = 0f;
		smoothedDriveAlignmentRatio = 0f;
	}

	private void OnEnable()
	{
		SummerRaceEnemyRegistry.Register(this);
	}

	private void OnDisable()
	{
		SummerRaceEnemyRegistry.Unregister(this);
	}

	private void Start()
	{
		TryResolvePlayerReference(force: true);
	}

	public void EnsureModularBackendInitialized()
	{
		if (!hasExplicitBuildConfig)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Explicit catalog build configuration is required before modular bootstrap.");
		}
		EnsureWeaponDefinitionCacheReady("Enemy.EnsureModularBackendInitialized", throwOnFailure: true);
		EnsureEquipDefinitionCacheReady("Enemy.EnsureModularBackendInitialized", throwOnFailure: true);
		Vector2 manualAimDirection = ResolveCurrentAimDirection();
		RebuildModularBackend(bodyType, new List<SummerRaceWeaponDefSO>(weaponDefs), new List<SummerRaceEquipDefSO>(equipDefs), player, manualAimDirection);
		if (player != null)
		{
			SetModularAimTarget(player);
		}
		ResetWeaponFireSpawnLock();
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

	private new void Update()
	{
		if (hasExplicitBuildConfig && !normalDefeatPending)
		{
			if (!CanTickRuntimeWeaponState())
			{
				TickBurnDamage();
				return;
			}
			TickEnergyAndOverload();
			TickBurnDamage();
		}
	}

	private new void LateUpdate()
	{
	}

	private new void FixedUpdate()
	{
		if (!hasExplicitBuildConfig)
		{
			return;
		}
		RequireModularBackendReady("Enemy.FixedUpdate");
		if (normalDefeatPending)
		{
			ApplyModularDrive(0f, 0f);
			SyncLegacyWheelContactsFromModular();
			TickWeaponFireSpawnLock(Time.fixedDeltaTime);
			ApplyOutOfBoundsGuard("Enemy.FixedUpdate.NormalDefeatPending");
			return;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.FixedUpdate");
		TryResolvePlayerReference(force: false);
		Vector2 vector = SummerRaceCharacterBase.ResolveSmoothedDriveAuthorityPair(smoothedDriveSupportRatio, smoothedDriveAlignmentRatio, ComputeRawDriveSupportRatio(), ComputeRawDriveAlignmentRatio(), driveAuthorityRiseRate, driveAuthorityFallRate, Time.fixedDeltaTime);
		smoothedDriveSupportRatio = vector.x;
		smoothedDriveAlignmentRatio = vector.y;
		bool flag = SummerRaceFightManager.Instance != null && SummerRaceFightManager.Instance.IsBattleActive;
		float num = ResolveMoveEffectSpeedMultiplier();
		bool flag2 = hookLatchMovementFrozen || Time.time < stunUntil;
		float num2 = ResolveThrusterSpeedMultiplier();
		float num3 = ((flag2 || !flag) ? 0f : (currentMoveSpeed * num * num2));
		float num4 = ((flag2 || !flag) ? 0f : Mathf.Max(0.25f, bodyProfile.ForwardAcceleration * num * num2));
		if (player == null || !flag)
		{
			ApplyModularDrive(0f, 0f);
			SyncLegacyWheelContactsFromModular();
			TickWeaponFireSpawnLock(Time.fixedDeltaTime);
			ApplyOutOfBoundsGuard("Enemy.FixedUpdate.NoPlayerOrInactiveBattle");
			return;
		}
		Vector2 toPlayer = (Vector2)player.position - rigidbody2D.position;
		float num5 = ResolveTargetSurfaceGapX(player);
		float num6 = Mathf.Abs(num5);
		SetModularAimDirection(ResolveCurrentAimDirection());
		float num7 = ComputeDriveSupportRatio();
		float rawSupportRatio = ComputeRawDriveSupportRatio();
		float num8 = ComputeDriveAlignmentRatio();
		float num9 = (flag2 ? 0f : ResolvePursuitDirectionSign(num5));
		float num10 = ResolveSpawnDriveCommandScale(num6, num7, Time.fixedDeltaTime);
		float desiredSpeedX = num9 * num3;
		float num11 = SummerRaceCharacterBase.ResolveHardSupportAuthorityGate(rawSupportRatio);
		float t = Mathf.Clamp01(num7 * num8) * num11;
		float num12 = Mathf.Lerp(0.28f, 1f, t);
		float num13 = num4 * num10 * num12;
		float accelerationCommand = num9 * num13;
		accelerationCommand = ResolveBoundaryAdjustedAcceleration(desiredSpeedX, accelerationCommand, num13, rigidbody2D.velocity.x);
		accelerationCommand = ResolveThrusterImpulseProtectedAcceleration(accelerationCommand, num13, out var reverseSuppressedByThruster);
		if (reverseSuppressedByThruster)
		{
			smoothedDriveAcceleration = 0f;
			smoothedThrottle = 0f;
		}
		ApplyDrivePhysics(accelerationCommand, num4);
		ApplyThrusterSustainedForce(Time.fixedDeltaTime);
		ApplyOutOfBoundsGuard("Enemy.FixedUpdate");
		TickWeaponFireSpawnLock(Time.fixedDeltaTime);
		float num14 = ((Mathf.Abs(rigidbody2D.velocity.x) > 0.08f) ? Mathf.Sign(rigidbody2D.velocity.x) : ((float)chaseDirection));
		UpdateWheelVisual(num14 * num * num2, Time.fixedDeltaTime);
		TryUseWeapons(num6, toPlayer);
		TryUseEquips(num6, toPlayer);
		EmitDebugState(accelerationCommand, num6);
	}

	private float ResolvePursuitDirectionSign(float signedGapX)
	{
		float holdDistance = Mathf.Max(0.05f, pursuitDeadZone);
		float commitDistance = ResolveDirectionCommitDistance(holdDistance);
		float num = SummerRaceCharacterBase.ResolveLatchedDirectionSign(chaseDirection, signedGapX, holdDistance, commitDistance, (chaseDirection >= 0) ? 1f : (-1f));
		chaseDirection = ((num > 0f) ? 1 : (-1));
		return num;
	}

	private void ApplyDrivePhysics(float targetAcceleration, float driveAcceleration)
	{
		RequireModularBackendReady("Enemy.ApplyDrivePhysics");
		RequirePhysicsBodyReady("Enemy.ApplyDrivePhysics");
		float num = Mathf.Max(0.25f, driveAcceleration);
		Vector2 vector = SummerRaceCharacterBase.ResolveDriveAccelerationStepRates(num);
		float x = vector.x;
		float y = vector.y;
		smoothedDriveAcceleration = SummerRaceCharacterBase.StepSignedCommand(smoothedDriveAcceleration, targetAcceleration, x, y, Time.fixedDeltaTime);
		float target = SummerRaceCharacterBase.ResolveNormalizedAccelerationCommand(smoothedDriveAcceleration, num);
		smoothedThrottle = SummerRaceCharacterBase.StepSignedCommand(smoothedThrottle, target, throttleRiseRate, throttleFallRate, Time.fixedDeltaTime);
		ApplyModularDrive(smoothedThrottle, 0f);
		SyncLegacyWheelContactsFromModular();
		bool fireDriveStress = Mathf.Abs(targetAcceleration) > 0.15f && recoilKick > 0.08f;
		UpdateWheelFeelTelemetry(lastFrontWheelContact, lastBackWheelContact, fireDriveStress);
	}

	private float ComputeDriveSupportRatio()
	{
		return Mathf.Clamp01(smoothedDriveSupportRatio);
	}

	private float ComputeRawDriveSupportRatio()
	{
		Rigidbody2D body = RequirePhysicsBodyReady("Enemy.ComputeRawDriveSupportRatio");
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
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.ComputeRawDriveAlignmentRatio");
		Vector2 forward = rigidbody2D.transform.right;
		if (forward.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Chassis forward axis is invalid during drive alignment resolution.");
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

	private void TryResolvePlayerReference(bool force)
	{
		if (!force && Time.time < nextPlayerResolveAt)
		{
			return;
		}
		nextPlayerResolveAt = Time.time + 0.35f;
		if (player != null && player.gameObject.activeInHierarchy)
		{
			return;
		}
		SummerRacePlayerController summerRacePlayerController = ((SummerRaceFightManager.Instance != null) ? SummerRaceFightManager.Instance.CurrentPlayer : null);
		if (summerRacePlayerController == null || !summerRacePlayerController.gameObject.activeInHierarchy)
		{
			return;
		}
		SetCombatTarget(summerRacePlayerController);
		if (!force)
		{
			RequireModularBackendReady("Enemy.TryResolvePlayerReference");
			if (player != null)
			{
				SetModularAimTarget(player);
			}
		}
	}

	private void UpdateWheelFeelTelemetry(WheelContactData frontContact, WheelContactData backContact, bool fireDriveStress)
	{
		Rigidbody2D body = RequirePhysicsBodyReady("Enemy.UpdateWheelFeelTelemetry");
		debugWheelEmbedRatio = ComputeWheelEmbedRatio(frontContact, backContact);
		debugRearCompressionNormalized = (SummerRaceCharacterBase.IsSupportContact(in backContact, 0.08f, body) ? Mathf.Clamp01(backContact.compression) : 0f);
	}

	protected override void ApplyCompressionHardLimits(ref WheelContactData frontContact, ref WheelContactData backContact, bool fireDriveStress)
	{
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
		if (!SummerRaceCharacterBase.IsSupportContact(in contact, 0.08f, RequirePhysicsBodyReady("Enemy.ComputeSingleWheelEmbedRatio")))
		{
			return 0f;
		}
		return Mathf.Clamp01((contact.compression - 0.7f) / 0.3f);
	}

	protected override WheelContactData SampleWheelContact(Vector2 wheelLocal, float wheelRadius)
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.ResolveWheelContact");
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
		Vector2 rhs = rigidbody2D.transform.up;
		if (rhs.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Chassis up axis is invalid in wheel contact solve.");
		}
		rhs.Normalize();
		result.hasContact = true;
		result.point = point;
		result.normal = vector2.normalized;
		result.tangent = new Vector2(result.normal.y, 0f - result.normal.x).normalized;
		result.surfaceBodyType = rigidbodyType2D;
		float num4 = Mathf.Max(0f, num3 - wheelRadius);
		float num5 = Mathf.Clamp01((suspensionReach - num4) / suspensionReach);
		float num6 = Mathf.Clamp01((Vector2.Dot(result.normal, rhs) - 0.05f) / 0.35f);
		result.compression = num5 * num6;
		result.supportSource = ((rigidbodyType2D != RigidbodyType2D.Dynamic) ? VehiclePhysicsController.WheelSupportSource.Primary : VehiclePhysicsController.WheelSupportSource.Secondary);
		result.tangentVelocity = Vector2.Dot(rigidbody2D.GetPointVelocity(vector), result.tangent);
		return result;
	}

	protected override void ApplyWheelMotorForce(WheelContactData contact, Vector2 wheelLocal, float wheelRadius, float driveSign, float throttle)
	{
		if (!contact.hasContact)
		{
			return;
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.ApplyWheelMotorForce");
		Vector2 vector = base.transform.TransformPoint(wheelLocal);
		Vector2 vector2 = contact.tangent;
		Vector2 normalized = ((Vector2)rigidbody2D.transform.right).normalized;
		if (normalized.sqrMagnitude <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Chassis forward axis is invalid in motor solve.");
		}
		if (Vector2.Dot(vector2, normalized * driveSign) < 0f)
		{
			vector2 = -vector2;
		}
		float num = Vector2.Dot(rigidbody2D.GetPointVelocity(vector), contact.normal);
		float num2 = Mathf.Clamp(rigidbody2D.mass / 24f, 0.9f, 2.8f);
		GetSuspensionBodyMultipliers(out var springMul, out var dampingMul);
		float value = wheelSpring * num2 * springMul * contact.compression - num * wheelDamping * Mathf.Sqrt(num2) * dampingMul;
		float num3 = Mathf.Max(4f, maxSuspensionForcePerMass) * rigidbody2D.mass;
		value = Mathf.Clamp(value, (0f - num3) * 0.28f, num3);
		rigidbody2D.AddForceAtPosition(contact.normal * value, vector, ForceMode2D.Force);
		float num4 = (0f - contact.tangentVelocity) * wheelRollingResistance * rigidbody2D.mass * 0.06f;
		rigidbody2D.AddForceAtPosition(vector2 * num4, vector, ForceMode2D.Force);
		if (!(throttle <= 0.0001f))
		{
			float num5 = 1f / Mathf.Max(0.08f, wheelRadius);
			float num6 = currentMoveSpeed * 1.9f * Mathf.Clamp(wheelRadius / 0.24f, 0.75f, 1.35f);
			float f = Mathf.Abs(num6) - Mathf.Abs(contact.tangentVelocity);
			float t = Mathf.Clamp01(Mathf.Abs(contact.tangentVelocity) / Mathf.Max(0.2f, num6 * 0.4f));
			float t2 = Mathf.Clamp01(Mathf.Abs(f) / Mathf.Max(0.1f, num6) * Mathf.Lerp(0.65f, 1f, t));
			float num7 = Mathf.Clamp01(contact.compression);
			float num8 = num7 * num7 * (3f - 2f * num7);
			float num9 = Mathf.Lerp(0.22f, 1f, Mathf.Clamp01(num8 * 1.2f));
			if (contact.surfaceBodyType == RigidbodyType2D.Dynamic)
			{
				num9 *= Mathf.Clamp01(dynamicSurfaceTractionMultiplier);
			}
			float value2 = rigidbody2D.mass * 1.45f * throttle * num5 * num9 * Mathf.Lerp(0.5f, 1f, t2);
			float num10 = Mathf.Max(0.5f, maxWheelMotorForcePerMass) * rigidbody2D.mass;
			value2 = Mathf.Clamp(value2, 0f - num10, num10);
			rigidbody2D.AddForceAtPosition(vector2 * value2, vector, ForceMode2D.Force);
		}
	}

	private void TryUseWeapons(float absDx, Vector2 toPlayer)
	{
		if (hookLatchMovementFrozen || Time.time < stunUntil || Time.time < disarmUntil || player == null)
		{
			if (base.IsRuntimeDebugLogEnabled && player != null && Time.time < disarmUntil && Time.time >= nextDisarmTraceLogAt)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][Enemy][DisarmTrace] fire_blocked enemy=" + base.name + " remain=" + Mathf.Max(0f, disarmUntil - Time.time).ToString("F3") + " t=" + Time.time.ToString("F3"));
				nextDisarmTraceLogAt = Time.time + 0.2f;
			}
		}
		else
		{
			if (!EnsureWeaponDefinitionCacheReady("Enemy.TryUseWeapon", throwOnFailure: false) || weaponDefs.Length == 0)
			{
				return;
			}
			RequireModularBackendReady("Enemy.TryUseWeapon");
			SetModularAimDirection(ResolveCurrentAimDirection());
			for (int i = 0; i < weaponDefs.Length; i++)
			{
				if (modularWeaponSystem.IsSlotReady(i) && TryFireModularWeaponSlot(i))
				{
					SummerRaceWeaponDefSO weaponDefinition = GetWeaponDefinition(i);
					RecordExplainabilityEvent("Fire", "slot=" + i + " weapon=" + ResolveWeaponDefinitionLabel(weaponDefinition), logToConsole: false);
				}
			}
		}
	}

	private void TryUseEquips(float absDx, Vector2 toPlayer)
	{
		if (hookLatchMovementFrozen || Time.time < stunUntil || player == null || !EnsureEquipDefinitionCacheReady("Enemy.TryUseEquip", throwOnFailure: false) || equipDefs.Length == 0)
		{
			return;
		}
		RequireModularBackendReady("Enemy.TryUseEquip");
		for (int i = 0; i < equipDefs.Length; i++)
		{
			if (modularEquipSystem.IsSlotReady(i))
			{
				_ = TryUseModularEquipSlot(i, toPlayer).Success;
			}
		}
	}

	private new void TickBurnDamage()
	{
		if (burnDps <= 0)
		{
			return;
		}
		if (Time.time >= burnUntil)
		{
			burnDps = 0;
			burnSource = null;
			burnTickImpactPayload = null;
			nextBurnTickAt = 0f;
		}
		else if (!(Time.time < nextBurnTickAt))
		{
			nextBurnTickAt = Time.time + 1f;
			if (burnTickImpactPayload != null && burnSource != null)
			{
				SummerRaceCombatEffectExecutor.Shared.ExecuteImpact(this, burnTickImpactPayload, Vector2.zero, burnSource);
			}
		}
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		if (collision != null)
		{
			NotifySpawnLandingContact(SummerRaceCharacterBase.ResolveBestSupportNormal(collision));
			RegisterBoundaryContact(collision);
			TryPublishVehicleCollisionAudio(collision);
		}
	}

	private void OnCollisionStay2D(Collision2D collision)
	{
		if (collision != null)
		{
			NotifySpawnLandingContact(SummerRaceCharacterBase.ResolveBestSupportNormal(collision));
			RegisterBoundaryContact(collision);
		}
	}

	private void OnTriggerStay2D(Collider2D other)
	{
		if (!(other == null))
		{
			_ = other.GetComponentInParent<VehicleSimpleProjectile>() != null;
		}
	}

	public void TakeDamage(int amount)
	{
		if (amount <= 0 || Time.time < shieldUntil)
		{
			return;
		}
		base.LastDamageReceivedTime = Time.time;
		currentHp -= amount;
		if (!(currentHp > 0f) && (!(SummerRaceFightManager.Instance != null) || !SummerRaceFightManager.Instance.HandleEnemyFatalHit(this)))
		{
			if (SummerRaceFightManager.Instance != null)
			{
				SummerRaceFightManager.Instance.RegisterEnemyDestroyed(this);
			}
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	public void SetRuntimeSpawnMeta(string enemyId, int waveIndex)
	{
		catalogEnemyId = (string.IsNullOrWhiteSpace(enemyId) ? catalogEnemyId : enemyId.Trim());
		spawnWaveIndex = Mathf.Max(1, waveIndex);
	}

	public void ResetForSpecialDefeat(float spawnX, float spawnY)
	{
		float y = (float.IsNaN(spawnY) ? ResolveSpawnYAlignedToArenaFloor(laneY + ResolveSpawnLaneLift(), "Enemy.ResetForSpecialDefeat") : spawnY);
		ApplySpawnPoseImmediate(spawnX, y);
		normalDefeatPending = false;
		if (modularWeaponSystem != null)
		{
			modularWeaponSystem.enabled = true;
		}
		if (modularEquipSystem != null)
		{
			modularEquipSystem.enabled = true;
		}
		hookLatchMovementFrozen = false;
		stunUntil = 0f;
		slowUntil = 0f;
		disarmUntil = 0f;
		burnUntil = 0f;
		burnDps = 0;
		nextBurnTickAt = 0f;
	}

	public void EnterNormalDefeatPendingState()
	{
		if (!normalDefeatPending)
		{
			normalDefeatPending = true;
			hookLatchMovementFrozen = true;
			stunUntil = float.MaxValue;
			disarmUntil = float.MaxValue;
			slowUntil = 0f;
			burnUntil = 0f;
			burnDps = 0;
			burnSource = null;
			burnTickImpactPayload = null;
			nextBurnTickAt = 0f;
			smoothedDriveAcceleration = 0f;
			smoothedThrottle = 0f;
			if (rb != null)
			{
				rb.velocity = Vector2.zero;
				rb.angularVelocity = 0f;
			}
			if (modularWeaponSystem != null)
			{
				modularWeaponSystem.ForceInterruptActiveFire("enemy_normal_defeat_pending");
				modularWeaponSystem.enabled = false;
			}
			if (modularEquipSystem != null)
			{
				modularEquipSystem.ForceResetHookStates("enemy_normal_defeat_pending");
				modularEquipSystem.enabled = false;
			}
			if (modularBackendReady)
			{
				ApplyModularDrive(0f, 0f);
				SyncLegacyWheelContactsFromModular();
			}
		}
	}

	public void HideForNormalDefeatExplosion()
	{
		EnterNormalDefeatPendingState();
		SetDefeatPresentationVisible(visible: false);
		SetDefeatCollidersEnabled(enabled: false);
	}

	public void PrepareForDefeatExplosion()
	{
		EnterNormalDefeatPendingState();
		SetDefeatPresentationVisible(visible: true);
		SetDefeatCollidersEnabled(enabled: false);
	}

	public void HideForSpecialDefeatExplosion()
	{
		SetDefeatPresentationVisible(visible: false);
		SetDefeatCollidersEnabled(enabled: false);
	}

	public void PrepareForFlagDefeatAnimation()
	{
		PrepareForDefeatExplosion();
	}

	private void SetDefeatPresentationVisible(bool visible)
	{
		Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] != null)
			{
				componentsInChildren[i].enabled = visible;
			}
		}
		VehicleSoftOvalShadowController component = GetComponent<VehicleSoftOvalShadowController>();
		if (component != null)
		{
			component.SetPresentationVisible(visible);
		}
	}

	private void SetDefeatCollidersEnabled(bool enabled)
	{
		Collider2D[] componentsInChildren = GetComponentsInChildren<Collider2D>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] != null)
			{
				componentsInChildren[i].enabled = enabled;
			}
		}
	}

	public float PlaySpecialDefeatLoseAnimation()
	{
		if (bodySkeletonAnimation == null || bodySkeletonAnimation.Skeleton == null || bodySkeletonAnimation.Skeleton.Data == null || bodySkeletonAnimation.AnimationState == null)
		{
			return 0f;
		}
		Spine.Animation animation = bodySkeletonAnimation.Skeleton.Data.FindAnimation("lose_1");
		Spine.Animation animation2 = bodySkeletonAnimation.Skeleton.Data.FindAnimation("lose_2");
		if (animation == null && animation2 == null)
		{
			if (base.IsRuntimeDebugLogEnabled)
			{
				SummerRaceRuntimeLog.Warning("[SummerRace][Enemy] Missing special defeat lose animations 'lose_1'/'lose_2' on " + base.name);
			}
			return 0f;
		}
		if (animation != null)
		{
			bodySkeletonAnimation.AnimationState.SetAnimation(0, animation.Name, loop: false);
			if (animation2 != null)
			{
				bodySkeletonAnimation.AnimationState.AddAnimation(0, animation2.Name, loop: true, 0f);
			}
			return Mathf.Max(0f, animation.Duration);
		}
		bodySkeletonAnimation.AnimationState.SetAnimation(0, animation2.Name, loop: true);
		return 0f;
	}

	private void ApplySlow(float multiplier, float duration)
	{
		slowMultiplier = Mathf.Clamp(multiplier, 0.2f, 1f);
		slowUntil = Mathf.Max(slowUntil, Time.time + Mathf.Max(0f, duration));
	}

	private float ResolveMoveEffectSpeedMultiplier()
	{
		if (Time.time >= slowUntil)
		{
			return 1f;
		}
		return Mathf.Clamp(slowMultiplier, 0.2f, 1f);
	}

	private void ApplyStun(float duration)
	{
		stunUntil = Mathf.Max(stunUntil, Time.time + Mathf.Max(0f, duration));
	}

	private void ApplyDisarm(float duration)
	{
		disarmUntil = Mathf.Max(disarmUntil, Time.time + Mathf.Max(0f, duration));
		if (modularWeaponSystem != null)
		{
			modularWeaponSystem.ForceInterruptActiveFire("enemy_disarm");
		}
	}

	private void ApplyBurn(int dps, float duration, SummerRacePlayerController source)
	{
		burnDps = Mathf.Max(burnDps, dps);
		burnUntil = Mathf.Max(burnUntil, Time.time + Mathf.Max(0f, duration));
		burnSource = source;
		burnTickImpactPayload = SummerRaceCombatEffectFactory.CreateDamageImpactPayload(burnDps, CombatTriggerType.StatusTick);
		nextBurnTickAt = Time.time + 0.1f;
	}

	public void ApplyKnockback(Vector2 impulse)
	{
		ApplyImpulse(impulse);
	}

	private void ApplyBodyProfile()
	{
		EnsureBodyVisualRefs();
		SummerRaceConfigLoader.BodyPrefabRuntimeData bodyPrefabRuntimeData = SummerRaceConfigLoader.LoadBodyPrefabRuntimeData(bodyType);
		rb.mass = bodyProfile.Mass;
		rb.drag = bodyProfile.Drag;
		rb.angularDrag = bodyProfile.AngularDrag;
		rb.gravityScale = bodyProfile.GravityScale;
		rb.bodyType = RigidbodyType2D.Dynamic;
		rb.interpolation = RigidbodyInterpolation2D.Interpolate;
		rb.collisionDetectionMode = CollisionDetectionMode2D.Continuous;
		rb.constraints = RigidbodyConstraints2D.None;
		if (bodyPrefabRuntimeData.ColliderPoints == null || bodyPrefabRuntimeData.ColliderPoints.Length < 3)
		{
			throw new InvalidOperationException("Body prefab colliderPoints missing for " + bodyType);
		}
		SummerRaceCharacterBase.BindBodySkeletonAnimation(bodyVisual, ref bodySkeletonAnimation, bodyPrefabRuntimeData.BodySkeletonData, 25, "[SummerRace][Enemy] BodyVisual", BuildEnemyBodySkinStack());
		bodyVisual.localPosition = bodyPrefabRuntimeData.BodyVisualLocalPosition;
		bodyVisual.localRotation = bodyPrefabRuntimeData.BodyVisualLocalRotation;
		bodyVisual.localScale = bodyPrefabRuntimeData.BodyVisualLocalScale;
		SummerRaceCharacterBase.FitBodySkeletonVisualToTargetSize(bodyVisual, bodySkeletonAnimation, bodyPrefabRuntimeData.BodyVisualTargetSize, "[SummerRace][Enemy] BodyVisualFit");
		bodyVisual.localScale = new Vector3(bodyVisual.localScale.x * bodyPrefabRuntimeData.BattleBodyVisualScale, bodyVisual.localScale.y * bodyPrefabRuntimeData.BattleBodyVisualScale, bodyVisual.localScale.z);
		EnsureEnemyBattleAdmin();
		poly.pathCount = 1;
		poly.SetPath(0, SummerRaceCharacterBase.OffsetColliderPath(SummerRaceCharacterBase.FitColliderPathToBodySkeletonBounds(bodyVisual, bodySkeletonAnimation, poly, bodyPrefabRuntimeData.ColliderPoints, "[SummerRace][Enemy] BodyColliderFit"), RuntimeBodyColliderLocalOffset, "[SummerRace][Enemy] BodyColliderOffset"));
		int num = LayerMask.NameToLayer("Character");
		if (num < 0)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Layer 'Character' is required for body layer.");
		}
		base.gameObject.layer = num;
		base.transform.localScale = bodyProfile.BodyScale;
		if (drawColliderOutlineInGame && SummerRaceFightManager.IsArenaColliderOutlineInGameEnabled())
		{
			Color color = ((bodyType == SummerRaceBodyType.Light) ? new Color(0.35f, 1f, 0.7f, 0.95f) : ((bodyType == SummerRaceBodyType.Heavy) ? new Color(1f, 0.45f, 0.25f, 0.95f) : new Color(0.45f, 0.78f, 1f, 0.95f)));
			SummerRaceColliderOutline.Ensure(base.gameObject, color, 0.024f, 175);
		}
		else
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
		frontWheelLocal = bodyProfile.FrontWheelPos;
		backWheelLocal = bodyProfile.BackWheelPos;
		float num2 = Mathf.Max(0.01f, bodyPrefabRuntimeData.FrontWheelVisualScale);
		float num3 = Mathf.Max(0.01f, bodyPrefabRuntimeData.BackWheelVisualScale);
		frontWheelRadius = bodyProfile.FrontWheelRadius * num2;
		backWheelRadius = bodyProfile.BackWheelRadius * num3;
		frontWheel = EnsureWheel("FrontWheel", frontWheelLocal, frontWheelRadius, bodyPrefabRuntimeData.FrontWheelVisualLocalPosition, bodyPrefabRuntimeData.FrontWheelVisualLocalRotation, bodyPrefabRuntimeData.FrontWheelVisualLocalScale, bodyPrefabRuntimeData.FrontWheelOuterSprite, bodyPrefabRuntimeData.FrontWheelInnerSprite);
		backWheel = EnsureWheel("BackWheel", backWheelLocal, backWheelRadius, bodyPrefabRuntimeData.BackWheelVisualLocalPosition, bodyPrefabRuntimeData.BackWheelVisualLocalRotation, bodyPrefabRuntimeData.BackWheelVisualLocalScale, bodyPrefabRuntimeData.BackWheelOuterSprite, bodyPrefabRuntimeData.BackWheelInnerSprite);
		EnsureSoftOvalShadow();
		ResetWheelVisualState();
		RecomputeRuntimeCenterOfMass();
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

	private void EnsureEnemyBattleAdmin()
	{
		if (bodyVisual == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] BodyVisual is required before mounting admin spine.");
		}
		if (enemyAdminRoot == null)
		{
			enemyAdminRoot = base.transform.Find("AdminRoot");
			if (enemyAdminRoot == null)
			{
				enemyAdminRoot = bodyVisual.Find("AdminRoot");
			}
			if (enemyAdminRoot == null)
			{
				GameObject gameObject = new GameObject("AdminRoot");
				gameObject.hideFlags = HideFlags.DontSave;
				gameObject.transform.SetParent(base.transform, worldPositionStays: false);
				enemyAdminRoot = gameObject.transform;
			}
		}
		if (enemyAdminRoot.parent != base.transform)
		{
			enemyAdminRoot.SetParent(base.transform, worldPositionStays: false);
		}
		enemyAdminRoot.localPosition = ResolveEnemyBattleAdminRootLocalPosition();
		enemyAdminRoot.localRotation = Quaternion.identity;
		enemyAdminRoot.localScale = Vector3.one;
		Transform transform = enemyAdminRoot.Find("AdminSpine");
		if (transform == null)
		{
			GameObject obj = new GameObject("AdminSpine");
			obj.hideFlags = HideFlags.DontSave;
			obj.transform.SetParent(enemyAdminRoot, worldPositionStays: false);
			transform = obj.transform;
		}
		transform.localPosition = Vector3.zero;
		transform.localRotation = Quaternion.identity;
		transform.localScale = Vector3.one;
		enemyAdminSkeletonAnimation = transform.GetComponent<SkeletonAnimation>();
		if (enemyAdminSkeletonAnimation == null)
		{
			enemyAdminSkeletonAnimation = transform.gameObject.AddComponent<SkeletonAnimation>();
		}
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow("Assets/ABResources/SummerRaceActivity/Spine/Admin/Battle/SummerRace_admin_SkeletonData.asset", "[SummerRace][Enemy] BattleAdmin");
		enemyAdminSkeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		enemyAdminSkeletonAnimation.Initialize(overwrite: true);
		if (enemyAdminSkeletonAnimation.Skeleton == null || enemyAdminSkeletonAnimation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Battle admin skeleton runtime data is missing.");
		}
		ApplyBattleAdminSkinOrThrow(enemyAdminSkeletonAnimation, ResolveEnemyBattleAdminSkinName(), "[SummerRace][Enemy] BattleAdmin");
		PlayEnemyBattleAdminAnimation("idle", loop: true, throwIfMissing: true);
		MeshRenderer component = enemyAdminSkeletonAnimation.GetComponent<MeshRenderer>();
		if (component == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Battle admin MeshRenderer is missing.");
		}
		MeshRenderer meshRenderer = ((bodySkeletonAnimation != null) ? bodySkeletonAnimation.GetComponent<MeshRenderer>() : null);
		if (meshRenderer != null)
		{
			component.sortingLayerID = meshRenderer.sortingLayerID;
		}
		component.sortingOrder = 24;
		component.enabled = true;
	}

	protected override void OnSpawnEntryAnimationReset()
	{
		PlayEnemyBattleAdminAnimation("idle", loop: true, throwIfMissing: false);
	}

	protected override void OnSpawnLandingContactAccepted()
	{
		PlayEnemyBattleAdminAnimation("out", loop: false, throwIfMissing: true);
	}

	public void PlaySpecialDefeatBattleAdminIntro()
	{
		PlayEnemyBattleAdminAnimationThenIdle("in", throwIfMissing: true);
	}

	private void PlayEnemyBattleAdminAnimation(string animationName, bool loop, bool throwIfMissing)
	{
		PlayBattleAdminAnimation(enemyAdminSkeletonAnimation, animationName, loop, throwIfMissing, "[SummerRace][Enemy] BattleAdmin");
	}

	private void PlayEnemyBattleAdminAnimationThenIdle(string animationName, bool throwIfMissing)
	{
		PlayBattleAdminAnimationThenIdle(enemyAdminSkeletonAnimation, animationName, "idle", throwIfMissing, "[SummerRace][Enemy] BattleAdmin");
	}

	private string ResolveEnemyBattleAdminSkinName()
	{
		return StripBattleAdminSkinSuffix(string.IsNullOrWhiteSpace(catalogBodyIcon) ? "9001" : catalogBodyIcon.Trim());
	}

	private static string StripBattleAdminSkinSuffix(string skinName)
	{
		string text = (string.IsNullOrWhiteSpace(skinName) ? "9001" : skinName.Trim());
		if (!text.EndsWith("_01", StringComparison.Ordinal))
		{
			return text;
		}
		return text.Substring(0, text.Length - 3);
	}

	private static void ApplyBattleAdminSkinOrThrow(SkeletonAnimation skeletonAnimation, string skinName, string context)
	{
		if (skeletonAnimation == null || skeletonAnimation.Skeleton == null || skeletonAnimation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace] Battle admin skeleton runtime data is missing. context=" + context);
		}
		string text = StripBattleAdminSkinSuffix(skinName);
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

	private Vector3 ResolveEnemyBattleAdminRootLocalPosition()
	{
		if (bodyVisual == null || bodySkeletonAnimation == null || bodySkeletonAnimation.Skeleton == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Body skeleton is required before resolving admin root position.");
		}
		GetBodySkeletonLocalBounds(bodySkeletonAnimation, "[SummerRace][Enemy] BattleAdminPosition", out var center, out var size);
		float num = ResolveEnemyBattleAdminBodyAnchorX();
		Vector3 position = new Vector3(center.x + size.x * num, center.y, 0f);
		Vector3 position2 = bodyVisual.TransformPoint(position);
		return new Vector3(base.transform.InverseTransformPoint(position2).x, ResolveEnemyBattleAdminRootLocalY(), 0f);
	}

	private float ResolveEnemyBattleAdminBodyAnchorX()
	{
		return (bodyType switch
		{
			SummerRaceBodyType.Light => EnemyBattleAdminLightUiPosition, 
			SummerRaceBodyType.Heavy => EnemyBattleAdminHeavyUiPosition, 
			_ => EnemyBattleAdminMediumUiPosition, 
		} - EnemyBattleAdminUiCarContentPosition).x / EnemyBattleAdminUiCarContentSize.x;
	}

	private float ResolveEnemyBattleAdminRootLocalY()
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
			throw new InvalidOperationException("[SummerRace][Enemy] Missing body skeleton for bounds query. context=" + context);
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
			throw new InvalidOperationException("[SummerRace][Enemy] Invalid body skeleton bounds. context=" + context + " size=(" + width + "," + height + ")");
		}
		center = new Vector2(x + width * 0.5f, y + height * 0.5f);
		size = new Vector2(width, height);
	}

	private void RecomputeRuntimeCenterOfMass()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.RecomputeRuntimeCenterOfMass");
		if (bodyProfile == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Body profile is missing while recomputing COM.");
		}
		if (weaponDefs == null || equipDefs == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Runtime loadout definitions are missing while recomputing COM.");
		}
		float num = Mathf.Max(0.01f, bodyProfile.Mass);
		Vector2 vector = bodyProfile.BodyComOffset * num;
		float num2 = Mathf.Max(0.3f, frontWheelRadius * 5.2f);
		float num3 = Mathf.Max(0.3f, backWheelRadius * 5.2f);
		vector += frontWheelLocal * num2;
		vector += backWheelLocal * num3;
		num += num2 + num3;
		for (int i = 0; i < weaponDefs.Length; i++)
		{
			SummerRaceWeaponDefSO weaponDefinition = GetWeaponDefinition(i);
			float num4 = Mathf.Max(0.35f, Mathf.Max(0f, weaponDefinition.knockback) * 0.7f + Mathf.Max(0f, weaponDefinition.damage) * 0.3f);
			Vector2 vector2 = ResolveMountMassPointLocal(SummerRaceMountSlotTypeConfig.Weapon, i);
			vector += vector2 * num4;
			num += num4;
		}
		for (int j = 0; j < equipDefs.Length; j++)
		{
			SummerRaceEquipDefSO equipDefinition = GetEquipDefinition(j);
			float num5 = Mathf.Max(0.25f, Mathf.Max(0f, equipDefinition.strength) * 0.08f + Mathf.Max(0f, equipDefinition.radius) * 0.18f);
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
			throw new InvalidOperationException("[SummerRace][Enemy] Missing body mount definitions for COM solve.");
		}
		for (int i = 0; i < summerRaceBodyDefSO.mountPoints.Count; i++)
		{
			SummerRaceMountPointDefConfig summerRaceMountPointDefConfig = summerRaceBodyDefSO.mountPoints[i];
			if (summerRaceMountPointDefConfig != null && summerRaceMountPointDefConfig.slotType == slotType && summerRaceMountPointDefConfig.slotIndex == slotIndex)
			{
				return summerRaceMountPointDefConfig.localPosition;
			}
		}
		throw new InvalidOperationException("[SummerRace][Enemy] Missing mount point for COM solve: " + slotType.ToString() + " index=" + slotIndex);
	}

	private void UpdateBuildAnalyticsCache()
	{
		RequireBodyProfileReady("Enemy.UpdateBuildAnalyticsCache");
		if (weaponDefs == null || weaponDefs.Length == 0 || equipDefs == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Missing runtime weapon/equip definitions while rebuilding build analytics.");
		}
		EnsureWeaponDefinitionCacheReady("Enemy.UpdateBuildAnalyticsCache", throwOnFailure: true);
		EnsureEquipDefinitionCacheReady("Enemy.UpdateBuildAnalyticsCache", throwOnFailure: true);
		float num = Mathf.Abs(frontWheelLocal.x - backWheelLocal.x);
		Vector2 centerOfMass = RequirePhysicsBodyReady("Enemy.UpdateBuildAnalyticsCache").centerOfMass;
		float frontRearMassBias = ((num > 0.001f) ? Mathf.Clamp(centerOfMass.x / Mathf.Max(0.01f, num * 0.5f), -1f, 1f) : 0f);
		float num2 = 0f;
		float num3 = 0f;
		for (int i = 0; i < weaponDefs.Length; i++)
		{
			SummerRaceWeaponAnalyticsEstimate summerRaceWeaponAnalyticsEstimate = SummerRaceBuildScoring.EstimateWeaponOutput(weaponDefs[i]);
			num2 += summerRaceWeaponAnalyticsEstimate.EstimatedDps;
			num3 += summerRaceWeaponAnalyticsEstimate.RecoilLoad;
		}
		float tractionGain = Mathf.Clamp(currentMoveSpeed * 1.8f, 4f, 12f);
		cachedBuildProfile = new SummerRaceBuildProfile
		{
			SourceTag = "Enemy",
			BodyType = bodyType,
			BodyLabel = bodyProfile.Label,
			Weapons = (WeaponKind[])weaponTypes.Clone(),
			Equips = (EquipKind[])equipTypes.Clone(),
			TotalMass = RequirePhysicsBodyReady("Enemy.UpdateBuildAnalyticsCache").mass,
			CenterOfMassLocal = centerOfMass,
			FrontWheelRadius = frontWheelRadius,
			BackWheelRadius = backWheelRadius,
			WheelBase = num,
			FrontRearMassBias = frontRearMassBias,
			CruiseSpeed = currentMoveSpeed,
			TractionGain = tractionGain,
			EstimatedDps = num2,
			RecoilLoad = num3,
			CostUsed = 0,
			CostCap = 0
		};
		cachedBuildRating = SummerRaceBuildScoring.Evaluate(cachedBuildProfile);
		cachedBuildArchetype = SummerRaceBuildScoring.Classify(cachedBuildProfile, cachedBuildRating);
		cachedBuildSignature = SummerRaceBuildScoring.BuildSignature(cachedBuildProfile);
	}

	private void ApplyScaledStats(int wave)
	{
		float num = 1f + (float)(Mathf.Max(1, wave) - 1) * 0.12f;
		maxHp = Mathf.Max(2f, (float)baseHp * num);
		currentHp = maxHp;
		base.LastDamageReceivedTime = float.NegativeInfinity;
		currentMoveSpeed = Mathf.Max(1f, baseMoveSpeed * (bodyProfile.CruiseSpeed / 2.8f) * Mathf.Lerp(1f, 1.22f, Mathf.Clamp01((float)(wave - 1) * 0.18f)));
		currentEnergy = 0f;
		nextOverloadCheckAt = 0f;
		if (weaponOverloadUntilBySlot != null)
		{
			Array.Clear(weaponOverloadUntilBySlot, 0, weaponOverloadUntilBySlot.Length);
		}
		nextDebugLogAt = 0f;
		UpdateBuildAnalyticsCache();
	}

	private int ScaleDamageToPlayer(int rawDamage)
	{
		if (rawDamage <= 0)
		{
			return 0;
		}
		return Mathf.Max(1, Mathf.RoundToInt((float)rawDamage * enemyDamageMultiplier));
	}

	private CombatImpactPayload CreateScaledWeaponImpactPayloadForPlayer(SummerRaceWeaponDefSO weaponDef, WeaponKind weaponType, CombatTriggerType trigger)
	{
		if (weaponDef == null)
		{
			throw new ArgumentNullException("weaponDef");
		}
		SummerRaceWeaponSpec spec = weaponDef.ToRuntimeSpec(weaponType);
		return ScaleDamageImpactPayloadForPlayer(SummerRaceCombatEffectFactory.CreateWeaponImpactPayload(spec, trigger));
	}

	private CombatImpactPayload ScaleDamageImpactPayloadForPlayer(CombatImpactPayload payload)
	{
		if (payload == null)
		{
			return payload;
		}
		CombatImpactPayload combatImpactPayload = payload.Clone();
		ScaleDamageEffectsForPlayerInPlace(combatImpactPayload.effects);
		return combatImpactPayload;
	}

	private CombatEffectSpec[] CloneAndScaleDamageEffectsForPlayer(CombatEffectSpec[] effects)
	{
		if (effects == null || effects.Length == 0)
		{
			return Array.Empty<CombatEffectSpec>();
		}
		CombatEffectSpec[] array = new CombatEffectSpec[effects.Length];
		for (int i = 0; i < effects.Length; i++)
		{
			array[i] = ((effects[i] != null) ? effects[i].Clone() : null);
		}
		ScaleDamageEffectsForPlayerInPlace(array);
		return array;
	}

	private void ScaleDamageEffectsForPlayerInPlace(CombatEffectSpec[] effects)
	{
		if (effects == null)
		{
			return;
		}
		foreach (CombatEffectSpec combatEffectSpec in effects)
		{
			if (combatEffectSpec != null && combatEffectSpec.enabled && (combatEffectSpec.effectKind == CombatEffectKind.Damage || combatEffectSpec.effectKind == CombatEffectKind.Burn))
			{
				combatEffectSpec.magnitude = ScaleDamageToPlayer(Mathf.RoundToInt(combatEffectSpec.magnitude));
			}
		}
	}

	private static string ResolveWeaponDefinitionLabel(SummerRaceWeaponDefSO weaponDef)
	{
		if (weaponDef == null)
		{
			return "Weapon";
		}
		if (!string.IsNullOrEmpty(weaponDef.displayName))
		{
			return weaponDef.displayName;
		}
		return weaponDef.weaponType.ToString();
	}

	private static string ResolveEquipDefinitionLabel(SummerRaceEquipDefSO equipDef)
	{
		if (equipDef == null)
		{
			return "Equip";
		}
		if (!string.IsNullOrEmpty(equipDef.displayName))
		{
			return equipDef.displayName;
		}
		return equipDef.equipType.ToString();
	}

	private bool EnsureWeaponDefinitionCacheReady(string context, bool throwOnFailure)
	{
		if (!hasExplicitBuildConfig)
		{
			if (throwOnFailure)
			{
				throw new InvalidOperationException("[SummerRace][Enemy] Explicit catalog build configuration is required before weapon cache access (" + context + ").");
			}
			return false;
		}
		if (IsWeaponDefinitionCacheAligned())
		{
			return true;
		}
		TryRepairWeaponDefinitionCache();
		if (IsWeaponDefinitionCacheAligned())
		{
			return true;
		}
		if (throwOnFailure)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Weapon definition cache is not aligned with runtime build.");
		}
		return false;
	}

	private bool EnsureEquipDefinitionCacheReady(string context, bool throwOnFailure)
	{
		if (!hasExplicitBuildConfig)
		{
			if (throwOnFailure)
			{
				throw new InvalidOperationException("[SummerRace][Enemy] Explicit catalog build configuration is required before equip cache access (" + context + ").");
			}
			return false;
		}
		if (IsEquipDefinitionCacheAligned())
		{
			return true;
		}
		TryRepairEquipDefinitionCache();
		if (IsEquipDefinitionCacheAligned())
		{
			return true;
		}
		if (throwOnFailure)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Equip definition cache is not aligned with runtime build.");
		}
		return false;
	}

	private bool IsWeaponDefinitionCacheAligned()
	{
		if (weaponDefs == null || weaponTypes == null || weaponMeleeImpactPayloads == null || weaponOverloadUntilBySlot == null || weaponDefs.Length != weaponTypes.Length || weaponDefs.Length != weaponMeleeImpactPayloads.Length || weaponDefs.Length != weaponOverloadUntilBySlot.Length)
		{
			return false;
		}
		for (int i = 0; i < weaponDefs.Length; i++)
		{
			if (weaponDefs[i] == null || weaponMeleeImpactPayloads[i] == null)
			{
				return false;
			}
		}
		return true;
	}

	private bool IsEquipDefinitionCacheAligned()
	{
		if (equipDefs == null || equipTypes == null || equipDefs.Length != equipTypes.Length)
		{
			return false;
		}
		for (int i = 0; i < equipDefs.Length; i++)
		{
			if (equipDefs[i] == null)
			{
				return false;
			}
		}
		return true;
	}

	private void TryRepairWeaponDefinitionCache()
	{
		if (weaponDefs != null && weaponDefs.Length != 0)
		{
			RebuildWeaponCachesFromDefinitions();
		}
	}

	private void TryRepairEquipDefinitionCache()
	{
		if (equipDefs != null && equipDefs.Length != 0)
		{
			RebuildEquipCachesFromDefinitions();
		}
	}

	private void RebuildWeaponCachesFromDefinitions()
	{
		WeaponKind[] array = new WeaponKind[weaponDefs.Length];
		CombatImpactPayload[] array2 = new CombatImpactPayload[weaponDefs.Length];
		float[] array3 = new float[weaponDefs.Length];
		if (weaponOverloadUntilBySlot != null && weaponOverloadUntilBySlot.Length != 0)
		{
			Array.Copy(weaponOverloadUntilBySlot, array3, Mathf.Min(weaponOverloadUntilBySlot.Length, array3.Length));
		}
		for (int i = 0; i < weaponDefs.Length; i++)
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = weaponDefs[i];
			if (summerRaceWeaponDefSO == null)
			{
				return;
			}
			array2[i] = CreateScaledWeaponImpactPayloadForPlayer(summerRaceWeaponDefSO, array[i] = (WeaponKind)summerRaceWeaponDefSO.weaponType, CombatTriggerType.MeleeHit);
		}
		weaponTypes = array;
		weaponMeleeImpactPayloads = array2;
		weaponOverloadUntilBySlot = array3;
	}

	private static SummerRaceWeaponDefSO ResolveRuntimeWeaponDef(WeaponKind weaponType)
	{
		SummerRaceWeaponDefSO summerRaceWeaponDefSO = SummerRaceConfigLoader.LoadWeaponDef(weaponType);
		if (summerRaceWeaponDefSO == null)
		{
			return null;
		}
		SummerRaceActivityRuntimeCatalog summerRaceActivityRuntimeCatalog = ((SummerRaceFightManager.Instance != null) ? SummerRaceFightManager.Instance.CurrentActivityConfig : null);
		if (summerRaceActivityRuntimeCatalog == null || !summerRaceActivityRuntimeCatalog.TryGetWeapon(weaponType, out var weapon) || weapon == null || weapon.FireInterval <= 0f)
		{
			return summerRaceWeaponDefSO;
		}
		SummerRaceWeaponDefSO summerRaceWeaponDefSO2 = UnityEngine.Object.Instantiate(summerRaceWeaponDefSO);
		summerRaceWeaponDefSO2.name = summerRaceWeaponDefSO.name + "_EnemyRuntimeOverride";
		summerRaceWeaponDefSO2.damage = Mathf.Max(0, weapon.Damage);
		summerRaceWeaponDefSO2.modularFireInterval = Mathf.Max(0.0001f, weapon.FireInterval);
		if (weapon.HasBurnOverride)
		{
			summerRaceWeaponDefSO2.burnDps = Mathf.Max(0, weapon.BurnDps);
			summerRaceWeaponDefSO2.burnDuration = Mathf.Max(0f, weapon.BurnDuration);
		}
		SummerRaceWeaponRuntimeOverrideUtility.ApplyProjectileOverrides(summerRaceWeaponDefSO2, weapon);
		return summerRaceWeaponDefSO2;
	}

	private void RebuildEquipCachesFromDefinitions()
	{
		EquipKind[] array = new EquipKind[equipDefs.Length];
		for (int i = 0; i < equipDefs.Length; i++)
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = equipDefs[i];
			if (summerRaceEquipDefSO == null)
			{
				return;
			}
			EquipKind equipType = (EquipKind)summerRaceEquipDefSO.equipType;
			array[i] = equipType;
		}
		equipTypes = array;
	}

	private SummerRaceWeaponDefSO GetWeaponDefinition(int slotIndex)
	{
		EnsureWeaponDefinitionCacheReady("Enemy.GetWeaponDefinition", throwOnFailure: true);
		if (slotIndex < 0 || slotIndex >= weaponDefs.Length || weaponDefs[slotIndex] == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Missing cached weapon def. slot=" + slotIndex);
		}
		return weaponDefs[slotIndex];
	}

	private bool TryGetWeaponDefinition(int slotIndex, out SummerRaceWeaponDefSO weaponDef)
	{
		weaponDef = null;
		if (!EnsureWeaponDefinitionCacheReady("Enemy.TryGetWeaponDefinition", throwOnFailure: false))
		{
			return false;
		}
		if (slotIndex < 0 || slotIndex >= weaponDefs.Length)
		{
			return false;
		}
		weaponDef = weaponDefs[slotIndex];
		return weaponDef != null;
	}

	private SummerRaceEquipDefSO GetEquipDefinition(int slotIndex)
	{
		EnsureEquipDefinitionCacheReady("Enemy.GetEquipDefinition", throwOnFailure: true);
		if (slotIndex < 0 || slotIndex >= equipDefs.Length || equipDefs[slotIndex] == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Missing cached equip def. slot=" + slotIndex);
		}
		return equipDefs[slotIndex];
	}

	private string ResolveBuildSummary()
	{
		if (!Application.isPlaying)
		{
			string text = ((bodyProfile != null) ? bodyProfile.Label : bodyType.ToString());
			string text2 = ((weaponDefs != null && weaponDefs.Length != 0 && weaponDefs[0] != null) ? weaponDefs[0].displayName : "Weapon");
			string text3 = ((equipDefs != null && equipDefs.Length != 0 && equipDefs[0] != null) ? equipDefs[0].displayName : "No Equip");
			return text + " | " + text2 + " | " + text3;
		}
		string label = RequireBodyProfileReady("Enemy.ResolveBuildSummary").Label;
		EnsureWeaponDefinitionCacheReady("Enemy.ResolveBuildSummary", throwOnFailure: true);
		EnsureEquipDefinitionCacheReady("Enemy.ResolveBuildSummary", throwOnFailure: true);
		if (weaponDefs.Length == 0 || weaponDefs[0] == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Missing primary weapon def while resolving build summary.");
		}
		string displayName = weaponDefs[0].displayName;
		string text4 = ((equipDefs.Length != 0 && equipDefs[0] != null) ? equipDefs[0].displayName : "No Equip");
		return label + " | " + displayName + " | " + text4;
	}

	protected override float GetCruiseSpeed()
	{
		return currentMoveSpeed;
	}

	protected override float GetTractionGain()
	{
		return 1.45f;
	}

	protected override float GetTractionCompressionMultiplier()
	{
		return 1.2f;
	}

	protected override float GetDesiredWheelLinearMultiplier()
	{
		return 1.9f;
	}

	protected override Vector2 GetWheelRadiusClampRange()
	{
		return new Vector2(0.75f, 1.35f);
	}

	protected override Vector2 ResolveRuntimeMountLocalPosition(SummerRaceMountPointDefConfig mount, float mountXSign)
	{
		if (mount == null)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Null mount config while resolving runtime mount position.");
		}
		SummerRaceConfigLoader.BodyPrefabRuntimeData bodyPrefabRuntimeData = SummerRaceConfigLoader.LoadBodyPrefabRuntimeData(bodyType);
		return SummerRaceBodyLayoutMapper.ResolveRuntimeLocalFromBodyVisual(bodyVisual, mount.localPosition, bodyPrefabRuntimeData.BodyVisualLocalPosition, bodyPrefabRuntimeData.BodyVisualLocalScale, "[SummerRace][Enemy] RuntimeMount slotType=" + mount.slotType.ToString() + " slotIndex=" + mount.slotIndex);
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
			throw new InvalidOperationException("[SummerRace][Enemy] Layer 'Character' is required for wheel collider layer.");
		}
		transform2.gameObject.layer = num;
		transform2.localScale = SummerRaceCharacterBase.ResolveWheelVisualScaleForRadius(wheelOuterSprite, wheelRadius, visualLocalScale.z, "[SummerRace][Enemy] " + wheelName);
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
		SummerRaceCharacterBase.BindWheelVisualSprites(transform2, wheelOuterSprite, wheelInnerSprite, 26, 27, SummerRaceCharacterBase.WheelInnerTireVisualAuthoringOffset, "[SummerRace][Enemy] " + wheelName);
		SummerRaceCharacterBase.SyncWheelVisualSortingToBody(transform2, bodySkeletonAnimation, "[SummerRace][Enemy] " + wheelName + ".Sorting");
		LogWheelVisualRendererState(transform2, "[SummerRace][Enemy] " + wheelName);
		CircleCollider2D circleCollider2D = transform2.GetComponent<CircleCollider2D>();
		if (circleCollider2D == null)
		{
			circleCollider2D = transform2.gameObject.AddComponent<CircleCollider2D>();
		}
		float num2 = Mathf.Max(Mathf.Abs(transform2.lossyScale.x), Mathf.Abs(transform2.lossyScale.y));
		if (num2 <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Invalid wheel world scale while fitting wheel collider.");
		}
		circleCollider2D.radius = Mathf.Max(0.01f, wheelRadius / num2);
		circleCollider2D.isTrigger = true;
		if (base.IsRuntimeDebugLogEnabled)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][Enemy][WheelColliderFit] wheel=" + wheelName + " wheelRadius=" + wheelRadius.ToString("F4") + " worldScale=" + num2.ToString("F4") + " colliderRadius=" + circleCollider2D.radius.ToString("F4") + " lossyScale=" + transform2.lossyScale.ToString("F4") + " localScale=" + transform2.localScale.ToString("F4") + " layer=" + LayerMask.LayerToName(transform2.gameObject.layer) + " isTrigger=" + circleCollider2D.isTrigger);
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

	protected override void UpdateWheelVisual(float dirX, float dt)
	{
		SyncModularVisualMirror();
		float num = Mathf.Clamp(currentMoveSpeed * 235f, 120f, 500f);
		float num2 = dirX * num * Mathf.Max(0.0001f, dt);
		if (frontWheel != null)
		{
			SummerRaceCharacterBase.RotateWheelVisual(frontWheel, 0f - num2);
			frontWheelVisualWorld = ResolveWheelVisualWorldPos(frontWheelLocal, frontWheelRadius, lastFrontWheelContact, frontWheelVisualWorld, ref frontWheelVisualVelY, ref frontWheelVisualInitialized, dt);
			frontWheel.position = frontWheelVisualWorld;
		}
		if (backWheel != null)
		{
			SummerRaceCharacterBase.RotateWheelVisual(backWheel, 0f - num2);
			backWheelVisualWorld = ResolveWheelVisualWorldPos(backWheelLocal, backWheelRadius, lastBackWheelContact, backWheelVisualWorld, ref backWheelVisualVelY, ref backWheelVisualInitialized, dt);
			backWheel.position = backWheelVisualWorld;
		}
	}

	protected override Vector2 ResolveWheelVisualWorldPos(Vector2 wheelLocal, float wheelRadius, WheelContactData contact, Vector2 cachedWorld, ref float yVelocity, ref bool initialized, float dt)
	{
		return base.ResolveWheelVisualWorldPos(wheelLocal, wheelRadius, contact, cachedWorld, ref yVelocity, ref initialized, dt);
	}

	protected override float GetSuspensionReach(float wheelRadius)
	{
		float num = ((bodyType == SummerRaceBodyType.Heavy) ? 1.38f : ((bodyType == SummerRaceBodyType.Light) ? 1f : 1.16f));
		return Mathf.Max(0.05f, wheelProbeExtra * num + wheelRadius * 0.22f);
	}

	protected override void GetSuspensionBodyMultipliers(out float springMul, out float dampingMul)
	{
		if (bodyType == SummerRaceBodyType.Heavy)
		{
			springMul = 1.14f;
			dampingMul = 0.98f;
		}
		else if (bodyType == SummerRaceBodyType.Light)
		{
			springMul = 0.96f;
			dampingMul = 0.9f;
		}
		else
		{
			springMul = 1.02f;
			dampingMul = 0.94f;
		}
	}

	private new float GetWheelVisualTravelMultiplier()
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

	private new void GetWheelVisualSpringDamping(out float springMul, out float dampingMul)
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

	private new void ResetWheelVisualState()
	{
		frontWheelVisualWorld = base.transform.TransformPoint(frontWheelLocal);
		backWheelVisualWorld = base.transform.TransformPoint(backWheelLocal);
		frontWheelVisualVelY = 0f;
		backWheelVisualVelY = 0f;
		frontWheelVisualInitialized = false;
		backWheelVisualInitialized = false;
	}

	protected override void DrawWheelCircleDebug()
	{
		if (drawRuntimeGizmos && drawColliderOutlineInGame)
		{
			Color color = new Color(1f, 0.92f, 0.2f, 0.95f);
			if (frontWheel != null)
			{
				DrawDebugCircle(frontWheel.position, frontWheelRadius, color);
			}
			if (backWheel != null)
			{
				DrawDebugCircle(backWheel.position, backWheelRadius, color);
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

	private void SnapToLaneImmediate()
	{
		float y = ResolveSpawnYAlignedToArenaFloor(laneY + ResolveSpawnLaneLift(), "Enemy.SnapToLaneImmediate");
		ApplySpawnPoseImmediate(base.transform.position.x, y);
	}

	private float ResolveSpawnLaneLift()
	{
		float num = Mathf.Max(0.05f, (GetSuspensionReach(frontWheelRadius) + GetSuspensionReach(backWheelRadius)) * 0.5f);
		float num2 = Mathf.Clamp01(spawnCompressionNormalized);
		return Mathf.Clamp(num * (1f - num2), 0.04f, 0.42f);
	}

	private void EmitDebugState(float dirX, float absDx)
	{
		if (base.IsRuntimeDebugLogEnabled && base.name.EndsWith("_0") && !(rb == null) && !(Time.time < nextDebugLogAt))
		{
			nextDebugLogAt = Time.time + 1f;
			float num = Mathf.Max(Mathf.Abs(lastFrontWheelContact.compressionVelocity), Mathf.Abs(lastBackWheelContact.compressionVelocity));
			float num2 = Mathf.Max(lastFrontWheelContact.supportSwitchCount1s, lastBackWheelContact.supportSwitchCount1s);
			float num3 = Mathf.Max(Mathf.Abs(lastFrontWheelContact.relativeNormalSpeed), Mathf.Abs(lastBackWheelContact.relativeNormalSpeed));
			SummerRaceRuntimeLog.Log("[SummerRace][Enemy] name=" + base.name + " build=" + BuildSummary + " archetype=" + SummerRaceBuildScoring.GetArchetypeLabel(cachedBuildArchetype) + " sig=" + cachedBuildSignature + " hp=" + currentHp.ToString("F1") + "/" + maxHp.ToString("F1") + " energy=" + currentEnergy.ToString("F1") + " dirX=" + dirX.ToString("F2") + " dx=" + absDx.ToString("F2") + " vel=" + rb.velocity.ToString("F2") + " contact=" + DebugWheelContactSummary + " event=" + FormatExplainabilityEventLabel() + " ovl=" + CountActiveWeaponOverloads() + "/" + weaponOverloadUntilBySlot.Length + " supportSource=F:" + lastFrontWheelContact.supportSource.ToString() + " B:" + lastBackWheelContact.supportSource.ToString() + " compressionVelPeak=" + num.ToString("F2") + " supportSwitchCount1s=" + num2.ToString("F1") + " relativeNormalSpeedPeak=" + num3.ToString("F2") + " wheelEmbedRatio=" + debugWheelEmbedRatio.ToString("F3") + " rearCompression=" + debugRearCompressionNormalized.ToString("F3") + "s targetEmbed<=" + wheelEmbedTargetRatio.ToString("F2") + " rearCap<=" + rearCompressionCapUnderFireDrive.ToString("F2"));
		}
	}

	protected override void RecordExplainabilityEvent(string category, string detail, bool logToConsole = false)
	{
		lastExplainabilityEvent = category + " | " + detail;
		lastExplainabilityEventAt = (Application.isPlaying ? Time.time : 0f);
		if (base.IsRuntimeDebugLogEnabled & logToConsole)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][Enemy][" + category + "] " + base.name + " " + detail);
		}
	}

	private new void TickEnergyAndOverload()
	{
		if (!CanTickRuntimeWeaponState())
		{
			return;
		}
		currentEnergy = Mathf.Clamp(currentEnergy + energyRegenPerSecond * Time.deltaTime, 0f, maxEnergy);
		if (Time.time < nextOverloadCheckAt)
		{
			return;
		}
		nextOverloadCheckAt = Time.time + 1.4f;
		if (!(currentEnergy < 4.2f) && !(UnityEngine.Random.value > 0.55f))
		{
			int num = PickEligibleWeaponOverloadSlot();
			if (num >= 0)
			{
				currentEnergy -= 4.2f;
				weaponOverloadUntilBySlot[num] = Time.time + 3f;
				SummerRaceFightManager.Instance?.NotifyEnemyOverclockActivated(this);
			}
		}
	}

	private int CountActiveWeaponOverloads()
	{
		if (weaponOverloadUntilBySlot == null || weaponOverloadUntilBySlot.Length == 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < weaponOverloadUntilBySlot.Length; i++)
		{
			if (Time.time < weaponOverloadUntilBySlot[i])
			{
				num++;
			}
		}
		return num;
	}

	private int PickEligibleWeaponOverloadSlot()
	{
		if (!CanTickRuntimeWeaponState())
		{
			return -1;
		}
		RequireModularBackendReady("Enemy.PickEligibleWeaponOverloadSlot");
		if (weaponDefs.Length == 0)
		{
			return -1;
		}
		int[] array = null;
		int num = 0;
		int[] array2 = null;
		int num2 = 0;
		for (int i = 0; i < weaponDefs.Length; i++)
		{
			if (Time.time < ResolveWeaponOverloadUntil(i))
			{
				continue;
			}
			if (array2 == null)
			{
				array2 = new int[weaponDefs.Length];
			}
			array2[num2++] = i;
			if (modularWeaponSystem.IsSlotReady(i))
			{
				if (array == null)
				{
					array = new int[weaponDefs.Length];
				}
				array[num++] = i;
			}
		}
		if (num > 0)
		{
			return array[UnityEngine.Random.Range(0, num)];
		}
		if (num2 > 0)
		{
			return array2[UnityEngine.Random.Range(0, num2)];
		}
		return -1;
	}

	private bool CanTickRuntimeWeaponState()
	{
		if (!EnsureWeaponDefinitionCacheReady("Enemy.CanTickRuntimeWeaponState", throwOnFailure: false))
		{
			return false;
		}
		if (weaponDefs != null && weaponMeleeImpactPayloads != null && weaponOverloadUntilBySlot != null && weaponDefs.Length != 0 && weaponDefs.Length == weaponMeleeImpactPayloads.Length)
		{
			return weaponDefs.Length == weaponOverloadUntilBySlot.Length;
		}
		return false;
	}

	private float ResolveFacingSign(Vector2 toPlayer)
	{
		if (Mathf.Abs(toPlayer.x) > 0.05f)
		{
			return Mathf.Sign(toPlayer.x);
		}
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.ResolveFacingSign");
		if (Mathf.Abs(rigidbody2D.velocity.x) > 0.08f)
		{
			return Mathf.Sign(rigidbody2D.velocity.x);
		}
		if (chaseDirection < 0)
		{
			return -1f;
		}
		return 1f;
	}

	private Vector2 ResolveCurrentAimDirection()
	{
		float facingSign = ((chaseDirection >= 0) ? 1f : (-1f));
		return GetChassisForwardVector(facingSign);
	}

	protected override float ResolveFacingDirection()
	{
		Rigidbody2D rigidbody2D = RequirePhysicsBodyReady("Enemy.ResolveFacingDirection");
		if (Mathf.Abs(rigidbody2D.velocity.x) > 0.08f)
		{
			return Mathf.Sign(rigidbody2D.velocity.x);
		}
		if (chaseDirection < 0)
		{
			return -1f;
		}
		return 1f;
	}

	protected override float ResolveThrusterImpulseGuardSeconds(float duration)
	{
		return Mathf.Max(0.75f, Mathf.Min(1.05f, ResolveThrusterActiveSeconds(duration) * 0.85f));
	}

	protected override Vector2 ResolveThrusterVehicleForwardDirection()
	{
		return -ResolveForwardPhysicsDirection();
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
			throw new InvalidOperationException("[SummerRace][Enemy] Chassis forward is invalid.");
		}
		return vector.normalized;
	}

	private void ResolveWeaponMountPose(float facingSign, out Vector2 mountPos, out Vector2 mountForward)
	{
		Vector2 vector = new Vector2(Mathf.Abs(weaponMountLocalOffset.x) * ((facingSign >= 0f) ? 1f : (-1f)), weaponMountLocalOffset.y);
		mountPos = base.transform.TransformPoint(vector);
		Vector2 chassisForwardVector = GetChassisForwardVector(facingSign);
		mountForward = Rotate(chassisForwardVector, weaponMountLocalAngle * ((facingSign >= 0f) ? 1f : (-1f)));
		if (mountForward.sqrMagnitude < 0.0001f)
		{
			mountForward = chassisForwardVector;
		}
	}

	private void OnDrawGizmos()
	{
		if (drawRuntimeGizmos)
		{
			DrawRuntimeContactGizmos();
			DrawWeaponDirectionGizmos();
		}
	}

	private void DrawRuntimeContactGizmos()
	{
		if (drawRuntimeGizmos && drawColliderOutlineInGame)
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
			Gizmos.DrawLine(vector, vector2);
			Gizmos.color = Color.green;
			Gizmos.DrawLine(vector2, vector2 + (Vector3)(contact.normal * 0.32f));
			Gizmos.color = Color.yellow;
			Gizmos.DrawLine(vector2, vector2 + (Vector3)(contact.tangent * 0.26f));
		}
	}

	private void DrawWeaponDirectionGizmos()
	{
		if (drawRuntimeGizmos && drawWeaponDirectionDebug)
		{
			Vector2 toPlayer = ((player != null) ? ((Vector2)player.position - (Vector2)base.transform.position) : GetChassisForwardVector((chaseDirection >= 0) ? 1f : (-1f)));
			float facingSign = ResolveFacingSign(toPlayer);
			Vector2 chassisForwardVector = GetChassisForwardVector(facingSign);
			ResolveWeaponMountPose(facingSign, out var mountPos, out var mountForward);
			Vector2 vector = ((mountForward.sqrMagnitude > 0.0001f) ? mountForward.normalized : chassisForwardVector);
			float num = Mathf.Max(0.25f, weaponDirectionDebugLength);
			Gizmos.color = Color.cyan;
			Gizmos.DrawLine(base.transform.position, (Vector2)base.transform.position + chassisForwardVector * num);
			Gizmos.color = Color.magenta;
			Gizmos.DrawLine(mountPos, mountPos + mountForward.normalized * (num * 0.9f));
			Gizmos.color = Color.yellow;
			Gizmos.DrawLine(mountPos, mountPos + vector * num);
		}
	}

	private void DrawWeaponDirectionDebug(Vector2 toPlayer)
	{
		if (drawRuntimeGizmos && drawWeaponDirectionDebug)
		{
			float facingSign = ResolveFacingSign(toPlayer);
			Vector2 chassisForwardVector = GetChassisForwardVector(facingSign);
			ResolveWeaponMountPose(facingSign, out var mountPos, out var mountForward);
			Vector2 vector = ((mountForward.sqrMagnitude > 0.0001f) ? mountForward.normalized : chassisForwardVector);
			float num = Mathf.Max(0.25f, weaponDirectionDebugLength);
			Debug.DrawLine(base.transform.position, (Vector2)base.transform.position + chassisForwardVector * num, Color.cyan, 0f, depthTest: false);
			Debug.DrawLine(mountPos, mountPos + mountForward.normalized * (num * 0.9f), Color.magenta, 0f, depthTest: false);
			Debug.DrawLine(mountPos, mountPos + vector * num, Color.yellow, 0f, depthTest: false);
		}
	}

	private new static Vector2 Rotate(Vector2 v, float degrees)
	{
		float f = degrees * (MathF.PI / 180f);
		float num = Mathf.Cos(f);
		float num2 = Mathf.Sin(f);
		return new Vector2(v.x * num - v.y * num2, v.x * num2 + v.y * num).normalized;
	}

	private static BodyProfile GetBodyProfile(SummerRaceBodyType type)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyDef(type);
		if (summerRaceBodyDefSO == null)
		{
			SummerRaceRuntimeLog.Error("Enemy body config missing: " + type);
			throw new Exception("Enemy body config missing: " + type);
		}
		if (summerRaceBodyDefSO.forwardAcceleration <= 0f)
		{
			throw new InvalidOperationException("[SummerRace][Enemy] Body forwardAcceleration must be > 0: body=" + type.ToString() + " value=" + summerRaceBodyDefSO.forwardAcceleration);
		}
		BodyProfile bodyProfile = new BodyProfile
		{
			Label = summerRaceBodyDefSO.displayName,
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
			return bodyProfile;
		}
		SummerRaceRuntimeLog.Error("[SummerRace] Enemy body " + type.ToString() + " requires at least two wheel configs.");
		throw new Exception("[SummerRace] Enemy body " + type.ToString() + " requires at least two wheel configs.");
	}
}
