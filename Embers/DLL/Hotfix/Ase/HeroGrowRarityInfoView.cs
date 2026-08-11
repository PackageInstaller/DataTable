using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroGrowRarityInfoView : UGuiView
{
	[SerializeField]
	private GameObject upgradeRoot;

	[SerializeField]
	private Image seatIcon1;

	[SerializeField]
	private TextMeshProUGUI seatName1;

	[SerializeField]
	private Image seatIcon2;

	[SerializeField]
	private TextMeshProUGUI seatName2;

	[SerializeField]
	private GameObject lightPointRoot;

	[SerializeField]
	private Image pointIcon;

	[SerializeField]
	private GameObject extraEffectRoot;

	[SerializeField]
	private TextMeshProUGUI effectDesc;

	[SerializeField]
	private TextMeshProUGUI affixNames;

	[SerializeField]
	private TextMeshProUGUI affixValues;

	[SerializeField]
	private TextMeshProUGUI pointAffixNames;

	[SerializeField]
	private TextMeshProUGUI pointAffixValues;

	[SerializeField]
	private List<GameObject> hideGosInPreview;

	[SerializeField]
	private GameObject costRoot;

	[SerializeField]
	private KnapsackItemNew costProp;

	[SerializeField]
	private StateItem button;

	[SerializeField]
	private TextMeshProUGUI buttonText;

	[SerializeField]
	private Button outsideBtn;

	[SerializeField]
	private GameObject decoObj;

	[SerializeField]
	private GameObject propRoot;

	[SerializeField]
	private GameObject hideBtnRoot;

	private HeroGrowRarityInfoViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroGrowRarityInfoViewModel>(userData);
		costProp.Init(_viewModel.CostPropData);
		BindingSet<HeroGrowRarityInfoView, HeroGrowRarityInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(upgradeRoot.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 2);
		bindingSet.Bind(lightPointRoot.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 1);
		bindingSet.Bind(extraEffectRoot.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 2);
		bindingSet.Bind(seatIcon1).For((Image v) => v.sprite).To((HeroGrowRarityInfoViewModel vm) => vm.SeatIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(seatName1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.SeatName1);
		bindingSet.Bind(seatIcon2).For((Image v) => v.sprite).To((HeroGrowRarityInfoViewModel vm) => vm.SeatIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(seatName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.SeatName2);
		bindingSet.Bind(pointIcon).For((Image v) => v.sprite).To((HeroGrowRarityInfoViewModel vm) => vm.PointIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(effectDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.EffectDesc);
		bindingSet.Bind<TextMeshProUGUI>(affixNames).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.AffixNames);
		bindingSet.Bind<TextMeshProUGUI>(affixValues).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.AffixValues);
		bindingSet.Bind(((Component)(object)affixNames).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 2);
		bindingSet.Bind(((Component)(object)affixValues).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 2);
		bindingSet.Bind<TextMeshProUGUI>(pointAffixNames).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.AffixNames);
		bindingSet.Bind<TextMeshProUGUI>(pointAffixValues).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.AffixValues);
		bindingSet.Bind(((Component)(object)pointAffixNames).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 1);
		bindingSet.Bind(((Component)(object)pointAffixValues).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.OptType == 1);
		if (_viewModel.IsSelf)
		{
			bindingSet.Bind(costRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => (int)vm.ItemState != 4);
		}
		if (!_viewModel.IsSelf)
		{
			bindingSet.Bind(decoObj).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.IsSelf);
			bindingSet.Bind(propRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.IsSelf);
			bindingSet.Bind(hideBtnRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroGrowRarityInfoViewModel vm) => vm.IsSelf);
		}
		bindingSet.Bind(button).For((StateItem v) => v.onClick).To((HeroGrowRarityInfoViewModel vm) => vm.LightCmd);
		bindingSet.Bind(button).For((StateItem v) => v.CurState).To((HeroGrowRarityInfoViewModel vm) => vm.ButtonState);
		bindingSet.Bind<TextMeshProUGUI>(buttonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGrowRarityInfoViewModel vm) => vm.ButtonText);
		bindingSet.Bind<TextMeshProUGUI>(buttonText).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((HeroGrowRarityInfoViewModel vm) => vm.ButtonTextColor);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((HeroGrowRarityInfoViewModel vm) => vm.Hide);
		bindingSet.Build();
	}

	public void SetInPreviewMode(bool inPreview)
	{
		if (hideGosInPreview == null)
		{
			return;
		}
		foreach (GameObject item in hideGosInPreview)
		{
			if (item != null)
			{
				item.SetActive(!inPreview);
			}
		}
	}
}
