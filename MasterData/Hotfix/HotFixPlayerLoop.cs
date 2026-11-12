#define LOG_ERROR
#define LOG_TRACE
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.LowLevel;
using UnityEngine.PlayerLoop;

public static class HotFixPlayerLoop
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct PostScriptUpdateTag
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct PostLateUpdateTag
	{
	}

	public static void Inject()
	{
		PlayerLoopSystem currentPlayerLoop = PlayerLoop.GetCurrentPlayerLoop();
		PlayerLoopSystem[] subSystemList = currentPlayerLoop.subSystemList;
		bool flag = false;
		bool flag2 = false;
		for (int i = 0; i < subSystemList.Length; i++)
		{
			Type type = subSystemList[i].type;
			if (type == typeof(Update))
			{
				flag = true;
				List<PlayerLoopSystem> list = new List<PlayerLoopSystem>(subSystemList[i].subSystemList);
				RemoveInjectedByFullName(list, typeof(PostScriptUpdateTag).FullName);
				int num = list.FindIndex((PlayerLoopSystem s) => s.type == typeof(Update.ScriptRunBehaviourUpdate));
				if (num < 0)
				{
					NovaLogger.Error("<HotFixPlayerLoop> PlayerLoop 注入失败：找不到 Update.ScriptRunBehaviourUpdate");
					continue;
				}
				list.Insert(num + 1, new PlayerLoopSystem
				{
					type = typeof(PostScriptUpdateTag),
					updateDelegate = OnPostScriptUpdate
				});
				subSystemList[i].subSystemList = list.ToArray();
			}
			else if (type == typeof(PostLateUpdate))
			{
				flag2 = true;
				List<PlayerLoopSystem> list2 = new List<PlayerLoopSystem>(subSystemList[i].subSystemList);
				RemoveInjectedByFullName(list2, typeof(PostLateUpdateTag).FullName);
				list2.Insert(0, new PlayerLoopSystem
				{
					type = typeof(PostLateUpdateTag),
					updateDelegate = OnPostLateUpdate
				});
				subSystemList[i].subSystemList = list2.ToArray();
			}
		}
		if (!flag || !flag2)
		{
			NovaLogger.Error("<HotFixPlayerLoop> PlayerLoop 注入失败：顶层子系统缺失 " + $"(Update: {flag}, PostLateUpdate: {flag2})");
		}
		else
		{
			PlayerLoop.SetPlayerLoop(currentPlayerLoop);
		}
	}

	private static void RemoveInjectedByFullName(List<PlayerLoopSystem> systems, string markerTypeFullName)
	{
		systems.RemoveAll((PlayerLoopSystem s) => s.type != null && s.type.FullName == markerTypeFullName);
	}

	public static void Uninject()
	{
		PlayerLoopSystem currentPlayerLoop = PlayerLoop.GetCurrentPlayerLoop();
		PlayerLoopSystem[] subSystemList = currentPlayerLoop.subSystemList;
		if (subSystemList == null)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < subSystemList.Length; i++)
		{
			if (subSystemList[i].subSystemList != null)
			{
				List<PlayerLoopSystem> list = new List<PlayerLoopSystem>(subSystemList[i].subSystemList);
				int count = list.Count;
				RemoveInjectedByFullName(list, typeof(PostScriptUpdateTag).FullName);
				RemoveInjectedByFullName(list, typeof(PostLateUpdateTag).FullName);
				if (list.Count != count)
				{
					subSystemList[i].subSystemList = list.ToArray();
					flag = true;
				}
			}
		}
		if (flag)
		{
			PlayerLoop.SetPlayerLoop(currentPlayerLoop);
			NovaLogger.Trace("<HotFixPlayerLoop> PlayerLoop 注入点已卸载");
		}
	}

	private static void OnPostScriptUpdate()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (instance != null && instance.isActiveAndEnabled)
		{
			InvokeSafely(instance.DriveUpdate);
		}
		AdventurePlayerController instance2 = SceneSingleton<AdventurePlayerController>.Instance;
		if (instance2 != null && instance2.isActiveAndEnabled)
		{
			InvokeSafely(instance2.DriveUpdate);
		}
		AdventureFXManager instance3 = SceneSingleton<AdventureFXManager>.Instance;
		if (instance3 != null && instance3.isActiveAndEnabled)
		{
			InvokeSafely(instance3.DriveUpdate);
		}
		AdventurePlayerCameraUpdateControl instance4 = SceneSingleton<AdventurePlayerCameraUpdateControl>.Instance;
		if (instance4 != null && instance4.isActiveAndEnabled)
		{
			InvokeSafely(instance4.DriveCameraUpdate);
		}
	}

	private static void OnPostLateUpdate()
	{
		PlayerAdventureActor.DriveActiveInstancesLateUpdate();
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		if (instance != null && instance.isActiveAndEnabled)
		{
			InvokeSafely(instance.DriveLateUpdate);
		}
		AdventureHUDController instance2 = SceneSingleton<AdventureHUDController>.Instance;
		if (instance2 != null && instance2.isActiveAndEnabled)
		{
			InvokeSafely(instance2.DriveLateUpdate);
		}
		AdventureIndicatorController instance3 = SceneSingleton<AdventureIndicatorController>.Instance;
		if (instance3 != null && instance3.isActiveAndEnabled)
		{
			InvokeSafely(instance3.DriveLateUpdate);
		}
		AdventureFXManager instance4 = SceneSingleton<AdventureFXManager>.Instance;
		if (instance4 != null && instance4.isActiveAndEnabled)
		{
			InvokeSafely(instance4.DriveLateUpdate);
		}
	}

	private static void InvokeSafely(Action action)
	{
		try
		{
			action();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}
}
