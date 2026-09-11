using System;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/ModularVehicle/Weapon Module", fileName = "WeaponModule")]
public class WeaponModuleDefinition : ModuleDefinition
{
	[Header("SummerRace Reference")]
	public SummerRaceWeaponDefSO summerRaceWeaponDef;

	[Header("ModularVehicle Weapon Fire")]
	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.modularRecoilImpulse.")]
	[Min(0f)]
	public float recoilImpulse = 120f;

	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.modularFireInterval.")]
	[Min(0.03f)]
	public float fireInterval = 0.18f;

	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.projectileSpeed.")]
	[Min(0f)]
	public float projectileSpeed = 18f;

	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.modularMuzzleLocalOffset.")]
	public Vector2 muzzleLocalOffset = new Vector2(0.4f, 0f);

	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.modularAimMode.")]
	public WeaponAimMode aimMode;

	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.modularOptionalSpread.")]
	[Min(0f)]
	public float optionalSpread = 1.5f;

	[Tooltip("Compatibility-only cache. Runtime should read SummerRaceWeaponDefSO.modularBurstCount.")]
	[Min(1f)]
	public int optionalBurstCount = 1;

	[Header("ModularVehicle Feedback")]
	[Tooltip("Legacy compatibility only. Runtime recoil should read recoilImpulse and ignore this field.")]
	[Obsolete("Compatibility-only. Do not use in new runtime code.")]
	[Min(0f)]
	public float recoilAmplifyForGameplay = 1f;

	[Min(0f)]
	public float cameraShakeHint = 0.08f;

	[Header("Legacy Fields")]
	[Min(0f)]
	public int damage = 1;

	public SummerRaceWeaponTypeConfig WeaponType => RequireWeaponDef("WeaponType").weaponType;

	public string DisplayName
	{
		get
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = RequireWeaponDef("DisplayName");
			RequireNonEmpty(summerRaceWeaponDefSO.displayName, "displayName", summerRaceWeaponDefSO.name);
			return summerRaceWeaponDefSO.displayName;
		}
	}

	public int CostValue => RequireWeaponDef("CostValue").cost;

	public float MassValue => RequireWeaponDef("MassValue").loadWeight;

	public WeaponAimMode AimModeValue => RequireWeaponDef("AimModeValue").modularAimMode;

	public Vector2 MuzzleLocalOffsetValue => RequireWeaponDef("MuzzleLocalOffsetValue").modularMuzzleLocalOffset;

	public float MuzzleAlternatingYOffsetValue => RequireWeaponDef("MuzzleAlternatingYOffsetValue").modularMuzzleAlternatingYOffset;

	public float RecoilImpulseValue => RequireWeaponDef("RecoilImpulseValue").modularRecoilImpulse;

	public float FireIntervalValue => RequireWeaponDef("FireIntervalValue").modularFireInterval;

	public float OptionalSpreadValue => RequireWeaponDef("OptionalSpreadValue").modularOptionalSpread;

	public int OptionalBurstCountValue => RequireWeaponDef("OptionalBurstCountValue").modularBurstCount;

	public float CameraShakeHintValue => RequireWeaponDef("CameraShakeHintValue").modularCameraShakeHint;

	public float RecoilAmplifyForGameplayValue => RequireWeaponDef("RecoilAmplifyForGameplayValue").modularRecoilAmplifyForGameplay;

	public float EnergyCost => RequireWeaponDef("EnergyCost").energyCost;

	public float Cooldown => RequireWeaponDef("Cooldown").cooldown;

	public SummerRaceWeaponFireModeConfig FireMode => RequireWeaponDef("FireMode").fireMode;

	public int BurstCount => RequireWeaponDef("BurstCount").burstCount;

	public float BurstInterval => RequireWeaponDef("BurstInterval").burstInterval;

	public int Damage => RequireWeaponDef("Damage").damage;

	public bool IsMelee => RequireWeaponDef("IsMelee").isMelee;

	public float Range => RequireWeaponDef("Range").range;

	public int ProjectileCount => RequireWeaponDef("ProjectileCount").projectileCount;

	public float ProjectileSpeedValue => RequireWeaponDef("ProjectileSpeedValue").projectileSpeed;

	public float ProjectileLifetime => RequireWeaponDef("ProjectileLifetime").projectileLifetime;

	public float BaseSpread => RequireWeaponDef("BaseSpread").baseSpread;

	public float SpreadIncreasePerShot => RequireWeaponDef("SpreadIncreasePerShot").spreadIncreasePerShot;

	public float MaxSpread => RequireWeaponDef("MaxSpread").maxSpread;

	public float SpreadDecayPerSecond => RequireWeaponDef("SpreadDecayPerSecond").spreadDecayPerSecond;

	public float AdsSpreadMultiplier => RequireWeaponDef("AdsSpreadMultiplier").adsSpreadMultiplier;

	public float RecoilBackImpulse => RequireWeaponDef("RecoilBackImpulse").recoilBackImpulse;

	public float RecoilUpImpulse => RequireWeaponDef("RecoilUpImpulse").recoilUpImpulse;

	public float RecoilSideImpulse => RequireWeaponDef("RecoilSideImpulse").recoilSideImpulse;

	public float RecoilSpring => RequireWeaponDef("RecoilSpring").recoilSpring;

	public float RecoilDamping => RequireWeaponDef("RecoilDamping").recoilDamping;

	public float AdsRecoilMultiplier => RequireWeaponDef("AdsRecoilMultiplier").adsRecoilMultiplier;

	public float ViewPunchUp => RequireWeaponDef("ViewPunchUp").viewPunchUp;

	public float ViewPunchSide => RequireWeaponDef("ViewPunchSide").viewPunchSide;

	public float ViewSpring => RequireWeaponDef("ViewSpring").viewSpring;

	public float ViewDamping => RequireWeaponDef("ViewDamping").viewDamping;

	public bool EnableShake => RequireWeaponDef("EnableShake").enableShake;

	public float ShakeAmplitude => RequireWeaponDef("ShakeAmplitude").shakeAmplitude;

	public float ShakeDuration => RequireWeaponDef("ShakeDuration").shakeDuration;

	public float Knockback => RequireWeaponDef("Knockback").knockback;

	public float StunDuration => RequireWeaponDef("StunDuration").stunDuration;

	public float SlowMultiplier => RequireWeaponDef("SlowMultiplier").slowMultiplier;

	public float SlowDuration => RequireWeaponDef("SlowDuration").slowDuration;

	public int BurnDps => RequireWeaponDef("BurnDps").burnDps;

	public float BurnDuration => RequireWeaponDef("BurnDuration").burnDuration;

	public bool BoomerangFlight => RequireWeaponDef("BoomerangFlight").boomerangFlight;

	public bool DisableEnemyWeapons => RequireWeaponDef("DisableEnemyWeapons").disableEnemyWeapons;

	public float DisableDuration => RequireWeaponDef("DisableDuration").disableDuration;

	public Color ProjectileColor => RequireWeaponDef("ProjectileColor").projectileColor;

	public string EmitterIdleAnimName => RequireWeaponDef("EmitterIdleAnimName").emitterIdleAnimName;

	public string EmitterFireAnimName => RequireWeaponDef("EmitterFireAnimName").emitterFireAnimName;

	public float RotatingSawSpinSpeedScale => RequireWeaponDef("RotatingSawSpinSpeedScale").rotatingSawSpinSpeedScale;

	public Vector2 ProjectileVisualSize => RequireWeaponDef("ProjectileVisualSize").projectileVisualSize;

	public float ProjectileColliderRadius => RequireWeaponDef("ProjectileColliderRadius").projectileColliderRadius;

	public string ProjectileLoopAnimName => RequireWeaponDef("ProjectileLoopAnimName").projectileLoopAnimName;

	public string ProjectileDespawnAnimName => RequireWeaponDef("ProjectileDespawnAnimName").projectileDespawnAnimName;

	public SummerRaceProjectileHitPolicyConfig ProjectileHitPolicy => RequireWeaponDef("ProjectileHitPolicy").projectileHitPolicy;

	public float MeleeRange => RequireWeaponDef("MeleeRange").meleeRange;

	public float MeleeRadius => RequireWeaponDef("MeleeRadius").meleeRadius;

	public string ProjectileSpineSkeletonDataPath => RequireWeaponDef("ProjectileSpineSkeletonDataPath").projectileSpineSkeletonDataPath;

	public Vector2 ProjectileSpineLocalOffset => RequireWeaponDef("ProjectileSpineLocalOffset").projectileSpineLocalOffset;

	public float ProjectileSpineLocalAngle => RequireWeaponDef("ProjectileSpineLocalAngle").projectileSpineLocalAngle;

	public float ProjectileSpineScale => RequireWeaponDef("ProjectileSpineScale").projectileSpineScale;

	public string ModularSpinePivotBoneName => RequireWeaponDef("ModularSpinePivotBoneName").modularSpinePivotBoneName;

	public Vector2 ModularSpinePivotLocalOffset => RequireWeaponDef("ModularSpinePivotLocalOffset").modularSpinePivotLocalOffset;

	public bool EnableMountedProjectilePreview => RequireWeaponDef("EnableMountedProjectilePreview").enableMountedProjectilePreview;

	public string MountedProjectileAnchorSlotName => RequireWeaponDef("MountedProjectileAnchorSlotName").mountedProjectileAnchorSlotName;

	public string MountedProjectileAnimName => RequireWeaponDef("MountedProjectileAnimName").mountedProjectileAnimName;

	public Vector2 MountedProjectileLocalOffset => RequireWeaponDef("MountedProjectileLocalOffset").mountedProjectileLocalOffset;

	public float MountedProjectileRespawnDelay => RequireWeaponDef("MountedProjectileRespawnDelay").mountedProjectileRespawnDelay;

	public Vector2 BoomerangMountLocalOffset => RequireWeaponDef("BoomerangMountLocalOffset").boomerangMountLocalOffset;

	public string ImpactSpineSkeletonDataPath => RequireWeaponDef("ImpactSpineSkeletonDataPath").impactSpineSkeletonDataPath;

	public Vector2 ImpactSpineLocalOffset => RequireWeaponDef("ImpactSpineLocalOffset").impactSpineLocalOffset;

	public float ImpactSpineLocalAngle => RequireWeaponDef("ImpactSpineLocalAngle").impactSpineLocalAngle;

	public float ImpactSpineScale => RequireWeaponDef("ImpactSpineScale").impactSpineScale;

	public override VehicleMountType MountType => VehicleMountType.Weapon;

	private SummerRaceWeaponDefSO RequireWeaponDef(string fieldName)
	{
		if (summerRaceWeaponDef == null)
		{
			throw new InvalidOperationException("[WeaponModuleDefinition] Missing SummerRace weapon def for " + fieldName + " on " + base.name);
		}
		return summerRaceWeaponDef;
	}

	private static void RequireNonEmpty(string value, string fieldName, string assetName)
	{
		if (string.IsNullOrWhiteSpace(value))
		{
			throw new InvalidOperationException("[WeaponModuleDefinition] Missing " + fieldName + " on " + assetName);
		}
	}

	private static void RequireRange(float value, float min, string fieldName, string assetName)
	{
		if (value < min)
		{
			throw new InvalidOperationException("[WeaponModuleDefinition] Invalid " + fieldName + "=" + value + " on " + assetName);
		}
	}

	private void OnValidate()
	{
		if (!(summerRaceWeaponDef == null))
		{
			RequireNonEmpty(summerRaceWeaponDef.displayName, "displayName", summerRaceWeaponDef.name);
			RequireRange(summerRaceWeaponDef.projectileSpeed, 0f, "projectileSpeed", summerRaceWeaponDef.name);
			RequireRange(summerRaceWeaponDef.cooldown, 0f, "cooldown", summerRaceWeaponDef.name);
			mass = summerRaceWeaponDef.loadWeight;
			cost = summerRaceWeaponDef.cost;
		}
	}
}
