using System;
using System.Collections.Generic;
using UnityEngine;

public class ActorDeathState : ActorStateBase<ActorPrimeFSM>
{
	protected LogicEntity _killer;

	protected IList<int> _damageTag;

	protected int _uniqueAttackId;

	protected DeadType _deadType;

	public override int GetStateID()
	{
		return 5;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		_actor.DyingStateChanged += OnDyingStateChanged;
		_killer = _fsm.killer;
		_damageTag = _fsm.damageTag;
		_uniqueAttackId = _fsm.uniqueAttackId;
		_deadType = _fsm.deadType;
		AdventureActorDiedEvent adventureActorDiedEvent = AdventureActorDiedEvent.Generate();
		adventureActorDiedEvent.actor = _actor;
		adventureActorDiedEvent.killer = ((_killer != null) ? _killer : _actor);
		adventureActorDiedEvent.damageTag = _damageTag;
		adventureActorDiedEvent.uniqueAttackId = _uniqueAttackId;
		adventureActorDiedEvent.deadType = _deadType;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorDiedEvent);
		_actor.StopFXBeforeDied();
		if (_actor is MonsterAdventureActor entity && !entity.IsPlayerSummoned(out var _, out var _))
		{
			_actor.buffComponent?.OnClear();
		}
		_actor.InterruptPassiveBehaviour();
		if (!HasDyingLogic())
		{
			_actor.isDead = true;
			DoDied();
		}
		else
		{
			AdventureMonsterNearDeathEvent adventureMonsterNearDeathEvent = AdventureMonsterNearDeathEvent.Generate();
			adventureMonsterNearDeathEvent.dataID = _actor.dataID;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterNearDeathEvent);
		}
		base.OnEnter(preStatus, onComplete, onLeave);
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		base.OnLeave(nextState);
		_actor.DyingStateChanged -= OnDyingStateChanged;
		_killer = null;
		_damageTag = null;
		_uniqueAttackId = 0;
	}

	private void OnDyingStateChanged(bool inDying)
	{
		if (!inDying)
		{
			_actor.isDead = true;
			DoDied();
		}
	}

	private bool HasDyingLogic()
	{
		return _ai != null;
	}

	protected virtual void DoDied()
	{
		DiedClear();
		FinishDied();
	}

	protected void DiedClear()
	{
		_actor.StopFXBeforeDied();
		_actor.DisableMovementAgent();
		_actor.InterruptMovement();
		_actor.InterruptAttack();
	}

	protected virtual void FinishDied()
	{
		_actor.EnterNull();
	}
}
