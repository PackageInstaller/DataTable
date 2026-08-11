using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankRewardItem : UGuiView
{
	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI rankRange;

	[SerializeField]
	private LoopListView2 rewards;

	private RankRewardItemData _viewModel;

	public void Init(RankRewardItemData data)
	{
		_viewModel = data;
		BindingSet<RankRewardItem, RankRewardItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(rankBg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((RankRewardItemData vm) => vm.ItemRank > 0);
		bindingSet.Bind(rankBg).For((Image v) => v.sprite).ToExpression((RankRewardItemData vm) => $"rank_icon_{vm.ItemRank}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(rankRange).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankRewardItemData vm) => vm.RankRange);
		bindingSet.Bind(((Component)(object)rankRange).gameObject).For((GameObject v) => v.activeSelf).ToExpression((RankRewardItemData vm) => vm.ItemRank <= 0);
		bindingSet.Build();
		rewards.InitListView(_viewModel.Rewards.Count, OnGetPropItemByIndex);
		rewards.ScrollRect.horizontal = _viewModel.Rewards.Count > 3;
	}

	public void RefreshData(RankRewardItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
		rewards.SetListItemCount(_viewModel.Rewards.Count);
		rewards.RefreshAllShownItem();
		rewards.ScrollRect.horizontal = _viewModel.Rewards.Count > 3;
	}

	private LoopListViewItem2 OnGetPropItemByIndex(LoopListView2 arg1, int itemIndex)
	{
		if (itemIndex < 0 || itemIndex > _viewModel.Rewards.Count)
		{
			return null;
		}
		PropDataBase propDataBase = _viewModel.Rewards[itemIndex];
		if (propDataBase == null || propDataBase.Empty)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = arg1.NewListViewItem("rewardItem");
		KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
		KnapsackItemViewModel viewModel = new KnapsackItemViewModel((OptionBase)_viewModel.Parent, propDataBase);
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel);
		}
		else
		{
			component.RefreshData(viewModel);
		}
		return loopListViewItem;
	}
}
