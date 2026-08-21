using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityRewardSliderView : UGuiView
{
	[SerializeField]
	private LoopListView2 rewardItemList;

	[SerializeField]
	private TextMeshProUGUI pointText;

	[SerializeField]
	private Image pointFill;

	[SerializeField]
	private ScrollRect scrollRect;

	private ActivityRewardSliderViewModel viewModel;

	public void Init(ActivityRewardSliderViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ActivityRewardSliderView, ActivityRewardSliderViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(pointText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityRewardSliderViewModel vm) => vm.PointText);
		bindingSet.Bind(pointFill).For((Image v) => v.fillAmount).To((ActivityRewardSliderViewModel vm) => vm.PointFill);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).To((ActivityRewardSliderViewModel vm) => vm.IsVisible);
		bindingSet.Bind(this).For((ActivityRewardSliderView v) => v.RefreshRewardItemList).To((ActivityRewardSliderViewModel vm) => vm.RefreshItemRequest);
		bindingSet.Build();
		rewardItemList.InitListView(viewModel.RewardItemList.Count, OnGetRewardItemByIndex);
		if (scrollRect != null)
		{
			scrollRect.horizontal = false;
			scrollRect.vertical = false;
		}
	}

	public void RefreshRewardItemList(object sender, InteractionEventArgs e)
	{
		rewardItemList.SetListItemCount(viewModel.RewardItemList.Count);
		rewardItemList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityRewardItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemList[index]);
			}
		}
		return loopListViewItem;
	}
}
