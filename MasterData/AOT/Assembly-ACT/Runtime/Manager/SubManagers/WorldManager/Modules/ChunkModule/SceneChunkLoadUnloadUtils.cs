using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using ACT;
using ACT.World;
using ACT.World.Asset;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using YooAsset;

namespace Runtime.Manager.SubManagers.WorldManager.Modules.ChunkModule;

public static class SceneChunkLoadUnloadUtils
{
	internal enum SceneType
	{
		Foreground,
		Background
	}

	internal const float SceneBlockProgressFrom = 0.05f;

	internal const float SceneBlockProgressTo = 0.65f;

	internal const float ChunkStateAssetsProgressFrom = 0.65f;

	internal const float ChunkStateAssetsProgressTo = 1f;

	internal const float SceneBlockPrefabRatio = 0.35f;

	internal const float SceneBlockLevelDesignRatio = 0.45f;

	internal const float SceneBlockStateAssetsRatio = 0.9f;

	private static ScenePrefabData _cachedScenePrefabData;

	internal static void ReportSubProgress(float normalized)
	{
		SceneLoadProgressHandle.ReportCurrentSubProgress(normalized);
	}

	internal static void ReportRange(float from, float to, float progress)
	{
		if (!(to <= from))
		{
			ReportSubProgress(Mathf.Lerp(from, to, Mathf.Clamp01(progress)));
		}
	}

	internal static void UnloadSceneAsset(AssetLoadHandle handle)
	{
		if (handle.IsValid)
		{
			AssetStationManager.SceneStation.ReleaseInstance(handle);
		}
	}

	internal static async UniTask<(AssetLoadHandle?, bool, int)> LoadSceneAsset(int chunkId, string debugName, YooAssetReference sceneAssetRef, SceneType sceneType)
	{
		AssetLoadHandle? loadHandle = null;
		int token = 0;
		bool isEditorLoad = false;
		string sceneAssetGuid = string.Empty;
		try
		{
			if (sceneAssetRef != null && !string.IsNullOrEmpty(sceneAssetRef.GUID))
			{
				sceneAssetGuid = sceneAssetRef.GUID;
				if (CheckSceneAssetEditorLoaded(sceneAssetGuid))
				{
					isEditorLoad = true;
					token++;
				}
				else
				{
					loadHandle = ExecuteLoadScenePrefab(sceneAssetGuid);
					token++;
					await UniTask.WaitUntil(() => loadHandle.HasValue && loadHandle.GetValueOrDefault().IsDone);
				}
			}
		}
		catch (Exception ex)
		{
			Debug.LogException(new Exception($"[场景加载错误] 场景块({chunkId}), {GetSceneTypeDesc(sceneType)}[{debugName}:'{sceneAssetGuid}'], 加载时发生异常:\n" + ex));
		}
		return (loadHandle, isEditorLoad, token);
	}

	private static string GetSceneTypeDesc(SceneType type)
	{
		return type switch
		{
			SceneType.Background => "背景景场景资源", 
			SceneType.Foreground => "前景场景资源", 
			_ => string.Empty, 
		};
	}

	private static AssetLoadHandle ExecuteLoadScenePrefab(string sceneAssetGuid)
	{
		ScenePrefabData scenePrefabData = LoadScenePrefabData();
		if (scenePrefabData == null)
		{
			throw new InvalidDataException("未找到 ScenePrefabData 资源，无法通过 SceneGUID 加载对应的 Prefab。");
		}
		string prefabGuid = scenePrefabData.GetPrefabGuid(sceneAssetGuid);
		if (string.IsNullOrEmpty(prefabGuid))
		{
			throw new InvalidDataException("ScenePrefabData 中未找到场景 GUID[" + sceneAssetGuid + "] 对应的 Prefab GUID。");
		}
		AssetInfo assetInfoByGUID = YooAssets.GetAssetInfoByGUID(prefabGuid, typeof(GameObject));
		if (assetInfoByGUID == null || assetInfoByGUID.IsInvalid)
		{
			throw new InvalidDataException("无法通过 Prefab GUID[" + prefabGuid + "] 获取有效的资源信息。");
		}
		Debug.LogWarning("[PF2D][ScenePrefabMap] sceneGuid=" + sceneAssetGuid + " prefabGuid=" + prefabGuid + " prefabPath=" + assetInfoByGUID.AssetPath);
		AssetLoadHandle assetLoadHandle = AssetStationManager.SceneStation.Instantiate(prefabGuid);
		LogPrefabInstanceSnapshot("Instantiate", sceneAssetGuid, prefabGuid, assetLoadHandle);
		return assetLoadHandle;
	}

	private static ScenePrefabData LoadScenePrefabData()
	{
		if (_cachedScenePrefabData != null)
		{
			return _cachedScenePrefabData;
		}
		_cachedScenePrefabData = AssetStationManager.Root.Load<ScenePrefabData>("Configs/ScenePrefabData").As<ScenePrefabData>();
		return _cachedScenePrefabData;
	}

	private static void LogPrefabInstanceSnapshot(string phase, string sceneAssetGuid, string prefabGuid, AssetLoadHandle handle)
	{
		if (!handle.IsValid)
		{
			Debug.LogWarning("[PF2D][ScenePrefabMap][" + phase + "] sceneGuid=" + sceneAssetGuid + " prefabGuid=" + prefabGuid + " handle=invalid");
			return;
		}
		GameObject gameObject = handle.AsGameObject();
		if (gameObject == null)
		{
			Debug.LogWarning("[PF2D][ScenePrefabMap][" + phase + "] sceneGuid=" + sceneAssetGuid + " prefabGuid=" + prefabGuid + " result=null");
		}
		else
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append("[PF2D][ScenePrefabMap][").Append(phase).Append("]");
			stringBuilder.Append(" sceneGuid=").Append(sceneAssetGuid);
			stringBuilder.Append(" prefabGuid=").Append(prefabGuid);
			stringBuilder.Append(" go=").Append(gameObject.name);
			stringBuilder.Append(" scene=").Append(gameObject.scene.name);
			stringBuilder.Append(" active=").Append(gameObject.activeInHierarchy);
			stringBuilder.Append(" rootCount=").Append(gameObject.scene.isLoaded ? gameObject.scene.rootCount : (-1));
			Debug.LogWarning(stringBuilder.ToString());
		}
	}

	private static bool CheckSceneAssetEditorLoaded(string sceneAssetGuid)
	{
		return false;
	}

	internal static async UniTask<AssetLoadHandle> LoadLevelDesign(YooAssetReference levelDesignAssetRef, Transform parent)
	{
		if (levelDesignAssetRef == null || !levelDesignAssetRef.IsValid())
		{
			await UniTask.CompletedTask;
			return default;
		}
		AssetLoadHandle levelDesignHandle = AssetStationManager.SceneStation.InstantiateAsync(levelDesignAssetRef);
		await UniTask.WaitUntil(() => levelDesignHandle.IsDone);
		if (levelDesignHandle.Result is GameObject gameObject)
		{
			gameObject.transform.SetParent(parent, worldPositionStays: true);
			gameObject.transform.SetAsFirstSibling();
			Debug.LogWarning("[PF2D][LevelDesign] guid=" + levelDesignAssetRef.GUID + " go=" + gameObject.name + " scene=" + gameObject.scene.name + " parentScene=" + ((parent != null) ? parent.gameObject.scene.name : "null"));
		}
		return levelDesignHandle;
	}

	internal static void UnloadLevelDesign(AssetLoadHandle handle)
	{
		if (handle.IsValid)
		{
			AssetStationManager.SceneStation.ReleaseInstance(handle);
		}
	}

	internal static async UniTask LoadStateAssets(StateWorldAssetData[] stateWorldAssetDatas, CancellationToken cancelToken = default(CancellationToken), CancellationToken syncToken = default(CancellationToken), float progressFrom = 0f, float progressTo = 0f)
	{
		int totalCount = stateWorldAssetDatas?.Length ?? 0;
		if (totalCount <= 0)
		{
			return;
		}
		List<(StateWorldAsset, UniTask)> assetLoadTask = new List<(StateWorldAsset, UniTask)>();
		int completedCount = 0;
		for (int i = 0; i < totalCount; i++)
		{
			(StateWorldAsset, UniTask) tuple = stateWorldAssetDatas[i].OnLoad(syncToken);
			if (tuple.Item2.Status == UniTaskStatus.Succeeded)
			{
				completedCount++;
			}
			else
			{
				assetLoadTask.Add((tuple.Item1, tuple.Item2));
			}
		}
		ReportRange(progressFrom, progressTo, (float)completedCount / (float)totalCount);
		await UniTask.WaitUntil(() =>
		{
			int num = completedCount;
			foreach (var item in assetLoadTask)
			{
				if (item.Item1.LoadDone)
				{
					num++;
				}
			}
			ReportRange(progressFrom, progressTo, (float)num / (float)totalCount);
			return num >= totalCount;
		}, PlayerLoopTiming.Update, cancelToken);
	}

	internal static void UnloadStateAssets(StateWorldAssetData[] stateWorldAssetDatas)
	{
		if (stateWorldAssetDatas != null)
		{
			int num = stateWorldAssetDatas.Length;
			for (int i = 0; i < num; i++)
			{
				stateWorldAssetDatas[i].OnRelease();
			}
		}
	}

	internal static async UniTask<AssetLoadHandle> LoadStateBlueprint(YooAssetReference LevelBlueprintAssetRef, Transform container)
	{
		if (LevelBlueprintAssetRef == null || !LevelBlueprintAssetRef.IsValid())
		{
			await UniTask.CompletedTask;
			return default;
		}
		AssetLoadHandle blueprintHandle = AssetStationManager.SceneStation.InstantiateAsync(LevelBlueprintAssetRef);
		await UniTask.WaitUntil(() => blueprintHandle.IsDone);
		if (blueprintHandle.Result is GameObject gameObject)
		{
			gameObject.transform.SetParent(container, worldPositionStays: true);
			gameObject.transform.SetAsFirstSibling();
			Debug.LogWarning("[PF2D][Blueprint] guid=" + LevelBlueprintAssetRef.GUID + " go=" + gameObject.name + " scene=" + gameObject.scene.name + " parentScene=" + ((container != null) ? container.gameObject.scene.name : "null"));
		}
		await UniTask.NextFrame();
		return blueprintHandle;
	}

	internal static void UnloadStateBlueprint(AssetLoadHandle handle)
	{
		if (handle.IsValid)
		{
			AssetStationManager.SceneStation.ReleaseInstance(handle);
		}
	}
}
