using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatImageView : UGuiView
{
	public Button btnClose;

	public GameObject emptyRoot;

	public TextMeshProUGUI tabName;

	public LoopListView2 tabList;

	public LoopGridView gridList;

	private ChatImageViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<ChatImageViewModel>(userData);
		BindingSet<ChatImageView, ChatImageViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((ChatImageViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(emptyRoot).For((GameObject v) => v.activeSelf).ToExpression((ChatImageViewModel vm) => vm.CurTabImageCount == 0);
		bindingSet.Bind<TextMeshProUGUI>(tabName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChatImageViewModel vm) => vm.TabName);
		bindingSet.Bind(this).For((ChatImageView v) => v.OnOpt).To((ChatImageViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		tabList.InitListView(viewModel.TabList.Count, OnGetTabItemByIndex);
		gridList.InitGridView(viewModel.CurTabImageCount, OnGetItemByIndex);
	}

	public void InitOpen()
	{
		tabList.SetListItemCount(viewModel.TabList.Count);
		tabList.RefreshAllShownItem();
		gridList.SetListItemCount(viewModel.CurTabImageCount);
		gridList.RefreshAllShownItem();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshTab".Equals(optName))
		{
			gridList.SetListItemCount(viewModel.CurTabImageCount);
			gridList.RefreshAllShownItem();
		}
	}

	private LoopListViewItem2 OnGetTabItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TabList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TabItemView");
		if (loopListViewItem != null)
		{
			TabItemView component = loopListViewItem.GetComponent<TabItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TabList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TabList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.CurTabImageCount)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("CharImageItemView");
		if (loopGridViewItem != null)
		{
			CharImageItemView component = loopGridViewItem.GetComponent<CharImageItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ImageDic[viewModel.CurTabId][index]);
			}
			else
			{
				component.RefreshData(viewModel.ImageDic[viewModel.CurTabId][index]);
			}
		}
		return loopGridViewItem;
	}
}
