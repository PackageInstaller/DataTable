using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断是否可目标", "Predicate", new string[] { "can", "find", "targets", "predicate", "check", "condition" })]
public class CanFindTargetsPredicate : ConfigPredicate
{
	public BaseFindTargets findTargets = new ComplexFoundTargets
	{
		baseFindTargets = new BaseFindTargets[2]
		{
			new ConfigFindRangeTargets(),
			new FilterFoundTargets
			{
				predicates = new ConfigPredicate[1]
				{
					new WhereTargetsPredicate
					{
						whereTargets = new WhereTargets
						{
							alliance = Alliance.Enemy
						}
					}
				}
			}
		}
	};

	public override bool Check(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		findTargets.FindTargets(memory, memory.owner, list);
		bool result = list.Count > 0;
		ListPool<FindTargetResult>.Release(list);
		return result;
	}
}
