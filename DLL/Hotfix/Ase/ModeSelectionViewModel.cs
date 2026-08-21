using Cysharp.Threading.Tasks;

namespace Ase;

public class ModeSelectionViewModel : OptionBase
{
	public async void OnBtnEnterClick(WorldData worldData)
	{
		LoadingGameOnlyViewModel loadViewModel = new LoadingGameOnlyViewModel(worldData);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
		loadViewModel.SetRandomLoadingTap(randomLoadingTap);
		await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadViewModel);
		await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
		_ = loadViewModel.LoadingSuccess;
		if (loadViewModel.LoadingSuccess)
		{
			dismissRequest.Raise();
			await loadViewModel.CloseLoading();
		}
		TeamMember teamMember = worldData.TeamMemberList[0];
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroData(teamMember.HeroModel.Id, teamMember.HeroModel);
	}

	public void SetRandom()
	{
	}
}
