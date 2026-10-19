using System;

namespace ACT.Config;

[Serializable]
public class UseSkill
{
	public readonly int id;

	public readonly string[] stateName = new string[0];

	public readonly string[] abilityName = new string[0];

	public UseSkill(int id, string[] stateName, string[] abilityName)
	{
		this.id = id;
		this.stateName = stateName;
		this.abilityName = abilityName;
	}
}
