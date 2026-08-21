using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SortPanelView : UGuiView
{
	[SerializeField]
	private LoopListView2 sortList;

	[SerializeField]
	private Button btnFunc;

	[SerializeField]
	private Button btnClose;

	private SortPanelViewModel viewModel;

	public void Init(SortPanelViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SortPanelView, SortPanelViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((SortPanelView v) => v.OnVisibleChanged).To((SortPanelViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(btnFunc).For((Button v) => v.onClick).To((SortPanelViewModel vm) => vm.OnFunc);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((SortPanelViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Build();
		sortList.InitListView(viewModel.SortList.Count, OnGetSortItemByIndex);
	}

	public void RefreshData(SortPanelViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetSortItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.SortList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("SortTypeView");
		if (loopListViewItem != null)
		{
			SortTypeView component = loopListViewItem.GetComponent<SortTypeView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SortList[index]);
			}
			else
			{
				component.RefreshData(viewModel.SortList[index]);
			}
		}
		return loopListViewItem;
	}
}
