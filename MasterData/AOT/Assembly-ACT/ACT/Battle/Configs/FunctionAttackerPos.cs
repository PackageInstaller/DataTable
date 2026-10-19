using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取攻击者位置", "Function", new string[] { "attacker", "pos", "vector", "position", "rotation", "quaternion" })]
public class FunctionAttackerPos : ConfigFunction<Vector3>
{
	protected override Vector3 Evaluate(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			Entity attacker = getAttackData.GetAttackData().attacker;
			if (attacker.IsValid)
			{
				return attacker.GetCompTransform()?.physicsPosition ?? attacker.GetModelTrans().position;
			}
		}
		return default;
	}
}
