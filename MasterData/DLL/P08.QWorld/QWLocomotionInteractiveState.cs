using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "InteractiveState", menuName = "箱庭/Locomotion/InteractiveState")]
public class QWLocomotionInteractiveState : QWLocomotionState
{
	private bool lockState;

	private bool oldDisablePos;

	public QWLocomotionAnimParam exitIdleAnim;

	private bool oldCollisionTest;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.Interactive;
	}

	protected override void OnInit()
	{
		base.OnInit();
	}

	public override bool TryActivate()
	{
		return false;
	}

	protected override void OnActivateTag()
	{
		oldCollisionTest = mBehaviour.EnableCollisionTest;
		oldDisablePos = mBehaviour.mAgent.Blackboard.disablePosition;
		mBehaviour.mAgent.Blackboard.disablePosition = true;
		if (mBehaviour.InPlacedRotate)
		{
			mBehaviour.mAgent.Blackboard.inputMovement = new QWCharacterMovement(mBehaviour.transform.forward, 0f);
		}
		mBehaviour.InPlacedRotate = false;
		mBehaviour.UseGravity = false;
		mBehaviour.EnableCollisionTest = false;
		mBehaviour.EnableForceOnGround = false;
		mBehaviour.mAgent.Blackboard.disableMoveInput = true;
	}

	public override void OnActivate()
	{
		SetLockState(isLock: true);
	}

	public override void OnStateMove()
	{
	}

	public void SetLockState(bool isLock)
	{
		lockState = isLock;
		if (!isLock)
		{
			mBehaviour.Anim?.CrossFade(exitIdleAnim.animName, 0f, 0, 0f);
		}
	}

	public override void SetCanExit()
	{
		CanExit = !lockState;
	}

	public override void OnExit(QWLocomotionStateEnum nextState)
	{
		if (!mBehaviour.InPlacedRotate)
		{
			mBehaviour.mAgent.Blackboard.disableMoveInput = false;
		}
		mBehaviour.mAgent.Blackboard.disablePosition = false;
		mBehaviour.EnableCollisionTest = true;
		mBehaviour.EnableForceOnGround = true;
	}
}
