using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinExchangeView : UGuiView
{
	[SerializeField]
	private Image skinIcon;

	[SerializeField]
	private TextMeshProUGUI skinName;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private TextMeshProUGUI skinDesc;

	[SerializeField]
	private TextMeshProUGUI quota;

	[SerializeField]
	private Image priceIcon;

	[SerializeField]
	private TextMeshProUGUI priceCount;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private GameObject btnConfirmMask;

	[SerializeField]
	private TextMeshProUGUI btnConfirmText;

	private HeroSkinExchangeViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroSkinExchangeViewModel>(userData);
		BindingSet<HeroSkinExchangeView, HeroSkinExchangeViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(skinIcon).For((Image v) => v.sprite).To((HeroSkinExchangeViewModel vm) => vm.SkinIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinExchangeViewModel vm) => vm.SkinName);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinExchangeViewModel vm) => vm.HeroName);
		bindingSet.Bind<TextMeshProUGUI>(skinDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinExchangeViewModel vm) => vm.SkinDesc);
		bindingSet.Bind<TextMeshProUGUI>(quota).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinExchangeViewModel vm) => vm.Quota);
		bindingSet.Bind(priceIcon).For((Image v) => v.sprite).To((HeroSkinExchangeViewModel vm) => vm.PriceIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(priceCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinExchangeViewModel vm) => vm.PriceCount);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((HeroSkinExchangeViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirm).For((Button v) => v.enabled).To((HeroSkinExchangeViewModel vm) => vm.ConfirmEnabled);
		bindingSet.Bind(btnConfirmMask).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinExchangeViewModel vm) => !vm.ConfirmEnabled);
		bindingSet.Bind<TextMeshProUGUI>(btnConfirmText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinExchangeViewModel vm) => vm.ConfirmText);
		bindingSet.Build();
		btnOutside.onClick.AddListener(delegate
		{
			Visibility = false;
		});
		btnClose.onClick.AddListener(delegate
		{
			Visibility = false;
		});
	}
}
