using System.Collections.Generic;
using Config;
using Entitas;
using UnityEngine;

public class AllEntityProccessorSystem : IExecuteSystem, ISystem, IInitializeSystem, ICleanupSystem
{
	private SimContext mSimContext;

	private IGroup<SimEntity> mEnityInputGroup;

	private IGroup<SimEntity> mEnityAbilityLogicInputGroup;

	private IGroup<SimEntity> mEnityRemoteMovementGroup;

	private IGroup<SimEntity> mEnityJumpGroup;

	private IGroup<SimEntity> mEntityBuffGroup;

	private IGroup<SimEntity> mEntityBlackboardWithoutAI;

	private IGroup<SimEntity> mEnityBornGroup;

	private IGroup<SimEntity> mEnityHPModifyGroup;

	private IGroup<SimEntity> mEntityBlackboard;

	private IGroup<SimEntity> mEntityTimerGroup;

	private IGroup<SimEntity> mEntityPuppetGroup;

	private List<SimEntity> mEntityBuffer = new List<SimEntity>();

	private IGroup<SimEntity> mEntityWithAbility;

	private IGroup<SimEntity> mEntityWithHitRecover;

	private IGroup<SimEntity> mEntityCombo;

	private IGroup<SimEntity> mEntityEndurance;

	private IGroup<SimEntity> mEntityResistance;

	private IGroup<SimEntity> mEntityAbilityDirection;

	private IGroup<SimEntity> mEntityStatisticalState;

	private IGroup<SimEntity> mEntityCombatScore;

	private IGroup<SimEntity> mEntityAvoidShadow;

	private IGroup<SimEntity> mEntityPostureValueGroup;

	private IGroup<SimEntity> mEntityQTEGroup;

	private IGroup<SimEntity> mEntityMoveClampGroup;

	public AllEntityProccessorSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
		CommonProcessor.Initialize(mSimContext);
		AbilitiesProcessor.Initialize(mSimContext);
		AIProcessor.Initialize(mSimContext);
		BuffProcessor.Initialize(mSimContext);
		AttributeProcessor.Initialize(mSimContext);
		ConfigProcessor.Initialize(mSimContext);
		DetectableProcessor.Initialize(mSimContext);
		ModifyHealthProcessor.Initialize(mSimContext);
		MovementProcessor.Initialize(mSimContext);
		ProjectileProcessor.Initialize(mSimContext);
		RecastGraphProcessor.Initialize(mSimContext);
		SpawnProcessor.Initialize(mSimContext);
		ThrownProcessor.Initialize(mSimContext);
		CDProcessor.Initialize(mSimContext);
		mEnityInputGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionManualInput).NoneOf(SimMatcher.EntityHide));
		mEnityAbilityLogicInputGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionAbilityLogicInput).NoneOf(SimMatcher.EntityHide));
		mEnityRemoteMovementGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionMoveDirection).NoneOf(SimMatcher.EntityHide));
		mEnityJumpGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionJump).NoneOf(SimMatcher.EntityHide));
		mEntityBuffGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBuff).NoneOf(SimMatcher.EntityHide));
		mEnityBornGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionBorn).NoneOf(SimMatcher.EntityHide));
		mEnityHPModifyGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionModifyHP));
		mEntityWithAbility = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionAbility).NoneOf(SimMatcher.EntityHide));
		mEntityWithHitRecover = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityHitRecover).NoneOf(SimMatcher.EntityHide));
		mEntityBlackboard = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBlackboard).NoneOf(SimMatcher.EntityHide));
		mEntityBlackboardWithoutAI = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBlackboard).NoneOf(SimMatcher.EntityHide, SimMatcher.EntityAIThink));
		mEntityTimerGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityTimer).NoneOf(SimMatcher.EntityHide));
		mEntityCombo = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityComboNumber).NoneOf(SimMatcher.EntityHide));
		mEntityEndurance = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityEndurance).NoneOf(SimMatcher.EntityHide));
		mEntityResistance = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityResistance).NoneOf(SimMatcher.EntityHide));
		mEntityAbilityDirection = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionAbilityDirection).NoneOf(SimMatcher.EntityHide));
		mEntityPuppetGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityPuppet).NoneOf(SimMatcher.EntityHide));
		mEntityStatisticalState = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBlackboard).NoneOf(SimMatcher.EntityHide));
		mEntityAvoidShadow = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionAvoidShadow).NoneOf(SimMatcher.EntityHide));
		mEntityCombatScore = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBlackboard, SimMatcher.EntityActionModifyCombatScore).NoneOf(SimMatcher.EntityHide));
		mEntityPostureValueGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityPostureValue).NoneOf(SimMatcher.EntityHide));
		mEntityQTEGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityQTE));
		mEntityMoveClampGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityMoveClamp, SimMatcher.EntityPositon).NoneOf(SimMatcher.EntityHide));
	}

	public void Execute()
	{
		Begin();
		Process();
		End();
	}

	public void Begin()
	{
		Process_LogicInput();
		Process_Input();
		Process_MoveInput();
		Process_TimeScale();
		Process_ReadyLogic();
	}

	public void Process()
	{
		Process_Born();
		Process_AvoidShadow();
		Process_Abilities();
		Process_Thrown();
		Process_Puppet();
		Process_HitRecover();
		Process_AbilityBuff();
		Process_MoveDirection();
	}

	public void End()
	{
		Process_HealthModifications();
		Process_StatisticalEntityState();
		Process_BuffModification();
		Process_LateInput();
		Process_Idle();
		Process_GamePause();
		Process_GameOver();
	}

	private void Process_BuffModification()
	{
		mEntityBuffGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			simEntity.entityBuff.ReleasePendingRemoveArray();
		});
		mEntityTimerGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			simEntity.entityTimer.ReleasePendingRemoveArray();
		});
	}

	private void Process_StatisticalEntityState()
	{
		mEntityStatisticalState.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
			int num = IntMath.Clamp(roleConfig.Ability.Count, 0, 4);
			for (int i = 0; i < num; i++)
			{
				int abilityByInput = AbilitiesProcessor.GetAbilityByInput(simEntity, i);
				if (AbilitiesProcessor.InterruptSelfByAbilityID(simContext, simEntity.creationIndex, abilityByInput))
				{
					simEntity.entityBlackboard.var.mAbilityOriginalCanUse = (byte)(simEntity.entityBlackboard.var.mAbilityOriginalCanUse | (1 << i));
				}
				else
				{
					simEntity.entityBlackboard.var.mAbilityOriginalCanUse = (byte)(simEntity.entityBlackboard.var.mAbilityOriginalCanUse & ~(1 << i));
				}
			}
		});
		mEntityCombatScore.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (simEntity.entityActionModifyCombatScore.mStatus == EntityActionStatus.E_ACTIVE)
			{
				simContext.GetSimInterface().mCalculateCombatScoreLogic?.Invoke(simEntity.creationIndex);
				simEntity.entityActionModifyCombatScore.mStatus = EntityActionStatus.E_SUCCESS;
			}
		});
	}

	private void Process_TimeScale()
	{
		SimWorldState worldState = CommonProcessor.GetWorldState();
		worldState.UpdateCommonWorldTimeScaleValue();
	}

	private void Process_Puppet()
	{
		mEntityPuppetGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mPuppetEvent != null)
			{
				simContext.GetSimInterface().mPuppetEvent(simEntity.creationIndex, simEntity.entityPuppet.mParent);
			}
		});
	}

	private void Process_ReadyLogic()
	{
		if (mSimContext.GetSimInterface() != null && mSimContext.GetSimInterface().mUpdateLogicEvent != null)
		{
			mSimContext.GetSimInterface().mUpdateLogicEvent();
		}
		mEntityCombo.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mComboTimeEvent != null)
			{
				simContext.GetSimInterface().mComboTimeEvent(simEntity.creationIndex);
			}
		});
		mEntityEndurance.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mEnduranceUpdateEvent != null)
			{
				simContext.GetSimInterface().mEnduranceUpdateEvent(simEntity.creationIndex);
			}
		});
		mEntityResistance.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			EntityResistance entityResistance = simEntity.entityResistance;
			if (entityResistance.curValue >= entityResistance.maxValue)
			{
				if (!entityResistance.reState)
				{
					entityResistance.reState = true;
					if (entityResistance.element != null)
					{
						for (int i = 0; i < entityResistance.maxValue && i < entityResistance.element.Count; i++)
						{
							entityResistance.reStateEle = entityResistance.element[i];
						}
					}
					if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mResistanceEvent != null)
					{
						simContext.GetSimInterface().mResistanceEvent(simEntity.creationIndex, arg2: true);
					}
				}
				if (entityResistance.curTime < entityResistance.maxTime)
				{
					entityResistance.curTime += (uint)CommonProcessor.GetLogicConstTick();
					entityResistance.exitReason = 0;
				}
				if (entityResistance.curTime >= entityResistance.maxTime)
				{
					entityResistance.reState = false;
					entityResistance.curTime = 0u;
					entityResistance.curValue = 0;
					if (entityResistance.element != null)
					{
						entityResistance.element.Clear();
					}
					if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mResistanceEvent != null)
					{
						simContext.GetSimInterface().mResistanceEvent(simEntity.creationIndex, arg2: false);
					}
				}
			}
		});
		mEntityPostureValueGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (CommonProcessor.GetWorldState().mLogicTimerPauseFlag == 0 && !CommonProcessor.InTimelineCantBreakTime(simEntity))
			{
				simEntity.entityPostureValue.curTime -= CommonProcessor.GetLogicConstTick();
				if (simEntity.entityPostureValue.value <= 0 && simEntity.entityPostureValue.state != BreakState.breakState)
				{
					simEntity.entityPostureValue.value = 0;
					simEntity.entityPostureValue.state = BreakState.breakState;
					simEntity.entityPostureValue.curTime = simEntity.entityPostureValue.breakMaxTime;
					simContext.PostEvent(EntityBreakEvent.Claim(simEntity.creationIndex, BreakState.breakState));
				}
				if (simEntity.entityPostureValue.curTime <= 0)
				{
					switch (simEntity.entityPostureValue.state)
					{
					case BreakState.breakState:
						simEntity.entityPostureValue.state = BreakState.breakCDState;
						simEntity.entityPostureValue.curTime = simEntity.entityPostureValue.breakCDTime;
						simEntity.entityPostureValue.value = simEntity.entityPostureValue.maxValue;
						simContext.PostEvent(EntityBreakEvent.Claim(simEntity.creationIndex, BreakState.breakCDState));
						break;
					case BreakState.breakCDState:
						simEntity.entityPostureValue.state = BreakState.delay;
						simEntity.entityPostureValue.curTime = simEntity.entityPostureValue.delayTime;
						simContext.PostEvent(EntityBreakEvent.Claim(simEntity.creationIndex, BreakState.delay));
						break;
					case BreakState.tick:
					case BreakState.delay:
						simEntity.entityPostureValue.state = BreakState.tick;
						simEntity.entityPostureValue.curTime += simEntity.entityPostureValue.intervalTime;
						simEntity.entityPostureValue.value += simEntity.entityPostureValue.deltaValue;
						if (simEntity.entityPostureValue.value > simEntity.entityPostureValue.maxValue)
						{
							simEntity.entityPostureValue.value = simEntity.entityPostureValue.maxValue;
						}
						break;
					}
				}
			}
		});
	}

	private void Process_Thrown()
	{
		ThrownProcessor.ProcessThrown();
	}

	private void Process_LateInput()
	{
		mEnityInputGroup.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			if (simEntity.entityActionManualInput.mCanDestroy)
			{
				simEntity.RemoveEntityActionManualInput();
			}
		});
		mEntityAbilityDirection.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			simEntity.RemoveEntityActionAbilityDirection();
		});
	}

	private void Process_Idle()
	{
		mEntityBlackboard.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
			bool flag = false;
			bool flag2 = simEntity.hasEntityActionAbility;
			if (flag2 && (roleConfig.Appear == simEntity.entityActionAbility.mAbilityID || simEntity.entityBlackboard.var.mBattleIldeRecoverSlot == simEntity.entityActionAbility.mAbilityID))
			{
				flag2 = false;
				flag = simEntity.entityBlackboard.var.mBattleIldeRecoverSlot == simEntity.entityActionAbility.mAbilityID;
			}
			if (flag2 || simEntity.hasEntityHitRecover || simEntity.hasEntityActionMoveDirection)
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(roleConfig.BattleIdle);
				simEntity.entityBlackboard.var.BattleIdleTime = (2500 / config.Duration + 1) * config.Duration;
				simEntity.entityBlackboard.var.IdleState = E_IdleType.Battle;
			}
			else if (E_IdleType.Battle == simEntity.entityBlackboard.var.IdleState && (simEntity.entityBlackboard.var.BattleIdleTime -= CommonProcessor.GetLogicConstTick()) <= 0)
			{
				simEntity.entityBlackboard.var.BattleIdleTime = 0;
				simEntity.entityBlackboard.var.IdleState = E_IdleType.BattleRecover;
				AbilitiesProcessor.SetNextFrameAbility(simEntity, simEntity.entityBlackboard.var.mBattleIldeRecoverSlot, forceBroken: false);
			}
			else if (!flag && E_IdleType.BattleRecover == simEntity.entityBlackboard.var.IdleState)
			{
				simEntity.entityBlackboard.var.IdleState = E_IdleType.Normal;
			}
		});
	}

	private void Process_HitRecover()
	{
		mEntityWithHitRecover.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			if (simEntity.hasEntityHitRecover)
			{
				AbilitiesProcessor.ProcessHitRecover(simEntity);
			}
		});
	}

	private void Process_Abilities()
	{
		mEntityWithAbility.GetEntities(mEntityBuffer);
		for (int i = 0; i < mEntityBuffer.Count; i++)
		{
			SimEntity simEntity = mEntityBuffer[i];
			AbilitiesProcessor.ProcessAbility(simEntity);
			AbilitiesProcessor.ProcessUltimateAvoidFrame(mSimContext, simEntity);
		}
	}

	private void Process_AvoidShadow()
	{
		mEntityAvoidShadow.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			AbilitiesProcessor.ProcessAvoidShadow(simEntity);
		});
	}

	private void Process_AbilityBuff()
	{
		mEntityBuffGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			EntityBuff entityBuff = simEntity.entityBuff;
			for (int num2 = entityBuff.mDuringArray.Count - 1; num2 >= 0; num2--)
			{
				if (!entityBuff.IsInPendingRemoveArray(entityBuff.mBuffID[num2]))
				{
					BuffParams value = entityBuff.mBuffParamsArray[num2];
					value.mBindLife = EBuffLife.None;
					if (entityBuff.mBuffRuntime[num2] <= 0)
					{
						if (simEntity.hasEntityBuff && simContext.GetSimInterface() != null && simContext.GetSimInterface().mUpdateBuffLogicEvent != null)
						{
							simContext.GetSimInterface().mUpdateBuffLogicEvent(simEntity.creationIndex, num2, entityBuff.mBuffClassIDArray[num2], EBuffLife.Tick, arg5: false);
						}
						value = entityBuff.mBuffParamsArray[num2];
						value.mBindLife = EBuffLife.Tick;
						entityBuff.mBuffRuntime[num2] += entityBuff.mTickArray[num2];
					}
					entityBuff.mBuffParamsArray[num2] = value;
					entityBuff.mBuffRuntime[num2] -= CommonProcessor.GetLogicConstTick();
					entityBuff.mDuringArray[num2] -= CommonProcessor.GetLogicConstTick();
				}
			}
		});
		mEntityTimerGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			for (int num2 = simEntity.entityTimer.entityTimers.Count - 1; num2 >= 0; num2--)
			{
				EntityTimerStruct entityTimerStruct = simEntity.entityTimer.entityTimers[num2];
				if (!simEntity.entityTimer.IsInPendingRemoveArray(entityTimerStruct.id))
				{
					if (entityTimerStruct.duringTime > 0 && entityTimerStruct.runningTime <= 0)
					{
						simContext.PostEvent(EntityTimerEvent.Claim(entityTimerStruct, EBuffLife.Tick, simEntity.creationIndex));
						entityTimerStruct.runningTime += entityTimerStruct.intervalTime;
					}
					entityTimerStruct.duringTime -= CommonProcessor.GetLogicConstTick();
					entityTimerStruct.runningTime -= CommonProcessor.GetLogicConstTick();
					simEntity.entityTimer.entityTimers[num2] = entityTimerStruct;
				}
			}
		});
		mEntityQTEGroup.GetEntities(mEntityBuffer);
		for (int num = 0; num < mEntityBuffer.Count; num++)
		{
			EntityQTE entityQTE = mEntityBuffer[num].entityQTE;
			if (entityQTE.mStatus == QTEStatusType.Start)
			{
				mSimContext.PostEvent(QTEEvent.Claim(entityQTE.mID, mEntityBuffer[num].creationIndex, entityQTE.mTime, entityQTE.mTotalTime, entityQTE.mStatus));
				entityQTE.mStatus = QTEStatusType.Running;
			}
			if (entityQTE.mStatus != QTEStatusType.Running)
			{
				mSimContext.PostEvent(QTEEvent.Claim(entityQTE.mID, mEntityBuffer[num].creationIndex, entityQTE.mTime, entityQTE.mTotalTime, entityQTE.mStatus));
				mEntityBuffer[num].RemoveEntityQTE();
				continue;
			}
			entityQTE.mTime += CommonProcessor.GetLogicConstTick();
			if (entityQTE.mTime > entityQTE.mTotalTime)
			{
				entityQTE.mStatus = QTEStatusType.Timeout;
			}
		}
	}

	private void Process_Input()
	{
		mEnityInputGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mLogicInputEvent != null)
			{
				simContext.GetSimInterface().mLogicInputEvent(simEntity.creationIndex, simEntity.entityActionManualInput.mInputKey);
			}
			if (simEntity.entityActionManualInput.mStatus == EntityActionStatus.E_ACTIVE)
			{
				int mInputKey = simEntity.entityActionManualInput.mInputKey;
				int abilityID = 0;
				if (simEntity.hasEntityActionAbility)
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityActionAbility.mAbilityID);
					if (config == null)
					{
						Debug.LogError((object)("无法找到 == " + simEntity.entityActionAbility.mAbilityID));
					}
					int mLogicTime = simEntity.entityActionAbility.mLogicTime;
					bool flag = config.InputActionTimelineNode.Enable && mLogicTime >= config.InputActionTimelineNode.Start;
					simEntity.entityActionManualInput.mCanDestroy = !flag;
					MovementProcessor.Stop(simEntity);
					if (mLogicTime > config.ComboOverTime)
					{
						simEntity.entityBlackboard.var.meleeIndex = 0;
					}
				}
				else
				{
					simEntity.entityActionManualInput.mCanDestroy = true;
				}
				if (AbilitiesProcessor.TryAddAbilityByInput(simEntity, mInputKey, out abilityID))
				{
					RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
					if (5 != mInputKey)
					{
						simEntity.entityBlackboard.var.meleeIndex = 0;
					}
					else
					{
						int count = simEntity.entityBlackboard.var.mMeleesSlots.Count;
						int meleeIndex = (simEntity.entityBlackboard.var.meleeIndex + 1) % count;
						simEntity.entityBlackboard.var.meleeIndex = meleeIndex;
					}
					for (int i = 0; i < roleConfig.AvoidAbility.Count; i++)
					{
						if (roleConfig.AvoidAbility.get_Item(i) == abilityID)
						{
							if (simEntity.hasEntityActionMoveDirection)
							{
								if (simEntity.entityActionMoveDirection.mDirection.sqrMagnitudeLong > 1)
								{
									simEntity.entityPositon.mForward = simEntity.entityActionMoveDirection.mDirection;
								}
								simEntity.entityPositon.mForwardAngle = IntMath.AngleOfVector(simEntity.entityPositon.mForward);
								simEntity.RemoveEntityActionMoveDirection();
							}
							break;
						}
					}
					if (simEntity.hasEntityActionMoveDirection)
					{
						MovementProcessor.SetForwardImmediately(simEntity, simEntity.entityActionMoveDirection.mDirection);
					}
					simEntity.entityActionManualInput.mCanDestroy = true;
				}
				if (mInputKey == 5 && abilityID != 0)
				{
					if (!AttributeProcessor.IsEnableAbility(simEntity, abilityID))
					{
						simEntity.entityBlackboard.var.meleeIndex = 0;
					}
				}
				else if (30 == mInputKey)
				{
					mSimContext.GetSimInterface().mButtonShootEvent(simEntity.entityBlackboard.var.mAimTarget);
					simEntity.entityBlackboard.var.mAimTarget = 0;
				}
			}
		});
		mEntityBlackboardWithoutAI.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			long baseValue = 0L;
			long plusValue = 0L;
			long tempPlusValue = 0L;
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2192, out baseValue, out plusValue, out tempPlusValue);
			if (baseValue != 0L)
			{
				SignalExchangeEvent evt = SignalExchangeEvent.Claim(simEntity.creationIndex, (int)baseValue);
				mSimContext.PostEvent(evt);
				AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2192, 0L, 0L, 0L);
			}
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2193, out baseValue, out plusValue, out tempPlusValue);
			if (baseValue != 0L)
			{
				OnlineReadyEvent evt2 = OnlineReadyEvent.Claim(simEntity.creationIndex, baseValue == 2);
				mSimContext.PostEvent(evt2);
				AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2193, 0L, 0L, 0L);
			}
		});
	}

	private void Process_MoveInput()
	{
		mEnityRemoteMovementGroup.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			if ((simEntity.hasEntityActionAbility || simEntity.hasEntityHitRecover) && AbilitiesProcessor.InterruptCheck(simEntity.creationIndex, simEntity, 0, simEntity.entityBlackboard.var.mRunSlot, 0))
			{
				MovementProcessor.EnableMovement(simEntity, isActive: true);
				if (simEntity.hasEntityActionAbility)
				{
					simEntity.entityBlackboard.var.meleeIndex = 0;
					simEntity.entityBlackboard.var.mActionBusy = false;
					simEntity.RemoveEntityActionAbility();
				}
				if (simEntity.hasEntityHitRecover)
				{
					simEntity.RemoveEntityHitRecover();
				}
			}
		});
	}

	private void Process_LogicInput()
	{
		mEnityAbilityLogicInputGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			int mBrokenAbilityID = simEntity.entityActionAbilityLogicInput.mBrokenAbilityID;
			bool mForceBroken = simEntity.entityActionAbilityLogicInput.mForceBroken;
			AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, mBrokenAbilityID, mForceBroken);
			simEntity.RemoveEntityActionAbilityLogicInput();
		});
		mEnityJumpGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			switch (simEntity.entityActionJump.mStatus)
			{
			case E_JumpActionStatus.None:
				AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, simEntity.entityBlackboard.var.mJumpStartSlot, forceBorken: false);
				break;
			case E_JumpActionStatus.Start:
				if (!simEntity.hasEntityActionAbility || simEntity.entityActionAbility.mAbilityID != simEntity.entityBlackboard.var.mJumpStartSlot)
				{
					AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, simEntity.entityBlackboard.var.mJumpStartSlot, forceBorken: false);
				}
				break;
			case E_JumpActionStatus.UpLoop:
				if (!simEntity.hasEntityActionAbility || simEntity.entityActionAbility.mAbilityID != simEntity.entityBlackboard.var.mJumpUpLoopSlot)
				{
					AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, simEntity.entityBlackboard.var.mJumpUpLoopSlot, forceBorken: false);
				}
				break;
			case E_JumpActionStatus.Air:
				if (!simEntity.hasEntityActionAbility || simEntity.entityActionAbility.mAbilityID != simEntity.entityBlackboard.var.mJumpAirSlot)
				{
					AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, simEntity.entityBlackboard.var.mJumpAirSlot, forceBorken: false);
				}
				break;
			case E_JumpActionStatus.DownLoop:
				if (!simEntity.hasEntityActionAbility || simEntity.entityActionAbility.mAbilityID != simEntity.entityBlackboard.var.mJumpDownLoopSlot)
				{
					AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, simEntity.entityBlackboard.var.mJumpDownLoopSlot, forceBorken: false);
				}
				break;
			case E_JumpActionStatus.Land:
				if (!simEntity.hasEntityActionAbility || simEntity.entityActionAbility.mAbilityID != simEntity.entityBlackboard.var.mJumpLandSlot)
				{
					simEntity.RemoveEntityActionJump();
				}
				break;
			}
		});
	}

	private void Process_MoveDirection()
	{
		mEnityRemoteMovementGroup.DoAction(delegate(SimEntity entity)
		{
			MovementProcessor.MoveDirection(entity);
			int mMoveID = entity.entityActionMoveDirection.mMoveID;
			if ((mMoveID == entity.entityBlackboard.var.mRunSlot || mMoveID == entity.entityBlackboard.var.mRushIDSlot) && entity.hasEntityBlackboard && entity.entityBlackboard.var.mHasTurnMoveID && !entity.hasEntityActionAbilityLogicInput)
			{
				long n = Int3.Dot(entity.entityActionMoveDirection.mDirection, entity.entityPositon.mForward);
				VFactor vFactor = IntMath.acos(new VFactor(n, 1000000L)) * IntMath.Rad2Deg;
				long num = Int3.Det(entity.entityActionMoveDirection.mDirection, entity.entityPositon.mForward);
				if (vFactor > entity.entityBlackboard.var.mTurnLimitAngle)
				{
					if (num > 0 && entity.entityBlackboard.var.mTurnRightMoveID != 0)
					{
						AbilitiesProcessor.SetNextFrameAbility(entity, entity.entityBlackboard.var.mTurnRightMoveID, forceBroken: false);
					}
					else if (num < 0 && entity.entityBlackboard.var.mTurnLeftMoveID != 0)
					{
						AbilitiesProcessor.SetNextFrameAbility(entity, entity.entityBlackboard.var.mTurnLeftMoveID, forceBroken: false);
					}
				}
			}
		});
		mEntityMoveClampGroup.DoAction(delegate(SimEntity entity)
		{
			MovementProcessor.MoveClamp(entity);
		});
	}

	private void Process_Born()
	{
		mEnityBornGroup.DoAction(mSimContext, delegate(SimContext simContext, SimEntity entity)
		{
			if (entity.entityActionBorn.mStatus == EntityActionStatus.E_ACTIVE)
			{
				entity.entityActionBorn.mBornDuring -= CommonProcessor.GetLogicConstTick();
				if (entity.entityActionBorn.mBornDuring <= 0)
				{
					entity[EntityVarName.ENTITY_AI_READY] = true;
					entity.entityActionBorn.mStatus = EntityActionStatus.E_SUCCESS;
				}
			}
		});
	}

	private static void SendDoFinalActionEvent(SimContext simContext, SimEntity entity, int deathID)
	{
		if (RoleCampProcessor.IsEnemy(entity.entityCamp.mRoleTypeCamp))
		{
			simContext.sEntityWorldState.status.mCurrentAliveMonsterCount--;
		}
		if (RoleCampProcessor.IsPlayer(entity.entityCamp.mRoleTypeCamp))
		{
			simContext.sEntityWorldState.status.mCurrentAliveHeroCount--;
		}
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entity.entityBlackboard.var.mKillerID);
		int arg = 0;
		if (entityWithEntityID != null)
		{
			arg = entityWithEntityID.entityBlackboard.var.mLastHitAbilityID;
		}
		if (simContext.GetSimInterface().mDoFinalActionEvent != null)
		{
			simContext.GetSimInterface().mDoFinalActionEvent(entity.creationIndex, deathID, arg, entity.entityBlackboard.var.mKillerID, entity.entityBlackboard.var.mKillThrownID);
		}
	}

	public void Process_HealthModifications()
	{
		if (!mSimContext.hasSEntityGameOver)
		{
			mEnityHPModifyGroup.DoAction(mSimContext, delegate(SimContext simContext, SimEntity entity)
			{
				bool flag = false;
				int num = 0;
				int num2 = 0;
				if (entity.entityActionModifyHP.mStatus == EntityActionStatus.E_ACTIVE)
				{
					int count = entity.entityActionModifyHP.mModifyInfoList.Count;
					for (int i = 0; i < count; i++)
					{
						ModifyHPInfo modifyHPInfo = entity.entityActionModifyHP.mModifyInfoList[i];
						long mAmount = modifyHPInfo.mAmount;
						if (mAmount < 0)
						{
							flag = true;
						}
						long mHP = entity.entityBlackboard.var.mHP;
						if (simContext.GetSimInterface().mOnHPModify != null)
						{
							simContext.GetSimInterface().mOnHPModify(entity.creationIndex, entity.entityBlackboard.var.mHP, entity.entityBlackboard.var.mHP + mAmount, mAmount, modifyHPInfo.mCasterID, modifyHPInfo.mActionID, modifyHPInfo.mThrownID, modifyHPInfo.mDamageType);
						}
						AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2002, out var baseValue, out var plusValue, out var tempPlusValue);
						entity.entityBlackboard.var.mHP = mAmount + baseValue;
						if (simContext.GetSimInterface().mOnAfterHPModify != null)
						{
							simContext.GetSimInterface().mOnAfterHPModify(entity.creationIndex, entity.entityBlackboard.var.mHP, mAmount, modifyHPInfo.mDamageType, modifyHPInfo.mCasterID, modifyHPInfo.mActionID, modifyHPInfo.mThrownID);
						}
						AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2180, out baseValue, out plusValue, out tempPlusValue);
						if (baseValue > 0 && entity.entityBlackboard.var.mHP < baseValue)
						{
							entity.entityBlackboard.var.mHP = baseValue;
						}
						num2 = modifyHPInfo.mActionID;
						if (entity.entityBlackboard.var.mHP <= 0 && mHP > 0)
						{
							num = modifyHPInfo.mCasterID;
							entity.entityBlackboard.var.mKillerID = num;
							entity.entityBlackboard.var.mKillDamageType = (int)modifyHPInfo.mDamageType;
							entity.entityBlackboard.var.mKillThrownID = modifyHPInfo.mThrownID;
							SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(num);
							if (entityWithEntityID != null)
							{
								entityWithEntityID.entityBlackboard.var.mLastHitAbilityID = num2;
							}
						}
						if (entity.entityBlackboard.var.mHP > entity.entityBlackboard.var.mMaxHP)
						{
							entity.entityBlackboard.var.mHP = entity.entityBlackboard.var.mMaxHP;
						}
						entity.entityBlackboard.var.mLastDamageAmount = mAmount;
					}
					entity.entityActionModifyHP.mStatus = EntityActionStatus.E_SUCCESS;
				}
				else
				{
					entity.entityBlackboard.var.mLastDamageAmount = 0L;
				}
				if (flag)
				{
					simContext.PostEvent(EntityTriggerEvent.Claim(TriggerEventType.UnitAcceptDamage, 0, entity.creationIndex));
				}
			});
		}
		mEntityBlackboard.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity entity)
		{
			if (entity.hasEntityActionAbility)
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityActionAbility.mAbilityID);
				if (config.IsFinalAction)
				{
					int mTimeStep = entity.entityActionAbility.mTimeStep;
					AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2191, out var baseValue, out var plusValue, out var tempPlusValue);
					AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2190, out var baseValue2, out tempPlusValue, out var _);
					if (!simContext.hasSEntityGameOver && (entity.entityActionAbility.mLogicTime + mTimeStep >= config.Duration || baseValue == 1))
					{
						SimWorldState status = simContext.sEntityWorldState.status;
						if (baseValue2 > 0)
						{
							entity.entityActionAbility.mLogicTime -= mTimeStep;
							entity.entityActionAbility.mAbilitySpeed = 0;
							simContext.PostEvent(SimResurrectEvent.Claim(entity.creationIndex, status.coinNumber, status.coinConsume, status.resurrectTimes, (baseValue != 0L) ? ResurrectEventState.tickAfterDeath : ResurrectEventState.death));
							plusValue += CommonProcessor.GetLogicConstTick();
							if (CommonProcessor.IsMultiplePlayerGameMode(ClientSimulator.Instance.mGameMode) && plusValue >= status.onlinemaxWaitingResurrectTime)
							{
								AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2190, 0L, 0L, 0L);
								entity.entityActionAbility.mAbilitySpeed = 100;
							}
							AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2191, 1L, plusValue, 0L);
						}
					}
					return;
				}
			}
			if (entity.entityBlackboard.var.mHP <= 0 && entity.hasEntityRemotePlayer && !simContext.hasSEntityGameOver)
			{
				bool flag = false;
				int num = entity.entityBlackboard.var.mDeathSlot;
				switch (entity.entityBlackboard.var.mDeathTimeType)
				{
				case DeathTimeType.ImmediatelyDeath:
					flag = true;
					if (entity.hasEntityHitRecover && entity.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.FloatUp)
					{
						num = entity.entityBlackboard.var.mAirDeathSlot;
					}
					else if (entity.entityBlackboard.var.mKillDamageType == 2)
					{
						num = entity.entityBlackboard.var.mNoAnimationDeathSlot;
					}
					else if (entity.entityBlackboard.var.mIsHitByThump)
					{
						num = entity.entityBlackboard.var.mNoAnimationDeathSlot;
					}
					break;
				case DeathTimeType.WaitHitRecover:
					flag = !entity.hasEntityHitRecover;
					num = entity.entityBlackboard.var.mDeathSlot;
					break;
				case DeathTimeType.WaitGetUp:
					if (entity.hasEntityHitRecover)
					{
						if (E_HitRecoverStatus.GetUp == entity.entityHitRecover.mHitRecoverStatus)
						{
							flag = true;
							num = entity.entityBlackboard.var.mFallDownDeathSlot;
						}
						else if (E_HitRecoverStatus.HitReocver == entity.entityHitRecover.mHitRecoverStatus)
						{
							flag = true;
						}
					}
					else
					{
						flag = true;
					}
					break;
				}
				if (flag)
				{
					if (entity.hasEntityBlackboard && !entity.entityBlackboard.var.sendDeathEvent)
					{
						entity.entityBlackboard.var.sendDeathEvent = true;
						SendDoFinalActionEvent(simContext, entity, num);
					}
					if (entity.hasEntityHitRecover)
					{
						entity.RemoveEntityHitRecover();
					}
					if (!entity.hasEntityActionAbility)
					{
						entity.entityBlackboard.var.mActionBusy = true;
						bool flag2 = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(num, out var config2);
						if (flag2)
						{
							flag2 = config2.CanBeParry;
						}
						entity.AddEntityActionAbility(EntityActionStatus.E_ACTIVE, num, 0, 0, 0, 0, newMIsPressing: true, 0, entity.creationIndex, newMEnableAbilityMovement: true, 100, 0, 0, 0, newMInUltimateAvoidFrame: false, 0, flag2, 0);
					}
					else
					{
						Timeline config3 = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityActionAbility.mAbilityID);
						if (!config3.IsFinalAction)
						{
							AbilitiesProcessor.SetNextFrameAbility(entity, num, forceBroken: true);
						}
					}
				}
			}
		});
	}

	private void Process_GamePause()
	{
	}

	public void Process_GameOver()
	{
		if (!mSimContext.hasSEntityGameOver)
		{
			return;
		}
		SEntityGameOver sEntityGameOver = mSimContext.sEntityGameOver;
		if (sEntityGameOver.state == GameOverState.shutDown)
		{
			ClientSimulator.Instance.StopSim();
			Debug.Log((object)"停止模拟");
			return;
		}
		mSimContext.PostEvent(SimGameOverEvent.Claim(sEntityGameOver.state, sEntityGameOver.isVectory, sEntityGameOver.timeScale, sEntityGameOver.countdown));
		SimWorldState worldState = CommonProcessor.GetWorldState();
		switch (sEntityGameOver.state)
		{
		case GameOverState.start:
			sEntityGameOver.state = GameOverState.tick;
			worldState.commonWorldTimeScaleFactor[0] = (short)sEntityGameOver.timeScale;
			break;
		case GameOverState.tick:
			sEntityGameOver.countdown -= CommonProcessor.GetLogicConstTick();
			if (sEntityGameOver.countdown <= 0)
			{
				sEntityGameOver.state = GameOverState.end;
			}
			break;
		case GameOverState.end:
			worldState.commonWorldTimeScaleFactor.Remove(0);
			sEntityGameOver.state = GameOverState.shutDown;
			break;
		}
	}

	public void Shutdown()
	{
		DetectableProcessor.Shutdown();
		AbilitiesProcessor.Shutdown();
		RecastGraphProcessor.Shutdown();
		SpawnProcessor.Shutdown();
		ThrownProcessor.Shutdown();
		AIProcessor.Shutdown();
		AttributeProcessor.Shutdown();
		BuffProcessor.Shutdown();
		CDProcessor.Shutdown();
		ConfigProcessor.Shutdown();
		CommonProcessor.Shutdown();
		ModifyHealthProcessor.Shutdown();
		MovementProcessor.Shutdown();
		ProjectileProcessor.Shutdown();
	}

	public void Cleanup()
	{
		Shutdown();
	}
}
