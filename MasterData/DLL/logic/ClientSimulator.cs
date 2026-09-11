using System;
using System.Collections.Generic;
using Config;
using Entitas;
using NetProcol;
using Pathfinding;
using Pathfinding.Util;
using Services;
using UnityEngine;
using XServer;

public class ClientSimulator
{
	private static ClientSimulator sInstance;

	private bool mIsInitialized;

	private int mLogicThreadFrame = 10;

	private int mLogicPeriodMS = 33;

	private float mPerFrameTime;

	private TaskCollection mTaskCollection;

	private TimedTaskSchedule mSimTickTimer;

	private const int kDefaultTransientStateListCapacity = 600;

	private static int kMaxTimerBacklogMS;

	private const int kMaxTimerBacklogMSDefault = 1500;

	private const int kSimShutdownGracePeriodMS = 3000;

	private uint mCurrentServerFrameNumber;

	private uint mCurrentPredictionFrameNumber;

	private bool mHasFrameManagerApplyBeenLogged;

	private bool mHasPlayerDropBeenLogged;

	private bool mHasSimStallBeenLogged;

	private int mTimeScale;

	private RealTimeClock realTime = new RealTimeClock();

	public Action<SimResultType> onTickCallback;

	public bool mCloseSampler;

	public GameMode mGameMode = GameMode.SinglePlayer;

	public int mTimerIntervalMS;

	public bool mWasSimRunning;

	public SimContext mSimContext;

	public AstarPath astarPath;

	private ProtoMapdata mapTrigger;

	private Systems mPredictionSystems;

	private SimPredictionStatesSystem mSimPredictionStatesSystem;

	private Systems mServerSystems;

	private SimStatesSystem mSimStatesSystem;

	private INetCallback mNetWork;

	public int SimFrameCount;

	public int SimTickPeriodMS => mLogicPeriodMS;

	public static ClientSimulator Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new ClientSimulator();
			}
			return sInstance;
		}
	}

	public bool IsSimRunning
	{
		get
		{
			if (mIsInitialized)
			{
				return SimTimeScale > 0;
			}
			return false;
		}
	}

	public bool IsInitialized => mIsInitialized;

	public float PerFrameTime => mPerFrameTime;

	public int LastRuntimeMS
	{
		get
		{
			if (mSimTickTimer == null)
			{
				return 0;
			}
			return (int)mSimTickTimer.LastRuntime.TotalMilliseconds;
		}
	}

	public int SimTimeScale
	{
		get
		{
			return mTimeScale;
		}
		set
		{
			if (value != mTimeScale)
			{
				if (value == 0 && IsSimRunning)
				{
					mTimeScale = value;
					return;
				}
				mTimeScale = value;
				mTimerIntervalMS = (int)Math.Round((double)(SimTickPeriodMS * 10000 / mTimeScale));
				SimFrameCount = mTimeScale * 10000 / SimTickPeriodMS;
			}
		}
	}

	protected ClientSimulator()
	{
		mSimContext = new SimContext(100);
		mSimContext.SubcriteID();
	}

	public void InitMap(ref byte[] mapData, ProtoMapdata triggers)
	{
		mapTrigger = triggers;
		if (mapData != null)
		{
			astarPath = new AstarPath(mSimContext);
			astarPath.scanOnStartup = true;
			astarPath.LoadAstartData(ref mapData);
			for (int i = 0; i < astarPath.graphs.Length; i++)
			{
				if (astarPath.graphs[i] is RecastGraph)
				{
					RecastGraph recastGraph = astarPath.graphs[i] as RecastGraph;
					recastGraph.mTileHandler = new TileHandler(recastGraph);
					recastGraph.mTileHandler.CreateTileTypesFromGraph();
				}
				else if (astarPath.graphs[i] is PointGraph)
				{
					Debug.Log((object)("PointGraph ======================= " + (astarPath.graphs[i] as PointGraph)));
				}
			}
		}
		mSimContext.sEntityWorldState.status.mMapGraph = astarPath;
		mSimContext.sEntityWorldState.status.mMapTrigger = mapTrigger;
	}

	public void InitWorldState(ref byte[] mapData, ProtoMapdata triggers)
	{
		InitMap(ref mapData, triggers);
	}

	public void InitMap(ref byte[] mapData, ProtoMapdata triggers, List<ISimShape> colliders)
	{
		mSimContext.GetService().mLevelColliderService.mLevelColliders = colliders;
		mapTrigger = triggers;
		if (mapData != null)
		{
			astarPath = new AstarPath(mSimContext);
			astarPath.scanOnStartup = true;
			astarPath.LoadAstartData(ref mapData);
			for (int i = 0; i < astarPath.graphs.Length; i++)
			{
				if (astarPath.graphs[i] is RecastGraph)
				{
					RecastGraph recastGraph = astarPath.graphs[i] as RecastGraph;
					recastGraph.mTileHandler = new TileHandler(recastGraph);
					recastGraph.mTileHandler.CreateTileTypesFromGraph();
				}
				else if (astarPath.graphs[i] is PointGraph)
				{
					Debug.Log((object)("PointGraph ======================= " + (astarPath.graphs[i] as PointGraph)));
				}
			}
		}
		mSimContext.sEntityWorldState.status.mMapGraph = astarPath;
		mSimContext.sEntityWorldState.status.mMapTrigger = mapTrigger;
	}

	public void InitWorldState(ref byte[] mapData, ProtoMapdata triggers, List<ISimShape> colliders)
	{
		InitMap(ref mapData, triggers, colliders);
	}

	public void Startup(int frameRate, GameMode gameMode, INetCallback net, bool closeSampler = false)
	{
		mLogicPeriodMS = 1000 / frameRate;
		mGameMode = gameMode;
		mCloseSampler = closeSampler;
		mPerFrameTime = (float)Math.Round(1f / (float)mLogicThreadFrame, 5);
		realTime.StartClock();
		SimulatorExtensions.Initialize();
		mSimContext.InitCommandService(gameMode, AdvanceServerSimFrame, AdvancePredictionSimFrame);
		if (net != null)
		{
			net.mSimContext = mSimContext;
			net.mRouter = mSimContext.mCommandRouter;
			mNetWork = net;
		}
		mSimContext.InitEventService();
		mSimContext.InitCommonService();
		if (CommonProcessor.IsMultiplePlayerGameMode(gameMode))
		{
			InitPredictionSystems();
		}
		InitServerSystems(mSimContext, gameMode);
		mCurrentServerFrameNumber = 0u;
		mCurrentPredictionFrameNumber = 0u;
		mHasPlayerDropBeenLogged = false;
		mHasSimStallBeenLogged = false;
	}

	public void RegisterServerCallback(Action<SimResultType> tickCallback, Action<SimStateFrame> onNewSimStateFrame)
	{
		onTickCallback = tickCallback;
		mSimStatesSystem.Initialize(32, onNewSimStateFrame);
	}

	public void RegisterClientCallback(Action<SimResultType> tickCallback, Action<SimStateFrame> onNewSimStateFrame)
	{
		onTickCallback = tickCallback;
		if (mSimPredictionStatesSystem != null)
		{
			mSimPredictionStatesSystem.Initialize(16, onNewSimStateFrame);
		}
	}

	public IAsynchronousEventSystem GetSimToPresentation()
	{
		return mSimContext.SimToPresentationEventSystem;
	}

	public SimStatesSystem GetSimStatesSystem()
	{
		return mSimStatesSystem;
	}

	public SimPredictionStatesSystem GetSimPredictionStatesSystem()
	{
		return mSimPredictionStatesSystem;
	}

	public long GetRealTime()
	{
		return realTime.GetElaspedTimeSinceStart();
	}

	private void AsyncTickWorker()
	{
		SimResultType simResultType = AsyncFixedUpdate();
		switch (simResultType)
		{
		}
		if (onTickCallback != null)
		{
			onTickCallback(simResultType);
		}
	}

	public void Ready(Op_C2B_PlayerReady ready)
	{
		if (mSimContext == null)
		{
			Debug.LogError((object)"mSimContext 为空");
		}
		RuntimeAttributeService runtimeAttributeService = mSimContext.GetService().mAttributeService as RuntimeAttributeService;
		if (runtimeAttributeService == null)
		{
			Debug.LogError((object)"service 为空");
		}
		runtimeAttributeService.mBattleID = ready.BattleID;
		mSimContext.sEntityWorldState.status.mBattleID = ready.BattleID;
		SendLocalMsg(130, ready, delegate(Packet pkg)
		{
			Op_B2C_ack_PlayerReady op_B2C_ack_PlayerReady = ReadPacket(pkg) as Op_B2C_ack_PlayerReady;
			Debug.Log((object)("emm..... player online battle ready: " + op_B2C_ack_PlayerReady.PlayerId));
			mSimContext.sEntityWorldState.status.mLocalPlayerNetID = op_B2C_ack_PlayerReady.PlayerId;
		});
	}

	public void SendBattleResult(long battleID, ulong uuid, E_BattleResult result, BattleResultInfo info, Action<int> callback)
	{
		if (callback != null)
		{
			mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent = null;
			ISimulatorInferface simInterface = mSimContext.GetSimInterface();
			simInterface.mGSRecvBattleResultFinishEvent = (Action<int>)Delegate.Combine(simInterface.mGSRecvBattleResultFinishEvent, callback);
		}
		if (CommonProcessor.IsSinglePlayerGameMode(mGameMode))
		{
			SendLocalMsg(132, new Op_C2B_BattleResult
			{
				BattleID = battleID,
				Uuid = uuid,
				Result = (int)result,
				Info = info
			}, delegate(Packet pkg)
			{
				Op_B2C_Ack_BattleResult op_B2C_Ack_BattleResult = ReadPacket(pkg) as Op_B2C_Ack_BattleResult;
				if (op_B2C_Ack_BattleResult.Result != 0)
				{
					if (1 == op_B2C_Ack_BattleResult.Result)
					{
						Debug.Log((object)("<color=red>等待其它玩家的结果: </color> battleID " + battleID + " uuid " + uuid + " result " + result.ToString() + " 返回结果为 " + op_B2C_Ack_BattleResult.Result));
					}
					else
					{
						Debug.Log((object)("<color=red>发送结果给战斗服务器失败: </color> battleID " + battleID + " uuid " + uuid + " result " + result.ToString() + " 返回结果为 " + op_B2C_Ack_BattleResult.Result));
					}
				}
				else
				{
					Debug.Log((object)("<color=red>发送结果给战斗服务器成功: </color> battleID " + battleID + " uuid " + uuid + " result " + result));
				}
			});
		}
		if (!CommonProcessor.IsMultiplePlayerGameMode(mGameMode))
		{
			return;
		}
		SendLocalMsg(137, new Op_C2B_BattleResultOnline
		{
			BattleID = battleID,
			Uuid = uuid,
			Result = (int)result,
			Info = info
		}, delegate(Packet pkg)
		{
			Op_B2C_Ack_BattleResult op_B2C_Ack_BattleResult = ReadPacket(pkg) as Op_B2C_Ack_BattleResult;
			if (op_B2C_Ack_BattleResult.Result != 0)
			{
				if (1 == op_B2C_Ack_BattleResult.Result)
				{
					Debug.Log((object)("<color=red>等待其它玩家的联机结果: </color> battleID " + battleID + " uuid " + uuid + " result " + result.ToString() + " 返回结果为 " + op_B2C_Ack_BattleResult.Result));
				}
				else
				{
					Debug.Log((object)("<color=red>发送联机结果给战斗服务器失败: </color> battleID " + battleID + " uuid " + uuid + " result " + result.ToString() + " 返回结果为 " + op_B2C_Ack_BattleResult.Result));
				}
			}
			else
			{
				Debug.Log((object)("<color=red>发送联机结果给战斗服务器成功: </color> battleID " + battleID + " uuid " + uuid + " result " + result));
			}
		});
	}

	public object ReadPacket(Packet pkg)
	{
		mNetWork.mUDPClientNet.ReadProtobuff(pkg, out var message);
		return message;
	}

	public virtual void SendLocalCommand(Command command)
	{
		if (CommonProcessor.IsReplayGameMode(mGameMode))
		{
			command.ReleaseCommand();
			return;
		}
		command.BindContext(mSimContext);
		if (CommonProcessor.IsMultiplePlayerGameMode(mGameMode))
		{
			mSimContext.mCommandRouter.InputClientCommand(command);
		}
		else if (CommonProcessor.IsSinglePlayerGameMode(mGameMode))
		{
			command.RunCommand(0L);
			SendNetCommand(command, mCurrentServerFrameNumber);
			command.ReleaseCommand();
		}
	}

	public void SendNetCommand(Command command, uint frameNum)
	{
		try
		{
			if (mNetWork != null)
			{
				mNetWork.mUDPClientNet.SendNetCommand(command, frameNum);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError((object)ex.Message);
			Debug.LogError((object)ex.StackTrace);
		}
	}

	public void SendLocalMsg(ushort opcode, object msg, Action<Packet> callback)
	{
		Debug.Log((object)("SendLocalMsg OpCode " + opcode));
		try
		{
			if (mNetWork != null)
			{
				mNetWork.mUDPClientNet.SendLocalMsg(opcode, msg, callback);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError((object)ex.Message);
			Debug.LogError((object)ex.StackTrace);
		}
	}

	public void Update(float deltaTime)
	{
		AsyncTickWorker();
	}

	public void FixedUpdate()
	{
		AsyncTickWorker();
	}

	public SimResultType AsyncFixedUpdate()
	{
		if (!mIsInitialized)
		{
			return SimResultType.NoTick;
		}
		SimResultType simResultType = SimResultType.NoTick;
		if (mNetWork != null)
		{
			mNetWork.mUDPClientNet.PullEvents();
		}
		if (!mSimStatesSystem.CanApplyNewFrame || (mSimPredictionStatesSystem != null && !mSimPredictionStatesSystem.CanApplyNewFrame))
		{
			simResultType = SimResultType.StalledOnPresentation;
			if (!mHasFrameManagerApplyBeenLogged)
			{
				mHasFrameManagerApplyBeenLogged = true;
			}
			return simResultType;
		}
		SimResultType result = SimResultType.OK;
		if (mTimeScale > 0)
		{
			switch (mSimContext.mCommandRouter.Tick())
			{
			case CommandRouter.UpdateStatus.SyncError:
				simResultType = SimResultType.SyncError;
				if (IsSimRunning)
				{
					XLogger.Error("Online:", "The local sim has detected a sync error!");
					SimTimeScale = 0;
				}
				return simResultType;
			case CommandRouter.UpdateStatus.NetworkDisconnect:
				simResultType = SimResultType.Disconnect;
				if (IsSimRunning)
				{
					XLogger.Error("Online:", "The local sim has disconnected from the rest of the players!");
					SimTimeScale = 0;
				}
				return simResultType;
			case CommandRouter.UpdateStatus.PlayerDropSynchronizing:
				return SimResultType.StalledOnPlayerDropSynchronization;
			case CommandRouter.UpdateStatus.StalledOnInput:
				simResultType = SimResultType.StalledOnInput;
				if (!mHasSimStallBeenLogged)
				{
					mHasSimStallBeenLogged = true;
				}
				return simResultType;
			}
			if (mSimTickTimer != null && kMaxTimerBacklogMS != 0)
			{
				mSimTickTimer.ResetNextRunTimeIfTooFarInPast(kMaxTimerBacklogMS);
			}
		}
		else
		{
			mSimContext.mCommandRouter.UpdateLastFrameTimeOnPause();
			CommandRouter.UpdateStatus updateStatus = CommandRouter.UpdateStatus.AbleToAdvance;
			result = SimResultType.NoTick;
		}
		if (mNetWork != null)
		{
			mNetWork.mUDPClientNet.PushEvents();
		}
		if (mHasFrameManagerApplyBeenLogged)
		{
			mHasFrameManagerApplyBeenLogged = false;
		}
		if (mHasPlayerDropBeenLogged)
		{
			mHasPlayerDropBeenLogged = false;
		}
		if (mHasSimStallBeenLogged)
		{
			mHasSimStallBeenLogged = false;
		}
		return result;
	}

	private void InitPredictionSystems()
	{
		mPredictionSystems = new Systems();
		mPredictionSystems.Add(new PredictionAbilitiesSystem(mSimContext));
		mPredictionSystems.Add(new PredictionMovementSystem(mSimContext));
		mSimPredictionStatesSystem = new SimPredictionStatesSystem(mSimContext);
		mPredictionSystems.Add(mSimPredictionStatesSystem);
		mPredictionSystems.Initialize();
	}

	private SimResultType AdvancePredictionSimFrame(uint predictionFrame, bool isRollback)
	{
		if (!mIsInitialized)
		{
			throw new InvalidOperationException("Sim Scheduler hasn't been initialized");
		}
		SimResultType result = SimResultType.OK;
		mCurrentPredictionFrameNumber = predictionFrame;
		mSimContext.simStatus.mClientPredictionFrame = predictionFrame;
		mSimContext.simStatus.mIsRollback = isRollback;
		mPredictionSystems.Execute();
		return result;
	}

	private void InitServerSystems(SimContext context, GameMode gameMode)
	{
		mServerSystems = new Systems();
		mSimContext.SetSimStatus(new SimStatusSetting(), new SimSettings(), 0u, 0u, newMIsRollback: false, ReplayMode.ReplayingGame, gameMode, 0L, new Checksum(), new Checksum());
		mSimContext.simStatus.runtimeSetting.kSimTickPeriodMS = mLogicPeriodMS;
		mSimContext.SetCommandsPending("why can't be empty?????");
		mSimContext.SetSEntityWorldState(new SimWorldState());
		mSimContext.SetSEntityAABBTree(new DynamicTree<ISimShape>());
		mServerSystems.Add(new SimLogger(mSimContext));
		mServerSystems.Add(new SpawnSystem(mSimContext));
		mServerSystems.Add(new AllEntityPreProccessorSystem(mSimContext));
		mServerSystems.Add(new TriggerSystem(mSimContext));
		mServerSystems.Add(new AISystem(mSimContext));
		mServerSystems.Add(new SimNavSytem(mSimContext, astarPath));
		mServerSystems.Add(new ShapeSystem(mSimContext));
		mServerSystems.Add(new AllEntityProccessorSystem(mSimContext));
		mServerSystems.Add(new SimSystem(mSimContext));
		if (!mCloseSampler)
		{
			mSimStatesSystem = new SimStatesSystem(mSimContext);
			mServerSystems.Add(mSimStatesSystem);
		}
		mServerSystems.Initialize();
		mIsInitialized = true;
	}

	protected virtual SimResultType AdvanceServerSimFrame(uint serverFrame)
	{
		if (!mIsInitialized)
		{
			throw new InvalidOperationException("Sim Scheduler hasn't been initialized");
		}
		mSimContext.simStatus.mServerFrame = serverFrame;
		mCurrentServerFrameNumber = serverFrame;
		SimResultType result = SimResultType.OK;
		mServerSystems.Execute();
		return result;
	}

	public int GetPing()
	{
		if (mNetWork != null)
		{
			return mNetWork.mUDPClientNet.ping;
		}
		return int.MaxValue;
	}

	public E_BattleResult Replay(Queue<Command> cmds, int maxCount = 9000, Action frameUpdate = null)
	{
		uint num = 0u;
		while (num < maxCount)
		{
			if (CommonProcessor.IsMultiplePlayerGameMode(mSimContext))
			{
				num++;
			}
			else
			{
				mSimContext.mCommandRouter.UpdateServerLogic(++num);
			}
			if (mSimContext.hasSEntityGameOver)
			{
				break;
			}
			while (cmds.Count > 0)
			{
				Command command = cmds.Peek();
				if (command.mFrameCount > num)
				{
					break;
				}
				if (cmds.Count <= 1)
				{
					XLogger.Debug("last command: " + command.GetType().Name);
				}
				cmds.Dequeue();
				command.BindContext(mSimContext);
				command.RunCommand(0L);
				command.ReleaseCommand();
			}
			if (CommonProcessor.IsMultiplePlayerGameMode(mSimContext))
			{
				mSimContext.mCommandRouter.UpdateServerLogic(num);
			}
			frameUpdate?.Invoke();
		}
		if (num != maxCount)
		{
			XLogger.Debug("frame count error {0} of {1}", num, maxCount);
			return E_BattleResult.TIME_OUT;
		}
		XLogger.Debug("result :{0}", mSimContext.hasSEntityGameOver ? mSimContext.sEntityGameOver.isVectory : E_BattleResult.None);
		if (!mSimContext.hasSEntityGameOver)
		{
			return E_BattleResult.None;
		}
		return mSimContext.sEntityGameOver.isVectory;
	}

	public void StartSim()
	{
		if (!mIsInitialized)
		{
			throw new InvalidOperationException("ClientSimulator hasn't been initialized");
		}
		if (!IsSimRunning)
		{
			mWasSimRunning = true;
			SimTimeScale = 100;
		}
	}

	public void StopSim()
	{
		XLogger.Assert(mIsInitialized, "ClientSimulator hasn't been initialized");
		if (mIsInitialized)
		{
			SimTimeScale = 0;
		}
	}

	public void Shutdown()
	{
		if (mSimTickTimer != null && mTaskCollection != null)
		{
			mTaskCollection.TerminateTask(mSimTickTimer, 3000);
		}
		SimulatorExtensions.Shutdown();
		mServerSystems.Cleanup();
		mServerSystems.TearDown();
		if (mPredictionSystems != null)
		{
			mPredictionSystems.Cleanup();
			mPredictionSystems.TearDown();
		}
		if (astarPath != null)
		{
			astarPath.Shutdown();
		}
		mIsInitialized = false;
		mSimContext.ShutDown();
		mSimContext = null;
		sInstance = null;
		Debug.Log((object)"<color=red>关闭simulator</color>");
	}

	public void StartSinglePlayerGame(int roleID)
	{
		mSimContext.sEntityWorldState.status.mLocalPlayerNetID = 0L;
		mSimContext.sEntityWorldState.status.mLocalPlayerID = 0;
		mSimContext.sEntityWorldState.status.mRoleID = roleID;
		mSimContext.PostEvent(EntityTriggerEvent.Claim(TriggerEventType.MapInit));
	}
}
