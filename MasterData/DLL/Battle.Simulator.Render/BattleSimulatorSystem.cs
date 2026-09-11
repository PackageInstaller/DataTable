using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using UnityEngine;

public class BattleSimulatorSystem
{
	public static int sTargetRenderFrameRate;

	public static int sTargetLogicFrameRate;

	private static float sCurrentServerSimSubFrame = 0f;

	private static float sCurrentPredictionSimSubFrame = 0f;

	private static object sSimFrameMutex = new object();

	private bool _gameOver;

	private GameOverState _gameOverState = GameOverState.shutDown;

	public EventHandler<SimGameOverEvent> GameOverDelegate;

	private SimStateFrame mCurrentSimFrame;

	private SimStateFrame mCurrentPredictionSimFrame;

	private SimResultType mLastSimResult;

	private Queue<SimStateFrame> mPendingServerSimFrames = new Queue<SimStateFrame>(16);

	private List<SimStateFrame> mTransientServerSimFrameList = new List<SimStateFrame>(16);

	private Queue<SimStateFrame> mPendingPredictionSimFrames = new Queue<SimStateFrame>(16);

	private List<SimStateFrame> mTransientPredictionSimFrameList = new List<SimStateFrame>(16);

	private AgentManager mAgentManager;

	private ThrownManager mThrownManager;

	private BuffManager mBuffManager;

	private MapTriggerManager mMapTriggerManager;

	private WorldStateManager mWorldStateManger;

	public SimStateFrame CurrentSimFrame => mCurrentSimFrame;

	public SimStateFrame CurrentPridictionSimFrame => mCurrentPredictionSimFrame;

	public AgentManager ClientAgentManager => mAgentManager;

	public ThrownManager ThrownManager => mThrownManager;

	public BuffManager BuffManager => mBuffManager;

	public Action<int, int> mLogicInputEvent { get; set; }

	public MapTriggerManager MapTriggerManager => mMapTriggerManager;

	public WorldStateManager WorldStateManager => mWorldStateManger;

	public SimResultType LastSimResult => mLastSimResult;

	public event Action<SimStateFrame> NewStateFrame;

	public void Initialize(GameMode gameMode, INetCallback net)
	{
		sTargetLogicFrameRate = Platform.GetLogicFrame();
		ClientSimulator.Instance.Startup(sTargetLogicFrameRate, gameMode, net);
		mAgentManager = new AgentManager();
		mThrownManager = new ThrownManager();
		mWorldStateManger = new WorldStateManager();
		mBuffManager = new BuffManager();
		mMapTriggerManager = new MapTriggerManager();
		mWorldStateManger.Initialize();
		mAgentManager.Initialize();
		mMapTriggerManager.Initialize();
		mThrownManager.Initialize();
		mBuffManager.Initialize();
		_gameOver = false;
		sCurrentServerSimSubFrame = 0f;
		sCurrentPredictionSimSubFrame = 0f;
		Debug.Log("renderFrame == " + sTargetRenderFrameRate + ",logicframe == " + sTargetLogicFrameRate);
	}

	public void StartSimulate(ref byte[] binMap, ProtoMapdata triggers)
	{
		Application.targetFrameRate = sTargetRenderFrameRate;
		ClientSimulator.Instance.InitMap(ref binMap, triggers);
		GameOverDelegate = (EventHandler<SimGameOverEvent>)Delegate.Combine(GameOverDelegate, new EventHandler<SimGameOverEvent>(OnGameOver));
		ClientSimulator.Instance.RegisterClientCallback(OnSimTickResultHandler, OnSyncNewSimStateFrame);
		ClientSimulator.Instance.RegisterServerCallback(OnSimTickResultHandler, OnSyncNewSimStateFrame);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler(GameOverDelegate);
		Time.fixedDeltaTime = 1f / (float)sTargetLogicFrameRate;
	}

	private void OnSimTickResultHandler(SimResultType tickResult)
	{
		if (mLastSimResult != SimResultType.SyncError && mLastSimResult != SimResultType.Disconnect && (mLastSimResult != SimResultType.Error || tickResult == SimResultType.Disconnect || tickResult == SimResultType.SyncError))
		{
			switch (tickResult)
			{
			default:
				XLogger.Error("Gameplay:", $"Unknown scheduler result in {GetType()}. Got result of {mLastSimResult}");
				break;
			case SimResultType.NoTick:
			case SimResultType.OK:
			case SimResultType.SyncError:
			case SimResultType.Disconnect:
			case SimResultType.StalledOnPresentation:
			case SimResultType.StalledOnInput:
			case SimResultType.StalledOnPlayerDropSynchronization:
			case SimResultType.Error:
				break;
			}
			mLastSimResult = tickResult;
		}
	}

	private void OnSyncNewSimStateFrame(SimStateFrame frame)
	{
		lock (sSimFrameMutex)
		{
			if (frame.IsPrediction)
			{
				mPendingPredictionSimFrames.Enqueue(frame);
			}
			else
			{
				mPendingServerSimFrames.Enqueue(frame);
			}
		}
	}

	public void FixedUpdate()
	{
		mAgentManager.FixedUpdate();
		mThrownManager.FixedUpdate();
		mWorldStateManger.FixedUpdate();
		mMapTriggerManager.FixedUpdate();
		mBuffManager.FixedUpdate();
	}

	public void Update()
	{
		ClientSimulator.Instance.Update(Time.deltaTime);
		int num = HandlePendingSimFrames();
		bool num2 = num > 0;
		sCurrentServerSimSubFrame += (float)ClientSimulator.Instance.SimFrameCount * Time.deltaTime;
		if (num2)
		{
			sCurrentServerSimSubFrame -= 1000 * num;
		}
		sCurrentServerSimSubFrame = Mathf.Clamp(sCurrentServerSimSubFrame, 0f, 1000f);
		num = HandlePendingPredictionSimFrames();
		bool num3 = num > 0;
		sCurrentPredictionSimSubFrame += (float)ClientSimulator.Instance.SimFrameCount * Time.deltaTime;
		if (num3)
		{
			sCurrentPredictionSimSubFrame -= 1000 * num;
		}
		sCurrentPredictionSimSubFrame = Mathf.Clamp(sCurrentPredictionSimSubFrame, 0f, 1000f);
		mWorldStateManger.Update();
		mAgentManager.Update();
		mMapTriggerManager.Update();
		mThrownManager.Update();
		mBuffManager.Update();
	}

	public void LateUpdate()
	{
		mWorldStateManger.LateUpdate();
		mAgentManager.LateUpdate();
		mMapTriggerManager.LateUpdate();
		mThrownManager.LateUpdate();
		mBuffManager.LateUpdate();
	}

	public void Destroy()
	{
		GameOverDelegate = (EventHandler<SimGameOverEvent>)Delegate.Remove(GameOverDelegate, new EventHandler<SimGameOverEvent>(OnGameOver));
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler(GameOverDelegate);
		mWorldStateManger?.Shutdown();
		mWorldStateManger = null;
		mAgentManager?.Shutdown();
		mAgentManager = null;
		mMapTriggerManager?.Shutdown();
		mMapTriggerManager = null;
		mThrownManager?.Shutdown();
		mThrownManager = null;
		mBuffManager?.Shutdown();
		mBuffManager = null;
		ClientSimulator.Instance.Shutdown();
	}

	private int HandlePendingSimFrames()
	{
		lock (sSimFrameMutex)
		{
			Queue<SimStateFrame>.Enumerator enumerator = mPendingServerSimFrames.GetEnumerator();
			while (enumerator.MoveNext())
			{
				mTransientServerSimFrameList.Add(enumerator.Current);
			}
			mPendingServerSimFrames.Clear();
		}
		int count = mTransientServerSimFrameList.Count;
		for (int i = 0; i < mTransientServerSimFrameList.Count; i++)
		{
			SimStateFrame simStateFrame = mTransientServerSimFrameList[i];
			if (mCurrentSimFrame != null && ClientSimulator.Instance.IsInitialized)
			{
				ClientSimulator.Instance.GetSimStatesSystem().Release(mCurrentSimFrame);
			}
			mCurrentSimFrame = simStateFrame;
			ClientSimulator.Instance.GetSimToPresentation().DispatchPreEventsToListeners(simStateFrame.Events);
			OnNewStateFrame(simStateFrame);
			ClientSimulator.Instance.GetSimToPresentation().DispatchEventsToListeners(simStateFrame.Events);
		}
		mTransientServerSimFrameList.Clear();
		return count;
	}

	private int HandlePendingPredictionSimFrames()
	{
		lock (sSimFrameMutex)
		{
			Queue<SimStateFrame>.Enumerator enumerator = mPendingPredictionSimFrames.GetEnumerator();
			while (enumerator.MoveNext())
			{
				mTransientPredictionSimFrameList.Add(enumerator.Current);
			}
			mPendingPredictionSimFrames.Clear();
		}
		int count = mTransientPredictionSimFrameList.Count;
		for (int i = 0; i < mTransientPredictionSimFrameList.Count; i++)
		{
			SimStateFrame simStateFrame = mTransientPredictionSimFrameList[i];
			if (mCurrentPredictionSimFrame != null && ClientSimulator.Instance.IsInitialized)
			{
				ClientSimulator.Instance.GetSimPredictionStatesSystem().Release(mCurrentPredictionSimFrame);
			}
			mCurrentPredictionSimFrame = simStateFrame;
			ClientSimulator.Instance.GetSimToPresentation().DispatchPreEventsToListeners(simStateFrame.Events);
			OnNewStateFrame(simStateFrame);
			ClientSimulator.Instance.GetSimToPresentation().DispatchEventsToListeners(simStateFrame.Events);
		}
		mTransientPredictionSimFrameList.Clear();
		return count;
	}

	private void OnNewStateFrame(SimStateFrame frame)
	{
		if (NewStateFrame != null)
		{
			NewStateFrame(frame);
		}
		mWorldStateManger.UpdateLogic(frame);
		mThrownManager.UpdateLogic(frame);
		mAgentManager.UpdateLogic(frame);
		mMapTriggerManager.UpdateLogic(frame);
		mBuffManager.UpdateLogic(frame);
	}

	public uint GetCurrentSimFrameNumber()
	{
		if (mCurrentSimFrame == null)
		{
			return 0u;
		}
		return mCurrentSimFrame.FrameNumber;
	}

	public uint GetCurrentPredictionSimFrameNumber()
	{
		if (mCurrentPredictionSimFrame == null)
		{
			return 0u;
		}
		return mCurrentPredictionSimFrame.FrameNumber;
	}

	public void PauseGame()
	{
		if (!BattleScene.isPause && CommonProcessor.IsSinglePlayerGameMode(ClientSimulator.Instance.mGameMode))
		{
			ClientSimulator.Instance.StopSim();
			BattleScene.isPause = true;
		}
	}

	public void ResumeGame()
	{
		if (CommonProcessor.IsSinglePlayerGameMode(ClientSimulator.Instance.mGameMode))
		{
			ClientSimulator.Instance.StartSim();
			BattleScene.isPause = false;
		}
	}

	public void UpdateLogic()
	{
		List<Graph> runningGraphs = Graph.GetRunningGraphs();
		if (runningGraphs != null)
		{
			for (int i = 0; i < runningGraphs.Count; i++)
			{
				runningGraphs[i].UpdateLogicGraph();
			}
		}
	}

	public static float GetSimPercent(bool Prediction)
	{
		if (Prediction)
		{
			return sCurrentPredictionSimSubFrame / 1000f;
		}
		return sCurrentServerSimSubFrame / 1000f;
	}

	public void OnGameOver(SimGameOverEvent gameOverEvent)
	{
		_gameOver = true;
		_gameOverState = gameOverEvent.state;
		if (gameOverEvent.state == GameOverState.end)
		{
			Debug.Log(Time.frameCount + ":GameOver " + gameOverEvent.isVectory);
		}
	}

	public bool IsGameOver()
	{
		return _gameOver;
	}

	public bool IsGameOverEnd()
	{
		if (!_gameOver)
		{
			return false;
		}
		if (_gameOverState == GameOverState.start || _gameOverState == GameOverState.tick)
		{
			return false;
		}
		return true;
	}
}
