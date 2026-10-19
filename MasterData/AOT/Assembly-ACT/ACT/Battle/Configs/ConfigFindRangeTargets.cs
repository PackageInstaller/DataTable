using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找范围目标", "FindTargets", new string[] { "find", "range", "targets" })]
public class ConfigFindRangeTargets : BaseFindTargetsByArea
{
	public TargetBounds targetBounds;

	[Tooltip("子弹和机关类敌人会用到")]
	public bool nonuseDirRot;

	public bool useTransPos;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		BaseFindTargetsByArea.FindBoundsTargets(referenceEntity, targetBounds, BattleConsts.hitMask, results, !nonuseDirRot, useTransPos);
	}
}
