using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Be攻击", "Predicate", new string[] { "check", "can", "be", "attack", "predicate", "condition" })]
public class CheckCanBeAttack : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return !memory.target.entity.CantBeAttack();
	}
}
