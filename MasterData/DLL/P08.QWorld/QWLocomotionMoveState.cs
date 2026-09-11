using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "MoveState", menuName = "箱庭/Locomotion/MoveAsset")]
public class QWLocomotionMoveState : QWLocomotionState
{
	public string walkAudioCueName;

	public string walkAudioCueSheet;

	public string walkStopAudioCueName;

	public string walkStopAudioCueSheet;

	public QWLocomotionAnimParam move;

	public QWLocomotionAnimParam moveStart;

	public QWLocomotionAnimParam moveEnd;

	public QWLocomotionStopAnimAudio moveEndAudio;

	public QWLocomotionStopAnimAudio exitMoveAudio;

	private float startTime;

	private float startDuration;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.Move;
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
				if (!mBehaviour.IsInRush)
				{
					return true;
				}
			}
			else if (qWCharacterBlackboard.inputMovement.Magnitude > 0f && qWCharacterBlackboard.inputMovement.Magnitude < 0.8f && !mBehaviour.InPlacedRotate)
			{
				return true;
			}
			return false;
		}
		if (!mBehaviour.IsInRush && mBehaviour.mWalkStep > 0f)
		{
			return true;
		}
		return false;
	}

	protected override void OnActivateTag()
	{
		if (mBehaviour.IsPlayer && !(mBehaviour.mAgent.Blackboard as QWCharacterBlackboard).inputMovement.UseGamePad)
		{
			mBehaviour.IsInRush = false;
			mBehaviour.IsInFastRush = false;
		}
		mBehaviour.DisableRotation = false;
		mBehaviour.ForceOnGround = true;
		mBehaviour.UseGravity = false;
		mBehaviour.AllowRush = true;
		mBehaviour.AllowFastRush = true;
	}

	public override void OnActivate()
	{
		startTime = Time.time;
		if (mBehaviour.IsPlayer)
		{
			AudioManager.Instance.Play("effect", walkAudioCueSheet, walkAudioCueName, useStream: false);
		}
		if (!mBehaviour.CheckLastIsInState(QWLocomotionStateEnum.Rush))
		{
			mBehaviour.Anim?.CrossFade(move.animName, 0.2f, 0, 0f);
			mBehaviour.CurAnimation = move.animName;
		}
		else
		{
			mBehaviour.Anim?.CrossFade(moveStart.animName, 0.2f, 0, 0f);
			mBehaviour.CurAnimation = moveStart.animName;
			startDuration = moveStart.duration;
		}
	}

	public override void OnAnimatorPerform()
	{
		if (!mBehaviour.CurAnimation.Equals(move.animName) && Time.time - startTime > startDuration)
		{
			SetSpeed();
			mBehaviour.Anim?.CrossFade(move.animName, 0.2f, 0, 0f);
			mBehaviour.CurAnimation = move.animName;
		}
	}

	protected override void SetSpeed()
	{
		if (base.SpeedDirty && (bool)mBehaviour && (bool)mBehaviour.Anim)
		{
			base.SpeedDirty = false;
			mBehaviour.Anim.SetFloat("WalkSpeed", mBehaviour.WalkSpeedRatio);
		}
	}

	public override bool GetEndAnim(out QWLocomotionAnimParam anim, out QWLocomotionStopAnimAudio audio)
	{
		anim = moveEnd;
		audio = moveEndAudio;
		return true;
	}

	public override void OnExit(QWLocomotionStateEnum nextState)
	{
		if (mBehaviour.IsPlayer)
		{
			if (nextState == QWLocomotionStateEnum.Idle)
			{
				AudioManager.Instance.Play("effect", walkStopAudioCueSheet, walkStopAudioCueName, useStream: false);
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
