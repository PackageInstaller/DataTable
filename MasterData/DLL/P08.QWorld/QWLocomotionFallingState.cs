using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "FallingState", menuName = "箱庭/Locomotion/FallingAsset")]
public class QWLocomotionFallingState : QWLocomotionState
{
	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.Falling;
	}

	public override bool TryActivate()
	{
		if (!mBehaviour.CheckIfGrounded())
		{
			return true;
		}
		return false;
	}

	protected override void OnActivateTag()
	{
		mBehaviour.DisableRotation = false;
		mBehaviour.Grounded = false;
		mBehaviour.UseGravity = true;
		mBehaviour.ForceOnGround = true;
	}

	public override void OnActivate()
	{
		if (mBehaviour.IsPlayer)
		{
			(base.Blackboard as QWCharacterBlackboard).IsFalling = true;
		}
	}

	public override void OnStateMove()
	{
	}

	public override void OnExit(QWLocomotionStateEnum nextState)
	{
		if (mBehaviour.IsPlayer)
		{
			(base.Blackboard as QWCharacterBlackboard).IsFalling = false;
		}
	}
}
