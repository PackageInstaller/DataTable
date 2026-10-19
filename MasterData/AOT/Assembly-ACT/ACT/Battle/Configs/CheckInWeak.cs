using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断中弱点", "Predicate", new string[] { "check", "in", "weak", "predicate", "condition" })]
public class CheckInWeak : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.GetCompAbility().IsWeak;
	}
}
