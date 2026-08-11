using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EquipExpItemNew : UGuiView
{
	[SerializeField]
	private ButtonLong btn;

	[SerializeField]
	private GameObject btnObj;

	[SerializeField]
	private Button normalBtn;

	[SerializeField]
	private GameObject normalBtnObj;

	[SerializeField]
	private GameObject selectedObj;

	[SerializeField]
	private GameObject propSelectedObj;

	[SerializeField]
	private GameObject equipSelectedObj;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject iconObj;

	[SerializeField]
	private Image weaponImg;

	[SerializeField]
	private GameObject weaponImgObj;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private Image bar;

	[SerializeField]
	private GameObject lockImg;

	[SerializeField]
	private TextMeshProUGUI selectedNum;

	[SerializeField]
	private ButtonLong btnReduce;

	[SerializeField]
	private GameObject weaponRoot;

	[SerializeField]
	private Image weaponEnumBg;

	[SerializeField]
	private Image weaponEnumIcon;

	[SerializeField]
	private TextMeshProUGUI weaponRefineText;

	[SerializeField]
	private GameObject armourRoot;

	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI rank;

	private EquipExpItemDataNew _viewModel;

	public void Init(EquipExpItemDataNew equipExpItemDataNew)
	{
		_viewModel = equipExpItemDataNew;
		BindingSet<EquipExpItemNew, EquipExpItemDataNew> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(btn).For((ButtonLong v) => v.onClick).To((EquipExpItemDataNew vm) => vm.BtnOnclick);
		bindingSet.Bind(btnObj).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.Type == 1);
		bindingSet.Bind(normalBtn).For((Button v) => v.onClick).To((EquipExpItemDataNew vm) => vm.BtnOnclick);
		bindingSet.Bind(normalBtnObj).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.Type != 1);
		bindingSet.Bind(selectedObj).For((GameObject v) => v.activeSelf).To((EquipExpItemDataNew vm) => vm.IsSelected);
		bindingSet.Bind(propSelectedObj).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.ItemType == 1);
		bindingSet.Bind(equipSelectedObj).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.ItemType != 1);
		bindingSet.Bind(weaponRoot).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.Type == 2);
		bindingSet.Bind(armourRoot).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.Type == 3);
		bindingSet.Bind(lockImg).For((GameObject v) => v.activeSelf).To((EquipExpItemDataNew vm) => vm.IsLock);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((EquipExpItemDataNew vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (iconObj != null)
		{
			bindingSet.Bind(iconObj).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.Type != 2);
		}
		if (weaponImg != null)
		{
			bindingSet.Bind(weaponImg).For((Image v) => v.sprite).ToExpression((EquipExpItemDataNew vm) => vm.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(weaponImgObj).For((GameObject v) => v.activeSelf).ToExpression((EquipExpItemDataNew vm) => vm.Type == 2);
		}
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((EquipExpItemDataNew vm) => $"RarityBG_Large_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipExpItemDataNew vm) => vm.ShowText);
		bindingSet.Bind<TextMeshProUGUI>(selectedNum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipExpItemDataNew vm) => vm.SelectedNum);
		bindingSet.Bind(btnReduce).For((ButtonLong v) => v.onClick).To((EquipExpItemDataNew vm) => vm.BtnReduce);
		bindingSet.Bind<TextMeshProUGUI>(weaponRefineText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipExpItemDataNew vm) => vm.WeaponRefine);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((EquipExpItemDataNew vm) => $"R{vm.Rank}");
		bindingSet.Bind(rankBg).For((Image v) => v.color).To((EquipExpItemDataNew vm) => vm.RankBgColor);
		bindingSet.Bind(weaponEnumIcon).For((Image v) => v.sprite).ToExpression((EquipExpItemDataNew vm) => $"WeaponEnum_{vm.WeaponEnum}")
			.WithConversion("ItemIcon")
			.OneWay();
		bindingSet.Build();
		btn.onPress.AddListener(AddOnClick);
		btnReduce.onPress.AddListener(ReduceOnClick);
	}

	private void AddOnClick()
	{
		if (_viewModel.ItemType == 1)
		{
			_viewModel.BtnOnclick();
		}
	}

	private void ReduceOnClick()
	{
		if (_viewModel.ItemType == 1)
		{
			_viewModel.BtnReduce();
		}
	}

	public void RefreshData(EquipExpItemDataNew viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
