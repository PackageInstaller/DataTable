using UnityEngine;

namespace T0World;

public class MoveLoopState : MoveStateBase
{
	public override bool CanEnterState => base.MoveState == PlayerMoveAnimBrain.MoveState.Start;

	public MoveLoopState(PlayerMoveAnimBrain stateMachine)
		: base(stateMachine)
	{
	}

	public override void OnEnterState()
	{
		base.OnEnterState();
		base.MoveState = PlayerMoveAnimBrain.MoveState.Loop;
		animancerState = base.Animancer.Play(base.AniData.moveLoop);
	}

	public override (Quaternion, Vector3) UpdateMove(float dt)
	{
		(Quaternion, Vector3) tuple = base.UpdateMove(dt);
		Quaternion item = tuple.Item1;
		Vector3 item2 = tuple.Item2;
		Vector3 moveDir = base.MoveDir;
		return (CalcCompensation(item * base.PlayerTrs.forward, moveDir, moveBrain.rotateAngleAdjustSpeed * dt) * item, item2);
	}
}
