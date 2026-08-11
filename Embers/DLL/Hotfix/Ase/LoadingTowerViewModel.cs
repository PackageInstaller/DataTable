#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingTowerViewModel : LoadingBattleViewModelBase
{
	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	public LoadingTowerViewModel(string preSceneName, bool autoUnload, WorldData worldData)
	{
		base.worldData = worldData;
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
	}

	public override async void Load()
	{
		base.ProgressBar.Enable = true;
		if (previousSceneName != worldData.SceneLoadPath && !(await LoadScene(worldData.SceneLoadPath)))
		{
			Game.RemoveSingleton<MathTriggerSystem>();
			LoadingFinish(success: false);
			return;
		}
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.ClimbTower, SceneManager.GetSceneByName(worldData.WorldName), worldData);
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
			if (autoUnloadPreviousScene && !string.IsNullOrEmpty(previousSceneName) && previousSceneName != worldData.SceneLoadPath && !(await UnloadScene(previousSceneName)))
			{
				Log.Error("进入战斗. 卸载前置场景【" + previousSceneName + "】失败.");
			}
			LoadingFinish();
		}
	}

	protected override async UniTask LoadBanks()
	{
		await AudioHelper.LoadBanksByType(2);
	}
}
