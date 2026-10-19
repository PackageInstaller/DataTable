using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找自身", "FindTargets", new string[] { "find", "self" })]
public class ConfigFindSelf : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		results.Add(FindTargetResult.EntityOnly(referenceEntity));
	}
}
