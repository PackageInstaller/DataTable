using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "PlayerFocusState", menuName = "箱庭/Locomotion/PlayerFocusAsset")]
public class QWLocomotionPlayerFocusState : QWLocomotionState
{
	public QWLocomotionAnimParam idleAnim;

	public string bookPath;

	public string gua_point = "gua_R_hand_bone";

	private GameObject book;

	private bool lockState;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.PlayerFocus;
	}

	public override bool TryActivate()
	{
		return false;
	}

	protected override void OnActivateTag()
	{
		mBehaviour.mAgent.Blackboard.disablePosition = true;
		if (mBehaviour.InPlacedRotate)
		{
			mBehaviour.mAgent.Blackboard.inputMovement = new QWCharacterMovement(mBehaviour.transform.forward, 0f);
		}
		mBehaviour.InPlacedRotate = false;
		mBehaviour.UseGravity = false;
		mBehaviour.EnableCollisionTest = false;
		mBehaviour.mAgent.Blackboard.disableMoveInput = true;
	}

	public override void OnActivate()
	{
		book = UnityEngine.Object.Instantiate(Asset.Load<GameObject>(bookPath));
		Transform parent = (mBehaviour.mAgent.Blackboard as QWCharacterBlackboard).FindAttachPoint(gua_point);
		book.transform.parent = parent;
		book.transform.localScale = Vector3.one;
		book.transform.localPosition = Vector3.zero;
		book.transform.localRotation = Quaternion.identity;
		book.SetActive(value: true);
		SetLockState(isLock: true);
		mBehaviour.Anim?.CrossFade(idleAnim.animName, 0f, 0, 0f);
	}

	public void SetLockState(bool isLock)
	{
		lockState = isLock;
	}

	public override void SetCanExit()
	{
		CanExit = !lockState;
	}

	public override void OnExit(QWLocomotionStateEnum nextState)
	{
		UnityEngine.Object.Destroy(book);
		Asset.Unload(bookPath);
		if (!mBehaviour.InPlacedRotate)
		{
			mBehaviour.mAgent.Blackboard.disableMoveInput = false;
		}
		mBehaviour.mAgent.Blackboard.disablePosition = false;
		mBehaviour.EnableCollisionTest = true;
	}
}
