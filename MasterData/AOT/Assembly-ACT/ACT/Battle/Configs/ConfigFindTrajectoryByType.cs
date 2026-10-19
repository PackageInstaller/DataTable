using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找轨迹按类型", "FindTargets", new string[] { "find", "trajectory", "by", "type" })]
public class ConfigFindTrajectoryByType : BaseFindTargets
{
	public AbilityEntityType entityType;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		foreach (Entity item in Singleton<GameManager>.instance.ecsManager.systemTrajectory.MajorFilter)
		{
			if (item.TryGetCompProduct(out CompProduct component) && component.AbilityEntityType == entityType)
			{
				results.Add(FindTargetResult.EntityOnly(item));
			}
		}
	}
}
