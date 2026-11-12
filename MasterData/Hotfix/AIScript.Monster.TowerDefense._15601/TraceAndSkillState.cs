using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._15601;

public class TraceAndSkillState : IState
{
	public bool CanCast;

	public LogicEntity target;

	public int skillId;

	public override void Enter()
	{
		base.Enter();
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		});
	}

	public override void ForceExit()
	{
		_actor.InterruptAttack(force: true);
		Exit();
	}
}
