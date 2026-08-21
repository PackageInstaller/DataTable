#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingSceneViewModel : LoadingViewModel
{
	private bool loadingSceneFinish;

	private bool loadingSceneSuccess;

	private bool unloadSceneFinish;

	private bool unloadSceneSuccess;

	private const string SCENE_LOADING_KEY = "SceneLoading";

	private GamePreload _gamePreload;

	protected LoadingSceneViewModel(WorldData worldData, bool autoLoad)
		: base(worldData, autoLoad)
	{
		_gamePreload = new GamePreload(progressBar);
	}

	protected LoadingSceneViewModel()
	{
		_gamePreload = new GamePreload(progressBar);
		progressBar.AddLoadingData("SceneLoading", 100);
	}

	protected async UniTask<PreloadBattleData> CheckPreloadGameData(BattleWorldData battleWorldData)
	{
		PreloadBattleData battleData = new PreloadBattleData();
		if (battleWorldData == null)
		{
			Log.Error("预加载失败：缺少 worldData");
			return null;
		}
		if (battleWorldData.TeamListConfig == null)
		{
			Log.Error("预加载失败：缺少队伍信息！");
			return null;
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		for (int i = 0; i < battleWorldData.TeamListConfig.Count; i++)
		{
			PeripheryHeroData peripheryHeroData = battleWorldData.TeamListConfig[i];
			if (peripheryHeroData.PropsData == null)
			{
				continue;
			}
			foreach (BattleProps value2 in peripheryHeroData.PropsData.Values)
			{
				if (value2 != null)
				{
					int num = Math.Max(value2.CarryPropNumber, 1);
					if (dictionary.TryGetValue(value2.Id, out var _))
					{
						dictionary[value2.Id] += num;
					}
					else
					{
						dictionary[value2.Id] = num;
					}
				}
			}
		}
		List<int> list = new List<int>();
		list.Add(battleWorldData.BossId);
		Dictionary<int, int> monsterCountDic = null;
		if (battleWorldData is ActivityBattleWorldData activityBattleWorldData)
		{
			for (int j = 0; j < activityBattleWorldData.Monsters.Count; j++)
			{
				list.Add(activityBattleWorldData.Monsters[j]);
			}
		}
		else if (battleWorldData is CampaignBattleWorldData campaignBattleWorldData)
		{
			monsterCountDic = campaignBattleWorldData.MonsterCounts;
			for (int k = 0; k < campaignBattleWorldData.Monsters.Count; k++)
			{
				if (!list.Contains(campaignBattleWorldData.Monsters[k]))
				{
					list.Add(campaignBattleWorldData.Monsters[k]);
				}
			}
		}
		if (!(await _gamePreload.CheckGameAsset(battleWorldData.TeamListConfig, battleWorldData.CopyId, list, dictionary, 0, battleData, !battleWorldData.isMutil, monsterCountDic)))
		{
			battleData.Close();
			LoadingFinish(success: false);
		}
		return battleData;
	}

	protected async UniTask PreloadGameData(PreloadBattleData battleData)
	{
		if (!(await _gamePreload.LoadGameAsset(battleData)))
		{
			battleData.Close();
			LoadingFinish(success: false);
		}
		else
		{
			worldData.PreloadBattleData = battleData;
		}
	}

	protected async UniTask<bool> LoadScene(string sceneName, LoadSceneMode loadSceneMode = LoadSceneMode.Additive)
	{
		loadingSceneFinish = false;
		loadingSceneSuccess = false;
		await UniTask.DelayFrame(1);
		GameEntry.Resource.UnloadUnusedAssets(performGCCollect: true, unloadResourceUnusedAssets: true);
		await UniTask.DelayFrame(10);
		GameEntry.Scene.LoadScene(AssetUtility.GetSceneAsset(sceneName), loadSceneMode, new LoadSceneCallbacks(LoadSceneSuccessCallback, LoadSceneFailureCallback, LoadSceneUpdateCallback));
		await UniTask.WaitUntil(() => loadingSceneFinish);
		if (loadingSceneSuccess)
		{
			GraphicsSetting instance = Singleton<GraphicsSetting>.Instance;
			Volume[] vols = instance.GetVolumes();
			if (sceneName == "Outer/Outer")
			{
				instance.HighResolution();
				instance.DisableAntiAliasing(in vols);
				instance.DisableBloom(in vols);
				instance.IsOuterScene = true;
			}
			else
			{
				instance.IsOuterScene = false;
				instance.ResumeResolution();
				instance.EnableAntiAliasing(in vols);
				instance.EnableBloom(in vols);
			}
		}
		return loadingSceneSuccess;
	}

	protected async UniTask<bool> UnloadScene(string sceneName)
	{
		unloadSceneFinish = false;
		unloadSceneSuccess = false;
		GameEntry.Scene.UnloadScene(AssetUtility.GetSceneAsset(sceneName), new UnloadSceneCallbacks(UnloadSceneSuccessCallback, UnloadSceneFailureCallback));
		await UniTask.WaitUntil(() => unloadSceneFinish);
		await UniTask.DelayFrame(1);
		GameEntry.Resource.UnloadUnusedAssets(performGCCollect: true, unloadResourceUnusedAssets: true);
		await UniTask.DelayFrame(10);
		return unloadSceneSuccess;
	}

	private void LoadSceneUpdateCallback(string sceneAssetName, float progress, object userdata)
	{
		progressBar.UpdateLoadingData("SceneLoading", Mathf.CeilToInt(progress * 100f));
	}

	private void LoadSceneFailureCallback(string sceneAssetName, LoadResourceStatus status, string errormessage, object userdata)
	{
		loadingSceneSuccess = false;
		loadingSceneFinish = true;
	}

	private void LoadSceneSuccessCallback(string sceneAssetName, float duration, object userdata)
	{
		progressBar.UpdateLoadingData("SceneLoading", 100);
		loadingSceneSuccess = true;
		loadingSceneFinish = true;
	}

	private void UnloadSceneFailureCallback(string sceneAssetName, object userdata)
	{
		unloadSceneSuccess = false;
		unloadSceneFinish = true;
	}

	private void UnloadSceneSuccessCallback(string sceneAssetName, object userdata)
	{
		unloadSceneSuccess = true;
		unloadSceneFinish = true;
	}
}
