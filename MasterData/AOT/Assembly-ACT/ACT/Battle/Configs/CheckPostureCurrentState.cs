using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断架势当前状态", "Predicate", new string[] { "check", "posture", "current", "state", "status", "tag", "predicate", "condition" })]
public class CheckPostureCurrentState : ConfigPredicate
{
	public enum EPostureState
	{
		HavaPosture,
		DontHavePosture,
		InWeak
	}

	public EPostureState postureState;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		switch (postureState)
		{
		case EPostureState.HavaPosture:
			result = memory.target.entity.GetCompAbility().IsHavePosture;
			break;
		case EPostureState.DontHavePosture:
			result = !memory.target.entity.GetCompAbility().IsHavePosture;
			break;
		case EPostureState.InWeak:
			result = memory.target.entity.GetCompAbility().IsWeak;
			break;
		}
		return result;
	}
}
