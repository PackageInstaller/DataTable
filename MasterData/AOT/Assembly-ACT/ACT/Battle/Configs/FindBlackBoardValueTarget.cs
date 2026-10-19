using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取黑板目标", "FindTargets", new string[] { "find", "cus", "tom", "range", "target" })]
public class FindBlackBoardValueTarget : BaseFindTargets
{
	public BlackboardScope readBlackboardScope;

	public string readBlackboardKey;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		FindTargetsCore(new ActionMemory(referenceEntity, referenceEntity, referenceEntity), referenceEntity, results);
	}

	protected override void FindTargetsCore(ActionMemory memory, Entity referenceEntity, List<FindTargetResult> results)
	{
		BattleBlackboard blackboard = memory.GetBlackboard(readBlackboardScope);
		if (blackboard == null || !blackboard.TryGet<EntityReference[]>(readBlackboardKey, out var value) || value == null)
		{
			return;
		}
		for (int i = 0; i < value.Length; i++)
		{
			if (value[i].IsValid)
			{
				results.Add(FindTargetResult.EntityOnly(value[i]));
			}
		}
	}
}
