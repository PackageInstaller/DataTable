using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class BattleResultWinWindow : BattleResultBaseWindow
{
	[SerializeField]
	private GameObject timeObj1;

	[SerializeField]
	private UIStarGroup2 uiStarGroup1;

	[SerializeField]
	private TextMeshProUGUI teamTimeText1;

	[SerializeField]
	private GameObject timeObj2;

	[SerializeField]
	private UIStarGroup2 uiStarGroup2;

	[SerializeField]
	private TextMeshProUGUI teamTimeText2;

	[SerializeField]
	private GameObject scoreObj;

	[SerializeField]
	private TextMeshProUGUI scoreText;

	[SerializeField]
	private GameObject higherScoreObj;

	[SerializeField]
	private GameObject likabilityObj;

	[SerializeField]
	private LoopGridView rewardItemList;

	[SerializeField]
	private TextMeshProUGUI battleTitle;

	[SerializeField]
	private TextMeshProUGUI battleValue;

	[SerializeField]
	private LoopListView2 starList;

	private BattleResultViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleResultViewModel>();
		BindingSet<BattleResultWinWindow, BattleResultViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(higherScoreObj).For((GameObject v) => v.activeSelf).To((BattleResultViewModel vm) => vm.HigherScore);
		bindingSet.Bind(likabilityObj).For((GameObject v) => v.activeSelf).To((BattleResultViewModel vm) => vm.ShowAddLikability);
		bindingSet.Bind<TextMeshProUGUI>(battleTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleResultViewModel vm) => vm.BattleTitle);
		bindingSet.Bind<TextMeshProUGUI>(battleValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleResultViewModel vm) => vm.BattleValue);
		bindingSet.Build();
		rewardItemList.InitGridView(viewModel.RewardList.Count, OnGetRewardItemByIndex);
		OpenWinType();
		if (starList != null)
		{
			starList.InitListView(viewModel.StarList.Count, OnGetStarDetailItemByIndex, checkViewport: true);
		}
	}

	private void OpenWinType()
	{
		if (viewModel.ResultShowType == BattleResultShowType.CopyMainType4)
		{
			timeObj1.SetActive(value: true);
			uiStarGroup1.SetStarCount(viewModel.CopyMaxStar, viewModel.CopyGetStar, 0);
			((TMP_Text)teamTimeText1).text = viewModel.GetTime();
		}
		else if (viewModel.ResultShowType == BattleResultShowType.StarAndTime)
		{
			timeObj2.SetActive(value: true);
			uiStarGroup2.SetStarCount(viewModel.CopyMaxStar, viewModel.CopyGetStar, 0);
			((TMP_Text)teamTimeText2).text = viewModel.GetTime();
		}
		else
		{
			scoreObj.SetActive(value: true);
			((TMP_Text)scoreText).text = $"{viewModel.Score}";
		}
	}

	private LoopGridViewItem OnGetRewardItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.RewardList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = null;
		if (viewModel.RewardList[index].ExValue == 0)
		{
			loopGridViewItem = rewardItemList.NewListViewItem("PropItem_Normal");
		}
		else if (viewModel.RewardList[index].ExValue == 1)
		{
			loopGridViewItem = rewardItemList.NewListViewItem("PropItem_Ex");
		}
		else if (viewModel.RewardList[index].ExValue == 2)
		{
			loopGridViewItem = rewardItemList.NewListViewItem("PropItem_First");
		}
		if (loopGridViewItem != null)
		{
			KnapsackItemNew component = loopGridViewItem.GetComponent<KnapsackItemNew>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardList[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardList[index]);
			}
		}
		return loopGridViewItem;
	}

	private LoopListViewItem2 OnGetStarDetailItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.StarList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("StarItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.StarList[index]);
			}
			else
			{
				component.Init(viewModel.StarList[index]);
			}
		}
		return loopListViewItem;
	}
}
