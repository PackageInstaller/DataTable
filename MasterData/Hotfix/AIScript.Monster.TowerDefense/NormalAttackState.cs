using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense;

public class NormalAttackState : IState
{
	public int skillId;

	public override void Enter()
	{
		base.Enter();
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		});
	}

	public override void Update()
	{
		if (_actor.skillMgr.HasCastSkill())
		{
			ForceExit();
		}
	}

	public override void ForceExit()
	{
		_actor.InterruptAttack(force: true);
		Exit();
	}
}
