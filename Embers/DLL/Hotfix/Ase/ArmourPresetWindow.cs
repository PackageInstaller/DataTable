#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Ase;

public class ArmourPresetWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private LoopListView2 tabList;

	[SerializeField]
	private LoopListView2 armourList;

	[SerializeField]
	private LoopGridView attrGrid;

	[SerializeField]
	private LoopGridView entryGrid;

	[SerializeField]
	private Button btnCreate;

	[SerializeField]
	private Button btnApply;

	[SerializeField]
	private GameObject btnCreateDisableObj;

	[SerializeField]
	private GameObject btnApplyDisableObj;

	[SerializeField]
	private Button btnRename;

	[SerializeField]
	private Button btnDelete;

	[SerializeField]
	private ArmourPresetNameView nameView;

	[SerializeField]
	private ArmourPresetApplyView applyView;

	private ArmourPresetWindowViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourPresetWindowViewModel>();
		BindingSet<ArmourPresetWindow, ArmourPresetWindowViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourPresetWindowViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((ArmourPresetWindowViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.OnDismissRequest).To((ArmourPresetWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.OpenUguiWindow).To((ArmourPresetWindowViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((ArmourPresetWindowViewModel vm) => vm.ApplyPreset);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.OnRefresh).To((ArmourPresetWindowViewModel vm) => vm.RefreshRequest);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.ShowNameView).To((ArmourPresetWindowViewModel vm) => vm.ShowNameViewRequest);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.HideNameView).To((ArmourPresetWindowViewModel vm) => vm.HideNameViewRequest);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.ShowApplyView).To((ArmourPresetWindowViewModel vm) => vm.ShowApplyViewRequest);
		bindingSet.Bind(this).For((ArmourPresetWindow v) => v.HideApplyView).To((ArmourPresetWindowViewModel vm) => vm.HideApplyViewRequest);
		bindingSet.Build();
		if (btnCreate != null)
		{
			btnCreate.onClick.AddListener(OpenCreatePresetNamePanel);
		}
		AddDisabledButtonListener(btnCreateDisableObj, ShowCreateDisabledToast);
		AddDisabledButtonListener(btnApplyDisableObj, ShowApplyDisabledToast);
		if (btnRename != null)
		{
			btnRename.onClick.AddListener(OpenRenamePresetNamePanel);
		}
		if (btnDelete != null)
		{
			btnDelete.onClick.AddListener(ConfirmDeletePreset);
		}
		HideNameView(null, null);
		HideApplyView(null, null);
		tabList.InitListView(viewModel.TabItems.Count, OnGetTabItemByIndex);
		armourList.InitListView(viewModel.ArmourItems.Count, OnGetArmourItemByIndex);
		attrGrid.InitGridView(viewModel.AttributeItems.Count, OnGetAttrItemByIndex);
		entryGrid.InitGridView(viewModel.EntryItems.Count, OnGetEntryItemByIndex);
		RefreshOperationButtons();
		OnRefresh(null, null);
	}

	private void RefreshLists()
	{
		tabList.SetListItemCount(viewModel.TabItems.Count);
		tabList.RefreshAllShownItem();
		armourList.SetListItemCount(viewModel.ArmourItems.Count);
		armourList.RefreshAllShownItem();
		attrGrid.SetListItemCount(viewModel.AttributeItems.Count);
		attrGrid.RefreshAllShownItem();
		entryGrid.SetListItemCount(viewModel.EntryItems.Count);
		entryGrid.RefreshAllShownItem();
	}

	private void RefreshOperationButtons()
	{
		bool canEditCurrentPreset = viewModel.CanEditCurrentPreset;
		bool isCurrentPresetSlotEmpty = viewModel.IsCurrentPresetSlotEmpty;
		if (btnCreate != null)
		{
			btnCreate.gameObject.SetActive(viewModel.CanShowCreatePresetButton);
		}
		if (btnCreateDisableObj != null)
		{
			btnCreateDisableObj.SetActive(viewModel.CanShowCreatePresetButton & isCurrentPresetSlotEmpty);
		}
		if (btnApply != null)
		{
			btnApply.gameObject.SetActive(canEditCurrentPreset);
		}
		if (btnApplyDisableObj != null)
		{
			btnApplyDisableObj.SetActive(canEditCurrentPreset & isCurrentPresetSlotEmpty);
		}
		if (btnRename != null)
		{
			btnRename.gameObject.SetActive(canEditCurrentPreset);
		}
		if (btnDelete != null)
		{
			btnDelete.gameObject.SetActive(canEditCurrentPreset);
		}
	}

	private void AddDisabledButtonListener(GameObject buttonObj, UnityAction action)
	{
		if (!(buttonObj == null))
		{
			Button componentInChildren = buttonObj.GetComponentInChildren<Button>(includeInactive: true);
			if (!(componentInChildren == null))
			{
				componentInChildren.onClick.RemoveListener(action);
				componentInChildren.onClick.AddListener(action);
			}
		}
	}

	private void ShowCreateDisabledToast()
	{
		Toast.ShowInfo("空预设无法存为新方案");
	}

	private void ShowApplyDisabledToast()
	{
		Toast.ShowInfo("空预设无法应用");
	}

	private void OpenCreatePresetNamePanel()
	{
		if (viewModel.IsCurrentPresetSlotEmpty)
		{
			Toast.ShowInfo("空预设无法存为新方案");
		}
		else if (!viewModel.CanCreatePreset)
		{
			AlertDialog.Show("提示", "预设明饰方案已达到<color=#ab2b1a>上限</color>,若仍想<color=#ab2b1a>保存</color>新预设,请先<color=#ab2b1a>删除</color>已保存的预设", "确定", null);
		}
		else
		{
			viewModel.OpenCreateNameView();
		}
	}

	private void OpenRenamePresetNamePanel()
	{
		if (viewModel.CanEditCurrentPreset)
		{
			viewModel.OpenNameView(createMode: false, viewModel.CurrentPresetName);
		}
	}

	private void ConfirmDeletePreset()
	{
		if (!viewModel.CanEditCurrentPreset)
		{
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", "确定<color=#ab2b1a>删除</color>当前<color=#ab2b1a>预设</color>明饰方案？", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				viewModel.DeletePreset();
			}
		});
	}

	private LoopListViewItem2 OnGetTabItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TabItems.Count)
		{
			return null;
		}
		ArmourPresetTabItemData armourPresetTabItemData = viewModel.TabItems[index];
		string itemPrefabName = (armourPresetTabItemData.IsCurrent ? "TabItemCurrent" : (armourPresetTabItemData.IsCreated ? "TabItem" : "TabItemAdd"));
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem(itemPrefabName);
		if (loopListViewItem == null)
		{
			return null;
		}
		TabItem component = loopListViewItem.GetComponent<TabItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(armourPresetTabItemData);
		}
		else
		{
			component.RefreshData(armourPresetTabItemData);
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetArmourItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ArmourItems.Count)
		{
			return null;
		}
		ArmourPresetEquipItemData armourPresetEquipItemData = viewModel.ArmourItems[index];
		if (armourPresetEquipItemData.IsBar)
		{
			LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BarItem");
			if (loopListViewItem != null)
			{
				loopListViewItem.IsInitHandlerCalled = true;
			}
			return loopListViewItem;
		}
		string itemPrefabName = (armourPresetEquipItemData.IsEmpty ? "emptyItem" : "ArmourItemRoot");
		LoopListViewItem2 loopListViewItem2 = listView2.NewListViewItem(itemPrefabName);
		if (loopListViewItem2 == null)
		{
			return null;
		}
		if (armourPresetEquipItemData.IsEmpty)
		{
			ArmourPresetEmptyItem component = loopListViewItem2.GetComponent<ArmourPresetEmptyItem>();
			if (!loopListViewItem2.IsInitHandlerCalled)
			{
				loopListViewItem2.IsInitHandlerCalled = true;
				component.Init(armourPresetEquipItemData);
			}
			else
			{
				component.RefreshData(armourPresetEquipItemData);
			}
		}
		else
		{
			ArmourItem componentInChildren = loopListViewItem2.GetComponentInChildren<ArmourItem>(includeInactive: true);
			if (componentInChildren == null)
			{
				Log.Error("ArmourPresetWindow ArmourItemRoot child ArmourItem is null.");
				return loopListViewItem2;
			}
			if (!loopListViewItem2.IsInitHandlerCalled)
			{
				loopListViewItem2.IsInitHandlerCalled = true;
				componentInChildren.Init(armourPresetEquipItemData.ArmourItemData);
			}
			else
			{
				componentInChildren.RefreshData(armourPresetEquipItemData.ArmourItemData);
			}
		}
		return loopListViewItem2;
	}

	private LoopGridViewItem OnGetAttrItemByIndex(LoopGridView listView2, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.AttributeItems.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = attrGrid.NewListViewItem("StatusAttrItem");
		StatusAttrItemView component = loopGridViewItem.GetComponent<StatusAttrItemView>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel.AttributeItems[index]);
		}
		else
		{
			component.RefreshData(viewModel.AttributeItems[index]);
		}
		return loopGridViewItem;
	}

	private LoopGridViewItem OnGetEntryItemByIndex(LoopGridView listView2, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.EntryItems.Count)
		{
			return null;
		}
		EntryLevelItemData entryLevelItemData = viewModel.EntryItems[index];
		string itemPrefabName = (entryLevelItemData.ShowLevel ? "EntryLevelItemRoot" : "MainEntryItem");
		LoopGridViewItem loopGridViewItem = entryGrid.NewListViewItem(itemPrefabName);
		if (!entryLevelItemData.ShowLevel)
		{
			EntryItem component = loopGridViewItem.GetComponent<EntryItem>();
			EntryItemData entryItemData = CreateMainEntryItemData(entryLevelItemData);
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(entryItemData);
			}
			else
			{
				component.RefreshEntryItemData(entryItemData);
			}
			return loopGridViewItem;
		}
		EntryLevelItem componentInChildren = loopGridViewItem.GetComponentInChildren<EntryLevelItem>(includeInactive: true);
		if (componentInChildren == null)
		{
			Log.Error("ArmourPresetWindow EntryLevelItemRoot child EntryLevelItem is null.");
			return loopGridViewItem;
		}
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			componentInChildren.InitItem(entryLevelItemData);
		}
		else
		{
			componentInChildren.RefreshEntryLevelItemData(entryLevelItemData);
		}
		return loopGridViewItem;
	}

	private EntryItemData CreateMainEntryItemData(EntryLevelItemData itemData)
	{
		EntryItemData entryItemData = new EntryItemData(viewModel, itemData.EntryData);
		entryItemData.IsMainEntry = true;
		entryItemData.AllLevel = itemData.CurLevel;
		entryItemData.EntryData.IsFixed = true;
		entryItemData.SetEntryTextType(1);
		return entryItemData;
	}

	private void OnRefresh(object sender, InteractionEventArgs e)
	{
		RefreshOperationButtons();
		RefreshLists();
	}

	private void ShowNameView(object sender, InteractionEventArgs e)
	{
		if (!(nameView == null))
		{
			nameView.gameObject.SetActive(value: true);
			nameView.Init(e?.Context);
		}
	}

	private void HideNameView(object sender, InteractionEventArgs e)
	{
		if (nameView != null)
		{
			nameView.gameObject.SetActive(value: false);
		}
	}

	private void ShowApplyView(object sender, InteractionEventArgs e)
	{
		if (!(applyView == null))
		{
			applyView.gameObject.SetActive(value: true);
			applyView.Init(e?.Context);
		}
	}

	private void HideApplyView(object sender, InteractionEventArgs e)
	{
		if (applyView != null)
		{
			applyView.gameObject.SetActive(value: false);
		}
	}

	protected override void OnDismiss()
	{
		viewModel?.NotifyAppliedPresetClosed();
		base.OnDismiss();
	}
}
