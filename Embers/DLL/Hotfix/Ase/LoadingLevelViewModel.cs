#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingLevelViewModel : LoadingBattleViewModelBase
{
	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	public LoadingLevelViewModel(string preSceneName, bool autoUnload, WorldData worldData)
	{
		base.worldData = worldData;
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
	}

	public override async void Load()
	{
		base.ProgressBar.Enable = true;
		Game.AddSingleton<MathTriggerSystem>();
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			Game.RemoveSingleton<MathTriggerSystem>();
			LoadingFinish(success: false);
			return;
		}
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Story, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		if (worldId == 0)
		{
			Game.RemoveSingleton<GameSystem>();
			Game.RemoveSingleton<MathTriggerSystem>();
			if (!(await UnloadScene(worldData.SceneLoadPath)))
			{
				Log.Error("创建战斗失败. 卸载战斗场景【" + worldData.WorldName + "】失败.");
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
			int playerMark = ((LevelWorldData)worldData)?.LevelId ?? 0;
			Singleton<ServiceSystem>.Instance.GetService<IMapService>()?.SetPlayerMark(playerMark);
			LoadingFinish();
		}
	}

	protected override async UniTask LoadBanks()
	{
		LevelWorldData levelWorldData = worldData as LevelWorldData;
		DRLevel level = GameEntry.DataTable.GetDataRow<DRLevel>(levelWorldData.LevelId);
		if (level != null)
		{
			DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => level.BankGroups.Contains(data.Id));
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				await AudioHelper.LoadBanksByGroup(array[num]);
			}
		}
	}
}
