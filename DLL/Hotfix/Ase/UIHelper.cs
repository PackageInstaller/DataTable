using Cysharp.Threading.Tasks;

namespace Ase;

public static class UIHelper
{
	public static async UniTask RequestData()
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RequestUsedEquipmentData();
		await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().RequestServiceData();
		await ServiceHelper.RequestDataInPropTable();
		await Singleton<ServiceSystem>.Instance.GetService<ITeamService>().InitTeamData();
		await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RequestUnusedEquipmentData();
		loading.Dispose();
	}

	public static async UniTask RequestDataWithKeepBottomView()
	{
		await RequestData();
		if (Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() != GameProcessType.Outer)
		{
			UIWindowHelper.ReleaseWindowKeepBattleView();
		}
		else
		{
			UIWindowHelper.ReleaseWindowKeepMainView();
		}
	}

	public static async UniTask AccountDisconnect()
	{
		Singleton<ServiceSystem>.Instance.GetService<IAccountService>().OnAccountDisconnect(1);
	}
}
