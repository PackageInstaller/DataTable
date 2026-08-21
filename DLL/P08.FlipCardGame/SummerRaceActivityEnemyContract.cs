using System;

[Serializable]
public sealed class SummerRaceActivityEnemyContract : SummerRaceActivityIdentifiedContract
{
	public SummerRaceBodyType BodyType = SummerRaceBodyType.Medium;

	public WeaponKind[] Weapons = Array.Empty<WeaponKind>();

	public EquipKind[] Equips = Array.Empty<EquipKind>();

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
