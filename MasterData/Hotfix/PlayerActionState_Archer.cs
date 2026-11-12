using System;
using TrueSync;
using UnityEngine;

public class PlayerActionState_Archer : PlayerActionState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		base.OnLeave(nextState);
	}

	public override void OnMovementInput(bool movementHasInput, TSVector2 movementInputVector, TSVector2 movementInputDirection)
	{
		base.OnMovementInput(movementHasInput, movementInputVector, movementInputDirection);
	}
}
