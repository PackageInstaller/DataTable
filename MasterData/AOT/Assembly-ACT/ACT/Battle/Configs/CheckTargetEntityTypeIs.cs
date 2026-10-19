using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标实体类型", "Predicate", new string[] { "check", "target", "entity", "type", "is", "retarget", "aim", "predicate", "condition" })]
public class CheckTargetEntityTypeIs : ConfigPredicate
{
	public EntityType checkEntityType;

	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.GetEntityType() == checkEntityType;
	}
}
