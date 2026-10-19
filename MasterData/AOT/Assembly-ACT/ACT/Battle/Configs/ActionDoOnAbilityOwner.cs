using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行时技能拥有者", "Action", new string[] { "do", "on", "ability", "owner", "skill", "cd" })]
public class ActionDoOnAbilityOwner : ConfigAction
{
	public ConfigAction[] actions;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability, actions);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}
}
