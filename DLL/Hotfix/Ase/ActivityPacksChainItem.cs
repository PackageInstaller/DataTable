using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityPacksChainItem : UGuiView
{
	[SerializeField]
	private GameObject packsIndexGo;

	[SerializeField]
	private TextMeshProUGUI packsIndex;

	[SerializeField]
	private KnapsackItemNew reward;

	[SerializeField]
	private Image packsPriceIcon;

	[SerializeField]
	private GameObject packsCashPriceIcon;

	[SerializeField]
	private TextMeshProUGUI packsPriceText;

	[SerializeField]
	private GameObject locked;

	[SerializeField]
	private GameObject bought;

	[SerializeField]
	private Button btnBuy;

	private ActivityPacksChainItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ActivityPacksChainItemData>(userData);
		BindingSet<ActivityPacksChainItem, ActivityPacksChainItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(packsIndex).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPacksChainItemData vm) => vm.PacksIndex);
		bindingSet.Bind(packsPriceIcon).For((Image v) => v.sprite).To((ActivityPacksChainItemData vm) => vm.PriceIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(packsPriceIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ActivityPacksChainItemData vm) => !vm.IsCashPrice && !string.IsNullOrEmpty(vm.PriceIcon));
		bindingSet.Bind(packsCashPriceIcon).For((GameObject v) => v.activeSelf).To((ActivityPacksChainItemData vm) => vm.IsCashPrice);
		bindingSet.Bind<TextMeshProUGUI>(packsPriceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPacksChainItemData vm) => vm.PriceText);
		bindingSet.Bind(locked).For((GameObject v) => v.activeSelf).ToExpression((ActivityPacksChainItemData vm) => !vm.Unlock);
		bindingSet.Bind(bought).For((GameObject v) => v.activeSelf).To((ActivityPacksChainItemData vm) => vm.Bought);
		bindingSet.Bind(btnBuy).For((Button v) => v.onClick).To((ActivityPacksChainItemData vm) => vm.OnBuyBtnClick);
		bindingSet.Build();
		reward.Init(_viewModel.RewardItemData);
	}
}
