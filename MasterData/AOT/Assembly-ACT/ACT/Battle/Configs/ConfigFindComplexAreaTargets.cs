using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找复合区域目标", "FindTargets", new string[] { "find", "complex", "area", "targets" })]
public class ConfigFindComplexAreaTargets : BaseFindTargetsByArea
{
	public BaseFindTargetsByArea[] findTargetsByArea;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		BaseFindTargetsByArea[] array = findTargetsByArea;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].FindTargets(referenceEntity, results);
		}
	}
}
