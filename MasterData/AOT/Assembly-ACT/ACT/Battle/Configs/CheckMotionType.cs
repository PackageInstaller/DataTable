using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动作类型", "Predicate", new string[] { "check", "motion", "type", "predicate", "condition", "skill", "ability", "cd" })]
public class CheckMotionType : ConfigPredicate
{
	public MotionType motionType;

	public override bool Check(ActionMemory memory)
	{
		ConfigCharacter config = memory.target.entity.GetConfig();
		if ((object)config != null)
		{
			return config.motionType == motionType;
		}
		return false;
	}
}
