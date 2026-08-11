#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingToOtherLevelViewModel : LoadingBattleViewModelBase
{
	private string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	private readonly int storyId;

	private List<OptionBase> closeViews = new List<OptionBase>();

	private LevelWorldData _levelWorldData;

	public LoadingToOtherLevelViewModel()
	{
		_levelWorldData = new LevelWorldData();
		worldData = _levelWorldData;
		worldData.WorldId = 0u;
		autoUnloadPreviousScene = true;
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
				Log.Error("创建关卡失败. 卸载关卡场景【" + worldData.WorldName + "】失败.");
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
			Singleton<ServiceSystem>.Instance.GetService<IMapService>()?.SetPlayerMark(_levelWorldData.LevelId);
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

	public void SetBonfireKey(string bornFireKey)
	{
		_levelWorldData.BonfireKey = bornFireKey;
	}

	public void SetLevelData(DRLevel drLevel)
	{
		worldData.WorldName = drLevel.SceneName;
		worldData.SceneLoadPath = "Level/" + drLevel.SceneName;
		worldData.MapDataName = drLevel.MapData;
		worldData.NavMeshId = drLevel.NavMeshId;
		worldData.RandomSeed = UnityEngine.Random.Range(0, 100);
		_levelWorldData.LevelId = drLevel.Id;
	}

	public void SetPreviousScene(string worldName)
	{
		previousSceneName = worldName;
	}

	public void SetTeamList(List<PeripheryHeroData> teamConfig)
	{
		worldData.TeamListConfig = teamConfig;
	}

	public void AddCloseView(OptionBase optionBase)
	{
		closeViews.Add(optionBase);
	}

	public bool CheckNeedLoading(int levelId)
	{
		return _levelWorldData.LevelId != levelId;
	}

	public string GetBornfireKey()
	{
		return _levelWorldData.BonfireKey;
	}

	public void CloseViews()
	{
		foreach (OptionBase closeView in closeViews)
		{
			closeView.Close();
		}
	}
}
