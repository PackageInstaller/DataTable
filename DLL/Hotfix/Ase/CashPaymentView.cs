using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class CashPaymentView : UGuiView
{
	[SerializeField]
	private LoopGridView PayItemList;

	private CashPaymentViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<CashPaymentViewModel>(userData);
		BindingSet<CashPaymentView, CashPaymentViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((CashPaymentView v) => v.OnVisibleChanged).To((CashPaymentViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((CashPaymentView v) => v.RefreshPayItemList).To((CashPaymentViewModel vm) => vm.RefreshPayItemDatas);
		bindingSet.Build();
		PayItemList.InitGridView(viewModel.ItemList.Count, OnGetPayItemItemByIndex);
		LayoutSuitSetting();
	}

	private void RefreshPayItemList(object sender, InteractionEventArgs e)
	{
		PayItemList.SetListItemCount(viewModel.ItemList.Count);
		PayItemList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetPayItemItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.ItemList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("PayItemView");
		if (loopGridViewItem != null)
		{
			PayItemView component = loopGridViewItem.GetComponent<PayItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.ItemList[index]);
			}
		}
		return loopGridViewItem;
	}

	private void LayoutSuitSetting()
	{
		int count = Mathf.FloorToInt((PayItemList.ViewPortWidth - (float)PayItemList.Padding.left + PayItemList.ItemPadding.x) / (PayItemList.ItemSize.x + PayItemList.ItemPadding.x));
		PayItemList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, count);
	}
}
