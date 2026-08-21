using System;

[Serializable]
public sealed class SummerRaceActivityCatalogSourceData
{
	public string ActivityId = "tank";

	public SummerRaceBuildDatabaseSO BuildDatabase;

	public SummerRaceActivityStageSourceRecord[] Stages = Array.Empty<SummerRaceActivityStageSourceRecord>();

	public SummerRaceActivityEnemySourceRecord[] Enemies = Array.Empty<SummerRaceActivityEnemySourceRecord>();

	public SummerRaceActivityBodySourceRecord[] Bodies = Array.Empty<SummerRaceActivityBodySourceRecord>();

	public SummerRaceActivityWeaponSourceRecord[] Weapons = Array.Empty<SummerRaceActivityWeaponSourceRecord>();

	public SummerRaceActivityEquipSourceRecord[] Equips = Array.Empty<SummerRaceActivityEquipSourceRecord>();

	public SummerRaceActivityChallengePoolSourceRecord[] ChallengePools = Array.Empty<SummerRaceActivityChallengePoolSourceRecord>();

	public static SummerRaceActivityCatalogSourceData FromBuildDatabase(SummerRaceBuildDatabaseSO buildDatabase, string activityId = "tank")
	{
		return new SummerRaceActivityCatalogSourceData
		{
			ActivityId = (string.IsNullOrEmpty(activityId) ? "tank" : activityId),
			BuildDatabase = buildDatabase,
			Enemies = SummerRaceActivityConfigMapper.BuildEnemySourcesFromDatabase(buildDatabase)
		};
	}
}
