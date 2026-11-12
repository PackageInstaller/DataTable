using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._156;

public class Action_Summoned : AIBase
{
	private readonly FP durationTime = 15;

	private readonly int skillId_SummonSkill = 100015604;

	private readonly FP durationTime_Potential = 15;

	private readonly int skillId_SummonSkill_Potential = 100015605;

	private readonly TraceTarget _traceTarget = new TraceTarget();

	private int _potentialLv;

	private FP _durationTime;

	public void OnStart()
	{
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_durationTime = durationTime;
		if (_potentialLv >= 1)
		{
			_durationTime = durationTime_Potential;
		}
		_actor.EnableInvincible();
		_actor.EnableCloseBlock();
		if (_actor.attackTarget != null)
		{
			_traceTarget.BeginTrace(_actor, _actor.attackTarget, _actor.attackTarget.GetRadius(), -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, OnTraceFinish);
		}
	}

	private void OnTraceFinish()
	{
		int skillId = skillId_SummonSkill;
		if (_potentialLv >= 1)
		{
			skillId = skillId_SummonSkill_Potential;
		}
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
	}

	public void OnUpdate()
	{
		if (_durationTime > 0)
		{
			_durationTime -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	public void OnStop()
	{
		_actor.DisableInvincible();
		_actor.DisableCloseBlock();
		_traceTarget.CancelTrace();
		_traceTarget.Clear();
	}
}
