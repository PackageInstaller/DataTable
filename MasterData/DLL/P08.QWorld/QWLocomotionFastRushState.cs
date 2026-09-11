using System;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "FastRushState", menuName = "箱庭/Locomotion/FastRushAsset")]
public class QWLocomotionFastRushState : QWLocomotionState
{
	public QWLocomotionAnimParam rush;

	public QWLocomotionAnimParam rushEnd;

	public QWLocomotionAnimParam rushStart;

	public QWLocomotionStopAnimAudio rushEndAudio;

	public QWLocomotionStopAnimAudio exitMoveAudio;

	public string rushAudioCueName;

	public string rushAudioCueSheet;

	public string rushStopAudioCueName;

	public string rushStopAudioCueSheet;

	public string rushStartEffectPath;

	[NonSerialized]
	private GameObject rushEffect;

	public float coolDown;

	public float endAnimDuration;

	public float fastRushDelay = 0.5f;

	private float startTime;

	[HideInInspector]
	public float exitTime;

	[HideInInspector]
	public bool isActionExitDirty;

	private float startDuration;

	public override QWLocomotionStateEnum GetStateEnum()
	{
		return QWLocomotionStateEnum.FastRush;
	}

	public bool CheckNeedReEnterFastRush()
	{
		if (Time.time - exitTime <= fastRushDelay)
		{
			return true;
		}
		return false;
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
				if (mBehaviour.IsInRush && mBehaviour.IsInFastRush)
				{
					return true;
				}
			}
			else if (qWCharacterBlackboard.inputMovement.Magnitude >= 0.8f)
			{
				if (mBehaviour.IsInFastRush)
				{
					return true;
				}
				if (CheckNeedReEnterFastRush())
				{
					if (!mBehaviour.IsInRush)
					{
						mBehaviour.IsInRush = true;
					}
					if (!mBehaviour.IsInFastRush)
					{
						mBehaviour.IsInFastRush = true;
					}
					return true;
				}
			}
			return false;
		}
		if (mBehaviour.IsInRush && mBehaviour.IsInFastRush && mBehaviour.mWalkStep > 0f)
		{
			return true;
		}
		return false;
	}

	protected override void OnActivateTag()
	{
		mBehaviour.DisableRotation = false;
		mBehaviour.ForceOnGround = true;
		mBehaviour.UseGravity = false;
		mBehaviour.AllowRush = false;
		mBehaviour.AllowFastRush = false;
	}

	public override void OnActivate()
	{
		if (rushEffect == null)
		{
			GameObject original = Asset.Load<GameObject>(rushStartEffectPath);
			rushEffect = UnityEngine.Object.Instantiate(original, mBehaviour.transform);
			rushEffect.transform.localPosition = new Vector3(0f, 0.314f, -0.682f);
			rushEffect.transform.localRotation = Quaternion.Euler(0f, 90f, 0f);
		}
		if (mBehaviour.IsPlayer)
		{
			AudioManager.Instance.Play("effect", rushAudioCueSheet, rushAudioCueName, useStream: false);
		}
		rushEffect.SetActive(value: true);
		CanExit = false;
		startTime = Time.time;
		startDuration = 0f;
		if (mBehaviour.CheckLastIsInState(QWLocomotionStateEnum.Move))
		{
			if (!mBehaviour.CurAnimation.Equals(rush.animName))
			{
				mBehaviour.Anim?.CrossFade(rush.animName, rush.crossFade, 0, 0f);
				mBehaviour.CurAnimation = rush.animName;
			}
		}
		else if (!mBehaviour.CurAnimation.Equals(rushStart.animName))
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
			mBehaviour.Anim.SetFloat("FastRunSpeed", mBehaviour.FastRunSpeedRatio);
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
		mBehaviour.IsInFastRush = false;
		rushEffect.SetActive(value: false);
		if (!isActionExitDirty)
		{
			exitTime = Time.time;
		}
		else
		{
			isActionExitDirty = false;
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
