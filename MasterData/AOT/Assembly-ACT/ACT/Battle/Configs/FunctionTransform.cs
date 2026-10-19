using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取变换", "Function", new string[] { "transform", "value", "float", "int" })]
public class FunctionTransform : ConfigFunction<Transform>
{
	public BaseFindTargets findTargets;

	public ConfigPredicate predicate = new WhereTargetsPredicate();

	public PosSourceType endPosType;

	public string attachPointName;

	public ConfigFunction<Transform> fallback;

	protected override Transform Evaluate(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		findTargets.FindTargets(memory.owner, list);
		if (predicate != null)
		{
			BaseFindTargets.Where(memory.owner, list, predicate);
		}
		if (list.Count > 0)
		{
			_ = list[0];
			Entity entity = list[0].entity;
			ListPool<FindTargetResult>.Release(list);
			Transform transform = null;
			switch (endPosType)
			{
			case PosSourceType.wrapFootPos:
				transform = entity.GetRootTransform();
				break;
			case PosSourceType.WrapHeadPos:
				transform = entity.GetRootTransform();
				break;
			case PosSourceType.BodyNear:
				transform = entity.GetRootTransform();
				break;
			case PosSourceType.WaistPos:
				transform = entity.GetMono().GetAttachPoint(BattleConsts.AIM_ATTACH_POINT);
				break;
			case PosSourceType.ExtraAttachPos:
				transform = entity.GetMono().GetAttachPoint(attachPointName);
				break;
			case PosSourceType.ExtraAttackDir:
				transform = entity.GetRootTransform();
				break;
			case PosSourceType.lastGroundPoint:
				transform = entity.GetRootTransform();
				break;
			case PosSourceType.VerticalBodyNear:
				transform = entity.GetRootTransform();
				break;
			case PosSourceType.targetXZAndSlefY:
				transform = entity.GetRootTransform();
				break;
			default:
				_ = LuminApplication.LogEnabled;
				break;
			}
			if (transform != null)
			{
				return transform;
			}
		}
		if (fallback != null)
		{
			return fallback.Return(memory);
		}
		return null;
	}
}
