using AdventureBehaviour;

namespace AIScript.Character._15801;

public class ActionScript_Casemate_Support : ActionScript_Summoned
{
	public override void OnStart()
	{
		base.OnStart();
		ILRuntimeAPI.CreateSkill(15897003, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
		{
			_actor.DestroySelf();
		});
	}

	protected override bool CanNormalAttack()
	{
		return false;
	}

	public override void OnStop()
	{
		base.OnStop();
	}
}
