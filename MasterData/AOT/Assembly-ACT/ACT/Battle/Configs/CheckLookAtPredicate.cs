using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断朝向", "Predicate", new string[] { "check", "lookat", "predicate", "condition" })]
public class CheckLookAtPredicate : ConfigPredicate
{
	public enum CheckLookAtType
	{
		useTarget,
		usePos
	}

	public CheckLookAtType checkLookAtType;

	public BaseFindTargets findTargetsCondition;

	public WhereTargets where;

	public ConfigFunction<Vector3> configFunctionPos;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		switch (checkLookAtType)
		{
		case CheckLookAtType.useTarget:
		{
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			findTargetsCondition.FindTargets(memory.target.entity, list);
			where.FindTargets(list, memory.owner);
			CompTransform compTransform = memory.target.entity.GetCompTransform();
			bool flag = memory.target.entity.IsFaceLeft();
			foreach (FindTargetResult item in list)
			{
				Vector3 physicsPosition = item.entity.GetCompTransform().physicsPosition;
				if (compTransform.physicsPosition.x < physicsPosition.x != flag)
				{
					result = true;
					break;
				}
			}
			ListPool<FindTargetResult>.Release(list);
			break;
		}
		case CheckLookAtType.usePos:
		{
			Vector3 vector = configFunctionPos.Return(memory);
			if (memory.target.entity.GetCompTransform().physicsPosition.x < vector.x != memory.target.entity.IsFaceLeft())
			{
				result = true;
			}
			break;
		}
		}
		return result;
	}
}
