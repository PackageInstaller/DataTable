using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/Config/EquipDef", fileName = "SummerRaceEquipDef")]
public class SummerRaceEquipDefSO : ScriptableObject
{
	public SummerRaceEquipTypeConfig equipType;

	public string displayName = "Thruster";

	public int cost = 1;

	public float energyCost = 2f;

	public float cooldown = 2.5f;

	public float duration = 0.9f;

	public float radius;

	public float strength;

	public float loadWeight = 1f;

	public string emitterIdleAnimName = string.Empty;

	public string emitterFireAnimName = string.Empty;

	public Vector2 projectileVisualSize;

	public float projectileColliderRadius = 0.05f;

	public SummerRaceProjectileHitPolicyConfig projectileHitPolicy;

	public Vector2 modularModuleSize;

	public float modularExtraMass;

	public float modularEnginePowerBonus;

	public float modularBatteryBonus;

	public float modularStabilityBonus;

	public float modularArmorBonus;

	public Vector2 modularCenterOfMassOffsetContribution;

	public string modularSpineSkeletonDataPath = string.Empty;

	public Vector2 modularSpineLocalOffset;

	public float modularSpineLocalAngle;

	public float modularSpineScale = 1f;

	public string hookHeadSpineSkeletonDataPath = string.Empty;

	public Vector2 hookHeadSpineLocalOffset;

	public float hookHeadSpineLocalAngle;

	public float hookHeadSpineScale = 1f;

	public string hookHeadSpineAnimationName = string.Empty;

	public string hookRopeSpineSkeletonDataPath = string.Empty;

	public string hookRopeSpineAnimationName = string.Empty;

	public int hookRopeBoneCount = 12;

	public float hookRopeMaxLength = 3f;

	public float hookRopeDamping = 8f;

	public float hookRopeStiffness = 28f;

	public bool ValidateModularData(out string reason)
	{
		if (modularModuleSize.x <= 0f || modularModuleSize.y <= 0f)
		{
			reason = "modularModuleSize must be > 0 on both axes";
			return false;
		}
		if (modularExtraMass < 0f)
		{
			reason = "modularExtraMass must be >= 0";
			return false;
		}
		if (string.IsNullOrWhiteSpace(modularSpineSkeletonDataPath))
		{
			reason = "modularSpineSkeletonDataPath is empty";
			return false;
		}
		if (modularSpineScale <= 0f)
		{
			reason = "modularSpineScale must be > 0";
			return false;
		}
		if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(modularSpineSkeletonDataPath, out var reason2))
		{
			reason = "modularSpineSkeletonDataPath is invalid: " + reason2;
			return false;
		}
		if (string.IsNullOrWhiteSpace(emitterIdleAnimName))
		{
			reason = "emitterIdleAnimName is empty";
			return false;
		}
		if (string.IsNullOrWhiteSpace(emitterFireAnimName))
		{
			reason = "emitterFireAnimName is empty";
			return false;
		}
		if (equipType == SummerRaceEquipTypeConfig.Hook)
		{
			if (string.IsNullOrWhiteSpace(hookHeadSpineSkeletonDataPath))
			{
				reason = "hookHeadSpineSkeletonDataPath is empty for Hook";
				return false;
			}
			if (hookHeadSpineScale <= 0f)
			{
				reason = "hookHeadSpineScale must be > 0";
				return false;
			}
			if (string.IsNullOrWhiteSpace(hookHeadSpineAnimationName))
			{
				reason = "hookHeadSpineAnimationName is empty for Hook";
				return false;
			}
			if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(hookHeadSpineSkeletonDataPath, out var reason3))
			{
				reason = "hookHeadSpineSkeletonDataPath is invalid: " + reason3;
				return false;
			}
			if (string.IsNullOrWhiteSpace(hookRopeSpineSkeletonDataPath))
			{
				reason = "hookRopeSpineSkeletonDataPath is empty for Hook";
				return false;
			}
			if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(hookRopeSpineSkeletonDataPath, out var reason4))
			{
				reason = "hookRopeSpineSkeletonDataPath is invalid: " + reason4;
				return false;
			}
			if (string.IsNullOrWhiteSpace(hookRopeSpineAnimationName))
			{
				reason = "hookRopeSpineAnimationName is empty for Hook";
				return false;
			}
			if (hookRopeBoneCount < 2)
			{
				reason = "hookRopeBoneCount must be >= 2";
				return false;
			}
			if (hookRopeMaxLength <= 0f)
			{
				reason = "hookRopeMaxLength must be > 0";
				return false;
			}
		}
		reason = "OK";
		return true;
	}
}
