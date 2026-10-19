using System;

namespace ACT.Config;

[Serializable]
public class CookEffectSkill
{
	public readonly int id;

	public readonly int type;

	public readonly int skill;

	public readonly int skillLevel;

	public readonly int iconAddress;

	public readonly int skillPr;

	public readonly int multilevel;

	public CookEffectSkill(int id, int type, int skill, int skillLevel, int iconAddress, int skillPr, int multilevel)
	{
		this.id = id;
		this.type = type;
		this.skill = skill;
		this.skillLevel = skillLevel;
		this.iconAddress = iconAddress;
		this.skillPr = skillPr;
		this.multilevel = multilevel;
	}
}
