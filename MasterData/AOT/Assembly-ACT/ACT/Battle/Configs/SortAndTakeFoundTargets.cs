using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("排序并截取已找到目标", "FindTargets", new string[] { "sort", "and", "take", "found", "targets" })]
public class SortAndTakeFoundTargets : BaseFindTargets
{
	public TargetResultComparer comparer;

	public int takeCount;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		if (comparer is DistanceComparer { axisPriority: not DistanceComparer.DistanceAxisPriority.None } distanceComparer)
		{
			distanceComparer.SetReferencePosition(referenceEntity.GetCompTransform().physicsPosition);
		}
		results.Sort(comparer);
		if (takeCount < results.Count)
		{
			results.RemoveRange(takeCount, results.Count - takeCount);
		}
	}
}
