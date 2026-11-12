using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._15001;

public class ActionScript_Support : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	protected override void OnCastSkill()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish);
	}

	private void OnSkillFinish(bool success)
	{
		if (success)
		{
			((PlayerAdventureActor)_actor).isAssistAIFinish = true;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515030, out var _))
			{
				_actor.buffComponent.RemoveBuffByBuffId(15030011);
			}
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
