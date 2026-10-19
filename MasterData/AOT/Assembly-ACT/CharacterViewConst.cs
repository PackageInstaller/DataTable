using System;

public class CharacterViewConst
{
	public enum ReasonType
	{
		None,
		LackMaterial,
		ReachMaxLevel,
		LackCoin,
		LessPlayerLevel,
		LessBreakLevel,
		PreNodeLocked,
		IsTalent,
		LessCharacterLevel,
		LessWorldLevel,
		[Obsolete("需求删掉了技能点", true)]
		LackSkillPoint
	}
}
