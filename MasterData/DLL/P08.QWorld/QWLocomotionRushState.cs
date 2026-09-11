using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "RushState", menuName = "箱庭/Locomotion/RushAsset")]
public class QWLocomotionRushState : QWLocomotionState
{
	public string rushAudioCueName;

	public string rushAudioCueSheet;

	public string rushStopAudioCueName;

	public string rushStopAudioCueSheet;

	public QWLocomotionAnimParam rush;

	public QWLocomotionAnimParam rushStart;

	public QWLocomotionAnimParam rushEnd;

	public QWLocomotionStopAnimAudio rushEndAudio;

	public QWLocomotionStopAnimAudio exitMoveAudio;

	public float coolDown;

	public float endAnimDuration;

	private float startTime;

	private float startDuration;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.Rush;
	}

	protected override void OnInit()
	{
	}

	public override bool TryActivate()
	{
		if (mBehaviour.mWalkStep <= 0f)
		{
			return false;
		}
		if (mBehaviour.IsPlayer)
		{
			if (!mBehaviour.CheckIfGrounded())
			{
				return false;
			}
			QWCharacterBlackboard qWCharacterBlackboard = mBehaviour.mAgent.Blackboard as QWCharacterBlackboard;
			if (qWCharacterBlackboard.inputMovement.UseGamePad)
			{
				if (mBehaviour.IsInRush && !mBehaviour.IsInFastRush)
				{
					return true;
				}
			}
			else if (qWCharacterBlackboard.inputMovement.Magnitude >= 0.8f && !mBehaviour.IsInFastRush)
			{
				return true;
			}
			return false;
		}
		if (mBehaviour.IsInRush && !mBehaviour.IsInFastRush && mBehaviour.mWalkStep > 0f)
		{
			return true;
		}
		return false;
	}

	protected override void OnActivateTag()
	{
		if (mBehaviour.IsPlayer && !(mBehaviour.mAgent.Blackboard as QWCharacterBlackboard).inputMovement.UseGamePad)
		{
			mBehaviour.IsInRush = true;
		}
		mBehaviour.DisableRotation = false;
		mBehaviour.ForceOnGround = true;
		mBehaviour.UseGravity = false;
		mBehaviour.AllowRush = false;
		mBehaviour.AllowFastRush = true;
	}

	public override void OnActivate()
	{
		CanExit = false;
		startTime = Time.time;
		startDuration = 0f;
		if (mBehaviour.IsPlayer)
		{
			AudioManager.Instance.Play("effect", rushAudioCueSheet, rushAudioCueName, useStream: false);
		}
		if (mBehaviour.CheckLastIsInState(QWLocomotionStateEnum.Move))
		{
			mBehaviour.Anim?.CrossFade(rush.animName, rush.crossFade, 0, 0f);
			mBehaviour.CurAnimation = rush.animName;
		}
		else
		{
			mBehaviour.Anim?.CrossFade(rushStart.animName, rushStart.crossFade, 0, 0f);
			mBehaviour.CurAnimation = rushStart.animName;
			startDuration = rushStart.duration;
		}
	}

	public override void OnAnimatorPerform()
	{
		if (!mBehaviour.CurAnimation.Equals(rush.animName) && Time.time - startTime > startDuration)
		{
			SetSpeed();
			mBehaviour.Anim?.CrossFade(rush.animName, rush.crossFade, 0, 0f);
			mBehaviour.CurAnimation = rush.animName;
		}
	}

	public override bool GetEndAnim(out QWLocomotionAnimParam anim, out QWLocomotionStopAnimAudio audio)
	{
		anim = rushEnd;
		audio = rushEndAudio;
		if (Time.time - startTime > endAnimDuration)
		{
			return true;
		}
		return false;
	}

	protected override void SetSpeed()
	{
		if (base.SpeedDirty && (bool)mBehaviour && (bool)mBehaviour.Anim)
		{
			base.SpeedDirty = false;
			mBehaviour.Anim.SetFloat("RunSpeed", mBehaviour.RunSpeedRatio);
		}
	}

	public override void SetCanExit()
	{
		if (Time.time - startTime > coolDown)
		{
			CanExit = true;
		}
	}

	public override void OnExit(QWLocomotionStateEnum nextState)
	{
		if (mBehaviour.IsPlayer)
		{
			if (nextState == QWLocomotionStateEnum.Idle)
			{
				AudioManager.Instance.Play("effect", rushStopAudioCueSheet, rushStopAudioCueName, useStream: false);
			}
			else
			{
				AudioManager.Instance.Play("effect", exitMoveAudio.stopAudioCueSheet, exitMoveAudio.stopAudioCueName, useStream: false);
			}
		}
	}

	public override void OnStatePreMove()
	{
		CheckForwardWall();
	}

	public override void OnStateMove()
	{
		ChangeGroundState();
	}
}
