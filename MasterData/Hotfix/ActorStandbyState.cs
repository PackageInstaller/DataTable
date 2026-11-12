using System;
using TrueSync;
using UnityEngine;

public class ActorStandbyState : ActorStateBase<ActorMovementFSM>
{
	protected Action _onComplete;

	protected Action _onLeavl;

	public override int GetStateID()
	{
		return 7;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_actor.movAgent.RotationTowards(new TSVector(_actor.tsTransform.Forward.x, FP.Zero, _actor.tsTransform.Forward.y), FP.MaxValue);
		_actor.velocitySpeed = 0f;
		_actor.velocityDirection = TSVector2.zero;
		_actor.forceChangeDirection = TSVector2.zero;
		_onComplete = onComplete;
		_actor._movementFSM.forceMove = false;
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		_onComplete?.Invoke();
		_onLeavl?.Invoke();
	}
}
