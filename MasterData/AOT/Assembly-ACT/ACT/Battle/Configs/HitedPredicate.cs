using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断受击", "Predicate", new string[] { "hited", "predicate", "check", "condition" })]
public class HitedPredicate : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.owner.GetCompAbility().IsHited(memory.target, null);
	}
}
