using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyMaterialSortView : UGuiView
{
	public Button btn;

	public GameObject viewRoot;

	public Button btnConfirm;

	public Button btnCancel;

	public CMSortItemView item1;

	public CMSortItemView item2;

	public LoopGridView itemList;

	public LoopListView2 dropList;

	private CopyMaterialSortViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyMaterialSortViewModel>(userData);
		BindingSet<CopyMaterialSortView, CopyMaterialSortViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).To((CopyMaterialSortViewModel vm) => vm.IsMaterialSort);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((CopyMaterialSortViewModel vm) => vm.OnConfirm);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((CopyMaterialSortViewModel vm) => vm.OnCancel);
		bindingSet.Bind(this).For((CopyMaterialSortView v) => v.OnOpt).To((CopyMaterialSortViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		viewRoot.gameObject.SetActive(value: false);
		btn.onClick.AddListener(delegate
		{
			viewRoot.gameObject.SetActive(value: true);
		});
		dropList.InitListView(viewModel.DropProps.Count, OnGetDropItemByIndex);
		itemList.InitGridView(viewModel.SortItemList.Count, OnGetItemItemByIndex);
		item1.Init(viewModel.Item1);
		item2.Init(viewModel.Item2);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshItems".Equals(optName))
		{
			dropList.SetListItemCount(viewModel.DropProps.Count);
			dropList.RefreshAllShownItem();
		}
		else if ("Close".Equals(optName))
		{
			dropList.SetListItemCount(viewModel.DropProps.Count);
			dropList.RefreshAllShownItem();
			viewRoot.gameObject.SetActive(value: false);
		}
	}

	private LoopGridViewItem OnGetItemItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.SortItemList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("MaterialSortItemView");
		if (loopGridViewItem != null)
		{
			CMSortItemView component = loopGridViewItem.GetComponent<CMSortItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SortItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.SortItemList[index]);
			}
		}
		return loopGridViewItem;
	}

	private LoopListViewItem2 OnGetDropItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.DropProps.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropSmallItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.DropProps[index]);
			}
			else
			{
				component.RefreshData(viewModel.DropProps[index]);
			}
		}
		return loopListViewItem;
	}
}
