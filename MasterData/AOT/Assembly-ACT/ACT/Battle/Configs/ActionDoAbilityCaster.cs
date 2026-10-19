using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行技能施法者", "Action", new string[] { "do", "ability", "caster", "skill", "cd" })]
public class ActionDoAbilityCaster : ConfigAction
{
	public ConfigAction[] actions;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.caster), memory.evt, memory.ability, actions);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}
}
