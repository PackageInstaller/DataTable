using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置产物施法者", "Action", new string[] { "set", "product", "caster" })]
public class ActionSetProductCaster : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.owner.IsValid && memory.owner.TryGetCompProduct(out CompProduct component))
		{
			component.caster = memory.target.entity;
		}
	}
}
