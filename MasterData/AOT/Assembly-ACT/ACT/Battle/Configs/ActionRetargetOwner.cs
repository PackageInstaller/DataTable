using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("重定向拥有者", "Action", new string[] { "retarget", "owner", "target", "aim" })]
public class ActionRetargetOwner : ConfigAction
{
	public ConfigAction[] actions;

	public override void Do(ActionMemory memory)
	{
		SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, actions);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}
}
