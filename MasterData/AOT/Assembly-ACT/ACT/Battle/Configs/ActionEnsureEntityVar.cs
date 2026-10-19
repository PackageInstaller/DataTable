using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("确保实体变量", "Action", new string[] { "ensure", "entity", "var" })]
public class ActionEnsureEntityVar : ConfigAction
{
	public string name;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAbility(out CompAbility component) && !component.HasEntityVar(name))
		{
			component.SetEntityVar(name, EntityId.Invalid);
		}
	}
}
