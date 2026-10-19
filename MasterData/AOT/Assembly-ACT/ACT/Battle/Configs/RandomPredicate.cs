using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断随机", "Predicate", new string[] { "random", "predicate", "check", "condition" })]
public class RandomPredicate : ConfigPredicate
{
	[Range(0f, 1f)]
	public float rate;

	public override bool Check(ActionMemory memory)
	{
		return (float)Random.Range(0, 1) < rate;
	}
}
