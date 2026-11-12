using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._31101;

public class Action_Summoned : AIBase
{
	private readonly FP durationTime = 8;

	private readonly int skillId_Trigger = 103110105;

	private readonly int skillId_Timeout = 103110106;

	private FP _durationTime;

	private bool _timeoutFired;

	public void OnStart()
	{
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
		_durationTime = durationTime;
		_timeoutFired = false;
		FireSkill(skillId_Trigger);
	}

	public void OnUpdate()
	{
		if (!_timeoutFired)
		{
			_durationTime -= _actor.LogicDeltaTime;
			if (_durationTime <= 0)
			{
				_timeoutFired = true;
				FireSkill(skillId_Timeout);
			}
		}
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableCloseBlock();
		_actor.DisableSearchedImmunity();
	}

	private void FireSkill(int skillId)
	{
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
	}
}
