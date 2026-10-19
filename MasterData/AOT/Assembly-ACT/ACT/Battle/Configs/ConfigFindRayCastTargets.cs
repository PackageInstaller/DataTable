using System.Collections.Generic;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找射线检测目标", "FindTargets", new string[] { "find", "raycast", "targets" })]
public class ConfigFindRayCastTargets : BaseFindTargetsByRayCast
{
	[Tooltip("投射的射线的粗细(半径)")]
	public float radius;

	[Tooltip("投射的射线的粗细(半径)")]
	public float enviromentRadius;

	[Tooltip("保存射线信息到rayHitName上给特效使用,如果不需要就不填")]
	public string rayHitName;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get();
		float num = distance;
		var (vector, _, vector2, anchor) = GetEmissionPointInfo(referenceEntity);
		if (Physics.SphereCast(vector, enviromentRadius, vector2, out var hitInfo, num, BattleConsts.enviromentMask))
		{
			num = hitInfo.distance;
		}
		Vector3 vector3 = vector + vector2 * num;
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		int num2 = Physics.OverlapCapsuleNonAlloc(vector, vector3, radius, cacheColliders, BattleConsts.hitMask);
		for (int i = 0; i < num2; i++)
		{
			BaseFindTargetsByArea.AddTargetByCollider(anchor, cacheColliders[i], bSet);
		}
		PhysicsUtility.Release(cacheColliders);
		foreach (FindTargetResult item in bSet)
		{
			results.Add(item);
		}
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
		if (!string.IsNullOrEmpty(rayHitName))
		{
			referenceEntity.GetCompEffect().rayEffectInfos[rayHitName] = new RayHitEffectInfo
			{
				startPos = vector,
				endPos = vector3
			};
		}
	}
}
