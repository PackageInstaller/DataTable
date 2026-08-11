using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GetPackWindow : UGuiWindow
{
	[SerializeField]
	private LoopListView2 packItemList;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private TextMeshProUGUI btnCancelText;

	private GetPackViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GetPackViewModel>();
		BindingSet<GetPackWindow, GetPackViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((GetPackWindow v) => v.OpenUguiWindow).To((GetPackViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GetPackWindow v) => v.CloseWindow).To((GetPackViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((GetPackViewModel vm) => vm.CancelCmd);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((GetPackViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(this).For((GetPackWindow v) => v.RefreshPackItem).To((GetPackViewModel vm) => vm.RefreshPackRequest);
		bindingSet.Build();
		packItemList.InitListView(viewModel.PackItemDataList.Count, OnPackItemByIndex);
	}

	private void RefreshPackItem(object sender, InteractionEventArgs args)
	{
		packItemList.SetListItemCount(viewModel.PackItemDataList.Count);
		packItemList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnPackItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PackItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = ((viewModel.PackItemDataList[index].ItemType != 5) ? listView2.NewListViewItem("PropItem") : listView2.NewListViewItem("WeaponItem"));
		if (loopListViewItem != null)
		{
			PackItem component = loopListViewItem.GetComponent<PackItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PackItemDataList[index]);
			}
			else
			{
				component.RefreshPackItemData(viewModel.PackItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
