using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "IdleState", menuName = "箱庭/Locomotion/IdleAsset")]
public class QWLocomotionIdleState : QWLocomotionState
{
	private QWLocomotionAnimParam lastEnd;

	private QWLocomotionStopAnimAudio lastEndAduio;

	public QWLocomotionAnimParam idle;

	private float startTime;

	private float startDuration;

	public float coolDown;

	private bool isInEndPlay;

	[NonSerialized]
	private float StartIdleStateTime;

	[NonSerialized]
	private float StartIdlePerformTime;

	[NonSerialized]
	private float CurIdlePerformDuration;

	[NonSerialized]
	private bool isInIdlePerform;

	public float IdlePlayGap = 5f;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.Idle;
	}

	public override bool TryActivate()
	{
		if (mBehaviour.mWalkStep <= 0f)
		{
			if (!mBehaviour.IsPlayer)
			{
				return true;
			}
			if (mBehaviour.CheckIfGrounded())
			{
				return true;
			}
		}
		return false;
	}

	protected override void OnActivateTag()
	{
		StartIdleStateTime = 0f;
		StartIdlePerformTime = 0f;
		isInIdlePerform = false;
		mBehaviour.DisableRotation = true;
		mBehaviour.ForceOnGround = true;
		mBehaviour.UseGravity = false;
		mBehaviour.AllowRush = true;
		mBehaviour.AllowFastRush = true;
		mBehaviour.IsInFastRush = false;
	}

	public override void OnActivate()
	{
		CanExit = false;
		startTime = Time.time;
		isInEndPlay = false;
		startDuration = 0f;
		string idleAnim = GetIdleAnim();
		if (mBehaviour.LastState != null)
		{
			if (mBehaviour.LastState.GetEndAnim(out var anim, out var audio))
			{
				lastEnd = anim;
				lastEndAduio = audio;
			}
			else
			{
				lastEnd.animName = "";
			}
		}
		if (lastEnd.animName != "")
		{
			if (!mBehaviour.CurAnimation.Equals(lastEnd.animName))
			{
				isInEndPlay = true;
				mBehaviour.Anim?.CrossFade(lastEnd.animName, lastEnd.customCrossFade ? lastEnd.crossFade : 0.05f, 0, 0f);
				mBehaviour.CurAnimation = lastEnd.animName;
				startDuration = lastEnd.duration;
				if (lastEndAduio.stopAudioCueName.IsNotNullOrEmpty() && mBehaviour.IsPlayer)
				{
					AudioManager.Instance.Play("effect", lastEndAduio.stopAudioCueSheet, lastEndAduio.stopAudioCueName, useStream: false);
				}
			}
		}
		else if (!mBehaviour.CurAnimation.Equals(idleAnim))
		{
			mBehaviour.Anim?.CrossFade(idleAnim, GetIdleCrossFade(), 0, 0f);
			mBehaviour.CurAnimation = idleAnim;
		}
		else
		{
			mBehaviour.Anim?.CrossFade(idleAnim, GetIdleCrossFade(), 0, 0f);
			mBehaviour.CurAnimation = idleAnim;
		}
	}

	public override void OnAnimatorPerform()
	{
		if (!mBehaviour.CurAnimation.Equals(GetIdleAnim()) && Time.time - startTime > startDuration)
		{
			if (mBehaviour.InPlacedRotate)
			{
				mBehaviour.mAgent.Blackboard.inputMovement = new QWCharacterMovement(mBehaviour.transform.forward, 0f);
			}
			mBehaviour.InPlacedRotate = false;
			isInEndPlay = false;
			mBehaviour.Anim?.CrossFade(GetIdleAnim(), GetIdleCrossFade(), 0, 0f);
			mBehaviour.CurAnimation = GetIdleAnim();
		}
		if (isInEndPlay)
		{
			return;
		}
		if (QWorldScene.Scene != null && !QWorldScene.GetQWorldContext().IsInStory)
		{
			if (!mBehaviour.IsPlayer)
			{
				return;
			}
			if (!isInIdlePerform)
			{
				if (!base.Blackboard.isInHide)
				{
					StartIdleStateTime += Time.deltaTime;
					if (StartIdleStateTime > IdlePlayGap)
					{
						string randomIdlePerform = GetRandomIdlePerform();
						if (randomIdlePerform != null)
						{
							mBehaviour.Anim?.CrossFade(randomIdlePerform, 0.05f, 0, 0f);
							float clipLength = mBehaviour.Anim.GetClipLength(0, randomIdlePerform);
							CurIdlePerformDuration = clipLength;
							StartIdlePerformTime = 0f;
							isInIdlePerform = true;
						}
						StartIdleStateTime = 0f;
					}
				}
				else
				{
					StartIdleStateTime = 0f;
				}
			}
			else if (!base.Blackboard.isInHide)
			{
				StartIdlePerformTime += Time.deltaTime;
				if (StartIdlePerformTime >= CurIdlePerformDuration)
				{
					mBehaviour.Anim?.CrossFade(GetIdleAnim(), GetIdleCrossFade(), 0, 0f);
					isInIdlePerform = false;
					CurIdlePerformDuration = 0f;
					StartIdlePerformTime = 0f;
				}
			}
			else
			{
				StartIdleStateTime = 0f;
			}
		}
		else if (mBehaviour.IsPlayer && isInIdlePerform)
		{
			CurIdlePerformDuration = 0f;
			StartIdlePerformTime = 0f;
			mBehaviour.Anim?.CrossFade(GetIdleAnim(), GetIdleCrossFade(), 0, 0f);
			isInIdlePerform = false;
		}
	}

	private string GetRandomIdlePerform()
	{
		QWCharacterBlackboard qWCharacterBlackboard = base.Blackboard as QWCharacterBlackboard;
		if ((bool)qWCharacterBlackboard)
		{
			int num = 0;
			if (qWCharacterBlackboard.curProxy.IdleAnim != null)
			{
				if (qWCharacterBlackboard.curProxy.IdleAnim.Count == 1)
				{
					return qWCharacterBlackboard.curProxy.IdleAnim[0];
				}
				if (qWCharacterBlackboard.curProxy.IdleAnim.Count > 2)
				{
					num = qWCharacterBlackboard.curProxy.IdleAnim.Count;
					return qWCharacterBlackboard.curProxy.IdleAnim[RandomHelper.RandomNumber(0, num - 1)];
				}
			}
		}
		return null;
	}

	private string GetIdleAnim()
	{
		if (mBehaviour.IsInSeeking)
		{
			return idle.animName;
		}
		if (base.Agent.Blackboard.defaultAnim.IsNotNullOrEmpty())
		{
			return base.Agent.Blackboard.defaultAnim;
		}
		return idle.animName;
	}

	private float GetIdleCrossFade()
	{
		if (base.Agent.Blackboard.defaultAnim.IsNotNullOrEmpty())
		{
			return 0f;
		}
		if (mBehaviour.LastState != null && mBehaviour.LastState.GetStateEnum() == QWLocomotionStateEnum.Interactive)
		{
			return 0f;
		}
		return idle.crossFade;
	}

	public override void SetCanExit()
	{
		if (Time.time - startTime > coolDown)
		{
			CanExit = true;
		}
	}

	public override void OnStatePreMove()
	{
		if (isInEndPlay)
		{
			CheckForwardWall();
		}
	}

	public override void OnStateMove()
	{
		ChangeGroundState();
	}
}
