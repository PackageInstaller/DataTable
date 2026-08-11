#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingToNextBattleViewModel : LoadingBattleViewModelBase
{
	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	public LoadingToNextBattleViewModel(string preSceneName, bool autoUnload, WorldData worldData)
	{
		base.worldData = worldData;
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
	}

	public override async void Load()
	{
		base.ProgressBar.Enable = true;
		if (autoUnloadPreviousScene && !string.IsNullOrEmpty(previousSceneName) && !(await UnloadScene(previousSceneName)))
		{
			Log.Error("离开战斗. 卸载前置场景【" + previousSceneName + "】失败.");
		}
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RemoveGetBPListener();
		PreloadBattleData battleData = await CheckPreloadGameData(worldData as BattleWorldData);
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			LoadingFinish(success: false);
			return;
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(worldData.SceneLoadPath);
		await PreloadGameData(battleData);
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Battle, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		if (worldId == 0)
		{
			Game.RemoveSingleton<GameSystem>();
			if (!(await UnloadScene(worldData.SceneLoadPath)))
			{
				Log.Error("创建战斗失败. 卸载战斗场景【" + worldData.WorldName + "】失败.");
			}
			await UniTask.Delay(TimeSpan.FromSeconds(1.0));
			LoadingFinish(success: false);
		}
		else
		{
			progressBar.ForceFinish();
			LoadingFinish();
		}
	}

	protected override async UniTask LoadBanks()
	{
		await AudioHelper.LoadBanksByType(2);
	}
}
