using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ShopGoodItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private Image rarityBg;

	[SerializeField]
	private Image rarityLine;

	[SerializeField]
	private Image goodIcon;

	[SerializeField]
	private TextMeshProUGUI nameAndCountText;

	[SerializeField]
	private Image bottomRarityBg;

	[SerializeField]
	private GameObject legend;

	[SerializeField]
	private GameObject limitBug;

	[SerializeField]
	private TextMeshProUGUI limitBugText;

	[SerializeField]
	private GameObject armourRank;

	[SerializeField]
	private TextMeshProUGUI armourRankText;

	[SerializeField]
	private GameObject oneCost;

	[SerializeField]
	private GameObject cashSymbol;

	[SerializeField]
	private Image oneCostIcon;

	[SerializeField]
	private TextMeshProUGUI oneCostCount;

	[SerializeField]
	private TextMeshProUGUI oneCostRawCount;

	[SerializeField]
	private GameObject twoCost;

	[SerializeField]
	private Image twoCostIcon1;

	[SerializeField]
	private TextMeshProUGUI twoCostCount1;

	[SerializeField]
	private GameObject orGo;

	[SerializeField]
	private Image twoCostIcon2;

	[SerializeField]
	private TextMeshProUGUI twoCostCount2;

	[SerializeField]
	private GameObject goodTag;

	[SerializeField]
	private TextMeshProUGUI tagText;

	[SerializeField]
	private GameObject customTag;

	[SerializeField]
	private TextMeshProUGUI customTagText;

	[SerializeField]
	private Image customTagImage;

	[SerializeField]
	private GameObject refreshTime;

	[SerializeField]
	private TextMeshProUGUI refreshTimeText;

	[SerializeField]
	private Color lockTipsColor;

	[SerializeField]
	private GameObject lockMask;

	[SerializeField]
	private TextMeshProUGUI lockTipsText;

	[SerializeField]
	private GameObject soldOutMask;

	[SerializeField]
	private GameObject saleMask;

	[SerializeField]
	private GameObject red;

	[SerializeField]
	private List<Color> bottomRarityColors = new List<Color>();

	private ShopGoodItemData _viewModel;

	public void Init(ShopGoodItemData data)
	{
		_viewModel = data;
		_viewModel.SetColorConfig(lockTipsColor, bottomRarityColors);
		BindingSet<ShopGoodItem, ShopGoodItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((ShopGoodItemData vm) => vm.OnItemClick);
		bindingSet.Bind(rarityBg).For((Image v) => v.sprite).ToExpression((ShopGoodItemData vm) => $"RarityBG_Shop_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarityLine).For((Image v) => v.color).To((ShopGoodItemData vm) => vm.RarityColor);
		bindingSet.Bind(goodIcon).For((Image v) => v.sprite).ToExpression((ShopGoodItemData vm) => vm.PropDataBase.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(nameAndCountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.NameAndCountText);
		bindingSet.Bind(bottomRarityBg).For((Image v) => v.color).To((ShopGoodItemData vm) => vm.BottomRarityColor);
		bindingSet.Bind(legend).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => vm.Rarity == 4);
		bindingSet.Bind(limitBug).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.ShowLimitBuy);
		bindingSet.Bind<TextMeshProUGUI>(limitBugText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.LimitBuyText);
		bindingSet.Bind(armourRank).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.ShowArmourRank);
		bindingSet.Bind<TextMeshProUGUI>(armourRankText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.ArmourRankText);
		bindingSet.Bind(oneCost).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => (int)vm.PriceType == 0 || (int)vm.PriceType == 1);
		bindingSet.Bind(cashSymbol).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.CashSinglePrice);
		bindingSet.Bind(oneCostIcon).For((Image v) => v.sprite).To((ShopGoodItemData vm) => vm.OneCostIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(oneCostIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => !vm.CashSinglePrice);
		bindingSet.Bind<TextMeshProUGUI>(oneCostCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.OneCostCount);
		bindingSet.Bind<TextMeshProUGUI>(oneCostRawCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.OneCostRawCount);
		bindingSet.Bind(twoCost).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => (int)vm.PriceType == 2 || (int)vm.PriceType == 3);
		bindingSet.Bind(orGo).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => (int)vm.PriceType == 3);
		bindingSet.Bind(twoCostIcon1).For((Image v) => v.sprite).To((ShopGoodItemData vm) => vm.TwoCostIcon1)
			.WithConversion("ItemIcon");
		bindingSet.Bind(twoCostIcon2).For((Image v) => v.sprite).To((ShopGoodItemData vm) => vm.TwoCostIcon2)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(twoCostCount1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.TwoCostCount1);
		bindingSet.Bind<TextMeshProUGUI>(twoCostCount2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.TwoCostCount2);
		bindingSet.Bind(goodTag).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => (int)vm.PriceType == 1);
		bindingSet.Bind<TextMeshProUGUI>(tagText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.OnSaleText);
		if (customTag != null && (UnityEngine.Object)(object)customTagText != null && customTagImage != null)
		{
			bindingSet.Bind(customTag).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.ShowCustomTag);
			bindingSet.Bind<TextMeshProUGUI>(customTagText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.CustomTagText);
			bindingSet.Bind(customTagImage).For((Image v) => v.sprite).To((ShopGoodItemData vm) => vm.CustomTagImage)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind(lockMask).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.LockMask);
		bindingSet.Bind<TextMeshProUGUI>(lockTipsText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.LockTips);
		bindingSet.Bind(soldOutMask).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.SoldOutMask);
		bindingSet.Bind(refreshTime).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => !string.IsNullOrEmpty(vm.RefreshTimeText));
		bindingSet.Bind<TextMeshProUGUI>(refreshTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopGoodItemData vm) => vm.RefreshTimeText);
		bindingSet.Bind(saleMask).For((GameObject v) => v.activeSelf).ToExpression((ShopGoodItemData vm) => (int)vm.PriceType == 1 && (vm.LockMask || vm.SoldOutMask));
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((ShopGoodItemData vm) => vm.Red);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is ShopGoodItemData shopGoodItemData)
		{
			_viewModel = shopGoodItemData;
			_viewModel.SetColorConfig(lockTipsColor, bottomRarityColors);
			this.SetDataContext(shopGoodItemData);
		}
	}
}
