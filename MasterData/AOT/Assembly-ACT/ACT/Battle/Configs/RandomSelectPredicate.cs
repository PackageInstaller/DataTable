using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断选择", "Predicate", new string[] { "random", "select", "predicate", "check", "condition" })]
public class RandomSelectPredicate : ConfigPredicate
{
	public ConfigPredicate truePredicate;

	public ConfigPredicate falsePredicate;

	public ConfigFunction<float> rate;

	public override bool Check(ActionMemory memory)
	{
		if (truePredicate.Inverse ? truePredicate.Check(memory) : (!truePredicate.Check(memory)))
		{
			return false;
		}
		if (falsePredicate.Inverse ? falsePredicate.Check(memory) : (!falsePredicate.Check(memory)))
		{
			return true;
		}
		return Random.Range(0f, 1f) < rate.Return(memory);
	}
}
