using System;
using UnityEngine;

public class MonsterActionState : ActorActionState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		if (SceneSingleton<AdventurePlayerController>.Instance != null)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null && activedPlayerActor.IsConfrontWith(_actor))
			{
				SceneSingleton<AdventurePlayerController>.Instance.setActionEnemyLs(_actor.Id, add: true);
			}
		}
	}
}
