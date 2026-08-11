using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class EntryCompareView : UGuiView
{
	[SerializeField]
	private LoopListView2 loopListView2;

	private EntryCompareViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<EntryCompareViewModel>(userData);
		BindingSet<EntryCompareView, EntryCompareViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<CanvasGroup>(CanvasGroup).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((EntryCompareViewModel vm) => vm.Visible ? 1 : 0);
		bindingSet.Bind<CanvasGroup>(CanvasGroup).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).To((EntryCompareViewModel vm) => vm.Visible);
		bindingSet.Bind().For((EntryCompareView v) => v.Refresh).To((EntryCompareViewModel vm) => vm.RefreshRst);
		bindingSet.Build();
		loopListView2.InitListView(_viewModel.EntryChangeList.Count, OnGetItemByIndex);
	}

	private void Refresh(object sender, InteractionEventArgs e)
	{
		loopListView2.SetListItemCount(_viewModel.EntryChangeList.Count);
		loopListView2.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.EntryChangeList.Count)
		{
			return null;
		}
		EntryChangeData entryChangeData = _viewModel.EntryChangeList[index];
		if (entryChangeData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = ((!_viewModel.IsRock || !entryChangeData.EntryData.IsFixed) ? loopListView2.NewListViewItem("EntryCompareItem") : loopListView2.NewListViewItem("RockMainEntryCompareItem"));
		if (loopListViewItem == null)
		{
			return null;
		}
		EntryCompareItemData userData = new EntryCompareItemData(_viewModel, entryChangeData, _viewModel.IsRock);
		EntryCompareItem component = loopListViewItem.GetComponent<EntryCompareItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(userData);
		}
		else
		{
			component.RefreshData(userData);
		}
		return loopListViewItem;
	}
}
