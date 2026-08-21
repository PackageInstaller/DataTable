using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildApplicationWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItem recommendTab;

	[SerializeField]
	private TabItem rankTab;

	[SerializeField]
	private TabItem createTab;

	[SerializeField]
	private GuildRecommendView recommendView;

	[SerializeField]
	private GuildRecommendRankView recommendRankView;

	[SerializeField]
	private GuildCreateView createView;

	private GuildApplicationViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildApplicationViewModel>();
		BindingSet<GuildApplicationWindow, GuildApplicationViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildApplicationWindow v) => v.OnDismissRequest).To((GuildApplicationViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildApplicationWindow v) => v.OpenUguiWindow).To((GuildApplicationViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GuildApplicationViewModel vm) => vm.Close);
		bindingSet.Bind().For((GuildApplicationWindow v) => v.OnTabClick).To((GuildApplicationViewModel vm) => vm.OnTabClickRst);
		bindingSet.Build();
		Init();
	}

	private void Init()
	{
		recommendTab.Init(new TabItemData(_viewModel, 1));
		rankTab.Init(new TabItemData(_viewModel, 2));
		createTab.Init(new TabItemData(_viewModel, 3));
		if (_viewModel.CurTabIndex == 1)
		{
			recommendTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 2)
		{
			rankTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 3)
		{
			createTab.ViewModel.TabOnClick();
		}
		OnTabClick();
	}

	private async void OnTabClick(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel == null)
		{
			return;
		}
		if (_viewModel.CurTabIndex == 1 && !recommendView.IsInitHandlerCalled)
		{
			GuildRecommendViewModel guildRecommendViewModel = new GuildRecommendViewModel(_viewModel);
			recommendView.Init(guildRecommendViewModel);
			await guildRecommendViewModel.RequestRecommendDatas(1);
		}
		if (_viewModel.CurTabIndex == 2 && !recommendRankView.IsInitHandlerCalled)
		{
			GuildRecommendRankViewModel guildRecommendRankViewModel = new GuildRecommendRankViewModel(_viewModel);
			recommendRankView.Init(guildRecommendRankViewModel);
			await guildRecommendRankViewModel.RequestRankDatas();
		}
		if (_viewModel.CurTabIndex == 3 && !createView.IsInitHandlerCalled)
		{
			createView.Init(new GuildCreateViewModel(_viewModel, GuildDefinition.Flag.Freedom, GuildDefinition.GetMinLevelForApply(), GuildDefinition.AuditType.ManualAudit));
		}
		recommendView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 1) ? 1 : 0);
		recommendView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 1;
		recommendRankView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 2) ? 1 : 0);
		recommendRankView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 2;
		createView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 3) ? 1 : 0);
		createView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 3;
		switch (_viewModel.CurTabIndex)
		{
		case 1:
		{
			Animator component2 = recommendView.GetComponent<Animator>();
			if (component2 != null)
			{
				component2.SetTrigger("enter");
			}
			break;
		}
		case 2:
		{
			Animator component3 = recommendRankView.GetComponent<Animator>();
			if (component3 != null)
			{
				component3.SetTrigger("enter");
			}
			break;
		}
		case 3:
		{
			Animator component = createView.GetComponent<Animator>();
			if (component != null)
			{
				component.SetTrigger("enter");
			}
			break;
		}
		}
	}
}
