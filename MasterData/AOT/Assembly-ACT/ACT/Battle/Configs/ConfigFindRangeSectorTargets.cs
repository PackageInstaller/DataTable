using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找范围扇形目标", "FindTargets", new string[] { "find", "range", "sector", "targets" })]
public class ConfigFindRangeSectorTargets : BaseFindTargetsByArea
{
	public TargetSectorBounds targetSectorBounds;

	[Tooltip("子弹和机关类敌人会用到")]
	public bool nonuseDirRot;

	public bool useTransPos;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		bool needDirRot = !nonuseDirRot;
		BaseFindTargetsByArea.FindSectorBoundsTargets(referenceEntity, ref targetSectorBounds, BattleConsts.hitMask, results, needDirRot, useTransPos);
	}

	private void FilterResultsWithAccuracyCollideCheck(Entity referenceEntity, ref TargetSectorBounds targetSectorBounds, List<FindTargetResult> results, List<Vector3> debugOutput = null)
	{
		if (results.Count <= 0)
		{
			return;
		}
		Quaternion referenceEntityFaceDirRot = BaseFindTargetsByArea.GetReferenceEntityFaceDirRot(referenceEntity);
		Vector3 pos = referenceEntity.GetCompTransform().physicsPosition + referenceEntityFaceDirRot * targetSectorBounds.center;
		Quaternion q = referenceEntityFaceDirRot * Quaternion.Euler(targetSectorBounds.localEulerAngle);
		Matrix4x4 sectorTRS = Matrix4x4.TRS(pos, q, Vector3.one);
		for (int num = results.Count - 1; num >= 0; num--)
		{
			if (results[num].Collider is CapsuleCollider capsule)
			{
				if (!GeometryIntersectDetect.CheckCylinderSectorToCapsule(ref sectorTRS, ref targetSectorBounds, capsule, debugOutput))
				{
					results.RemoveAt(num);
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[ConfigFindRangeSectorTargets] AccuracyCheck only support CapsuleCollider, current is:" + results[num].Collider.GetType().Name);
			}
		}
	}
}
