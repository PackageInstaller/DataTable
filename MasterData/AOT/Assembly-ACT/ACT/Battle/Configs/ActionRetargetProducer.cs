using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("重定向生产者", "Action", new string[] { "retarget", "producer", "target", "aim" })]
public class ActionRetargetProducer : ConfigAction
{
	public ConfigAction[] actions;

	public override void Do(ActionMemory memory)
	{
		CompProduct compProduct = memory.target.entity.GetCompProduct();
		if (compProduct != null)
		{
			Entity productOwner = compProduct.productOwner;
			if (productOwner.IsValid)
			{
				SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(compProduct.productOwner), memory.evt, memory.ability, actions);
			}
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}
}
