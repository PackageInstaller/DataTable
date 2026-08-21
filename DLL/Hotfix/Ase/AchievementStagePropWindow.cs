using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchievementStagePropWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack1;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private LoopListView2 achievementStageList;

	private AchievementStagePropViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AchievementStagePropViewModel>();
		BindingSet<AchievementStagePropWindow, AchievementStagePropViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack1).For((Button v) => v.onClick).To((AchievementStagePropViewModel vm) => vm.Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((AchievementStagePropViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((AchievementStagePropWindow v) => v.CloseWindow).To((AchievementStagePropViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AchievementStagePropWindow v) => v.OpenUguiWindow).To((AchievementStagePropViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		achievementStageList.InitListView(viewModel.AchievementStageItemDataList.Count, OnGeStageItemByIndex, checkViewport: true);
	}

	private LoopListViewItem2 OnGeStageItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AchievementStageItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AchievementStageItem");
		if (loopListViewItem != null)
		{
			AchievementStageItem component = loopListViewItem.GetComponent<AchievementStageItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AchievementStageItemDataList[index]);
			}
			else
			{
				component.RefreshAchievementStageData(viewModel.AchievementStageItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
