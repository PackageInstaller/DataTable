using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("重定向施法者", "Action", new string[] { "retarget", "caster", "target", "aim" })]
public class ActionRetargetCaster : ConfigAction
{
	public ConfigAction[] actions;

	public override void Do(ActionMemory memory)
	{
		SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.caster), memory.evt, memory.ability, actions);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}
}
