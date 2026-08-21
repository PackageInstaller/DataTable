using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropPackItem : KnapsackItemNew
{
	[SerializeField]
	private Button openPropPopupBtn;

	[SerializeField]
	private Button selectPropBtn;

	[SerializeField]
	private TextMeshProUGUI propAmountText;

	[SerializeField]
	private TextMeshProUGUI propNameText;

	[SerializeField]
	private Image propIcon;

	[SerializeField]
	private Image propBg;

	[SerializeField]
	private GameObject itemSelected;

	private PropPackItemViewModel viewModel;

	public void Init(PropPackItemViewModel propPackItemViewModel)
	{
		viewModel = propPackItemViewModel;
		Init((KnapsackItemViewModel)propPackItemViewModel);
		BindingSet<PropPackItem, PropPackItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(propIcon).For((Image v) => v.sprite).ToExpression((PropPackItemViewModel vm) => vm.PropDataBase.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(propBg).For((Image v) => v.sprite).ToExpression((PropPackItemViewModel vm) => $"RarityBG_{itemSizeType}_{vm.Quality}")
			.WithConversion("ItemIcon");
		if (itemSelected != null)
		{
			bindingSet.Bind(itemSelected).For((GameObject v) => v.activeSelf).To((PropPackItemViewModel vm) => vm.IsSelected);
		}
		if (openPropPopupBtn != null)
		{
			bindingSet.Bind(openPropPopupBtn).For((Button v) => v.onClick).To((PropPackItemViewModel vm) => vm.OpenPropPopupOnClick);
		}
		if (selectPropBtn != null)
		{
			bindingSet.Bind(selectPropBtn).For((Button v) => v.onClick).To((PropPackItemViewModel vm) => vm.SelectPropOnClick);
		}
		bindingSet.Bind<TextMeshProUGUI>(propAmountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropPackItemViewModel vm) => vm.PropAmount);
		bindingSet.Bind<TextMeshProUGUI>(propNameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropPackItemViewModel vm) => vm.PropDataBase.Name);
		bindingSet.Build();
	}
}
