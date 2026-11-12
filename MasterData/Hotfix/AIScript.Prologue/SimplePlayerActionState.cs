using System;
using UnityEngine;

namespace AIScript.Prologue;

public class SimplePlayerActionState : PlayerActionState
{
	public bool isOverride = true;

	private SimplePlayerAdventureActor actor;

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		actor = _actor as SimplePlayerAdventureActor;
	}

	public override void OnUpdate()
	{
		if (!isOverride)
		{
			base.OnUpdate();
		}
		else
		{
			if (_actor.movementFSM.forceMove || !actor.IsManualMove)
			{
				return;
			}
			if (_movementHasInput)
			{
				if (actor.IsFixedMoveDir)
				{
					_movementInputDirection = actor.FixedMoveDir;
				}
				if (actor.forceStandBy)
				{
					actor.StandBy();
				}
				else
				{
					actor.Move(_movementInputDirection);
				}
			}
			else if (actor.movementState == ActorState.Move && actor.movementFSM.moveMode == ActorMoveState.MoveMode.MoveByDirection)
			{
				actor.StandBy();
			}
		}
	}
}
