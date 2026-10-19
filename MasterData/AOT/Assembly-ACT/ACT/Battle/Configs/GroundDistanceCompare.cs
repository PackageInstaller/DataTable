using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断地面距离比较", "Predicate", new string[] { "ground", "distance", "compare", "vector", "position", "rotation", "quaternion", "predicate", "check", "condition" })]
public class GroundDistanceCompare : ConfigPredicate
{
	public ConfigFunction<float> maxGroundDistance = new ConstFloat
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
		float num = 0f;
		if (memory.target.entity.GetEntityType() == EntityType.Trajectory)
		{
			Vector3 down = Vector3.down;
			if (Physics.Raycast(new Ray(memory.target.entity.GetCompTransform().physicsPosition, down), out var hitInfo, 20f, BattleConsts.enviromentMask))
			{
				num = hitInfo.distance;
			}
		}
		else
		{
			num = memory.target.entity.GetMotionFloat("GroundDistance");
		}
		float num2 = maxGroundDistance.Return(memory);
		return condition switch
		{
			Condition.Greater => num > num2, 
			Condition.Less => num < num2, 
			Condition.Equal => Mathf.Approximately(num, num2), 
			Condition.GreaterAndEqual => (float)(int)num >= num2, 
			Condition.LessAndEqual => (float)(int)num <= num2, 
			_ => false, 
		};
	}
}
