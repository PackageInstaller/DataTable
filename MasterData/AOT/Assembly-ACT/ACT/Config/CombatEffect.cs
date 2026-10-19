using System;

namespace ACT.Config;

[Serializable]
public class CombatEffect
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly string abilityName = "";

	public readonly float[] paras = new float[0];

	public readonly int maxTriggerCount;

	public CombatEffect(int id, int name, int description, string abilityName, float[] paras, int maxTriggerCount)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.abilityName = abilityName;
		this.paras = paras;
		this.maxTriggerCount = maxTriggerCount;
	}
}
