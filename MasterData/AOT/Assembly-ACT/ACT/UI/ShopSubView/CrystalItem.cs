using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.Utility;
using Bamboo.ImageCenter;
using Pb;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ShopSubView;

public class CrystalItem : LoopScrollBaseItem
{
	public ActButton buyButton;

	public GameObject doubleTagObject;

	public GameObject limitedTimeTagObject;

	public GameObject rebateTagObject;

	public GameObject leftTimeTagObject;

	public LocalizeStringEvent doubleTagText;

	public LocalizeStringEvent limitedTimeTagText;

	public LocalizeStringEvent rebateTagText;

	public Image backgroundImage;

	public CommonPriceComponent priceComponent;

	public BImage iconImage;

	public TextMeshProUGUI descriptionText;

	public CommonTimerComponent leftTime;

	public PresentTotalRechargeTag presentTotalRechargeTag;

	[Header("动画")]
	public BetterAnimation betterAnimation;

	private int _commodityId;

	private GemRecharge _rechargeData;

	public int CommodityId
	{
		get
		{
			return _commodityId;
		}
		set
		{
			_commodityId = value;
			_rechargeData = CoreUtils.GetData(_commodityId, RuntimeConfigs.data.gemRecharges);
			Refresh();
		}
	}

	public int SubShopId { get; set; }

	private void Awake()
	{
		if (buyButton != null)
		{
			buyButton.SetBtnClick(OnBuy);
		}
	}

	private void Refresh()
	{
		UpdateTags();
		UpdateLeftTime();
		UpdateBackground();
		UpdatePrice();
		UpdateDescription();
		UpdateIcon();
		UpdateButton();
	}

	private void UpdateTags()
	{
		limitedTimeTagObject.SetActive(value: false);
		doubleTagObject.SetActive(value: false);
		rebateTagObject.SetActive(value: false);
		SaleList data = CoreUtils.GetData(CommodityId, RuntimeConfigs.data.saleLists);
		presentTotalRechargeTag?.SetAmount(data?.eventPoint ?? 0);
		if (Model<ShopModel>.Interface.IsDiamondCommodityLimitDouble(CommodityId))
		{
			limitedTimeTagObject.SetActive(value: true);
			limitedTimeTagText.GetVariable<int>("0").Value = _rechargeData.firstPay;
		}
		else if (Model<ShopModel>.Interface.IsDiamondCommodityDouble(CommodityId))
		{
			doubleTagText.GetVariable<int>("0").Value = _rechargeData.firstPay;
			doubleTagObject.SetActive(value: true);
		}
		else if (_rechargeData.normalPay != 0)
		{
			rebateTagText.GetVariable<int>("0").Value = _rechargeData.normalPay;
			rebateTagObject.SetActive(value: true);
		}
	}

	private void UpdateLeftTime()
	{
		if (Model<ShopModel>.Interface.IsDiamondCommodityLimitDouble(CommodityId))
		{
			DoubleGem doubleGem = RuntimeConfigs.data.doubleGems[_rechargeData.doubleid];
			leftTimeTagObject.SetActive(value: true);
			leftTime.IsCountDown = true;
			CommonTimerComponent commonTimerComponent = leftTime;
			System.DateTime minValue = System.DateTime.MinValue;
			commonTimerComponent.Time = minValue.Add(new System.DateTime(doubleGem.endTimeStamp) - TimeManager.ServerTime.Now);
		}
		else
		{
			leftTimeTagObject.SetActive(value: false);
		}
	}

	private void UpdateBackground()
	{
		if (!(backgroundImage == null))
		{
			backgroundImage.enabled = true;
		}
	}

	private void UpdatePrice()
	{
		priceComponent.Init(Model<PayModel>.Interface.GetPrice(_commodityId));
	}

	private void UpdateDescription()
	{
		if ((bool)descriptionText && _rechargeData != null)
		{
			descriptionText.GetComponent<LocalizeStringEvent>().SetTable(LocalizeTable.ShortCommon);
			descriptionText.GetComponent<LocalizeStringEvent>().SetEntry(_rechargeData.dec);
		}
	}

	private void UpdateIcon()
	{
		if (_rechargeData != null)
		{
			Station.LoadImage(211, _rechargeData.id, iconImage);
		}
	}

	private void UpdateButton()
	{
		if (!(buyButton == null))
		{
			buyButton.Interactable(_rechargeData != null);
		}
	}

	private void OnBuy()
	{
		if (_rechargeData == null)
		{
			return;
		}
		ShopEventTrackHelper.Dispatch(SubShopId, 3, _commodityId, 1);
		ShopEventTrackHelper.Dispatch(SubShopId, 4, _commodityId, 1);
		Model<PayModel>.Interface.SendOrder(_commodityId, SubShopId, (bool ok, CreatOrderAck ack) =>
		{
			if (!ok)
			{
				ShopEventTrackHelper.Dispatch(SubShopId, 5, _commodityId, 1);
			}
			else
			{
				PayModel payModel = Model<PayModel>.Interface;
				payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnOrderPaySuccess));
			}
			void OnOrderPaySuccess(string orderId)
			{
				if (ack == null || !(orderId != ack.OrderId))
				{
					PayModel payModel2 = Model<PayModel>.Interface;
					payModel2.OnPaySuccess = (Action<string>)Delegate.Remove(payModel2.OnPaySuccess, new Action<string>(OnOrderPaySuccess));
					ShopEventTrackHelper.Dispatch(SubShopId, 6, _commodityId, 1);
				}
			}
		});
	}
}
