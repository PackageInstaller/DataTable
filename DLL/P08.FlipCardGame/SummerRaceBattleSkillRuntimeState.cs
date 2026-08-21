using System;

[Serializable]
public sealed class SummerRaceBattleSkillRuntimeState
{
	public int slotIndex;

	public string slotType = string.Empty;

	public string label = string.Empty;

	public float cooldownRemaining;

	public float cooldownTotal;

	public float overloadRemaining;

	public float overloadTotal;

	public float activeRemaining;

	public float activeTotal;

	public float energyCost;

	public float overloadEnergyCost;

	public bool isReady;

	public bool isOverloaded;

	public bool canUse;

	public bool canOverload;

	public bool inputBlocked;

	public SummerRaceBattleSkillRuntimeState Clone()
	{
		return (SummerRaceBattleSkillRuntimeState)MemberwiseClone();
	}
}
