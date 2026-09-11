using Animancer;
using UnityEngine;

namespace T0World;

public class MoveStartState : MoveStateBase
{
	private Vector3 estimateMoveStartFinishDir;

	public bool NeedTurnToMoveDir => Vector3.Angle(base.PlayerTrs.forward, base.MoveDir) > 22.5f;

	public override bool CanEnterState
	{
		get
		{
			if (base.MoveState != PlayerMoveAnimBrain.MoveState.End)
			{
				return base.MoveState == PlayerMoveAnimBrain.MoveState.Idle;
			}
			return true;
		}
	}

	public override bool CanExitState
	{
		get
		{
			if (!(base.MoveDir == Vector3.zero))
			{
				return animFinish;
			}
			return true;
		}
	}

	public MoveStartState(PlayerMoveAnimBrain stateMachine)
		: base(stateMachine)
	{
	}

	public override void OnEnterState()
	{
		base.OnEnterState();
		base.MoveState = PlayerMoveAnimBrain.MoveState.Start;
		if (NeedTurnToMoveDir)
		{
			Vector3 v = base.PlayerTrs.InverseTransformDirection(base.MoveDir);
			Vector2 vector = MoveStateBase.ToVec2XZ(v);
			if (v.x < 0f)
			{
				turning = Turning.L;
			}
			else
			{
				turning = Turning.R;
			}
			if (base.AniData.moveStartTurning.Transition is DirectionalClipTransition directionalClipTransition)
			{
				Vector2 vector2 = directionalClipTransition.AnimationSet.Snap(vector);
				estimateMoveStartFinishDir = base.PlayerTrs.TransformDirection(new Vector3(vector2.x, 0f, vector2.y)).normalized;
				if ((bool)base.PlayerTrs.parent)
				{
					estimateMoveStartFinishDir = base.PlayerTrs.parent.InverseTransformDirection(estimateMoveStartFinishDir);
				}
				animancerState = base.Animancer.Play(directionalClipTransition.AnimationSet.Get(vector));
				animancerState.Events(moveBrain).OnEnd = base.OnAnimEnd;
				return;
			}
		}
		turning = Turning.R;
		estimateMoveStartFinishDir = base.PlayerTrs.localRotation * Vector3.forward;
		animancerState = base.Animancer.Play(base.AniData.moveStartForward);
		animancerState.Events(moveBrain).OnEnd = base.OnAnimEnd;
	}

	public override void OnExitState()
	{
	}

	public override (Quaternion, Vector3) UpdateMove(float dt)
	{
		var (quaternion, item) = base.UpdateMove(dt);
		if ((bool)base.AniData)
		{
			Vector3 moveDir = base.MoveDir;
			float maxTurning = moveBrain.rotateAngleAdjustSpeed * moveBrain.moveStartDirAjustSpeedWeight.Evaluate(base.nt) * dt;
			Vector3 b = quaternion * base.PlayerTrs.localRotation * Vector3.forward;
			Vector3 refVec = Vector3.Slerp(estimateMoveStartFinishDir, b, base.nt);
			Quaternion quaternion2 = CalcCompensation(refVec, moveDir, maxTurning);
			quaternion = quaternion2 * quaternion;
			estimateMoveStartFinishDir = quaternion2 * estimateMoveStartFinishDir;
		}
		return (quaternion, item);
	}
}
