using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityPointsWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private LoopListView2 activityTaskList;

	[SerializeField]
	private ActivityRewardSliderView2 rewardSliderView;

	private ActivityPointsViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ActivityPointsViewModel>();
		BindingSet<ActivityPointsWindow, ActivityPointsViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ActivityPointsViewModel vm) => vm.Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((ActivityPointsViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((ActivityPointsWindow v) => v.RefreshTaskItemList).To((ActivityPointsViewModel vm) => vm.RefreshTaskRequest);
		bindingSet.Bind(this).For((ActivityPointsWindow v) => v.OpenUguiWindow).To((ActivityPointsViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((ActivityPointsWindow v) => v.CloseWindow).To((ActivityPointsViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		activityTaskList.InitListView(viewModel.ActivityTaskItemDataList.Count, OnGetTaskItemByIndex);
		rewardSliderView.Init(viewModel.SliderViewModel);
	}

	private void RefreshTaskItemList(object sender, InteractionEventArgs e)
	{
		activityTaskList.SetListItemCount(viewModel.ActivityTaskItemDataList.Count);
		activityTaskList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ActivityTaskItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityTaskItem");
		if (loopListViewItem != null)
		{
			ActivityTaskItem component = loopListViewItem.GetComponent<ActivityTaskItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ActivityTaskItemDataList[index]);
			}
			else
			{
				component.RefreshActivityTaskItem(viewModel.ActivityTaskItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
