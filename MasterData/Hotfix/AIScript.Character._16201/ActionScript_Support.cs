using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._16201;

public class ActionScript_Support : ActionScript
{
	private bool _inSkill;

	public override void OnStart()
	{
		base.OnStart();
		_inSkill = false;
	}

	protected override void OnCastSkill()
	{
		_inSkill = true;
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish);
	}

	private void OnSkillFinish(bool _)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		_inSkill = false;
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (!_inSkill)
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
	}

	public override void OnStop()
	{
		base.OnStop();
		_inSkill = false;
	}
}
