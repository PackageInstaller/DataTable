#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingGuideLevelViewModel : LoadingBattleViewModelBase
{
	public static int[] heroIdDic = new int[2] { 6101, 61011 };

	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	private readonly int storyId;

	private readonly List<int> heroIds;

	private readonly bool loadUserData;

	private const string USER_DATA_LOADING_KEY = "UserDataLoading";

	public static LoadingGuideLevelViewModel CreateGuideFirstStep(int characterIndex)
	{
		DRLevel dataRow = GameEntry.DataTable.GetDataRow<DRLevel>(10);
		int num = 500001;
		List<int> list = new List<int> { heroIdDic[characterIndex] };
		return new LoadingGuideLevelViewModel(LevelWorldData.CreateLevelWorldData(0u, dataRow.SceneName, dataRow.Id, dataRow.MapData, dataRow.DefaultActiveBonfire.ToString(), dataRow.NavMeshId, null), list, "Outer/Outer", autoUnload: false, loadUserData: true, num);
	}

	public static LoadingGuideLevelViewModel CreateGuideSecondStep(string previousSceneName)
	{
		DRLevel dataRow = GameEntry.DataTable.GetDataRow<DRLevel>(100);
		List<int> list = new List<int> { 1104, 1005 };
		return new LoadingGuideLevelViewModel(LevelWorldData.CreateLevelWorldData(0u, dataRow.SceneName, dataRow.Id, dataRow.MapData, dataRow.DefaultActiveBonfire.ToString(), dataRow.NavMeshId, null), list, previousSceneName, autoUnload: true, loadUserData: false);
	}

	public static LoadingGuideLevelViewModel CreateGuideThirdStep()
	{
		DRLevel dataRow = GameEntry.DataTable.GetDataRow<DRLevel>(100);
		List<int> list = new List<int> { 1104, 1005 };
		return new LoadingGuideLevelViewModel(LevelWorldData.CreateLevelWorldData(0u, dataRow.SceneName, dataRow.Id, dataRow.MapData, dataRow.DefaultActiveBonfire.ToString(), dataRow.NavMeshId, null), list, "Outer/Outer", autoUnload: false);
	}

	public LoadingGuideLevelViewModel(WorldData worldData, List<int> heroIds, string preSceneName, bool autoUnload, bool loadUserData = true, int storyId = 0)
	{
		base.worldData = worldData;
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		this.storyId = storyId;
		this.loadUserData = loadUserData;
		this.heroIds = heroIds;
		progressBar.AddLoadingData("UserDataLoading", 900);
	}

	public override async void Load()
	{
		if (loadUserData)
		{
			Game.AddSingleton<OuterSystem>();
		}
		base.ProgressBar.Enable = true;
		Game.AddSingleton<MathTriggerSystem>();
		bool flag = loadUserData;
		if (flag)
		{
			flag = !(await RequestUserData());
		}
		if (flag)
		{
			LoadingFinish(success: false);
			Game.RemoveSingleton<OuterSystem>();
			Game.RemoveSingleton<MathTriggerSystem>();
			return;
		}
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			LoadingFinish(success: false);
			Game.RemoveSingleton<OuterSystem>();
			Game.RemoveSingleton<MathTriggerSystem>();
			return;
		}
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		if (heroIds.Count > 0)
		{
			List<PeripheryHeroData> list = new List<PeripheryHeroData>();
			for (int i = 0; i < heroIds.Count; i++)
			{
				PeripheryHeroData peripheryHeroData = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroIds[i], emptyCreateNew: true, saveNew: false).GetPeripheryHeroData(0L);
				list.Add(peripheryHeroData);
			}
			worldData.TeamListConfig = list;
		}
		worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Story, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		if (worldId == 0)
		{
			Game.RemoveSingleton<OuterSystem>();
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

	public override void Close()
	{
		base.Close();
	}

	private async UniTask<bool> RequestUserData()
	{
		try
		{
			return await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().RequestAccountData(delegate(int progress)
			{
				progressBar.AddProgress("UserDataLoading", progress);
			});
		}
		catch (Exception ex)
		{
			Log.Error("加载用户数据失败. e = " + ex.Message + " \n" + ex.StackTrace);
			return false;
		}
	}
}
