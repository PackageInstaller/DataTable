using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AddEntryPreViewWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button backBtn2;

	[SerializeField]
	private LoopGridView entryList;

	[SerializeField]
	private EntryInfoView entryInfoView;

	private AddEntryPreViewViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<AddEntryPreViewViewModel>();
		BindingSet<AddEntryPreViewWindow, AddEntryPreViewViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((AddEntryPreViewViewModel vm) => vm.Close);
		bindingSet.Bind(backBtn2).For((Button v) => v.onClick).To((AddEntryPreViewViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((AddEntryPreViewWindow v) => v.OnDismissRequest).To((AddEntryPreViewViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((AddEntryPreViewWindow v) => v.ShowEntryDetail).To((AddEntryPreViewViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		entryList.InitGridView(viewModel.EntryItemDataList.Count, OnGetEntryItemByIndex);
		entryInfoView.Init();
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItemData data = (EntryItemData)e.Context;
		entryInfoView.Show(data);
	}

	private LoopGridViewItem OnGetEntryItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.EntryItemDataList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("EntryItem");
		if (loopGridViewItem != null)
		{
			EntryItemData2 entryItemData = viewModel.EntryItemDataList[index];
			EntryItem2 component = loopGridViewItem.GetComponent<EntryItem2>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(entryItemData);
			}
			else
			{
				component.RefreshEntryItemData(entryItemData);
			}
		}
		return loopGridViewItem;
	}
}
