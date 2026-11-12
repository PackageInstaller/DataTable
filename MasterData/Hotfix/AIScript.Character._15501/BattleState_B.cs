using AdventureBehaviour;

namespace AIScript.Character._15501;

public class BattleState_B : IState_UAV
{
	public bool CanCast;

	public int skillId;

	public override void Enter()
	{
		base.Enter();
		CanCast = ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		});
	}

	public override void ForceExit(bool keepAim = false)
	{
		_actor.InterruptAttack(force: true);
		Exit();
	}
}
