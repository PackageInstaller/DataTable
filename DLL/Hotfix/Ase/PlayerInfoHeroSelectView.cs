using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerInfoHeroSelectView : UGuiView
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnInfo;

	[SerializeField]
	private Button btnShow;

	[SerializeField]
	private LoopGridView heroItemList;

	private PlayerInfoHeroSelectViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<PlayerInfoHeroSelectViewModel>(userData);
		BindingSet<PlayerInfoHeroSelectView, PlayerInfoHeroSelectViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PlayerInfoHeroSelectViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((PlayerInfoHeroSelectView v) => ((UGuiView)v).OnVisibleChanged).To((PlayerInfoHeroSelectViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((PlayerInfoHeroSelectView v) => v.UpdateList).To((PlayerInfoHeroSelectViewModel vm) => vm.UpdateListRequest);
		bindingSet.Bind(btnInfo).For((Button v) => v.onClick).To((PlayerInfoHeroSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("OnInfo");
		bindingSet.Bind(btnShow).For((Button v) => v.onClick).To((PlayerInfoHeroSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("OnShow");
		bindingSet.Build();
		heroItemList.InitGridView(viewModel.HeroItemViewModels.Count, OnGetItemByIndex);
	}

	protected override void OnEnable()
	{
		if (viewModel != null)
		{
			viewModel.Refresh();
			UpdateList(null, null);
		}
	}

	private void UpdateList(object sender, InteractionEventArgs e)
	{
		heroItemList.SetListItemCount(viewModel.HeroItemViewModels.Count);
		heroItemList.RefreshAllShownItem();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		Visibility = viewModel.IsVisible;
	}

	public LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.HeroItemViewModels.Count)
		{
			return null;
		}
		HeroItemViewModel heroItemViewModel = viewModel.HeroItemViewModels[itemIndex];
		if (heroItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("HeroItem");
		HeroItem component = loopGridViewItem.GetComponent<HeroItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(heroItemViewModel);
		}
		else
		{
			component.RefreshData(heroItemViewModel);
		}
		return loopGridViewItem;
	}
}
