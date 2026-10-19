using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断拥有者类型", "Predicate", new string[] { "check", "owner", "type", "is", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckOwnerTypeIs : ConfigPredicate
{
	public EntityType checkType;

	public override bool Check(ActionMemory memory)
	{
		return memory.owner.GetEntityType() == checkType;
	}
}
