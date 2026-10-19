namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能Cooldown", "Predicate", new string[] { "check", "ability", "cooldown", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityCooldown : ConfigPredicate
{
	public enum CooldownType
	{
		autoSetCD,
		custo1SetCD
	}

	public CooldownType cooldownType;

	public override bool Check(ActionMemory memory)
	{
		if (memory.ability.config.abilityCooldown != null)
		{
			bool flag = memory.ability.cooldownTimestamp == 0f || memory.ability.time - memory.ability.cooldownTimestamp > memory.ability.config.abilityCooldown.Return(memory);
			if (cooldownType == CooldownType.autoSetCD && flag)
			{
				memory.ability.cooldownTimestamp = memory.ability.time;
			}
			return flag;
		}
		return true;
	}
}
