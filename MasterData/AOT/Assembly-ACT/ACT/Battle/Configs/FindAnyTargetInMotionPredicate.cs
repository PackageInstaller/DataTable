using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断任意目标中动作", "Predicate", new string[] { "find", "any", "target", "in", "motion", "predicate", "check", "condition", "skill", "ability" })]
public class FindAnyTargetInMotionPredicate : ConfigPredicate
{
	public BaseFindTargets findTargetsCondition;

	public MotionState checkState;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		if (findTargetsCondition != null)
		{
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			WhereTargets whereTargets = new WhereTargets
			{
				alliance = memory.owner.GetAlliance().GetOp(),
				canBeAttack = true
			};
			findTargetsCondition.FindTargets(memory.owner, list);
			whereTargets.FindTargets(list, memory.owner);
			foreach (FindTargetResult item in list)
			{
				if (item.entity.TryGetCompMotion(out CompMotion component) && component.curMotionState == checkState)
				{
					result = true;
					break;
				}
			}
			ListPool<FindTargetResult>.Release(list);
			return result;
		}
		return result;
	}
}
