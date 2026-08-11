using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryLevelItem : UGuiView
{
	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryLvText;

	[SerializeField]
	private GameObject warningItem;

	[SerializeField]
	private TextMeshProUGUI exLevelText;

	[SerializeField]
	private Image bgFillImg;

	[SerializeField]
	private Image normalFillImg;

	[SerializeField]
	private Image maxLevelFillImg;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private TextMeshProUGUI entryName2;

	[SerializeField]
	private GameObject levelObj;

	[SerializeField]
	private GameObject specialObj;

	[SerializeField]
	private GameObject fixedObj;

	[SerializeField]
	private GameObject mainObj;

	[SerializeField]
	private Transform spaceRootObj;

	[SerializeField]
	private GameObject spaceItem;

	[SerializeField]
	private GameObject selected;

	public bool IsInit;

	public EntryLevelItemData viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<EntryLevelItemData>(userData);
		BindingSet<EntryLevelItem, EntryLevelItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(entryIcon).For((Image v) => v.sprite).ToExpression((EntryLevelItemData vm) => vm.EntryIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.EntryName);
		bindingSet.Bind<TextMeshProUGUI>(entryLvText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.EntryLevelText);
		bindingSet.Bind(levelObj).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.ShowLevel);
		bindingSet.Bind<TextMeshProUGUI>(entryName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.EntryName2);
		if (warningItem != null)
		{
			bindingSet.Bind(warningItem).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.IsShowWarningItem);
			bindingSet.Bind<TextMeshProUGUI>(exLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.ExLevelText);
		}
		if (specialObj != null)
		{
			bindingSet.Bind(specialObj).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.EntryData.IsSpecial);
		}
		if (fixedObj != null)
		{
			bindingSet.Bind(fixedObj).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.EntryData.IsFixed);
		}
		if (mainObj != null)
		{
			bindingSet.Bind(mainObj).For((GameObject v) => v.activeSelf).ToExpression((EntryLevelItemData vm) => !vm.ShowLevel);
		}
		if (btn != null)
		{
			btn.onClick.AddListener(ShowEntry);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.Selected);
		}
		bindingSet.Bind(bgFillImg).For((Image v) => v.fillAmount).To((EntryLevelItemData vm) => vm.BgFillAmount);
		bindingSet.Bind(normalFillImg).For((Image v) => v.fillAmount).To((EntryLevelItemData vm) => vm.FillAmount);
		bindingSet.Bind(maxLevelFillImg).For((Image v) => v.fillAmount).To((EntryLevelItemData vm) => vm.MaxFillAmount);
		bindingSet.Build();
		IsInit = true;
	}

	public void InitItem(EntryLevelItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<EntryLevelItem, EntryLevelItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(entryIcon).For((Image v) => v.sprite).ToExpression((EntryLevelItemData vm) => vm.EntryIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.EntryName);
		bindingSet.Bind<TextMeshProUGUI>(entryLvText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.EntryLevelText);
		bindingSet.Bind(levelObj).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.ShowLevel);
		bindingSet.Bind<TextMeshProUGUI>(entryName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.EntryName2);
		if (warningItem != null)
		{
			bindingSet.Bind(warningItem).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.IsShowWarningItem);
			bindingSet.Bind<TextMeshProUGUI>(exLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryLevelItemData vm) => vm.ExLevelText);
		}
		if (specialObj != null)
		{
			bindingSet.Bind(specialObj).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.EntryData.IsSpecial);
		}
		if (fixedObj != null)
		{
			bindingSet.Bind(fixedObj).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.EntryData.IsFixed);
		}
		if (mainObj != null)
		{
			bindingSet.Bind(mainObj).For((GameObject v) => v.activeSelf).ToExpression((EntryLevelItemData vm) => !vm.ShowLevel);
		}
		if (btn != null)
		{
			btn.onClick.AddListener(ShowEntry);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((EntryLevelItemData vm) => vm.Selected);
		}
		bindingSet.Bind(bgFillImg).For((Image v) => v.fillAmount).To((EntryLevelItemData vm) => vm.BgFillAmount);
		bindingSet.Bind(normalFillImg).For((Image v) => v.fillAmount).To((EntryLevelItemData vm) => vm.FillAmount);
		bindingSet.Bind(maxLevelFillImg).For((Image v) => v.fillAmount).To((EntryLevelItemData vm) => vm.MaxFillAmount);
		bindingSet.Build();
		IsInit = true;
	}

	private void ShowEntry()
	{
		viewModel.OpenEntryPanel(this);
	}

	public void RefreshEntryLevelItemData(EntryLevelItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void SetSelected(bool selected)
	{
		viewModel.Selected = selected;
	}
}
