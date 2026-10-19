using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行目标Compensation", "Action", new string[] { "target", "compensation", "retarget", "aim" })]
public class ActionTargetCompensation : ActionCompensation
{
	public BaseFindTargets findTargetsCondition;

	public Vector2 offest;

	public override void Do(ActionMemory memory)
	{
		if (findTargetsCondition == null)
		{
			return;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		WhereTargets whereTargets = new WhereTargets
		{
			alliance = memory.owner.GetAlliance().GetOp(),
			canBeAttack = true
		};
		findTargetsCondition.FindTargets(memory, list, whereTargets);
		bool faceLeft = memory.target.entity.IsFaceLeft();
		CompTransform compTransform = memory.target.entity.GetCompTransform();
		foreach (FindTargetResult item in list)
		{
			Entity entity = item.entity;
			config.DoCompensation(entity.GetCompTransform().physicsPosition - compTransform.physicsPosition + VectorUtility.HorizontalDirection(faceLeft, offest), memory.target.entity);
		}
		ListPool<FindTargetResult>.Release(list);
	}
}
