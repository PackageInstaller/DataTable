namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能时Buff类型", "Predicate", new string[] { "check", "ability", "on", "add", "buff", "type", "state", "status", "tag", "predicate" })]
public class CheckAbilityOnAddBuffType : ConfigPredicate
{
	public BuffType type;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAddAbilityAdd evtAddAbilityAdd)
		{
			ConfigAbility config = evtAddAbilityAdd.ability.config;
			return type == config.buffType;
		}
		if (memory.evt is EvtAddAbilityAddTo evtAddAbilityAddTo)
		{
			ConfigAbility config2 = evtAddAbilityAddTo.ability.config;
			return type == config2.buffType;
		}
		return false;
	}
}
