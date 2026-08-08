using System;

[Serializable]
public sealed class SummerRaceActivityEquipContract
{
	public EquipKind EquipKind;

	public string DisplayName = string.Empty;

	public int Cost;

	public float EnergyCost;

	public float CooldownSeconds;

	public string UnlockStageId = string.Empty;
}
