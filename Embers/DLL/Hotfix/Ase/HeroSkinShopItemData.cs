using System;

namespace Ase;

public class HeroSkinShopItemData : HeroSkinItemData
{
	private ShopExcData excData;

	private bool showDiscount;

	private string discountText;

	private bool bought;

	private string priceIcon = "";

	private string oriPrice;

	private string finalPrice;

	private long refreshTime = -1L;

	private string refreshTimeText;

	public ShopExcData ExcData => excData;

	public string PriceIcon
	{
		get
		{
			return priceIcon;
		}
		set
		{
			Set(ref priceIcon, value, "PriceIcon");
		}
	}

	public string OriPrice
	{
		get
		{
			return oriPrice;
		}
		set
		{
			Set(ref oriPrice, value, "OriPrice");
		}
	}

	public string FinalPrice
	{
		get
		{
			return finalPrice;
		}
		set
		{
			Set(ref finalPrice, value, "FinalPrice");
		}
	}

	public bool Bought
	{
		get
		{
			return bought;
		}
		set
		{
			Set(ref bought, value, "Bought");
		}
	}

	public bool ShowDiscount
	{
		get
		{
			return showDiscount;
		}
		set
		{
			Set(ref showDiscount, value, "ShowDiscount");
		}
	}

	public string DiscountText
	{
		get
		{
			return discountText;
		}
		set
		{
			Set(ref discountText, value, "DiscountText");
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

	public HeroSkinShopItemData()
	{
	}

	public HeroSkinShopItemData(OptionBase parent, ShopExcData excData)
		: base(parent, (excData?.Prop?.Id).GetValueOrDefault())
	{
		this.excData = excData;
		Bought = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkinOwnerShopSituation((excData?.Prop?.Id).GetValueOrDefault());
		int num = 0;
		int num2 = -1;
		if (excData.CashPriceCount > 0 || excData.CashPriceOriginalCount > 0)
		{
			PriceIcon = "";
			num2 = excData.CashPriceCount;
			num = ((excData.CashPriceOriginalCount > 0) ? excData.CashPriceOriginalCount : (-1));
		}
		else if (excData.ConsumeSchemes.Count > 0 && excData.ConsumeSchemes[0].Count > 0)
		{
			PropDataBase propDataBase = excData.ConsumeSchemes[0][0];
			PriceIcon = propDataBase.Icon;
			num2 = propDataBase.Amount;
			num = ((propDataBase.MaxCount > 0 && propDataBase.MaxCount != propDataBase.Amount) ? propDataBase.MaxCount : (-1));
		}
		FinalPrice = $"{num2}";
		OriPrice = ((num < 0) ? "" : $"{num}");
		ShowDiscount = num >= 0;
		DiscountText = ((num >= 0) ? $"-{Math.Round((double)(num - num2) / (double)num, 2, MidpointRounding.AwayFromZero) * 100.0}%" : "");
		RefreshTime = ((excData.LeftDelistTime >= 0) ? excData.LeftDelistTime : excData.LeftRefreshTime);
	}

	public override void OnItemClick()
	{
		parent.ItemOnClick(this);
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
		if (Bought)
		{
			return !ExcData.SoldOutShow;
		}
		return false;
	}
}
