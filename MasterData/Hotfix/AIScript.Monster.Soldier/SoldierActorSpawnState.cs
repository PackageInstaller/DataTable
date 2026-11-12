using System;
using UnityEngine;

namespace AIScript.Monster.Soldier;

public class SoldierActorSpawnState : ActorSpawnState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		SoldierActor soldierActor = _actor as SoldierActor;
		if (_ai != null)
		{
			if (soldierActor.spawnSkillSkillId == 0)
			{
				_actor.Action();
			}
		}
		else
		{
			_actor.Action();
		}
	}
}
