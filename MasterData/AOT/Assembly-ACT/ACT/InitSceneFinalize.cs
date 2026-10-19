using System.Text;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.World;
using Cysharp.Threading.Tasks;
using Fundamental;
using PathFinding2D.Runtime;
using PathFinding2D.Runtime.Models;
using PathFinding2D.Runtime.Settings;
using Runtime.World.SceneChunks;
using UnityEngine;

namespace ACT;

internal class InitSceneFinalize : WorldLoadStepOperation
{
	private static int s_PathFindingBindVersion;

	internal override async void OnStart()
	{
		Singleton<GameManager>.instance.worldManager.RegisterOnWorldChangedCallback(OnConfigWorldChange);
		Singleton<GameManager>.instance.worldManager.RegisterOnWorldReleaseCallback(OnWorldReleased);
		Singleton<GameManager>.instance.worldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		OnConfigWorldChange(null);
		BindPathFinding2D("InitSceneFinalize");
		if (G.localPlayer.Profile.SceneStatus != SceneStatus.Main)
		{
			State = OptionState.Succeed;
			return;
		}
		await UniTask.DelayFrame(1);
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}

	private void OnConfigWorldChange(IConfigWorldPartition configWorldPartition)
	{
		if (Singleton<GameManager>.instance.worldManager.ActiveWorldId == 3 && Model<MapModel>.HasInstance() && !Model<MapModel>.Interface.MainWorldDataInitFinish)
		{
			Model<MapModel>.Interface.MainWorldDataInit();
		}
		ClearPathFinding2D("OnConfigWorldChange");
		SchedulePathFinding2DRetry("OnConfigWorldChange");
	}

	private static void OnWorldReleased(IConfigWorldPartition _)
	{
		ClearPathFinding2D("OnWorldReleased");
	}

	private static void OnChunkChanged(int chunkId, int oldChunkId)
	{
		BindPathFinding2D("OnChunkChanged", chunkId);
	}

	private static void EnsurePathFindingRuntime()
	{
		if (!NavigationRuntime.IsInstantiated)
		{
			NavigationRuntimeProfile navigationRuntimeProfile = GameLoader.meta?.navigationRuntimeProfile;
			if (navigationRuntimeProfile != null)
			{
				NavigationRuntime.Init(navigationRuntimeProfile);
			}
		}
	}

	private static void BindPathFinding2D(string phase, int chunkId = -1)
	{
		EnsurePathFindingRuntime();
		if (NavigationRuntime.IsInstantiated)
		{
			NavigationDirection navigationDirection = FindSceneNavigationDirection();
			if (navigationDirection != null && HasUsableNavigationData(navigationDirection.NavigationData))
			{
				NavigationRuntime.Instance.LoadMap(navigationDirection.NavigationData);
			}
			else
			{
				ClearPathFinding2D(phase + "-noSceneData");
			}
		}
	}

	private static void ClearPathFinding2D(string phase)
	{
		s_PathFindingBindVersion++;
		if (NavigationRuntime.IsInstantiated)
		{
			NavigationRuntime.Instance.ClearMap();
		}
	}

	private static void SchedulePathFinding2DRetry(string phase)
	{
		int version = s_PathFindingBindVersion;
		RetryBindPathFinding2D(phase, version).Forget();
	}

	private static async UniTaskVoid RetryBindPathFinding2D(string phase, int version)
	{
		await UniTask.DelayFrame(1);
		if (version == s_PathFindingBindVersion && (!NavigationRuntime.IsInstantiated || !(NavigationRuntime.Instance.NavigationData != null)))
		{
			BindPathFinding2D(phase + "-retry");
		}
	}

	private static bool HasUsableNavigationData(NavigationData data)
	{
		if (data != null && data.Waypoints != null)
		{
			return data.Waypoints.Count > 0;
		}
		return false;
	}

	private static NavigationDirection FindSceneNavigationDirection()
	{
		NavigationDirection[] array = Object.FindObjectsByType<NavigationDirection>(FindObjectsInactive.Include, FindObjectsSortMode.None);
		WorldManager worldManager = ((Singleton<GameManager>.instance != null) ? Singleton<GameManager>.instance.worldManager : null);
		ISceneChunkControl sceneChunkControl = worldManager?.ActiveChunk;
		WorldBase worldBase = worldManager?.GetCurrentWorld();
		int num = sceneChunkControl?.WorldConfigId ?? 0;
		int num2 = sceneChunkControl?.ChunkId ?? 0;
		int num3 = worldBase?.WorldId ?? 0;
		NavigationDirection navigationDirection = null;
		int num4 = int.MinValue;
		NavigationDirection navigationDirection2 = null;
		int num5 = int.MinValue;
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("[PF2D][FindNavDir]");
		stringBuilder.Append(" worldConfigId=").Append(num);
		stringBuilder.Append(" chunkId=").Append(num2);
		stringBuilder.Append(" worldId=").Append(num3);
		stringBuilder.Append(" dirCount=").Append(array.Length);
		for (int i = 0; i < array.Length; i++)
		{
			NavigationDirection navigationDirection3 = array[i];
			if (navigationDirection3 == null)
			{
				stringBuilder.Append(" | [").Append(i).Append("] null");
				continue;
			}
			string identity = navigationDirection3.gameObject.name + " " + navigationDirection3.gameObject.scene.name;
			bool flag = HasUsableNavigationData(navigationDirection3.NavigationData);
			bool flag2 = MatchesCurrentWorld(identity, num, num2, num3);
			bool flag3 = !flag;
			stringBuilder.Append(" | [").Append(i).Append("]");
			stringBuilder.Append(" go=").Append(navigationDirection3.gameObject.name);
			stringBuilder.Append(" active=").Append(navigationDirection3.gameObject.activeInHierarchy);
			stringBuilder.Append(" scene=").Append(navigationDirection3.gameObject.scene.name);
			stringBuilder.Append(" data=").Append(NavigationRuntime.FormatData(navigationDirection3.NavigationData));
			stringBuilder.Append(" matched=").Append(flag2);
			stringBuilder.Append(" skipped=").Append(flag3);
			if (flag3)
			{
				continue;
			}
			int num6 = navigationDirection3.NavigationData.Waypoints.Count;
			if (navigationDirection3.gameObject.activeInHierarchy)
			{
				num6 += 1000000;
			}
			stringBuilder.Append(" score=").Append(num6);
			if (num6 > num5)
			{
				navigationDirection2 = navigationDirection3;
				num5 = num6;
			}
			if (flag2)
			{
				int num7 = num6 + 2000000;
				stringBuilder.Append(" matchedScore=").Append(num7);
				if (num7 > num4)
				{
					navigationDirection = navigationDirection3;
					num4 = num7;
				}
			}
		}
		NavigationDirection navigationDirection4 = ((navigationDirection != null) ? navigationDirection : navigationDirection2);
		stringBuilder.Append(" chosen=").Append((navigationDirection4 != null) ? navigationDirection4.gameObject.name : "null");
		stringBuilder.Append(" chosenSource=").Append((navigationDirection != null) ? "matched" : "fallback");
		return navigationDirection4;
	}

	private static bool MatchesCurrentWorld(string identity, int worldConfigId, int chunkId, int worldId)
	{
		if (string.IsNullOrEmpty(identity))
		{
			return false;
		}
		if (worldConfigId >= 1000 && identity.Contains(worldConfigId.ToString()))
		{
			return true;
		}
		if (chunkId >= 1000 && identity.Contains(chunkId.ToString()))
		{
			return true;
		}
		if (worldId >= 1000 && identity.Contains(worldId.ToString()))
		{
			return true;
		}
		return false;
	}
}
