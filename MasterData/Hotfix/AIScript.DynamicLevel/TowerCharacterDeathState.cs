using System;
using UnityEngine;

namespace AIScript.DynamicLevel;

public class TowerCharacterDeathState : ActorDeathState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
	}

	protected override void FinishDied()
	{
		base.FinishDied();
		(_actor as TowerDefenseCharacterActor)?.Despawn();
	}
}
