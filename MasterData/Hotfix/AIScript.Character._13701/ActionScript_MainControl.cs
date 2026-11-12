using AdventureBehaviour;

namespace AIScript.Character._13701;

public class ActionScript_MainControl : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	protected override void OnButtonAPress()
	{
		base.OnButtonAPress();
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		base.OnButtonBPress();
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End);
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}
}
