using System;
using System.Collections.Generic;
using ACT;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Runtime.Manager.SubManagers.WorldManager.Modules.ChunkModule;

public class SceneChunkNodeTempLoader
{
	private static readonly List<StateWorldAssetData> _loadAssetsDataCache = new List<StateWorldAssetData>();

	private bool _loadStateObjects;

	private bool _loadMonster;

	private StateWorldAssetData[] _assetsData;

	private AssetLoadHandle _foregroundScenePrefabHandle;

	private AssetLoadHandle _backgroundScenePrefabHandle;

	private AssetLoadHandle _levelDesignHandle;

	public int ChunkId { get; private set; }

	public SceneBlock BlockData { get; private set; }

	private static void FillStateWorldAssetsData(List<StateWorldAssetData> toList, StateWorldAssetData[] assets, bool includeMonster)
	{
		if (assets == null)
		{
			return;
		}
		foreach (StateWorldAssetData stateWorldAssetData in assets)
		{
			if (includeMonster || (!(stateWorldAssetData is MonsterPointData) && !(stateWorldAssetData is BattleRoomData) && !(stateWorldAssetData is BossChallengeData)))
			{
				toList.Add(stateWorldAssetData);
			}
		}
	}

	public static SceneChunkNodeTempLoader Create(int chunkId, SceneBlock blockData, StateWorldAssetData[] commonAssets, bool loadStateObjects, bool loadMonster)
	{
		_loadAssetsDataCache?.Clear();
		if (loadStateObjects)
		{
			FillStateWorldAssetsData(_loadAssetsDataCache, commonAssets, loadMonster);
			FillStateWorldAssetsData(_loadAssetsDataCache, blockData.StateWorldAssetDatas, loadMonster);
		}
		return new SceneChunkNodeTempLoader
		{
			ChunkId = chunkId,
			BlockData = blockData,
			_loadStateObjects = loadStateObjects,
			_loadMonster = loadMonster,
			_assetsData = _loadAssetsDataCache.ToArray()
		};
	}

	private SceneChunkNodeTempLoader()
	{
	}

	public async UniTask<bool> Load()
	{
		bool success = true;
		try
		{
			await LoadSceneAsset();
			await LoadLevelDesign();
			await LoadStateAssets();
		}
		catch (Exception exception)
		{
			success = false;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
				Debug.LogError("加载timeline临时场景失败");
			}
		}
		return success;
	}

	public void Unload()
	{
		UnloadSceneAsset();
		UnloadLevelDesign();
		UnloadSceneAsset();
	}

	private async UniTask LoadSceneAsset()
	{
		int loadCnt = 0;
		if (!_foregroundScenePrefabHandle.IsValid)
		{
			(AssetLoadHandle?, bool, int) tuple = await SceneChunkLoadUnloadUtils.LoadSceneAsset(ChunkId, BlockData.DebugSceneName, BlockData.SceneAssetRef, SceneChunkLoadUnloadUtils.SceneType.Foreground);
			AssetLoadHandle? item = tuple.Item1;
			int item2 = tuple.Item3;
			_foregroundScenePrefabHandle = item.GetValueOrDefault();
			loadCnt += item2;
		}
		if (!_backgroundScenePrefabHandle.IsValid)
		{
			(AssetLoadHandle?, bool, int) tuple2 = await SceneChunkLoadUnloadUtils.LoadSceneAsset(ChunkId, BlockData.DebugSceneName, BlockData.BackgroundSceneAssetRef, SceneChunkLoadUnloadUtils.SceneType.Background);
			AssetLoadHandle? item3 = tuple2.Item1;
			int item4 = tuple2.Item3;
			_backgroundScenePrefabHandle = item3.GetValueOrDefault();
			loadCnt += item4;
		}
		if (loadCnt == 0)
		{
			await UniTask.CompletedTask;
		}
	}

	private void UnloadSceneAsset()
	{
		SceneChunkLoadUnloadUtils.UnloadSceneAsset(_foregroundScenePrefabHandle);
		SceneChunkLoadUnloadUtils.UnloadSceneAsset(_backgroundScenePrefabHandle);
	}

	private async UniTask LoadLevelDesign()
	{
		_levelDesignHandle = await SceneChunkLoadUnloadUtils.LoadLevelDesign(BlockData.LevelDesignAssetRef, _foregroundScenePrefabHandle.AsGameObject()?.transform);
	}

	private void UnloadLevelDesign()
	{
		SceneChunkLoadUnloadUtils.UnloadLevelDesign(_levelDesignHandle);
	}

	private async UniTask LoadStateAssets()
	{
		await SceneChunkLoadUnloadUtils.LoadStateAssets(_assetsData);
	}

	private void UnLoadStateAssets()
	{
		SceneChunkLoadUnloadUtils.UnloadStateAssets(_assetsData);
	}
}
