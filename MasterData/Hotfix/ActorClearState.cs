using System;
using UnityEngine;

public class ActorClearState : ActorStateBase<ActorPrimeFSM>
{
	public override int GetStateID()
	{
		return 6;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		_actor.isDead = true;
		_actor.isDeclareDead = true;
		DoClear();
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		base.OnLeave(nextState);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
	}

	protected virtual void DoClear()
	{
		AdventureActorDiedEvent adventureActorDiedEvent = AdventureActorDiedEvent.Generate();
		adventureActorDiedEvent.actor = _actor;
		adventureActorDiedEvent.killer = _actor;
		adventureActorDiedEvent.damageTag = null;
		adventureActorDiedEvent.uniqueAttackId = 0;
		adventureActorDiedEvent.deadType = DeadType.ClearSelf;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorDiedEvent);
		FinishClear();
	}

	protected virtual void FinishClear()
	{
		_actor.InterruptMovement();
		_actor.InterruptAttack();
		_actor.buffComponent?.OnClear();
		_actor.InterruptPassiveBehaviour();
		_actor.EnterNull();
		if (_actor is PlayerAdventureActor playerAdventureActor)
		{
			playerAdventureActor.Despawn();
		}
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.Despawn();
		}
	}
}
