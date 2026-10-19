using System;

namespace ACT.Config;

[Serializable]
public class EnvironmentEffect
{
	public readonly int id;

	public readonly int effectDes;

	public readonly int scope;

	public readonly int skillId;

	public readonly string[] abilities = new string[0];

	public readonly int[] rules = new int[0];

	public readonly int tag;

	public EnvironmentEffect(int id, int effectDes, int scope, int skillId, string[] abilities, int[] rules, int tag)
	{
		this.id = id;
		this.effectDes = effectDes;
		this.scope = scope;
		this.skillId = skillId;
		this.abilities = abilities;
		this.rules = rules;
		this.tag = tag;
	}
}
