using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找自适应区域目标", "FindTargets", new string[] { "find", "flexible", "area", "targets" })]
public class ConfigFindFlexibleAreaTargets : BaseFindTargetsByArea
{
	public ConfigFindRangeTargets configFindRange = new ConfigFindRangeTargets();

	public TargetBounds startBounds;

	public TargetBounds endBounds;

	public Vector2 flexibleDuration;

	public bool useCurve;

	public AnimationCurve curve;

	public void ChangeTargetRange(float time)
	{
		if (useCurve)
		{
			time = curve.Evaluate(time);
		}
		configFindRange.targetBounds.bounds.center = Vector3.Lerp(startBounds.bounds.center, endBounds.bounds.center, time);
		configFindRange.targetBounds.bounds.extents = Vector3.Lerp(startBounds.bounds.extents, endBounds.bounds.extents, time);
		configFindRange.targetBounds.localEulerAngle = Vector3.Slerp(startBounds.localEulerAngle, endBounds.localEulerAngle, time);
		configFindRange.targetBounds.anchor = Vector3.Lerp(startBounds.anchor, endBounds.anchor, time);
	}

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		configFindRange.FindTargets(referenceEntity, results);
	}
}
