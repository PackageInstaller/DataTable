using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.UI.Interface;
using ACT.Utility;
using Fundamental;
using UnityEngine.Localization.Components;

namespace ACT.UI.ShopSubView;

public class CharacterSkinSubShopView : BaseShopSecondSubView<CharacterSkinSubShopInputController>
{
	public LocalizeStringEvent titleName;

	public LocalizeStringEvent desText;

	public CommonPriceComponent priceComponent;

	public ActButton buyButton;

	public ActButton helpButton;

	private SkinShop _skinShop;

	private void Awake()
	{
		if ((bool)buyButton)
		{
			buyButton.SetBtnClick(OnBuy);
		}
		if ((bool)helpButton)
		{
			helpButton.SetBtnClick(OnHelp);
		}
	}

	private void OnHelp()
	{
		if (_skinShop != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				iconId = 1027,
				titleTextId = _skinShop.bundlename,
				descTextId = _skinShop.bundledetail
			});
		}
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		SubshopData subShopData = ShopSecondTab.SubShopData;
		if (subShopData == null)
		{
			return;
		}
		int firstListedCommodityId = GetFirstListedCommodityId(subShopData);
		if (firstListedCommodityId == 0)
		{
			_skinShop = null;
			if ((bool)buyButton)
			{
				buyButton.Interactable(active: false);
			}
			return;
		}
		_skinShop = CoreUtils.GetData(firstListedCommodityId, RuntimeConfigs.data.skinShops);
		if (_skinShop != null)
		{
			if ((bool)buyButton)
			{
				buyButton.Interactable(active: true);
			}
			titleName.SetTable("shortcommon");
			titleName.StringReference.TableEntryReference = _skinShop.bundlename;
			desText.SetTable("longcommon");
			desText.StringReference.TableEntryReference = _skinShop.bundledetail;
			switch (_skinShop.paytype)
			{
			case 1:
			{
				ItemKv itemKv = _skinShop.itemNeed.FirstOrDefault();
				priceComponent.Init(itemKv.id, itemKv.count);
				break;
			}
			case 2:
				priceComponent.Init(Model<PayModel>.Interface.GetPrice(_skinShop.id));
				break;
			case 3:
				priceComponent.Init();
				break;
			}
		}
	}

	private int GetFirstListedCommodityId(SubshopData subShopData)
	{
		if (subShopData.commodityIds == null)
		{
			return 0;
		}
		int[] commodityIds = subShopData.commodityIds;
		foreach (int num in commodityIds)
		{
			if (subShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
			{
				return num;
			}
		}
		return 0;
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		SetBuyButtonPromptVisible(visible: true);
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		SetBuyButtonPromptVisible(visible: false);
	}

	private void SetBuyButtonPromptVisible(bool visible)
	{
		if ((bool)buyButton)
		{
			OperateBtnPrompt componentInChildren = buyButton.GetComponentInChildren<OperateBtnPrompt>();
			if ((bool)componentInChildren)
			{
				componentInChildren.SetVisible(visible);
			}
		}
	}

	private void OnBuy()
	{
		if (_skinShop != null)
		{
			Skin data = CoreUtils.GetData(_skinShop.skinid, RuntimeConfigs.data.Skins);
			if (data != null)
			{
				ShopEventTrackHelper.Dispatch(ShopSecondTab.SubShopData.id, 3, _skinShop.id, 1);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERSKIN, new CharacterSkinViewData
				{
					RoleId = data.roleid,
					SkinId = _skinShop.skinid,
					FormType = OpenForm.Shop,
					SubShopId = ShopSecondTab.SubShopData.id
				});
			}
		}
	}
}
