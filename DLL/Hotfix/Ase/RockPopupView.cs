using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockPopupView : UGuiView
{
	[SerializeField]
	private Button btnMask;

	[SerializeField]
	private RectTransform mainPanel;

	[SerializeField]
	private GameObject upTitleObj;

	[SerializeField]
	private GameObject newTitleObj;

	[SerializeField]
	private Image titleBg;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private TextMeshProUGUI armourName;

	[SerializeField]
	private Image armourImg;

	[SerializeField]
	private Image entryImg;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private TabItemNormal lockBtn;

	[SerializeField]
	private GameObject lockIcon;

	[SerializeField]
	private GameObject unlockIcon;

	[SerializeField]
	private LoopListView2 developEntryList;

	[SerializeField]
	private LoopListView2 entryList;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private EquipWearerItem equipWearerItem;

	private RockPopupViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<RockPopupViewModel>(userData);
		BindingSet<RockPopupView, RockPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((RockPopupView v) => v.OnVisibleChanged).To((RockPopupViewModel vm) => vm.VisibleRequest);
		if (mainPanel != null)
		{
			bindingSet.Bind(mainPanel).For((RectTransform v) => v.anchoredPosition).To((RockPopupViewModel vm) => vm.ShowPos);
		}
		if (btnMask != null)
		{
			bindingSet.Bind(btnMask.gameObject).For((GameObject v) => v.activeSelf).To((RockPopupViewModel vm) => vm.ShowOutsideMask);
			bindingSet.Bind(btnMask).For((Button v) => v.onClick).To((RockPopupViewModel vm) => vm.Hide);
		}
		bindingSet.Bind<TextMeshProUGUI>(armourName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockPopupViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((RockPopupViewModel vm) => $"RANK*{vm.ArmourData.Rank}");
		bindingSet.Bind(armourImg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(entryImg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => vm.EntryIconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind(titleBg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => $"Prop_Title_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((RockPopupViewModel vm) => $"Prop_Bg_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		if (upTitleObj != null)
		{
			bindingSet.Bind(upTitleObj).For((GameObject v) => v.activeSelf).ToExpression((RockPopupViewModel vm) => vm.TitleType == 1);
		}
		if (newTitleObj != null)
		{
			bindingSet.Bind(newTitleObj).For((GameObject v) => v.activeSelf).ToExpression((RockPopupViewModel vm) => vm.TitleType == 2);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((RockPopupViewModel vm) => vm.SelectOnClick);
		}
		if (selectObj != null)
		{
			bindingSet.Bind(selectObj).For((GameObject v) => v.activeSelf).To((RockPopupViewModel vm) => vm.IsSelect);
		}
		if (lockBtn != null)
		{
			lockBtn.Init(viewModel.LockBtn);
			bindingSet.Bind(lockBtn.gameObject).For((GameObject v) => v.activeSelf).To((RockPopupViewModel vm) => vm.ShowLockBtn);
		}
		if (lockIcon != null)
		{
			bindingSet.Bind(lockIcon).For((GameObject v) => v.activeSelf).ToExpression((RockPopupViewModel vm) => vm.ShowLockBtn && vm.ArmourData.IsLock);
		}
		if (unlockIcon != null)
		{
			bindingSet.Bind(unlockIcon).For((GameObject v) => v.activeSelf).ToExpression((RockPopupViewModel vm) => vm.ShowLockBtn && !vm.ArmourData.IsLock);
		}
		bindingSet.Bind().For((RockPopupView v) => v.RefreshEntryList).To((RockPopupViewModel vm) => vm.RefreshEntryRequest);
		bindingSet.Bind().For((RockPopupView v) => v.GetPosition).To((RockPopupViewModel vm) => vm.GetPositionXRequest);
		bindingSet.Bind(this).For((RockPopupView v) => v.ShowEntryDetail).To((RockPopupViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(this).For((RockPopupView v) => v.HideEntryDetail).To((RockPopupViewModel vm) => vm.HideEntryDetailRequest);
		bindingSet.Build();
		entryList.InitListView(viewModel.EntryItemDataList.Count, OnGetEntryItemByIndex);
		developEntryList.InitListView(viewModel.DevelopEntryItemDataList.Count, OnGetDevelopEntryItemByIndex);
		entryList.gameObject.SetActive(viewModel.EntryItemDataList.Count > 0);
		developEntryList.gameObject.SetActive(viewModel.DevelopEntryItemDataList.Count > 0);
		if (entryInfoView != null)
		{
			entryInfoView.Init();
		}
		if (equipWearerItem != null)
		{
			equipWearerItem.Init(viewModel.EquipWearerItemData);
		}
	}

	protected override void OnVisibilityChanged()
	{
		base.OnVisibilityChanged();
		if (Visibility)
		{
			RefreshEntryList();
		}
	}

	private void RefreshEntryList(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel?.EntryItemDataList != null && !(entryList == null))
		{
			entryList.gameObject.SetActive(viewModel.EntryItemDataList.Count > 0);
			entryList.SetListItemCount(viewModel.EntryItemDataList.Count);
			entryList.RefreshAllShownItem();
		}
	}

	private void GetPosition(object sender, InteractionEventArgs e)
	{
		viewModel.SetPositionX(base.gameObject.GetComponent<RectTransform>().localPosition.x);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		if (!(entryInfoView == null))
		{
			entryInfoView.gameObject.SetActive(value: true);
			EntryItemData entryItemData = (EntryItemData)e.Context;
			entryInfoView.Show(entryItemData, null, !entryItemData.IsMainEntry);
		}
	}

	private void HideEntryDetail(object sender, InteractionEventArgs e)
	{
		if (!(entryInfoView == null))
		{
			entryInfoView.Hide();
		}
	}

	private LoopListViewItem2 OnGetEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.EntryItemDataList.Count)
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
				component.Init(viewModel.EntryItemDataList[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.EntryItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetDevelopEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.DevelopEntryItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("RockDevelopEntryItem");
		if (loopListViewItem != null)
		{
			RockDevelopEntryItem component = loopListViewItem.GetComponent<RockDevelopEntryItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.DevelopEntryItemDataList[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.DevelopEntryItemDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
