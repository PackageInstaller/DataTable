using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityAchievementView : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private RectTransform subTabRoot;

	[SerializeField]
	private TabItem subTabTpl;

	[SerializeField]
	private LoopGridView achiItemList;

	[SerializeField]
	private TextMeshProUGUI countTxt;

	[SerializeField]
	private TextMeshProUGUI rewardCountTxt;

	[SerializeField]
	private Button rewardBtn;

	[SerializeField]
	private TextMeshProUGUI nameTxt;

	[SerializeField]
	private TextMeshProUGUI descTxt;

	[SerializeField]
	private LoopGridView descList;

	[SerializeField]
	private GameObject redPoint;

	private GameObjectPool subTabItemPool;

	private ActivityAchievementViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		subTabItemPool = new GameObjectPool(subTabTpl.gameObject, subTabRoot);
		base.OnCreate(bundle);
		viewModel = GetData<ActivityAchievementViewModel>();
		BindingSet<ActivityAchievementView, ActivityAchievementViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ActivityAchievementView v) => v.OnDismissRequest).To((ActivityAchievementViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ActivityAchievementView v) => v.OpenUguiWindow).To((ActivityAchievementViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((ActivityAchievementView v) => v.OnSubTabChanged).To((ActivityAchievementViewModel vm) => vm.SubTabChangedRst);
		bindingSet.Bind().For((ActivityAchievementView v) => v.OnDataListChanged).To((ActivityAchievementViewModel vm) => vm.DataListChangeRst);
		bindingSet.Bind().For((ActivityAchievementView v) => v.OnDescListChange).To((ActivityAchievementViewModel vm) => vm.DescChangedRst);
		bindingSet.Bind().For((ActivityAchievementView v) => v.RefreshSelectInfo).To((ActivityAchievementViewModel vm) => vm.TitleDescChangedRst);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((ActivityAchievementViewModel vm) => vm.Close);
		bindingSet.Bind(rewardBtn).For((Button v) => v.onClick).To((ActivityAchievementViewModel vm) => vm.OpenRewardCmd);
		bindingSet.Bind<TextMeshProUGUI>(countTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementViewModel vm) => vm.CountTxt);
		bindingSet.Bind<TextMeshProUGUI>(rewardCountTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementViewModel vm) => vm.RewardCountTxt);
		bindingSet.Bind<TextMeshProUGUI>(nameTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementViewModel vm) => vm.NameTxt);
		bindingSet.Bind<TextMeshProUGUI>(descTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementViewModel vm) => vm.DescTxt);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((ActivityAchievementViewModel vm) => vm.RedPoint);
		bindingSet.Build();
		InitSubTabs();
		achiItemList.InitGridView(viewModel.TabShowList.Count, OnGetItemByIndex);
		descList.InitGridView(viewModel.DescList.Count, OnGetItemByIndex2);
		RefreshSelectInfo(null, null);
	}

	private void InitSubTabs()
	{
		for (int i = 0; i < viewModel.SubTabItemDataList.Count; i++)
		{
			TabItemData dataContext = viewModel.SubTabItemDataList[i];
			TabItem component = subTabItemPool.Allocate(out var newCreate).GetComponent<TabItem>();
			if (newCreate)
			{
				component.Init(dataContext);
			}
			else
			{
				component.SetDataContext(dataContext);
			}
			component.transform.SetSiblingIndex(subTabRoot.childCount - 1);
		}
	}

	private void OnSubTabChanged(object sender, InteractionEventArgs e)
	{
		achiItemList.SetListItemCount(viewModel.TabShowList.Count);
		achiItemList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		List<ActivityAchievementItemData> tabShowList = viewModel.TabShowList;
		if (dataIndex < 0 || dataIndex >= tabShowList.Count)
		{
			return null;
		}
		ActivityAchievementItemData activityAchievementItemData = tabShowList[dataIndex];
		if (activityAchievementItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = achiItemList.NewListViewItem("ActivityAchievementItem");
		ActivityAchievementItem component = loopGridViewItem.GetComponent<ActivityAchievementItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(activityAchievementItemData);
		}
		else
		{
			component.RefreshData(activityAchievementItemData);
		}
		if (viewModel.CurItemData != null)
		{
			activityAchievementItemData.IsSelected = activityAchievementItemData.Config.id == viewModel.CurItemData.Config.id;
		}
		else if (dataIndex == 0)
		{
			activityAchievementItemData.OnClick();
		}
		return loopGridViewItem;
	}

	private void OnDataListChanged(object sender, InteractionEventArgs e)
	{
		achiItemList.SetListItemCount(viewModel.TabShowList.Count);
		achiItemList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetItemByIndex2(LoopGridView view, int dataIndex, int arg3, int arg4)
	{
		List<ActivityAchievementDescData> list = viewModel.DescList;
		if (dataIndex < 0 || dataIndex >= list.Count)
		{
			return null;
		}
		ActivityAchievementDescData activityAchievementDescData = list[dataIndex];
		if (activityAchievementDescData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = descList.NewListViewItem("AchievementDesc");
		ActivityAchievementDesc component = loopGridViewItem.GetComponent<ActivityAchievementDesc>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(activityAchievementDescData);
		}
		else
		{
			component.RefreshData(activityAchievementDescData);
		}
		return loopGridViewItem;
	}

	private void OnDescListChange(object sender, InteractionEventArgs e)
	{
		descList.SetListItemCount(viewModel.DescList.Count);
		descList.RefreshAllShownItem();
	}

	private void RefreshSelectInfo(object sender, InteractionEventArgs e)
	{
		if (viewModel.CurItemData.Config.state != ActivityAchievementState.UnSeen)
		{
			((TMP_Text)nameTxt).text = viewModel.CurItemData.Config.name;
			((TMP_Text)descTxt).text = viewModel.CurItemData.Config.desc;
		}
		else
		{
			((TMP_Text)nameTxt).text = "? ? ?";
			((TMP_Text)descTxt).text = "神秘的庇护效果，在肉鸽塔中可以随机遇到";
		}
	}
}
