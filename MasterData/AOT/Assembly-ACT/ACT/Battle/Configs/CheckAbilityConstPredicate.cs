using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能常量", "Predicate", new string[] { "check", "ability", "const", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityConstPredicate : ConfigPredicate
{
	public string constKey;

	public ConfigFunction<float> targetValue;

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		if (memory.ability == null || string.IsNullOrEmpty(constKey))
		{
			return false;
		}
		memory.ability.TryGetAbilityConst(constKey, out var value);
		float num = targetValue.Return(memory);
		return condition switch
		{
			Condition.Greater => value > num, 
			Condition.Less => value < num, 
			Condition.Equal => Mathf.Approximately(value, num), 
			Condition.GreaterAndEqual => value >= num, 
			Condition.LessAndEqual => value <= num, 
			_ => false, 
		};
	}
}
