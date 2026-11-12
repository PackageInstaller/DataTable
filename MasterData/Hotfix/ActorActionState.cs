using System;
using UnityEngine;

public class ActorActionState : ActorStateBase<ActorPrimeFSM>
{
	public override int GetStateID()
	{
		return 3;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
	}
}
