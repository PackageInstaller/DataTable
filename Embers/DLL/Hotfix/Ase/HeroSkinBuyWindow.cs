using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinBuyWindow : UGuiWindow
{
	[SerializeField]
	private Animator windowAnimator;

	[SerializeField]
	protected Button btnBack;

	[SerializeField]
	private Image skinIcon;

	[SerializeField]
	protected Image priceIcon;

	[SerializeField]
	protected TextMeshProUGUI finalPrice;

	[SerializeField]
	protected TextMeshProUGUI oriPrice;

	[SerializeField]
	protected Button btnBuy;

	[SerializeField]
	protected GameObject bought;

	[SerializeField]
	private GameObject headGo;

	[SerializeField]
	protected Image headIcon;

	[SerializeField]
	protected TextMeshProUGUI skinName;

	[SerializeField]
	protected TextMeshProUGUI heroName;

	[SerializeField]
	protected TextMeshProUGUI skinDesc;

	[SerializeField]
	protected Button btnHideUi;

	[SerializeField]
	protected Button btnShowUi;

	[SerializeField]
	protected Button btnPre;

	[SerializeField]
	protected Button btnNext;

	[SerializeField]
	protected RectTransform skinSpineRoot;

	private string _skinSpinePath;

	private GameObject _skinSpine;

	private HeroSkinBuyViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroSkinBuyViewModel>();
		BindingSet<HeroSkinBuyWindow, HeroSkinBuyViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((HeroSkinBuyWindow v) => v.OpenUguiWindow).To((HeroSkinBuyViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((HeroSkinBuyWindow v) => v.OnDismissRequest).To((HeroSkinBuyViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((HeroSkinBuyWindow v) => v.SetChildViewVisibility).To((HeroSkinBuyViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HeroSkinBuyViewModel vm) => vm.Close);
		bindingSet.Bind(priceIcon).For((Image v) => v.sprite).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.PriceIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(finalPrice).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.FinalPrice);
		bindingSet.Bind<TextMeshProUGUI>(oriPrice).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.OriPrice);
		bindingSet.Bind(((Component)(object)oriPrice).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinBuyViewModel vm) => !string.IsNullOrEmpty(vm.CurShopItemData.OriPrice));
		bindingSet.Bind(skinIcon).For((Image v) => v.sprite).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.SkinName);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.HeroName);
		bindingSet.Bind<TextMeshProUGUI>(skinDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.SkinDesc);
		bindingSet.Bind(headGo).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinBuyViewModel vm) => !string.IsNullOrEmpty(vm.CurShopItemData.HeadIcon));
		bindingSet.Bind(headIcon).For((Image v) => v.sprite).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.HeadIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnBuy.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinBuyViewModel vm) => !vm.CurShopItemData.Bought);
		bindingSet.Bind(btnBuy).For((Button v) => v.onClick).To((HeroSkinBuyViewModel vm) => vm.BuyCmd);
		bindingSet.Bind(bought).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinBuyViewModel vm) => vm.CurShopItemData.Bought);
		bindingSet.Bind(btnPre).For((Button v) => v.onClick).To((HeroSkinBuyViewModel vm) => vm.SwitchPre);
		bindingSet.Bind(btnNext).For((Button v) => v.onClick).To((HeroSkinBuyViewModel vm) => vm.SwitchNext);
		bindingSet.Bind().For((HeroSkinBuyWindow v) => v.LoadSkinSpine).To((HeroSkinBuyViewModel vm) => vm.RefreshSkinSpineRst);
		bindingSet.Build();
		btnShowUi.onClick.AddListener(PlayShowUIAni);
		btnHideUi.onClick.AddListener(PlayHideUIAni);
		LoadSkinSpine();
	}

	private void PlayHideUIAni()
	{
		Animator obj = windowAnimator;
		if (obj != null)
		{
			obj.SetTrigger("hideUI");
		}
	}

	private void PlayShowUIAni()
	{
		Animator obj = windowAnimator;
		if (obj != null)
		{
			obj.SetTrigger("showUI");
		}
	}

	private async void LoadSkinSpine(object sender = null, InteractionEventArgs e = null)
	{
		if (string.IsNullOrEmpty(_viewModel.SkinSpinePath))
		{
			return;
		}
		ClearHeroSpine();
		_skinSpinePath = _viewModel.SkinSpinePath;
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(_skinSpinePath), skinSpineRoot);
		if (!(gameObject == null))
		{
			_skinSpine = gameObject;
			SkeletonGraphic component = _skinSpine.transform.GetChild(0).GetComponent<SkeletonGraphic>();
			if ((UnityEngine.Object)(object)component != null)
			{
				component.freeze = false;
			}
			StreamerMode.ApplySpineSkin(gameObject);
		}
	}

	private void ClearHeroSpine()
	{
		if (_skinSpine != null)
		{
			UnityEngine.Object.DestroyImmediate(_skinSpine);
			_skinSpine = null;
		}
	}

	protected override void OnDestroy()
	{
		ClearHeroSpine();
		base.OnDestroy();
	}
}
