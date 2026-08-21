using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;
using UnityEngine;
using UnityEngine.LowLevel;
using UnityEngine.PlayerLoop;

namespace Cysharp.Threading.Tasks;

public static class PlayerLoopHelper
{
	private static readonly ContinuationQueue ThrowMarkerContinuationQueue = new ContinuationQueue(PlayerLoopTiming.Initialization);

	private static readonly PlayerLoopRunner ThrowMarkerPlayerLoopRunner = new PlayerLoopRunner(PlayerLoopTiming.Initialization);

	private static int mainThreadId;

	private static string applicationDataPath;

	private static SynchronizationContext unitySynchronizationContext;

	private static ContinuationQueue[] yielders;

	private static PlayerLoopRunner[] runners;

	public static SynchronizationContext UnitySynchronizationContext => unitySynchronizationContext;

	public static int MainThreadId => mainThreadId;

	internal static string ApplicationDataPath => applicationDataPath;

	public static bool IsMainThread => Thread.CurrentThread.ManagedThreadId == mainThreadId;

	internal static bool IsEditorApplicationQuitting { get; private set; }

	private static PlayerLoopSystem[] InsertRunner(PlayerLoopSystem loopSystem, bool injectOnFirst, Type loopRunnerYieldType, ContinuationQueue cq, Type loopRunnerType, PlayerLoopRunner runner)
	{
		PlayerLoopSystem playerLoopSystem = new PlayerLoopSystem
		{
			type = loopRunnerYieldType,
			updateDelegate = cq.Run
		};
		PlayerLoopSystem playerLoopSystem2 = new PlayerLoopSystem
		{
			type = loopRunnerType,
			updateDelegate = runner.Run
		};
		PlayerLoopSystem[] array = RemoveRunner(loopSystem, loopRunnerYieldType, loopRunnerType);
		PlayerLoopSystem[] array2 = new PlayerLoopSystem[array.Length + 2];
		Array.Copy(array, 0, array2, injectOnFirst ? 2 : 0, array.Length);
		if (injectOnFirst)
		{
			array2[0] = playerLoopSystem;
			array2[1] = playerLoopSystem2;
		}
		else
		{
			array2[array2.Length - 2] = playerLoopSystem;
			array2[array2.Length - 1] = playerLoopSystem2;
		}
		return array2;
	}

	private static PlayerLoopSystem[] RemoveRunner(PlayerLoopSystem loopSystem, Type loopRunnerYieldType, Type loopRunnerType)
	{
		return loopSystem.subSystemList.Where((PlayerLoopSystem ls) => ls.type != loopRunnerYieldType && ls.type != loopRunnerType).ToArray();
	}

	private static PlayerLoopSystem[] InsertUniTaskSynchronizationContext(PlayerLoopSystem loopSystem)
	{
		PlayerLoopSystem item = new PlayerLoopSystem
		{
			type = typeof(UniTaskSynchronizationContext),
			updateDelegate = UniTaskSynchronizationContext.Run
		};
		List<PlayerLoopSystem> list = new List<PlayerLoopSystem>(loopSystem.subSystemList.Where((PlayerLoopSystem ls) => ls.type != typeof(UniTaskSynchronizationContext)).ToArray());
		int num = list.FindIndex((PlayerLoopSystem x) => x.type.Name == "ScriptRunDelayedTasks");
		if (num == -1)
		{
			num = list.FindIndex((PlayerLoopSystem x) => x.type.Name == "UniTaskLoopRunnerUpdate");
		}
		list.Insert(num + 1, item);
		return list.ToArray();
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterAssembliesLoaded)]
	private static void Init()
	{
		unitySynchronizationContext = SynchronizationContext.Current;
		mainThreadId = Thread.CurrentThread.ManagedThreadId;
		try
		{
			applicationDataPath = Application.dataPath;
		}
		catch
		{
		}
		if (runners == null)
		{
			PlayerLoopSystem playerLoop = PlayerLoop.GetCurrentPlayerLoop();
			Initialize(ref playerLoop);
		}
	}

	private static int FindLoopSystemIndex(PlayerLoopSystem[] playerLoopList, Type systemType)
	{
		for (int i = 0; i < playerLoopList.Length; i++)
		{
			if (playerLoopList[i].type == systemType)
			{
				return i;
			}
		}
		throw new Exception("Target PlayerLoopSystem does not found. Type:" + systemType.FullName);
	}

	private static void InsertLoop(PlayerLoopSystem[] copyList, InjectPlayerLoopTimings injectTimings, Type loopType, InjectPlayerLoopTimings targetTimings, int index, bool injectOnFirst, Type loopRunnerYieldType, Type loopRunnerType, PlayerLoopTiming playerLoopTiming)
	{
		int num = FindLoopSystemIndex(copyList, loopType);
		if ((injectTimings & targetTimings) == targetTimings)
		{
			copyList[num].subSystemList = InsertRunner(copyList[num], injectOnFirst, loopRunnerYieldType, yielders[index] = new ContinuationQueue(playerLoopTiming), loopRunnerType, runners[index] = new PlayerLoopRunner(playerLoopTiming));
		}
		else
		{
			copyList[num].subSystemList = RemoveRunner(copyList[num], loopRunnerYieldType, loopRunnerType);
		}
	}

	public static void Initialize(ref PlayerLoopSystem playerLoop, InjectPlayerLoopTimings injectTimings = InjectPlayerLoopTimings.All)
	{
		yielders = new ContinuationQueue[16];
		runners = new PlayerLoopRunner[16];
		PlayerLoopSystem[] array = playerLoop.subSystemList.ToArray();
		InsertLoop(array, injectTimings, typeof(Initialization), InjectPlayerLoopTimings.Initialization, 0, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldInitialization), typeof(UniTaskLoopRunners.UniTaskLoopRunnerInitialization), PlayerLoopTiming.Initialization);
		InsertLoop(array, injectTimings, typeof(Initialization), InjectPlayerLoopTimings.LastInitialization, 1, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldInitialization), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastInitialization), PlayerLoopTiming.LastInitialization);
		InsertLoop(array, injectTimings, typeof(EarlyUpdate), InjectPlayerLoopTimings.EarlyUpdate, 2, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldEarlyUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerEarlyUpdate), PlayerLoopTiming.EarlyUpdate);
		InsertLoop(array, injectTimings, typeof(EarlyUpdate), InjectPlayerLoopTimings.LastEarlyUpdate, 3, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldEarlyUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastEarlyUpdate), PlayerLoopTiming.LastEarlyUpdate);
		InsertLoop(array, injectTimings, typeof(FixedUpdate), InjectPlayerLoopTimings.FixedUpdate, 4, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldFixedUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerFixedUpdate), PlayerLoopTiming.FixedUpdate);
		InsertLoop(array, injectTimings, typeof(FixedUpdate), InjectPlayerLoopTimings.LastFixedUpdate, 5, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldFixedUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastFixedUpdate), PlayerLoopTiming.LastFixedUpdate);
		InsertLoop(array, injectTimings, typeof(PreUpdate), InjectPlayerLoopTimings.PreUpdate, 6, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldPreUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerPreUpdate), PlayerLoopTiming.PreUpdate);
		InsertLoop(array, injectTimings, typeof(PreUpdate), InjectPlayerLoopTimings.LastPreUpdate, 7, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldPreUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastPreUpdate), PlayerLoopTiming.LastPreUpdate);
		InsertLoop(array, injectTimings, typeof(Update), InjectPlayerLoopTimings.Update, 8, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerUpdate), PlayerLoopTiming.Update);
		InsertLoop(array, injectTimings, typeof(Update), InjectPlayerLoopTimings.LastUpdate, 9, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastUpdate), PlayerLoopTiming.LastUpdate);
		InsertLoop(array, injectTimings, typeof(PreLateUpdate), InjectPlayerLoopTimings.PreLateUpdate, 10, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldPreLateUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerPreLateUpdate), PlayerLoopTiming.PreLateUpdate);
		InsertLoop(array, injectTimings, typeof(PreLateUpdate), InjectPlayerLoopTimings.LastPreLateUpdate, 11, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldPreLateUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastPreLateUpdate), PlayerLoopTiming.LastPreLateUpdate);
		InsertLoop(array, injectTimings, typeof(PostLateUpdate), InjectPlayerLoopTimings.PostLateUpdate, 12, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldPostLateUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerPostLateUpdate), PlayerLoopTiming.PostLateUpdate);
		InsertLoop(array, injectTimings, typeof(PostLateUpdate), InjectPlayerLoopTimings.LastPostLateUpdate, 13, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldPostLateUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastPostLateUpdate), PlayerLoopTiming.LastPostLateUpdate);
		InsertLoop(array, injectTimings, typeof(TimeUpdate), InjectPlayerLoopTimings.TimeUpdate, 14, injectOnFirst: true, typeof(UniTaskLoopRunners.UniTaskLoopRunnerYieldTimeUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerTimeUpdate), PlayerLoopTiming.TimeUpdate);
		InsertLoop(array, injectTimings, typeof(TimeUpdate), InjectPlayerLoopTimings.LastTimeUpdate, 15, injectOnFirst: false, typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastYieldTimeUpdate), typeof(UniTaskLoopRunners.UniTaskLoopRunnerLastTimeUpdate), PlayerLoopTiming.LastTimeUpdate);
		int num = FindLoopSystemIndex(array, typeof(Update));
		array[num].subSystemList = InsertUniTaskSynchronizationContext(array[num]);
		playerLoop.subSystemList = array;
		PlayerLoop.SetPlayerLoop(playerLoop);
	}

	public static void AddAction(PlayerLoopTiming timing, IPlayerLoopItem action)
	{
		PlayerLoopRunner obj = runners[(int)timing];
		if (obj == null)
		{
			ThrowInvalidLoopTiming(timing);
		}
		obj.AddAction(action);
	}

	private static void ThrowInvalidLoopTiming(PlayerLoopTiming playerLoopTiming)
	{
		throw new InvalidOperationException("Target playerLoopTiming is not injected. Please check PlayerLoopHelper.Initialize. PlayerLoopTiming:" + playerLoopTiming);
	}

	public static void AddContinuation(PlayerLoopTiming timing, Action continuation)
	{
		ContinuationQueue obj = yielders[(int)timing];
		if (obj == null)
		{
			ThrowInvalidLoopTiming(timing);
		}
		obj.Enqueue(continuation);
	}

	public static void DumpCurrentPlayerLoop()
	{
		PlayerLoopSystem currentPlayerLoop = PlayerLoop.GetCurrentPlayerLoop();
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("PlayerLoop List");
		PlayerLoopSystem[] subSystemList = currentPlayerLoop.subSystemList;
		for (int i = 0; i < subSystemList.Length; i++)
		{
			PlayerLoopSystem playerLoopSystem = subSystemList[i];
			stringBuilder.AppendFormat("------{0}------", playerLoopSystem.type.Name);
			stringBuilder.AppendLine();
			if (playerLoopSystem.subSystemList == null)
			{
				stringBuilder.AppendFormat("{0} has no subsystems!", playerLoopSystem.ToString());
				stringBuilder.AppendLine();
				continue;
			}
			PlayerLoopSystem[] subSystemList2 = playerLoopSystem.subSystemList;
			for (int j = 0; j < subSystemList2.Length; j++)
			{
				PlayerLoopSystem playerLoopSystem2 = subSystemList2[j];
				stringBuilder.AppendFormat("{0}", playerLoopSystem2.type.Name);
				stringBuilder.AppendLine();
				if (playerLoopSystem2.subSystemList != null)
				{
					Debug.LogWarning("More Subsystem:" + playerLoopSystem2.subSystemList.Length);
				}
			}
		}
		Debug.Log(stringBuilder.ToString());
	}

	public static bool IsInjectedUniTaskPlayerLoop()
	{
		PlayerLoopSystem[] subSystemList = PlayerLoop.GetCurrentPlayerLoop().subSystemList;
		for (int i = 0; i < subSystemList.Length; i++)
		{
			PlayerLoopSystem playerLoopSystem = subSystemList[i];
			if (playerLoopSystem.subSystemList == null)
			{
				continue;
			}
			PlayerLoopSystem[] subSystemList2 = playerLoopSystem.subSystemList;
			for (int j = 0; j < subSystemList2.Length; j++)
			{
				if (subSystemList2[j].type == typeof(UniTaskLoopRunners.UniTaskLoopRunnerInitialization))
				{
					return true;
				}
			}
		}
		return false;
	}
}
