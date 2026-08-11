using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourPopupSampleView : UGuiWindow
{
	[SerializeField]
	private Button outsideBtn;

	[SerializeField]
	private Image titleBg;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private TextMeshProUGUI armourName;

	[SerializeField]
	private Image armourImg;

	[SerializeField]
	private TextMeshProUGUI type;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private LoopListView2 entryList;

	[SerializeField]
	private EntryInfoView entryInfoView;

	private ArmourPopupViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourPopupViewModel>();
		BindingSet<ArmourPopupSampleView, ArmourPopupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ArmourPopupSampleView v) => v.CloseWindow).To((ArmourPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(armourName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourPopupViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourPopupViewModel vm) => $"RANK*{vm.ArmourData.Rank}");
		bindingSet.Bind(armourImg).For((Image v) => v.sprite).ToExpression((ArmourPopupViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(titleBg).For((Image v) => v.sprite).ToExpression((ArmourPopupViewModel vm) => $"Prop_Title_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((ArmourPopupViewModel vm) => $"Prop_Bg_{vm.ArmourData.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(type).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourPopupViewModel vm) => vm.Type);
		bindingSet.Bind(outsideBtn.gameObject).For((GameObject v) => v.activeSelf).To((ArmourPopupViewModel vm) => vm.ShowOutsideMask);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((ArmourPopupViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((ArmourPopupSampleView v) => v.ShowEntryDetail).To((ArmourPopupViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		entryInfoView.Init();
		entryList.InitListView(viewModel.EntryItemData.Count, OnGetEntryItemByIndex);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		entryInfoView.gameObject.SetActive(value: true);
		EntryItem entryItem = (EntryItem)e.Context;
		entryInfoView.Show(entryItem.ViewModel);
	}

	private LoopListViewItem2 OnGetEntryItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.EntryItemData.Count)
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
				component.Init(viewModel.EntryItemData[index]);
			}
			else
			{
				component.RefreshEntryItemData(viewModel.EntryItemData[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
