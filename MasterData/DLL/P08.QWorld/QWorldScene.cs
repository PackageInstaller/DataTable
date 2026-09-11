using System;
using QwStreaming;
using Unity.Profiling;
using UnityEngine;

public class QWorldScene : QWorldSceneLoader
{
	private ProfilerMarker QwSpaceQueryMarker = new ProfilerMarker("QwSpaceQueryMarker");

	private ProfilerMarker QwModelLodMarker = new ProfilerMarker("QwModelLodMarker");

	private ProfilerMarker QwSpQwLightLodaceQueryMarker = new ProfilerMarker("QwSpQwLightLodaceQueryMarker");

	private ProfilerMarker QwComponentLodMarker = new ProfilerMarker("QwComponentLodMarker");

	private ProfilerMarker PostUpdateAllLodDataMarker = new ProfilerMarker("PostUpdateAllLodDataMarker");

	private ProfilerMarker DoClearJobMarker = new ProfilerMarker("DoClearJobMarker");

	private ProfilerMarker LodComSchedulerMarker = new ProfilerMarker("LodComSchedulerMarker");

	private ProfilerMarker LodComSchedulerPreCullMarker = new ProfilerMarker("LodComSchedulerPreCullMarker");

	private const string EnterWorldFunc = "PostEnterQWorld";

	private const string WorldLoadedFunc = "OnQWorldLoaded";

	private const string ExitWorldFunc = "PostExitQWorld";

	private const string LuaGC = "LuaGcCollect";

	public static QWorldScene mScene;

	public float[] ratio = new float[6];

	public QWorldBubbleManager bubbleMgr;

	public QWorldCameraManager cameraManager;

	public QWorldHudManager hudManager;

	public QWorldPathFinderManager pathFinderManager;

	public QWPerformManager performManager;

	public QWComponentSystemManager componnetSystem;

	public QWorldSoundNodeManager soundNodeMgr;

	public QWAgentManager agentManager;

	public QWorldLODControlledLogicScheduler lodComScheduler;

	private QWorldContext qWorldContext;

	public static QWorldScene Scene => mScene;

	public ref QWorldContext Context => ref qWorldContext;

	public static ref QWorldContext GetQWorldContext()
	{
		return ref Scene.Context;
	}

	public override void OnSceneEnter()
	{
		mScene = this;
		QWorldLuaBridge.ClearAllEvent();
		Streaming.Init();
		StreamingCacheMgr.Init();
		QwLodMgr.Init();
		base.OnSceneEnter();
		bubbleMgr = new QWorldBubbleManager();
		bubbleMgr.Init();
		cameraManager = new QWorldCameraManager();
		cameraManager.Init();
		hudManager = new QWorldHudManager();
		hudManager.Init();
		pathFinderManager = new QWorldPathFinderManager();
		pathFinderManager.Init("Map/X510_graph.bytes");
		performManager = new QWPerformManager();
		performManager.Init();
		componnetSystem = new QWComponentSystemManager();
		componnetSystem.Init();
		soundNodeMgr = new QWorldSoundNodeManager();
		agentManager = new QWAgentManager();
		agentManager.Init();
		lodComScheduler = new QWorldLODControlledLogicScheduler();
		lodComScheduler.Init();
		LuaHelper.CallFunction("PostEnterQWorld");
	}

	public override void OnSceneLoaded()
	{
		LuaHelper.CallFunction("OnQWorldLoaded");
		base.OnSceneLoaded();
		cameraManager.InitLight();
	}

	public override void CloseLoadUI()
	{
		Resources.UnloadUnusedAssets();
		GC.Collect();
		GC.Collect();
		GC.Collect();
		LuaHelper.CallFunction("LuaGcCollect");
		base.CloseLoadUI();
	}

	private void Update()
	{
		bool num = Streaming.HasSyncLoading();
		Streaming.Update();
		bool flag = Streaming.HasSyncLoading();
		bool flag2 = isReady && !flag;
		if (isReady)
		{
			lodComScheduler?.PreCull();
		}
		QwLodMgr.UpdateAllLodData();
		if (flag2)
		{
			bubbleMgr?.StartJobCollectInteractInfo(base.Agent);
		}
		QwModelLod.Update();
		QwLightLod.Update();
		QwComponentLod.Update();
		if (!isReady)
		{
			SetUIProgress(Progress);
		}
		if (num != flag)
		{
			if (flag)
			{
				LoadingUIManager.inst.ShowLoadUI(LoadingUIType.Main);
			}
			else
			{
				LoadingUIManager.inst.CloseLoadUI();
			}
		}
		if (flag)
		{
			QwLodMgr.PostUpdateAllLodData();
			StreamingCacheMgr.DoClearJob();
			return;
		}
		if (flag2)
		{
			base.mMap?.Tick(base.Agent);
			bubbleMgr?.Tick(base.Agent);
			cameraManager?.Tick();
			hudManager?.Tick();
			pathFinderManager?.Tick();
			performManager?.Tick();
			componnetSystem?.Tick();
			soundNodeMgr?.Update();
			agentManager?.Tick();
		}
		QwLodMgr.PostUpdateAllLodData();
		StreamingCacheMgr.DoClearJob();
		if (isReady)
		{
			lodComScheduler?.Update();
		}
	}

	private void LateUpdate()
	{
		bool flag = Streaming.HasSyncLoading();
		if (isReady && !flag)
		{
			cameraManager?.LateTick();
			componnetSystem?.LateTick();
			agentManager?.LateTick();
		}
	}

	public override void OnSceneExit(NScene nextScene)
	{
		LuaHelper.CallFunction("PostExitQWorld");
		bubbleMgr.Disopse();
		bubbleMgr = null;
		hudManager.Dispose();
		hudManager = null;
		pathFinderManager.Dispose();
		pathFinderManager = null;
		performManager.Dispose();
		performManager = null;
		teleportManager = null;
		componnetSystem.Dispose();
		componnetSystem = null;
		soundNodeMgr.Dispose();
		soundNodeMgr = null;
		agentManager.Dispose();
		agentManager = null;
		lodComScheduler.Dispose();
		lodComScheduler = null;
		base.OnSceneExit(nextScene);
		QwLodMgr.Shutdown();
		StreamingCacheMgr.Shutdown();
		Streaming.Shutdown();
		QWorldLuaBridge.ClearAllEvent();
		mScene = null;
	}

	public void CullingAll(bool all, int[] hiddenIds = null, QWAgentLayer cullingLayer = (QWAgentLayer)4095)
	{
		if (base.mMap != null)
		{
			base.mMap.CullingAll(all, hiddenIds, cullingLayer);
		}
	}

	public void ResetWorldStateWithPos(Vector3 position)
	{
		base.mMap.ResetWorldState(position);
	}
}
