using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponItem : KnapsackItemNew
{
	private WeaponItemData viewModel;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private Image weaponEnumIcon;

	[SerializeField]
	private Image weaponEnumIconBg;

	[SerializeField]
	private TextMeshProUGUI weaponRefine;

	[SerializeField]
	private Image heroIconFrame;

	public void Init(WeaponItemData viewModel)
	{
		this.viewModel = viewModel;
		Init((KnapsackItemViewModel)this.viewModel);
		BindingSet<WeaponItem, WeaponItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((WeaponItemData vm) => vm.Data.IsLock);
		bindingSet.Bind(weaponEnumIcon).For((Image v) => v.sprite).ToExpression((WeaponItemData vm) => $"WeaponEnum_{(int)vm.Data.WeaponEnum}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(weaponEnumIconBg).For((Image v) => v.sprite).ToExpression((WeaponItemData vm) => $"Rarity_WeaponEnumBg_{vm.Data.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(weaponRefine).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WeaponItemData vm) => vm.Refine);
		if (heroIconFrame != null)
		{
			bindingSet.Bind(heroIconFrame).For((Image v) => v.color).To((WeaponItemData vm) => vm.WeaponFrameColor);
		}
		bindingSet.Build();
	}

	public void RefreshData(WeaponItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public static Color WeaponBgColor(int refine)
	{
		string htmlString = "";
		switch (refine)
		{
		case 1:
			htmlString = "#1e3942";
			break;
		case 2:
			htmlString = "#232c4c";
			break;
		case 3:
			htmlString = "#312944";
			break;
		case 4:
			htmlString = "#4a2519";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public static Color WeaponFrameColor(int refine)
	{
		string htmlString = "";
		switch (refine)
		{
		case 1:
			htmlString = "#c6e3d4";
			break;
		case 2:
			htmlString = "#d3e8ff";
			break;
		case 3:
			htmlString = "#e6ecff";
			break;
		case 4:
			htmlString = "#fbd295";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}
}
