using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourEntryResetView : UGuiView
{
	[SerializeField]
	private Button gamePlayOpenBtn;

	[SerializeField]
	private Button entryAllBtn;

	[SerializeField]
	private GameObject entryAllBtnObj;

	[SerializeField]
	private Button openAddEntryWindowBtn;

	[SerializeField]
	private GameObject unLockEntryObj;

	[SerializeField]
	private LoopListView2 unlockEntryList;

	[SerializeField]
	private TextMeshProUGUI costCoinNum;

	[SerializeField]
	private Button unLockEntryBtn;

	[SerializeField]
	private TextMeshProUGUI unlockEntryText;

	[SerializeField]
	private GameObject curEntryObj;

	[SerializeField]
	private LoopListView2 curEntryList;

	[SerializeField]
	private Button openRefreshEntryBtn;

	[SerializeField]
	private GameObject armourTabsObj;

	[SerializeField]
	private List<TabItemNormal> armourTabs;

	private ArmourEntryResetViewModel viewModel;

	public void Init(ArmourEntryResetViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ArmourEntryResetView, ArmourEntryResetViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(gamePlayOpenBtn).For((Button v) => v.onClick).To((ArmourEntryResetViewModel vm) => vm.OpenGamePlayWindow);
		bindingSet.Bind(openAddEntryWindowBtn).For((Button v) => v.onClick).To((ArmourEntryResetViewModel vm) => vm.OpenAddEntryPreViewWindow);
		bindingSet.Bind(entryAllBtn).For((Button v) => v.onClick).To((ArmourEntryResetViewModel vm) => vm.OpenAllEntryWindowCmd);
		bindingSet.Bind(entryAllBtnObj).For((GameObject v) => v.activeSelf).To((ArmourEntryResetViewModel vm) => vm.IsShowEntryAllBtn);
		bindingSet.Bind(unLockEntryObj).For((GameObject v) => v.activeSelf).To((ArmourEntryResetViewModel vm) => vm.CanUnLockEntry);
		bindingSet.Bind(curEntryObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourEntryResetViewModel vm) => !vm.CanUnLockEntry);
		bindingSet.Bind<TextMeshProUGUI>(costCoinNum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourEntryResetViewModel vm) => vm.CostCoin);
		bindingSet.Bind(unLockEntryBtn).For((Button v) => v.onClick).To((ArmourEntryResetViewModel vm) => vm.UnLockEntryCmd);
		bindingSet.Bind<TextMeshProUGUI>(unlockEntryText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourEntryResetViewModel vm) => vm.UnlockBtnText);
		bindingSet.Bind(openRefreshEntryBtn).For((Button v) => v.onClick).To((ArmourEntryResetViewModel vm) => vm.OpenRefreshEntryCmd);
		bindingSet.Bind(this).For((ArmourEntryResetView v) => v.RefreshUnLockEntryList).To((ArmourEntryResetViewModel vm) => vm.RefreshUnLockEntryListRequest);
		bindingSet.Bind(this).For((ArmourEntryResetView v) => v.RefreshCurEntryList).To((ArmourEntryResetViewModel vm) => vm.RefreshCurEntryListRequest);
		bindingSet.Bind(this).For((ArmourEntryResetView v) => v.RefreshArmourTabs).To((ArmourEntryResetViewModel vm) => vm.RefreshArmourTabRequest);
		bindingSet.Build();
		unlockEntryList.InitListView(viewModel.UnLockEntryList.Count, OnGetUnLockEntryItemByIndex);
		curEntryList.InitListView(viewModel.CurEntryList.Count, OnGetCurEntryItemByIndex);
		InitArmourTabs();
		unlockEntryList.ScrollRect.vertical = false;
		curEntryList.ScrollRect.vertical = false;
	}

	private void InitArmourTabs()
	{
		armourTabsObj.SetActive(viewModel.IsShowHeroArmourTabs);
		if (viewModel.IsShowHeroArmourTabs)
		{
			for (int i = 0; i < armourTabs.Count; i++)
			{
				armourTabs[i].Init(viewModel.ArmourTabDataList[i]);
			}
		}
	}

	private void RefreshArmourTabs(object sender, InteractionEventArgs e)
	{
		armourTabsObj.SetActive(viewModel.IsShowHeroArmourTabs);
		if (viewModel.IsShowHeroArmourTabs)
		{
			for (int i = 0; i < armourTabs.Count; i++)
			{
				armourTabs[i].RefreshData(viewModel.ArmourTabDataList[i]);
			}
		}
	}

	private void RefreshUnLockEntryList(object sender = null, InteractionEventArgs e = null)
	{
		unlockEntryList.SetListItemCount(viewModel.UnLockEntryList.Count);
		unlockEntryList.RefreshAllShownItem();
	}

	private void RefreshCurEntryList(object sender = null, InteractionEventArgs e = null)
	{
		curEntryList.SetListItemCount(viewModel.CurEntryList.Count);
		curEntryList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetUnLockEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.UnLockEntryList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EntryItem2");
		if (loopListViewItem != null)
		{
			EntryItem2 component = loopListViewItem.GetComponent<EntryItem2>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.UnLockEntryList[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.UnLockEntryList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetCurEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CurEntryList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EntryItem2");
		if (loopListViewItem != null)
		{
			EntryItem2 component = loopListViewItem.GetComponent<EntryItem2>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CurEntryList[index]);
			}
			else
			{
				component.RefreshData(viewModel.CurEntryList[index]);
			}
		}
		return loopListViewItem;
	}
}
