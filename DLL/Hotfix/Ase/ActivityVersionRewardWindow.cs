using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class ActivityVersionRewardWindow : UGuiWindow
{
	public VersionMoneyView propItem;

	public Button btnBack;

	public TabItemNormal itemTask;

	public TabItemNormal itemShop;

	public ActivityShopView shopView;

	public ActivityPointsView pointsTaskView;

	private ActivityVersionRewardViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ActivityVersionRewardViewModel>();
		BindingSet<ActivityVersionRewardWindow, ActivityVersionRewardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ActivityVersionRewardViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((ActivityVersionRewardWindow v) => v.OnVisibleChanged).To((ActivityVersionRewardViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((ActivityVersionRewardWindow v) => v.OnDismissRequest).To((ActivityVersionRewardViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ActivityVersionRewardWindow v) => v.OpenUguiWindow).To((ActivityVersionRewardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((ActivityVersionRewardWindow v) => v.SetChildViewVisibility).To((ActivityVersionRewardViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind().For((ActivityVersionRewardWindow v) => v.ChangeViewRst).To((ActivityVersionRewardViewModel vm) => vm.ChangeViewRst);
		bindingSet.Build();
		itemTask.Init(viewModel.GetTabById(1));
		itemShop.Init(viewModel.GetTabById(2));
		LoadProp();
		shopView.Init(viewModel.ShopViewModel);
		pointsTaskView.Init(viewModel.ActivityPointsViewModel);
		ChangeView(1);
	}

	private void ChangeViewRst(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context is int tabId)
		{
			ChangeView(tabId);
		}
	}

	private async void ChangeView(int tabId)
	{
		pointsTaskView.Alpha = ((tabId == 1) ? 1 : 0);
		pointsTaskView.CanvasGroup.blocksRaycasts = tabId == 1;
		if (tabId == 2)
		{
			await viewModel.ShopViewModel.OnOpen();
		}
		shopView.Alpha = ((tabId == 2) ? 1 : 0);
		shopView.CanvasGroup.blocksRaycasts = tabId == 2;
	}

	private void LoadProp()
	{
		VersionMoneyViewModel prop = viewModel.GetProp(propItem.id);
		if (prop != null)
		{
			propItem.Init(prop);
		}
	}
}
