using System;

namespace ACT.Config;

[Serializable]
public class MenuSkill
{
	public readonly int id;

	public readonly int skillid;

	public readonly int skillweight;

	public readonly int iconAddress;

	public readonly int skillLevel;

	public readonly int actionScope;

	public MenuSkill(int id, int skillid, int skillweight, int iconAddress, int skillLevel, int actionScope)
	{
		this.id = id;
		this.skillid = skillid;
		this.skillweight = skillweight;
		this.iconAddress = iconAddress;
		this.skillLevel = skillLevel;
		this.actionScope = actionScope;
	}
}
