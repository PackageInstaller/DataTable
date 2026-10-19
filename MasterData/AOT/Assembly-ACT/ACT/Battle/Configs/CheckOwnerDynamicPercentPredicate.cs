using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断拥有者动态Percent", "Predicate", new string[] { "check", "owner", "dynamic", "percent", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckOwnerDynamicPercentPredicate : ConfigPredicate
{
	public string dynamicName;

	public Condition condition;

	public float dynamicTargetValue;

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component) || !component.vars.TryGetValue(dynamicName, out var value))
		{
			return false;
		}
		float num = value.value / value.max;
		return condition switch
		{
			Condition.Greater => num > dynamicTargetValue, 
			Condition.Less => num < dynamicTargetValue, 
			Condition.Equal => Mathf.Approximately(num, dynamicTargetValue), 
			Condition.GreaterAndEqual => num >= dynamicTargetValue, 
			Condition.LessAndEqual => num <= dynamicTargetValue, 
			_ => false, 
		};
	}
}
