using System;
using UnityEngine;

[Serializable]
public abstract class QWLocomotionState : ScriptableObject
{
	protected QWLocomotionBehaviour mBehaviour;

	private bool mSpeedDirty = true;

	[HideInInspector]
	public bool CanExit = true;

	public int Priority;

	protected QWAgent Agent => mBehaviour?.mAgent;

	protected QWBlackboard Blackboard => Agent?.Blackboard;

	public bool SpeedDirty
	{
		get
		{
			return mSpeedDirty;
		}
		set
		{
			mSpeedDirty = true;
		}
	}

	public bool CanBeActivated => false;

	public bool IgnoreLowerStates { get; set; }

	public abstract QWLocomotionStateEnum GetStateEnum();

	public void Init(QWLocomotionBehaviour bv)
	{
		mBehaviour = bv;
		OnInit();
	}

	protected virtual void OnInit()
	{
	}

	public virtual void InputAxisUpdate()
	{
	}

	public virtual void SetCanExit()
	{
		CanExit = true;
	}

	public virtual void OnStatePreMove()
	{
	}

	public virtual void OnStateMove()
	{
	}

	public virtual void OnAnimatorPerform()
	{
	}

	public virtual bool AllowExit()
	{
		_ = CanExit;
		return CanExit;
	}

	public virtual void TryExitState()
	{
	}

	public virtual bool TryActivate()
	{
		return CanBeActivated;
	}

	private bool StatePreCheck()
	{
		if (!mBehaviour.IsPlayer || QWorldScene.Scene == null)
		{
			return true;
		}
		QWLocomotionStateEnum stateEnum = GetStateEnum();
		QWInteractionModeEnum interactMode = QWorldScene.GetQWorldContext().InteractMode;
		if (stateEnum == QWLocomotionStateEnum.Idle || stateEnum == QWLocomotionStateEnum.Interactive || stateEnum == QWLocomotionStateEnum.Falling)
		{
			return true;
		}
		switch (interactMode)
		{
		case QWInteractionModeEnum.ONLY_CONTROL_WALK:
			return stateEnum == QWLocomotionStateEnum.Move;
		case QWInteractionModeEnum.ONLY_CONTROL_RUN:
			if (stateEnum != QWLocomotionStateEnum.Rush)
			{
				return stateEnum == QWLocomotionStateEnum.FastRush;
			}
			return true;
		default:
			return true;
		}
	}

	public void Activate()
	{
		if (!mBehaviour.JustActivateState && StatePreCheck())
		{
			mBehaviour.ActiveState = this;
			SetSpeed();
			OnActivateTag();
			OnActivate();
		}
	}

	public virtual void ReActivate()
	{
	}

	public virtual void OnActivate()
	{
	}

	protected abstract void OnActivateTag();

	protected virtual void SetSpeed()
	{
	}

	public virtual void OnPlataformChanged()
	{
	}

	public virtual bool GetEndAnim(out QWLocomotionAnimParam anim, out QWLocomotionStopAnimAudio audio)
	{
		anim = default(QWLocomotionAnimParam);
		audio = default(QWLocomotionStopAnimAudio);
		return false;
	}

	public virtual void OnExit(QWLocomotionStateEnum nextState)
	{
	}

	public void ChangeGroundState()
	{
		if (!mBehaviour.CheckIfGrounded() && mBehaviour.Grounded)
		{
			mBehaviour.Grounded = false;
		}
	}

	protected void CheckForwardWall()
	{
		mBehaviour.WallHit = null;
		float lowWallHeight = mBehaviour.LowWallHeight;
		if (Physics.Raycast(mBehaviour.Position + mBehaviour.UpVector.normalized * lowWallHeight, layerMask: mBehaviour.GroundLayer.value | mBehaviour.BlockLayer.value, direction: mBehaviour.Forward, hitInfo: out var hitInfo, maxDistance: mBehaviour.BodySize.x / 2f + 0.02f))
		{
			mBehaviour.WallHit = hitInfo.transform;
		}
		else
		{
			mBehaviour.WallHit = null;
		}
	}
}
