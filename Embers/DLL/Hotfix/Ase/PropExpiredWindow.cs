using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropExpiredWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private LoopListView2 loopListView;

	private PropExpiredViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PropExpiredViewModel>();
		BindingSet<PropExpiredWindow, PropExpiredViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((PropExpiredWindow v) => v.OnDismissRequest).To((PropExpiredViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((PropExpiredWindow v) => v.OpenUguiWindow).To((PropExpiredViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PropExpiredViewModel vm) => vm.Close);
		bindingSet.Build();
		InitListParam();
	}

	public void InitListParam()
	{
		loopListView.InitListView(_viewModel.ExpiredDataList.Count, OnGetItemByIndex);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.ExpiredDataList.Count)
		{
			return null;
		}
		PropDataBase propDataBase = _viewModel.ExpiredDataList[index];
		if (propDataBase == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = loopListView.NewListViewItem("PropItem");
		KnapsackItemViewModel viewModel = new KnapsackItemViewModel(_viewModel, propDataBase);
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel);
			}
			else
			{
				component.RefreshData(viewModel);
			}
		}
		return loopListViewItem;
	}
}
