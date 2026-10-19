using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找轨迹跟踪实体", "FindTargets", new string[] { "find", "trajectory", "track", "entity" })]
public class ConfigFindTrajectoryTrackEntity : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		if (referenceEntity.GetCompAim().aimEntity.IsValid)
		{
			results.Add(FindTargetResult.EntityOnly(referenceEntity.GetCompAim().aimEntity));
		}
	}
}
