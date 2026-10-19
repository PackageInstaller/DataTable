using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找矩形中矩形目标", "FindTargets", new string[] { "find", "rect", "in", "targets" })]
public class ConfigFindRectInRectTargets : BaseFindTargetsByArea
{
	public TargetBounds bounds1;

	public TargetBounds bounds2;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		BaseFindTargetsByArea.FindBoundsTargets(referenceEntity, bounds1, BattleConsts.hitMask, list);
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num].entity == referenceEntity)
			{
				list.Remove(list[num]);
			}
		}
		if (list.Count > 0)
		{
			DistanceComparer distanceComparer = new DistanceComparer();
			list.Sort(distanceComparer.Compare);
			BaseFindTargetsByArea.FindBoundsTargets(referenceEntity.GetCompPhysics().faceDirRot, list[0].entity.GetCompTransform().physicsPosition, bounds2, BattleConsts.hitMask, results);
		}
		ListPool<FindTargetResult>.Release(list);
	}
}
