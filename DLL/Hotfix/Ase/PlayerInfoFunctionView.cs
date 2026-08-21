using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerInfoFunctionView : UGuiView
{
	[SerializeField]
	private GameObject viewObj;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private LoopListView2 functionItemList;

	private PlayerInfoFunctionViewModel viewModel;

	public void Init(PlayerInfoFunctionViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PlayerInfoFunctionView, PlayerInfoFunctionViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PlayerInfoFunctionViewModel vm) => vm.CloseView);
		bindingSet.Bind(viewObj).For((GameObject v) => v.activeSelf).To((PlayerInfoFunctionViewModel vm) => vm.IsOpen);
		bindingSet.Build();
		functionItemList.InitListView(viewModel.FunctionList.Count, OnGetFunctionItemByIndex);
	}

	private LoopListViewItem2 OnGetFunctionItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.FunctionList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("FunctionItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.FunctionList[index]);
			}
			else
			{
				component.RefreshData(viewModel.FunctionList[index]);
			}
		}
		return loopListViewItem;
	}
}
