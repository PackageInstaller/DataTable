using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeShopListItem : UGuiView
{
	[SerializeField]
	private Text playerName;

	[SerializeField]
	private Image headIcon;

	[SerializeField]
	private Image headFrame;

	[SerializeField]
	private LoopListView2 list;

	[SerializeField]
	private Button btnGo;

	private HomeShopListItemData _viewModel;

	public void Init(HomeShopListItemData data)
	{
		_viewModel = data;
		BindingSet<HomeShopListItem, HomeShopListItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(playerName).For((Text v) => v.text).To((HomeShopListItemData vm) => vm.PlayerName);
		bindingSet.Bind(headIcon).For((Image v) => v.sprite).To((HomeShopListItemData vm) => vm.HeadIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).To((HomeShopListItemData vm) => vm.HeadFrame)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HomeShopListItemData vm) => !vm.IsCurrentShop);
		bindingSet.Bind(btnGo).For((Button v) => v.onClick).To((HomeShopListItemData vm) => vm.OnBtnGoClick);
		bindingSet.Build();
		list.InitListView(_viewModel.GoodsData.Count, OnGetItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		_viewModel = GetUserData<HomeShopListItemData>(userData);
		this.SetDataContext(userData);
		list.SetListItemCount(_viewModel.GoodsData.Count);
		list.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.GoodsData.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("GoodsItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			KnapsackItemViewModel knapsackItemViewModel = new KnapsackItemViewModel(_viewModel.Parent, _viewModel.GoodsData[index].Prop);
			knapsackItemViewModel.IsActive = _viewModel.GoodsData[index].LeftExc > 0;
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(knapsackItemViewModel);
			}
			else
			{
				component.RefreshData(knapsackItemViewModel);
			}
		}
		return loopListViewItem;
	}
}
