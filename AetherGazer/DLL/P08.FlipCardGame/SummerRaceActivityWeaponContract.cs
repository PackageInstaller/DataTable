using System;

[Serializable]
public sealed class SummerRaceActivityWeaponContract
{
	public WeaponKind WeaponKind = WeaponKind.MachineGun;

	public string DisplayName = string.Empty;

	public int Cost;

	public float EnergyCost;

	public float CooldownSeconds;

	public int Damage;

	public float FireInterval;

	public bool HasBurnOverride;

	public int BurnDps;

	public float BurnDuration;

	public bool HasProjectileCountOverride;

	public int ProjectileCount;

	public bool HasProjectileSpreadOverride;

	public float ProjectileSpreadDegrees;

	public bool HasProjectileSpeedOverride;

	public float ProjectileSpeed;

	public bool HasRotatingSawSpinSpeedScaleOverride;

	public float RotatingSawSpinSpeedScale = 1f;

	public string UnlockStageId = string.Empty;
}
