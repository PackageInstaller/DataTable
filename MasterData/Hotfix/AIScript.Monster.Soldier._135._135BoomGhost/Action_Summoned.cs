using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._135._135BoomGhost;

public class Action_Summoned : AIBase
{
	private static readonly FP durationTime = 3;

	private static readonly FP arriveDistance = 2;

	private static readonly int broadcastEvt_SkillEnd = CommonHelper.StringToHash("135BoomGhost_SkillEnd");

	private readonly TraceTarget _traceTarget = new TraceTarget();

	private LogicEntity _target;

	private FP _durationTime;

	private bool _skillFired;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public void OnStart()
	{
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
		_durationTime = durationTime;
		_skillFired = false;
		RefreshTarget();
	}

	public void OnUpdate()
	{
		if (_skillFired)
		{
			return;
		}
		RefreshTarget();
		if (_target != null && TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position) <= arriveDistance)
		{
			FireSkill();
			return;
		}
		_durationTime -= _actor.LogicDeltaTime;
		if (_durationTime <= 0)
		{
			_traceTarget.CancelTrace();
			_actor.DestroySelf();
		}
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableCloseBlock();
		_actor.DisableSearchedImmunity();
		_traceTarget.CancelTrace();
		_traceTarget.Clear();
		_target = null;
	}

	private void RefreshTarget()
	{
		LogicEntity logicEntity = GetPriorityConfrontTarget();
		if (logicEntity == null)
		{
			FP fP = FP.MaxValue;
			TSVector2 position = _actor.tsTransform.Position;
			List<AdventureActor> confrontFactionActors = ILRuntimeAPI.GetConfrontFactionActors(_actor);
			for (int i = 0; i < confrontFactionActors.Count; i++)
			{
				AdventureActor adventureActor = confrontFactionActors.get_Item(i);
				if (adventureActor == null || adventureActor == _actor)
				{
					continue;
				}
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity())
				{
					FP fP2 = TSVector2.DistanceSquared(position, adventureActor.tsTransform.Position);
					if (fP2 < fP)
					{
						fP = fP2;
						logicEntity = adventureActor;
					}
				}
			}
		}
		if (!(logicEntity == _target))
		{
			_target = logicEntity;
			_actor.attackTarget = _target;
			_traceTarget.CancelTrace();
			if (_target != null)
			{
				_traceTarget.BeginTrace(_actor, _target, arriveDistance, -1, -1, null, null);
			}
		}
	}

	private void FireSkill()
	{
		_traceTarget.CancelTrace();
		_actor.DestroySelf();
		_skillFired = true;
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (_skillFired && evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.sender as AdventureActor != _actor) && adventureActorCustomEvent.eventHashCode == broadcastEvt_SkillEnd)
		{
			_traceTarget.CancelTrace();
			_actor.DestroySelf();
		}
	}

	private LogicEntity GetPriorityConfrontTarget()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return null;
		}
		if (soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.GaoGeDaXinWen) < 1)
		{
			return null;
		}
		SoldierActor soldierActor = FindSummoner(soldierLevelController);
		if (soldierActor != null && soldierActor.attackTarget is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity())
		{
			return adventureActor;
		}
		return null;
	}

	private SoldierActor FindSummoner(SoldierLevelController levelController)
	{
		List<SoldierLevelController.SoldierSummonData> soldierSummonInfos = levelController.GetSoldierSummonInfos();
		if (soldierSummonInfos == null)
		{
			return null;
		}
		for (int i = 0; i < soldierSummonInfos.Count; i++)
		{
			if (soldierSummonInfos.get_Item(i).entityId == _actor.Id)
			{
				return soldierSummonInfos.get_Item(i).summoner;
			}
		}
		return null;
	}
}
