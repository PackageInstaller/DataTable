using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找瞄准实体", "FindTargets", new string[] { "find", "aim", "entity" })]
public class ConfigFindAimEntity : BaseFindTargets
{
	[Tooltip("选择距离参考实体最近的有效可瞄准部位；没有合适部位时仍返回实体。追踪弹道需关闭以AttachPoint为目标。")]
	public bool useBodyPart;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		Entity aimEntity = referenceEntity.GetCompAim().aimEntity;
		if (!aimEntity.IsValid)
		{
			return;
		}
		FindTargetResult item = FindTargetResult.EntityOnly(aimEntity);
		if (useBodyPart)
		{
			MonoEntity mono = aimEntity.GetMono();
			if (mono != null && mono.bodyParts != null)
			{
				Vector3 physicsPosition = referenceEntity.GetCompTransform().physicsPosition;
				float num = float.PositiveInfinity;
				MonoBodyPart[] bodyParts = mono.bodyParts;
				for (int i = 0; i < bodyParts.Length; i++)
				{
					MonoBodyPart monoBodyPart = bodyParts[i];
					if (!(monoBodyPart == null) && monoBodyPart.isActiveAndEnabled && monoBodyPart.aimAble && !monoBodyPart.parryOnly && monoBodyPart.index == i + 1 && !(monoBodyPart.entity != aimEntity) && !(monoBodyPart.myCollider == null) && monoBodyPart.myCollider.enabled)
					{
						var (flag, findTargetResult) = monoBodyPart.FindResult(physicsPosition, Vector3.zero);
						if (flag && !(findTargetResult.sqrDis >= num))
						{
							num = findTargetResult.sqrDis;
							item = findTargetResult;
						}
					}
				}
			}
		}
		results.Add(item);
	}
}
