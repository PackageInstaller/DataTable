using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("判断架势当前值", "Predicate", new string[] { "check", "posture", "current", "value", "predicate", "condition" })]
public class CheckPostureCurrentValue : ConfigPredicate
{
	public ConfigFunction<float> posturePercent = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.IsBattleBehaveNotCharacter())
		{
			CompAbility compAbility = memory.target.entity.GetCompAbility();
			int num = compAbility.posture / compAbility.maxPosture;
			float num2 = posturePercent.Return(memory);
			bool flag = (float)num > num2;
			switch (condition)
			{
			case Condition.Less:
			case Condition.LessAndEqual:
				flag = (float)num < num2;
				break;
			case Condition.Equal:
				flag = Mathf.Approximately(num, num2);
				break;
			}
			if (flag)
			{
				return true;
			}
			return false;
		}
		return false;
	}
}
