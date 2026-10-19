using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能时间剩余", "Predicate", new string[] { "check", "ability", "time", "left", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityTimeLeftPredicate : ConfigPredicate
{
	public string name;

	public ConfigFunction<float> floatValue = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		bool flag = false;
		if (memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			flag = component.HasAbility(name);
		}
		if (flag)
		{
			if (component.GetAbilityByName(name).config.durationType == DurationType.Infinite)
			{
				return false;
			}
			float val = component.GetAbilityByName(name).Duration.GetVal(0);
			switch (condition)
			{
			case Condition.Less:
			case Condition.LessAndEqual:
				return val < floatValue.Return(memory);
			case Condition.Greater:
			case Condition.GreaterAndEqual:
				return val > floatValue.Return(memory);
			case Condition.Equal:
				return Mathf.Approximately(val, floatValue.Return(memory));
			}
		}
		return flag;
	}
}
