using System;

[Serializable]
public sealed class SummerRaceActivityWeaponSourceRecord
{
	public SummerRaceWeaponTypeConfig WeaponType = SummerRaceWeaponTypeConfig.MachineGun;

	public string DisplayName = string.Empty;

	public int Cost;

	public float EnergyCost;

	public float CooldownSeconds;

	public int Damage;

	public float FireInterval;

	public bool HasBurnOverride;

	public int BurnDps;

	public float BurnDuration;

	public float[] EffectParams = Array.Empty<float>();

	public string UnlockStageId = string.Empty;
}
