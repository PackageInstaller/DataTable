using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourChangeEntryWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private Button entryAllBtn;

	[SerializeField]
	private GameObject entryAllBtnObj;

	[SerializeField]
	private Button showEntryGamePlayViewBtn;

	[SerializeField]
	private Button openEntryPreViewBtn;

	[SerializeField]
	private TextMeshProUGUI tip;

	[SerializeField]
	private KnapsackItemNew propItem;

	[SerializeField]
	private KnapsackItemNew coinItem;

	[SerializeField]
	private LoopListView2 backUpEntryList;

	[SerializeField]
	private LoopListView2 curEntryList;

	[SerializeField]
	private Button reSetEntryBtn;

	[SerializeField]
	private GameObject exChangeEntryView;

	[SerializeField]
	private EntryItem2 selectedEntry;

	[SerializeField]
	private LoopListView2 curEntryList2;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private MoneyView moneyView;

	private ArmourChangeEntryViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourChangeEntryViewModel>();
		BindingSet<ArmourChangeEntryWindow, ArmourChangeEntryViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourChangeEntryViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((ArmourChangeEntryViewModel vm) => vm.CloseExChangeView);
		bindingSet.Bind(this).For((ArmourChangeEntryWindow v) => v.OpenUguiWindow).To((ArmourChangeEntryViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<TextMeshProUGUI>(tip).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourChangeEntryViewModel vm) => vm.Tip);
		bindingSet.Bind(reSetEntryBtn).For((Button v) => v.onClick).To((ArmourChangeEntryViewModel vm) => vm.ResetEntryCommand);
		bindingSet.Bind(exChangeEntryView).For((GameObject v) => v.activeSelf).To((ArmourChangeEntryViewModel vm) => vm.IsShowSelected);
		bindingSet.Bind(this).For((ArmourChangeEntryWindow v) => v.RefreshBackUpEntryList).To((ArmourChangeEntryViewModel vm) => vm.RefreshBackUpEntryRequest);
		bindingSet.Bind(this).For((ArmourChangeEntryWindow v) => v.RefreshCurEntryList).To((ArmourChangeEntryViewModel vm) => vm.RefreshCurEntryRequest);
		bindingSet.Bind(this).For((ArmourChangeEntryWindow v) => v.OnDismissRequest).To((ArmourChangeEntryViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ArmourChangeEntryWindow v) => v.ShowEntryDetail).To((ArmourChangeEntryViewModel vm) => vm.OpenEntryPanelRequest);
		bindingSet.Bind(entryAllBtn).For((Button v) => v.onClick).To((ArmourChangeEntryViewModel vm) => vm.OpenAllEntryWindowCmd);
		bindingSet.Bind(entryAllBtnObj).For((GameObject v) => v.activeSelf).To((ArmourChangeEntryViewModel vm) => vm.IsShowEntryAllBtn);
		bindingSet.Bind(showEntryGamePlayViewBtn).For((Button v) => v.onClick).To((ArmourChangeEntryViewModel vm) => vm.OpenEntryGamePlayView);
		bindingSet.Bind(openEntryPreViewBtn).For((Button v) => v.onClick).To((ArmourChangeEntryViewModel vm) => vm.OpenEntryPreViewCmd);
		bindingSet.Build();
		propItem.Init(viewModel.PropItemData);
		coinItem.Init(viewModel.CoinItemData);
		moneyView.Init(new MoneyViewModel(viewModel));
		selectedEntry.Init(viewModel.SelectedBackUpEntry);
		backUpEntryList.InitListView(viewModel.BackUpEntryList.Count, OnGetBackUpEntryItemByIndex);
		curEntryList.InitListView(viewModel.CurEntryList.Count, OnGetCurEntryItemByIndex);
		curEntryList2.InitListView(viewModel.ExchangeEntryList.Count, OnGetExChangeEntryItemByIndex);
		entryInfoView.Init();
		backUpEntryList.ScrollRect.horizontal = false;
	}

	private void RefreshBackUpEntryList(object sender, InteractionEventArgs e)
	{
		backUpEntryList.SetListItemCount(viewModel.BackUpEntryList.Count);
		backUpEntryList.RefreshAllShownItem();
	}

	private void RefreshCurEntryList(object sender, InteractionEventArgs e)
	{
		curEntryList.SetListItemCount(viewModel.CurEntryList.Count);
		curEntryList.RefreshAllShownItem();
		curEntryList2.SetListItemCount(viewModel.CurEntryList.Count);
		curEntryList2.RefreshAllShownItem();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItemData data = (EntryItemData)e.Context;
		entryInfoView.Show(data);
	}

	private LoopListViewItem2 OnGetBackUpEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.BackUpEntryList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BackUpEntry");
		if (loopListViewItem != null)
		{
			EntryItem2 component = loopListViewItem.GetComponent<EntryItem2>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BackUpEntryList[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.BackUpEntryList[index]);
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
				component.RefreshEntryItemData(viewModel.CurEntryList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetExChangeEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ExchangeEntryList.Count)
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
				component.Init(viewModel.ExchangeEntryList[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.ExchangeEntryList[index]);
			}
		}
		return loopListViewItem;
	}
}
