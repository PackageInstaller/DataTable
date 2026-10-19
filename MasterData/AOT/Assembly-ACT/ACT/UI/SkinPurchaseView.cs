using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SkinPurchaseView : BaseUIView
{
	public GameObject[] qualityBgs;

	public BImage skinBanner;

	[Header("折扣标签")]
	public GameObject permanentDiscountTag;

	public GameObject limitedTimeDiscountTag;

	public CommonTimerComponent remainTimeComponent;

	public CommonPriceComponent priceComponent;

	public LocalizeStringEvent skinName;

	public LocalizeStringEvent skinDes;

	public ActButton buyBtn;

	private SkinShop _skinShop;

	private SkinPurchaseViewData m_data => uiViewData as SkinPurchaseViewData;

	private void Awake()
	{
		if (buyBtn != null)
		{
			buyBtn.SetBtnClick(OnBuy);
		}
	}

	protected override void Init()
	{
		base.Init();
		_skinShop = CoreUtils.GetData(m_data.SkinShopId, RuntimeConfigs.data.skinShops);
		if (_skinShop == null)
		{
			Debug.LogError($"SkinPurchaseView Init Fail, skinShop is null, skinShopId: {m_data.SkinShopId}");
		}
		else
		{
			Refresh();
		}
	}

	private void Refresh()
	{
		UpdateQuality();
		UpdateBanner();
		UpdateTag();
		UpdateRemainTime();
		UpdateSkinName();
		UpdateSkinDes();
		UpdatePrice();
	}

	private void UpdateQuality()
	{
		if (qualityBgs == null)
		{
			return;
		}
		for (int i = 0; i < qualityBgs.Length; i++)
		{
			if (qualityBgs[i] != null)
			{
				qualityBgs[i].SetActive(i == _skinShop.quality - 1);
			}
		}
	}

	private void UpdateBanner()
	{
		if (skinBanner != null)
		{
			Station.LoadImage(208, _skinShop.skinid, skinBanner);
		}
	}

	private void UpdateTag()
	{
		if (permanentDiscountTag != null)
		{
			permanentDiscountTag.SetActive(value: false);
		}
		if (limitedTimeDiscountTag != null)
		{
			limitedTimeDiscountTag.SetActive(value: false);
		}
		if (_skinShop.tag.Contains(1) && permanentDiscountTag != null)
		{
			permanentDiscountTag.SetActive(value: true);
		}
		if (_skinShop.tag.Contains(2) && limitedTimeDiscountTag != null)
		{
			limitedTimeDiscountTag.SetActive(value: true);
		}
	}

	private void UpdateRemainTime()
	{
		if (!(remainTimeComponent == null))
		{
			remainTimeComponent.IsCountDown = true;
			CommonTimerComponent commonTimerComponent = remainTimeComponent;
			System.DateTime minValue = System.DateTime.MinValue;
			commonTimerComponent.Time = minValue.Add(TimeSpan.FromTicks(3153600000000000L));
		}
	}

	private void UpdateSkinName()
	{
		if (!(skinName == null))
		{
			skinName.SetTable("shortcommon");
			skinName.StringReference.TableEntryReference = _skinShop.bundlename;
		}
	}

	private void UpdateSkinDes()
	{
		if (!(skinDes == null))
		{
			skinDes.SetTable("shortcommon");
			skinDes.StringReference.TableEntryReference = _skinShop.bundledetail;
		}
	}

	private void UpdatePrice()
	{
		if (priceComponent == null)
		{
			return;
		}
		switch (_skinShop.paytype)
		{
		case 1:
		{
			ItemKv itemKv = _skinShop.itemNeed?.FirstOrDefault();
			if (itemKv != null)
			{
				priceComponent.Init(itemKv.id, itemKv.count);
			}
			break;
		}
		case 2:
			priceComponent.Init(Model<PayModel>.Interface.GetPrice(m_data.SkinShopId));
			break;
		case 3:
			priceComponent.Init();
			break;
		}
	}

	private void OnBuy()
	{
		Model<PayModel>.Interface.ExchangeCommodity(m_data.SubShopId, _skinShop.id, (bool x, List<Item> items) =>
		{
			if (x)
			{
				Close();
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SKINREWARD, new SkinRewardViewData
				{
					SkinId = _skinShop.skinid
				});
			}
		});
	}
}
