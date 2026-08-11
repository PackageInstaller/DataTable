using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class ShopGiftPackWindow : PropExchangeView
{
	[SerializeField]
	private LoopGridView packItemList;

	[SerializeField]
	private GameObject limitObj;

	private PropExchangeViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<PropExchangeViewModel>(userData);
		BindingSet<ShopGiftPackWindow, PropExchangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(limitObj).For((GameObject v) => v.activeSelf).ToExpression((PropExchangeViewModel vm) => !vm.LimitExchangeText.Equals(""));
		bindingSet.Bind(this).For((ShopGiftPackWindow v) => v.ChangeVisibility).To((PropExchangeViewModel vm) => vm.VisibleRequest);
		bindingSet.Build();
		packItemList.InitGridView(viewModel.PropPackItemViewModelList.Count, OnGetPackItemByIndex);
	}

	protected override void OnVisibilityChanged()
	{
		base.OnVisibilityChanged();
		if (viewModel != null)
		{
			packItemList.SetListItemCount(viewModel.PropPackItemViewModelList.Count);
			packItemList.RefreshAllShownItem();
		}
	}

	private void ChangeVisibility(object sender, InteractionEventArgs e)
	{
		Visibility = (bool)sender;
	}

	private LoopGridViewItem OnGetPackItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		PropPackItemViewModel propPackItemViewModel = viewModel.PropPackItemViewModelList[index];
		if (propPackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = packItemList.NewListViewItem("PackItem");
		PropPackItem component = loopGridViewItem.GetComponent<PropPackItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(propPackItemViewModel);
		}
		else
		{
			component.RefreshData(propPackItemViewModel);
		}
		return loopGridViewItem;
	}
}
