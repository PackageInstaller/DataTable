using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchievementStageItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private TextMeshProUGUI rate;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image darkIcon;

	[SerializeField]
	private Image rarity;

	[SerializeField]
	private LoopListView2 rewardItemList;

	[SerializeField]
	private GameObject darkObj;

	private AchievementStageItemData viewModel;

	public void Init(AchievementStageItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AchievementStageItem, AchievementStageItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementStageItemData vm) => vm.MedalName);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementStageItemData vm) => vm.MedalDesc);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((AchievementStageItemData vm) => vm.MedalIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(darkIcon).For((Image v) => v.sprite).ToExpression((AchievementStageItemData vm) => vm.MedalIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((AchievementStageItemData vm) => $"achievements_list_item1_{vm.MedalRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(rate).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((AchievementStageItemData vm) => vm.Rate);
		bindingSet.Bind(darkObj).For((GameObject v) => v.activeSelf).ToExpression((AchievementStageItemData vm) => vm.State == 2);
		rewardItemList.InitListView(viewModel.AchievementRewardItemDataList.Count, OnGeRewardItemByIndex, checkViewport: true);
		bindingSet.Build();
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

	public void RefreshAchievementStageData(AchievementStageItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
