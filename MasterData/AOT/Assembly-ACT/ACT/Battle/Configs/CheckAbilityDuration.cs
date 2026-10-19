using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能持续时间", "Predicate", new string[] { "check", "ability", "duration", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityDuration : ConfigPredicate
{
	public string name;

	public Condition condition;

	public ConfigFunction<float> targetValue;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			Ability abilityByName = component.GetAbilityByName(name);
			if (abilityByName != null)
			{
				int stack = abilityByName.stack;
				if (stack <= 0)
				{
					return false;
				}
				float num = targetValue.Return(memory);
				float val = abilityByName.Duration.GetVal(stack - 1);
				return condition switch
				{
					Condition.Greater => val > num, 
					Condition.Less => val < num, 
					Condition.Equal => Mathf.Approximately(val, num), 
					Condition.GreaterAndEqual => val >= num, 
					Condition.LessAndEqual => val <= num, 
					_ => false, 
				};
			}
		}
		return false;
	}
}
