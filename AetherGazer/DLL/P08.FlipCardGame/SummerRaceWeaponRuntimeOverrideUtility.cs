using UnityEngine;

public static class SummerRaceWeaponRuntimeOverrideUtility
{
	private const int RotatingSawSpinSpeedScaleEffectParamIndex = 0;

	public static bool TryResolveRotatingSawSpinSpeedScale(SummerRaceWeaponTypeConfig weaponType, float[] effectParams, out float scale)
	{
		scale = 1f;
		if (weaponType != SummerRaceWeaponTypeConfig.RotatingSaw || effectParams == null || effectParams.Length == 0)
		{
			return false;
		}
		scale = Mathf.Clamp01(effectParams[0]);
		return true;
	}

	public static void ApplyRotatingSawSpinSpeedScale(SummerRaceWeaponDefSO runtimeDef, float[] effectParams)
	{
		if (!(runtimeDef == null) && TryResolveRotatingSawSpinSpeedScale(runtimeDef.weaponType, effectParams, out var scale))
		{
			runtimeDef.rotatingSawSpinSpeedScale = scale;
		}
	}

	public static bool TryResolveScatterShellProjectileParams(SummerRaceWeaponTypeConfig weaponType, float[] effectParams, out int projectileCount, out float spreadDegrees, out float projectileSpeed)
	{
		projectileCount = 0;
		spreadDegrees = 0f;
		projectileSpeed = 0f;
		if (weaponType != SummerRaceWeaponTypeConfig.ScatterShell || effectParams == null || effectParams.Length < 3)
		{
			return false;
		}
		projectileCount = Mathf.Max(1, Mathf.RoundToInt(effectParams[0]));
		spreadDegrees = Mathf.Max(0f, effectParams[1]);
		projectileSpeed = Mathf.Max(0f, effectParams[2]);
		return true;
	}

	public static void ApplyProjectileOverrides(SummerRaceWeaponDefSO runtimeDef, SummerRaceActivityWeaponContract contract)
	{
		if (!(runtimeDef == null) && contract != null)
		{
			if (contract.HasProjectileCountOverride)
			{
				runtimeDef.projectileCount = Mathf.Max(1, contract.ProjectileCount);
			}
			if (contract.HasProjectileSpreadOverride)
			{
				runtimeDef.modularOptionalSpread = Mathf.Max(0f, contract.ProjectileSpreadDegrees);
			}
			if (contract.HasProjectileSpeedOverride)
			{
				runtimeDef.projectileSpeed = Mathf.Max(0f, contract.ProjectileSpeed);
			}
			if (contract.HasRotatingSawSpinSpeedScaleOverride && contract.WeaponKind == WeaponKind.RotatingSaw)
			{
				runtimeDef.rotatingSawSpinSpeedScale = Mathf.Clamp01(contract.RotatingSawSpinSpeedScale);
			}
		}
	}

	public static void ApplyScatterShellEffectParams(SummerRaceWeaponDefSO runtimeDef, float[] effectParams)
	{
		if (!(runtimeDef == null) && TryResolveScatterShellProjectileParams(runtimeDef.weaponType, effectParams, out var projectileCount, out var spreadDegrees, out var projectileSpeed))
		{
			runtimeDef.projectileCount = projectileCount;
			runtimeDef.modularOptionalSpread = spreadDegrees;
			runtimeDef.projectileSpeed = projectileSpeed;
		}
	}
}
