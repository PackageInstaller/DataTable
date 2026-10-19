using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;
using ACT.Error;
using ACT.Event;
using ACT.Initialize.Flow;
using ACT.Net;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using bamboosdk;

namespace ACT.Initialize;

public class LuminRuntimeInitializer
{
	private static readonly List<RuntimeLoadFlow> _runningLoadingFlows = new List<RuntimeLoadFlow>();

	private readonly Queue<RuntimeLoadFlow> _pendingStartFlows = new Queue<RuntimeLoadFlow>();

	private bool _isStartingFlows;

	public static GameLoader GameLoader { get; protected set; }

	public static Instructions WaitInstruction { get; private set; } = new Instructions();

	public static ReadOnlyCollection<RuntimeLoadFlow> RunningFlows => _runningLoadingFlows.AsReadOnly();

	public static bool IsRuntimeInitializationComplete
	{
		get
		{
			if (_runningLoadingFlows.Count == 0)
			{
				return false;
			}
			for (int i = 0; i < _runningLoadingFlows.Count; i++)
			{
				if (!_runningLoadingFlows[i].IsComplete)
				{
					return false;
				}
			}
			return true;
		}
	}

	public static bool IsGameDataInitializationStarted { get; private set; }

	public LuminRuntimeInitializer()
	{
		WaitInstruction.Clear();
		_runningLoadingFlows.Clear();
		IsGameDataInitializationStarted = false;
	}

	internal InitShaderVariant InitGameShader()
	{
		InitShaderVariant initShaderVariant = new InitShaderVariant();
		initShaderVariant.Start(enableReport: false);
		return initShaderVariant;
	}

	public void InitGameDataNoneParam()
	{
		InitGameData(null);
	}

	public void InitGameData(GameLoader gameLoader)
	{
		InitGameDataAsync(gameLoader).Forget();
	}

	private async UniTask InitGameDataAsync(GameLoader gameLoader)
	{
		RegisterCrashSightExceptionHandler();
		RepairRawFileCacheFlow repairFlow = new RepairRawFileCacheFlow();
		repairFlow.Start(enableReport: false);
		if (!repairFlow.IsComplete && !repairFlow.Aborted)
		{
			await UniTask.WaitUntil(() => repairFlow.IsComplete || repairFlow.Aborted);
		}
		if (repairFlow.Aborted)
		{
			return;
		}
		InitShaderVariant shaderFlow = InitGameShader();
		if (!shaderFlow.IsComplete)
		{
			await UniTask.WaitUntil(() => shaderFlow.IsComplete);
		}
		IsGameDataInitializationStarted = true;
		StartGameDataFlows(gameLoader);
	}

	private static void RegisterCrashSightExceptionHandler()
	{
		try
		{
			MethodInfo methodInfo = Type.GetType("CrashSightAgent, CrashSight")?.GetMethod("_RegisterExceptionHandler", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, Type.EmptyTypes, null);
			if (methodInfo == null)
			{
				Debug.LogWarning("[LuminRuntimeInitializer] 未找到 CrashSightAgent._RegisterExceptionHandler，跳过异常处理注册。");
			}
			else
			{
				methodInfo.Invoke(null, null);
			}
		}
		catch (Exception arg)
		{
			Debug.LogWarning($"[LuminRuntimeInitializer] 注册 CrashSight 异常处理失败: {arg}");
		}
	}

	private void StartGameDataFlows(GameLoader gameLoader)
	{
		Debug.Log("Start Load GameLoader");
		if (gameLoader == null)
		{
			GameLoader = AssetStationManager.Root.Instantiate("GameLoader").As<GameObject>().GetComponent<GameLoader>();
			Debug.Log("Load GameLoader Over");
		}
		else
		{
			GameLoader = gameLoader;
		}
		try
		{
			RegisterFlow(new InitUWASDK());
			RegisterFlow(new InitAssetStation());
			RegisterFlow(new InitDeviceGrade(GameLoader));
			RegisterFlow(new InitGameUtility());
			RegisterFlow(new InitUIFrameWork());
			RegisterFlow(new ClearUnusedBundleCacheFlow());
			RegisterFlow(new InitDebugTool());
			RegisterFlow(new InitSpriteAtlasLoader());
			RegisterFlow(new InitEventTrack());
			RegisterFlow(new InitTables());
			RegisterFlow(new InitMetaRes());
			RegisterFlow(new InitSound());
			RegisterFlow(new InitSettingConfig());
			RegisterFlow(new InitRaidMonsterInfo());
			RegisterFlow(new InitSensitiveWordManager());
			RegisterFlow(new InitRaidPerformanceConfig());
			RegisterFlow(new ConnectNodeModelLoadFlow());
			RegisterFlow(new InitLoginView(), includeInMainProgress: false);
			Application.quitting += QuitProcess;
			Application.runInBackground = true;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ResourceLoad_End, null);
			StartRegisteredFlowsAsync().Forget();
		}
		catch (Exception ex)
		{
			if (ex is LuminErrorException exception)
			{
				LuminError.Handle(exception, new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, Application.Quit));
			}
			throw;
		}
	}

	private void RegisterFlow(RuntimeLoadFlow flow, bool includeInMainProgress = true)
	{
		_runningLoadingFlows.Add(flow);
		if (includeInMainProgress)
		{
			WaitInstruction.AddInstruction(flow.WaitInitializer, flow.Weight);
		}
		_pendingStartFlows.Enqueue(flow);
	}

	private async UniTask StartRegisteredFlowsAsync()
	{
		if (_isStartingFlows)
		{
			return;
		}
		_isStartingFlows = true;
		try
		{
			while (_pendingStartFlows.Count > 0)
			{
				_pendingStartFlows.Dequeue().Start(enableReport: false);
				await UniTask.NextFrame();
			}
		}
		finally
		{
			_isStartingFlows = false;
		}
	}

	private void QuitProcess()
	{
		Application.quitting -= QuitProcess;
		BamBooSdk.getInstance().exit();
		if (Singleton<NetManager>.HasInstance())
		{
			Singleton<NetManager>.instance.Disconnect();
		}
	}
}
