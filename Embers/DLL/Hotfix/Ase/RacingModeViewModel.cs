using Cysharp.Threading.Tasks;

namespace Ase;

public class RacingModeViewModel : OptionBase
{
	public async void OnBtnEnterClick(WorldData worldData)
	{
		LoadingGameOnlyViewModel loadViewModel = new LoadingGameOnlyViewModel(worldData);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
		loadViewModel.SetRandomLoadingTap(randomLoadingTap);
		await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadViewModel);
		await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
		bool loadingSuccess = loadViewModel.LoadingSuccess;
		if (loadViewModel.LoadingSuccess)
		{
			dismissRequest.Raise();
			await loadViewModel.CloseLoading();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
	}
}
