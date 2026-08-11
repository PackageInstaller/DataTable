using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryUpgradeItem : UGuiView
{
	[SerializeField]
	private Image entryBg;

	[SerializeField]
	private GameObject entryUpObj;

	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryValue1;

	[SerializeField]
	private TextMeshProUGUI entryValue2;

	[SerializeField]
	private GameObject selRoot;

	[SerializeField]
	private GameObject entryNewObj;

	[SerializeField]
	private TextMeshProUGUI entryName2;

	[SerializeField]
	private TextMeshProUGUI entryValue3;

	[SerializeField]
	private Button button;

	public EntryUpgradeItemData _viewModel;

	public void Init(EntryUpgradeItemData data)
	{
		_viewModel = data;
		BindingSet<EntryUpgradeItem, EntryUpgradeItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(entryBg).For((Image v) => v.color).To((EntryUpgradeItemData vm) => vm.Color);
		bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryUpgradeItemData vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(entryValue1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryUpgradeItemData vm) => vm.ShowValue1);
		bindingSet.Bind<TextMeshProUGUI>(entryValue2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryUpgradeItemData vm) => vm.ShowValue2);
		bindingSet.Bind<TextMeshProUGUI>(entryName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryUpgradeItemData vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(entryValue3).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryUpgradeItemData vm) => vm.ShowValue1);
		if (selRoot != null)
		{
			bindingSet.Bind(selRoot).For((GameObject v) => v.activeSelf).To((EntryUpgradeItemData vm) => vm.IsSelect);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((EntryUpgradeItemData vm) => vm.OpenPanelRequest);
			bindingSet.Bind(this).For((EntryUpgradeItem v) => v.OnShowPanel).To((EntryUpgradeItemData vm) => vm.OpenEntryPanelRequest);
		}
		bindingSet.Build();
		SetActive();
	}

	public void OnShowPanel(object sender, InteractionEventArgs e)
	{
		_viewModel.OnShowEntryPanel(this);
	}

	private void SetActive()
	{
		if (_viewModel != null)
		{
			if (entryUpObj != null)
			{
				entryUpObj.SetActive(!_viewModel.IsNew);
			}
			if (entryNewObj != null)
			{
				entryNewObj.SetActive(_viewModel.IsNew);
			}
		}
	}

	public void Refresh(EntryUpgradeItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
		SetActive();
	}
}
