#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class LoadingService : ILoadingService
{
	private int usedBgIndex;

	private string cachedBgPath;

	private bool isLoading;

	private List<string> loadingBgPaths;

	private Sprite sprite;

	private GameProcessType curGameProcess;

	public LoadingService()
	{
		loadingBgPaths = new List<string>();
		DRLoadingTips[] dataRows = GameEntry.DataTable.GetDataRows((DRLoadingTips p) => !string.IsNullOrEmpty(p.AssetPath));
		if (dataRows != null)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				loadingBgPaths.Add(dataRows[num].AssetPath);
			}
		}
	}

	private async Task CacheBgPath()
	{
		if (loadingBgPaths.Count == 0 || loadingBgPaths.Count == 1)
		{
			Log.Error($"Loading背景图片配置数量不足 {loadingBgPaths.Count}！请检查配置！");
			Toast.ShowError($"Loading背景图片配置数量不足 {loadingBgPaths.Count}！请检查配置！");
			if (loadingBgPaths.Count == 1)
			{
				cachedBgPath = loadingBgPaths[0];
			}
		}
		int index = UnityEngine.Random.Range(usedBgIndex, loadingBgPaths.Count);
		if (cachedBgPath != null && !cachedBgPath.Equals(loadingBgPaths[index]))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(cachedBgPath));
		}
		if (cachedBgPath == null || !cachedBgPath.Equals(loadingBgPaths[index]))
		{
			cachedBgPath = loadingBgPaths[index];
			loadingBgPaths.RemoveAt(index);
			loadingBgPaths.Insert(0, cachedBgPath);
			usedBgIndex = 1;
			sprite = await GameEntry.Resource.LoadAssetAsync<Sprite>(AssetUtility.GetTextureAsset(cachedBgPath));
		}
	}

	public Sprite GetBgSprite()
	{
		return sprite;
	}

	public async Task<DRLoadingTips> PrepareLoading(GameProcessType loadingType)
	{
		curGameProcess = loadingType;
		isLoading = true;
		Singleton<SubrequestResHelper>.Instance?.OnGameProcessChanged(loadingType);
		int type = (int)((loadingType == GameProcessType.Login) ? GameProcessType.Outer : loadingType);
		DRLoadingTips[] loadingTipList = GameEntry.DataTable.GetDataRows((DRLoadingTips d) => d.Type == type);
		int index = -1;
		if (loadingTipList == null || loadingTipList.Length == 0)
		{
			Log.Error($"LoadingTips表，类型为{type}的Loading不存在!");
		}
		else
		{
			index = UnityEngine.Random.Range(0, loadingTipList.Length);
		}
		await CacheBgPath();
		return (index == -1) ? null : loadingTipList[index];
	}

	public void LoadingEnd(bool isSuccess)
	{
		isLoading = false;
		if (cachedBgPath != null)
		{
			sprite = null;
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(cachedBgPath));
		}
	}

	public bool IsLoading()
	{
		return isLoading;
	}

	public GameProcessType GetGameProcess()
	{
		return curGameProcess;
	}

	public void ResetOuter()
	{
		curGameProcess = GameProcessType.Outer;
	}

	public async UniTask BacktiTitle(string sceneName, Func<bool, UniTask> loadTask = null)
	{
		LoadingStartupViewModel loadViewModel = null;
		try
		{
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Login);
			loadViewModel = new LoadingStartupViewModel(sceneName, autoUnload: true, battleExit: false, loadTask);
			loadViewModel.SetRandomLoadingTap(randomLoadingTap);
			await (await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadViewModel)).DoShow();
			await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
			_ = loadViewModel.LoadingSuccess;
			if (loadViewModel.LoadingSuccess)
			{
				StartupWindow startWindow = await GameEntry.UI.LoadWindow<StartupWindow>("Start/StartupWindow", new StartupViewModel());
				UIWindowHelper.WindowReleaseAll();
				await loadViewModel.CloseLoading();
				startWindow.Show();
			}
		}
		catch (Exception ex)
		{
			Log.Error("返回登录界面发生异常！" + ex.Message + " / " + ex.StackTrace);
			if (loadViewModel != null)
			{
				await loadViewModel.CloseLoading();
				loadViewModel?.Close();
			}
		}
	}
}
