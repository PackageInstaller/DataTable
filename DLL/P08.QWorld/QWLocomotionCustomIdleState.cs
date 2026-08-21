using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "CustomIdleState", menuName = "箱庭/Locomotion/CustomIdleAsset")]
public class QWLocomotionCustomIdleState : QWLocomotionState
{
	public bool LoopState;

	public string IdleAnim;

	public bool firstIsIdle = true;

	public float crossFadeTime = 0.05f;

	public float delayTimer = 1f;

	public QWLocomotionCustomIdleFunc loopFunc = QWLocomotionCustomIdleFunc.OrderLoop;

	public List<string> loopAnim;

	private bool lockState;

	private int curIdx;

	private float lastInIdleTime;

	private bool isInIdle;

	private bool firstAddDirty;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.CustomIdle;
	}

	public override bool TryActivate()
	{
		return false;
	}

	public override void OnActivate()
	{
		curIdx = -1;
		lastInIdleTime = 0f;
		isInIdle = firstIsIdle;
		firstAddDirty = false;
		OnFirstAnim();
		SetLockState(isLock: true);
	}

	protected override void OnActivateTag()
	{
	}

	public override void ReActivate()
	{
		OnActivate();
	}

	public void OnFirstAnim()
	{
		if (base.Blackboard.isInHide || base.Blackboard.animator == null || !base.Agent.IsInit || !base.Blackboard.isInStage || !base.Blackboard.animator.isActiveAndEnabled)
		{
			firstAddDirty = true;
		}
		else if (!LoopState)
		{
			base.Blackboard.animator.CrossFade(IdleAnim, crossFadeTime, 0, 0f);
		}
		else if (firstIsIdle)
		{
			base.Blackboard.animator.CrossFade(IdleAnim, crossFadeTime, 0, 0f);
			lastInIdleTime = Time.time;
			isInIdle = true;
		}
		else
		{
			NextAnim();
		}
	}

	public override void OnAnimatorPerform()
	{
		if (!LoopState || base.Blackboard.isInHide || base.Blackboard.animator == null || !base.Agent.IsInit || !base.Blackboard.isInStage || !base.Blackboard.animator.isActiveAndEnabled)
		{
			return;
		}
		if (firstAddDirty)
		{
			firstAddDirty = false;
			OnFirstAnim();
			return;
		}
		if (isInIdle)
		{
			if (Time.time - lastInIdleTime >= delayTimer)
			{
				isInIdle = false;
				NextAnim();
			}
			return;
		}
		float num = ((!base.Blackboard.animator.IsInTransition(0)) ? base.Blackboard.animator.GetCurrentAnimatorStateInfo(0).normalizedTime : base.Blackboard.animator.GetAnimatorTransitionInfo(0).normalizedTime);
		if (num >= 0.98f)
		{
			if (delayTimer <= 0f)
			{
				NextAnim();
				return;
			}
			base.Blackboard.animator.CrossFade(IdleAnim, crossFadeTime, 0, 0f);
			lastInIdleTime = Time.time;
			isInIdle = true;
		}
	}

	private void NextAnim()
	{
		if (loopFunc == QWLocomotionCustomIdleFunc.OrderLoop)
		{
			curIdx = (curIdx + 1) % loopAnim.Count;
			base.Blackboard.animator.CrossFade(loopAnim[curIdx], crossFadeTime, 0, 0f);
		}
		else if (loopFunc == QWLocomotionCustomIdleFunc.RandomLoop)
		{
			if (loopAnim.Count <= 1)
			{
				curIdx = 0;
			}
			else
			{
				curIdx = RandomHelper.RandomNumber(0, loopAnim.Count - 1);
			}
			base.Blackboard.animator.CrossFade(loopAnim[curIdx], crossFadeTime, 0, 0f);
		}
	}

	public void SetLockState(bool isLock)
	{
		lockState = isLock;
	}

	public override void SetCanExit()
	{
		CanExit = !lockState;
	}
}
