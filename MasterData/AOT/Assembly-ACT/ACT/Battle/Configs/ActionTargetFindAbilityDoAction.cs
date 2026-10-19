using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行目标技能", "Action", new string[] { "target", "find", "ability", "do", "search", "retarget", "aim" })]
public class ActionTargetFindAbilityDoAction : ConfigAction
{
	public string ability;

	public ConfigAction[] onTrue;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAbility(out CompAbility component) && component.TryGetAbility(ability, includeAdd: false, out var ab))
		{
			SystemAbility.DoActions(new ActionMemory(memory.owner, memory.target.entity, memory.target, null, ab), onTrue);
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onTrue, ab);
	}
}
