using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._160;

public class Action_Summoned : AIBase
{
	private readonly FP durationTime = 9;

	private readonly int skillId_SummonSkill = 100016004;

	private readonly FP durationTime_Potential = 27;

	private int _potentialLv;

	private FP _durationTime;

	private TraceTarget _traceTarget = new TraceTarget();

	private List<SoldierActor> _targetList = new List<SoldierActor>();

	private SoldierActor _target;

	public void OnStart()
	{
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_durationTime = durationTime;
		if (_potentialLv >= 3)
		{
			_durationTime = durationTime_Potential;
		}
		_actor.EnableInvincible();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
	}

	public void OnUpdate()
	{
		if (!_actor.actorSkillManage.HaveSkill(skillId_SummonSkill))
		{
			ILRuntimeAPI.CreateSkill(skillId_SummonSkill, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
		}
		CheckTraceTarget();
		if (_durationTime >= 0)
		{
			_durationTime -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private void CheckTraceTarget()
	{
		if (_traceTarget.Tracing)
		{
			return;
		}
		if (_target == null)
		{
			_target = _actor.attackTarget as SoldierActor;
		}
		else if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
		{
			if (_actor.attackTarget is SoldierActor self)
			{
				soldierLevelController.GetBattleActors(self, _targetList);
				_targetList.Remove(_target);
				List<SoldierActor> targetList = _targetList;
				if (targetList != null && targetList.Count > 0)
				{
					_target = _targetList.get_Item(TSRandom.Range(0, _targetList.Count));
				}
				else
				{
					_target = null;
				}
			}
		}
		else
		{
			_target = null;
		}
		if (_target != null)
		{
			_traceTarget.BeginTrace(_actor, _actor.attackTarget, _actor.attackTarget.GetRadius(), -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, CheckTraceTarget);
		}
		else
		{
			_traceTarget.Clear();
		}
	}

	public void OnStop()
	{
		_actor.DisableInvincible();
		_actor.DisableCloseBlock();
		_actor.DisableSearchedImmunity();
		_durationTime = 0;
		_traceTarget.CancelTrace();
		_traceTarget.Clear();
		_targetList.Clear();
		_target = null;
	}
}
