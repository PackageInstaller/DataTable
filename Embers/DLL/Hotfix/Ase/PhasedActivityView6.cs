using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PhasedActivityView6 : ActivityViewBase
{
	[SerializeField]
	private Button goBtn;

	[SerializeField]
	private Button achievementBtn;

	[SerializeField]
	private TextMeshProUGUI activityDesText;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private GameObject achievementRedPoint;

	[SerializeField]
	private GameObject rewardRedPoint;

	[SerializeField]
	private Button rewardBtn;

	[SerializeField]
	private TextMeshProUGUI rewardText;

	[SerializeField]
	private TextMeshProUGUI achievementProgressText;

	[SerializeField]
	private GameObject achievementCompleteIcon;

	[SerializeField]
	private GameObject rewardCompleteIcon;

	public LoopListView2 rewardList;

	private PhasedActivity6ViewModel viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (PhasedActivity6ViewModel)viewModel;
		BindingSet<PhasedActivityView6, PhasedActivity6ViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(activityDesText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PhasedActivity6ViewModel vm) => vm.AcitivityDesc);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((PhasedActivity6ViewModel vm) => vm.Red);
		bindingSet.Bind(achievementRedPoint).For((GameObject v) => v.activeSelf).To((PhasedActivity6ViewModel vm) => vm.AchievementRed);
		bindingSet.Bind<TextMeshProUGUI>(rewardText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PhasedActivity6ViewModel vm) => vm.RewardText);
		bindingSet.Bind<TextMeshProUGUI>(achievementProgressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PhasedActivity6ViewModel vm) => vm.AchievementProgressText);
		bindingSet.Bind(achievementCompleteIcon).For((GameObject v) => v.activeSelf).To((PhasedActivity6ViewModel vm) => vm.AchievementComplete);
		bindingSet.Bind(rewardCompleteIcon).For((GameObject v) => v.activeSelf).To((PhasedActivity6ViewModel vm) => vm.RewardComplete);
		bindingSet.Bind(((Component)(object)achievementProgressText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((PhasedActivity6ViewModel vm) => !vm.AchievementComplete);
		bindingSet.Bind(((Component)(object)rewardText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((PhasedActivity6ViewModel vm) => !vm.RewardComplete);
		bindingSet.Build();
		base.Init(viewModel);
		Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>()?.SetActivityAchievementRedPointBlocked(this.viewModel.ActivityTypeId, blockActivityAchievementRedPoint);
		goBtn.onClick.AddListener(EnterActivity);
		achievementBtn.onClick.AddListener(OpenAchievementWindow);
		rewardBtn.onClick.AddListener(OpenRewardView);
		rewardList.InitListView(this.viewModel.RewardItemViewModels.Count, OnGetRewardItemByIndex);
		this.viewModel.RefreshActivityTime();
	}

	private async void EnterActivity()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCurChallengeTowerLayer() > 0)
		{
			ShowContinueTis();
		}
		TowerActivityAreaViewModel userData = new TowerActivityAreaViewModel(viewModel, null);
		(await GameEntry.UI.LoadWindow<TowerActivityAreaWindow>("OperatingActivity/TownChallenge/TowerActivityAreaWindow", userData)).Show();
	}

	private async void OpenAchievementWindow()
	{
		List<ActivityAchievementData> dataList = Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().ByActivityTypeGetAchievementDataList(viewModel.ActivityTypeId);
		ActivityAchievementViewModel userData = new ActivityAchievementViewModel(viewModel, viewModel.ActivityTypeId, dataList);
		(await GameEntry.UI.LoadWindow<ActivityAchievementView>("OperatingActivity/ActivityAchievement/ActivityAchievement", userData)).Show();
	}

	private async void OpenRewardView()
	{
		TowerRewardViewModel userData = new TowerRewardViewModel(viewModel, viewModel.MaxActivityRank, viewModel.TowerTaskData, viewModel.ActivityTypeId);
		(await GameEntry.UI.LoadWindow<TowerRewardWindow>("OperatingActivity/TownChallenge/TowerRewardWindow", userData)).Show();
	}

	private async void ShowContinueTis()
	{
		switch (await AlertDialog.ShowDialog("提示", "是否以未完成游戏进度继续", "确认", "取消", "", "POPUP", canceledOnTouchOutside: false, autoPause: false, canceledOnTop: false))
		{
		case -1:
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().ContinuePlayTower();
			break;
		case -2:
			ShowClearTips();
			break;
		}
	}

	private async void ShowClearTips()
	{
		switch (await AlertDialog.ShowDialog("提示", "取消将会丢失当前进度", "确认", "取消", "", "POPUP", canceledOnTouchOutside: false, autoPause: false, canceledOnTop: false))
		{
		case -1:
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RequestClearTowerBuffData();
			break;
		case -2:
			ShowContinueTis();
			break;
		}
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.RewardItemViewModels[index].IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(viewModel.RewardItemViewModels[index].CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}
}
