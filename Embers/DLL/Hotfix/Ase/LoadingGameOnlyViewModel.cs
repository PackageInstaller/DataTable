#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingGameOnlyViewModel : LoadingBattleViewModelBase
{
	public LoadingGameOnlyViewModel(WorldData worldData, bool autoLoad = true)
		: base(worldData, autoLoad)
	{
	}

	public override async void Load()
	{
		PreloadBattleData battleData = await CheckPreloadGameData(worldData as BattleWorldData);
		base.ProgressBar.Enable = true;
		base.ProgressBar.Tip = "加载中...";
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			LoadingFinish(success: false);
			return;
		}
		await PreloadGameData(battleData);
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		worldData.IsDevel = true;
		if (worldData is BattleWorldData { isMutil: not false })
		{
			worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.TestingWorld, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		}
		else
		{
			worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Battle, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		}
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
			LoadingFinish();
		}
	}

	protected override async UniTask LoadBanks()
	{
		await AudioHelper.LoadBanksByType(2);
	}
}
