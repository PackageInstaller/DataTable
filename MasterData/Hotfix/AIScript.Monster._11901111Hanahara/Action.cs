using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11901111Hanahara;

public class Action : AIBase
{
	private int skillId_NoramlAttack = 11940001;

	private int perkId_41 = 511941;

	private FP distance_BeginFollow = 5;

	private FP distance_FinishFollow = 4;

	protected PlayerAdventureActor _summoner;

	protected AimTarget _aimTarget;

	protected TraceTarget _traceTarget;

	protected CoroutineNode _traceCor;

	public void OnEnable()
	{
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	public void OnDisable()
	{
		_actor.DisableUnparalleled();
		_actor.DisableSearchedImmunity();
		_actor.DisableCloseBlock();
		_summoner = null;
		if (_traceCor != null)
		{
			_actor.StopLogicCoroutine(_traceCor);
		}
		_traceCor = null;
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		_traceTarget?.CancelTrace();
	}

	public void OnStop()
	{
		if (_traceCor != null)
		{
			_actor.StopLogicCoroutine(_traceCor);
		}
		_aimTarget?.Cancel();
		_traceTarget?.CancelTrace();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_SUMMON_CASTSKILL", OnCastSkill);
	}

	public void OnStart()
	{
		if (_traceCor != null)
		{
			_actor.StopLogicCoroutine(_traceCor);
		}
		_aimTarget?.Cancel();
		_traceTarget?.CancelTrace();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_SUMMON_CASTSKILL", OnCastSkill);
		if (GetPerk(perkId_41))
		{
			_actor.DisableCloseBlock();
			_actor.StartLogicCoroutine(TracePlayer());
		}
		else
		{
			_actor.EnableCloseBlock();
		}
	}

	protected IEnumerator TracePlayer()
	{
		LogicEntity followTarget = null;
		FP checkInterval = 0;
		while (!(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == null))
		{
			bool num = followTarget == null || followTarget.Id != SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.Id;
			followTarget = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (num || checkInterval > 0.5f)
			{
				if (TSVector2.DistanceSquared(_actor.tsTransform.Position, followTarget.tsTransform.Position) > distance_BeginFollow * distance_BeginFollow)
				{
					if (_traceTarget == null)
					{
						_traceTarget = new TraceTarget();
					}
					_traceTarget.BeginTrace(_actor, followTarget, distance_FinishFollow, -1, -1, null, null);
				}
				else
				{
					_traceTarget?.CancelTrace();
				}
				checkInterval = 0;
			}
			checkInterval += _actor.LogicDeltaTime;
			yield return null;
		}
		_traceTarget?.CancelTrace();
	}

	public void OnUpdate()
	{
		if (_actor.state == ActorState.Death)
		{
			return;
		}
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor != null && activedPlayerActor.attackTarget != null)
		{
			_actor.attackTarget = activedPlayerActor.attackTarget;
		}
		if (_actor.attackTarget != null)
		{
			if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
			{
				if (_aimTarget == null)
				{
					_aimTarget = new AimTarget();
				}
				_aimTarget.Aim(_actor, (AdventureActor)_actor.attackTarget);
			}
			_actor.movementMode = AdventureActor.MovementMode.Walk;
			ILRuntimeAPI.CreateSkill(skillId_NoramlAttack, _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		}
		else if (_actor.actorSkillManage.HaveSkill(skillId_NoramlAttack))
		{
			if (_aimTarget == null)
			{
				_aimTarget = new AimTarget();
			}
			_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
			_actor.movementMode = AdventureActor.MovementMode.Walk;
		}
		else
		{
			_aimTarget?.Cancel();
			_actor.movementMode = AdventureActor.MovementMode.Run;
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (_actor.state != ActorState.Death && evt is AdventureSummonCaskSkillEvent adventureSummonCaskSkillEvent && adventureSummonCaskSkillEvent.sender as AdventureActor == _summoner && InCastSkillQuota())
		{
			_actor.InterruptAttack(force: true);
			ILRuntimeAPI.CreateSkill(adventureSummonCaskSkillEvent.skillId, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		}
	}

	private bool InCastSkillQuota()
	{
		if (_summoner == null)
		{
			return true;
		}
		List<AdventureModuleController.MonsterSummonData> list = ModuleController<AdventureModuleController>.Instance?.MonsterSummonInfos;
		if (list == null)
		{
			return true;
		}
		int num = 0;
		for (int i = 0; i < list.Count; i++)
		{
			AdventureModuleController.MonsterSummonData monsterSummonData = list.get_Item(i);
			if (monsterSummonData != null && monsterSummonData.iAlive && monsterSummonData.dataID == _actor.dataID && monsterSummonData.SummonActorID == _summoner.Id)
			{
				if (monsterSummonData.entityID == _actor.Id)
				{
					return num < 2;
				}
				num++;
			}
		}
		return true;
	}
}
