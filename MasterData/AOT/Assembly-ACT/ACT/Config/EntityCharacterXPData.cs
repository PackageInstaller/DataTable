using System;

namespace ACT.Config;

[Serializable]
public class EntityCharacterXPData
{
	public readonly int id;

	public readonly int xpTotal;

	public readonly int xpEachLv;

	public readonly int getSkillPoint;

	public EntityCharacterXPData(int id, int xpTotal, int xpEachLv, int getSkillPoint)
	{
		this.id = id;
		this.xpTotal = xpTotal;
		this.xpEachLv = xpEachLv;
		this.getSkillPoint = getSkillPoint;
	}
}
