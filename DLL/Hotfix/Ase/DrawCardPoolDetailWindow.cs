using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardPoolDetailWindow : UGuiWindowBase
{
	[SerializeField]
	private TabItemNormal poolDescribeBtn;

	[SerializeField]
	private TabItemNormal poolRecordBtn;

	[SerializeField]
	private TextMeshProUGUI poolName2;

	[SerializeField]
	private TextMeshProUGUI poolName;

	[SerializeField]
	private TextMeshProUGUI poolDesc;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private LoopListView2 poolRecordListView;

	[SerializeField]
	private Button recordLeftBtn;

	[SerializeField]
	private Button recordRightBtn;

	[SerializeField]
	private TextMeshProUGUI page;

	[SerializeField]
	private Button closeBtn;

	private DrawCardPoolDetailViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardPoolDetailViewModel>();
		BindingSet<DrawCardPoolDetailWindow, DrawCardPoolDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(recordLeftBtn).For((Button v) => v.onClick).To((DrawCardPoolDetailViewModel vm) => vm.LeftCommand);
		bindingSet.Bind(recordRightBtn).For((Button v) => v.onClick).To((DrawCardPoolDetailViewModel vm) => vm.RightCommand);
		bindingSet.Bind<TextMeshProUGUI>(poolName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardPoolDetailViewModel vm) => vm.PoolName);
		bindingSet.Bind<TextMeshProUGUI>(poolName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardPoolDetailViewModel vm) => vm.PoolName);
		bindingSet.Bind<TextMeshProUGUI>(poolDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardPoolDetailViewModel vm) => vm.PoolDesc);
		bindingSet.Bind<TextMeshProUGUI>(page).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardPoolDetailViewModel vm) => vm.Page);
		bindingSet.Bind(this).For((DrawCardPoolDetailWindow v) => v.OpenPoolDescribeView).To((DrawCardPoolDetailViewModel vm) => vm.OpenDetailRequest);
		bindingSet.Bind(this).For((DrawCardPoolDetailWindow v) => v.RefreshRecordItem).To((DrawCardPoolDetailViewModel vm) => vm.RefreshRecordRequest);
		bindingSet.Bind(this).For((DrawCardPoolDetailWindow v) => v.ReSetScrollView).To((DrawCardPoolDetailViewModel vm) => vm.ResetScrollRequest);
		bindingSet.Bind(closeBtn).For((Button v) => v.onClick).To((DrawCardPoolDetailViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((DrawCardPoolDetailWindow v) => v.CloseWindow).To((DrawCardPoolDetailViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		poolRecordListView.InitListView(viewModel.CurRecordItemViewModels.Count, OnGetRecordItemByIndex);
		poolDescribeBtn.Init(viewModel.DescribeBtnViewModel);
		poolRecordBtn.Init(viewModel.RecordBtnViewModel);
	}

	private void OpenPoolDescribeView(object sender, InteractionEventArgs e)
	{
		ReSetScrollView();
	}

	private void ReSetScrollView(object sender = null, InteractionEventArgs e = null)
	{
		scrollRect.verticalNormalizedPosition = 1f;
	}

	private void RefreshRecordItem(object sender, InteractionEventArgs e)
	{
		poolRecordListView.SetListItemCount(viewModel.CurRecordItemViewModels.Count);
		poolRecordListView.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetRecordItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CurRecordItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("RecordItem");
		if (loopListViewItem != null)
		{
			DrawCardRecordItem component = loopListViewItem.GetComponent<DrawCardRecordItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CurRecordItemViewModels[index]);
			}
			else
			{
				component.RefreshRecordItem(viewModel.CurRecordItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
