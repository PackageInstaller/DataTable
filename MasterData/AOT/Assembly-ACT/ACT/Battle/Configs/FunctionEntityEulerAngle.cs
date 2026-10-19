using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体欧拉角", "Function", new string[] { "entity", "euler", "angle", "vector", "position", "rotation", "quaternion" })]
public class FunctionEntityEulerAngle : ConfigFunction<Vector3>
{
	[Tooltip("搜索目标,只会选中第一个结果")]
	public BaseFindTargets findTargets;

	[Tooltip("筛选的条件，可空（空表示不筛选）。")]
	public ConfigPredicate predicate = new WhereTargetsPredicate();

	public bool useFaceRotation;

	[Tooltip("是否使用挂点的位置")]
	public bool useAttachPoint;

	[Tooltip("挂点")]
	public string attachPoint = BattleConsts.AIM_ATTACH_POINT;

	[Tooltip("如果没找到目标就使用这个结果")]
	public ConfigFunction<Vector3> fallback;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		findTargets.FindTargets(memory.owner, list);
		if (predicate != null)
		{
			BaseFindTargets.Where(memory.owner, list, predicate);
		}
		if (list.Count > 0)
		{
			Entity entity = list[0].entity;
			ListPool<FindTargetResult>.Release(list);
			if (!useAttachPoint)
			{
				if (!useFaceRotation)
				{
					return entity.GetCompTransform().rotation.eulerAngles;
				}
				return entity.GetCompTransform().FaceRotation.eulerAngles;
			}
			return entity.GetMono().GetAttachPoint(attachPoint).eulerAngles;
		}
		ListPool<FindTargetResult>.Release(list);
		return fallback?.Return(memory) ?? memory.owner.GetCompTransform().rotation.eulerAngles;
	}
}
