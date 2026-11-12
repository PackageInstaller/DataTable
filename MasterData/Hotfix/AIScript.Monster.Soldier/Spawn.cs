using AdventureBehaviour;

namespace AIScript.Monster.Soldier;

public class Spawn : AIBase
{
	protected int _skillId;

	public void OnEnable()
	{
		_skillId = (_actor as SoldierActor).spawnSkillSkillId;
	}

	public void OnStart()
	{
		_actor.Idle();
		if (_skillId != 0)
		{
			ILRuntimeAPI.CreateSkill(_skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, ChangeState);
		}
		else
		{
			ChangeState(success: true);
		}
	}

	private void ChangeState(bool success)
	{
		_actor.Action(makeThreatAlert: false);
	}
}
