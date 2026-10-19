using System;

namespace ACT.Config;

[Serializable]
public class CookSkillLevel
{
	public readonly int id;

	public readonly int type;

	public readonly int skill;

	public readonly int skillCondition;

	public readonly int skillLevel;

	public readonly int iconAddress;

	public readonly int actionScope;

	public CookSkillLevel(int id, int type, int skill, int skillCondition, int skillLevel, int iconAddress, int actionScope)
	{
		this.id = id;
		this.type = type;
		this.skill = skill;
		this.skillCondition = skillCondition;
		this.skillLevel = skillLevel;
		this.iconAddress = iconAddress;
		this.actionScope = actionScope;
	}
}
