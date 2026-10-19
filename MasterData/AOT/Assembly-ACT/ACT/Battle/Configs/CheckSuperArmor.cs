using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断SuperArmor", "Predicate", new string[] { "check", "super", "armor", "predicate", "condition" })]
public class CheckSuperArmor : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.IsSuperArmor();
	}
}
