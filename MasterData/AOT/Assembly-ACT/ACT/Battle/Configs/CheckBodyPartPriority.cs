using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断身体PartPriority", "Predicate", new string[] { "check", "body", "part", "priority", "predicate", "condition" })]
public class CheckBodyPartPriority : ConfigPredicate
{
	public CompareMode compareMode;

	public byte targetPriority;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			AttackData attackData = getAttackData.GetAttackData();
			if (attackData.bodyPart > 0)
			{
				byte priority = memory.target.entity.GetMono().bodyParts[attackData.bodyPart - 1].priority;
				return compareMode switch
				{
					CompareMode.Equal => priority == targetPriority, 
					CompareMode.NotEqual => priority != targetPriority, 
					CompareMode.Greater => priority > targetPriority, 
					CompareMode.Less => priority < targetPriority, 
					CompareMode.GreaterAndEqual => priority >= targetPriority, 
					CompareMode.LessAndEqual => priority <= targetPriority, 
					_ => throw new NotImplementedException(), 
				};
			}
		}
		return false;
	}
}
