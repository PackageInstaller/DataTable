using System.Collections.Generic;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找武器区域目标", "FindTargets", new string[] { "find", "weapon", "area", "targets" })]
public class ConfigFindWeaponAreaTargets : BaseFindTargetsByArea
{
	public string weaponAreaName;

	[Tooltip("如果武器区域命中的是格挡专用部位，则不加入结果列表")]
	public bool ignoreParryPart;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		WeaponPart weaponPart = referenceEntity.GetMono().GetWeaponPart(weaponAreaName);
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get(results.Count);
		MonoWeaponPart[] monoWeaponParts = weaponPart.monoWeaponParts;
		foreach (MonoWeaponPart monoWeaponPart in monoWeaponParts)
		{
			Vector3 center = monoWeaponPart.myCollider.bounds.center;
			for (int num = monoWeaponPart.touches.Count - 1; num >= 0; num--)
			{
				Collider collider = monoWeaponPart.touches[num];
				if (collider == null)
				{
					monoWeaponPart.touches.Remove(collider);
				}
				else
				{
					(bool, FindTargetResult) result = BaseFindTargetsByArea.GetResult(center, collider, monoWeaponPart.forward);
					bool item = result.Item1;
					FindTargetResult item2 = result.Item2;
					bool flag = ignoreParryPart && item2.IsParryOnlyBodyPart;
					if (item && !flag)
					{
						BaseFindTargetsByArea.AddTarget(item2, bSet);
					}
				}
			}
		}
		foreach (FindTargetResult item3 in bSet)
		{
			results.Add(item3);
		}
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
	}
}
