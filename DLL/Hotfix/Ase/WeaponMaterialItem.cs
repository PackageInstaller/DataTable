using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponMaterialItem : UGuiView
{
	[SerializeField]
	private Image weaponIcon;

	[SerializeField]
	private Image typeIcon;

	[SerializeField]
	private Image rarityIcon;

	[SerializeField]
	private TextMeshProUGUI refineText;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private GameObject selecteObj;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject lockObj;

	private WeaponMaterialItemData viewModel;

	public void Init(WeaponMaterialItemData viewModel)
	{
		this.viewModel = viewModel;
		Init((object)this.viewModel);
		BindingSet<WeaponMaterialItem, WeaponMaterialItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(weaponIcon).For((Image v) => v.sprite).ToExpression((WeaponMaterialItemData vm) => vm.WeaponIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(typeIcon).For((Image v) => v.sprite).ToExpression((WeaponMaterialItemData vm) => $"WeaponEnum_{(int)vm.WeaponEnum}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarityIcon).For((Image v) => v.sprite).ToExpression((WeaponMaterialItemData vm) => $"Rarity_Middle_{vm.WeaponRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(refineText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponMaterialItemData vm) => vm.WeaponRefine);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((WeaponMaterialItemData vm) => $"Lv.{vm.WeaponLevel}");
		bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((WeaponMaterialItemData vm) => vm.IsEmpty);
		if (selecteObj != null)
		{
			bindingSet.Bind(selecteObj).For((GameObject v) => v.activeSelf).To((WeaponMaterialItemData vm) => vm.IsSelected);
		}
		if (lockObj != null)
		{
			bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((WeaponMaterialItemData vm) => vm.IsLock);
		}
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((WeaponMaterialItemData vm) => vm.OnClick);
		bindingSet.Build();
	}

	public void RefreshWeaponMaterialData(WeaponMaterialItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
