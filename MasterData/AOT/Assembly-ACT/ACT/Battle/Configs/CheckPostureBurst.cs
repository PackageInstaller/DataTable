using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断架势爆发", "Predicate", new string[] { "check", "posture", "burst", "predicate", "condition" })]
public class CheckPostureBurst : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.GetCompAbility().IsPostureBurst;
	}
}
