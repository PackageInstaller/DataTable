using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动作状态", "Predicate", new string[] { "motion", "state", "status", "tag", "predicate", "check", "condition" })]
public class MotionStatePredicate : ConfigPredicate
{
	public MotionState motionState;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompMotion(out CompMotion component))
		{
			bool flag = component.curMotionState == motionState;
			if (!Inverse)
			{
				return flag;
			}
			return !flag;
		}
		return false;
	}
}
