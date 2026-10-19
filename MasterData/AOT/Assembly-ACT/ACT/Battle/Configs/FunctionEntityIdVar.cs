using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体变量ID", "Function", new string[] { "entity", "id", "var", "target", "owner", "caster" })]
public class FunctionEntityIdVar : ConfigFunction<EntityId>
{
	public string name;

	protected override EntityId Evaluate(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component) || !component.TryGetEntityVar(name, out var value))
		{
			return EntityId.Invalid;
		}
		return value;
	}
}
