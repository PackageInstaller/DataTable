using System;

[Serializable]
public struct SummerRaceBuildBlueprint
{
	public string SourceTag;

	public SummerRaceBodyType BodyType;

	public WeaponKind[] Weapons;

	public EquipKind[] Equips;

	public SummerRaceBuildRating Rating;

	public SummerRaceBuildArchetype Archetype;

	public string Signature;
}
