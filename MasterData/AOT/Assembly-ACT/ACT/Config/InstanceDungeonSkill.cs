using System;

namespace ACT.Config;

[Serializable]
public class InstanceDungeonSkill
{
	public readonly int id;

	public readonly int skillIcon;

	public InstanceDungeonSkill(int id, int skillIcon)
	{
		this.id = id;
		this.skillIcon = skillIcon;
	}
}
