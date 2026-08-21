using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourFilterView : UGuiView
{
	[SerializeField]
	private GameObject filterRoot;

	[SerializeField]
	private LoopListView2 filterList;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnReset;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[Header("Filter Grid Layout")]
	[SerializeField]
	private float otherHeight;

	[SerializeField]
	private float itemHeight;

	[SerializeField]
	private float padding;

	private ArmourFilterSubViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<ArmourFilterSubViewModel>(userData);
		BindingSet<ArmourFilterView, ArmourFilterSubViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (btnClose != null)
		{
			bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((ArmourFilterSubViewModel vm) => vm.OptCommand)
				.CommandParameter("CloseFilterView");
		}
		if (btnReset != null)
		{
			bindingSet.Bind(btnReset).For((Button v) => v.onClick).To((ArmourFilterSubViewModel vm) => vm.OptCommand)
				.CommandParameter("ResetFilter");
		}
		if (btnConfirm != null)
		{
			bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((ArmourFilterSubViewModel vm) => vm.OptCommand)
				.CommandParameter("ConfirmFilter");
		}
		bindingSet.Bind(this).For((ArmourFilterView v) => v.OnOpt).To((ArmourFilterSubViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		if (entryInfoView != null)
		{
			entryInfoView.Init();
			entryInfoView.gameObject.SetActive(value: false);
		}
		if (filterList != null)
		{
			filterList.InitListView(viewModel.FilterTypes.Count * 2, OnGetFilterItemByIndex);
		}
		SetVisible(visible: false);
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ArmourFilterSubViewModel>(userData);
		this.SetDataContext(viewModel);
		if (filterList != null)
		{
			RefreshFilterList();
		}
	}

	public void SetVisible(bool visible)
	{
		GameObject gameObject = ((filterRoot != null) ? filterRoot : base.gameObject);
		if (gameObject != null)
		{
			gameObject.SetActive(visible);
		}
	}

	public void HideEntryInfo()
	{
		if (entryInfoView != null)
		{
			entryInfoView.Hide();
		}
	}

	public bool UsesEntryInfoView(EntryInfoView view)
	{
		if (view != null)
		{
			return entryInfoView == view;
		}
		return false;
	}

	public void RefreshFilterList()
	{
		if (!(filterList == null) && viewModel != null)
		{
			filterList.SetListItemCount(viewModel.FilterTypes.Count * 2);
			filterList.RefreshAllShownItem();
		}
	}

	public void ShowFilterEntryInfo()
	{
		if (!(entryInfoView == null) && viewModel != null)
		{
			EntryItemData filterEntryItemData = viewModel.FilterEntryItemData;
			if (filterEntryItemData != null)
			{
				entryInfoView.Show(filterEntryItemData);
			}
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("CloseFilterView".Equals(optName))
		{
			HideEntryInfo();
			SetVisible(visible: false);
		}
		else if ("RefreshFilterList".Equals(optName))
		{
			RefreshFilterList();
		}
		else if ("ShowFilterEntryInfo".Equals(optName))
		{
			ShowFilterEntryInfo();
		}
	}

	private LoopListViewItem2 OnGetFilterItemByIndex(LoopListView2 listView2, int index)
	{
		if (viewModel == null)
		{
			return null;
		}
		int num = viewModel.FilterTypes.Count * 2;
		if (index < 0 || index >= num)
		{
			return null;
		}
		int num2 = index / 2;
		ReportItemViewModel userData = viewModel.FilterTypes[num2];
		if (index % 2 == 0)
		{
			LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TitleItem");
			if (loopListViewItem != null)
			{
				ReportItemView component = loopListViewItem.GetComponent<ReportItemView>();
				if (!loopListViewItem.IsInitHandlerCalled)
				{
					loopListViewItem.IsInitHandlerCalled = true;
					component.Init(userData);
				}
				else
				{
					component.RefreshData(userData);
				}
			}
			return loopListViewItem;
		}
		LoopListViewItem2 loopListViewItem2 = listView2.NewListViewItem("ScrollViewItem");
		if (loopListViewItem2 == null)
		{
			return null;
		}
		LoopGridView loopGridView = loopListViewItem2.GetComponent<LoopGridView>() ?? loopListViewItem2.GetComponentInChildren<LoopGridView>();
		if (loopGridView == null)
		{
			return loopListViewItem2;
		}
		List<ArmourFilterOptionViewModel> filterOptionViewModelsByIndex = viewModel.GetFilterOptionViewModelsByIndex(num2);
		ArmourFilterGridContext armourFilterGridContext = loopGridView.GetComponent<ArmourFilterGridContext>();
		if (armourFilterGridContext == null)
		{
			armourFilterGridContext = loopGridView.gameObject.AddComponent<ArmourFilterGridContext>();
		}
		armourFilterGridContext.TypeIndex = num2;
		AdaptFilterGridHeight(loopListViewItem2, loopGridView, filterOptionViewModelsByIndex.Count);
		if (!loopGridView.MListViewInited)
		{
			loopGridView.InitGridView(filterOptionViewModelsByIndex.Count, OnGetFilterOptionByIndex);
		}
		else
		{
			loopGridView.SetListItemCount(filterOptionViewModelsByIndex.Count);
			loopGridView.RefreshAllShownItem();
		}
		return loopListViewItem2;
	}

	private LoopGridViewItem OnGetFilterOptionByIndex(LoopGridView gridView, int index, int row, int column)
	{
		int typeIndex = 0;
		ArmourFilterGridContext armourFilterGridContext = ((gridView != null) ? gridView.GetComponent<ArmourFilterGridContext>() : null);
		if (armourFilterGridContext != null)
		{
			typeIndex = armourFilterGridContext.TypeIndex;
		}
		List<ArmourFilterOptionViewModel> filterOptionViewModelsByIndex = viewModel.GetFilterOptionViewModelsByIndex(typeIndex);
		if (index < 0 || index >= filterOptionViewModelsByIndex.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("ReportItemView");
		if (loopGridViewItem != null)
		{
			ReportItemView component = loopGridViewItem.GetComponent<ReportItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(filterOptionViewModelsByIndex[index]);
			}
			else
			{
				component.RefreshData(filterOptionViewModelsByIndex[index]);
			}
		}
		return loopGridViewItem;
	}

	private void AdaptFilterGridHeight(LoopListViewItem2 scrollItem, LoopGridView gridView, int optionCount)
	{
		if (gridView == null || scrollItem == null)
		{
			return;
		}
		int num = 0;
		if (optionCount > 0)
		{
			num = gridView.GetRowColumnByItemIndex(optionCount - 1).mRow + 1;
		}
		float num2 = ((itemHeight > 0f) ? itemHeight : gridView.ItemSize.y);
		float num3 = ((padding > 0f) ? padding : gridView.ItemPadding.y);
		if (num2 <= 0f)
		{
			GridViewItemPrefabConfData itemPrefabConfData = gridView.GetItemPrefabConfData("ReportItemView");
			if (itemPrefabConfData != null && itemPrefabConfData.mItemPrefab != null)
			{
				RectTransform component = itemPrefabConfData.mItemPrefab.GetComponent<RectTransform>();
				if (component != null)
				{
					num2 = ((component.sizeDelta.y > 0f) ? component.sizeDelta.y : component.rect.size.y);
				}
			}
		}
		float b = otherHeight + (float)num * num2 + (float)Mathf.Max(0, num - 1) * num3;
		b = Mathf.Max(0f, b);
		RectTransform component2 = gridView.GetComponent<RectTransform>();
		if (component2 != null)
		{
			component2.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, b);
		}
		scrollItem.CachedRectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, b);
	}
}
