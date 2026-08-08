using System;
using System.Collections.Generic;
using Config;
using Entitas;
using Google.Protobuf;
using Pathfinding;
using Pathfinding.RVO;
using Pathfinding.RVO.Sampled;
using Services;
using UnityEngine;

public sealed class SimEntity : Entity
{
	private class EntityVarNameComparer : IEqualityComparer<EntityVarName>
	{
		public bool Equals(EntityVarName x, EntityVarName y)
		{
			return x == y;
		}

		public int GetHashCode(EntityVarName obj)
		{
			return (int)obj;
		}
	}

	public enum Tag
	{
		None,
		AvoidShadow,
		Combination,
		MultiColliders
	}

	private static readonly Projectile projectileComponent = new Projectile();

	private static readonly EntityDetectable entityDetectableComponent = new EntityDetectable();

	private Dictionary<EntityVarName, VarVisitor> mVarList;

	public int x;

	public int z;

	public SimEntity mLinePre;

	public SimEntity mLinkNext;

	public SimEntity mParent;

	public Dictionary<int, List<SimEntity>> mChildren;

	public Tag mTag;

	public string mName;

	public SEntityGameOver sEntityGameOver => (SEntityGameOver)GetComponent(67);

	public bool hasSEntityGameOver => HasComponent(67);

	public LogicServices logicServices => (LogicServices)GetComponent(64);

	public bool hasLogicServices => HasComponent(64);

	public EntitySourceSpace entitySourceSpace => (EntitySourceSpace)GetComponent(57);

	public bool hasEntitySourceSpace => HasComponent(57);

	public SEntityWorldState sEntityWorldState => (SEntityWorldState)GetComponent(69);

	public bool hasSEntityWorldState => HasComponent(69);

	public SEntityAABBTree sEntityAABBTree => (SEntityAABBTree)GetComponent(66);

	public bool hasSEntityAABBTree => HasComponent(66);

	public SEntitySpatialTable sEntitySpatialTable => (SEntitySpatialTable)GetComponent(68);

	public bool hasSEntitySpatialTable => HasComponent(68);

	public SimStatusComponent simStatus => (SimStatusComponent)GetComponent(71);

	public bool hasSimStatus => HasComponent(71);

	public EventHandlerComponent eventHandler => (EventHandlerComponent)GetComponent(63);

	public bool hasEventHandler => HasComponent(63);

	public SimStateFrameBuffer simStateFrameBuffer => (SimStateFrameBuffer)GetComponent(70);

	public bool hasSimStateFrameBuffer => HasComponent(70);

	public CommandsPendingComponent commandsPending => (CommandsPendingComponent)GetComponent(0);

	public bool hasCommandsPending => HasComponent(0);

	public SimulatorInterfaceComponent simulatorInterface => (SimulatorInterfaceComponent)GetComponent(73);

	public bool hasSimulatorInterface => HasComponent(73);

	public EntityMasterSkill entityMasterSkill => (EntityMasterSkill)GetComponent(43);

	public bool hasEntityMasterSkill => HasComponent(43);

	public EntityMoveClamp entityMoveClamp => (EntityMoveClamp)GetComponent(44);

	public bool hasEntityMoveClamp => HasComponent(44);

	public EntityActionParrying entityActionParrying => (EntityActionParrying)GetComponent(17);

	public bool hasEntityActionParrying => HasComponent(17);

	public EntityResistance entityResistance => (EntityResistance)GetComponent(53);

	public bool hasEntityResistance => HasComponent(53);

	public EntityUniqueSkillEnergy entityUniqueSkillEnergy => (EntityUniqueSkillEnergy)GetComponent(62);

	public bool hasEntityUniqueSkillEnergy => HasComponent(62);

	public EntityActionManualAIInput entityActionManualAIInput => (EntityActionManualAIInput)GetComponent(10);

	public bool hasEntityActionManualAIInput => HasComponent(10);

	public EntityActionModifyCombatScore entityActionModifyCombatScore => (EntityActionModifyCombatScore)GetComponent(13);

	public bool hasEntityActionModifyCombatScore => HasComponent(13);

	public EntityUltimateAvoidCD entityUltimateAvoidCD => (EntityUltimateAvoidCD)GetComponent(61);

	public bool hasEntityUltimateAvoidCD => HasComponent(61);

	public EntityExposedValue entityExposedValue => (EntityExposedValue)GetComponent(35);

	public bool hasEntityExposedValue => HasComponent(35);

	public EntityExposedValueBreak entityExposedValueBreak => (EntityExposedValueBreak)GetComponent(36);

	public bool hasEntityExposedValueBreak => HasComponent(36);

	public EntityExposedValueCoverReducedValue entityExposedValueCoverReducedValue => (EntityExposedValueCoverReducedValue)GetComponent(37);

	public bool hasEntityExposedValueCoverReducedValue => HasComponent(37);

	public EntityQTE entityQTE => (EntityQTE)GetComponent(50);

	public bool hasEntityQTE => HasComponent(50);

	public EntityActionAbilityLogicInput entityActionAbilityLogicInput => (EntityActionAbilityLogicInput)GetComponent(3);

	public bool hasEntityActionAbilityLogicInput => HasComponent(3);

	public EntityActionAvoidShadow entityActionAvoidShadow => (EntityActionAvoidShadow)GetComponent(5);

	public bool hasEntityActionAvoidShadow => HasComponent(5);

	public EntityActionSubJoystick entityActionSubJoystick => (EntityActionSubJoystick)GetComponent(18);

	public bool hasEntityActionSubJoystick => HasComponent(18);

	public EntityEndurance entityEndurance => (EntityEndurance)GetComponent(34);

	public bool hasEntityEndurance => HasComponent(34);

	public EntityPuppet entityPuppet => (EntityPuppet)GetComponent(48);

	public bool hasEntityPuppet => HasComponent(48);

	public EntityPuppetHost entityPuppetHost => (EntityPuppetHost)GetComponent(49);

	public bool hasEntityPuppetHost => HasComponent(49);

	public EntityActionTransfiguration entityActionTransfiguration => (EntityActionTransfiguration)GetComponent(19);

	public bool hasEntityActionTransfiguration => HasComponent(19);

	public EntityCD entityCD => (EntityCD)GetComponent(28);

	public bool hasEntityCD => HasComponent(28);

	public EntityCommander entityCommander => (EntityCommander)GetComponent(31);

	public bool hasEntityCommander => HasComponent(31);

	public EntityComboNumber entityComboNumber => (EntityComboNumber)GetComponent(30);

	public bool hasEntityComboNumber => HasComponent(30);

	public EntityTimer entityTimer => (EntityTimer)GetComponent(59);

	public bool hasEntityTimer => HasComponent(59);

	public EntityPostureValue entityPostureValue => (EntityPostureValue)GetComponent(46);

	public bool hasEntityPostureValue => HasComponent(46);

	public EntityBoss entityBoss => (EntityBoss)GetComponent(24);

	public bool hasEntityBoss => HasComponent(24);

	public EntityRecastCut entityRecastCut => (EntityRecastCut)GetComponent(51);

	public bool hasEntityRecastCut => HasComponent(51);

	public EntityCameraView entityCameraView => (EntityCameraView)GetComponent(26);

	public bool hasEntityCameraView => HasComponent(26);

	public EntityAIMovement entityAIMovement => (EntityAIMovement)GetComponent(21);

	public bool hasEntityAIMovement => HasComponent(21);

	public EntityActionAbility entityActionAbility => (EntityActionAbility)GetComponent(1);

	public bool hasEntityActionAbility => HasComponent(1);

	public EntityHide entityHide => (EntityHide)GetComponent(39);

	public bool hasEntityHide => HasComponent(39);

	public EntityPredicationPlayer entityPredicationPlayer => (EntityPredicationPlayer)GetComponent(47);

	public bool hasEntityPredicationPlayer => HasComponent(47);

	public EntityRemotePlayer entityRemotePlayer => (EntityRemotePlayer)GetComponent(52);

	public bool hasEntityRemotePlayer => HasComponent(52);

	public EntityActionManualInput entityActionManualInput => (EntityActionManualInput)GetComponent(11);

	public bool hasEntityActionManualInput => HasComponent(11);

	public EntityActionMoveDirection entityActionMoveDirection => (EntityActionMoveDirection)GetComponent(16);

	public bool hasEntityActionMoveDirection => HasComponent(16);

	public EntityTestGoogle entityTestGoogle => (EntityTestGoogle)GetComponent(58);

	public bool hasEntityTestGoogle => HasComponent(58);

	public EntityLocalPlayer entityLocalPlayer => (EntityLocalPlayer)GetComponent(42);

	public bool hasEntityLocalPlayer => HasComponent(42);

	public EntitySkillEffect entitySkillEffect => (EntitySkillEffect)GetComponent(56);

	public bool hasEntitySkillEffect => HasComponent(56);

	public EntityBuff entityBuff => (EntityBuff)GetComponent(25);

	public bool hasEntityBuff => HasComponent(25);

	public EntityActionJump entityActionJump => (EntityActionJump)GetComponent(9);

	public bool hasEntityActionJump => HasComponent(9);

	public EntityActionIdle entityActionIdle => (EntityActionIdle)GetComponent(8);

	public bool hasEntityActionIdle => HasComponent(8);

	public EntityID entityID => (EntityID)GetComponent(41);

	public bool hasEntityID => HasComponent(41);

	public EntityConfig entityConfig => (EntityConfig)GetComponent(32);

	public bool hasEntityConfig => HasComponent(32);

	public EntityHitRecover entityHitRecover => (EntityHitRecover)GetComponent(40);

	public bool hasEntityHitRecover => HasComponent(40);

	public EntityActionBorn entityActionBorn => (EntityActionBorn)GetComponent(6);

	public bool hasEntityActionBorn => HasComponent(6);

	public EntityActionMelee entityActionMelee => (EntityActionMelee)GetComponent(12);

	public bool hasEntityActionMelee => HasComponent(12);

	public EntityActionDeath entityActionDeath => (EntityActionDeath)GetComponent(7);

	public bool hasEntityActionDeath => HasComponent(7);

	public EntityActionModifyHP entityActionModifyHP => (EntityActionModifyHP)GetComponent(14);

	public bool hasEntityActionModifyHP => HasComponent(14);

	public EntityActionAttack entityActionAttack => (EntityActionAttack)GetComponent(4);

	public bool hasEntityActionAttack => HasComponent(4);

	public EntityActionMove entityActionMove => (EntityActionMove)GetComponent(15);

	public bool hasEntityActionMove => HasComponent(15);

	public EntityActionWeaponEquip entityActionWeaponEquip => (EntityActionWeaponEquip)GetComponent(20);

	public bool hasEntityActionWeaponEquip => HasComponent(20);

	public EntityActionAbilityDirection entityActionAbilityDirection => (EntityActionAbilityDirection)GetComponent(2);

	public bool hasEntityActionAbilityDirection => HasComponent(2);

	public EntityBlackboard entityBlackboard => (EntityBlackboard)GetComponent(23);

	public bool hasEntityBlackboard => HasComponent(23);

	public EntityAIThink entityAIThink => (EntityAIThink)GetComponent(22);

	public bool hasEntityAIThink => HasComponent(22);

	public EntityTrigger entityTrigger => (EntityTrigger)GetComponent(60);

	public bool hasEntityTrigger => HasComponent(60);

	public EntityCamp entityCamp => (EntityCamp)GetComponent(27);

	public bool hasEntityCamp => HasComponent(27);

	public EntityCollisionInfo entityCollisionInfo => (EntityCollisionInfo)GetComponent(29);

	public bool hasEntityCollisionInfo => HasComponent(29);

	public EntityShape entityShape => (EntityShape)GetComponent(55);

	public bool hasEntityShape => HasComponent(55);

	public Unit unit => (Unit)GetComponent(74);

	public bool hasUnit => HasComponent(74);

	public EntityRVO entityRVO => (EntityRVO)GetComponent(54);

	public bool hasEntityRVO => HasComponent(54);

	public SimTransform simTransform => (SimTransform)GetComponent(72);

	public bool hasSimTransform => HasComponent(72);

	public bool isProjectile
	{
		get
		{
			return HasComponent(65);
		}
		set
		{
			if (value == isProjectile)
			{
				return;
			}
			int index = 65;
			if (value)
			{
				Stack<IComponent> componentPool = GetComponentPool(index);
				IComponent component2;
				if (componentPool.Count <= 0)
				{
					IComponent component = projectileComponent;
					component2 = component;
				}
				else
				{
					component2 = componentPool.Pop();
				}
				IComponent component3 = component2;
				AddComponent(index, component3);
			}
			else
			{
				RemoveComponent(index);
			}
		}
	}

	public bool isEntityDetectable
	{
		get
		{
			return HasComponent(33);
		}
		set
		{
			if (value == isEntityDetectable)
			{
				return;
			}
			int index = 33;
			if (value)
			{
				Stack<IComponent> componentPool = GetComponentPool(index);
				IComponent component2;
				if (componentPool.Count <= 0)
				{
					IComponent component = entityDetectableComponent;
					component2 = component;
				}
				else
				{
					component2 = componentPool.Pop();
				}
				IComponent component3 = component2;
				AddComponent(index, component3);
			}
			else
			{
				RemoveComponent(index);
			}
		}
	}

	public EntityHealth entityHealth => (EntityHealth)GetComponent(38);

	public bool hasEntityHealth => HasComponent(38);

	public EntityPositon entityPositon => (EntityPositon)GetComponent(45);

	public bool hasEntityPositon => HasComponent(45);

	public SimVar this[EntityVarName varName]
	{
		get
		{
			return mVarList[varName].mGetVar();
		}
		set
		{
			mVarList[varName].mSetVar(value);
		}
	}

	private SimVar ENTITY_ID => base.creationIndex;

	public SimVar WORLDSTATE_ALIVEMONSTER_COUNT => HasComponent(69) ? sEntityWorldState.status.mExsitAliveEnemiesCount : (-1);

	public SimVar WORLDSTATE_ALIVEHERO_COUNT => HasComponent(69) ? sEntityWorldState.status.mExsitAliveHerosCount : (-1);

	public SimVar ENTITY_CONFIG_ID
	{
		get
		{
			return HasComponent(32) ? entityConfig.mId : (-1);
		}
		set
		{
			entityConfig.mId = value;
		}
	}

	public SimVar ENTITY_ATTR_FIGHT_LEVEL
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mFightLevel : (-1);
		}
		set
		{
			entityBlackboard.var.mFightLevel = value;
		}
	}

	public SimVar ENTITY_HP
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mHP : (-1);
		}
		set
		{
			entityBlackboard.var.mHP = value;
		}
	}

	public SimVar ENTITY_AI_HAS_ATTACK_TRAGET => HasComponent(23) && entityBlackboard.var.mHasAimTarget;

	public SimVar ENTITY_ATTR_MOVE_USE_CURVE
	{
		get
		{
			return HasComponent(23) && entityBlackboard.var.mUseRunMoveCurve;
		}
		set
		{
			entityBlackboard.var.mUseRunMoveCurve = value;
		}
	}

	public SimVar ENTITY_ATTR_ROTATION_SPEED
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mDeltaRotationSpeed : ((Int)0);
		}
		set
		{
			entityBlackboard.var.mDeltaRotationSpeed = value;
		}
	}

	public SimVar ENTITY_AI_TARGETPOS
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mTargetPos : Int3.zero;
		}
		set
		{
			entityBlackboard.var.mTargetPos = value;
		}
	}

	public SimVar ENTITY_AI_TARGET
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mAimTarget : (-1);
		}
		set
		{
			entityBlackboard.var.mAimTarget = value;
		}
	}

	public SimVar ENTITY_AI_TRIGGER_TARGET
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mTriggerTarget : (-1);
		}
		set
		{
			entityBlackboard.var.mTriggerTarget = value;
		}
	}

	public SimVar ENTITY_DESIRED_VELOCITY
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mDesiredVelocity : Int3.zero;
		}
		set
		{
			entityBlackboard.var.mDesiredVelocity = value;
		}
	}

	public SimVar ENTITY_DESIRED_POSITION
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mDesiredPos : Int3.zero;
		}
		set
		{
			entityBlackboard.var.mDesiredPos = value;
		}
	}

	public SimVar ENTITY_DESIRED_SPEED
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mDesiredSpeed : ((Int)0);
		}
		set
		{
			entityBlackboard.var.mDesiredSpeed = value;
		}
	}

	public SimVar ENTITY_CALCULATED_SPEED
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mCalculatedSpeed : ((Int)0);
		}
		set
		{
			entityBlackboard.var.mCalculatedSpeed = value;
		}
	}

	public SimVar ENTITY_CALCULATED_POSITION
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mCalculatedPos : Int3.zero;
		}
		set
		{
			entityBlackboard.var.mCalculatedPos = value;
		}
	}

	public SimVar ENTITY_CALCULATED_VELOCITY
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mCalculatedVec : Int3.zero;
		}
		set
		{
			entityBlackboard.var.mCalculatedVec = value;
		}
	}

	public SimVar ENTITY_ATTR_LOCK_MOVEMENT
	{
		get
		{
			return HasComponent(23) ? entityBlackboard.var.mLockMovementCount : (-1);
		}
		set
		{
			entityBlackboard.var.mLockMovementCount = value;
		}
	}

	public SimVar ENTITY_POS
	{
		get
		{
			return HasComponent(45) ? entityPositon.mPosition : Int3.zero;
		}
		set
		{
			entityPositon.mPosition = value;
		}
	}

	public SimVar ENTITY_FOWARD
	{
		get
		{
			return HasComponent(45) ? entityPositon.mForward : Int3.zero;
		}
		set
		{
			entityPositon.mForward = value;
		}
	}

	public SimVar ENTITY_UP
	{
		get
		{
			return HasComponent(45) ? entityPositon.mUp : Int3.zero;
		}
		set
		{
			entityPositon.mUp = value;
		}
	}

	public void AddSEntityGameOver(GameOverState newState, int newCountdown, int newTimeScale, E_BattleResult newIsVectory)
	{
		int index = 67;
		SEntityGameOver sEntityGameOver = CreateComponent<SEntityGameOver>(index);
		sEntityGameOver.state = newState;
		sEntityGameOver.countdown = newCountdown;
		sEntityGameOver.timeScale = newTimeScale;
		sEntityGameOver.isVectory = newIsVectory;
		AddComponent(index, sEntityGameOver);
	}

	public void ReplaceSEntityGameOver(GameOverState newState, int newCountdown, int newTimeScale, E_BattleResult newIsVectory)
	{
		int index = 67;
		SEntityGameOver sEntityGameOver = CreateComponent<SEntityGameOver>(index);
		sEntityGameOver.state = newState;
		sEntityGameOver.countdown = newCountdown;
		sEntityGameOver.timeScale = newTimeScale;
		sEntityGameOver.isVectory = newIsVectory;
		ReplaceComponent(index, sEntityGameOver);
	}

	public void RemoveSEntityGameOver()
	{
		RemoveComponent(67);
	}

	public void AddLogicServices(CommonService newMService)
	{
		int index = 64;
		LogicServices logicServices = CreateComponent<LogicServices>(index);
		logicServices.mService = newMService;
		AddComponent(index, logicServices);
	}

	public void ReplaceLogicServices(CommonService newMService)
	{
		int index = 64;
		LogicServices logicServices = CreateComponent<LogicServices>(index);
		logicServices.mService = newMService;
		ReplaceComponent(index, logicServices);
	}

	public void RemoveLogicServices()
	{
		RemoveComponent(64);
	}

	public void AddEntitySourceSpace(bool newEnable, int newSourceSpaceKeepTime, int newSourceSpaceDelayTime, int newSourceSpaceExitTime, int newSourceSpaceRaceID, int newLimitDodgeCD, int newBreakEntityID, bool newManualMode)
	{
		int index = 57;
		EntitySourceSpace entitySourceSpace = CreateComponent<EntitySourceSpace>(index);
		entitySourceSpace.Enable = newEnable;
		entitySourceSpace.SourceSpaceKeepTime = newSourceSpaceKeepTime;
		entitySourceSpace.SourceSpaceDelayTime = newSourceSpaceDelayTime;
		entitySourceSpace.SourceSpaceExitTime = newSourceSpaceExitTime;
		entitySourceSpace.SourceSpaceRaceID = newSourceSpaceRaceID;
		entitySourceSpace.LimitDodgeCD = newLimitDodgeCD;
		entitySourceSpace.BreakEntityID = newBreakEntityID;
		entitySourceSpace.ManualMode = newManualMode;
		AddComponent(index, entitySourceSpace);
	}

	public void ReplaceEntitySourceSpace(bool newEnable, int newSourceSpaceKeepTime, int newSourceSpaceDelayTime, int newSourceSpaceExitTime, int newSourceSpaceRaceID, int newLimitDodgeCD, int newBreakEntityID, bool newManualMode)
	{
		int index = 57;
		EntitySourceSpace entitySourceSpace = CreateComponent<EntitySourceSpace>(index);
		entitySourceSpace.Enable = newEnable;
		entitySourceSpace.SourceSpaceKeepTime = newSourceSpaceKeepTime;
		entitySourceSpace.SourceSpaceDelayTime = newSourceSpaceDelayTime;
		entitySourceSpace.SourceSpaceExitTime = newSourceSpaceExitTime;
		entitySourceSpace.SourceSpaceRaceID = newSourceSpaceRaceID;
		entitySourceSpace.LimitDodgeCD = newLimitDodgeCD;
		entitySourceSpace.BreakEntityID = newBreakEntityID;
		entitySourceSpace.ManualMode = newManualMode;
		ReplaceComponent(index, entitySourceSpace);
	}

	public void RemoveEntitySourceSpace()
	{
		RemoveComponent(57);
	}

	public void AddSEntityWorldState(SimWorldState newStatus)
	{
		int index = 69;
		SEntityWorldState sEntityWorldState = CreateComponent<SEntityWorldState>(index);
		sEntityWorldState.status = newStatus;
		AddComponent(index, sEntityWorldState);
	}

	public void ReplaceSEntityWorldState(SimWorldState newStatus)
	{
		int index = 69;
		SEntityWorldState sEntityWorldState = CreateComponent<SEntityWorldState>(index);
		sEntityWorldState.status = newStatus;
		ReplaceComponent(index, sEntityWorldState);
	}

	public void RemoveSEntityWorldState()
	{
		RemoveComponent(69);
	}

	public void AddSEntityAABBTree(DynamicTree<ISimShape> newMDynamicTree)
	{
		int index = 66;
		SEntityAABBTree sEntityAABBTree = CreateComponent<SEntityAABBTree>(index);
		sEntityAABBTree.mDynamicTree = newMDynamicTree;
		AddComponent(index, sEntityAABBTree);
	}

	public void ReplaceSEntityAABBTree(DynamicTree<ISimShape> newMDynamicTree)
	{
		int index = 66;
		SEntityAABBTree sEntityAABBTree = CreateComponent<SEntityAABBTree>(index);
		sEntityAABBTree.mDynamicTree = newMDynamicTree;
		ReplaceComponent(index, sEntityAABBTree);
	}

	public void RemoveSEntityAABBTree()
	{
		RemoveComponent(66);
	}

	public void AddSEntitySpatialTable(Int2 newMMin, Int2 newMMax)
	{
		int index = 68;
		SEntitySpatialTable sEntitySpatialTable = CreateComponent<SEntitySpatialTable>(index);
		sEntitySpatialTable.mMin = newMMin;
		sEntitySpatialTable.mMax = newMMax;
		AddComponent(index, sEntitySpatialTable);
	}

	public void ReplaceSEntitySpatialTable(Int2 newMMin, Int2 newMMax)
	{
		int index = 68;
		SEntitySpatialTable sEntitySpatialTable = CreateComponent<SEntitySpatialTable>(index);
		sEntitySpatialTable.mMin = newMMin;
		sEntitySpatialTable.mMax = newMMax;
		ReplaceComponent(index, sEntitySpatialTable);
	}

	public void RemoveSEntitySpatialTable()
	{
		RemoveComponent(68);
	}

	public void AddSimStatus(SimStatusSetting newRuntimeSetting, SimSettings newSimSetting, uint newMServerFrame, uint newMClientPredictionFrame, bool newMIsRollback, ReplayMode newReplayMode, GameMode newGameMode, long newMSimTime, Checksum newExpectedChecksum, Checksum newMMostRecentChecksum)
	{
		int index = 71;
		SimStatusComponent simStatusComponent = CreateComponent<SimStatusComponent>(index);
		simStatusComponent.runtimeSetting = newRuntimeSetting;
		simStatusComponent.simSetting = newSimSetting;
		simStatusComponent.mServerFrame = newMServerFrame;
		simStatusComponent.mClientPredictionFrame = newMClientPredictionFrame;
		simStatusComponent.mIsRollback = newMIsRollback;
		simStatusComponent.replayMode = newReplayMode;
		simStatusComponent.gameMode = newGameMode;
		simStatusComponent.mSimTime = newMSimTime;
		simStatusComponent.expectedChecksum = newExpectedChecksum;
		simStatusComponent.mMostRecentChecksum = newMMostRecentChecksum;
		AddComponent(index, simStatusComponent);
	}

	public void ReplaceSimStatus(SimStatusSetting newRuntimeSetting, SimSettings newSimSetting, uint newMServerFrame, uint newMClientPredictionFrame, bool newMIsRollback, ReplayMode newReplayMode, GameMode newGameMode, long newMSimTime, Checksum newExpectedChecksum, Checksum newMMostRecentChecksum)
	{
		int index = 71;
		SimStatusComponent simStatusComponent = CreateComponent<SimStatusComponent>(index);
		simStatusComponent.runtimeSetting = newRuntimeSetting;
		simStatusComponent.simSetting = newSimSetting;
		simStatusComponent.mServerFrame = newMServerFrame;
		simStatusComponent.mClientPredictionFrame = newMClientPredictionFrame;
		simStatusComponent.mIsRollback = newMIsRollback;
		simStatusComponent.replayMode = newReplayMode;
		simStatusComponent.gameMode = newGameMode;
		simStatusComponent.mSimTime = newMSimTime;
		simStatusComponent.expectedChecksum = newExpectedChecksum;
		simStatusComponent.mMostRecentChecksum = newMMostRecentChecksum;
		ReplaceComponent(index, simStatusComponent);
	}

	public void RemoveSimStatus()
	{
		RemoveComponent(71);
	}

	public void AddEventHandler(Dictionary<Type, EventPosterBase> newMHandlers)
	{
		int index = 63;
		EventHandlerComponent eventHandlerComponent = CreateComponent<EventHandlerComponent>(index);
		eventHandlerComponent.mHandlers = newMHandlers;
		AddComponent(index, eventHandlerComponent);
	}

	public void ReplaceEventHandler(Dictionary<Type, EventPosterBase> newMHandlers)
	{
		int index = 63;
		EventHandlerComponent eventHandlerComponent = CreateComponent<EventHandlerComponent>(index);
		eventHandlerComponent.mHandlers = newMHandlers;
		ReplaceComponent(index, eventHandlerComponent);
	}

	public void RemoveEventHandler()
	{
		RemoveComponent(63);
	}

	public void AddSimStateFrameBuffer(int newMCurrentFrameArrayIndex, uint newMLastAppliedFrame)
	{
		int index = 70;
		SimStateFrameBuffer simStateFrameBuffer = CreateComponent<SimStateFrameBuffer>(index);
		simStateFrameBuffer.mCurrentFrameArrayIndex = newMCurrentFrameArrayIndex;
		simStateFrameBuffer.mLastAppliedFrame = newMLastAppliedFrame;
		AddComponent(index, simStateFrameBuffer);
	}

	public void ReplaceSimStateFrameBuffer(int newMCurrentFrameArrayIndex, uint newMLastAppliedFrame)
	{
		int index = 70;
		SimStateFrameBuffer simStateFrameBuffer = CreateComponent<SimStateFrameBuffer>(index);
		simStateFrameBuffer.mCurrentFrameArrayIndex = newMCurrentFrameArrayIndex;
		simStateFrameBuffer.mLastAppliedFrame = newMLastAppliedFrame;
		ReplaceComponent(index, simStateFrameBuffer);
	}

	public void RemoveSimStateFrameBuffer()
	{
		RemoveComponent(70);
	}

	public void AddCommandsPending(string newMEmpty)
	{
		int index = 0;
		CommandsPendingComponent commandsPendingComponent = CreateComponent<CommandsPendingComponent>(index);
		commandsPendingComponent.mEmpty = newMEmpty;
		AddComponent(index, commandsPendingComponent);
	}

	public void ReplaceCommandsPending(string newMEmpty)
	{
		int index = 0;
		CommandsPendingComponent commandsPendingComponent = CreateComponent<CommandsPendingComponent>(index);
		commandsPendingComponent.mEmpty = newMEmpty;
		ReplaceComponent(index, commandsPendingComponent);
	}

	public void RemoveCommandsPending()
	{
		RemoveComponent(0);
	}

	public void AddSimulatorInterface(ISimulatorInferface newValue)
	{
		int index = 73;
		SimulatorInterfaceComponent simulatorInterfaceComponent = CreateComponent<SimulatorInterfaceComponent>(index);
		simulatorInterfaceComponent.value = newValue;
		AddComponent(index, simulatorInterfaceComponent);
	}

	public void ReplaceSimulatorInterface(ISimulatorInferface newValue)
	{
		int index = 73;
		SimulatorInterfaceComponent simulatorInterfaceComponent = CreateComponent<SimulatorInterfaceComponent>(index);
		simulatorInterfaceComponent.value = newValue;
		ReplaceComponent(index, simulatorInterfaceComponent);
	}

	public void RemoveSimulatorInterface()
	{
		RemoveComponent(73);
	}

	public void AddEntityMasterSkill(EntityActionStatus newMState, int newMValue, int newMMaxValue, int newMCD, int newMMaxCD, int newMConsumeValue, int newMConsumeCD, int newMConfigID)
	{
		int index = 43;
		EntityMasterSkill entityMasterSkill = CreateComponent<EntityMasterSkill>(index);
		entityMasterSkill.mState = newMState;
		entityMasterSkill.mValue = newMValue;
		entityMasterSkill.mMaxValue = newMMaxValue;
		entityMasterSkill.mCD = newMCD;
		entityMasterSkill.mMaxCD = newMMaxCD;
		entityMasterSkill.mConsumeValue = newMConsumeValue;
		entityMasterSkill.mConsumeCD = newMConsumeCD;
		entityMasterSkill.mConfigID = newMConfigID;
		AddComponent(index, entityMasterSkill);
	}

	public void ReplaceEntityMasterSkill(EntityActionStatus newMState, int newMValue, int newMMaxValue, int newMCD, int newMMaxCD, int newMConsumeValue, int newMConsumeCD, int newMConfigID)
	{
		int index = 43;
		EntityMasterSkill entityMasterSkill = CreateComponent<EntityMasterSkill>(index);
		entityMasterSkill.mState = newMState;
		entityMasterSkill.mValue = newMValue;
		entityMasterSkill.mMaxValue = newMMaxValue;
		entityMasterSkill.mCD = newMCD;
		entityMasterSkill.mMaxCD = newMMaxCD;
		entityMasterSkill.mConsumeValue = newMConsumeValue;
		entityMasterSkill.mConsumeCD = newMConsumeCD;
		entityMasterSkill.mConfigID = newMConfigID;
		ReplaceComponent(index, entityMasterSkill);
	}

	public void RemoveEntityMasterSkill()
	{
		RemoveComponent(43);
	}

	public void AddEntityMoveClamp(bool newIsCircle, Int3 newMCenter, int newMZLength, int newMXLength, int newMRange)
	{
		int index = 44;
		EntityMoveClamp entityMoveClamp = CreateComponent<EntityMoveClamp>(index);
		entityMoveClamp.isCircle = newIsCircle;
		entityMoveClamp.mCenter = newMCenter;
		entityMoveClamp.mZLength = newMZLength;
		entityMoveClamp.mXLength = newMXLength;
		entityMoveClamp.mRange = newMRange;
		AddComponent(index, entityMoveClamp);
	}

	public void ReplaceEntityMoveClamp(bool newIsCircle, Int3 newMCenter, int newMZLength, int newMXLength, int newMRange)
	{
		int index = 44;
		EntityMoveClamp entityMoveClamp = CreateComponent<EntityMoveClamp>(index);
		entityMoveClamp.isCircle = newIsCircle;
		entityMoveClamp.mCenter = newMCenter;
		entityMoveClamp.mZLength = newMZLength;
		entityMoveClamp.mXLength = newMXLength;
		entityMoveClamp.mRange = newMRange;
		ReplaceComponent(index, entityMoveClamp);
	}

	public void RemoveEntityMoveClamp()
	{
		RemoveComponent(44);
	}

	public void AddEntityActionParrying(int newMAngle, uint newMEnableFlag, int newMEnableCount)
	{
		int index = 17;
		EntityActionParrying entityActionParrying = CreateComponent<EntityActionParrying>(index);
		entityActionParrying.mAngle = newMAngle;
		entityActionParrying.mEnableFlag = newMEnableFlag;
		entityActionParrying.mEnableCount = newMEnableCount;
		AddComponent(index, entityActionParrying);
	}

	public void ReplaceEntityActionParrying(int newMAngle, uint newMEnableFlag, int newMEnableCount)
	{
		int index = 17;
		EntityActionParrying entityActionParrying = CreateComponent<EntityActionParrying>(index);
		entityActionParrying.mAngle = newMAngle;
		entityActionParrying.mEnableFlag = newMEnableFlag;
		entityActionParrying.mEnableCount = newMEnableCount;
		ReplaceComponent(index, entityActionParrying);
	}

	public void RemoveEntityActionParrying()
	{
		RemoveComponent(17);
	}

	public void AddEntityResistance(int newMaxValue, int newCurValue, uint newMaxTime, uint newCurTime, bool newReState, int newReStateEle, int newEnterReason, int newExitReason, List<int> newElement)
	{
		int index = 53;
		EntityResistance entityResistance = CreateComponent<EntityResistance>(index);
		entityResistance.maxValue = newMaxValue;
		entityResistance.curValue = newCurValue;
		entityResistance.maxTime = newMaxTime;
		entityResistance.curTime = newCurTime;
		entityResistance.reState = newReState;
		entityResistance.reStateEle = newReStateEle;
		entityResistance.enterReason = newEnterReason;
		entityResistance.exitReason = newExitReason;
		entityResistance.element = newElement;
		AddComponent(index, entityResistance);
	}

	public void ReplaceEntityResistance(int newMaxValue, int newCurValue, uint newMaxTime, uint newCurTime, bool newReState, int newReStateEle, int newEnterReason, int newExitReason, List<int> newElement)
	{
		int index = 53;
		EntityResistance entityResistance = CreateComponent<EntityResistance>(index);
		entityResistance.maxValue = newMaxValue;
		entityResistance.curValue = newCurValue;
		entityResistance.maxTime = newMaxTime;
		entityResistance.curTime = newCurTime;
		entityResistance.reState = newReState;
		entityResistance.reStateEle = newReStateEle;
		entityResistance.enterReason = newEnterReason;
		entityResistance.exitReason = newExitReason;
		entityResistance.element = newElement;
		ReplaceComponent(index, entityResistance);
	}

	public void RemoveEntityResistance()
	{
		RemoveComponent(53);
	}

	public void AddEntityUniqueSkillEnergy(EntityActionStatus newMState, int newMValue, int newMMaxValue, int newMAddValue, int newMTick, int newMRuntime)
	{
		int index = 62;
		EntityUniqueSkillEnergy entityUniqueSkillEnergy = CreateComponent<EntityUniqueSkillEnergy>(index);
		entityUniqueSkillEnergy.mState = newMState;
		entityUniqueSkillEnergy.mValue = newMValue;
		entityUniqueSkillEnergy.mMaxValue = newMMaxValue;
		entityUniqueSkillEnergy.mAddValue = newMAddValue;
		entityUniqueSkillEnergy.mTick = newMTick;
		entityUniqueSkillEnergy.mRuntime = newMRuntime;
		AddComponent(index, entityUniqueSkillEnergy);
	}

	public void ReplaceEntityUniqueSkillEnergy(EntityActionStatus newMState, int newMValue, int newMMaxValue, int newMAddValue, int newMTick, int newMRuntime)
	{
		int index = 62;
		EntityUniqueSkillEnergy entityUniqueSkillEnergy = CreateComponent<EntityUniqueSkillEnergy>(index);
		entityUniqueSkillEnergy.mState = newMState;
		entityUniqueSkillEnergy.mValue = newMValue;
		entityUniqueSkillEnergy.mMaxValue = newMMaxValue;
		entityUniqueSkillEnergy.mAddValue = newMAddValue;
		entityUniqueSkillEnergy.mTick = newMTick;
		entityUniqueSkillEnergy.mRuntime = newMRuntime;
		ReplaceComponent(index, entityUniqueSkillEnergy);
	}

	public void RemoveEntityUniqueSkillEnergy()
	{
		RemoveComponent(62);
	}

	public void AddEntityActionManualAIInput(EntityActionStatus newMStatus, int newMInputKey, bool newMCanDestroy, bool newMIsPressing)
	{
		int index = 10;
		EntityActionManualAIInput entityActionManualAIInput = CreateComponent<EntityActionManualAIInput>(index);
		entityActionManualAIInput.mStatus = newMStatus;
		entityActionManualAIInput.mInputKey = newMInputKey;
		entityActionManualAIInput.mCanDestroy = newMCanDestroy;
		entityActionManualAIInput.mIsPressing = newMIsPressing;
		AddComponent(index, entityActionManualAIInput);
	}

	public void ReplaceEntityActionManualAIInput(EntityActionStatus newMStatus, int newMInputKey, bool newMCanDestroy, bool newMIsPressing)
	{
		int index = 10;
		EntityActionManualAIInput entityActionManualAIInput = CreateComponent<EntityActionManualAIInput>(index);
		entityActionManualAIInput.mStatus = newMStatus;
		entityActionManualAIInput.mInputKey = newMInputKey;
		entityActionManualAIInput.mCanDestroy = newMCanDestroy;
		entityActionManualAIInput.mIsPressing = newMIsPressing;
		ReplaceComponent(index, entityActionManualAIInput);
	}

	public void RemoveEntityActionManualAIInput()
	{
		RemoveComponent(10);
	}

	public void AddEntityActionModifyCombatScore(EntityActionStatus newMStatus, List<ModifyCombatScoreInfo> newMModifyInfoList)
	{
		int index = 13;
		EntityActionModifyCombatScore entityActionModifyCombatScore = CreateComponent<EntityActionModifyCombatScore>(index);
		entityActionModifyCombatScore.mStatus = newMStatus;
		entityActionModifyCombatScore.mModifyInfoList = newMModifyInfoList;
		AddComponent(index, entityActionModifyCombatScore);
	}

	public void ReplaceEntityActionModifyCombatScore(EntityActionStatus newMStatus, List<ModifyCombatScoreInfo> newMModifyInfoList)
	{
		int index = 13;
		EntityActionModifyCombatScore entityActionModifyCombatScore = CreateComponent<EntityActionModifyCombatScore>(index);
		entityActionModifyCombatScore.mStatus = newMStatus;
		entityActionModifyCombatScore.mModifyInfoList = newMModifyInfoList;
		ReplaceComponent(index, entityActionModifyCombatScore);
	}

	public void RemoveEntityActionModifyCombatScore()
	{
		RemoveComponent(13);
	}

	public void AddEntityUltimateAvoidCD(int newMRuntime, int newMLeftUseCount)
	{
		int index = 61;
		EntityUltimateAvoidCD entityUltimateAvoidCD = CreateComponent<EntityUltimateAvoidCD>(index);
		entityUltimateAvoidCD.mRuntime = newMRuntime;
		entityUltimateAvoidCD.mLeftUseCount = newMLeftUseCount;
		AddComponent(index, entityUltimateAvoidCD);
	}

	public void ReplaceEntityUltimateAvoidCD(int newMRuntime, int newMLeftUseCount)
	{
		int index = 61;
		EntityUltimateAvoidCD entityUltimateAvoidCD = CreateComponent<EntityUltimateAvoidCD>(index);
		entityUltimateAvoidCD.mRuntime = newMRuntime;
		entityUltimateAvoidCD.mLeftUseCount = newMLeftUseCount;
		ReplaceComponent(index, entityUltimateAvoidCD);
	}

	public void RemoveEntityUltimateAvoidCD()
	{
		RemoveComponent(61);
	}

	public void AddEntityExposedValue(long newMValue, long newMMaxValue, long newMReducedValue, int newMTick, int newMRuntime, uint newMResistEnter, bool newMManualEnter)
	{
		int index = 35;
		EntityExposedValue entityExposedValue = CreateComponent<EntityExposedValue>(index);
		entityExposedValue.mValue = newMValue;
		entityExposedValue.mMaxValue = newMMaxValue;
		entityExposedValue.mReducedValue = newMReducedValue;
		entityExposedValue.mTick = newMTick;
		entityExposedValue.mRuntime = newMRuntime;
		entityExposedValue.mResistEnter = newMResistEnter;
		entityExposedValue.mManualEnter = newMManualEnter;
		AddComponent(index, entityExposedValue);
	}

	public void ReplaceEntityExposedValue(long newMValue, long newMMaxValue, long newMReducedValue, int newMTick, int newMRuntime, uint newMResistEnter, bool newMManualEnter)
	{
		int index = 35;
		EntityExposedValue entityExposedValue = CreateComponent<EntityExposedValue>(index);
		entityExposedValue.mValue = newMValue;
		entityExposedValue.mMaxValue = newMMaxValue;
		entityExposedValue.mReducedValue = newMReducedValue;
		entityExposedValue.mTick = newMTick;
		entityExposedValue.mRuntime = newMRuntime;
		entityExposedValue.mResistEnter = newMResistEnter;
		entityExposedValue.mManualEnter = newMManualEnter;
		ReplaceComponent(index, entityExposedValue);
	}

	public void RemoveEntityExposedValue()
	{
		RemoveComponent(35);
	}

	public void AddEntityExposedValueBreak(long newDamage)
	{
		int index = 36;
		EntityExposedValueBreak entityExposedValueBreak = CreateComponent<EntityExposedValueBreak>(index);
		entityExposedValueBreak.Damage = newDamage;
		AddComponent(index, entityExposedValueBreak);
	}

	public void ReplaceEntityExposedValueBreak(long newDamage)
	{
		int index = 36;
		EntityExposedValueBreak entityExposedValueBreak = CreateComponent<EntityExposedValueBreak>(index);
		entityExposedValueBreak.Damage = newDamage;
		ReplaceComponent(index, entityExposedValueBreak);
	}

	public void RemoveEntityExposedValueBreak()
	{
		RemoveComponent(36);
	}

	public void AddEntityExposedValueCoverReducedValue(long newMReducedValue, int newMRuntime)
	{
		int index = 37;
		EntityExposedValueCoverReducedValue entityExposedValueCoverReducedValue = CreateComponent<EntityExposedValueCoverReducedValue>(index);
		entityExposedValueCoverReducedValue.mReducedValue = newMReducedValue;
		entityExposedValueCoverReducedValue.mRuntime = newMRuntime;
		AddComponent(index, entityExposedValueCoverReducedValue);
	}

	public void ReplaceEntityExposedValueCoverReducedValue(long newMReducedValue, int newMRuntime)
	{
		int index = 37;
		EntityExposedValueCoverReducedValue entityExposedValueCoverReducedValue = CreateComponent<EntityExposedValueCoverReducedValue>(index);
		entityExposedValueCoverReducedValue.mReducedValue = newMReducedValue;
		entityExposedValueCoverReducedValue.mRuntime = newMRuntime;
		ReplaceComponent(index, entityExposedValueCoverReducedValue);
	}

	public void RemoveEntityExposedValueCoverReducedValue()
	{
		RemoveComponent(37);
	}

	public void AddEntityQTE(QTEStatusType newMStatus, int newMID, int newMTime, int newMTotalTime)
	{
		int index = 50;
		EntityQTE entityQTE = CreateComponent<EntityQTE>(index);
		entityQTE.mStatus = newMStatus;
		entityQTE.mID = newMID;
		entityQTE.mTime = newMTime;
		entityQTE.mTotalTime = newMTotalTime;
		AddComponent(index, entityQTE);
	}

	public void ReplaceEntityQTE(QTEStatusType newMStatus, int newMID, int newMTime, int newMTotalTime)
	{
		int index = 50;
		EntityQTE entityQTE = CreateComponent<EntityQTE>(index);
		entityQTE.mStatus = newMStatus;
		entityQTE.mID = newMID;
		entityQTE.mTime = newMTime;
		entityQTE.mTotalTime = newMTotalTime;
		ReplaceComponent(index, entityQTE);
	}

	public void RemoveEntityQTE()
	{
		RemoveComponent(50);
	}

	public void AddEntityActionAbilityLogicInput(int newMBrokenAbilityID, bool newMForceBroken)
	{
		int index = 3;
		EntityActionAbilityLogicInput entityActionAbilityLogicInput = CreateComponent<EntityActionAbilityLogicInput>(index);
		entityActionAbilityLogicInput.mBrokenAbilityID = newMBrokenAbilityID;
		entityActionAbilityLogicInput.mForceBroken = newMForceBroken;
		AddComponent(index, entityActionAbilityLogicInput);
	}

	public void ReplaceEntityActionAbilityLogicInput(int newMBrokenAbilityID, bool newMForceBroken)
	{
		int index = 3;
		EntityActionAbilityLogicInput entityActionAbilityLogicInput = CreateComponent<EntityActionAbilityLogicInput>(index);
		entityActionAbilityLogicInput.mBrokenAbilityID = newMBrokenAbilityID;
		entityActionAbilityLogicInput.mForceBroken = newMForceBroken;
		ReplaceComponent(index, entityActionAbilityLogicInput);
	}

	public void RemoveEntityActionAbilityLogicInput()
	{
		RemoveComponent(3);
	}

	public void AddEntityActionAvoidShadow(Int3 newEarliestPosition, bool newPosted, int newLeftTime)
	{
		int index = 5;
		EntityActionAvoidShadow entityActionAvoidShadow = CreateComponent<EntityActionAvoidShadow>(index);
		entityActionAvoidShadow.EarliestPosition = newEarliestPosition;
		entityActionAvoidShadow.Posted = newPosted;
		entityActionAvoidShadow.leftTime = newLeftTime;
		AddComponent(index, entityActionAvoidShadow);
	}

	public void ReplaceEntityActionAvoidShadow(Int3 newEarliestPosition, bool newPosted, int newLeftTime)
	{
		int index = 5;
		EntityActionAvoidShadow entityActionAvoidShadow = CreateComponent<EntityActionAvoidShadow>(index);
		entityActionAvoidShadow.EarliestPosition = newEarliestPosition;
		entityActionAvoidShadow.Posted = newPosted;
		entityActionAvoidShadow.leftTime = newLeftTime;
		ReplaceComponent(index, entityActionAvoidShadow);
	}

	public void RemoveEntityActionAvoidShadow()
	{
		RemoveComponent(5);
	}

	public void AddEntityActionSubJoystick(int newCommandCode, int newTimelineID)
	{
		int index = 18;
		EntityActionSubJoystick entityActionSubJoystick = CreateComponent<EntityActionSubJoystick>(index);
		entityActionSubJoystick.CommandCode = newCommandCode;
		entityActionSubJoystick.TimelineID = newTimelineID;
		AddComponent(index, entityActionSubJoystick);
	}

	public void ReplaceEntityActionSubJoystick(int newCommandCode, int newTimelineID)
	{
		int index = 18;
		EntityActionSubJoystick entityActionSubJoystick = CreateComponent<EntityActionSubJoystick>(index);
		entityActionSubJoystick.CommandCode = newCommandCode;
		entityActionSubJoystick.TimelineID = newTimelineID;
		ReplaceComponent(index, entityActionSubJoystick);
	}

	public void RemoveEntityActionSubJoystick()
	{
		RemoveComponent(18);
	}

	public void AddEntityEndurance(Int newMaxValue, Int newCurrentValue, Int newResumeSpeed, Int newConsumeValue, bool newState)
	{
		int index = 34;
		EntityEndurance entityEndurance = CreateComponent<EntityEndurance>(index);
		entityEndurance.maxValue = newMaxValue;
		entityEndurance.currentValue = newCurrentValue;
		entityEndurance.resumeSpeed = newResumeSpeed;
		entityEndurance.consumeValue = newConsumeValue;
		entityEndurance.state = newState;
		AddComponent(index, entityEndurance);
	}

	public void ReplaceEntityEndurance(Int newMaxValue, Int newCurrentValue, Int newResumeSpeed, Int newConsumeValue, bool newState)
	{
		int index = 34;
		EntityEndurance entityEndurance = CreateComponent<EntityEndurance>(index);
		entityEndurance.maxValue = newMaxValue;
		entityEndurance.currentValue = newCurrentValue;
		entityEndurance.resumeSpeed = newResumeSpeed;
		entityEndurance.consumeValue = newConsumeValue;
		entityEndurance.state = newState;
		ReplaceComponent(index, entityEndurance);
	}

	public void RemoveEntityEndurance()
	{
		RemoveComponent(34);
	}

	public void AddEntityPuppet(int newMParent, int newMThinkTime, bool newMIsClose)
	{
		int index = 48;
		EntityPuppet entityPuppet = CreateComponent<EntityPuppet>(index);
		entityPuppet.mParent = newMParent;
		entityPuppet.mThinkTime = newMThinkTime;
		entityPuppet.mIsClose = newMIsClose;
		AddComponent(index, entityPuppet);
	}

	public void ReplaceEntityPuppet(int newMParent, int newMThinkTime, bool newMIsClose)
	{
		int index = 48;
		EntityPuppet entityPuppet = CreateComponent<EntityPuppet>(index);
		entityPuppet.mParent = newMParent;
		entityPuppet.mThinkTime = newMThinkTime;
		entityPuppet.mIsClose = newMIsClose;
		ReplaceComponent(index, entityPuppet);
	}

	public void RemoveEntityPuppet()
	{
		RemoveComponent(48);
	}

	public void AddEntityPuppetHost(List<int> newMPuppets)
	{
		int index = 49;
		EntityPuppetHost entityPuppetHost = CreateComponent<EntityPuppetHost>(index);
		entityPuppetHost.mPuppets = newMPuppets;
		AddComponent(index, entityPuppetHost);
	}

	public void ReplaceEntityPuppetHost(List<int> newMPuppets)
	{
		int index = 49;
		EntityPuppetHost entityPuppetHost = CreateComponent<EntityPuppetHost>(index);
		entityPuppetHost.mPuppets = newMPuppets;
		ReplaceComponent(index, entityPuppetHost);
	}

	public void RemoveEntityPuppetHost()
	{
		RemoveComponent(49);
	}

	public void AddEntityActionTransfiguration(int newMRoleID, int newMAppearID)
	{
		int index = 19;
		EntityActionTransfiguration entityActionTransfiguration = CreateComponent<EntityActionTransfiguration>(index);
		entityActionTransfiguration.mRoleID = newMRoleID;
		entityActionTransfiguration.mAppearID = newMAppearID;
		AddComponent(index, entityActionTransfiguration);
	}

	public void ReplaceEntityActionTransfiguration(int newMRoleID, int newMAppearID)
	{
		int index = 19;
		EntityActionTransfiguration entityActionTransfiguration = CreateComponent<EntityActionTransfiguration>(index);
		entityActionTransfiguration.mRoleID = newMRoleID;
		entityActionTransfiguration.mAppearID = newMAppearID;
		ReplaceComponent(index, entityActionTransfiguration);
	}

	public void RemoveEntityActionTransfiguration()
	{
		RemoveComponent(19);
	}

	public void AddEntityCD(HashSet<int> newMAward, HashSet<int> newMIgnore, List<AbilityCD> newMAbilityCD, Dictionary<int, AbilityMaxCDInfo> newMAbilityMaxCD, Dictionary<int, int> newMAbilityMaxUse)
	{
		int index = 28;
		EntityCD entityCD = CreateComponent<EntityCD>(index);
		entityCD.mAward = newMAward;
		entityCD.mIgnore = newMIgnore;
		entityCD.mAbilityCD = newMAbilityCD;
		entityCD.mAbilityMaxCD = newMAbilityMaxCD;
		entityCD.mAbilityMaxUse = newMAbilityMaxUse;
		AddComponent(index, entityCD);
	}

	public void ReplaceEntityCD(HashSet<int> newMAward, HashSet<int> newMIgnore, List<AbilityCD> newMAbilityCD, Dictionary<int, AbilityMaxCDInfo> newMAbilityMaxCD, Dictionary<int, int> newMAbilityMaxUse)
	{
		int index = 28;
		EntityCD entityCD = CreateComponent<EntityCD>(index);
		entityCD.mAward = newMAward;
		entityCD.mIgnore = newMIgnore;
		entityCD.mAbilityCD = newMAbilityCD;
		entityCD.mAbilityMaxCD = newMAbilityMaxCD;
		entityCD.mAbilityMaxUse = newMAbilityMaxUse;
		ReplaceComponent(index, entityCD);
	}

	public void RemoveEntityCD()
	{
		RemoveComponent(28);
	}

	public void AddEntityCommander(List<EnemyInfo> newEnemyInfos, List<TargetInfo> newTargetInfos)
	{
		int index = 31;
		EntityCommander entityCommander = CreateComponent<EntityCommander>(index);
		entityCommander.enemyInfos = newEnemyInfos;
		entityCommander.targetInfos = newTargetInfos;
		AddComponent(index, entityCommander);
	}

	public void ReplaceEntityCommander(List<EnemyInfo> newEnemyInfos, List<TargetInfo> newTargetInfos)
	{
		int index = 31;
		EntityCommander entityCommander = CreateComponent<EntityCommander>(index);
		entityCommander.enemyInfos = newEnemyInfos;
		entityCommander.targetInfos = newTargetInfos;
		ReplaceComponent(index, entityCommander);
	}

	public void RemoveEntityCommander()
	{
		RemoveComponent(31);
	}

	public void AddEntityComboNumber(int newComboCount, int newRunningTime)
	{
		int index = 30;
		EntityComboNumber entityComboNumber = CreateComponent<EntityComboNumber>(index);
		entityComboNumber.comboCount = newComboCount;
		entityComboNumber.runningTime = newRunningTime;
		AddComponent(index, entityComboNumber);
	}

	public void ReplaceEntityComboNumber(int newComboCount, int newRunningTime)
	{
		int index = 30;
		EntityComboNumber entityComboNumber = CreateComponent<EntityComboNumber>(index);
		entityComboNumber.comboCount = newComboCount;
		entityComboNumber.runningTime = newRunningTime;
		ReplaceComponent(index, entityComboNumber);
	}

	public void RemoveEntityComboNumber()
	{
		RemoveComponent(30);
	}

	public void AddEntityTimer(List<EntityTimerStruct> newEntityTimers)
	{
		int index = 59;
		EntityTimer entityTimer = CreateComponent<EntityTimer>(index);
		entityTimer.entityTimers = newEntityTimers;
		AddComponent(index, entityTimer);
	}

	public void ReplaceEntityTimer(List<EntityTimerStruct> newEntityTimers)
	{
		int index = 59;
		EntityTimer entityTimer = CreateComponent<EntityTimer>(index);
		entityTimer.entityTimers = newEntityTimers;
		ReplaceComponent(index, entityTimer);
	}

	public void RemoveEntityTimer()
	{
		RemoveComponent(59);
	}

	public void AddEntityPostureValue(int newDeltaValue, int newValue, int newMaxValue, BreakState newState, int newCurTime, int newBreakCDTime, int newBreakMaxTime, int newDelayTime, int newIntervalTime, uint newCantBreakFlag, int newDamageType)
	{
		int index = 46;
		EntityPostureValue entityPostureValue = CreateComponent<EntityPostureValue>(index);
		entityPostureValue.deltaValue = newDeltaValue;
		entityPostureValue.value = newValue;
		entityPostureValue.maxValue = newMaxValue;
		entityPostureValue.state = newState;
		entityPostureValue.curTime = newCurTime;
		entityPostureValue.breakCDTime = newBreakCDTime;
		entityPostureValue.breakMaxTime = newBreakMaxTime;
		entityPostureValue.delayTime = newDelayTime;
		entityPostureValue.intervalTime = newIntervalTime;
		entityPostureValue.cantBreakFlag = newCantBreakFlag;
		entityPostureValue.damageType = newDamageType;
		AddComponent(index, entityPostureValue);
	}

	public void ReplaceEntityPostureValue(int newDeltaValue, int newValue, int newMaxValue, BreakState newState, int newCurTime, int newBreakCDTime, int newBreakMaxTime, int newDelayTime, int newIntervalTime, uint newCantBreakFlag, int newDamageType)
	{
		int index = 46;
		EntityPostureValue entityPostureValue = CreateComponent<EntityPostureValue>(index);
		entityPostureValue.deltaValue = newDeltaValue;
		entityPostureValue.value = newValue;
		entityPostureValue.maxValue = newMaxValue;
		entityPostureValue.state = newState;
		entityPostureValue.curTime = newCurTime;
		entityPostureValue.breakCDTime = newBreakCDTime;
		entityPostureValue.breakMaxTime = newBreakMaxTime;
		entityPostureValue.delayTime = newDelayTime;
		entityPostureValue.intervalTime = newIntervalTime;
		entityPostureValue.cantBreakFlag = newCantBreakFlag;
		entityPostureValue.damageType = newDamageType;
		ReplaceComponent(index, entityPostureValue);
	}

	public void RemoveEntityPostureValue()
	{
		RemoveComponent(46);
	}

	public void AddEntityBoss(int newDeltaValueEveryTime, int newReductionTime, int newReductionPercent, int newAttackTime, int newCurrentTime, Dictionary<int, int> newValue)
	{
		int index = 24;
		EntityBoss entityBoss = CreateComponent<EntityBoss>(index);
		entityBoss.deltaValueEveryTime = newDeltaValueEveryTime;
		entityBoss.reductionTime = newReductionTime;
		entityBoss.reductionPercent = newReductionPercent;
		entityBoss.attackTime = newAttackTime;
		entityBoss.currentTime = newCurrentTime;
		entityBoss.value = newValue;
		AddComponent(index, entityBoss);
	}

	public void ReplaceEntityBoss(int newDeltaValueEveryTime, int newReductionTime, int newReductionPercent, int newAttackTime, int newCurrentTime, Dictionary<int, int> newValue)
	{
		int index = 24;
		EntityBoss entityBoss = CreateComponent<EntityBoss>(index);
		entityBoss.deltaValueEveryTime = newDeltaValueEveryTime;
		entityBoss.reductionTime = newReductionTime;
		entityBoss.reductionPercent = newReductionPercent;
		entityBoss.attackTime = newAttackTime;
		entityBoss.currentTime = newCurrentTime;
		entityBoss.value = newValue;
		ReplaceComponent(index, entityBoss);
	}

	public void RemoveEntityBoss()
	{
		RemoveComponent(24);
	}

	public void AddEntityRecastCut(bool newIsEnable, NavmeshCut newCutParam)
	{
		int index = 51;
		EntityRecastCut entityRecastCut = CreateComponent<EntityRecastCut>(index);
		entityRecastCut.isEnable = newIsEnable;
		entityRecastCut.cutParam = newCutParam;
		AddComponent(index, entityRecastCut);
	}

	public void ReplaceEntityRecastCut(bool newIsEnable, NavmeshCut newCutParam)
	{
		int index = 51;
		EntityRecastCut entityRecastCut = CreateComponent<EntityRecastCut>(index);
		entityRecastCut.isEnable = newIsEnable;
		entityRecastCut.cutParam = newCutParam;
		ReplaceComponent(index, entityRecastCut);
	}

	public void RemoveEntityRecastCut()
	{
		RemoveComponent(51);
	}

	public void AddEntityCameraView(Int3 newMViewPosition, Int3 newMViewDirection, int newMFOV, int newMLimitDegree, int newMViewDistance, int newMIsColinear, int newMViewLerpTime)
	{
		int index = 26;
		EntityCameraView entityCameraView = CreateComponent<EntityCameraView>(index);
		entityCameraView.mViewPosition = newMViewPosition;
		entityCameraView.mViewDirection = newMViewDirection;
		entityCameraView.mFOV = newMFOV;
		entityCameraView.mLimitDegree = newMLimitDegree;
		entityCameraView.mViewDistance = newMViewDistance;
		entityCameraView.mIsColinear = newMIsColinear;
		entityCameraView.mViewLerpTime = newMViewLerpTime;
		AddComponent(index, entityCameraView);
	}

	public void ReplaceEntityCameraView(Int3 newMViewPosition, Int3 newMViewDirection, int newMFOV, int newMLimitDegree, int newMViewDistance, int newMIsColinear, int newMViewLerpTime)
	{
		int index = 26;
		EntityCameraView entityCameraView = CreateComponent<EntityCameraView>(index);
		entityCameraView.mViewPosition = newMViewPosition;
		entityCameraView.mViewDirection = newMViewDirection;
		entityCameraView.mFOV = newMFOV;
		entityCameraView.mLimitDegree = newMLimitDegree;
		entityCameraView.mViewDistance = newMViewDistance;
		entityCameraView.mIsColinear = newMIsColinear;
		entityCameraView.mViewLerpTime = newMViewLerpTime;
		ReplaceComponent(index, entityCameraView);
	}

	public void RemoveEntityCameraView()
	{
		RemoveComponent(26);
	}

	public void AddEntityAIMovement(int newMPrevAvoidEntityID, int newMDirection, int newMTimer)
	{
		int index = 21;
		EntityAIMovement entityAIMovement = CreateComponent<EntityAIMovement>(index);
		entityAIMovement.mPrevAvoidEntityID = newMPrevAvoidEntityID;
		entityAIMovement.mDirection = newMDirection;
		entityAIMovement.mTimer = newMTimer;
		AddComponent(index, entityAIMovement);
	}

	public void ReplaceEntityAIMovement(int newMPrevAvoidEntityID, int newMDirection, int newMTimer)
	{
		int index = 21;
		EntityAIMovement entityAIMovement = CreateComponent<EntityAIMovement>(index);
		entityAIMovement.mPrevAvoidEntityID = newMPrevAvoidEntityID;
		entityAIMovement.mDirection = newMDirection;
		entityAIMovement.mTimer = newMTimer;
		ReplaceComponent(index, entityAIMovement);
	}

	public void RemoveEntityAIMovement()
	{
		RemoveComponent(21);
	}

	public void AddEntityActionAbility(EntityActionStatus newMStatus, int newMAbilityID, int newMHitIndex, int newMOffsetIndex, int newMTargetID, int newMKartunTime, bool newMIsPressing, int newMCurLockIndex, int newMCasterID, bool newMEnableAbilityMovement, int newMAbilitySpeed, int newMLogicTime, int newMCurrentStateIndex, int newMCurTurnIndex, bool newMInUltimateAvoidFrame, int newMTimeStep, bool newMCanBeParry, int newMAttackApproachSpeed)
	{
		int index = 1;
		EntityActionAbility entityActionAbility = CreateComponent<EntityActionAbility>(index);
		entityActionAbility.mStatus = newMStatus;
		entityActionAbility.mAbilityID = newMAbilityID;
		entityActionAbility.mHitIndex = newMHitIndex;
		entityActionAbility.mOffsetIndex = newMOffsetIndex;
		entityActionAbility.mTargetID = newMTargetID;
		entityActionAbility.mKartunTime = newMKartunTime;
		entityActionAbility.mIsPressing = newMIsPressing;
		entityActionAbility.mCurLockIndex = newMCurLockIndex;
		entityActionAbility.mCasterID = newMCasterID;
		entityActionAbility.mEnableAbilityMovement = newMEnableAbilityMovement;
		entityActionAbility.mAbilitySpeed = newMAbilitySpeed;
		entityActionAbility.mLogicTime = newMLogicTime;
		entityActionAbility.mCurrentStateIndex = newMCurrentStateIndex;
		entityActionAbility.mCurTurnIndex = newMCurTurnIndex;
		entityActionAbility.mInUltimateAvoidFrame = newMInUltimateAvoidFrame;
		entityActionAbility.mTimeStep = newMTimeStep;
		entityActionAbility.mCanBeParry = newMCanBeParry;
		entityActionAbility.MAttackApproachSpeed = newMAttackApproachSpeed;
		AddComponent(index, entityActionAbility);
	}

	public void ReplaceEntityActionAbility(EntityActionStatus newMStatus, int newMAbilityID, int newMHitIndex, int newMOffsetIndex, int newMTargetID, int newMKartunTime, bool newMIsPressing, int newMCurLockIndex, int newMCasterID, bool newMEnableAbilityMovement, int newMAbilitySpeed, int newMLogicTime, int newMCurrentStateIndex, int newMCurTurnIndex, bool newMInUltimateAvoidFrame, int newMTimeStep, bool newMCanBeParry, int newMAttackApproachSpeed)
	{
		int index = 1;
		EntityActionAbility entityActionAbility = CreateComponent<EntityActionAbility>(index);
		entityActionAbility.mStatus = newMStatus;
		entityActionAbility.mAbilityID = newMAbilityID;
		entityActionAbility.mHitIndex = newMHitIndex;
		entityActionAbility.mOffsetIndex = newMOffsetIndex;
		entityActionAbility.mTargetID = newMTargetID;
		entityActionAbility.mKartunTime = newMKartunTime;
		entityActionAbility.mIsPressing = newMIsPressing;
		entityActionAbility.mCurLockIndex = newMCurLockIndex;
		entityActionAbility.mCasterID = newMCasterID;
		entityActionAbility.mEnableAbilityMovement = newMEnableAbilityMovement;
		entityActionAbility.mAbilitySpeed = newMAbilitySpeed;
		entityActionAbility.mLogicTime = newMLogicTime;
		entityActionAbility.mCurrentStateIndex = newMCurrentStateIndex;
		entityActionAbility.mCurTurnIndex = newMCurTurnIndex;
		entityActionAbility.mInUltimateAvoidFrame = newMInUltimateAvoidFrame;
		entityActionAbility.mTimeStep = newMTimeStep;
		entityActionAbility.mCanBeParry = newMCanBeParry;
		entityActionAbility.MAttackApproachSpeed = newMAttackApproachSpeed;
		ReplaceComponent(index, entityActionAbility);
	}

	public void RemoveEntityActionAbility()
	{
		RemoveComponent(1);
	}

	public void AddEntityHide(E_EntityHideType newMHide)
	{
		int index = 39;
		EntityHide entityHide = CreateComponent<EntityHide>(index);
		entityHide.mHide = newMHide;
		AddComponent(index, entityHide);
	}

	public void ReplaceEntityHide(E_EntityHideType newMHide)
	{
		int index = 39;
		EntityHide entityHide = CreateComponent<EntityHide>(index);
		entityHide.mHide = newMHide;
		ReplaceComponent(index, entityHide);
	}

	public void RemoveEntityHide()
	{
		RemoveComponent(39);
	}

	public void AddEntityPredicationPlayer(int newMOwnerID)
	{
		int index = 47;
		EntityPredicationPlayer entityPredicationPlayer = CreateComponent<EntityPredicationPlayer>(index);
		entityPredicationPlayer.mOwnerID = newMOwnerID;
		AddComponent(index, entityPredicationPlayer);
	}

	public void ReplaceEntityPredicationPlayer(int newMOwnerID)
	{
		int index = 47;
		EntityPredicationPlayer entityPredicationPlayer = CreateComponent<EntityPredicationPlayer>(index);
		entityPredicationPlayer.mOwnerID = newMOwnerID;
		ReplaceComponent(index, entityPredicationPlayer);
	}

	public void RemoveEntityPredicationPlayer()
	{
		RemoveComponent(47);
	}

	public void AddEntityRemotePlayer(int newMNetID, int newMLocalEntityID, bool newMIsLocalPlayer)
	{
		int index = 52;
		EntityRemotePlayer entityRemotePlayer = CreateComponent<EntityRemotePlayer>(index);
		entityRemotePlayer.mNetID = newMNetID;
		entityRemotePlayer.mLocalEntityID = newMLocalEntityID;
		entityRemotePlayer.mIsLocalPlayer = newMIsLocalPlayer;
		AddComponent(index, entityRemotePlayer);
	}

	public void ReplaceEntityRemotePlayer(int newMNetID, int newMLocalEntityID, bool newMIsLocalPlayer)
	{
		int index = 52;
		EntityRemotePlayer entityRemotePlayer = CreateComponent<EntityRemotePlayer>(index);
		entityRemotePlayer.mNetID = newMNetID;
		entityRemotePlayer.mLocalEntityID = newMLocalEntityID;
		entityRemotePlayer.mIsLocalPlayer = newMIsLocalPlayer;
		ReplaceComponent(index, entityRemotePlayer);
	}

	public void RemoveEntityRemotePlayer()
	{
		RemoveComponent(52);
	}

	public void AddEntityActionManualInput(EntityActionStatus newMStatus, int newMInputKey, long newMInputStamp, bool newMCanDestroy, bool newMIsPressing)
	{
		int index = 11;
		EntityActionManualInput entityActionManualInput = CreateComponent<EntityActionManualInput>(index);
		entityActionManualInput.mStatus = newMStatus;
		entityActionManualInput.mInputKey = newMInputKey;
		entityActionManualInput.mInputStamp = newMInputStamp;
		entityActionManualInput.mCanDestroy = newMCanDestroy;
		entityActionManualInput.mIsPressing = newMIsPressing;
		AddComponent(index, entityActionManualInput);
	}

	public void ReplaceEntityActionManualInput(EntityActionStatus newMStatus, int newMInputKey, long newMInputStamp, bool newMCanDestroy, bool newMIsPressing)
	{
		int index = 11;
		EntityActionManualInput entityActionManualInput = CreateComponent<EntityActionManualInput>(index);
		entityActionManualInput.mStatus = newMStatus;
		entityActionManualInput.mInputKey = newMInputKey;
		entityActionManualInput.mInputStamp = newMInputStamp;
		entityActionManualInput.mCanDestroy = newMCanDestroy;
		entityActionManualInput.mIsPressing = newMIsPressing;
		ReplaceComponent(index, entityActionManualInput);
	}

	public void RemoveEntityActionManualInput()
	{
		RemoveComponent(11);
	}

	public void AddEntityActionMoveDirection(EntityActionStatus newMStatus, Int3 newMDirection, Int3 newMLastDirection, bool newMIsTurn, int newMLogicTime, Int3 newMSpeedDirection, int newMMoveID, int newMTimeStep, Int3 newMMovementDirection, EMoveDirectionMode newMMoveMode)
	{
		int index = 16;
		EntityActionMoveDirection entityActionMoveDirection = CreateComponent<EntityActionMoveDirection>(index);
		entityActionMoveDirection.mStatus = newMStatus;
		entityActionMoveDirection.mDirection = newMDirection;
		entityActionMoveDirection.mLastDirection = newMLastDirection;
		entityActionMoveDirection.mIsTurn = newMIsTurn;
		entityActionMoveDirection.mLogicTime = newMLogicTime;
		entityActionMoveDirection.mSpeedDirection = newMSpeedDirection;
		entityActionMoveDirection.mMoveID = newMMoveID;
		entityActionMoveDirection.mTimeStep = newMTimeStep;
		entityActionMoveDirection.mMovementDirection = newMMovementDirection;
		entityActionMoveDirection.mMoveMode = newMMoveMode;
		AddComponent(index, entityActionMoveDirection);
	}

	public void ReplaceEntityActionMoveDirection(EntityActionStatus newMStatus, Int3 newMDirection, Int3 newMLastDirection, bool newMIsTurn, int newMLogicTime, Int3 newMSpeedDirection, int newMMoveID, int newMTimeStep, Int3 newMMovementDirection, EMoveDirectionMode newMMoveMode)
	{
		int index = 16;
		EntityActionMoveDirection entityActionMoveDirection = CreateComponent<EntityActionMoveDirection>(index);
		entityActionMoveDirection.mStatus = newMStatus;
		entityActionMoveDirection.mDirection = newMDirection;
		entityActionMoveDirection.mLastDirection = newMLastDirection;
		entityActionMoveDirection.mIsTurn = newMIsTurn;
		entityActionMoveDirection.mLogicTime = newMLogicTime;
		entityActionMoveDirection.mSpeedDirection = newMSpeedDirection;
		entityActionMoveDirection.mMoveID = newMMoveID;
		entityActionMoveDirection.mTimeStep = newMTimeStep;
		entityActionMoveDirection.mMovementDirection = newMMovementDirection;
		entityActionMoveDirection.mMoveMode = newMMoveMode;
		ReplaceComponent(index, entityActionMoveDirection);
	}

	public void RemoveEntityActionMoveDirection()
	{
		RemoveComponent(16);
	}

	public void AddEntityTestGoogle(Queue<IMessage> newMRecvCache)
	{
		int index = 58;
		EntityTestGoogle entityTestGoogle = CreateComponent<EntityTestGoogle>(index);
		entityTestGoogle.mRecvCache = newMRecvCache;
		AddComponent(index, entityTestGoogle);
	}

	public void ReplaceEntityTestGoogle(Queue<IMessage> newMRecvCache)
	{
		int index = 58;
		EntityTestGoogle entityTestGoogle = CreateComponent<EntityTestGoogle>(index);
		entityTestGoogle.mRecvCache = newMRecvCache;
		ReplaceComponent(index, entityTestGoogle);
	}

	public void RemoveEntityTestGoogle()
	{
		RemoveComponent(58);
	}

	public void AddEntityLocalPlayer(int newMNetID, int newMRemoteEntityID)
	{
		int index = 42;
		EntityLocalPlayer entityLocalPlayer = CreateComponent<EntityLocalPlayer>(index);
		entityLocalPlayer.mNetID = newMNetID;
		entityLocalPlayer.mRemoteEntityID = newMRemoteEntityID;
		AddComponent(index, entityLocalPlayer);
	}

	public void ReplaceEntityLocalPlayer(int newMNetID, int newMRemoteEntityID)
	{
		int index = 42;
		EntityLocalPlayer entityLocalPlayer = CreateComponent<EntityLocalPlayer>(index);
		entityLocalPlayer.mNetID = newMNetID;
		entityLocalPlayer.mRemoteEntityID = newMRemoteEntityID;
		ReplaceComponent(index, entityLocalPlayer);
	}

	public void RemoveEntityLocalPlayer()
	{
		RemoveComponent(42);
	}

	public void AddEntitySkillEffect(int newMSkillEffectCreator, int newMSkillConfigID, int newMSkillCastCount, int newMSkillSingleTargetID, Int3 newMEffectStartPosition, Int3 newMEffectPosition, int newMEffectReadyTime, int newMEffectDuring, int newMEffectTick)
	{
		int index = 56;
		EntitySkillEffect entitySkillEffect = CreateComponent<EntitySkillEffect>(index);
		entitySkillEffect.mSkillEffectCreator = newMSkillEffectCreator;
		entitySkillEffect.mSkillConfigID = newMSkillConfigID;
		entitySkillEffect.mSkillCastCount = newMSkillCastCount;
		entitySkillEffect.mSkillSingleTargetID = newMSkillSingleTargetID;
		entitySkillEffect.mEffectStartPosition = newMEffectStartPosition;
		entitySkillEffect.mEffectPosition = newMEffectPosition;
		entitySkillEffect.mEffectReadyTime = newMEffectReadyTime;
		entitySkillEffect.mEffectDuring = newMEffectDuring;
		entitySkillEffect.mEffectTick = newMEffectTick;
		AddComponent(index, entitySkillEffect);
	}

	public void ReplaceEntitySkillEffect(int newMSkillEffectCreator, int newMSkillConfigID, int newMSkillCastCount, int newMSkillSingleTargetID, Int3 newMEffectStartPosition, Int3 newMEffectPosition, int newMEffectReadyTime, int newMEffectDuring, int newMEffectTick)
	{
		int index = 56;
		EntitySkillEffect entitySkillEffect = CreateComponent<EntitySkillEffect>(index);
		entitySkillEffect.mSkillEffectCreator = newMSkillEffectCreator;
		entitySkillEffect.mSkillConfigID = newMSkillConfigID;
		entitySkillEffect.mSkillCastCount = newMSkillCastCount;
		entitySkillEffect.mSkillSingleTargetID = newMSkillSingleTargetID;
		entitySkillEffect.mEffectStartPosition = newMEffectStartPosition;
		entitySkillEffect.mEffectPosition = newMEffectPosition;
		entitySkillEffect.mEffectReadyTime = newMEffectReadyTime;
		entitySkillEffect.mEffectDuring = newMEffectDuring;
		entitySkillEffect.mEffectTick = newMEffectTick;
		ReplaceComponent(index, entitySkillEffect);
	}

	public void RemoveEntitySkillEffect()
	{
		RemoveComponent(56);
	}

	public void AddEntityBuff(List<int> newMBuffID, List<int> newMBuffClassIDArray, List<int> newMBuffRuntime, List<int> newMBuffCasterArray, List<int> newMDuringArray, List<int> newMTickArray, List<BuffParams> newMBuffParamsArray, List<int> newMBuffConfigID, List<int> newMBuffFloor, List<int> newMBuffKeepTimeArray)
	{
		int index = 25;
		EntityBuff entityBuff = CreateComponent<EntityBuff>(index);
		entityBuff.mBuffID = newMBuffID;
		entityBuff.mBuffClassIDArray = newMBuffClassIDArray;
		entityBuff.mBuffRuntime = newMBuffRuntime;
		entityBuff.mBuffCasterArray = newMBuffCasterArray;
		entityBuff.mDuringArray = newMDuringArray;
		entityBuff.mTickArray = newMTickArray;
		entityBuff.mBuffParamsArray = newMBuffParamsArray;
		entityBuff.mBuffConfigID = newMBuffConfigID;
		entityBuff.mBuffFloor = newMBuffFloor;
		entityBuff.mBuffKeepTimeArray = newMBuffKeepTimeArray;
		AddComponent(index, entityBuff);
	}

	public void ReplaceEntityBuff(List<int> newMBuffID, List<int> newMBuffClassIDArray, List<int> newMBuffRuntime, List<int> newMBuffCasterArray, List<int> newMDuringArray, List<int> newMTickArray, List<BuffParams> newMBuffParamsArray, List<int> newMBuffConfigID, List<int> newMBuffFloor, List<int> newMBuffKeepTimeArray)
	{
		int index = 25;
		EntityBuff entityBuff = CreateComponent<EntityBuff>(index);
		entityBuff.mBuffID = newMBuffID;
		entityBuff.mBuffClassIDArray = newMBuffClassIDArray;
		entityBuff.mBuffRuntime = newMBuffRuntime;
		entityBuff.mBuffCasterArray = newMBuffCasterArray;
		entityBuff.mDuringArray = newMDuringArray;
		entityBuff.mTickArray = newMTickArray;
		entityBuff.mBuffParamsArray = newMBuffParamsArray;
		entityBuff.mBuffConfigID = newMBuffConfigID;
		entityBuff.mBuffFloor = newMBuffFloor;
		entityBuff.mBuffKeepTimeArray = newMBuffKeepTimeArray;
		ReplaceComponent(index, entityBuff);
	}

	public void RemoveEntityBuff()
	{
		RemoveComponent(25);
	}

	public void AddEntityActionJump(Int3 newMTargetPos, int newMMaxHeight, int newMStartActionReadyTime, int newMG, E_JumpActionStatus newMStatus, Int3 newMHSpeed, int newMVSpeed, bool newMUseTartgetPos)
	{
		int index = 9;
		EntityActionJump entityActionJump = CreateComponent<EntityActionJump>(index);
		entityActionJump.mTargetPos = newMTargetPos;
		entityActionJump.mMaxHeight = newMMaxHeight;
		entityActionJump.mStartActionReadyTime = newMStartActionReadyTime;
		entityActionJump.mG = newMG;
		entityActionJump.mStatus = newMStatus;
		entityActionJump.mHSpeed = newMHSpeed;
		entityActionJump.mVSpeed = newMVSpeed;
		entityActionJump.mUseTartgetPos = newMUseTartgetPos;
		AddComponent(index, entityActionJump);
	}

	public void ReplaceEntityActionJump(Int3 newMTargetPos, int newMMaxHeight, int newMStartActionReadyTime, int newMG, E_JumpActionStatus newMStatus, Int3 newMHSpeed, int newMVSpeed, bool newMUseTartgetPos)
	{
		int index = 9;
		EntityActionJump entityActionJump = CreateComponent<EntityActionJump>(index);
		entityActionJump.mTargetPos = newMTargetPos;
		entityActionJump.mMaxHeight = newMMaxHeight;
		entityActionJump.mStartActionReadyTime = newMStartActionReadyTime;
		entityActionJump.mG = newMG;
		entityActionJump.mStatus = newMStatus;
		entityActionJump.mHSpeed = newMHSpeed;
		entityActionJump.mVSpeed = newMVSpeed;
		entityActionJump.mUseTartgetPos = newMUseTartgetPos;
		ReplaceComponent(index, entityActionJump);
	}

	public void RemoveEntityActionJump()
	{
		RemoveComponent(9);
	}

	public void AddEntityActionIdle(EntityActionStatus newMStatus)
	{
		int index = 8;
		EntityActionIdle entityActionIdle = CreateComponent<EntityActionIdle>(index);
		entityActionIdle.mStatus = newMStatus;
		AddComponent(index, entityActionIdle);
	}

	public void ReplaceEntityActionIdle(EntityActionStatus newMStatus)
	{
		int index = 8;
		EntityActionIdle entityActionIdle = CreateComponent<EntityActionIdle>(index);
		entityActionIdle.mStatus = newMStatus;
		ReplaceComponent(index, entityActionIdle);
	}

	public void RemoveEntityActionIdle()
	{
		RemoveComponent(8);
	}

	public void AddEntityID(int newMID)
	{
		int index = 41;
		EntityID entityID = CreateComponent<EntityID>(index);
		entityID.mID = newMID;
		AddComponent(index, entityID);
	}

	public void ReplaceEntityID(int newMID)
	{
		int index = 41;
		EntityID entityID = CreateComponent<EntityID>(index);
		entityID.mID = newMID;
		ReplaceComponent(index, entityID);
	}

	public void RemoveEntityID()
	{
		RemoveComponent(41);
	}

	public void AddEntityConfig(IMessage newMConfig, int newMId)
	{
		int index = 32;
		EntityConfig entityConfig = CreateComponent<EntityConfig>(index);
		entityConfig.mConfig = newMConfig;
		entityConfig.mId = newMId;
		AddComponent(index, entityConfig);
	}

	public void ReplaceEntityConfig(IMessage newMConfig, int newMId)
	{
		int index = 32;
		EntityConfig entityConfig = CreateComponent<EntityConfig>(index);
		entityConfig.mConfig = newMConfig;
		entityConfig.mId = newMId;
		ReplaceComponent(index, entityConfig);
	}

	public void RemoveEntityConfig()
	{
		RemoveComponent(32);
	}

	public void AddEntityHitRecover(E_HitRecover newMHitRecover, int newMHitRecoverTime, int newMHitRecoverActionID, Int3 newMLookAtDirection, Int3 newMHitDirection, int newMHitSpeed, int newMHitAcceleration, HitCheckInfo newMHitInfo, int newMHitUpSpeed, bool newMEnableMovement, int newMHitOffsetTime, E_HitRecoverStatus newMHitRecoverStatus, int newMCanProcessVerticalTime, int newMHitAbilityID, int newMHitCount, int newMHitHorizontalSpeedOnFloat, int newMCurrentStateIndex, int newMTimeScale, int newMLoop, int newMTimeStep, int newMCasterID, Int3 newMLastOffsetMove)
	{
		int index = 40;
		EntityHitRecover entityHitRecover = CreateComponent<EntityHitRecover>(index);
		entityHitRecover.mHitRecover = newMHitRecover;
		entityHitRecover.mHitRecoverTime = newMHitRecoverTime;
		entityHitRecover.mHitRecoverActionID = newMHitRecoverActionID;
		entityHitRecover.mLookAtDirection = newMLookAtDirection;
		entityHitRecover.mHitDirection = newMHitDirection;
		entityHitRecover.mHitSpeed = newMHitSpeed;
		entityHitRecover.mHitAcceleration = newMHitAcceleration;
		entityHitRecover.mHitInfo = newMHitInfo;
		entityHitRecover.mHitUpSpeed = newMHitUpSpeed;
		entityHitRecover.mEnableMovement = newMEnableMovement;
		entityHitRecover.mHitOffsetTime = newMHitOffsetTime;
		entityHitRecover.mHitRecoverStatus = newMHitRecoverStatus;
		entityHitRecover.mCanProcessVerticalTime = newMCanProcessVerticalTime;
		entityHitRecover.mHitAbilityID = newMHitAbilityID;
		entityHitRecover.mHitCount = newMHitCount;
		entityHitRecover.mHitHorizontalSpeedOnFloat = newMHitHorizontalSpeedOnFloat;
		entityHitRecover.mCurrentStateIndex = newMCurrentStateIndex;
		entityHitRecover.mTimeScale = newMTimeScale;
		entityHitRecover.mLoop = newMLoop;
		entityHitRecover.mTimeStep = newMTimeStep;
		entityHitRecover.mCasterID = newMCasterID;
		entityHitRecover.mLastOffsetMove = newMLastOffsetMove;
		AddComponent(index, entityHitRecover);
	}

	public void ReplaceEntityHitRecover(E_HitRecover newMHitRecover, int newMHitRecoverTime, int newMHitRecoverActionID, Int3 newMLookAtDirection, Int3 newMHitDirection, int newMHitSpeed, int newMHitAcceleration, HitCheckInfo newMHitInfo, int newMHitUpSpeed, bool newMEnableMovement, int newMHitOffsetTime, E_HitRecoverStatus newMHitRecoverStatus, int newMCanProcessVerticalTime, int newMHitAbilityID, int newMHitCount, int newMHitHorizontalSpeedOnFloat, int newMCurrentStateIndex, int newMTimeScale, int newMLoop, int newMTimeStep, int newMCasterID, Int3 newMLastOffsetMove)
	{
		int index = 40;
		EntityHitRecover entityHitRecover = CreateComponent<EntityHitRecover>(index);
		entityHitRecover.mHitRecover = newMHitRecover;
		entityHitRecover.mHitRecoverTime = newMHitRecoverTime;
		entityHitRecover.mHitRecoverActionID = newMHitRecoverActionID;
		entityHitRecover.mLookAtDirection = newMLookAtDirection;
		entityHitRecover.mHitDirection = newMHitDirection;
		entityHitRecover.mHitSpeed = newMHitSpeed;
		entityHitRecover.mHitAcceleration = newMHitAcceleration;
		entityHitRecover.mHitInfo = newMHitInfo;
		entityHitRecover.mHitUpSpeed = newMHitUpSpeed;
		entityHitRecover.mEnableMovement = newMEnableMovement;
		entityHitRecover.mHitOffsetTime = newMHitOffsetTime;
		entityHitRecover.mHitRecoverStatus = newMHitRecoverStatus;
		entityHitRecover.mCanProcessVerticalTime = newMCanProcessVerticalTime;
		entityHitRecover.mHitAbilityID = newMHitAbilityID;
		entityHitRecover.mHitCount = newMHitCount;
		entityHitRecover.mHitHorizontalSpeedOnFloat = newMHitHorizontalSpeedOnFloat;
		entityHitRecover.mCurrentStateIndex = newMCurrentStateIndex;
		entityHitRecover.mTimeScale = newMTimeScale;
		entityHitRecover.mLoop = newMLoop;
		entityHitRecover.mTimeStep = newMTimeStep;
		entityHitRecover.mCasterID = newMCasterID;
		entityHitRecover.mLastOffsetMove = newMLastOffsetMove;
		ReplaceComponent(index, entityHitRecover);
	}

	public void RemoveEntityHitRecover()
	{
		RemoveComponent(40);
	}

	public void AddEntityActionBorn(EntityActionStatus newMStatus, int newMBornDuring)
	{
		int index = 6;
		EntityActionBorn entityActionBorn = CreateComponent<EntityActionBorn>(index);
		entityActionBorn.mStatus = newMStatus;
		entityActionBorn.mBornDuring = newMBornDuring;
		AddComponent(index, entityActionBorn);
	}

	public void ReplaceEntityActionBorn(EntityActionStatus newMStatus, int newMBornDuring)
	{
		int index = 6;
		EntityActionBorn entityActionBorn = CreateComponent<EntityActionBorn>(index);
		entityActionBorn.mStatus = newMStatus;
		entityActionBorn.mBornDuring = newMBornDuring;
		ReplaceComponent(index, entityActionBorn);
	}

	public void RemoveEntityActionBorn()
	{
		RemoveComponent(6);
	}

	public void AddEntityActionMelee(EntityActionStatus newMStatus, int newMAttackID, bool newMIsReady, int newMAttackTime, Int3 newMAttackDirection, int newMAttackStatus, int newMCurOffsetCount, int newMCurHitCount, int newMNextAttackTime, int newMAttackOnceDuring, int newMHitDuring, int newMHitCheckCount)
	{
		int index = 12;
		EntityActionMelee entityActionMelee = CreateComponent<EntityActionMelee>(index);
		entityActionMelee.mStatus = newMStatus;
		entityActionMelee.mAttackID = newMAttackID;
		entityActionMelee.mIsReady = newMIsReady;
		entityActionMelee.mAttackTime = newMAttackTime;
		entityActionMelee.mAttackDirection = newMAttackDirection;
		entityActionMelee.mAttackStatus = newMAttackStatus;
		entityActionMelee.mCurOffsetCount = newMCurOffsetCount;
		entityActionMelee.mCurHitCount = newMCurHitCount;
		entityActionMelee.mNextAttackTime = newMNextAttackTime;
		entityActionMelee.mAttackOnceDuring = newMAttackOnceDuring;
		entityActionMelee.mHitDuring = newMHitDuring;
		entityActionMelee.mHitCheckCount = newMHitCheckCount;
		AddComponent(index, entityActionMelee);
	}

	public void ReplaceEntityActionMelee(EntityActionStatus newMStatus, int newMAttackID, bool newMIsReady, int newMAttackTime, Int3 newMAttackDirection, int newMAttackStatus, int newMCurOffsetCount, int newMCurHitCount, int newMNextAttackTime, int newMAttackOnceDuring, int newMHitDuring, int newMHitCheckCount)
	{
		int index = 12;
		EntityActionMelee entityActionMelee = CreateComponent<EntityActionMelee>(index);
		entityActionMelee.mStatus = newMStatus;
		entityActionMelee.mAttackID = newMAttackID;
		entityActionMelee.mIsReady = newMIsReady;
		entityActionMelee.mAttackTime = newMAttackTime;
		entityActionMelee.mAttackDirection = newMAttackDirection;
		entityActionMelee.mAttackStatus = newMAttackStatus;
		entityActionMelee.mCurOffsetCount = newMCurOffsetCount;
		entityActionMelee.mCurHitCount = newMCurHitCount;
		entityActionMelee.mNextAttackTime = newMNextAttackTime;
		entityActionMelee.mAttackOnceDuring = newMAttackOnceDuring;
		entityActionMelee.mHitDuring = newMHitDuring;
		entityActionMelee.mHitCheckCount = newMHitCheckCount;
		ReplaceComponent(index, entityActionMelee);
	}

	public void RemoveEntityActionMelee()
	{
		RemoveComponent(12);
	}

	public void AddEntityActionDeath(int newMKiller, int newMAbilityID, int newMDeathDuring)
	{
		int index = 7;
		EntityActionDeath entityActionDeath = CreateComponent<EntityActionDeath>(index);
		entityActionDeath.mKiller = newMKiller;
		entityActionDeath.mAbilityID = newMAbilityID;
		entityActionDeath.mDeathDuring = newMDeathDuring;
		AddComponent(index, entityActionDeath);
	}

	public void ReplaceEntityActionDeath(int newMKiller, int newMAbilityID, int newMDeathDuring)
	{
		int index = 7;
		EntityActionDeath entityActionDeath = CreateComponent<EntityActionDeath>(index);
		entityActionDeath.mKiller = newMKiller;
		entityActionDeath.mAbilityID = newMAbilityID;
		entityActionDeath.mDeathDuring = newMDeathDuring;
		ReplaceComponent(index, entityActionDeath);
	}

	public void RemoveEntityActionDeath()
	{
		RemoveComponent(7);
	}

	public void AddEntityActionModifyHP(EntityActionStatus newMStatus, List<ModifyHPInfo> newMModifyInfoList)
	{
		int index = 14;
		EntityActionModifyHP entityActionModifyHP = CreateComponent<EntityActionModifyHP>(index);
		entityActionModifyHP.mStatus = newMStatus;
		entityActionModifyHP.mModifyInfoList = newMModifyInfoList;
		AddComponent(index, entityActionModifyHP);
	}

	public void ReplaceEntityActionModifyHP(EntityActionStatus newMStatus, List<ModifyHPInfo> newMModifyInfoList)
	{
		int index = 14;
		EntityActionModifyHP entityActionModifyHP = CreateComponent<EntityActionModifyHP>(index);
		entityActionModifyHP.mStatus = newMStatus;
		entityActionModifyHP.mModifyInfoList = newMModifyInfoList;
		ReplaceComponent(index, entityActionModifyHP);
	}

	public void RemoveEntityActionModifyHP()
	{
		RemoveComponent(14);
	}

	public void AddEntityActionAttack(EntityActionStatus newMStatus, bool newMIsReady, int newMAimDuring, int newMHitDuring, int newMHitCheckCount, int newMAttackTime, int newMAttackOnceDuring, int newMNextAttackTime, bool newMIsCD, Int3 newMAttackDirection)
	{
		int index = 4;
		EntityActionAttack entityActionAttack = CreateComponent<EntityActionAttack>(index);
		entityActionAttack.mStatus = newMStatus;
		entityActionAttack.mIsReady = newMIsReady;
		entityActionAttack.mAimDuring = newMAimDuring;
		entityActionAttack.mHitDuring = newMHitDuring;
		entityActionAttack.mHitCheckCount = newMHitCheckCount;
		entityActionAttack.mAttackTime = newMAttackTime;
		entityActionAttack.mAttackOnceDuring = newMAttackOnceDuring;
		entityActionAttack.mNextAttackTime = newMNextAttackTime;
		entityActionAttack.mIsCD = newMIsCD;
		entityActionAttack.mAttackDirection = newMAttackDirection;
		AddComponent(index, entityActionAttack);
	}

	public void ReplaceEntityActionAttack(EntityActionStatus newMStatus, bool newMIsReady, int newMAimDuring, int newMHitDuring, int newMHitCheckCount, int newMAttackTime, int newMAttackOnceDuring, int newMNextAttackTime, bool newMIsCD, Int3 newMAttackDirection)
	{
		int index = 4;
		EntityActionAttack entityActionAttack = CreateComponent<EntityActionAttack>(index);
		entityActionAttack.mStatus = newMStatus;
		entityActionAttack.mIsReady = newMIsReady;
		entityActionAttack.mAimDuring = newMAimDuring;
		entityActionAttack.mHitDuring = newMHitDuring;
		entityActionAttack.mHitCheckCount = newMHitCheckCount;
		entityActionAttack.mAttackTime = newMAttackTime;
		entityActionAttack.mAttackOnceDuring = newMAttackOnceDuring;
		entityActionAttack.mNextAttackTime = newMNextAttackTime;
		entityActionAttack.mIsCD = newMIsCD;
		entityActionAttack.mAttackDirection = newMAttackDirection;
		ReplaceComponent(index, entityActionAttack);
	}

	public void RemoveEntityActionAttack()
	{
		RemoveComponent(4);
	}

	public void AddEntityActionMove(EntityActionStatus newMStatus, Int3 newMTargetPos, int newMCurrentWaypointIndex, bool newMHasCaculated, bool newMNeedAutoPath)
	{
		int index = 15;
		EntityActionMove entityActionMove = CreateComponent<EntityActionMove>(index);
		entityActionMove.mStatus = newMStatus;
		entityActionMove.mTargetPos = newMTargetPos;
		entityActionMove.mCurrentWaypointIndex = newMCurrentWaypointIndex;
		entityActionMove.mHasCaculated = newMHasCaculated;
		entityActionMove.mNeedAutoPath = newMNeedAutoPath;
		AddComponent(index, entityActionMove);
	}

	public void ReplaceEntityActionMove(EntityActionStatus newMStatus, Int3 newMTargetPos, int newMCurrentWaypointIndex, bool newMHasCaculated, bool newMNeedAutoPath)
	{
		int index = 15;
		EntityActionMove entityActionMove = CreateComponent<EntityActionMove>(index);
		entityActionMove.mStatus = newMStatus;
		entityActionMove.mTargetPos = newMTargetPos;
		entityActionMove.mCurrentWaypointIndex = newMCurrentWaypointIndex;
		entityActionMove.mHasCaculated = newMHasCaculated;
		entityActionMove.mNeedAutoPath = newMNeedAutoPath;
		ReplaceComponent(index, entityActionMove);
	}

	public void RemoveEntityActionMove()
	{
		RemoveComponent(15);
	}

	public void AddEntityActionWeaponEquip(EntityActionStatus newMStatus, int newMWantEquipWeaponID, int newMEquipDuring)
	{
		int index = 20;
		EntityActionWeaponEquip entityActionWeaponEquip = CreateComponent<EntityActionWeaponEquip>(index);
		entityActionWeaponEquip.mStatus = newMStatus;
		entityActionWeaponEquip.mWantEquipWeaponID = newMWantEquipWeaponID;
		entityActionWeaponEquip.mEquipDuring = newMEquipDuring;
		AddComponent(index, entityActionWeaponEquip);
	}

	public void ReplaceEntityActionWeaponEquip(EntityActionStatus newMStatus, int newMWantEquipWeaponID, int newMEquipDuring)
	{
		int index = 20;
		EntityActionWeaponEquip entityActionWeaponEquip = CreateComponent<EntityActionWeaponEquip>(index);
		entityActionWeaponEquip.mStatus = newMStatus;
		entityActionWeaponEquip.mWantEquipWeaponID = newMWantEquipWeaponID;
		entityActionWeaponEquip.mEquipDuring = newMEquipDuring;
		ReplaceComponent(index, entityActionWeaponEquip);
	}

	public void RemoveEntityActionWeaponEquip()
	{
		RemoveComponent(20);
	}

	public void AddEntityActionAbilityDirection(EntityActionStatus newMStatus, Int3 newMDirection)
	{
		int index = 2;
		EntityActionAbilityDirection entityActionAbilityDirection = CreateComponent<EntityActionAbilityDirection>(index);
		entityActionAbilityDirection.mStatus = newMStatus;
		entityActionAbilityDirection.mDirection = newMDirection;
		AddComponent(index, entityActionAbilityDirection);
	}

	public void ReplaceEntityActionAbilityDirection(EntityActionStatus newMStatus, Int3 newMDirection)
	{
		int index = 2;
		EntityActionAbilityDirection entityActionAbilityDirection = CreateComponent<EntityActionAbilityDirection>(index);
		entityActionAbilityDirection.mStatus = newMStatus;
		entityActionAbilityDirection.mDirection = newMDirection;
		ReplaceComponent(index, entityActionAbilityDirection);
	}

	public void RemoveEntityActionAbilityDirection()
	{
		RemoveComponent(2);
	}

	public void AddEntityBlackboard(SimBlackboard newVar)
	{
		int index = 23;
		EntityBlackboard entityBlackboard = CreateComponent<EntityBlackboard>(index);
		entityBlackboard.var = newVar;
		AddComponent(index, entityBlackboard);
	}

	public void ReplaceEntityBlackboard(SimBlackboard newVar)
	{
		int index = 23;
		EntityBlackboard entityBlackboard = CreateComponent<EntityBlackboard>(index);
		entityBlackboard.var = newVar;
		ReplaceComponent(index, entityBlackboard);
	}

	public void RemoveEntityBlackboard()
	{
		RemoveComponent(23);
	}

	public void AddEntityAIThink(int newMThinkTimer, Dictionary<int, AICommand> newMAICommandSet, AICommand newMCurrentCommand, AICommand newMInterruptCommand, bool newMReevalute, bool newMForceMakeDecision, int newMLastThinkTimer)
	{
		int index = 22;
		EntityAIThink entityAIThink = CreateComponent<EntityAIThink>(index);
		entityAIThink.mThinkTimer = newMThinkTimer;
		entityAIThink.mAICommandSet = newMAICommandSet;
		entityAIThink.mCurrentCommand = newMCurrentCommand;
		entityAIThink.mInterruptCommand = newMInterruptCommand;
		entityAIThink.mReevalute = newMReevalute;
		entityAIThink.mForceMakeDecision = newMForceMakeDecision;
		entityAIThink.mLastThinkTimer = newMLastThinkTimer;
		AddComponent(index, entityAIThink);
	}

	public void ReplaceEntityAIThink(int newMThinkTimer, Dictionary<int, AICommand> newMAICommandSet, AICommand newMCurrentCommand, AICommand newMInterruptCommand, bool newMReevalute, bool newMForceMakeDecision, int newMLastThinkTimer)
	{
		int index = 22;
		EntityAIThink entityAIThink = CreateComponent<EntityAIThink>(index);
		entityAIThink.mThinkTimer = newMThinkTimer;
		entityAIThink.mAICommandSet = newMAICommandSet;
		entityAIThink.mCurrentCommand = newMCurrentCommand;
		entityAIThink.mInterruptCommand = newMInterruptCommand;
		entityAIThink.mReevalute = newMReevalute;
		entityAIThink.mForceMakeDecision = newMForceMakeDecision;
		entityAIThink.mLastThinkTimer = newMLastThinkTimer;
		ReplaceComponent(index, entityAIThink);
	}

	public void RemoveEntityAIThink()
	{
		RemoveComponent(22);
	}

	public void AddEntityTrigger(int newMTriggerID, bool newMEnabled, ProtoEntityData newMTriggerData, Dictionary<string, SimVariable> newMBlackboard, int newMActiveFrameCount)
	{
		int index = 60;
		EntityTrigger entityTrigger = CreateComponent<EntityTrigger>(index);
		entityTrigger.mTriggerID = newMTriggerID;
		entityTrigger.mEnabled = newMEnabled;
		entityTrigger.mTriggerData = newMTriggerData;
		entityTrigger.mBlackboard = newMBlackboard;
		entityTrigger.mActiveFrameCount = newMActiveFrameCount;
		AddComponent(index, entityTrigger);
	}

	public void ReplaceEntityTrigger(int newMTriggerID, bool newMEnabled, ProtoEntityData newMTriggerData, Dictionary<string, SimVariable> newMBlackboard, int newMActiveFrameCount)
	{
		int index = 60;
		EntityTrigger entityTrigger = CreateComponent<EntityTrigger>(index);
		entityTrigger.mTriggerID = newMTriggerID;
		entityTrigger.mEnabled = newMEnabled;
		entityTrigger.mTriggerData = newMTriggerData;
		entityTrigger.mBlackboard = newMBlackboard;
		entityTrigger.mActiveFrameCount = newMActiveFrameCount;
		ReplaceComponent(index, entityTrigger);
	}

	public void RemoveEntityTrigger()
	{
		RemoveComponent(60);
	}

	public void AddEntityCamp(uint newMRoleTypeCamp)
	{
		int index = 27;
		EntityCamp entityCamp = CreateComponent<EntityCamp>(index);
		entityCamp.mRoleTypeCamp = newMRoleTypeCamp;
		AddComponent(index, entityCamp);
	}

	public void ReplaceEntityCamp(uint newMRoleTypeCamp)
	{
		int index = 27;
		EntityCamp entityCamp = CreateComponent<EntityCamp>(index);
		entityCamp.mRoleTypeCamp = newMRoleTypeCamp;
		ReplaceComponent(index, entityCamp);
	}

	public void RemoveEntityCamp()
	{
		RemoveComponent(27);
	}

	public void AddEntityCollisionInfo(SimEntity newContactEntity, CollisionStatus newCollisionStatus)
	{
		int index = 29;
		EntityCollisionInfo entityCollisionInfo = CreateComponent<EntityCollisionInfo>(index);
		entityCollisionInfo.contactEntity = newContactEntity;
		entityCollisionInfo.collisionStatus = newCollisionStatus;
		AddComponent(index, entityCollisionInfo);
	}

	public void ReplaceEntityCollisionInfo(SimEntity newContactEntity, CollisionStatus newCollisionStatus)
	{
		int index = 29;
		EntityCollisionInfo entityCollisionInfo = CreateComponent<EntityCollisionInfo>(index);
		entityCollisionInfo.contactEntity = newContactEntity;
		entityCollisionInfo.collisionStatus = newCollisionStatus;
		ReplaceComponent(index, entityCollisionInfo);
	}

	public void RemoveEntityCollisionInfo()
	{
		RemoveComponent(29);
	}

	public void AddEntityShape(Int3 newMOffset, ShapePartType newMPartType, ISimShape newMShape, uint newMLayer, int newMWeight, ShapePartInfo newMShapePartInfo)
	{
		int index = 55;
		EntityShape entityShape = CreateComponent<EntityShape>(index);
		entityShape.mOffset = newMOffset;
		entityShape.mPartType = newMPartType;
		entityShape.mShape = newMShape;
		entityShape.mLayer = newMLayer;
		entityShape.mWeight = newMWeight;
		entityShape.mShapePartInfo = newMShapePartInfo;
		AddComponent(index, entityShape);
	}

	public void ReplaceEntityShape(Int3 newMOffset, ShapePartType newMPartType, ISimShape newMShape, uint newMLayer, int newMWeight, ShapePartInfo newMShapePartInfo)
	{
		int index = 55;
		EntityShape entityShape = CreateComponent<EntityShape>(index);
		entityShape.mOffset = newMOffset;
		entityShape.mPartType = newMPartType;
		entityShape.mShape = newMShape;
		entityShape.mLayer = newMLayer;
		entityShape.mWeight = newMWeight;
		entityShape.mShapePartInfo = newMShapePartInfo;
		ReplaceComponent(index, entityShape);
	}

	public void RemoveEntityShape()
	{
		RemoveComponent(55);
	}

	public void AddUnit(UnitClass newMUnitClass)
	{
		int index = 74;
		Unit unit = CreateComponent<Unit>(index);
		unit.mUnitClass = newMUnitClass;
		AddComponent(index, unit);
	}

	public void ReplaceUnit(UnitClass newMUnitClass)
	{
		int index = 74;
		Unit unit = CreateComponent<Unit>(index);
		unit.mUnitClass = newMUnitClass;
		ReplaceComponent(index, unit);
	}

	public void RemoveUnit()
	{
		RemoveComponent(74);
	}

	public void AddEntityRVO(Agent newAgent, Agent newBugPrevAvoided, int newBugDirection, int newBugTimer, VFactor newMAgentTimeHorizon, VFactor newMObstacleTimeHorizon, bool newMlockWhenNotMoving, int newMMaxNeighbours, RVOLayer newMLayer, RVOLayer newMColliderWith, VFactor newMPriority)
	{
		int index = 54;
		EntityRVO entityRVO = CreateComponent<EntityRVO>(index);
		entityRVO.agent = newAgent;
		entityRVO.bugPrevAvoided = newBugPrevAvoided;
		entityRVO.bugDirection = newBugDirection;
		entityRVO.bugTimer = newBugTimer;
		entityRVO.mAgentTimeHorizon = newMAgentTimeHorizon;
		entityRVO.mObstacleTimeHorizon = newMObstacleTimeHorizon;
		entityRVO.mlockWhenNotMoving = newMlockWhenNotMoving;
		entityRVO.mMaxNeighbours = newMMaxNeighbours;
		entityRVO.mLayer = newMLayer;
		entityRVO.mColliderWith = newMColliderWith;
		entityRVO.mPriority = newMPriority;
		AddComponent(index, entityRVO);
	}

	public void ReplaceEntityRVO(Agent newAgent, Agent newBugPrevAvoided, int newBugDirection, int newBugTimer, VFactor newMAgentTimeHorizon, VFactor newMObstacleTimeHorizon, bool newMlockWhenNotMoving, int newMMaxNeighbours, RVOLayer newMLayer, RVOLayer newMColliderWith, VFactor newMPriority)
	{
		int index = 54;
		EntityRVO entityRVO = CreateComponent<EntityRVO>(index);
		entityRVO.agent = newAgent;
		entityRVO.bugPrevAvoided = newBugPrevAvoided;
		entityRVO.bugDirection = newBugDirection;
		entityRVO.bugTimer = newBugTimer;
		entityRVO.mAgentTimeHorizon = newMAgentTimeHorizon;
		entityRVO.mObstacleTimeHorizon = newMObstacleTimeHorizon;
		entityRVO.mlockWhenNotMoving = newMlockWhenNotMoving;
		entityRVO.mMaxNeighbours = newMMaxNeighbours;
		entityRVO.mLayer = newMLayer;
		entityRVO.mColliderWith = newMColliderWith;
		entityRVO.mPriority = newMPriority;
		ReplaceComponent(index, entityRVO);
	}

	public void RemoveEntityRVO()
	{
		RemoveComponent(54);
	}

	public void AddSimTransform(Int3 newPosition, Int3 newForward, Quaternion newRotation, Quaternion newInverseRotation, Quaternion newLocalRotation, Int3 newLocalScale, Matrix4x4 newInverseMatrix, bool newIdentity, bool newOnlyTranslational, Int newSpeed, Matrix4x4 newMatrix)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		int index = 72;
		SimTransform simTransform = CreateComponent<SimTransform>(index);
		simTransform.position = newPosition;
		simTransform.forward = newForward;
		simTransform.rotation = newRotation;
		simTransform.inverseRotation = newInverseRotation;
		simTransform.localRotation = newLocalRotation;
		simTransform.localScale = newLocalScale;
		simTransform.inverseMatrix = newInverseMatrix;
		simTransform.identity = newIdentity;
		simTransform.onlyTranslational = newOnlyTranslational;
		simTransform.speed = newSpeed;
		simTransform.Matrix = newMatrix;
		AddComponent(index, simTransform);
	}

	public void ReplaceSimTransform(Int3 newPosition, Int3 newForward, Quaternion newRotation, Quaternion newInverseRotation, Quaternion newLocalRotation, Int3 newLocalScale, Matrix4x4 newInverseMatrix, bool newIdentity, bool newOnlyTranslational, Int newSpeed, Matrix4x4 newMatrix)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		int index = 72;
		SimTransform simTransform = CreateComponent<SimTransform>(index);
		simTransform.position = newPosition;
		simTransform.forward = newForward;
		simTransform.rotation = newRotation;
		simTransform.inverseRotation = newInverseRotation;
		simTransform.localRotation = newLocalRotation;
		simTransform.localScale = newLocalScale;
		simTransform.inverseMatrix = newInverseMatrix;
		simTransform.identity = newIdentity;
		simTransform.onlyTranslational = newOnlyTranslational;
		simTransform.speed = newSpeed;
		simTransform.Matrix = newMatrix;
		ReplaceComponent(index, simTransform);
	}

	public void RemoveSimTransform()
	{
		RemoveComponent(72);
	}

	public void AddEntityHealth(int newMaxHealth, int newMCurrentHealth, uint newMLastDamagedAtFrame)
	{
		int index = 38;
		EntityHealth entityHealth = CreateComponent<EntityHealth>(index);
		entityHealth.MaxHealth = newMaxHealth;
		entityHealth.mCurrentHealth = newMCurrentHealth;
		entityHealth.mLastDamagedAtFrame = newMLastDamagedAtFrame;
		AddComponent(index, entityHealth);
	}

	public void ReplaceEntityHealth(int newMaxHealth, int newMCurrentHealth, uint newMLastDamagedAtFrame)
	{
		int index = 38;
		EntityHealth entityHealth = CreateComponent<EntityHealth>(index);
		entityHealth.MaxHealth = newMaxHealth;
		entityHealth.mCurrentHealth = newMCurrentHealth;
		entityHealth.mLastDamagedAtFrame = newMLastDamagedAtFrame;
		ReplaceComponent(index, entityHealth);
	}

	public void RemoveEntityHealth()
	{
		RemoveComponent(38);
	}

	public void AddEntityPositon(Int3 newMPosition, Int3 newMForward, Int newMForwardAngle, Int3 newMUp, bool newIsTeleport)
	{
		int index = 45;
		EntityPositon entityPositon = CreateComponent<EntityPositon>(index);
		entityPositon.mPosition = newMPosition;
		entityPositon.mForward = newMForward;
		entityPositon.mForwardAngle = newMForwardAngle;
		entityPositon.mUp = newMUp;
		entityPositon.IsTeleport = newIsTeleport;
		AddComponent(index, entityPositon);
	}

	public void ReplaceEntityPositon(Int3 newMPosition, Int3 newMForward, Int newMForwardAngle, Int3 newMUp, bool newIsTeleport)
	{
		int index = 45;
		EntityPositon entityPositon = CreateComponent<EntityPositon>(index);
		entityPositon.mPosition = newMPosition;
		entityPositon.mForward = newMForward;
		entityPositon.mForwardAngle = newMForwardAngle;
		entityPositon.mUp = newMUp;
		entityPositon.IsTeleport = newIsTeleport;
		ReplaceComponent(index, entityPositon);
	}

	public void RemoveEntityPositon()
	{
		RemoveComponent(45);
	}

	public void BindEntityVar(SimContext simContext)
	{
		if (mVarList == null)
		{
			mVarList = new Dictionary<EntityVarName, VarVisitor>(new EntityVarNameComparer());
		}
		mVarList.Clear();
		mVarList.Add(EntityVarName.ENTITY_ID, new VarVisitor(() => ENTITY_ID, null));
		mVarList.Add(EntityVarName.WORLDSTATE_ALIVEMONSTER_COUNT, new VarVisitor(() => simContext.sEntityWorldStateEntity.WORLDSTATE_ALIVEMONSTER_COUNT, null));
		mVarList.Add(EntityVarName.WORLDSTATE_ALIVEHERO_COUNT, new VarVisitor(() => simContext.sEntityWorldStateEntity.WORLDSTATE_ALIVEHERO_COUNT, null));
		mVarList.Add(EntityVarName.ENTITY_CONFIG_ID, new VarVisitor(() => ENTITY_CONFIG_ID, delegate(SimVar var)
		{
			ENTITY_CONFIG_ID = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_ATTR_FIGHT_LEVEL, new VarVisitor(() => ENTITY_ATTR_FIGHT_LEVEL, delegate(SimVar var)
		{
			ENTITY_ATTR_FIGHT_LEVEL = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_HP, new VarVisitor(() => ENTITY_HP, delegate(SimVar var)
		{
			ENTITY_HP = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_AI_HAS_ATTACK_TRAGET, new VarVisitor(() => ENTITY_AI_HAS_ATTACK_TRAGET, null));
		mVarList.Add(EntityVarName.ENTITY_ATTR_MOVE_USE_CURVE, new VarVisitor(() => ENTITY_ATTR_MOVE_USE_CURVE, delegate(SimVar var)
		{
			ENTITY_ATTR_MOVE_USE_CURVE = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_ATTR_ROTATION_SPEED, new VarVisitor(() => ENTITY_ATTR_ROTATION_SPEED, delegate(SimVar var)
		{
			ENTITY_ATTR_ROTATION_SPEED = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_AI_TARGETPOS, new VarVisitor(() => ENTITY_AI_TARGETPOS, delegate(SimVar var)
		{
			ENTITY_AI_TARGETPOS = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_AI_TARGET, new VarVisitor(() => ENTITY_AI_TARGET, delegate(SimVar var)
		{
			ENTITY_AI_TARGET = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_AI_TRIGGER_TARGET, new VarVisitor(() => ENTITY_AI_TRIGGER_TARGET, delegate(SimVar var)
		{
			ENTITY_AI_TRIGGER_TARGET = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_DESIRED_VELOCITY, new VarVisitor(() => ENTITY_DESIRED_VELOCITY, delegate(SimVar var)
		{
			ENTITY_DESIRED_VELOCITY = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_DESIRED_POSITION, new VarVisitor(() => ENTITY_DESIRED_POSITION, delegate(SimVar var)
		{
			ENTITY_DESIRED_POSITION = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_DESIRED_SPEED, new VarVisitor(() => ENTITY_DESIRED_SPEED, delegate(SimVar var)
		{
			ENTITY_DESIRED_SPEED = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_CALCULATED_SPEED, new VarVisitor(() => ENTITY_CALCULATED_SPEED, delegate(SimVar var)
		{
			ENTITY_CALCULATED_SPEED = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_CALCULATED_POSITION, new VarVisitor(() => ENTITY_CALCULATED_POSITION, delegate(SimVar var)
		{
			ENTITY_CALCULATED_POSITION = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_CALCULATED_VELOCITY, new VarVisitor(() => ENTITY_CALCULATED_VELOCITY, delegate(SimVar var)
		{
			ENTITY_CALCULATED_VELOCITY = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_ATTR_LOCK_MOVEMENT, new VarVisitor(() => ENTITY_ATTR_LOCK_MOVEMENT, delegate(SimVar var)
		{
			ENTITY_ATTR_LOCK_MOVEMENT = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_POS, new VarVisitor(() => ENTITY_POS, delegate(SimVar var)
		{
			ENTITY_POS = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_FOWARD, new VarVisitor(() => ENTITY_FOWARD, delegate(SimVar var)
		{
			ENTITY_FOWARD = var;
		}));
		mVarList.Add(EntityVarName.ENTITY_UP, new VarVisitor(() => ENTITY_UP, delegate(SimVar var)
		{
			ENTITY_UP = var;
		}));
	}

	public bool HasVarValue(EntityVarName evn)
	{
		return mVarList.ContainsKey(evn);
	}

	public bool IsTag(Tag t)
	{
		return mTag == t;
	}

	public bool IsName(string name)
	{
		return mName == name;
	}

	public bool FindChildrenTag(Tag t, out List<SimEntity> children)
	{
		children = null;
		if (mChildren == null)
		{
			return false;
		}
		return mChildren.TryGetValue((int)t, out children);
	}

	public SimEntity FindChildAndSelf(Tag t, ShapePartType partName)
	{
		if (hasEntityShape && entityShape.mPartType == partName)
		{
			return this;
		}
		if (mChildren == null)
		{
			return null;
		}
		if (!mChildren.TryGetValue((int)t, out var value))
		{
			return null;
		}
		if (value != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				SimEntity simEntity = value[i];
				if (simEntity != null && simEntity.hasEntityShape && simEntity.entityShape.mPartType == partName)
				{
					return simEntity;
				}
			}
		}
		return null;
	}

	public SimEntity FindChildFirst(Tag t)
	{
		if (mChildren == null)
		{
			return null;
		}
		if (mChildren.TryGetValue((int)t, out var value) && value != null && mChildren.Count > 0)
		{
			return value[0];
		}
		return null;
	}

	public SimEntity FindChild(int entityID)
	{
		if (mChildren == null)
		{
			return null;
		}
		Dictionary<int, List<SimEntity>>.Enumerator enumerator = mChildren.GetEnumerator();
		while (enumerator.MoveNext())
		{
			List<SimEntity> value = enumerator.Current.Value;
			if (value == null)
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i] != null && value[i].creationIndex == entityID)
				{
					return value[i];
				}
			}
		}
		return null;
	}

	public SimEntity FindChild(string name)
	{
		if (string.IsNullOrEmpty(name) || mChildren == null)
		{
			return null;
		}
		Dictionary<int, List<SimEntity>>.Enumerator enumerator = mChildren.GetEnumerator();
		while (enumerator.MoveNext())
		{
			List<SimEntity> value = enumerator.Current.Value;
			if (value == null)
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i].mName == name)
				{
					return value[i];
				}
			}
		}
		return null;
	}

	public bool HasChild(SimEntity simEntity)
	{
		if (simEntity == null || mChildren == null)
		{
			return false;
		}
		List<SimEntity> children = null;
		FindChildrenTag(simEntity.mTag, out children);
		if (children == null || children.Count <= 0)
		{
			return false;
		}
		for (int num = children.Count - 1; num >= 0; num--)
		{
			if (children[num] == simEntity)
			{
				return true;
			}
		}
		return false;
	}

	public void AddChild(SimEntity simEntity)
	{
		if (simEntity == null)
		{
			return;
		}
		if (mChildren == null)
		{
			mChildren = new Dictionary<int, List<SimEntity>>(new IntComparer());
		}
		if (mChildren.ContainsKey((int)simEntity.mTag))
		{
			List<SimEntity> list = mChildren[(int)simEntity.mTag];
			if (list == null)
			{
				list = FrameListPool<SimEntity>.Claim();
				mChildren[(int)simEntity.mTag] = list;
			}
			list.Add(simEntity);
		}
		else
		{
			List<SimEntity> list2 = FrameListPool<SimEntity>.Claim();
			list2.Add(simEntity);
			mChildren.Add((int)simEntity.mTag, list2);
		}
	}

	public void RemoveChild(SimEntity simEntity, bool destroyChild = true)
	{
		if (simEntity == null || mChildren == null)
		{
			return;
		}
		List<SimEntity> children = null;
		FindChildrenTag(simEntity.mTag, out children);
		if (children == null || children.Count <= 0)
		{
			return;
		}
		for (int num = children.Count - 1; num >= 0; num--)
		{
			if (children[num] == simEntity)
			{
				if (destroyChild)
				{
					children[num].mParent = null;
					children[num].mTag = Tag.None;
					children[num].Destroy();
				}
				children.RemoveAt(num);
				break;
			}
		}
	}

	public bool RemoveChildByTag(Tag tag, bool destroyChild = true)
	{
		if (mChildren == null)
		{
			return false;
		}
		if (mChildren.TryGetValue((int)tag, out var value) && value != null && mChildren.Count > 0)
		{
			if (destroyChild)
			{
				for (int i = 0; i < value.Count; i++)
				{
					value[i].mParent = null;
					value[i].mTag = Tag.None;
					value[i].Destroy();
				}
			}
			value.Clear();
			return true;
		}
		return false;
	}

	public void DestroyChildren()
	{
		if (mChildren == null)
		{
			return;
		}
		Dictionary<int, List<SimEntity>>.Enumerator enumerator = mChildren.GetEnumerator();
		while (enumerator.MoveNext())
		{
			List<SimEntity> value = enumerator.Current.Value;
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value[num] != null)
				{
					value[num].mParent = null;
					value[num].mTag = Tag.None;
					value[num].Destroy();
				}
			}
			FrameListPool<SimEntity>.Release(value);
		}
		mChildren.Clear();
	}
}
