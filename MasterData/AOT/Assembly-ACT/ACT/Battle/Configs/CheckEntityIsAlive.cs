using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体存活", "Predicate", new string[] { "check", "entity", "is", "alive", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityIsAlive : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.IsLogicAvailable();
	}
}
