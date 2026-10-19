namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能时", "Predicate", new string[] { "check", "ability", "on", "add", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityOnAdd : ConfigPredicate
{
	public string ability;

	public bool useTag;

	public bool useCustomTag;

	public BuffTag tag;

	public string customTag;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAddAbilityAdd evtAddAbilityAdd)
		{
			return CheckAbility(evtAddAbilityAdd.name, evtAddAbilityAdd.ability.config);
		}
		if (memory.evt is EvtAddAbilityAddTo evtAddAbilityAddTo)
		{
			return CheckAbility(evtAddAbilityAddTo.name, evtAddAbilityAddTo.ability.config);
		}
		return false;
	}

	private bool CheckAbility(string abilityName, ConfigAbility config)
	{
		if (useCustomTag)
		{
			return config?.HasCustomTag(customTag) ?? false;
		}
		if (!useTag)
		{
			return ability == abilityName;
		}
		if (config != null)
		{
			return config.buffTag.HasFlag(tag);
		}
		return false;
	}
}
