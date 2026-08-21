using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockPopupWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

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
	private LoopListView2 entryList;

	[SerializeField]
	private EntryInfoView entryInfoView;

	private RockPopupViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<RockPopupViewModel>();
		BindingSet<RockPopupWindow, RockPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((RockPopupWindow v) => v.OpenUguiWindow).To((RockPopupViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((RockPopupWindow v) => v.CloseWindow).To((RockPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((RockPopupViewModel vm) => vm.Close);
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
		bindingSet.Bind(this).For((RockPopupWindow v) => v.ShowEntryDetail).To((RockPopupViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		if (lockBtn != null)
		{
			lockBtn.Init(viewModel.LockBtn);
		}
		if (entryInfoView != null)
		{
			entryInfoView.Init();
		}
		entryList.InitListView(viewModel.EntryItemDataList.Count, OnGetEntryItemByIndex);
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

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
