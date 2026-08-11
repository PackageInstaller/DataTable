#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingActivitiyBattleViewModel : LoadingBattleViewModelBase
{
	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	public LoadingActivitiyBattleViewModel(string preSceneName, WorldData worldData, bool autoUnload, bool autoLoad = true)
		: base(worldData, autoLoad)
	{
		if (worldData is ActivityBattleWorldData activityBattleWorldData)
		{
			worldData.isMutil = activityBattleWorldData.worldMode == BattleWorldMode.SyncBattle;
		}
		base.worldData = worldData;
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
	}

	public override async void Load()
	{
		PreloadBattleData battleData = await CheckPreloadGameData(worldData as ActivityBattleWorldData);
		base.ProgressBar.Enable = true;
		await LoadBanks();
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			LoadingFinish(success: false);
			return;
		}
		await PreloadGameData(battleData);
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		ActivityBattleWorldData activityBattleWorldData = worldData as ActivityBattleWorldData;
		if (activityBattleWorldData.worldMode == BattleWorldMode.SingleBattle)
		{
			worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Battle, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		}
		else if (activityBattleWorldData.worldMode == BattleWorldMode.SyncBattle)
		{
			worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Lockstep, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		}
		if (worldId == 0)
		{
			Game.RemoveSingleton<GameSystem>();
			if (!(await UnloadScene(worldData.SceneLoadPath)))
			{
				Debug.LogError("创建战斗失败. 卸载战斗场景【" + worldData.WorldName + "】失败.");
			}
			await UniTask.Delay(TimeSpan.FromSeconds(1.0));
			LoadingFinish(success: false);
		}
		else
		{
			if (autoUnloadPreviousScene && !string.IsNullOrEmpty(previousSceneName) && !(await UnloadScene(previousSceneName)))
			{
				Log.Error("进入战斗. 卸载前置场景【" + previousSceneName + "】失败.");
			}
			LoadingFinish();
		}
	}
}
