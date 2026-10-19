using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动态", "Predicate", new string[] { "check", "dynamic", "predicate", "condition" })]
public class CheckDynamicPredicate : ConfigPredicate
{
	public Condition condition;

	public string dynamicName;

	public float dynamicTargetValue;

	public bool checkOwner;

	public override bool Check(ActionMemory memory)
	{
		CompAbility component2;
		DynamicValue value2;
		if (checkOwner)
		{
			if (memory.owner.TryGetCompAbility(out CompAbility component) && component.vars.TryGetValue(dynamicName, out var value))
			{
				return condition switch
				{
					Condition.Greater => value.value > dynamicTargetValue, 
					Condition.Less => value.value < dynamicTargetValue, 
					Condition.Equal => Mathf.Approximately(value.value, dynamicTargetValue), 
					Condition.GreaterAndEqual => value.value >= dynamicTargetValue, 
					Condition.LessAndEqual => value.value <= dynamicTargetValue, 
					_ => false, 
				};
			}
		}
		else if (memory.target.entity.TryGetCompAbility(out component2) && component2.vars.TryGetValue(dynamicName, out value2))
		{
			return condition switch
			{
				Condition.Greater => value2.value > dynamicTargetValue, 
				Condition.Less => value2.value < dynamicTargetValue, 
				Condition.Equal => Mathf.Approximately(value2.value, dynamicTargetValue), 
				Condition.GreaterAndEqual => value2.value >= dynamicTargetValue, 
				Condition.LessAndEqual => value2.value <= dynamicTargetValue, 
				_ => false, 
			};
		}
		return false;
	}
}
