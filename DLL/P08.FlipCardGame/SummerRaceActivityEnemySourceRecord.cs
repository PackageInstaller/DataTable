using System;

[Serializable]
public sealed class SummerRaceActivityEnemySourceRecord
{
	public string Id = string.Empty;

	public string DisplayName = string.Empty;

	public SummerRaceBuildDefSO BuildDefinition;

	public SummerRaceBodyTypeConfig BodyType = SummerRaceBodyTypeConfig.Medium;

	public SummerRaceWeaponTypeConfig[] Weapons = Array.Empty<SummerRaceWeaponTypeConfig>();

	public SummerRaceEquipTypeConfig[] Equips = Array.Empty<SummerRaceEquipTypeConfig>();

	public bool HasBodyOverride;

	public bool HasWeaponOverride;

	public bool HasEquipOverride;

	public SummerRaceBuildArchetype PreferredArchetype;

	public string SignatureHint = string.Empty;

	public int BaseHp = 3;

	public float MoveSpeed = 2.5f;

	public int CollisionDamage = 1;

	public float DamageMultiplier = 1f;

	public string BattleIntroText = string.Empty;

	public string OverclockBubbleText = string.Empty;

	public string DefeatEffect = string.Empty;

	public string BodyIcon = string.Empty;

	public string LogoSkinName = string.Empty;
}
