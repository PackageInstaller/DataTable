using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense;

public class SkillState : IState
{
	public int skillId;

	public override void Enter()
	{
		base.Enter();
		if (ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
			if (!_actor.beginEnergyOnCast)
			{
				_actor.skillMgr.BeginEnergy(skillId);
			}
		}))
		{
			_actor.skillMgr.ResetEnergy(skillId, auto: false);
			if (_actor.beginEnergyOnCast)
			{
				_actor.skillMgr.BeginEnergy(skillId);
			}
		}
	}

	public override void ForceExit()
	{
		_actor.InterruptAttack(force: true);
		Exit();
	}
}
