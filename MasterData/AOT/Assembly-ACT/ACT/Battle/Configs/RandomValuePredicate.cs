using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断值", "Predicate", new string[] { "random", "value", "predicate", "check", "condition" })]
public class RandomValuePredicate : ConfigPredicate
{
	public ConfigFunction<float> rate;

	public override bool Check(ActionMemory memory)
	{
		return Random.Range(0f, 1f) < rate.Return(memory);
	}
}
