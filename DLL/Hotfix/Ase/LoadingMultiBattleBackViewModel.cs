#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingMultiBattleBackViewModel : LoadingMultiBattleViewModel
{
	private const string USER_DATA_LOADING_KEY = "Reconnection";

	public LoadingMultiBattleBackViewModel(string preSceneName, bool autoUnload, WorldData worldData, List<TeamMember> teamList)
	{
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		playerLoadingVMs = new List<PlayerLoadingViewModel>();
		base.worldData = worldData;
		foreach (TeamMember team in teamList)
		{
			PlayerLoadingViewModel playerLoadingViewModel = new PlayerLoadingViewModel(team, isReconnect: true);
			if (playerLoadingViewModel.TeamMember.IsSelf)
			{
				base.ProgressBar.AddProgressChanged(playerLoadingViewModel.UpdateProgress);
			}
			else
			{
				playerLoadingViewModel.Progress = 100;
			}
			playerLoadingVMs.Add(playerLoadingViewModel);
		}
	}

	public override async void Load()
	{
		PreloadBattleData battleData = await CheckPreloadGameData(worldData as BattleWorldData);
		progressBar.Progress = 0f;
		progressBar.Enable = true;
		progressBar.AddLoadingData("Reconnection", 100);
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			Log.Error("加载战斗场景【" + worldData.WorldName + "】失败.");
			LoadingFinish(success: false);
			return;
		}
		await PreloadGameData(battleData);
		UIWindowHelper.WindowRelease();
		Game.AddSingleton<GameSystem>();
		if (!(worldData is LockstepBattleWorldData lockstepBattleWorldData))
		{
			Log.Error("多人重连加载错误 ： LockstepBattleWorldData == null... ");
			return;
		}
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		lockstepBattleWorldData.UpdateProgressAction = UpdateProgress;
		lockstepBattleWorldData.LostConnectAction = base.BattleForceEndLoading;
		uint worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Lockstep, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		if (worldId == 0)
		{
			Game.RemoveSingleton<GameSystem>();
			if (!(await UnloadScene(worldData.SceneLoadPath)))
			{
				Log.Error("创建战斗失败. 卸载战斗场景【" + worldData.WorldName + "】失败.");
			}
			await UniTask.Delay(TimeSpan.FromSeconds(1.0));
			LoadingFinish(success: false);
			return;
		}
		if (autoUnloadPreviousScene && !string.IsNullOrEmpty(previousSceneName) && !(await UnloadScene(previousSceneName)))
		{
			Log.Error("进入战斗. 卸载前置场景【" + previousSceneName + "】失败.");
		}
		loadingException = LoadingExceptionEnum.None;
		Log.Error("Loading处理已结束");
		Singleton<GameSystem>.Instance.WorldStart(worldId);
		IAccountService accountserver = Singleton<ServiceSystem>.Instance.GetService<IAccountService>();
		await UniTask.WaitUntil(() => !accountserver.IsLogin || loadingFinish);
		if (!loadingFinish)
		{
			BattleForceEndLoading();
		}
		Resources.UnloadUnusedAssets();
		GC.Collect();
	}

	private void UpdateProgress(int currentProgress, int totalProgress)
	{
		if (!(worldData is LockstepBattleWorldData lockstepBattleWorldData))
		{
			Log.Error("多人重连加载错误 ： LockstepBattleWorldData == null... ");
			return;
		}
		if (currentProgress == totalProgress)
		{
			lockstepBattleWorldData.LostConnectAction = (Action)Delegate.Remove(lockstepBattleWorldData.LostConnectAction, new Action(base.BattleForceEndLoading));
			DoLoadingFinish();
		}
		float num = Mathf.Round((float)currentProgress * 1f / (float)totalProgress * 100f) / 100f;
		progressBar.UpdateLoadingData("Reconnection", Mathf.CeilToInt(num * 100f));
	}
}
