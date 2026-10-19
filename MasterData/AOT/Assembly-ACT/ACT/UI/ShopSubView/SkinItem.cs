using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ShopSubView;

public class SkinItem : LoopScrollBaseItem
{
	public GameObject[] qualityBgs;

	public GameObject[] qualityFrontBgs;

	public BImage banner;

	[Header("折扣标签")]
	public GameObject permanentDiscountTag;

	public GameObject limitedTimeDiscountTag;

	public CommonTimerComponent timerComponent;

	public LocalizeStringEvent skinName;

	public CommonPriceComponent priceComponent;

	public ActButton actButton;

	public GameObject soldOutMask;

	public BetterAnimation betterAnimation;

	public BetterAnimation tagBetterAnimation;

	private int _skinShopId;

	private SkinShop _skinShop;

	public int SkinShopId
	{
		get
		{
			return _skinShopId;
		}
		set
		{
			_skinShopId = value;
			_skinShop = CoreUtils.GetData(_skinShopId, RuntimeConfigs.data.skinShops);
			Refresh();
		}
	}

	public int SubShopId { get; set; }

	public int ShopId { get; set; }

	private void Awake()
	{
		if ((bool)actButton)
		{
			actButton.SetBtnClick(OnBuy);
		}
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		timerComponent.OnTimeOut = null;
	}

	private void Refresh()
	{
		UpdateTag();
		UpdateRemainTime();
		UpdateBanner();
		UpdateQuality();
		UpdateSkinName();
		UpdatePrice();
		UpdateSoldOutMask();
	}

	private void UpdateTag()
	{
		permanentDiscountTag.SetActive(value: false);
		limitedTimeDiscountTag.SetActive(value: false);
		if (!IsSoldOut())
		{
			if (_skinShop.tag.Contains(1))
			{
				permanentDiscountTag.SetActive(value: true);
			}
			if (_skinShop.tag.Contains(2))
			{
				limitedTimeDiscountTag.SetActive(value: true);
			}
		}
	}

	private void UpdateRemainTime()
	{
		timerComponent.IsCountDown = true;
		long num = Model<ShopModel>.Interface.CommodityLeftTime(_skinShopId);
		TimeSpan value = TimeSpan.FromSeconds(num);
		if (num == -1 || value.Ticks >= 3153600000000000L)
		{
			timerComponent.gameObject.SetActive(value: false);
			return;
		}
		timerComponent.gameObject.SetActive(value: true);
		CommonTimerComponent commonTimerComponent = timerComponent;
		System.DateTime minValue = System.DateTime.MinValue;
		commonTimerComponent.Time = minValue.Add(value);
	}

	private void UpdateBanner()
	{
		Station.LoadImage(215, _skinShop.skinid, banner);
	}

	private void UpdateQuality()
	{
		for (int i = 0; i < qualityBgs.Length; i++)
		{
			qualityBgs[i].SetActive(i == _skinShop.quality - 1);
		}
		for (int j = 0; j < qualityFrontBgs.Length; j++)
		{
			qualityFrontBgs[j].SetActive(j == _skinShop.quality - 1);
		}
	}

	private void UpdateSkinName()
	{
		skinName.SetTable("shortcommon");
		skinName.StringReference.TableEntryReference = _skinShop.bundlename;
	}

	private void UpdatePrice()
	{
		switch (_skinShop.paytype)
		{
		case 1:
		{
			ItemKv itemKv = _skinShop.itemNeed.FirstOrDefault();
			priceComponent.Init(itemKv.id, itemKv.count);
			break;
		}
		case 2:
			priceComponent.Init(Model<PayModel>.Interface.GetPrice(_skinShopId));
			break;
		case 3:
			priceComponent.Init();
			break;
		}
	}

	private void UpdateSoldOutMask()
	{
		bool flag = IsSoldOut();
		soldOutMask.SetActive(flag);
		priceComponent.Interactable(!flag);
	}

	private bool IsSoldOut()
	{
		return Model<ShopModel>.Interface.SkinItemLeftCount(_skinShopId) == 0;
	}

	private void OnBuy()
	{
		if (!soldOutMask || !soldOutMask.activeSelf)
		{
			Skin data = CoreUtils.GetData(_skinShop.skinid, RuntimeConfigs.data.Skins);
			if (data != null)
			{
				ShopEventTrackHelper.Dispatch(SubShopId, 3, _skinShop.id, 1);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERSKIN, new CharacterSkinViewData
				{
					RoleId = data.roleid,
					SkinId = _skinShop.skinid,
					FormType = OpenForm.Shop,
					SubShopId = SubShopId
				});
			}
		}
	}
}
