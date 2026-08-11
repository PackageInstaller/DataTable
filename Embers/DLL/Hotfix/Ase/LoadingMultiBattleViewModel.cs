#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingMultiBattleViewModel : LoadingSceneViewModel
{
	protected string previousSceneName;

	protected bool autoUnloadPreviousScene;

	protected List<PlayerLoadingViewModel> playerLoadingVMs;

	protected LoadingExceptionEnum loadingException = LoadingExceptionEnum.BeforeUnloadOuter;

	private uint _worldId;

	public List<PlayerLoadingViewModel> PlayerLoadingVMs => playerLoadingVMs;

	public LoadingExceptionEnum LoadingException => loadingException;

	public LoadingMultiBattleViewModel()
	{
	}

	public LoadingMultiBattleViewModel(string preSceneName, bool autoUnload, WorldData worldData, List<TeamMember> teamList)
	{
		worldData.isMutil = true;
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		playerLoadingVMs = new List<PlayerLoadingViewModel>();
		base.worldData = worldData;
		foreach (TeamMember team in teamList)
		{
			PlayerLoadingViewModel playerLoadingViewModel = new PlayerLoadingViewModel(team, isReconnect: false);
			if (playerLoadingViewModel.TeamMember.IsSelf)
			{
				base.ProgressBar.AddProgressChanged(playerLoadingViewModel.UpdateProgress);
			}
			else
			{
				playerLoadingViewModel.UpdateTeammateProgress();
			}
			playerLoadingVMs.Add(playerLoadingViewModel);
		}
	}

	public override async void Load()
	{
		PreloadBattleData battleData = await CheckPreloadGameData(worldData as BattleWorldData);
		progressBar.Progress = 0f;
		progressBar.Enable = true;
		if (!(await LoadScene(worldData.SceneLoadPath)))
		{
			Log.Error("加载战斗场景【" + worldData.WorldName + "】失败.");
			LoadingFinish(success: false);
			return;
		}
		await PreloadGameData(battleData);
		for (int i = 0; i < playerLoadingVMs.Count; i++)
		{
			if (playerLoadingVMs[i].TeamMember.IsSelf)
			{
				playerLoadingVMs[i].SendRate(100);
			}
		}
		Game.AddSingleton<GameSystem>();
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		if (!(worldData is LockstepBattleWorldData lockstepBattleWorldData))
		{
			Log.Error("多人加载错误： lockstepBattleWorldData == null");
			return;
		}
		lockstepBattleWorldData.GameStartAction = GameStart;
		lockstepBattleWorldData.LostConnectAction = BattleForceEndLoading;
		UIWindowHelper.WindowRelease();
		await Task.Delay(300);
		_worldId = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Lockstep, SceneManager.GetSceneByName(worldData.WorldName), worldData);
		if (_worldId == 0)
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
		IAccountService accountserver = Singleton<ServiceSystem>.Instance.GetService<IAccountService>();
		await UniTask.WaitUntil(() => !accountserver.IsLogin || loadingFinish);
		if (!loadingFinish)
		{
			BattleForceEndLoading();
		}
	}

	protected override async UniTask LoadBanks()
	{
		await AudioHelper.LoadBanksByType(2);
	}

	private void GameStart()
	{
		_ = KCPLog.Open;
		DoLoadingFinish();
	}

	protected override void OnLoadingClosed()
	{
		if (loadingSuccess)
		{
			Singleton<GameSystem>.Instance.WorldStart(_worldId);
		}
	}

	protected override async Task OnCloseLoadWindow()
	{
		if (loadingSuccess)
		{
			await Singleton<GameSystem>.Instance.WorldStartBefore(_worldId);
		}
	}

	protected void BattleForceEndLoading()
	{
		loadingException = LoadingExceptionEnum.Unknow;
		loadingFinish = true;
		loadingSuccess = false;
	}
}
