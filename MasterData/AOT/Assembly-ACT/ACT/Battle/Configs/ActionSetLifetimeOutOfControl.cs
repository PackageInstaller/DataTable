using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置生命周期外的控制", "Action", new string[] { "set", "lifetime", "out", "of", "control", "state", "status", "tag" })]
public class ActionSetLifetimeOutOfControl : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompProduct(out CompProduct component))
		{
			component.productLifeTimeMode = ProductLifeTimeMode.outOfContorl;
		}
	}
}
