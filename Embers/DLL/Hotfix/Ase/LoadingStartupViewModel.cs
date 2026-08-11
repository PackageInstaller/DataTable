#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class LoadingStartupViewModel : LoadingSceneViewModel
{
	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	private readonly bool battleExit;

	private const string USER_DATA_UNREGISTER_KEY = "UserDataUnresgister";

	private const string USER_LOGOUT_KEY = "UserLogout";

	private const string UNLOADSCENE_KEY = "UnloadScene";

	private const string BASE_PGS_KEY = "BaseProgress";

	private bool hasTask;

	private UIDViewModel uidVM;

	private Func<bool, UniTask> loadTask;

	public LoadingStartupViewModel(string preSceneName, bool autoUnload, bool battleExit)
	{
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		progressBar.AddLoadingData("BaseProgress", 100);
		progressBar.AddLoadingData("UserDataUnresgister", 100);
		progressBar.AddLoadingData("UserLogout", 100);
		progressBar.AddLoadingData("UnloadScene", 100);
		this.battleExit = battleExit;
	}

	public LoadingStartupViewModel(string preSceneName, bool autoUnload, bool battleExit, Func<bool, UniTask> loadTask)
	{
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		progressBar.AddLoadingData("BaseProgress", 100);
		progressBar.AddLoadingData("UserDataUnresgister", 100);
		progressBar.AddLoadingData("UserLogout", 100);
		progressBar.AddLoadingData("UnloadScene", 100);
		this.battleExit = battleExit;
		this.loadTask = loadTask;
		hasTask = true;
	}

	public override async void Load()
	{
		uidVM = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.UidVM;
		Singleton<Story>.Instance.CloseNetworkNotify();
		Singleton<GuidanceManager>.Instance.CloseNetworkNotify();
		progressBar.Progress = 0f;
		progressBar.Enable = true;
		progressBar.UpdateLoadingData("BaseProgress", 100);
		progressBar.UpdateLoadingData("UserLogout", 100);
		await Task.Delay(100);
		Singleton<ServiceSystem>.Instance.GetService<IAccountService>().UnSubscribeNetworkNotify();
		if (hasTask && loadTask != null)
		{
			await loadTask(arg: false);
		}
		if (autoUnloadPreviousScene && !string.IsNullOrEmpty(previousSceneName) && !(await UnloadScene(previousSceneName)))
		{
			Log.Error("离开战斗. 卸载前置场景【" + previousSceneName + "】失败.");
		}
		progressBar.UpdateLoadingData("UnloadScene", 100);
		await Task.Delay(100);
		Game.RemoveSingleton<OuterSystem>();
		Singleton<ServiceSystem>.Instance.GetService<IGameNewsTipService>()?.ClearNewsTipWindow();
		Singleton<ServiceSystem>.Instance.UnregisterSystemService();
		progressBar.UpdateLoadingData("UserDataUnresgister", 100);
		await Task.Delay(100);
		progressBar.ForceFinish();
		LoadingFinish();
	}

	protected override async Task OnCloseLoading()
	{
		UIWindowHelper.WindowReleaseAll();
		if (uidVM != null)
		{
			uidVM.Close();
		}
	}
}
