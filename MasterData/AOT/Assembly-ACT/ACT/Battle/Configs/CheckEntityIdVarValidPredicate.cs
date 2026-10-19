using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体变量Valid", "Predicate", new string[] { "check", "entity", "id", "var", "valid", "predicate", "condition" })]
public class CheckEntityIdVarValidPredicate : ConfigPredicate
{
	public string name;

	public bool checkOwner;

	public override bool Check(ActionMemory memory)
	{
		if (!(checkOwner ? memory.owner : memory.target.entity).TryGetCompAbility(out CompAbility component) || !component.TryGetEntityVar(name, out var value) || value == EntityId.Invalid)
		{
			return false;
		}
		return GameManager.entities.GetEntity(value).IsValid;
	}
}
