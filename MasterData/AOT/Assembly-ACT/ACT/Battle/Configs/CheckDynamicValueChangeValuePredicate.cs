using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动态值值", "Predicate", new string[] { "check", "dynamic", "value", "change", "predicate", "condition" })]
public class CheckDynamicValueChangeValuePredicate : ConfigPredicate
{
	public Condition condition;

	public bool percent;

	public float dynamicTargetValue;

	public bool signed;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtDynamicValueChange evtDynamicValueChange)
		{
			float num = 0f;
			if (percent)
			{
				num = (signed ? evtDynamicValueChange.changeValue : Mathf.Abs(evtDynamicValueChange.changeValue)) / evtDynamicValueChange.dynamicValue.max;
			}
			else
			{
				num = (signed ? evtDynamicValueChange.changeValue : Mathf.Abs(evtDynamicValueChange.changeValue));
			}
			return condition switch
			{
				Condition.Greater => num > dynamicTargetValue, 
				Condition.Less => num < dynamicTargetValue, 
				Condition.Equal => num == dynamicTargetValue, 
				Condition.GreaterAndEqual => num >= dynamicTargetValue, 
				Condition.LessAndEqual => num <= dynamicTargetValue, 
				_ => false, 
			};
		}
		return false;
	}
}
