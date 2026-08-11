using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchievementWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopListView2 achievementList;

	[SerializeField]
	private Button allAchievementRewardBtn;

	[SerializeField]
	private GameObject allAchiRedPoint;

	private AchievementViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AchievementViewModel>();
		BindingSet<AchievementWindow, AchievementViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((AchievementViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((AchievementWindow v) => v.CloseWindow).To((AchievementViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AchievementWindow v) => v.OpenUguiWindow).To((AchievementViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(allAchievementRewardBtn).For((Button v) => v.onClick).To((AchievementViewModel vm) => vm.OpenAllAchiRewardCmd);
		bindingSet.Bind(allAchiRedPoint).For((GameObject v) => v.activeSelf).To((AchievementViewModel vm) => vm.RedPoint);
		bindingSet.Build();
		achievementList.InitListView(viewModel.AchievementItemDataList.Count, OnGetAchievementItemByIndex);
	}

	private LoopListViewItem2 OnGetAchievementItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AchievementItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AchievementItem");
		if (loopListViewItem != null)
		{
			AchievementItem component = loopListViewItem.GetComponent<AchievementItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AchievementItemDataList[index]);
			}
			else
			{
				component.RefreshAchievementData(viewModel.AchievementItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
