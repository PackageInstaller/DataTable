using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能实体类型", "Predicate", new string[] { "check", "ability", "entity", "type", "is", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityEntityTypeIs : ConfigPredicate
{
	public AbilityEntityType entityType;

	public override bool Check(ActionMemory memory)
	{
		CompProduct compProduct = memory.target.entity.GetCompProduct();
		if (compProduct != null && compProduct.AbilityEntityType == entityType)
		{
			return true;
		}
		return false;
	}
}
