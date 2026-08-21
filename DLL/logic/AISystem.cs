using System;
using System.Collections.Generic;
using Config;
using Entitas;

public class AISystem : IInitializeSystem, ISystem, IExecuteSystem
{
	private SimContext mSimContext;

	private IGroup<SimEntity> mManualIntervention;

	private IGroup<SimEntity> mAIGroup;

	private List<SimEntity> mAIBuffer = new List<SimEntity>();

	private IGroup<SimEntity> mBossGroup;

	private IGroup<SimEntity> mEntityPostureValueGroup;

	private IGroup<SimEntity> mEntityExposedValueGroup;

	private IGroup<SimEntity> mEntityExposedValueCoverReducedValueGroup;

	private IGroup<SimEntity> mEntityCommanderGroup;

	public AISystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
		mManualIntervention = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionManualAIInput).NoneOf(SimMatcher.EntityHide));
		mAIGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityAIThink, SimMatcher.EntityCamp).NoneOf(SimMatcher.EntityHide));
		mEntityCommanderGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityCommander).NoneOf(SimMatcher.EntityHide));
		mBossGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBoss).NoneOf(SimMatcher.EntityHide));
		mEntityPostureValueGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityPostureValue).NoneOf(SimMatcher.EntityHide));
		mEntityExposedValueGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityExposedValue).NoneOf(SimMatcher.EntityHide));
		mEntityExposedValueCoverReducedValueGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityExposedValueCoverReducedValue).NoneOf(SimMatcher.EntityHide));
		ISimulatorInferface simInterface = mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mUpdateAbilityLogicEvent, new Action<int, int, int, int>(LogicAbilityUpdate));
		mSimContext.SimEventSystem.AddHandler<HitTargetEvent>(OnHitTargetEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDespawnedEntity);
		mSimContext.SimEventSystem.AddHandler<EntitySpawnedEvent>(OnSpawnUnitEventHandler);
	}

	private void OnSpawnUnitEventHandler(EntitySpawnedEvent eventReceived)
	{
		if (eventReceived.mSpawnType != E_SpawnType.ROLE)
		{
			return;
		}
		mBossGroup.DoAction(mSimContext, delegate(SimContext sim, SimEntity simEntity)
		{
			if (eventReceived.mConfigId != 0 && RoleCampProcessor.Is(RoleCampProcessor.GetInterestCamp(2u), eventReceived.mAgentCamp))
			{
				simEntity.entityBoss.value[eventReceived.NewEntity] = 0;
			}
		});
		mEntityCommanderGroup.DoAction(mSimContext, delegate(SimContext context, SimEntity entity)
		{
			if (RoleCampProcessor.Is(RoleCampProcessor.GetInterestCamp(2u), eventReceived.mAgentCamp))
			{
				TargetInfo item = default(TargetInfo);
				item.entityID = eventReceived.NewEntity;
				item.lastAttackTime = context.simStatus.mSimTime;
				item.AimMeEnemyNumber = 0;
				entity.entityCommander.targetInfos.Add(item);
			}
			else if (RoleCampProcessor.Is(eventReceived.mAgentCamp, 2u))
			{
				EnemyInfo item2 = default(EnemyInfo);
				item2.entityID = eventReceived.NewEntity;
				item2.lastAttackTime = context.simStatus.mSimTime;
				entity.entityCommander.enemyInfos.Add(item2);
			}
		});
	}

	private void OnDespawnedEntity(EntityDespawnedEvent eventReceived)
	{
		mBossGroup.DoAction(mSimContext, delegate(SimContext sim, SimEntity simEntity)
		{
			if (RoleCampProcessor.Is(RoleCampProcessor.GetInterestCamp(2u), eventReceived.mAgentCamp) && simEntity.entityBoss.value.ContainsKey(eventReceived.DestroyedEntity))
			{
				simEntity.entityBoss.value.Remove(eventReceived.DestroyedEntity);
			}
		});
		mEntityCommanderGroup.DoAction(mSimContext, delegate(SimContext context, SimEntity entity)
		{
			if (RoleCampProcessor.Is(RoleCampProcessor.GetInterestCamp(2u), eventReceived.mAgentCamp))
			{
				for (int i = 0; i < entity.entityCommander.targetInfos.Count; i++)
				{
					if (entity.entityCommander.targetInfos[i].entityID == eventReceived.DestroyedEntity)
					{
						entity.entityCommander.targetInfos.RemoveAt(i);
						break;
					}
				}
			}
			else if (RoleCampProcessor.Is(2u, eventReceived.mAgentCamp))
			{
				for (int j = 0; j < entity.entityCommander.enemyInfos.Count; j++)
				{
					if (entity.entityCommander.enemyInfos[j].entityID == eventReceived.DestroyedEntity)
					{
						entity.entityCommander.enemyInfos.RemoveAt(j);
						break;
					}
				}
			}
		});
	}

	private void OnHitTargetEventHandler(HitTargetEvent eventReceived)
	{
	}

	private void LogicAbilityUpdate(int entityID, int abilityID, int logicTime, int logicStep)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBoss || entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility || logicTime > CommonProcessor.GetConfigInterval())
		{
			return;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
		if (config == null || config.HitTimeList.Count <= 0)
		{
			return;
		}
		List<ISimShape> list = FrameListPool<ISimShape>.Claim();
		list.Clear();
		HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(0);
		CommonProcessor.TryGetCollisions(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mForward, hitCheckInfo, RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityCamp.mRoleTypeCamp), list);
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity simEntity = mSimContext.GetEntityWithEntityID(list[i].OwnerID);
			if (simEntity.mTag == SimEntity.Tag.MultiColliders)
			{
				simEntity = simEntity.mParent;
			}
			if (simEntity.hasEntityBlackboard)
			{
				if (entityWithEntityID.entityBoss.value.TryGetValue(simEntity.creationIndex, out var _))
				{
					entityWithEntityID.entityBoss.value[simEntity.creationIndex] += entityWithEntityID.entityBoss.deltaValueEveryTime;
				}
				else
				{
					entityWithEntityID.entityBoss.value.Add(simEntity.creationIndex, entityWithEntityID.entityBoss.deltaValueEveryTime);
				}
			}
		}
		entityWithEntityID.entityBoss.attackTime++;
		FrameListPool<ISimShape>.Release(list);
	}

	public void Execute()
	{
		Process_Boss_Logic();
		Process_AI_Logic();
	}

	public void Process_Boss_Logic()
	{
		mBossGroup.DoAction(mSimContext, delegate(SimContext sim, SimEntity simEntity)
		{
			simEntity.entityBoss.currentTime += sim.simStatus.runtimeSetting.kSimTickPeriodMS;
			if (simEntity.entityBoss.currentTime > simEntity.entityBoss.reductionTime)
			{
				simEntity.entityBoss.currentTime = 0;
				List<int> list = FrameListPool<int>.Claim();
				Dictionary<int, int>.KeyCollection.Enumerator enumerator = simEntity.entityBoss.value.Keys.GetEnumerator();
				while (enumerator.MoveNext())
				{
					list.Add(enumerator.Current);
				}
				for (int i = 0; i < list.Count; i++)
				{
					simEntity.entityBoss.value[list[i]] = IntMath.Divide(simEntity.entityBoss.value[list[i]] * simEntity.entityBoss.reductionPercent, 100);
				}
				FrameListPool<int>.Release(list);
			}
		});
		mEntityExposedValueGroup.GetEntities(mAIBuffer).DoAction(mSimContext, delegate(SimContext sim, SimEntity simEntity)
		{
			if (sim.sEntityWorldState.status.m_InQTERoleCount <= 0 && !sim.entitySourceSpace.Enable)
			{
				EntityExposedValue entityExposedValue = simEntity.entityExposedValue;
				bool manualMode = sim.entitySourceSpace.ManualMode;
				bool mManualEnter = entityExposedValue.mManualEnter;
				if (mManualEnter)
				{
					entityExposedValue.mManualEnter = false;
				}
				if (entityExposedValue.mResistEnter == 0 && ((entityExposedValue.mValue >= entityExposedValue.mMaxValue && !manualMode) || (manualMode & mManualEnter)))
				{
					if (sim.GetSimInterface().mExposedValueBreakEvent != null)
					{
						sim.GetSimInterface().mExposedValueBreakEvent(simEntity.creationIndex);
					}
					simEntity.AddEntityExposedValueBreak(0L);
					simEntity.RemoveEntityExposedValue();
				}
				else
				{
					entityExposedValue.mRuntime -= sim.simStatus.runtimeSetting.kSimTickPeriodMS;
					if (entityExposedValue.mRuntime <= 0)
					{
						entityExposedValue.mRuntime = entityExposedValue.mTick;
						long mReducedValue = entityExposedValue.mReducedValue;
						if (simEntity.hasEntityExposedValueCoverReducedValue)
						{
							mReducedValue = simEntity.entityExposedValueCoverReducedValue.mReducedValue;
						}
						entityExposedValue.mValue = IntMath.Clamp(entityExposedValue.mValue - mReducedValue, 0L, entityExposedValue.mMaxValue);
					}
				}
			}
		});
		mEntityExposedValueCoverReducedValueGroup.GetEntities(mAIBuffer).DoAction(mSimContext, delegate(SimContext sim, SimEntity simEntity)
		{
			if (!sim.entitySourceSpace.Enable)
			{
				if (simEntity.hasEntityExposedValueBreak)
				{
					simEntity.RemoveEntityExposedValueCoverReducedValue();
				}
				else
				{
					simEntity.entityExposedValueCoverReducedValue.mRuntime -= sim.simStatus.runtimeSetting.kSimTickPeriodMS;
					if (simEntity.entityExposedValueCoverReducedValue.mRuntime <= 0)
					{
						simEntity.RemoveEntityExposedValueCoverReducedValue();
					}
				}
			}
		});
	}

	public void Process_AI_Logic()
	{
		if (!mSimContext.sEntityWorldState.status.mBattleStart)
		{
			return;
		}
		mManualIntervention.GetEntities(mAIBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity2)
		{
			if (!simEntity2.hasEntityAIThink)
			{
				simEntity2.RemoveEntityActionManualAIInput();
			}
			else
			{
				if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mManualAIInputEvent != null)
				{
					simContext.GetSimInterface().mManualAIInputEvent(simEntity2.creationIndex, simEntity2.entityActionManualAIInput.mInputKey);
				}
				simEntity2.RemoveEntityActionManualAIInput();
			}
		});
		mAIGroup.GetEntities(mAIBuffer);
		for (int num = 0; num < mAIBuffer.Count; num++)
		{
			SimEntity simEntity = mAIBuffer[num];
			simEntity.entityAIThink.mThinkTimer++;
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2196, out var baseValue, out var _, out var _);
			if (baseValue <= 0 && simEntity.entityBlackboard.var.initFinished)
			{
				AIProcessor.AICommandStatus arg = AIProcessor.AICommandStatus.None;
				if (simEntity.entityAIThink.mInterruptCommand != null || simEntity.entityAIThink.mForceMakeDecision)
				{
					if (simEntity.entityAIThink.mCurrentCommand != null)
					{
						arg = AIProcessor.DoAICommand(simEntity, simEntity.entityAIThink.mCurrentCommand, isInterrupt: true);
						simEntity.entityAIThink.mCurrentCommand.Reset();
						simEntity.entityAIThink.mCurrentCommand = null;
					}
					if (simEntity.entityAIThink.mInterruptCommand != null)
					{
						simEntity.entityAIThink.mCurrentCommand = simEntity.entityAIThink.mInterruptCommand;
					}
					simEntity.entityAIThink.mInterruptCommand = null;
				}
				if (simEntity.entityAIThink.mCurrentCommand == null || simEntity.entityAIThink.mCurrentCommand.mStatus == AIProcessor.AICommandStatus.Success || simEntity.entityAIThink.mCurrentCommand.mStatus == AIProcessor.AICommandStatus.Failed)
				{
					if (simEntity.entityAIThink.mCurrentCommand != null)
					{
						simEntity.entityAIThink.mCurrentCommand.Reset();
						simEntity.entityAIThink.mCurrentCommand = null;
					}
					if ((!simEntity.hasEntityHitRecover && !simEntity.hasEntityActionAbility) || simEntity.entityAIThink.mForceMakeDecision)
					{
						if (mSimContext.GetSimInterface().mAICommandMakeDecision != null)
						{
							mSimContext.GetSimInterface().mAICommandMakeDecision(simEntity.creationIndex, arg);
							if (simEntity.entityAIThink.mInterruptCommand != null)
							{
								simEntity.entityAIThink.mCurrentCommand = simEntity.entityAIThink.mInterruptCommand;
							}
							simEntity.entityAIThink.mInterruptCommand = null;
						}
						simEntity.entityAIThink.mForceMakeDecision = false;
					}
				}
				if (simEntity.entityAIThink.mCurrentCommand != null && simEntity.entityAIThink.mCurrentCommand.mStatus != AIProcessor.AICommandStatus.Failed && simEntity.entityAIThink.mCurrentCommand.mStatus != AIProcessor.AICommandStatus.Success)
				{
					AIProcessor.AICommandStatus aICommandStatus = AIProcessor.DoAICommand(simEntity, simEntity.entityAIThink.mCurrentCommand);
					switch (aICommandStatus)
					{
					case AIProcessor.AICommandStatus.Success:
					case AIProcessor.AICommandStatus.Failed:
						arg = aICommandStatus;
						break;
					}
				}
			}
			else if (simEntity.entityAIThink.mCurrentCommand != null)
			{
				simEntity.entityAIThink.mCurrentCommand.Exit(mSimContext, simEntity);
				simEntity.entityAIThink.mCurrentCommand.Reset();
				simEntity.entityAIThink.mCurrentCommand = null;
			}
			if (mSimContext.GetSimInterface() != null && mSimContext.GetSimInterface().mUpdateAILogicEvent != null && baseValue <= 0)
			{
				bool flag = true;
				if (simEntity.entityBlackboard.var.enemyType == EnemyType.MonsterNormal && simEntity.entityBlackboard.var.initFinished)
				{
					flag = simEntity.entityAIThink.mThinkTimer % mAIBuffer.Count == num;
				}
				if (flag)
				{
					mSimContext.GetSimInterface().mUpdateAILogicEvent(simEntity.creationIndex, simEntity.entityBlackboard.var.mAIID);
					simEntity.entityAIThink.mLastThinkTimer = simEntity.entityAIThink.mThinkTimer;
				}
			}
		}
		mEntityCommanderGroup.DoAction(mSimContext, delegate(SimContext context, SimEntity entity)
		{
			for (int i = 0; i < entity.entityCommander.targetInfos.Count; i++)
			{
				TargetInfo value = entity.entityCommander.targetInfos[i];
				value.AimMeEnemyNumber = 0;
				entity.entityCommander.targetInfos[i] = value;
			}
			for (int j = 0; j < entity.entityCommander.enemyInfos.Count; j++)
			{
				SimEntity entityWithEntityID = context.GetEntityWithEntityID(entity.entityCommander.enemyInfos[j].entityID);
				if (entityWithEntityID != null)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, out var baseValue2, out var _, out var _);
					if (entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0 && baseValue2 >= 2)
					{
						for (int k = 0; k < entity.entityCommander.targetInfos.Count; k++)
						{
							SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
							if (simEntityByMultiColliders != null && entity.entityCommander.targetInfos[k].entityID == simEntityByMultiColliders.creationIndex)
							{
								TargetInfo value2 = entity.entityCommander.targetInfos[k];
								value2.AimMeEnemyNumber++;
								entity.entityCommander.targetInfos[k] = value2;
								break;
							}
						}
					}
				}
			}
		});
	}
}
