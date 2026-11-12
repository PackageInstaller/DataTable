using System;
using UnityEngine;

public class PlayerSpawnState : ActorSpawnState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (_ai == null)
		{
			_actor.Action();
		}
	}
}
