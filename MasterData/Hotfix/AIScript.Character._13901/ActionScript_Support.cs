using AdventureBehaviour;

namespace AIScript.Character._13901;

public class ActionScript_Support : ActionScript
{
	protected override void OnCastUltimate()
	{
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.D);
		ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End, OnUltraSkillFinish, null, currentBindSkillId == 13940001);
	}

	private void OnUltraSkillFinish(bool _)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
	}
}
