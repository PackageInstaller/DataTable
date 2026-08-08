using System;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/ModularVehicle/Utility Module", fileName = "UtilityModule")]
public class UtilityModuleDefinition : ModuleDefinition
{
	[Header("SummerRace Reference")]
	public SummerRaceEquipDefSO summerRaceEquipDef;

	[Header("Utility Effects (ModularVehicle)")]
	[Min(0f)]
	public float extraMass;

	public float enginePowerBonus;

	public float batteryBonus;

	public float stabilityBonus;

	public float armorBonus;

	public Vector2 customCenterOfMassOffsetContribution;

	public SummerRaceEquipTypeConfig EquipType => RequireEquipDef("EquipType").equipType;

	public string DisplayName
	{
		get
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = RequireEquipDef("DisplayName");
			RequireNonEmpty(summerRaceEquipDefSO.displayName, "displayName", summerRaceEquipDefSO.name);
			return summerRaceEquipDefSO.displayName;
		}
	}

	public int CostValue => RequireEquipDef("CostValue").cost;

	public float MassValue => RequireEquipDef("MassValue").loadWeight;

	public float EnergyCost => RequireEquipDef("EnergyCost").energyCost;

	public float Cooldown => RequireEquipDef("Cooldown").cooldown;

	public float Duration => RequireEquipDef("Duration").duration;

	public float Radius => RequireEquipDef("Radius").radius;

	public float Strength => RequireEquipDef("Strength").strength;

	public string EmitterIdleAnimName => RequireEquipDef("EmitterIdleAnimName").emitterIdleAnimName;

	public string EmitterFireAnimName => RequireEquipDef("EmitterFireAnimName").emitterFireAnimName;

	public Vector2 ProjectileVisualSize => RequireEquipDef("ProjectileVisualSize").projectileVisualSize;

	public float ProjectileColliderRadius => RequireEquipDef("ProjectileColliderRadius").projectileColliderRadius;

	public SummerRaceProjectileHitPolicyConfig ProjectileHitPolicy => RequireEquipDef("ProjectileHitPolicy").projectileHitPolicy;

	public float ExtraMassValue => RequireEquipDef("ExtraMassValue").modularExtraMass;

	public float EnginePowerBonusValue => RequireEquipDef("EnginePowerBonusValue").modularEnginePowerBonus;

	public float BatteryBonusValue => RequireEquipDef("BatteryBonusValue").modularBatteryBonus;

	public float StabilityBonusValue => RequireEquipDef("StabilityBonusValue").modularStabilityBonus;

	public float ArmorBonusValue => RequireEquipDef("ArmorBonusValue").modularArmorBonus;

	public Vector2 CenterOfMassOffsetContributionValue => RequireEquipDef("CenterOfMassOffsetContributionValue").modularCenterOfMassOffsetContribution;

	public string ModularSpineSkeletonDataPath => RequireEquipDef("ModularSpineSkeletonDataPath").modularSpineSkeletonDataPath;

	public Vector2 ModularSpineLocalOffset => RequireEquipDef("ModularSpineLocalOffset").modularSpineLocalOffset;

	public float ModularSpineLocalAngle => RequireEquipDef("ModularSpineLocalAngle").modularSpineLocalAngle;

	public float ModularSpineScale => RequireEquipDef("ModularSpineScale").modularSpineScale;

	public string HookHeadSpineSkeletonDataPath => RequireEquipDef("HookHeadSpineSkeletonDataPath").hookHeadSpineSkeletonDataPath;

	public Vector2 HookHeadSpineLocalOffset => RequireEquipDef("HookHeadSpineLocalOffset").hookHeadSpineLocalOffset;

	public float HookHeadSpineLocalAngle => RequireEquipDef("HookHeadSpineLocalAngle").hookHeadSpineLocalAngle;

	public float HookHeadSpineScale => RequireEquipDef("HookHeadSpineScale").hookHeadSpineScale;

	public string HookHeadSpineAnimationName => RequireEquipDef("HookHeadSpineAnimationName").hookHeadSpineAnimationName;

	public string HookRopeSpineSkeletonDataPath => RequireEquipDef("HookRopeSpineSkeletonDataPath").hookRopeSpineSkeletonDataPath;

	public string HookRopeSpineAnimationName => RequireEquipDef("HookRopeSpineAnimationName").hookRopeSpineAnimationName;

	public int HookRopeBoneCount => RequireEquipDef("HookRopeBoneCount").hookRopeBoneCount;

	public float HookRopeMaxLength => RequireEquipDef("HookRopeMaxLength").hookRopeMaxLength;

	public float HookRopeDamping => RequireEquipDef("HookRopeDamping").hookRopeDamping;

	public float HookRopeStiffness => RequireEquipDef("HookRopeStiffness").hookRopeStiffness;

	public override VehicleMountType MountType => VehicleMountType.Utility;

	private SummerRaceEquipDefSO RequireEquipDef(string fieldName)
	{
		if (summerRaceEquipDef == null)
		{
			throw new InvalidOperationException("[UtilityModuleDefinition] Missing SummerRace equip def for " + fieldName + " on " + base.name);
		}
		return summerRaceEquipDef;
	}

	private static void RequireNonEmpty(string value, string fieldName, string assetName)
	{
		if (string.IsNullOrWhiteSpace(value))
		{
			throw new InvalidOperationException("[UtilityModuleDefinition] Missing " + fieldName + " on " + assetName);
		}
	}

	private static void RequireRange(float value, float min, string fieldName, string assetName)
	{
		if (value < min)
		{
			throw new InvalidOperationException("[UtilityModuleDefinition] Invalid " + fieldName + "=" + value + " on " + assetName);
		}
	}

	private void OnValidate()
	{
		if (!(summerRaceEquipDef == null))
		{
			RequireNonEmpty(summerRaceEquipDef.displayName, "displayName", summerRaceEquipDef.name);
			RequireRange(summerRaceEquipDef.cooldown, 0f, "cooldown", summerRaceEquipDef.name);
			RequireRange(summerRaceEquipDef.energyCost, 0f, "energyCost", summerRaceEquipDef.name);
			mass = summerRaceEquipDef.loadWeight;
			cost = summerRaceEquipDef.cost;
		}
	}
}
