using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchievementPropWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack1;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private LoopListView2 achievementProgressList;

	private AchievementPropViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AchievementPropViewModel>();
		BindingSet<AchievementPropWindow, AchievementPropViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack1).For((Button v) => v.onClick).To((AchievementPropViewModel vm) => vm.Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((AchievementPropViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((AchievementPropWindow v) => v.CloseWindow).To((AchievementPropViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AchievementPropWindow v) => v.OpenUguiWindow).To((AchievementPropViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		achievementProgressList.InitListView(viewModel.AchievementProgressItemDataList.Count, OnGetAchievementItemByIndex, checkViewport: true);
	}

	private LoopListViewItem2 OnGetAchievementItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AchievementProgressItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AchievementProgressItem");
		if (loopListViewItem != null)
		{
			AchievementProgressItem component = loopListViewItem.GetComponent<AchievementProgressItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AchievementProgressItemDataList[index]);
			}
			else
			{
				component.RefreshAchievementData(viewModel.AchievementProgressItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
