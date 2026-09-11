using System;
using System.Collections.Generic;
using Entitas;
using Entitas.CodeGeneration.Attributes;
using Services;
using UnityEngine;

public sealed class SimContext : Context<SimEntity>
{
	public const string EntityID = "EntityID";

	private ISimulatorInferface mSimInterface;

	public CommonService mService;

	public SynchronousEventSystem SimEventSystem;

	public AsynchronousEventSystem SimToPresentationEventSystem;

	public CommandRouter mCommandRouter;

	private bool isShutDown;

	public SimEntity sEntityGameOverEntity => GetGroup(SimMatcher.SEntityGameOver).GetSingleEntity();

	public SEntityGameOver sEntityGameOver => sEntityGameOverEntity.sEntityGameOver;

	public bool hasSEntityGameOver => sEntityGameOverEntity != null;

	public SimEntity logicServicesEntity => GetGroup(SimMatcher.LogicServices).GetSingleEntity();

	public LogicServices logicServices => logicServicesEntity.logicServices;

	public bool hasLogicServices => logicServicesEntity != null;

	public SimEntity entitySourceSpaceEntity => GetGroup(SimMatcher.EntitySourceSpace).GetSingleEntity();

	public EntitySourceSpace entitySourceSpace => entitySourceSpaceEntity.entitySourceSpace;

	public bool hasEntitySourceSpace => entitySourceSpaceEntity != null;

	public SimEntity sEntityWorldStateEntity => GetGroup(SimMatcher.SEntityWorldState).GetSingleEntity();

	public SEntityWorldState sEntityWorldState => sEntityWorldStateEntity.sEntityWorldState;

	public bool hasSEntityWorldState => sEntityWorldStateEntity != null;

	public SimEntity sEntityAABBTreeEntity => GetGroup(SimMatcher.SEntityAABBTree).GetSingleEntity();

	public SEntityAABBTree sEntityAABBTree => sEntityAABBTreeEntity.sEntityAABBTree;

	public bool hasSEntityAABBTree => sEntityAABBTreeEntity != null;

	public SimEntity sEntitySpatialTableEntity => GetGroup(SimMatcher.SEntitySpatialTable).GetSingleEntity();

	public SEntitySpatialTable sEntitySpatialTable => sEntitySpatialTableEntity.sEntitySpatialTable;

	public bool hasSEntitySpatialTable => sEntitySpatialTableEntity != null;

	public SimEntity simStatusEntity => GetGroup(SimMatcher.SimStatus).GetSingleEntity();

	public SimStatusComponent simStatus => simStatusEntity.simStatus;

	public bool hasSimStatus => simStatusEntity != null;

	public SimEntity eventHandlerEntity => GetGroup(SimMatcher.EventHandler).GetSingleEntity();

	public EventHandlerComponent eventHandler => eventHandlerEntity.eventHandler;

	public bool hasEventHandler => eventHandlerEntity != null;

	public SimEntity simStateFrameBufferEntity => GetGroup(SimMatcher.SimStateFrameBuffer).GetSingleEntity();

	public SimStateFrameBuffer simStateFrameBuffer => simStateFrameBufferEntity.simStateFrameBuffer;

	public bool hasSimStateFrameBuffer => simStateFrameBufferEntity != null;

	public SimEntity commandsPendingEntity => GetGroup(SimMatcher.CommandsPending).GetSingleEntity();

	public CommandsPendingComponent commandsPending => commandsPendingEntity.commandsPending;

	public bool hasCommandsPending => commandsPendingEntity != null;

	public SimEntity simulatorInterfaceEntity => GetGroup(SimMatcher.SimulatorInterface).GetSingleEntity();

	public SimulatorInterfaceComponent simulatorInterface => simulatorInterfaceEntity.simulatorInterface;

	public bool hasSimulatorInterface => simulatorInterfaceEntity != null;

	public SimEntity SetSEntityGameOver(GameOverState newState, int newCountdown, int newTimeScale, E_BattleResult newIsVectory)
	{
		if (hasSEntityGameOver)
		{
			throw new EntitasException("Could not set SEntityGameOver!\n" + this?.ToString() + " already has an entity with SEntityGameOver!", "You should check if the context already has a sEntityGameOverEntity before setting it or use context.ReplaceSEntityGameOver().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSEntityGameOver(newState, newCountdown, newTimeScale, newIsVectory);
		return simEntity;
	}

	public void ReplaceSEntityGameOver(GameOverState newState, int newCountdown, int newTimeScale, E_BattleResult newIsVectory)
	{
		SimEntity simEntity = sEntityGameOverEntity;
		if (simEntity == null)
		{
			simEntity = SetSEntityGameOver(newState, newCountdown, newTimeScale, newIsVectory);
		}
		else
		{
			simEntity.ReplaceSEntityGameOver(newState, newCountdown, newTimeScale, newIsVectory);
		}
	}

	public void RemoveSEntityGameOver()
	{
		sEntityGameOverEntity.Destroy();
	}

	public SimEntity SetLogicServices(CommonService newMService)
	{
		if (hasLogicServices)
		{
			throw new EntitasException("Could not set LogicServices!\n" + this?.ToString() + " already has an entity with LogicServices!", "You should check if the context already has a logicServicesEntity before setting it or use context.ReplaceLogicServices().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddLogicServices(newMService);
		return simEntity;
	}

	public void ReplaceLogicServices(CommonService newMService)
	{
		SimEntity simEntity = logicServicesEntity;
		if (simEntity == null)
		{
			simEntity = SetLogicServices(newMService);
		}
		else
		{
			simEntity.ReplaceLogicServices(newMService);
		}
	}

	public void RemoveLogicServices()
	{
		logicServicesEntity.Destroy();
	}

	public SimEntity SetEntitySourceSpace(bool newEnable, int newSourceSpaceKeepTime, int newSourceSpaceDelayTime, int newSourceSpaceExitTime, int newSourceSpaceRaceID, int newLimitDodgeCD, int newBreakEntityID, bool newManualMode)
	{
		if (hasEntitySourceSpace)
		{
			throw new EntitasException("Could not set EntitySourceSpace!\n" + this?.ToString() + " already has an entity with EntitySourceSpace!", "You should check if the context already has a entitySourceSpaceEntity before setting it or use context.ReplaceEntitySourceSpace().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddEntitySourceSpace(newEnable, newSourceSpaceKeepTime, newSourceSpaceDelayTime, newSourceSpaceExitTime, newSourceSpaceRaceID, newLimitDodgeCD, newBreakEntityID, newManualMode);
		return simEntity;
	}

	public void ReplaceEntitySourceSpace(bool newEnable, int newSourceSpaceKeepTime, int newSourceSpaceDelayTime, int newSourceSpaceExitTime, int newSourceSpaceRaceID, int newLimitDodgeCD, int newBreakEntityID, bool newManualMode)
	{
		SimEntity simEntity = entitySourceSpaceEntity;
		if (simEntity == null)
		{
			simEntity = SetEntitySourceSpace(newEnable, newSourceSpaceKeepTime, newSourceSpaceDelayTime, newSourceSpaceExitTime, newSourceSpaceRaceID, newLimitDodgeCD, newBreakEntityID, newManualMode);
		}
		else
		{
			simEntity.ReplaceEntitySourceSpace(newEnable, newSourceSpaceKeepTime, newSourceSpaceDelayTime, newSourceSpaceExitTime, newSourceSpaceRaceID, newLimitDodgeCD, newBreakEntityID, newManualMode);
		}
	}

	public void RemoveEntitySourceSpace()
	{
		entitySourceSpaceEntity.Destroy();
	}

	public SimEntity SetSEntityWorldState(SimWorldState newStatus)
	{
		if (hasSEntityWorldState)
		{
			throw new EntitasException("Could not set SEntityWorldState!\n" + this?.ToString() + " already has an entity with SEntityWorldState!", "You should check if the context already has a sEntityWorldStateEntity before setting it or use context.ReplaceSEntityWorldState().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSEntityWorldState(newStatus);
		return simEntity;
	}

	public void ReplaceSEntityWorldState(SimWorldState newStatus)
	{
		SimEntity simEntity = sEntityWorldStateEntity;
		if (simEntity == null)
		{
			simEntity = SetSEntityWorldState(newStatus);
		}
		else
		{
			simEntity.ReplaceSEntityWorldState(newStatus);
		}
	}

	public void RemoveSEntityWorldState()
	{
		sEntityWorldStateEntity.Destroy();
	}

	public SimEntity SetSEntityAABBTree(DynamicTree<ISimShape> newMDynamicTree)
	{
		if (hasSEntityAABBTree)
		{
			throw new EntitasException("Could not set SEntityAABBTree!\n" + this?.ToString() + " already has an entity with SEntityAABBTree!", "You should check if the context already has a sEntityAABBTreeEntity before setting it or use context.ReplaceSEntityAABBTree().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSEntityAABBTree(newMDynamicTree);
		return simEntity;
	}

	public void ReplaceSEntityAABBTree(DynamicTree<ISimShape> newMDynamicTree)
	{
		SimEntity simEntity = sEntityAABBTreeEntity;
		if (simEntity == null)
		{
			simEntity = SetSEntityAABBTree(newMDynamicTree);
		}
		else
		{
			simEntity.ReplaceSEntityAABBTree(newMDynamicTree);
		}
	}

	public void RemoveSEntityAABBTree()
	{
		sEntityAABBTreeEntity.Destroy();
	}

	public SimEntity SetSEntitySpatialTable(Int2 newMMin, Int2 newMMax)
	{
		if (hasSEntitySpatialTable)
		{
			throw new EntitasException("Could not set SEntitySpatialTable!\n" + this?.ToString() + " already has an entity with SEntitySpatialTable!", "You should check if the context already has a sEntitySpatialTableEntity before setting it or use context.ReplaceSEntitySpatialTable().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSEntitySpatialTable(newMMin, newMMax);
		return simEntity;
	}

	public void ReplaceSEntitySpatialTable(Int2 newMMin, Int2 newMMax)
	{
		SimEntity simEntity = sEntitySpatialTableEntity;
		if (simEntity == null)
		{
			simEntity = SetSEntitySpatialTable(newMMin, newMMax);
		}
		else
		{
			simEntity.ReplaceSEntitySpatialTable(newMMin, newMMax);
		}
	}

	public void RemoveSEntitySpatialTable()
	{
		sEntitySpatialTableEntity.Destroy();
	}

	public SimEntity SetSimStatus(SimStatusSetting newRuntimeSetting, SimSettings newSimSetting, uint newMServerFrame, uint newMClientPredictionFrame, bool newMIsRollback, ReplayMode newReplayMode, GameMode newGameMode, long newMSimTime, Checksum newExpectedChecksum, Checksum newMMostRecentChecksum)
	{
		if (hasSimStatus)
		{
			throw new EntitasException("Could not set SimStatus!\n" + this?.ToString() + " already has an entity with SimStatusComponent!", "You should check if the context already has a simStatusEntity before setting it or use context.ReplaceSimStatus().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSimStatus(newRuntimeSetting, newSimSetting, newMServerFrame, newMClientPredictionFrame, newMIsRollback, newReplayMode, newGameMode, newMSimTime, newExpectedChecksum, newMMostRecentChecksum);
		return simEntity;
	}

	public void ReplaceSimStatus(SimStatusSetting newRuntimeSetting, SimSettings newSimSetting, uint newMServerFrame, uint newMClientPredictionFrame, bool newMIsRollback, ReplayMode newReplayMode, GameMode newGameMode, long newMSimTime, Checksum newExpectedChecksum, Checksum newMMostRecentChecksum)
	{
		SimEntity simEntity = simStatusEntity;
		if (simEntity == null)
		{
			simEntity = SetSimStatus(newRuntimeSetting, newSimSetting, newMServerFrame, newMClientPredictionFrame, newMIsRollback, newReplayMode, newGameMode, newMSimTime, newExpectedChecksum, newMMostRecentChecksum);
		}
		else
		{
			simEntity.ReplaceSimStatus(newRuntimeSetting, newSimSetting, newMServerFrame, newMClientPredictionFrame, newMIsRollback, newReplayMode, newGameMode, newMSimTime, newExpectedChecksum, newMMostRecentChecksum);
		}
	}

	public void RemoveSimStatus()
	{
		simStatusEntity.Destroy();
	}

	public SimEntity SetEventHandler(Dictionary<Type, EventPosterBase> newMHandlers)
	{
		if (hasEventHandler)
		{
			throw new EntitasException("Could not set EventHandler!\n" + this?.ToString() + " already has an entity with EventHandlerComponent!", "You should check if the context already has a eventHandlerEntity before setting it or use context.ReplaceEventHandler().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddEventHandler(newMHandlers);
		return simEntity;
	}

	public void ReplaceEventHandler(Dictionary<Type, EventPosterBase> newMHandlers)
	{
		SimEntity simEntity = eventHandlerEntity;
		if (simEntity == null)
		{
			simEntity = SetEventHandler(newMHandlers);
		}
		else
		{
			simEntity.ReplaceEventHandler(newMHandlers);
		}
	}

	public void RemoveEventHandler()
	{
		eventHandlerEntity.Destroy();
	}

	public SimEntity SetSimStateFrameBuffer(int newMCurrentFrameArrayIndex, uint newMLastAppliedFrame)
	{
		if (hasSimStateFrameBuffer)
		{
			throw new EntitasException("Could not set SimStateFrameBuffer!\n" + this?.ToString() + " already has an entity with SimStateFrameBuffer!", "You should check if the context already has a simStateFrameBufferEntity before setting it or use context.ReplaceSimStateFrameBuffer().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSimStateFrameBuffer(newMCurrentFrameArrayIndex, newMLastAppliedFrame);
		return simEntity;
	}

	public void ReplaceSimStateFrameBuffer(int newMCurrentFrameArrayIndex, uint newMLastAppliedFrame)
	{
		SimEntity simEntity = simStateFrameBufferEntity;
		if (simEntity == null)
		{
			simEntity = SetSimStateFrameBuffer(newMCurrentFrameArrayIndex, newMLastAppliedFrame);
		}
		else
		{
			simEntity.ReplaceSimStateFrameBuffer(newMCurrentFrameArrayIndex, newMLastAppliedFrame);
		}
	}

	public void RemoveSimStateFrameBuffer()
	{
		simStateFrameBufferEntity.Destroy();
	}

	public SimEntity SetCommandsPending(string newMEmpty)
	{
		if (hasCommandsPending)
		{
			throw new EntitasException("Could not set CommandsPending!\n" + this?.ToString() + " already has an entity with CommandsPendingComponent!", "You should check if the context already has a commandsPendingEntity before setting it or use context.ReplaceCommandsPending().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddCommandsPending(newMEmpty);
		return simEntity;
	}

	public void ReplaceCommandsPending(string newMEmpty)
	{
		SimEntity simEntity = commandsPendingEntity;
		if (simEntity == null)
		{
			simEntity = SetCommandsPending(newMEmpty);
		}
		else
		{
			simEntity.ReplaceCommandsPending(newMEmpty);
		}
	}

	public void RemoveCommandsPending()
	{
		commandsPendingEntity.Destroy();
	}

	public SimEntity SetSimulatorInterface(ISimulatorInferface newValue)
	{
		if (hasSimulatorInterface)
		{
			throw new EntitasException("Could not set SimulatorInterface!\n" + this?.ToString() + " already has an entity with SimulatorInterfaceComponent!", "You should check if the context already has a simulatorInterfaceEntity before setting it or use context.ReplaceSimulatorInterface().");
		}
		SimEntity simEntity = CreateEntity();
		simEntity.AddSimulatorInterface(newValue);
		return simEntity;
	}

	public void ReplaceSimulatorInterface(ISimulatorInferface newValue)
	{
		SimEntity simEntity = simulatorInterfaceEntity;
		if (simEntity == null)
		{
			simEntity = SetSimulatorInterface(newValue);
		}
		else
		{
			simEntity.ReplaceSimulatorInterface(newValue);
		}
	}

	public void RemoveSimulatorInterface()
	{
		simulatorInterfaceEntity.Destroy();
	}

	public SimContext()
		: base(75, 0, new ContextInfo("Sim", SimComponentsLookup.componentNames, SimComponentsLookup.componentTypes), (Func<IEntity, IAERC>)((IEntity entity) => new SafeAERC(entity)))
	{
	}

	public SimContext(int startID)
		: base(75, startID, new ContextInfo("Sim", SimComponentsLookup.componentNames, SimComponentsLookup.componentTypes), (Func<IEntity, IAERC>)((IEntity entity) => new SafeAERC(entity)))
	{
		InitializeEntityIndices();
	}

	[PostConstructor]
	public void InitializeEntityIndices()
	{
		AddEntityIndex(new PrimaryEntityIndex<SimEntity, int>("EntityID", GetGroup(SimMatcher.EntityID), (SimEntity e, IComponent c) => ((EntityID)c).mID));
	}

	public ISimulatorInferface GetSimInterface()
	{
		if (isShutDown)
		{
			return null;
		}
		if (mSimInterface == null)
		{
			mSimInterface = new ISimulatorInferface();
		}
		return mSimInterface;
	}

	public void InitCommonService()
	{
		mService = new CommonService(this);
	}

	public CommonService GetService()
	{
		if (isShutDown)
		{
			return null;
		}
		return mService;
	}

	public void InitCommandService(GameMode gameMode, Func<uint, SimResultType> serverFrameCallback, Func<uint, bool, SimResultType> clientFrameCallback)
	{
		if (mCommandRouter == null)
		{
			mCommandRouter = new CommandRouter(this);
			mCommandRouter.Initialize(gameMode, serverFrameCallback, clientFrameCallback);
		}
	}

	public void InitEventService()
	{
		if (SimEventSystem == null)
		{
			SimEventSystem = new SynchronousEventSystem();
		}
		if (SimToPresentationEventSystem == null)
		{
			SimToPresentationEventSystem = new AsynchronousEventSystem();
		}
	}

	public void PostEvent(NEventBase evt)
	{
		if (isShutDown)
		{
			return;
		}
		try
		{
			if (evt is IPostToSimulation)
			{
				SimEventSystem.Post(evt);
			}
			if (evt is IPostToPresentation)
			{
				SimToPresentationEventSystem.Post(evt);
			}
			if (evt is IPostToPreliminaryPresentation)
			{
				SimToPresentationEventSystem.Post(evt);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError((object)ex.Message);
			Debug.LogError((object)ex.StackTrace);
		}
	}

	public void ShutDown()
	{
		isShutDown = true;
		mSimInterface = null;
		mService = null;
		SimEventSystem = null;
		SimToPresentationEventSystem = null;
		mCommandRouter = null;
	}
}
