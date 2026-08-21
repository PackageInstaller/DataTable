using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class ShopGoodItemData : ItemOptionBase
{
	public enum PriceTypeEnum
	{
		Single,
		SingleOnSale,
		BothMultiple,
		OrMultiple
	}

	public enum ShopPosition
	{
		Shop = 1,
		GuildShop,
		CashPayShop,
		HeroSkinShop,
		ActivityShop,
		CampaignShop
	}

	private Dictionary<int, string> RarityColors = new Dictionary<int, string>
	{
		[0] = "#969797",
		[1] = "#2ac871",
		[2] = "#2a87c8",
		[3] = "#8e2ac8",
		[4] = "#c8a52a"
	};

	public List<Color> bottomRarityColors = new List<Color>();

	private ShopExcData excData;

	private PropDataBase propDataBase;

	private int rarity;

	private Color rarityColor;

	private Color bottomRarityColor;

	private string nameAndCountText;

	private bool showLimitBuy;

	private string limitBuyText;

	private bool showOnSale;

	private string onSaleText;

	private bool showCustomTag;

	private string customTagText;

	private string customTagImage = "";

	private bool showArmourRank;

	private string armourRankText;

	private PriceTypeEnum priceType;

	private string oneCostIcon = "";

	private string oneCostCount;

	private string oneCostRawCount;

	private string twoCostIcon1 = "";

	private string twoCostCount1;

	private string twoCostIcon2 = "";

	private string twoCostCount2;

	private bool red;

	private string lockTips;

	private bool lockMask;

	private bool soldOutMask;

	public Color LockTipsColor;

	private long refreshTime = -1L;

	private string refreshTimeText;

	private bool cashSinglePrice;

	public bool CashSinglePrice
	{
		get
		{
			return cashSinglePrice;
		}
		private set
		{
			Set(ref cashSinglePrice, value, "CashSinglePrice");
		}
	}

	public ShopExcData ExcData => excData;

	public PropDataBase PropDataBase
	{
		get
		{
			return propDataBase;
		}
		private set
		{
			Set(ref propDataBase, value, "PropDataBase");
			if (value is ArmourData armourData)
			{
				ShowArmourRank = true;
				ArmourRankText = $"R{armourData.Rank}";
			}
			else
			{
				ShowArmourRank = false;
				ArmourRankText = string.Empty;
			}
		}
	}

	public int Rarity
	{
		get
		{
			return rarity;
		}
		set
		{
			Set(ref rarity, value, "Rarity");
			if (RarityColors.ContainsKey(value))
			{
				ColorUtility.TryParseHtmlString(RarityColors[value], out var color);
				RarityColor = color;
			}
			if (bottomRarityColors.Count > value)
			{
				BottomRarityColor = bottomRarityColors[value];
			}
		}
	}

	public Color RarityColor
	{
		get
		{
			return rarityColor;
		}
		set
		{
			Set(ref rarityColor, value, "RarityColor");
		}
	}

	public Color BottomRarityColor
	{
		get
		{
			return bottomRarityColor;
		}
		set
		{
			Set(ref bottomRarityColor, value, "BottomRarityColor");
		}
	}

	public string NameAndCountText
	{
		get
		{
			return nameAndCountText;
		}
		set
		{
			Set(ref nameAndCountText, value, "NameAndCountText");
		}
	}

	public string LimitBuyText
	{
		get
		{
			return limitBuyText;
		}
		set
		{
			Set(ref limitBuyText, value, "LimitBuyText");
		}
	}

	public bool ShowLimitBuy
	{
		get
		{
			return showLimitBuy;
		}
		set
		{
			Set(ref showLimitBuy, value, "ShowLimitBuy");
		}
	}

	public string OnSaleText
	{
		get
		{
			return onSaleText;
		}
		set
		{
			Set(ref onSaleText, value, "OnSaleText");
		}
	}

	public bool ShowCustomTag
	{
		get
		{
			return showCustomTag;
		}
		set
		{
			Set(ref showCustomTag, value, "ShowCustomTag");
		}
	}

	public string CustomTagText
	{
		get
		{
			return customTagText;
		}
		set
		{
			Set(ref customTagText, value, "CustomTagText");
		}
	}

	public string CustomTagImage
	{
		get
		{
			return customTagImage;
		}
		set
		{
			Set(ref customTagImage, value, "CustomTagImage");
		}
	}

	public bool ShowArmourRank
	{
		get
		{
			return showArmourRank;
		}
		set
		{
			Set(ref showArmourRank, value, "ShowArmourRank");
		}
	}

	public string ArmourRankText
	{
		get
		{
			return armourRankText;
		}
		set
		{
			Set(ref armourRankText, value, "ArmourRankText");
		}
	}

	public PriceTypeEnum PriceType
	{
		get
		{
			return priceType;
		}
		private set
		{
			priceType = value;
		}
	}

	public string OneCostIcon
	{
		get
		{
			return oneCostIcon;
		}
		set
		{
			Set(ref oneCostIcon, value, "OneCostIcon");
		}
	}

	public string OneCostCount
	{
		get
		{
			return oneCostCount;
		}
		set
		{
			Set(ref oneCostCount, value, "OneCostCount");
		}
	}

	public string OneCostRawCount
	{
		get
		{
			return oneCostRawCount;
		}
		set
		{
			Set(ref oneCostRawCount, value, "OneCostRawCount");
		}
	}

	public string TwoCostIcon1
	{
		get
		{
			return twoCostIcon1;
		}
		set
		{
			Set(ref twoCostIcon1, value, "TwoCostIcon1");
		}
	}

	public string TwoCostIcon2
	{
		get
		{
			return twoCostIcon2;
		}
		set
		{
			Set(ref twoCostIcon2, value, "TwoCostIcon2");
		}
	}

	public string TwoCostCount1
	{
		get
		{
			return twoCostCount1;
		}
		set
		{
			Set(ref twoCostCount1, value, "TwoCostCount1");
		}
	}

	public string TwoCostCount2
	{
		get
		{
			return twoCostCount2;
		}
		set
		{
			Set(ref twoCostCount2, value, "TwoCostCount2");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		set
		{
			Set(ref red, value, "Red");
		}
	}

	public string LockTips
	{
		get
		{
			return lockTips;
		}
		set
		{
			Set(ref lockTips, value, "LockTips");
		}
	}

	public bool LockMask
	{
		get
		{
			return lockMask;
		}
		set
		{
			Set(ref lockMask, value, "LockMask");
		}
	}

	public bool SoldOutMask
	{
		get
		{
			return soldOutMask;
		}
		set
		{
			Set(ref soldOutMask, value, "SoldOutMask");
		}
	}

	public string RefreshTimeText
	{
		get
		{
			return refreshTimeText;
		}
		set
		{
			Set(ref refreshTimeText, value, "RefreshTimeText");
		}
	}

	public long RefreshTime
	{
		get
		{
			return refreshTime;
		}
		private set
		{
			Set(ref refreshTime, value, "RefreshTime");
			if (RefreshTime < 0)
			{
				RefreshTimeText = string.Empty;
				return;
			}
			TimeSpan timeSpan = new TimeSpan(0, 0, (int)RefreshTime);
			RefreshTimeText = $"{timeSpan.Days}天{timeSpan.Hours}小时";
		}
	}

	public ShopGoodItemData(OptionBase parent, ShopExcData excData)
	{
		base.parent = parent;
		this.excData = excData;
		Red = excData.FreeNew;
		PropDataBase = excData.Prop;
		Rarity = PropDataBase.GetRarity();
		NameAndCountText = ((PropDataBase.Amount > 1) ? $"{PropDataBase.Name}x{PropDataBase.Amount}" : PropDataBase.Name);
		ShowLimitBuy = excData.QuotaNum >= 0;
		if (ShowLimitBuy)
		{
			LimitBuyText = ((excData.LeftExc <= 0) ? $"限购 <color=red>{excData.LeftExc}</color>/{excData.QuotaNum}" : $"限购 {excData.LeftExc}/{excData.QuotaNum}");
		}
		if (excData.CashPriceCount > 0 || excData.CashPriceOriginalCount > 0)
		{
			CashSinglePrice = true;
			if (excData.CashPriceOriginalCount > 0 && excData.CashPriceOriginalCount != excData.CashPriceCount)
			{
				PriceType = PriceTypeEnum.SingleOnSale;
				OneCostCount = excData.CashPriceCount.ToString();
				OneCostRawCount = excData.CashPriceOriginalCount.ToString();
				OnSaleText = $"-{Math.Round((double)(excData.CashPriceOriginalCount - excData.CashPriceCount) / (double)excData.CashPriceOriginalCount, 2, MidpointRounding.AwayFromZero) * 100.0}%";
			}
			else
			{
				PriceType = PriceTypeEnum.Single;
				OneCostCount = excData.CashPriceCount.ToString();
			}
		}
		else if (excData.ConsumeSchemes.Count == 1)
		{
			if (excData.ConsumeSchemes[0].Count > 0)
			{
				PropDataBase propDataBase = excData.ConsumeSchemes[0][0];
				if (excData.ConsumeSchemes[0].Count > 1)
				{
					PropDataBase propDataBase2 = excData.ConsumeSchemes[0][1];
					PriceType = PriceTypeEnum.BothMultiple;
					TwoCostIcon1 = propDataBase.Icon;
					TwoCostCount1 = propDataBase.Amount.ToString();
					TwoCostIcon2 = propDataBase2.Icon;
					TwoCostCount2 = propDataBase2.Amount.ToString();
				}
				else if (propDataBase.MaxCount > 0 && propDataBase.MaxCount != propDataBase.Amount)
				{
					PriceType = PriceTypeEnum.SingleOnSale;
					OneCostIcon = propDataBase.Icon;
					OneCostCount = propDataBase.Amount.ToString();
					OneCostRawCount = propDataBase.MaxCount.ToString();
					OnSaleText = $"-{Math.Round((double)(propDataBase.MaxCount - propDataBase.Amount) / (double)propDataBase.MaxCount, 2, MidpointRounding.AwayFromZero) * 100.0}%";
				}
				else
				{
					PriceType = PriceTypeEnum.Single;
					OneCostIcon = propDataBase.Icon;
					OneCostCount = propDataBase.Amount.ToString();
				}
			}
		}
		else if (excData.ConsumeSchemes.Count > 1)
		{
			List<PropDataBase> list = excData.ConsumeSchemes[0];
			List<PropDataBase> list2 = excData.ConsumeSchemes[1];
			if (list.Count > 0 && list2.Count > 0)
			{
				PriceType = PriceTypeEnum.OrMultiple;
				TwoCostIcon1 = list[0].Icon;
				TwoCostCount1 = list[0].Amount.ToString();
				TwoCostIcon2 = list2[0].Icon;
				TwoCostCount2 = list2[0].Amount.ToString();
			}
		}
		SoldOutMask = excData.QuotaNum >= 0 && excData.LeftExc <= 0;
		if (!excData.IsUnlock)
		{
			LockTips = excData.GetUnlockCondition(LockTipsColor);
			LockMask = true;
		}
		ShowCustomTag = excData.ShowCustomTag;
		CustomTagImage = excData.CustomTagImage;
		CustomTagText = excData.CustomTagText;
		if (excData.LeftDelistTime >= 0)
		{
			RefreshTime = excData.LeftDelistTime;
		}
		else
		{
			RefreshTime = excData.LeftRefreshTime;
		}
	}

	private bool CheckBeforeBuy(out string tips)
	{
		tips = "";
		if (SoldOutMask)
		{
			tips = "物品已售空";
			return false;
		}
		if (LockMask)
		{
			tips = "未满足解锁条件";
			return false;
		}
		return true;
	}

	public void SetColorConfig(Color lockTipsColor, List<Color> bottomRarityColors)
	{
		LockTipsColor = lockTipsColor;
		if (bottomRarityColors != null)
		{
			this.bottomRarityColors = bottomRarityColors;
		}
		if (excData != null)
		{
			LockTips = excData.GetUnlockCondition(LockTipsColor);
		}
		if (this.bottomRarityColors.Count > Rarity)
		{
			BottomRarityColor = this.bottomRarityColors[Rarity];
		}
	}

	public void OnExchangeSucceed(int useCount)
	{
		if (ShowLimitBuy)
		{
			LimitBuyText = ((excData.LeftExc <= 0) ? $"限购 <color=red>{excData.LeftExc}</color>/{excData.QuotaNum}" : $"限购 {excData.LeftExc}/{excData.QuotaNum}");
		}
		SoldOutMask = excData.QuotaNum >= 0 && excData.LeftExc <= 0;
		Red = excData.FreeNew;
	}

	public void OnItemClick()
	{
		if (!CheckBeforeBuy(out var tips))
		{
			Toast.ShowInfo(tips);
		}
		else
		{
			parent.ItemOnClick(this);
		}
	}

	public void OnTimerUpdate(int second = 1)
	{
		if (excData.WaitRefresh)
		{
			excData.UpdateLeftTime(second);
			if (excData.LeftDelistTime >= 0)
			{
				RefreshTime = excData.LeftDelistTime;
			}
			else
			{
				RefreshTime = excData.LeftRefreshTime;
			}
			if (ExcData.LeftRefreshTime == 0L || ExcData.LeftDiscountTime == 0L || ExcData.LeftDelistTime == 0L)
			{
				parent.ItemOnClick(new OptionArg(this, "RefetchShopInfo"));
			}
		}
	}

	public bool GetSoldOutHide()
	{
		if (ExcData == null)
		{
			return true;
		}
		if (ExcData.QuotaNum >= 0 && ExcData.LeftExc <= 0)
		{
			return !ExcData.SoldOutShow;
		}
		return false;
	}
}
