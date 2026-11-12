using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Summoned : AIBase
{
	protected PlayerAdventureActor _summoner;

	private bool _enableTrace;

	private TraceTarget _traceTarget;

	private FP _checkTraceInterval;

	private bool _forceTrace;

	private FP _normalAttackInterval;

	public virtual void OnStart()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected bool HavePersonalPerk(int perkId, out int perkLevel)
	{
		perkLevel = 0;
		if (_summoner == null)
		{
			return false;
		}
		return CommonUtils.HavePersonalPerk(_summoner.dataID, perkId, out perkLevel);
	}

	public virtual void OnUpdate()
	{
		_actor.attackTarget = GetAttackTarget();
		if (_enableTrace)
		{
			if (_checkTraceInterval > 0)
			{
				_checkTraceInterval -= _actor.LogicDeltaTime;
			}
			else if (CheckTrace())
			{
				_checkTraceInterval = Config.interval_CheckTrace_Summoned;
			}
		}
		if (CanNormalAttack() && NormalAttack())
		{
			_traceTarget?.CancelTrace();
		}
		if (_normalAttackInterval > 0)
		{
			_normalAttackInterval -= _actor.LogicDeltaTime;
		}
	}

	private LogicEntity GetAttackTarget()
	{
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (playerAdventureActor != null && playerAdventureActor.attackTarget != null)
		{
			return playerAdventureActor.attackTarget;
		}
		return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
	}

	protected void EnableTrace()
	{
		if (!_enableTrace)
		{
			_enableTrace = true;
			_forceTrace = false;
			_checkTraceInterval = 0;
			_traceTarget?.CancelTrace();
			_traceTarget?.Clear();
		}
	}

	protected void DisableTrace()
	{
		if (_enableTrace)
		{
			_enableTrace = false;
			_forceTrace = false;
			_checkTraceInterval = 0;
			_traceTarget?.CancelTrace();
			_traceTarget?.Clear();
		}
	}

	private bool CheckTrace()
	{
		if (_forceTrace)
		{
			return false;
		}
		if (_traceTarget == null)
		{
			_traceTarget = new TraceTarget();
		}
		if (_actor.actorSkillManage.HaveRunningSkill())
		{
			_traceTarget.CancelTrace();
			return false;
		}
		(LogicEntity target, FP stopDistance, bool forceTrace) traceInfo = GetTraceInfo();
		LogicEntity item = traceInfo.target;
		FP item2 = traceInfo.stopDistance;
		bool item3 = traceInfo.forceTrace;
		_forceTrace = item3;
		if (item != null)
		{
			_traceTarget.BeginTrace(_actor, item, item2, -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, () =>
			{
				_forceTrace = false;
			});
			return true;
		}
		return false;
	}

	private (LogicEntity target, FP stopDistance, bool forceTrace) GetTraceInfo()
	{
		FP fP = _actor.DistanceWithRadius(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor);
		if (fP > Config.distance_ForceTrace_Summoned)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config.distance_StopTrace_ForPlayer_Summoned, forceTrace: true);
		}
		if (_actor.attackTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.attackTarget) > GetAttackRange())
			{
				return (target: _actor.attackTarget, stopDistance: GetAttackRange(), forceTrace: false);
			}
		}
		else if (fP > Config.distance_StopTrace_ForPlayer_Summoned)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config.distance_StopTrace_ForPlayer_Summoned, forceTrace: false);
		}
		return (target: null, stopDistance: 0, forceTrace: false);
	}

	protected virtual bool CanNormalAttack()
	{
		if (_forceTrace)
		{
			return false;
		}
		if (_actor.attackTarget == null)
		{
			return false;
		}
		if (_normalAttackInterval > 0)
		{
			return false;
		}
		return _actor.DistanceWithRadius(_actor.attackTarget) <= GetAttackRange();
	}

	protected virtual FP GetAttackRange()
	{
		return 0;
	}

	protected bool NormalAttack()
	{
		int normalAttackSkillId = GetNormalAttackSkillId();
		if (normalAttackSkillId <= 0)
		{
			return false;
		}
		if (ILRuntimeAPI.CreateSkill(normalAttackSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnNormalAttackFinish))
		{
			return true;
		}
		return false;
	}

	protected virtual int GetNormalAttackSkillId()
	{
		return 0;
	}

	private void OnNormalAttackFinish(bool _)
	{
		_normalAttackInterval = GetNormalAttackInterval();
	}

	protected virtual FP GetNormalAttackInterval()
	{
		return 0;
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_SummonedCoordinateAttack)
		{
			OnReceiveCoordinateAttackEvent();
		}
	}

	protected virtual void OnReceiveCoordinateAttackEvent()
	{
	}

	public virtual void OnStop()
	{
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		DisableTrace();
		_normalAttackInterval = 0;
	}
}
