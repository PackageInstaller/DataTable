using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class ActionScript_Summoned : AIBase
{
	private AdventureActor _summoner;

	private TraceTarget _traceTarget;

	private FP _checkDistanceInterval;

	public void OnStart()
	{
		_summoner = ((MonsterAdventureActor)_actor).monsterSummonInfo.SummonActor;
		_checkDistanceInterval = 0;
		ILRuntimeAPI.CreateSkill(15631002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
	}

	public void OnUpdate()
	{
		if (!(_summoner != null))
		{
			return;
		}
		LogicEntity traceTarget = GetTraceTarget();
		if (traceTarget == null)
		{
			_checkDistanceInterval = 0;
			_traceTarget?.CancelTrace();
			_traceTarget?.Clear();
			return;
		}
		if (_checkDistanceInterval > 0)
		{
			_checkDistanceInterval -= _actor.LogicDeltaTime;
			return;
		}
		if (_traceTarget == null)
		{
			_traceTarget = new TraceTarget();
		}
		FP fP = _actor.DistanceWithRadius(traceTarget);
		if (fP > Config_MainControl.distance_BeginTrace_Summoned_Skill && !_traceTarget.Tracing)
		{
			_traceTarget.BeginTrace(_actor, traceTarget, Config_MainControl.distance_BeginTrace_Summoned_Skill, -1, -1, null, null);
		}
		else if (fP <= Config_MainControl.distance_BeginTrace_Summoned_Skill && _traceTarget.Tracing)
		{
			_traceTarget.CancelTrace();
		}
		_checkDistanceInterval = Config_MainControl.interval_CheckDistance_Summoned_Skill;
	}

	private LogicEntity GetTraceTarget()
	{
		object obj = _summoner.attackTarget ?? _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		if (obj == null)
		{
			obj = _summoner;
		}
		return (LogicEntity)obj;
	}

	public void OnStop()
	{
		_summoner = null;
		_traceTarget?.CancelTrace();
		_traceTarget?.Clear();
		_checkDistanceInterval = 0;
	}
}
