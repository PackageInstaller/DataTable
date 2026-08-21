using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockDevelopEntryItem : UGuiView
{
	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryLevel;

	[SerializeField]
	private GameObject specialObj;

	[SerializeField]
	private GameObject fixedObj;

	[SerializeField]
	private GameObject mainObj;

	[SerializeField]
	private GameObject newEntry;

	[SerializeField]
	private GameObject disMissEntry;

	[SerializeField]
	private GameObject entryUpLevel;

	[SerializeField]
	private GameObject entryDownLevel;

	[SerializeField]
	private Button button;

	private RockDevelopEntryItemData viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<RockDevelopEntryItemData>(userData);
		BindingSet<RockDevelopEntryItem, RockDevelopEntryItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(entryIcon).For((Image v) => v.sprite).ToExpression((RockDevelopEntryItemData vm) => vm.EntryIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopEntryItemData vm) => vm.EntryName);
		bindingSet.Bind<TextMeshProUGUI>(entryLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopEntryItemData vm) => vm.EntryLevel);
		if (specialObj != null)
		{
			bindingSet.Bind(specialObj).For((GameObject v) => v.activeSelf).To((RockDevelopEntryItemData vm) => vm.EntryData.IsSpecial);
		}
		if (fixedObj != null)
		{
			bindingSet.Bind(fixedObj).For((GameObject v) => v.activeSelf).To((RockDevelopEntryItemData vm) => vm.EntryData.IsFixed);
		}
		if (mainObj != null)
		{
			bindingSet.Bind(mainObj).For((GameObject v) => v.activeSelf).To((RockDevelopEntryItemData vm) => vm.IsMainEntry);
		}
		bindingSet.Bind(newEntry).For((GameObject v) => v.activeSelf).To((RockDevelopEntryItemData vm) => vm.IsNewEntry);
		bindingSet.Bind(disMissEntry).For((GameObject v) => v.activeSelf).To((RockDevelopEntryItemData vm) => vm.IsDismiss);
		bindingSet.Bind(entryUpLevel).For((GameObject v) => v.activeSelf).ToExpression((RockDevelopEntryItemData vm) => vm.NewLevel > vm.OldLevel);
		bindingSet.Bind(entryDownLevel).For((GameObject v) => v.activeSelf).ToExpression((RockDevelopEntryItemData vm) => vm.NewLevel < vm.OldLevel);
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((RockDevelopEntryItemData vm) => vm.OpenEntryPanel);
		}
		bindingSet.Build();
	}

	public void RefreshEntryItemData(RockDevelopEntryItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
