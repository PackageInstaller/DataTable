using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityPacksChainView : ActivityViewBase
{
	[SerializeField]
	private LoopListView2 loopListView2;

	[SerializeField]
	private GameObject buyAllPart;

	[SerializeField]
	private GameObject buyTipsPart;

	[SerializeField]
	private TextMeshProUGUI buyTips;

	[SerializeField]
	private Button btnBuyAll;

	[SerializeField]
	private Image priceIcon;

	[SerializeField]
	private GameObject cashPriceIcon;

	[SerializeField]
	private TextMeshProUGUI curPriceText;

	[SerializeField]
	private TextMeshProUGUI oriPriceText;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private Button btnOpenRule;

	[SerializeField]
	private Button btnCloseRule;

	[SerializeField]
	private GameObject rulePanel;

	private ActivityPacksChainViewModel _viewModel;

	private int _curItemIndex = -1;

	public override void Init(ActivityViewModelBase viewModel)
	{
		_viewModel = (ActivityPacksChainViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ActivityPacksChainView, ActivityPacksChainViewModel> bindingSet = this.CreateBindingSet((ActivityPacksChainViewModel)viewModel);
		bindingSet.Bind(buyAllPart).For((GameObject v) => v.activeSelf).To((ActivityPacksChainViewModel vm) => vm.ShowBuyAll);
		bindingSet.Bind<TextMeshProUGUI>(buyTips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPacksChainViewModel vm) => vm.BuyTips);
		bindingSet.Bind(buyTipsPart).For((GameObject v) => v.activeSelf).ToExpression((ActivityPacksChainViewModel vm) => !string.IsNullOrEmpty(vm.BuyTips));
		bindingSet.Bind(btnBuyAll).For((Button v) => v.onClick).To((ActivityPacksChainViewModel vm) => vm.BuyCmd)
			.CommandParameter(null);
		bindingSet.Bind(priceIcon).For((Image v) => v.sprite).To((ActivityPacksChainViewModel vm) => vm.PriceIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(priceIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ActivityPacksChainViewModel vm) => !string.IsNullOrEmpty(vm.PriceIcon) && !vm.AllBought);
		bindingSet.Bind(cashPriceIcon).For((GameObject v) => v.activeSelf).ToExpression((ActivityPacksChainViewModel vm) => vm.IsCashPrice && !vm.AllBought);
		bindingSet.Bind<TextMeshProUGUI>(curPriceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPacksChainViewModel vm) => vm.CurPriceText);
		bindingSet.Bind<TextMeshProUGUI>(oriPriceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPacksChainViewModel vm) => vm.OriPriceText);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPacksChainViewModel vm) => vm.Desc);
		bindingSet.Build();
		loopListView2.InitListView(_viewModel.ItemDataList.Count, OnGetItemByIndex);
		_curItemIndex = _viewModel.ItemDataList.FindIndex((ActivityPacksChainItemData p) => p.Unlock && !p.Bought);
		if (_curItemIndex >= 0)
		{
			loopListView2.MovePanelToItemIndex(_curItemIndex, 0f);
		}
		btnOpenRule.onClick.AddListener(delegate
		{
			rulePanel.SetActive(value: true);
		});
		btnCloseRule.onClick.AddListener(delegate
		{
			rulePanel.SetActive(value: false);
		});
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.ItemDataList.Count)
		{
			return null;
		}
		ActivityPacksChainItemData activityPacksChainItemData = _viewModel.ItemDataList[index];
		if (activityPacksChainItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityPacksChainItem");
		ActivityPacksChainItem component = loopListViewItem.GetComponent<ActivityPacksChainItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(activityPacksChainItemData);
		}
		else
		{
			component.RefreshData(activityPacksChainItemData);
		}
		return loopListViewItem;
	}
}
