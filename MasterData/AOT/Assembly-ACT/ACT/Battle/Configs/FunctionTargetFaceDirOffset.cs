using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class FunctionTargetFaceDirOffset : ConfigFunction<Vector3>
{
	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (entity.IsValid && entity.TryGetCompTransform(out CompTransform component))
		{
			int num = ((component.FaceDir != FaceDir.Left) ? 1 : (-1));
			return new Vector3(component.physicsPosition.x + (float)num, 0f, 0f);
		}
		return default;
	}
}
