using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryValue;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject entryObj;

	[SerializeField]
	private GameObject selRoot;

	[SerializeField]
	private GameObject lockRoot;

	[SerializeField]
	private GameObject specialObj;

	[SerializeField]
	private GameObject fixedObj;

	[SerializeField]
	private GameObject mainObj;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private UIParticlePlayer effectNewEntry;

	[SerializeField]
	private UIParticlePlayer effectUpEntry;

	[SerializeField]
	private UIParticlePlayer effectDownEntry;

	[SerializeField]
	private Button button;

	private EntryItemData _viewModel;

	private Action<EntryItem> _action;

	public EntryItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<EntryItemData>(userData);
		BindingSet<EntryItem, EntryItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (selRoot != null)
		{
			bindingSet.Bind(selRoot).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.IsSelect);
		}
		if (lockRoot != null)
		{
			bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.IsLock);
		}
		bindingSet.Bind(((Component)(object)text).gameObject).For((GameObject v) => v.activeSelf).ToExpression((EntryItemData vm) => !vm.IsEntry);
		bindingSet.Bind(entryObj).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.IsEntry);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((EntryItemData vm) => vm.IconPath)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData vm) => vm.EntryName);
		if ((UnityEngine.Object)(object)entryValue != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData vm) => vm.Level);
		}
		if (specialObj != null)
		{
			bindingSet.Bind(specialObj).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.EntryData.IsSpecial);
		}
		if (fixedObj != null)
		{
			bindingSet.Bind(fixedObj).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.EntryData.IsFixed);
		}
		if (mainObj != null)
		{
			bindingSet.Bind(mainObj).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.IsMainEntry);
		}
		if (emptyObj != null)
		{
			bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((EntryItemData vm) => vm.IsEmpty);
		}
		if (button != null)
		{
			button.onClick.AddListener(delegate
			{
				_action?.Invoke(this);
			});
			bindingSet.Bind(button).For((Button v) => v.onClick).To((EntryItemData vm) => vm.OpenPanelRequest);
			bindingSet.Bind(this).For((EntryItem v) => v.OnShowPanel).To((EntryItemData vm) => vm.OpenEntryPanelRequest);
		}
		bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData vm) => vm.Text);
		bindingSet.Bind(this).For((EntryItem v) => v.PlayEffect).To((EntryItemData vm) => vm.PlayEffectRequest);
		bindingSet.Bind(this).For((EntryItem v) => v.CloseEffect).To((EntryItemData vm) => vm.CloseEffectRequest);
		bindingSet.Build();
	}

	public void RefreshEntryItemData(EntryItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
		if (effectNewEntry != null)
		{
			effectNewEntry.gameObject.SetActive(value: false);
		}
		if (effectUpEntry != null)
		{
			effectUpEntry.gameObject.SetActive(value: false);
		}
		if (effectDownEntry != null)
		{
			effectDownEntry.gameObject.SetActive(value: false);
		}
	}

	public void PlayEffect(object sender, InteractionEventArgs e)
	{
		int num = (int)e.Context;
		effectNewEntry.gameObject.SetActive(value: false);
		if (_viewModel.EffectIndex != 0 && !_viewModel.IsMainEntry)
		{
			switch (num)
			{
			case 1:
				effectNewEntry.Hide();
				effectNewEntry.gameObject.SetActive(value: true);
				effectNewEntry.Play();
				break;
			case 2:
				effectUpEntry.Hide();
				effectUpEntry.gameObject.SetActive(value: true);
				effectUpEntry.Play();
				break;
			case 3:
				effectDownEntry.Hide();
				effectDownEntry.gameObject.SetActive(value: true);
				effectDownEntry.Play();
				break;
			}
		}
	}

	public void CloseEffect(object sender, InteractionEventArgs e)
	{
		effectNewEntry.Hide();
		effectUpEntry.Hide();
		effectDownEntry.Hide();
	}

	public void SetOnClickAction(Action<EntryItem> action)
	{
		_action = action;
	}

	public void OnShowPanel(object sender, InteractionEventArgs e)
	{
		_viewModel.OnShowEntryPanel(this);
	}
}
