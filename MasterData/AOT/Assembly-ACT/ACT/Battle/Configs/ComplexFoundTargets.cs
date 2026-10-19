using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("组合已找到目标", "FindTargets", new string[] { "complex", "found", "targets" })]
public class ComplexFoundTargets : BaseFindTargets
{
	public BaseFindTargets[] baseFindTargets = new BaseFindTargets[3]
	{
		new ConfigFindRangeTargets(),
		new FilterFoundTargets(),
		new SortAndTakeFoundTargets()
	};

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		for (int i = 0; i < baseFindTargets.Length; i++)
		{
			baseFindTargets[i].FindTargets(referenceEntity, results);
		}
	}
}
