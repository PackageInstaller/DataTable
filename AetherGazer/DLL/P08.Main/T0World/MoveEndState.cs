using Animancer;
using UnityEngine;

namespace T0World;

public class MoveEndState : MoveStateBase
{
	public bool leftFeetStep;

	public bool rightFeetStep;

	public float threadhold = 0.05f;

	private const float NEED_TO_TURNING_ANIM_THREASHOLD = 2.5f;

	private float? adjustFacingAnimEstimateTurnDegree;

	public override bool CanEnterState
	{
		get
		{
			if (base.MoveState != PlayerMoveAnimBrain.MoveState.Start)
			{
				return base.MoveState == PlayerMoveAnimBrain.MoveState.Loop;
			}
			return true;
		}
	}

	public override bool CanExitState
	{
		get
		{
			if (!animFinish)
			{
				return base.MoveDir != Vector3.zero;
			}
			return true;
		}
	}

	private Vector3 FilteredMoveInput
	{
		get
		{
			Vector3? moveEndEstimateFacingDir = moveBrain.MoveEndEstimateFacingDir;
			if (!moveEndEstimateFacingDir.HasValue)
			{
				if (!moveBrain.InputIsValid)
				{
					return base.PlayerTrs.forward;
				}
				return moveBrain.MoveInput;
			}
			return moveEndEstimateFacingDir.GetValueOrDefault();
		}
	}

	private bool turnToTargetDir => adjustFacingAnimEstimateTurnDegree.HasValue;

	public MoveEndState(PlayerMoveAnimBrain stateMachine)
		: base(stateMachine)
	{
	}

	private void CheckLeftOrRightFoot()
	{
		Transform leftFeetTrs = moveBrain.leftFeetTrs;
		Transform rightFeetTrs = moveBrain.rightFeetTrs;
		Vector3 vector = base.PlayerTrs.InverseTransformPoint(leftFeetTrs.position);
		Vector3 vector2 = base.PlayerTrs.InverseTransformPoint(rightFeetTrs.position);
		if (vector.z > vector2.z + threadhold)
		{
			leftFeetStep = true;
			rightFeetStep = false;
		}
		else if (vector2.z > vector.z + threadhold)
		{
			leftFeetStep = false;
			rightFeetStep = true;
		}
		else
		{
			leftFeetStep = false;
			rightFeetStep = false;
		}
	}

	public override void OnEnterState()
	{
		adjustFacingAnimEstimateTurnDegree = null;
		_ = FilteredMoveInput;
		base.OnEnterState();
		PlayerMoveAnimBrain.MoveState moveState = base.MoveState;
		base.MoveState = PlayerMoveAnimBrain.MoveState.End;
		CheckLeftOrRightFoot();
		if (moveState != PlayerMoveAnimBrain.MoveState.Loop || (!leftFeetStep && !rightFeetStep))
		{
			OnWalkEndCheckNeedAlignPosAndTarget();
			return;
		}
		animancerState = base.Animancer.Play(base.AniData.moveEnd);
		float num = (leftFeetStep ? 1 : 0);
		float num2 = (rightFeetStep ? 1 : 0);
		float num3 = num + num2;
		num /= num3;
		num2 /= num3;
		animancerState.GetChild(0).Weight = num;
		animancerState.GetChild(1).Weight = num2;
		animancerState.Events(moveBrain).OnEnd = OnWalkEndCheckNeedAlignPosAndTarget;
	}

	public override (Quaternion, Vector3) UpdateMove(float dt)
	{
		Vector3 vector;
		Quaternion quaternion;
		(quaternion, vector) = base.UpdateMove(dt);
		if ((bool)base.AniData)
		{
			Vector3 filteredMoveInput = FilteredMoveInput;
			Quaternion quaternion2 = quaternion * base.PlayerTrs.rotation;
			Vector3 refVec = quaternion2 * Vector3.forward;
			if (turnToTargetDir)
			{
				float num = Vector3.SignedAngle(base.PlayerTrs.forward, filteredMoveInput, Vector3.down);
				float duration = animancerState.Duration;
				float num2 = Mathf.Max(0.01f, animancerState.RemainingDuration);
				float value = adjustFacingAnimEstimateTurnDegree.Value;
				float t = num / num2 / (value / duration);
				quaternion = Quaternion.SlerpUnclamped(Quaternion.identity, quaternion, t);
				Quaternion quaternion3 = Quaternion.Slerp(quaternion2, Quaternion.LookRotation(filteredMoveInput, Vector3.up), base.nt);
				quaternion = Quaternion.Slerp(quaternion, quaternion3 * Quaternion.Inverse(quaternion2), base.nt);
			}
			else
			{
				float maxTurning = moveBrain.rotateAngleAdjustSpeed * dt * moveBrain.moveEndDirAjustSpeedWeight.Evaluate(base.nt);
				quaternion = CalcCompensation(refVec, filteredMoveInput, maxTurning) * quaternion;
			}
		}
		if (moveBrain.MoveEndEstimateTargetPos.HasValue)
		{
			float t2 = 0f;
			if (animancerState.NormalizedEndTime > 0f)
			{
				t2 = base.nt / animancerState.NormalizedEndTime;
			}
			Vector3 vector2 = base.PlayerTrs.position + vector;
			vector = Vector3.Lerp(vector2, moveBrain.MoveEndEstimateTargetPos.Value, t2) - vector2;
		}
		return (quaternion, vector);
	}

	private void OnWalkEndCheckNeedAlignPosAndTarget()
	{
		if (moveBrain.MoveEndEstimateTargetPos.HasValue)
		{
			base.PlayerTrs.position = moveBrain.MoveEndEstimateTargetPos.Value;
		}
		if (moveBrain.MoveEndEstimateFacingDir.HasValue)
		{
			if (Vector3.Angle(base.PlayerTrs.forward, moveBrain.MoveEndEstimateFacingDir.Value) > 2.5f)
			{
				Vector3 filteredMoveInput = FilteredMoveInput;
				Vector2 vector = MoveStateBase.ToVec2XZ(base.PlayerTrs.InverseTransformDirection(filteredMoveInput));
				if ((bool)base.AniData.moveEndAdjustDir && base.AniData.moveEndAdjustDir.Transition is DirectionalClipTransition directionalClipTransition)
				{
					Vector2 to = directionalClipTransition.AnimationSet.Snap(vector);
					adjustFacingAnimEstimateTurnDegree = Vector2.SignedAngle(Vector2.up, to);
					animancerState = base.Animancer.Play(directionalClipTransition.AnimationSet.Get(vector));
					animancerState.Events(moveBrain).OnEnd = delegate
					{
						if (moveBrain.MoveEndEstimateTargetPos.HasValue)
						{
							base.PlayerTrs.position = moveBrain.MoveEndEstimateTargetPos.Value;
						}
						if (moveBrain.MoveEndEstimateFacingDir.HasValue)
						{
							base.PlayerTrs.forward = moveBrain.MoveEndEstimateFacingDir.Value;
						}
						OnAnimEnd();
					};
					return;
				}
			}
			else
			{
				base.PlayerTrs.forward = moveBrain.MoveEndEstimateFacingDir.Value;
			}
		}
		OnAnimEnd();
	}
}
