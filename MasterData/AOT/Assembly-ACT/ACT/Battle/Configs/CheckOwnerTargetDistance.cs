using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断拥有者目标距离", "Predicate", new string[] { "check", "owner", "target", "distance", "retarget", "aim", "predicate", "condition" })]
public class CheckOwnerTargetDistance : ConfigPredicate
{
	public bool redirectAttacker;

	public Condition condition;

	public int targetValue;

	public bool useFunctionValue;

	public ConfigFunction<float> targetValueFunc = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	private float distance;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			Entity entity = getAttackData.GetAttackData().attackee;
			if (redirectAttacker)
			{
				entity = getAttackData.GetAttackData().attacker;
			}
			distance = Vector3.Distance(entity.GetCompTransform().physicsPosition, memory.owner.GetCompTransform().physicsPosition);
		}
		if (useFunctionValue)
		{
			targetValue = (int)targetValueFunc.Return(memory);
		}
		return ConditionCheck(distance);
	}

	public bool ConditionCheck(float value)
	{
		return condition switch
		{
			Condition.Greater => value > (float)targetValue, 
			Condition.Less => value < (float)targetValue, 
			Condition.Equal => value == (float)targetValue, 
			Condition.GreaterAndEqual => value >= (float)targetValue, 
			Condition.LessAndEqual => value <= (float)targetValue, 
			_ => false, 
		};
	}
}
