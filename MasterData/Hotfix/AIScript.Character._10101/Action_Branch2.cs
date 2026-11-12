using AdventureBehaviour;

namespace AIScript.Character._10101;

public class Action_Branch2 : Action
{
	protected override void OnButtonBPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End);
			_actor.logicVariable.ToggleLogicTag("holdSkill", value: true);
		}
	}
}
