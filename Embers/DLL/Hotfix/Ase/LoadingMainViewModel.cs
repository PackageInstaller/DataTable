#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class LoadingMainViewModel : LoadingSceneViewModel
{
	private bool loadUserData;

	private const string USER_DATA_LOADING_KEY = "UserDataLoading";

	public LoadingMainViewModel(bool loadUserData = false, bool autoLoad = true)
		: base(null, autoLoad)
	{
		this.loadUserData = loadUserData;
	}

	public LoadingMainViewModel()
	{
		progressBar.AddLoadingData("UserDataLoading", 900);
	}

	public override async void Load()
	{
		Game.AddSingleton<OuterSystem>();
		progressBar.Progress = 0f;
		progressBar.Enable = true;
		if (!(await RequestUserData()))
		{
			Game.RemoveSingleton<OuterSystem>();
			LoadingFinish(success: false);
		}
		else if (!(await LoadScene("Outer/Outer")))
		{
			LoadingFinish(success: false);
			Game.RemoveSingleton<OuterSystem>();
		}
		else
		{
			progressBar.ForceFinish();
			LoadingFinish();
		}
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

	protected override async UniTask LoadBanks()
	{
		await AudioHelper.LoadBanksByType(1);
	}
}
