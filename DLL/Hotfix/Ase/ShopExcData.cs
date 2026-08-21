using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ShopExcData : ViewModelBase
{
	protected int mainShopId;

	protected int shopId;

	protected int excId;

	protected PropDataBase prop;

	protected int quotaNum;

	protected int leftExc;

	protected bool freeNew;

	protected int sort = -1;

	protected List<List<PropDataBase>> consumeSchemes = new List<List<PropDataBase>>();

	protected int cashPriceCount;

	protected int cashPriceOriginalCount;

	protected bool waitRefresh;

	protected long leftRefreshTime = -1L;

	protected long leftDiscountTime = -1L;

	protected long leftDelistTime = -1L;

	protected bool isUnlock;

	protected int unlockType;

	protected int unlockNum;

	protected bool soldOutShow;

	protected bool showCustomTag;

	protected string customTagText;

	protected string customTagImage;

	public PropDataBase Prop
	{
		get
		{
			return prop;
		}
		protected set
		{
			Set(ref prop, value, "Prop");
		}
	}

	public int QuotaNum
	{
		get
		{
			return quotaNum;
		}
		protected set
		{
			Set(ref quotaNum, value, "QuotaNum");
		}
	}

	public int LeftExc
	{
		get
		{
			return leftExc;
		}
		protected set
		{
			Set(ref leftExc, value, "LeftExc");
		}
	}

	public int MainShopId
	{
		get
		{
			return mainShopId;
		}
		protected set
		{
			Set(ref mainShopId, value, "MainShopId");
		}
	}

	public int ShopId
	{
		get
		{
			return shopId;
		}
		protected set
		{
			Set(ref shopId, value, "ShopId");
		}
	}

	public int ExcId
	{
		get
		{
			return excId;
		}
		protected set
		{
			Set(ref excId, value, "ExcId");
		}
	}

	public bool FreeNew
	{
		get
		{
			return freeNew;
		}
		set
		{
			Set(ref freeNew, value, "FreeNew");
		}
	}

	public List<List<PropDataBase>> ConsumeSchemes => consumeSchemes;

	public int CashPriceCount
	{
		get
		{
			return cashPriceCount;
		}
		protected set
		{
			Set(ref cashPriceCount, value, "CashPriceCount");
		}
	}

	public int CashPriceOriginalCount
	{
		get
		{
			return cashPriceOriginalCount;
		}
		protected set
		{
			Set(ref cashPriceOriginalCount, value, "CashPriceOriginalCount");
		}
	}

	public bool WaitRefresh => waitRefresh;

	public long LeftRefreshTime
	{
		get
		{
			return leftRefreshTime;
		}
		protected set
		{
			Set(ref leftRefreshTime, value, "LeftRefreshTime");
		}
	}

	public long LeftDiscountTime
	{
		get
		{
			return leftDiscountTime;
		}
		protected set
		{
			Set(ref leftDiscountTime, value, "LeftDiscountTime");
		}
	}

	public int Sort
	{
		get
		{
			return sort;
		}
		protected set
		{
			Set(ref sort, value, "Sort");
		}
	}

	public long LeftDelistTime
	{
		get
		{
			return leftDelistTime;
		}
		set
		{
			Set(ref leftDelistTime, value, "LeftDelistTime");
		}
	}

	public bool IsUnlock
	{
		get
		{
			return isUnlock;
		}
		set
		{
			Set(ref isUnlock, value, "IsUnlock");
		}
	}

	public int UnlockType
	{
		get
		{
			return unlockType;
		}
		set
		{
			Set(ref unlockType, value, "UnlockType");
		}
	}

	public int UnlockNum
	{
		get
		{
			return unlockNum;
		}
		set
		{
			Set(ref unlockNum, value, "UnlockNum");
		}
	}

	public bool SoldOutShow
	{
		get
		{
			return soldOutShow;
		}
		set
		{
			Set(ref soldOutShow, value, "SoldOutShow");
		}
	}

	public bool ShowCustomTag
	{
		get
		{
			return showCustomTag;
		}
		protected set
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
		protected set
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
		protected set
		{
			Set(ref customTagImage, value, "CustomTagImage");
		}
	}

	public static ShopExcData Create(int mainShopId, int shopId, PbShopExchangeInfo pbShopExchangeInfo)
	{
		PropDataBase propDataBase = PropDataBase.CreateByType(pbShopExchangeInfo.ItemType, pbShopExchangeInfo.ItemId, pbShopExchangeInfo.ItemCount);
		DRExchangeShop dataRow = GameEntry.DataTable.GetDataRow<DRExchangeShop>(pbShopExchangeInfo.ExchangeId);
		if (propDataBase == null || dataRow == null)
		{
			return null;
		}
		ShopExcData obj = new ShopExcData
		{
			MainShopId = mainShopId,
			ShopId = shopId,
			ExcId = pbShopExchangeInfo.ExchangeId,
			Prop = propDataBase,
			QuotaNum = pbShopExchangeInfo.ExchangeCount,
			LeftExc = pbShopExchangeInfo.LeftCount,
			LeftRefreshTime = pbShopExchangeInfo.RefreshTime,
			LeftDelistTime = pbShopExchangeInfo.DelistTime,
			IsUnlock = pbShopExchangeInfo.IsUnlock,
			Sort = dataRow.Sort,
			UnlockType = dataRow.UnlockType,
			UnlockNum = dataRow.UnlockNum,
			SoldOutShow = dataRow.SoldOutShow,
			ShowCustomTag = (!string.IsNullOrEmpty(dataRow.CustomTagIcon) && !string.IsNullOrEmpty(dataRow.CustomTagText)),
			CustomTagImage = dataRow.CustomTagIcon,
			CustomTagText = dataRow.CustomTagText
		};
		RefreshConsumeSchemes(obj, pbShopExchangeInfo.ConsumeItemInfo);
		return obj;
	}

	protected static void RefreshConsumeSchemes(ShopExcData exchangeData, List<PbShopConsumeItem> pbShopConsumeItems)
	{
		exchangeData.CashPriceCount = 0;
		exchangeData.CashPriceOriginalCount = 0;
		exchangeData.ConsumeSchemes.Clear();
		exchangeData.LeftDiscountTime = -1L;
		if (pbShopConsumeItems.Count > 0)
		{
			foreach (PbShopConsumeItem pbShopConsumeItem in pbShopConsumeItems)
			{
				List<PropDataBase> list = new List<PropDataBase>();
				for (int i = 0; i < pbShopConsumeItem.ConsumeItemId.Count; i++)
				{
					if (pbShopConsumeItem.ConsumeItemType.Count <= i || pbShopConsumeItem.ConsumeItemCount.Count <= i || pbShopConsumeItem.ConsumeItemOriginalCount.Count <= i)
					{
						continue;
					}
					if (pbShopConsumeItem.ConsumeItemType[i] == 99)
					{
						exchangeData.CashPriceCount = pbShopConsumeItem.ConsumeItemCount[i];
						exchangeData.CashPriceOriginalCount = pbShopConsumeItem.ConsumeItemOriginalCount[i];
						continue;
					}
					PropDataBase propDataBase = PropDataBase.CreateByType(pbShopConsumeItem.ConsumeItemType[i], pbShopConsumeItem.ConsumeItemId[i], pbShopConsumeItem.ConsumeItemCount[i]);
					if (propDataBase != null)
					{
						propDataBase.MaxCount = pbShopConsumeItem.ConsumeItemOriginalCount[i];
						list.Add(propDataBase);
					}
				}
				exchangeData.ConsumeSchemes.Add(list);
			}
			exchangeData.LeftDiscountTime = pbShopConsumeItems[0].LastDiscountTime;
		}
		exchangeData.waitRefresh = exchangeData.LeftDiscountTime >= 0 || exchangeData.LeftRefreshTime >= 0 || exchangeData.LeftDelistTime >= 0;
		exchangeData.UpdateFreeNew();
	}

	public void ChangeLeftExc(int useExc)
	{
		if (LeftExc > 0)
		{
			LeftExc -= useExc;
			UpdateFreeNew();
		}
	}

	public void UpdateLeftTime(int second)
	{
		if (!waitRefresh)
		{
			return;
		}
		if (LeftRefreshTime > 0)
		{
			LeftRefreshTime -= second;
			if (LeftRefreshTime < 0)
			{
				LeftRefreshTime = 0L;
			}
		}
		if (LeftDiscountTime > 0)
		{
			LeftDiscountTime -= second;
			if (LeftDiscountTime < 0)
			{
				LeftDiscountTime = 0L;
			}
		}
		if (LeftDelistTime > 0)
		{
			LeftDelistTime -= second;
			if (LeftDelistTime < 0)
			{
				LeftDelistTime = 0L;
			}
		}
	}

	protected void UpdateFreeNew()
	{
		if (LeftExc <= 0)
		{
			FreeNew = false;
			return;
		}
		if (CashPriceCount > 0 || CashPriceOriginalCount > 0)
		{
			FreeNew = CashPriceCount == 0 && CashPriceOriginalCount > 0;
			return;
		}
		if (consumeSchemes.Count <= 0)
		{
			FreeNew = false;
			return;
		}
		bool flag = true;
		foreach (PropDataBase item in consumeSchemes[0])
		{
			if (item.Amount > 0)
			{
				flag = false;
				break;
			}
		}
		FreeNew = flag;
	}

	public string GetUnlockCondition(Color color)
	{
		string result = "";
		string text = ColorUtility.ToHtmlStringRGBA(color);
		switch (UnlockType)
		{
		case 1:
			result = $"传火等级<color=#{text}>{UnlockNum}级</color>解锁";
			break;
		case 2:
		{
			DRTask dataRow = GameEntry.DataTable.GetDataRow((DRTask p) => p.CopyOpen == UnlockNum);
			result = "完成<color=#" + text + ">" + dataRow.TaskName + "</color>解锁";
			break;
		}
		case 4:
			result = $"公会等级<color=#{text}>{UnlockNum}级</color>解锁";
			break;
		case 5:
			result = "誓约烬天使解锁";
			break;
		}
		return result;
	}
}
