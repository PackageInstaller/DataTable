using System.Collections.Generic;
using UnityEngine;

public class BBCommom : MonoBehaviour, XBlackboard
{
	public delegate void AgentActionHandler(AgentAction a);

	[HideInInspector]
	public NAgent mAgent;

	public Vector3 DeltaPosition = Vector3.zero;

	public bool OverrideWithDeltaPosition;

	public Vector3 DeltaRotate = Vector3.zero;

	public bool OverrideWithDeltaRotate;

	private bool _isSprinting;

	public CharacterMovement inputMovement;

	public CharacterMovement currentMovement;

	public bool HasMoveDirectionInput;

	public Vector3 MoveDirectionInputDirection;

	private uint frameCount;

	public bool IsPrediction;

	public AgentActionHandler ActionHandler;

	private List<AgentAction> m_ActiveActions = new List<AgentAction>();

	public bool WantsToSprint { get; set; }

	public bool IsSprinting => _isSprinting;

	public int HeroGuid { get; set; }

	public virtual bool IsAlive { get; set; }

	public virtual E_HitRecover IsHitRecovering { get; set; }

	public virtual float FrameTime { get; set; }

	public virtual float FramePercent { get; set; }

	public Vector3 CurrentFramePosition { get; set; }

	public Vector3 NextFramePosition { get; set; }

	public Vector3 LastFrameVelocity { get; set; }

	public Vector3 CurrentFrameVelocity { get; set; }

	public Vector3 CurrentVelocity { get; set; }

	public uint FrameCount
	{
		get
		{
			return frameCount;
		}
		set
		{
			if (frameCount != value)
			{
				OnFrameAdvanceHandler(value);
				frameCount = value;
			}
		}
	}

	public virtual void Initialize()
	{
		mAgent = base.gameObject.GetComponent<NAgent>();
		IsAlive = true;
		CurrentFramePosition = base.transform.position;
		NextFramePosition = base.transform.position;
		XLogger.Assert(mAgent != null, "this gameobject don't have NAgent!");
	}

	public virtual void OnFrameAdvanceHandler(uint frameCount)
	{
	}

	public virtual void StartUpdateBlackboard()
	{
	}

	public virtual void UpdateBlackboard(SimPersistentState stateFrame)
	{
		if (stateFrame is UnitState unitState)
		{
			CurrentFramePosition = NextFramePosition;
			LastFrameVelocity = base.transform.forward;
			NextFramePosition = (OverrideWithDeltaPosition ? DeltaPosition : ((Vector3)unitState.mPostion + DeltaPosition));
			CurrentFrameVelocity = (NextFramePosition - CurrentFramePosition).normalized;
			GameUtil.AngleOfVector(CurrentFrameVelocity);
			CurrentVelocity = (NextFramePosition - CurrentFramePosition) / 0.033f;
			inputMovement = new CharacterMovement(CurrentVelocity.normalized, ((VFactor)unitState.mSpeed).single);
			WantsToSprint = inputMovement.IsSprinting;
			HasMoveDirectionInput = unitState.mHasMoveDirectionInput;
			MoveDirectionInputDirection = (Vector3)unitState.mMoveDirectionInputDirection;
		}
	}

	public virtual void LateUpdateBlackboard(SimPersistentState stateFrame)
	{
	}

	public virtual void EndUpdateBlackboard()
	{
	}

	public void ActionAdd(AgentAction action)
	{
		m_ActiveActions.Add(action);
		ActionHandler(action);
	}

	public void PostUpdate()
	{
		for (int i = 0; i < m_ActiveActions.Count; i++)
		{
			ActionDone(m_ActiveActions[i]);
		}
		m_ActiveActions.Clear();
	}

	private void ActionDone(AgentAction action)
	{
		AgentActionFactory.Return(action);
	}

	public void InputMovement(CharacterMovement movement)
	{
		inputMovement = movement;
		WantsToSprint = movement.IsSprinting;
	}

	public virtual void Update()
	{
	}

	public virtual void ResetBlackboard()
	{
		IsAlive = false;
		ActionHandler = null;
		IsPrediction = false;
		for (int i = 0; i < m_ActiveActions.Count; i++)
		{
			ActionDone(m_ActiveActions[i]);
		}
		m_ActiveActions.Clear();
		inputMovement.Direction = Vector3.zero;
		inputMovement.Magnitude = 0f;
		HasMoveDirectionInput = false;
		MoveDirectionInputDirection = Vector3.zero;
	}
}
