using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

internal class AchievementProgressItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI rate;

	[SerializeField]
	private Image fill;

	[SerializeField]
	private LoopListView2 rewardItemList;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private Button receiveBtn;

	[SerializeField]
	private GameObject receiveBtnObj;

	[SerializeField]
	private Button openBtn;

	private AchievementProgressItemData viewModel;

	public void Init(AchievementProgressItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AchievementProgressItem, AchievementProgressItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementProgressItemData vm) => vm.Title);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((AchievementProgressItemData vm) => vm.CanReceived);
		bindingSet.Bind(receiveBtnObj).For((GameObject v) => v.activeSelf).To((AchievementProgressItemData vm) => vm.CanReceived);
		bindingSet.Bind(receiveBtn).For((Button v) => v.onClick).To((AchievementProgressItemData vm) => vm.ReceiveReward);
		bindingSet.Bind<TextMeshProUGUI>(rate).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementProgressItemData vm) => vm.FillText);
		bindingSet.Bind(fill).For((Image v) => v.fillAmount).To((AchievementProgressItemData vm) => vm.Fill);
		bindingSet.Bind(openBtn).For((Button v) => v.onClick).To((AchievementProgressItemData vm) => vm.OpenAchieve);
		bindingSet.Build();
		rewardItemList.InitListView(viewModel.AchievementRewardItemDataList.Count, OnGeRewardItemByIndex, checkViewport: true);
	}

	private LoopListViewItem2 OnGeRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AchievementRewardItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("RewardItem");
		if (loopListViewItem != null)
		{
			AchievementRewardItem component = loopListViewItem.GetComponent<AchievementRewardItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AchievementRewardItemDataList[index]);
			}
			else
			{
				component.RefreshAchievementData(viewModel.AchievementRewardItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	public void RefreshAchievementData(AchievementProgressItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
