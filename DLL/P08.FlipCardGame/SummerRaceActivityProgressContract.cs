using System;

[Serializable]
public sealed class SummerRaceActivityProgressContract
{
	public string ActivityId = "tank";

	public string CurrentStageId = string.Empty;

	public string[] UnlockedStageIds = Array.Empty<string>();

	public string[] ClearedStageIds = Array.Empty<string>();

	public string[] ClaimedRewardGroupIds = Array.Empty<string>();

	public SummerRaceBodyType[] UnlockedBodies = Array.Empty<SummerRaceBodyType>();

	public WeaponKind[] UnlockedWeapons = Array.Empty<WeaponKind>();

	public EquipKind[] UnlockedEquips = Array.Empty<EquipKind>();

	public int BestChallengeScore;

	public int EncyclopediaProgress;
}
