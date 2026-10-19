using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置实体变量", "Action", new string[] { "set", "entity", "var" })]
public class ActionSetEntityVar : ConfigAction
{
	public string name;

	public ConfigFunction<EntityId> value;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			EntityId entityId = value?.Return(memory) ?? EntityId.Invalid;
			component.SetEntityVar(name, entityId);
		}
	}
}
