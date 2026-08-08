using Config;
using UnityEngine;

public sealed class BBHumanoid : BBCommom
{
	private bool m_IsFirstFrameData;

	public SimFrameData m_NextSimFrameData;

	public SimFrameData m_LastSimFrameData;

	public float LastHeight;

	public long MaxHP => m_NextSimFrameData.MaxHP;

	public long HP => m_NextSimFrameData.HP;

	public bool IsBorning { get; set; }

	public bool IsReloading => m_NextSimFrameData.IsReloading;

	public bool IsCaught => m_NextSimFrameData.IsCaught;

	public override bool IsAlive => m_NextSimFrameData.IsAlive;

	public override E_HitRecover IsHitRecovering => m_NextSimFrameData.IsHitRecovering;

	public EntityActionStatus MovementStatus => m_NextSimFrameData.mMovementStatus;

	public float Speed => m_NextSimFrameData.Speed;

	public float AttackSpeedParam { get; set; }

	public Vector3 Top => base.transform.position + Vector3.up;

	public Vector3 NextFrameFaceDirection
	{
		get
		{
			return m_NextSimFrameData.FaceDirection;
		}
		set
		{
			m_NextSimFrameData.FaceDirection = value;
		}
	}

	public Vector3 LastFrameFaceDirection
	{
		get
		{
			return m_LastSimFrameData.FaceDirection;
		}
		set
		{
			m_LastSimFrameData.FaceDirection = value;
		}
	}

	public Vector3 CurrentFaceDirection
	{
		get
		{
			return m_NextSimFrameData.FaceDirection;
		}
		set
		{
			m_NextSimFrameData.FaceDirection = value;
		}
	}

	public int AimingTarget => m_NextSimFrameData.mAimingTarget;

	public int CombatScore => m_NextSimFrameData.mCombatScore;

	public RoleConfig RoleLogicConfig { get; set; }

	public int IdleID { get; set; }

	public int RelaxID { get; set; }

	public int BattleIdleID { get; set; }

	public RoleRenderConfig RoleRenderConfig { get; set; }

	public override void Initialize()
	{
		base.Initialize();
		m_NextSimFrameData = new SimFrameData
		{
			ID = 1
		};
		m_LastSimFrameData = new SimFrameData
		{
			ID = 2
		};
		LastFrameFaceDirection = base.transform.forward;
		CurrentFaceDirection = base.transform.forward;
		NextFrameFaceDirection = base.transform.forward;
	}

	public void SwapFrame()
	{
		SimFrameData nextSimFrameData = m_NextSimFrameData;
		m_NextSimFrameData = m_LastSimFrameData;
		m_LastSimFrameData = nextSimFrameData;
	}

	public override void ResetBlackboard()
	{
		base.ResetBlackboard();
		m_NextSimFrameData = null;
		m_LastSimFrameData = null;
		m_IsFirstFrameData = false;
	}

	public override void StartUpdateBlackboard()
	{
	}

	public override void OnFrameAdvanceHandler(uint frameCount)
	{
		base.OnFrameAdvanceHandler(frameCount);
		SwapFrame();
	}

	public override void UpdateBlackboard(SimPersistentState stateFrame)
	{
		base.UpdateBlackboard(stateFrame);
		_ = m_IsFirstFrameData;
		m_NextSimFrameData.Decode(stateFrame, DeltaPosition, OverrideWithDeltaPosition, DeltaRotate, OverrideWithDeltaRotate);
	}

	public override void EndUpdateBlackboard()
	{
		if (!m_IsFirstFrameData)
		{
			m_IsFirstFrameData = true;
			mAgent.Initialize();
		}
		if (m_NextSimFrameData.mEntityConfigID != m_LastSimFrameData.mEntityConfigID && m_LastSimFrameData.mEntityConfigID != 0)
		{
			AgentActionTransfiguration action = AgentActionFactory.Create(AgentActionFactory.E_Type.Transfiguration) as AgentActionTransfiguration;
			ActionAdd(action);
		}
		if (m_NextSimFrameData.mAbilityID == 0 && m_LastSimFrameData.mAbilityID != 0)
		{
			AgentActionAbilityLeave action2 = AgentActionFactory.Create(AgentActionFactory.E_Type.AbilityLeave) as AgentActionAbilityLeave;
			ActionAdd(action2);
		}
		if ((m_NextSimFrameData.mAbilityID > 0 && (m_NextSimFrameData.mAbilityID != m_LastSimFrameData.mAbilityID || m_NextSimFrameData.AbilityFrame < m_LastSimFrameData.AbilityFrame)) || (m_NextSimFrameData.mAbilityID == m_LastSimFrameData.mAbilityID && m_NextSimFrameData.AbilityFrame - m_LastSimFrameData.AbilityFrame > 6))
		{
			if (m_LastSimFrameData.mAbilityID > 0)
			{
				AgentActionAbilityLeave action3 = AgentActionFactory.Create(AgentActionFactory.E_Type.AbilityLeave) as AgentActionAbilityLeave;
				ActionAdd(action3);
			}
			AgentActionAbilityEnter agentActionAbilityEnter = AgentActionFactory.Create(AgentActionFactory.E_Type.AbilityEnter) as AgentActionAbilityEnter;
			agentActionAbilityEnter.mAblityID = m_NextSimFrameData.mAbilityID;
			agentActionAbilityEnter.mFrameCount = m_NextSimFrameData.AbilityFrame;
			agentActionAbilityEnter.mTimeScale = m_NextSimFrameData.AbilityTimeScale;
			ActionAdd(agentActionAbilityEnter);
		}
		if (m_NextSimFrameData.AbilityTimeStep != m_LastSimFrameData.AbilityTimeStep)
		{
			AgentActionTimeStepChange agentActionTimeStepChange = AgentActionFactory.Create(AgentActionFactory.E_Type.TimeStepChange) as AgentActionTimeStepChange;
			agentActionTimeStepChange.mAbilityID = m_NextSimFrameData.mAbilityID;
			agentActionTimeStepChange.mTimeScale = m_NextSimFrameData.AbilityTimeScale;
			ActionAdd(agentActionTimeStepChange);
		}
		if (m_NextSimFrameData.IsReloading != m_LastSimFrameData.IsReloading)
		{
			if (m_NextSimFrameData.IsReloading)
			{
				ActionAdd(AgentActionFactory.Create(AgentActionFactory.E_Type.ReloadEnter));
			}
			else
			{
				ActionAdd(AgentActionFactory.Create(AgentActionFactory.E_Type.ReloadLeave));
			}
		}
		if (m_NextSimFrameData.IsAlive != m_LastSimFrameData.IsAlive && !m_NextSimFrameData.IsAlive)
		{
			ActionAdd(AgentActionFactory.Create(AgentActionFactory.E_Type.Dead));
		}
		bool num = (m_LastSimFrameData.mIsHide & E_EntityHideType.Render) == E_EntityHideType.Render;
		bool flag = (m_NextSimFrameData.mIsHide & E_EntityHideType.Render) == E_EntityHideType.Render;
		if (num != flag)
		{
			AgentActionHide agentActionHide = (AgentActionHide)AgentActionFactory.Create(AgentActionFactory.E_Type.Hide);
			agentActionHide.IsHide = flag;
			ActionAdd(agentActionHide);
		}
		if (m_NextSimFrameData.IsHurt)
		{
			for (int i = 0; i < m_NextSimFrameData.ModifyHpArray.Count; i++)
			{
				AgentActionHurt agentActionHurt = AgentActionFactory.Create(AgentActionFactory.E_Type.Hurt) as AgentActionHurt;
				agentActionHurt.DamageAmount = m_NextSimFrameData.ModifyHpArray[i].mAmount;
				agentActionHurt.damageType = m_NextSimFrameData.ModifyHpArray[i].mDamageType;
				agentActionHurt.ActionID = m_NextSimFrameData.ModifyHpArray[i].mActionID;
				agentActionHurt.SourceID = m_NextSimFrameData.ModifyHpArray[i].mCasterID;
				agentActionHurt.ThrownID = m_NextSimFrameData.ModifyHpArray[i].mThrownID;
				agentActionHurt.partID = m_NextSimFrameData.ModifyHpArray[i].mPartID;
				ActionAdd(agentActionHurt);
			}
			m_NextSimFrameData.IsHurt = false;
		}
		mAgent.IsCanControl = E_HitRecover.OnLeave == m_NextSimFrameData.IsHitRecovering;
		mAgent.IsNeedForceControl = m_NextSimFrameData.HitRecoverStatus == E_HitRecoverStatus.GetUp || m_NextSimFrameData.HitRecoverStatus == E_HitRecoverStatus.HitReocver;
		mAgent.IsNeedForceControl = mAgent.IsNeedForceControl || (m_NextSimFrameData.mAbilityID > 0 && m_NextSimFrameData.mAbilityID % 1000 == 305);
		if ((E_HitRecover.OnUpdate == m_NextSimFrameData.IsHitRecovering && E_HitRecover.OnLeave == m_LastSimFrameData.IsHitRecovering) || E_HitRecover.OnEnter == m_NextSimFrameData.IsHitRecovering || E_HitRecover.OnChange == m_NextSimFrameData.IsHitRecovering)
		{
			AgentActionHitRecoverEnter agentActionHitRecoverEnter = AgentActionFactory.Create(AgentActionFactory.E_Type.HitRecoverEnter) as AgentActionHitRecoverEnter;
			agentActionHitRecoverEnter.IsReset = E_HitRecover.OnEnter == m_NextSimFrameData.IsHitRecovering;
			ActionAdd(agentActionHitRecoverEnter);
		}
		else if (E_HitRecover.OnLeave == m_NextSimFrameData.IsHitRecovering && m_NextSimFrameData.IsHitRecovering != m_LastSimFrameData.IsHitRecovering)
		{
			ActionAdd(AgentActionFactory.Create(AgentActionFactory.E_Type.HitRecoverLeave));
		}
		if (E_HitRecover.OnLeave != m_NextSimFrameData.IsHitRecovering && m_NextSimFrameData.IsHitRecovering != E_HitRecover.None && m_NextSimFrameData.HitAbilityID != 0 && m_NextSimFrameData.HitAbilityID != m_LastSimFrameData.HitAbilityID)
		{
			ActionAdd(AgentActionFactory.Create(AgentActionFactory.E_Type.HitAbilityChange));
		}
		if (IsPrediction && m_NextSimFrameData.mHitRecoverActionID != m_LastSimFrameData.mHitRecoverActionID && m_NextSimFrameData.mHitRecoverActionID != 0)
		{
			AgentActionHitRecoverEnter agentActionHitRecoverEnter2 = AgentActionFactory.Create(AgentActionFactory.E_Type.HitRecoverEnter) as AgentActionHitRecoverEnter;
			agentActionHitRecoverEnter2.IsReset = E_HitRecover.OnEnter == m_NextSimFrameData.IsHitRecovering;
			ActionAdd(agentActionHitRecoverEnter2);
		}
		if (m_NextSimFrameData.HitRecoverTimeStep != m_LastSimFrameData.HitRecoverTimeStep)
		{
			AgentActionTimeStepChange agentActionTimeStepChange2 = AgentActionFactory.Create(AgentActionFactory.E_Type.TimeStepChange) as AgentActionTimeStepChange;
			agentActionTimeStepChange2.mAbilityID = m_NextSimFrameData.mHitRecoverActionID;
			agentActionTimeStepChange2.mTimeScale = m_NextSimFrameData.HitRecoverTimeScale;
			ActionAdd(agentActionTimeStepChange2);
		}
		if (m_NextSimFrameData.MovementTimeStep != m_LastSimFrameData.MovementTimeStep)
		{
			AgentActionTimeStepChange agentActionTimeStepChange3 = AgentActionFactory.Create(AgentActionFactory.E_Type.TimeStepChange) as AgentActionTimeStepChange;
			agentActionTimeStepChange3.mAbilityID = m_NextSimFrameData.MoveID;
			agentActionTimeStepChange3.mTimeScale = m_NextSimFrameData.MovementTimeScale;
			ActionAdd(agentActionTimeStepChange3);
		}
		float num2 = m_NextSimFrameData.EntityTimeScale;
		float num3 = m_LastSimFrameData.EntityTimeScale;
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager != null)
		{
			num2 *= (float)worldStateManager.worldTimeScale / 100f;
			num3 *= (float)worldStateManager.lastWorldTimeScale / 100f;
		}
		if (!Mathf.Approximately(num2, num3) && m_NextSimFrameData.IsIdle)
		{
			AgentActionTimeStepChange agentActionTimeStepChange4 = AgentActionFactory.Create(AgentActionFactory.E_Type.TimeStepChange) as AgentActionTimeStepChange;
			agentActionTimeStepChange4.mAbilityID = -1;
			agentActionTimeStepChange4.mIsIdle = true;
			agentActionTimeStepChange4.mTimeScale = num2;
			ActionAdd(agentActionTimeStepChange4);
		}
		if (m_LastSimFrameData.mSubJoystickCommandCode == 0 && m_NextSimFrameData.mSubJoystickCommandCode != 0)
		{
			AgentActionSubJoystickCommandEnter action4 = AgentActionFactory.Create(AgentActionFactory.E_Type.SubJoystickEnter) as AgentActionSubJoystickCommandEnter;
			ActionAdd(action4);
		}
		if (m_NextSimFrameData.mSubJoystickCommandCode != 0)
		{
			AgentActionSubJoystickCommandUpdate agentActionSubJoystickCommandUpdate = AgentActionFactory.Create(AgentActionFactory.E_Type.SubJoystickUpdate) as AgentActionSubJoystickCommandUpdate;
			agentActionSubJoystickCommandUpdate.CommandCode = m_NextSimFrameData.mSubJoystickCommandCode;
			agentActionSubJoystickCommandUpdate.TimelineID = m_NextSimFrameData.mSubJoysitckTimelineID;
			ActionAdd(agentActionSubJoystickCommandUpdate);
		}
		if (m_LastSimFrameData.mSubJoystickCommandCode != 0 && m_NextSimFrameData.mSubJoystickCommandCode == 0)
		{
			AgentActionSubJoystickCommandExit action5 = AgentActionFactory.Create(AgentActionFactory.E_Type.SubJoystickExit) as AgentActionSubJoystickCommandExit;
			ActionAdd(action5);
		}
	}
}
