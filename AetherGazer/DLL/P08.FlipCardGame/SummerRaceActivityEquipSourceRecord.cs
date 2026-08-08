using System;

[Serializable]
public sealed class SummerRaceActivityEquipSourceRecord
{
	public SummerRaceEquipTypeConfig EquipType;

	public string DisplayName = string.Empty;

	public int Cost;

	public float EnergyCost;

	public float CooldownSeconds;

	public string UnlockStageId = string.Empty;
}
