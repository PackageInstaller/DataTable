using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体四元数", "Function", new string[] { "entity", "quaternion", "vector", "position", "rotation" })]
public class FunctionEntityQuaternion : ConfigFunction<Quaternion>
{
	public enum EntityQuaternionType
	{
		FaceRotation,
		Rotation
	}

	public BaseFindTargets baseFindTargets;

	public EntityQuaternionType entityQuaternionType;

	protected override Quaternion Evaluate(ActionMemory memory)
	{
		Quaternion result = Quaternion.identity;
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		baseFindTargets.FindTargets(memory.owner, list);
		if (list.Count > 0)
		{
			Entity entity = list[0].entity;
			if (entity.IsValid)
			{
				switch (entityQuaternionType)
				{
				case EntityQuaternionType.FaceRotation:
					result = entity.GetCompTransform().FaceRotation;
					break;
				case EntityQuaternionType.Rotation:
					result = entity.GetCompTransform().rotation;
					break;
				}
			}
		}
		ListPool<FindTargetResult>.Release(list);
		return result;
	}
}
