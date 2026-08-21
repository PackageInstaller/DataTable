using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityAchievementRewardView : UGuiWindow
{
	[SerializeField]
	private Button backBtn1;

	[SerializeField]
	private Button backBtn2;

	[SerializeField]
	private LoopGridView rewardList;

	private ActivityAchievementRewardViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ActivityAchievementRewardViewModel>();
		BindingSet<ActivityAchievementRewardView, ActivityAchievementRewardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ActivityAchievementRewardView v) => v.OnDismissRequest).To((ActivityAchievementRewardViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ActivityAchievementRewardView v) => v.OpenUguiWindow).To((ActivityAchievementRewardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(backBtn1).For((Button v) => v.onClick).To((ActivityAchievementRewardViewModel vm) => vm.Close);
		bindingSet.Bind(backBtn2).For((Button v) => v.onClick).To((ActivityAchievementRewardViewModel vm) => vm.Close);
		bindingSet.Bind().For((ActivityAchievementRewardView v) => v.OnRefreshData).To((ActivityAchievementRewardViewModel vm) => vm.RefreshRst);
		bindingSet.Build();
		rewardList.InitGridView(viewModel.RewardList.Count, OnGetRewardItemByIndex);
	}

	public void OnRefreshData(object sender, InteractionEventArgs e)
	{
		rewardList.SetListItemCount(viewModel.RewardList.Count);
		rewardList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetRewardItemByIndex(LoopGridView view, int itemIndex, int arg3, int arg4)
	{
		if (itemIndex < 0 || itemIndex >= viewModel.RewardList.Count)
		{
			return null;
		}
		ActivityAchievementRewardItemData activityAchievementRewardItemData = viewModel.RewardList[itemIndex];
		if (activityAchievementRewardItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = view.NewListViewItem("RewardItem");
		ActivityAchievementRewardItem component = loopGridViewItem.GetComponent<ActivityAchievementRewardItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(activityAchievementRewardItemData);
		}
		else
		{
			component.RefreshData(activityAchievementRewardItemData);
		}
		return loopGridViewItem;
	}
}
