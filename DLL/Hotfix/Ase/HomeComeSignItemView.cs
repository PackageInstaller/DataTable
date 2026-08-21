using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComeSignItemView : UGuiView
{
	[SerializeField]
	private LoopGridView rewardList;

	[SerializeField]
	private TextMeshProUGUI stateTxt;

	[SerializeField]
	private GameObject received;

	[SerializeField]
	private Button button;

	private HomeComeSignItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HomeComeSignItemViewModel>(userData);
		BindingSet<HomeComeSignItemView, HomeComeSignItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if ((UnityEngine.Object)(object)stateTxt != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(stateTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HomeComeSignItemViewModel vm) => vm.StateText);
			bindingSet.Bind<TextMeshProUGUI>(stateTxt).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((HomeComeSignItemViewModel vm) => vm.StateColor);
		}
		if (received != null)
		{
			bindingSet.Bind(received).For((GameObject v) => v.activeSelf).To((HomeComeSignItemViewModel vm) => vm.Received);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((HomeComeSignItemViewModel vm) => vm.ClickCommand);
			bindingSet.Bind(button).For((Button v) => v.interactable).To((HomeComeSignItemViewModel vm) => vm.Clickable);
		}
		bindingSet.Bind(this).For((HomeComeSignItemView v) => v.RefreshRewardList).To((HomeComeSignItemViewModel vm) => vm.RefreshRewardListRequest);
		bindingSet.Build();
		if (rewardList != null)
		{
			rewardList.InitGridView(viewModel.RewardItems.Count, OnGetRewardItemByIndex);
		}
		RefreshRewardList();
	}

	private void RefreshRewardList(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel != null && !(rewardList == null))
		{
			rewardList.SetListItemCount(viewModel.RewardItems.Count);
			rewardList.RefreshAllShownItem();
		}
	}

	private LoopGridViewItem OnGetRewardItemByIndex(LoopGridView gridView, int itemIndex, int row, int column)
	{
		if (viewModel == null || itemIndex < 0 || itemIndex >= viewModel.RewardItems.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("RewardItem");
		HomeComeSignRewardCellView homeComeSignRewardCellView = loopGridViewItem.GetComponent<HomeComeSignRewardCellView>();
		if (homeComeSignRewardCellView == null)
		{
			homeComeSignRewardCellView = loopGridViewItem.gameObject.AddComponent<HomeComeSignRewardCellView>();
		}
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			homeComeSignRewardCellView.Init(viewModel.RewardItems[itemIndex]);
		}
		else
		{
			homeComeSignRewardCellView.RefreshData(viewModel.RewardItems[itemIndex]);
		}
		return loopGridViewItem;
	}

	public void RefreshData(HomeComeSignItemViewModel data)
	{
		viewModel = data;
		this.SetDataContext(data);
		RefreshRewardList();
	}
}
