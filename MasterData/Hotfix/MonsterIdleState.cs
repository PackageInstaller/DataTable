using System;
using UnityEngine;

public class MonsterIdleState : ActorIdleState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.EnableAlertRng();
			monsterAdventureActor.CheckDelayEnterAction();
		}
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		base.OnLeave(nextState);
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.DisableAlertRng();
		}
	}
}
