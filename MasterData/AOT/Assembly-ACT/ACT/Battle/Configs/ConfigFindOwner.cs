using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找拥有者", "FindTargets", new string[] { "find", "owner" })]
public class ConfigFindOwner : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		results.Add(FindTargetResult.EntityOnly(referenceEntity.GetCaster()));
	}
}
