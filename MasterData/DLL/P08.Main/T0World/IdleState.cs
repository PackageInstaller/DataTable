using UnityEngine;

namespace T0World;

public class IdleState : PlayerState
{
	public PlayerMoveAnimBrain.MoveState MoveState
	{
		get
		{
			return moveBrain.moveState;
		}
		set
		{
			moveBrain.moveState = value;
		}
	}

	public IdleState(PlayerMoveAnimBrain playerStateMachine)
		: base(playerStateMachine)
	{
	}

	public override void OnEnterState()
	{
		MoveState = PlayerMoveAnimBrain.MoveState.Idle;
		animancerState = base.Animancer.Play(base.AniData.idle);
	}

	public override (Quaternion, Vector3) UpdateMove(float dt)
	{
		return (base.Animancer.Animator.deltaRotation, base.Animancer.Animator.deltaPosition);
	}
}
