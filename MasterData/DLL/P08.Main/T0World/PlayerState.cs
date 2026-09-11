using Animancer;
using Animancer.FSM;
using UnityEngine;

namespace T0World;

public abstract class PlayerState : global::Animancer.FSM.State
{
	public PlayerMoveAnimBrain moveBrain;

	protected AnimancerState animancerState;

	protected bool animFinish;

	public AnimancerComponent Animancer => moveBrain.animancer;

	public MoveAniData AniData => moveBrain.aniData;

	protected float nt => animancerState?.NormalizedTime ?? 0f;

	public PlayerState(PlayerMoveAnimBrain playerStateMachine)
	{
		moveBrain = playerStateMachine;
	}

	public override void OnEnterState()
	{
		base.OnEnterState();
		animFinish = false;
	}

	protected void OnAnimEnd()
	{
		animFinish = true;
		moveBrain.UpdateMovementAnim();
	}

	public abstract (Quaternion, Vector3) UpdateMove(float dt);

	public virtual void OnUpdate()
	{
	}
}
