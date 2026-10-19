using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找施法者", "FindTargets", new string[] { "cofnig", "find", "caster" })]
public class CofnigFindCaster : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		results.Add(FindTargetResult.EntityOnly(referenceEntity.GetCaster()));
	}
}
