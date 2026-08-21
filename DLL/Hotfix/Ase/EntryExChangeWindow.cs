using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryExChangeWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button cancelBtn;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private EntryItem2 curEntryItem;

	[SerializeField]
	private EntryItem2 exChangeEntryItem;

	private EntryExChangeViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<EntryExChangeViewModel>();
		BindingSet<EntryExChangeWindow, EntryExChangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((EntryExChangeViewModel vm) => vm.Close);
		bindingSet.Bind(cancelBtn).For((Button v) => v.onClick).To((EntryExChangeViewModel vm) => vm.Close);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((EntryExChangeViewModel vm) => vm.ConfirmOnClick);
		bindingSet.Bind(this).For((EntryExChangeWindow v) => v.OnDismissRequest).To((EntryExChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		curEntryItem.Init(viewModel.CurEntryItemData);
		exChangeEntryItem.Init(viewModel.ExChangeEntryItemData);
	}
}
