using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinShopItem : HeroSkinItem
{
	[SerializeField]
	protected Image priceIcon;

	[SerializeField]
	protected TextMeshProUGUI finalPrice;

	[SerializeField]
	protected TextMeshProUGUI oriPrice;

	[SerializeField]
	protected GameObject discountGo;

	[SerializeField]
	protected TextMeshProUGUI discountText;

	[SerializeField]
	protected GameObject boughtGo;

	[SerializeField]
	protected GameObject buyLimitGo;

	[SerializeField]
	protected GameObject offSaleGo;

	[SerializeField]
	protected TextMeshProUGUI offSaleTime;

	private HeroSkinShopItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroSkinShopItemData>(userData);
		BindingSet<HeroSkinShopItem, HeroSkinShopItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (priceIcon != null)
		{
			bindingSet.Bind(priceIcon).For((Image v) => v.sprite).To((HeroSkinShopItemData vm) => vm.PriceIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)finalPrice != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(finalPrice).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinShopItemData vm) => vm.FinalPrice);
		}
		if ((UnityEngine.Object)(object)oriPrice != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(oriPrice).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinShopItemData vm) => vm.OriPrice);
			bindingSet.Bind(((Component)(object)oriPrice).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinShopItemData vm) => !string.IsNullOrEmpty(vm.OriPrice));
		}
		if (discountGo != null)
		{
			bindingSet.Bind(discountGo).For((GameObject v) => v.activeSelf).To((HeroSkinShopItemData vm) => vm.ShowDiscount);
		}
		if ((UnityEngine.Object)(object)discountText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(discountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinShopItemData vm) => vm.DiscountText);
		}
		if (boughtGo != null)
		{
			bindingSet.Bind(boughtGo).For((GameObject v) => v.activeSelf).To((HeroSkinShopItemData vm) => vm.Bought);
		}
		if (buyLimitGo != null)
		{
			bindingSet.Bind(buyLimitGo).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinShopItemData vm) => !vm.Bought);
		}
		if (offSaleGo != null)
		{
			bindingSet.Bind(offSaleGo).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinShopItemData vm) => !string.IsNullOrEmpty(vm.RefreshTimeText));
		}
		if ((UnityEngine.Object)(object)offSaleTime != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(offSaleTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinShopItemData vm) => vm.RefreshTimeText);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is HeroSkinShopItemData heroSkinShopItemData)
		{
			_viewModel = heroSkinShopItemData;
			this.SetDataContext(heroSkinShopItemData);
		}
	}
}
