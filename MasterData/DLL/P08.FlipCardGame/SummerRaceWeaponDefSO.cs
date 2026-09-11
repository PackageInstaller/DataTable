using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/Config/WeaponDef", fileName = "SummerRaceWeaponDef")]
public class SummerRaceWeaponDefSO : ScriptableObject
{
	public SummerRaceWeaponTypeConfig weaponType = SummerRaceWeaponTypeConfig.MachineGun;

	public string displayName = "Machine Gun";

	public int cost = 3;

	public float energyCost = 2f;

	public float cooldown = 0.35f;

	public SummerRaceWeaponFireModeConfig fireMode;

	public int burstCount = 3;

	public float burstInterval = 0.06f;

	public int damage = 1;

	public bool isMelee;

	public float range = 6f;

	public int projectileCount = 1;

	public float projectileSpeed = 10f;

	public float projectileLifetime = 1.2f;

	public float baseSpread = 0.6f;

	public float spreadIncreasePerShot = 0.22f;

	public float maxSpread = 3.2f;

	public float spreadDecayPerSecond = 5.5f;

	public float adsSpreadMultiplier = 0.55f;

	public float recoilBackImpulse = 0.22f;

	public float recoilUpImpulse = 0.32f;

	public float recoilSideImpulse = 0.1f;

	public float recoilSpring = 64f;

	public float recoilDamping = 12f;

	public float adsRecoilMultiplier = 0.68f;

	public float viewPunchUp = 0.25f;

	public float viewPunchSide = 0.12f;

	public float viewSpring = 52f;

	public float viewDamping = 9f;

	public bool enableShake = true;

	public float shakeAmplitude = 0.08f;

	public float shakeDuration = 0.07f;

	public float loadWeight = 1f;

	public float knockback = 1f;

	public float stunDuration;

	public float slowMultiplier = 1f;

	public float slowDuration;

	public int burnDps;

	public float burnDuration;

	public bool boomerangFlight;

	public bool disableEnemyWeapons;

	public float disableDuration;

	public Color projectileColor = Color.white;

	public string emitterIdleAnimName = string.Empty;

	public string emitterFireAnimName = string.Empty;

	[Range(0f, 1f)]
	public float rotatingSawSpinSpeedScale = 1f;

	public Vector2 projectileVisualSize;

	public float projectileColliderRadius = 0.05f;

	public string projectileLoopAnimName = string.Empty;

	public string projectileDespawnAnimName = string.Empty;

	public SummerRaceProjectileHitPolicyConfig projectileHitPolicy;

	public float meleeRange = 1f;

	public float meleeRadius = 0.9f;

	public Vector2 modularModuleSize;

	public Vector2 modularMuzzleLocalOffset;

	public float modularMuzzleAlternatingYOffset;

	public WeaponAimMode modularAimMode;

	public float modularRecoilImpulse;

	public float modularFireInterval;

	public float modularOptionalSpread;

	public int modularBurstCount = 1;

	public float modularRecoilAmplifyForGameplay;

	public float modularCameraShakeHint;

	public string modularSpineSkeletonDataPath = string.Empty;

	public Vector2 modularSpineLocalOffset;

	public float modularSpineLocalAngle;

	public float modularSpineScale = 1f;

	public string modularSpinePivotBoneName = string.Empty;

	public Vector2 modularSpinePivotLocalOffset = Vector2.zero;

	public string projectileSpineSkeletonDataPath = string.Empty;

	public Vector2 projectileSpineLocalOffset;

	public float projectileSpineLocalAngle;

	public float projectileSpineScale = 1f;

	public bool enableMountedProjectilePreview;

	public string mountedProjectileAnchorSlotName = string.Empty;

	public string mountedProjectileAnimName = "none";

	public Vector2 mountedProjectileLocalOffset;

	public float mountedProjectileRespawnDelay = 0.12f;

	public Vector2 boomerangMountLocalOffset;

	public string impactSpineSkeletonDataPath = string.Empty;

	public Vector2 impactSpineLocalOffset;

	public float impactSpineLocalAngle;

	public float impactSpineScale = 1f;

	public bool ValidateModularData(out string reason)
	{
		if (modularModuleSize.x <= 0f || modularModuleSize.y <= 0f)
		{
			reason = "modularModuleSize must be > 0 on both axes";
			return false;
		}
		if (modularRecoilImpulse < 0f)
		{
			reason = "modularRecoilImpulse must be >= 0";
			return false;
		}
		if (modularFireInterval <= 0f)
		{
			reason = "modularFireInterval must be > 0";
			return false;
		}
		if (modularBurstCount <= 0)
		{
			reason = "modularBurstCount must be > 0";
			return false;
		}
		if (modularRecoilAmplifyForGameplay <= 0f)
		{
			reason = "modularRecoilAmplifyForGameplay must be > 0";
			return false;
		}
		if (string.IsNullOrWhiteSpace(modularSpineSkeletonDataPath))
		{
			reason = "modularSpineSkeletonDataPath is empty";
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
		if (weaponType == SummerRaceWeaponTypeConfig.RotatingSaw && (float.IsNaN(modularSpinePivotLocalOffset.x) || float.IsInfinity(modularSpinePivotLocalOffset.x) || float.IsNaN(modularSpinePivotLocalOffset.y) || float.IsInfinity(modularSpinePivotLocalOffset.y)))
		{
			reason = "modularSpinePivotLocalOffset is invalid for RotatingSaw";
			return false;
		}
		if (projectileVisualSize.x <= 0f || projectileVisualSize.y <= 0f)
		{
			reason = "projectileVisualSize must be > 0 on both axes";
			return false;
		}
		if (projectileColliderRadius <= 0f)
		{
			reason = "projectileColliderRadius must be > 0";
			return false;
		}
		if (!isMelee)
		{
			if (string.IsNullOrWhiteSpace(projectileLoopAnimName))
			{
				reason = "projectileLoopAnimName is empty for non-melee weapon";
				return false;
			}
			if (string.IsNullOrWhiteSpace(projectileDespawnAnimName))
			{
				reason = "projectileDespawnAnimName is empty for non-melee weapon";
				return false;
			}
		}
		if (!isMelee)
		{
			if (string.IsNullOrWhiteSpace(projectileSpineSkeletonDataPath))
			{
				reason = "projectileSpineSkeletonDataPath is empty for non-melee weapon";
				return false;
			}
			if (projectileSpineScale <= 0f)
			{
				reason = "projectileSpineScale must be > 0";
				return false;
			}
			if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(projectileSpineSkeletonDataPath, out var reason3))
			{
				reason = "projectileSpineSkeletonDataPath is invalid: " + reason3;
				return false;
			}
			if (enableMountedProjectilePreview && mountedProjectileRespawnDelay < 0f)
			{
				reason = "mountedProjectileRespawnDelay must be >= 0";
				return false;
			}
			if (enableMountedProjectilePreview && string.IsNullOrWhiteSpace(mountedProjectileAnimName))
			{
				reason = "mountedProjectileAnimName is empty while mounted projectile preview is enabled";
				return false;
			}
		}
		if (!string.IsNullOrWhiteSpace(impactSpineSkeletonDataPath))
		{
			if (impactSpineScale <= 0f)
			{
				reason = "impactSpineScale must be > 0";
				return false;
			}
			if (!SummerRaceConfigLoader.TryValidateSkeletonDataPath(impactSpineSkeletonDataPath, out var reason4))
			{
				reason = "impactSpineSkeletonDataPath is invalid: " + reason4;
				return false;
			}
		}
		reason = "OK";
		return true;
	}
}
