using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标按数量", "FindTargets", new string[] { "check", "find", "target", "by", "count" })]
public class CheckFindTargetByCount : BaseFindTargets
{
	public int count;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		if (results.Count != count)
		{
			results.Clear();
		}
	}
}
