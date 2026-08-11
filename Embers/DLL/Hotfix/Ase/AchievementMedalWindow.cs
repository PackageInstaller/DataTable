using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchievementMedalWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack1;

	[SerializeField]
	private LoopListView2 tabList;

	[SerializeField]
	private LoopGridView achievementMedalItemList;

	[SerializeField]
	private Button btnAllAchievementReward;

	[SerializeField]
	private GameObject allAchiRedPoint;

	[SerializeField]
	private Button btnGetAllReward;

	[SerializeField]
	private GameObject btnGetAllRewardObj;

	private AchievementMedalViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AchievementMedalViewModel>();
		BindingSet<AchievementMedalWindow, AchievementMedalViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack1).For((Button v) => v.onClick).To((AchievementMedalViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((AchievementMedalWindow v) => v.CloseWindow).To((AchievementMedalViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AchievementMedalWindow v) => v.OpenUguiWindow).To((AchievementMedalViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((AchievementMedalWindow v) => v.RefreshMedalList).To((AchievementMedalViewModel vm) => vm.RefreshMedalItemRequest);
		bindingSet.Bind(btnAllAchievementReward).For((Button v) => v.onClick).To((AchievementMedalViewModel vm) => vm.OpenAllAchiRewardCmd);
		bindingSet.Bind(allAchiRedPoint).For((GameObject v) => v.activeSelf).To((AchievementMedalViewModel vm) => vm.RedPoint);
		bindingSet.Bind(btnGetAllReward).For((Button v) => v.onClick).To((AchievementMedalViewModel vm) => vm.GetAllRewardCmd);
		bindingSet.Bind(btnGetAllRewardObj).For((GameObject v) => v.activeSelf).To((AchievementMedalViewModel vm) => vm.ShowGetAllRewardBtn);
		bindingSet.Build();
		tabList.InitListView(viewModel.TabDataList.Count, OnGetTabItemByIndex, checkViewport: true);
		achievementMedalItemList.InitGridView(viewModel.ShowMedalItemDataList.Count, OnGetAchievementMedalByIndex);
	}

	private void RefreshMedalList(object sender, InteractionEventArgs e)
	{
		achievementMedalItemList.SetListItemCount(viewModel.ShowMedalItemDataList.Count);
		achievementMedalItemList.RefreshAllShownItem();
		achievementMedalItemList.MovePanelToItemByIndex(0);
	}

	private LoopListViewItem2 OnGetTabItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TabDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AchievementTabItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TabDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TabDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetAchievementMedalByIndex(LoopGridView arg1, int index, int row, int column)
	{
		AchievementMedalItemData achievementMedalItemData = viewModel.ShowMedalItemDataList[index];
		if (achievementMedalItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = achievementMedalItemList.NewListViewItem("MedalItem");
		AchievementMedalItem component = loopGridViewItem.GetComponent<AchievementMedalItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(achievementMedalItemData);
		}
		else
		{
			component.RefreshAchievementMedalData(achievementMedalItemData);
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
