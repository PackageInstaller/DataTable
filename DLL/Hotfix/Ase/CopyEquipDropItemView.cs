using GameFramework.Runtime;
using SuperScrollView;

namespace Ase;

public class CopyEquipDropItemView : UGuiView
{
	public KnapsackItemNew propItem;

	public WeeklyStar star;

	public LoopListView2 entryList;

	private CopyEquipDropItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyEquipDropItemViewModel>(userData);
		BindingSet<CopyEquipDropItemView, CopyEquipDropItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(star).For((WeeklyStar v) => v.CurCount).To((CopyEquipDropItemViewModel vm) => vm.AdditionCount);
		bindingSet.Build();
		entryList.InitListView(viewModel.EntryItemVMs.Count, OnGetEntryItemByIndex);
		propItem.Init(viewModel.PropItemVM);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyEquipDropItemViewModel>(userData);
		this.SetDataContext(viewModel);
		propItem.Init(viewModel.PropItemVM);
		entryList.SetListItemCount(viewModel.EntryItemVMs.Count);
		entryList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.EntryItemVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EntryItem");
		if (loopListViewItem != null)
		{
			EntryItem component = loopListViewItem.GetComponent<EntryItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.EntryItemVMs[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.EntryItemVMs[index]);
			}
		}
		return loopListViewItem;
	}
}
