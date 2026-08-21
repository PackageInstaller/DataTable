using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourEntryDetailWindow : UGuiWindow
{
	[SerializeField]
	private LoopListView2 armourItemList;

	[SerializeField]
	private LoopListView2 entryDetailItemList;

	[SerializeField]
	private Button closeBtn1;

	[SerializeField]
	private Button closeBtn2;

	private ArmourEntryDetailViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourEntryDetailViewModel>();
		BindingSet<ArmourEntryDetailWindow, ArmourEntryDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (closeBtn1 != null)
		{
			bindingSet.Bind(closeBtn1).For((Button v) => v.onClick).To((ArmourEntryDetailViewModel vm) => vm.Close);
		}
		if (closeBtn2 != null)
		{
			bindingSet.Bind(closeBtn2).For((Button v) => v.onClick).To((ArmourEntryDetailViewModel vm) => vm.Close);
		}
		bindingSet.Bind(this).For((ArmourEntryDetailWindow v) => v.CloseWindow).To((ArmourEntryDetailViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		armourItemList.InitListView(viewModel.ArmourBaseItemDataList.Count, OnGetArmourBaseItemByIndex);
		entryDetailItemList.InitListView(viewModel.EntryDetailItemDataList.Count, OnGetEntryDetailItemByIndex);
	}

	private LoopListViewItem2 OnGetArmourBaseItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ArmourBaseItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ArmourBaseItem");
		if (loopListViewItem != null)
		{
			ArmourBaseItem component = loopListViewItem.GetComponent<ArmourBaseItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ArmourBaseItemDataList[index]);
			}
			else
			{
				component.RefreshDataArmourBase(viewModel.ArmourBaseItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetEntryDetailItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.EntryDetailItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EntryDetailItem");
		if (loopListViewItem != null)
		{
			EntryDetailItem component = loopListViewItem.GetComponent<EntryDetailItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.EntryDetailItemDataList[index]);
			}
			else
			{
				component.RefreshEntryDetailItem(viewModel.EntryDetailItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
