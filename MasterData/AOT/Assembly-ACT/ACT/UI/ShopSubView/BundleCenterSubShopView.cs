using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.UI.Interface;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ShopSubView;

public class BundleCenterSubShopView : BaseShopSecondSubView<BundleCenterSubShopViewInputController>
{
	public LocalizeStringEvent titleText;

	public LocalizeStringEvent desText;

	public BImage bundleBanner;

	public CommonTimerComponent timerComponent;

	public CommonPriceComponent priceComponent;

	public ActButton buyBtn;

	private Bundle _bundleData;

	private int _commodityId;

	private void Awake()
	{
		if ((bool)buyBtn)
		{
			buyBtn.SetBtnClick(OnBuy);
		}
		if ((bool)timerComponent)
		{
			timerComponent.OnTimeOut = OnTimeOut;
		}
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_commodityId = GetFirstAvailableCommodityId();
		if (_commodityId == 0)
		{
			_bundleData = null;
			if ((bool)buyBtn)
			{
				buyBtn.Interactable(active: false);
			}
			if ((bool)timerComponent)
			{
				timerComponent.gameObject.SetActive(value: false);
			}
			return;
		}
		_bundleData = CoreUtils.GetData(_commodityId, RuntimeConfigs.data.bundles);
		if (_bundleData != null)
		{
			if ((bool)buyBtn)
			{
				buyBtn.Interactable(active: true);
			}
			UpdateTimerComponentStyle();
			UpdateTitleTextStyle();
			UpdateDesTextStyle();
			UpdatePriceComponentStyle();
			UpdateBundleBannerStyle();
		}
	}

	private int GetFirstAvailableCommodityId()
	{
		int[] array = ShopSecondTab?.SubShopData?.commodityIds;
		if (array == null)
		{
			return 0;
		}
		int[] array2 = array;
		foreach (int num in array2)
		{
			if ((Model<ShopModel>.Interface.GoodsData.TryGetValue(num, out var value) || ShopSecondTab.SubShopData.gmType == 1) && Model<ShopModel>.Interface.BundleLeftCount(num) != 0 && (value == null || value.EndTime <= 0 || value.EndTime >= TimeManager.ServerTime.NowTimestampSecond))
			{
				return num;
			}
		}
		return 0;
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		if ((bool)buyBtn)
		{
			OperateBtnPrompt componentInChildren = buyBtn.GetComponentInChildren<OperateBtnPrompt>();
			if ((bool)componentInChildren)
			{
				componentInChildren.SetVisible(vis: true);
			}
		}
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		if ((bool)buyBtn)
		{
			OperateBtnPrompt componentInChildren = buyBtn.GetComponentInChildren<OperateBtnPrompt>();
			if ((bool)componentInChildren)
			{
				componentInChildren.SetVisible(vis: false);
			}
		}
	}

	private void UpdateTimerComponentStyle()
	{
		if (!timerComponent)
		{
			return;
		}
		timerComponent.IsCountDown = true;
		if (ShopSecondTab.SubShopData.gmType == 1)
		{
			timerComponent.gameObject.SetActive(value: false);
			return;
		}
		if (!Model<ShopModel>.Interface.GoodsData.TryGetValue(_commodityId, out var value))
		{
			timerComponent.gameObject.SetActive(value: false);
			return;
		}
		long num = value.EndTime - TimeManager.ServerTime.NowTimestampSecond;
		if (num < 0)
		{
			num = 0L;
			Debug.LogWarning("礼包剩余时间小于0，可能已经过期了，commodityId:" + _commodityId);
		}
		TimeSpan value2 = TimeSpan.FromSeconds(num);
		if (value2.Ticks >= 3153600000000000L)
		{
			timerComponent.gameObject.SetActive(value: false);
			return;
		}
		timerComponent.gameObject.SetActive(value: true);
		CommonTimerComponent commonTimerComponent = timerComponent;
		System.DateTime minValue = System.DateTime.MinValue;
		commonTimerComponent.Time = minValue.Add(value2);
	}

	private void UpdateTitleTextStyle()
	{
		titleText.SetTable("shortcommon");
		titleText.StringReference.TableEntryReference = _bundleData.bundlename;
	}

	private void UpdateDesTextStyle()
	{
		if ((bool)desText)
		{
			desText.SetTable("longcommon");
			desText.StringReference.TableEntryReference = _bundleData.bundledetail;
		}
	}

	private void UpdatePriceComponentStyle()
	{
		int preprice = _bundleData.preprice;
		if (_bundleData.paytype == 1)
		{
			ItemKv itemKv = _bundleData.itemNeed.FirstOrDefault();
			if (itemKv != null)
			{
				priceComponent.Init(itemKv.id, itemKv.count, (preprice > 0) ? preprice : (-1));
			}
		}
		else
		{
			priceComponent.Init(Model<PayModel>.Interface.GetPrice(_commodityId), (preprice > 0) ? preprice.FastToString() : null);
		}
	}

	private void UpdateBundleBannerStyle()
	{
		Station.LoadImage(212, _bundleData.icon, bundleBanner);
	}

	private void OnTimeOut()
	{
		if (timerComponent.gameObject.activeSelf)
		{
			RecommendView recommendView = (Singleton<NewUIManager>.instance.GetTopActiveUI().GetUIView() as ShopView)?.tabListComponent.ActiveTab.Content as RecommendView;
			if ((bool)recommendView)
			{
				recommendView.tabListComponent.TabItems.Remove(Tab);
			}
		}
	}

	private void OnBuy()
	{
		if (_bundleData != null)
		{
			switch (_bundleData.type)
			{
			case 2:
			case 3:
			case 5:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BUNDLEPURCHASE, new BundlePurchaseViewData
				{
					SubShopId = ShopSecondTab.TabIdentify,
					BundleId = _bundleData.id
				});
				break;
			case 4:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SELFSELECTBUNDLEPURCHASE, new SelfSelectBundlePurchaseViewData
				{
					SubShopId = ShopSecondTab.TabIdentify,
					BundleId = _bundleData.id
				});
				break;
			}
		}
	}
}
