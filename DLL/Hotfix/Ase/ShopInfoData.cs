using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ShopInfoData : ViewModelBase
{
	protected int mainShopId;

	protected int shopId;

	protected string name;

	protected string englishName;

	protected List<int> consumeItemIds = new List<int>();

	protected List<int> consumeItemTypes = new List<int>();

	protected bool waitRefresh;

	protected long refreshEndTime;

	protected Dictionary<int, ShopExcData> shopExcDatas = new Dictionary<int, ShopExcData>();

	protected int sort = -1;

	protected string tips = string.Empty;

	protected bool refreshNew;

	protected bool freeNew;

	public string Tips
	{
		get
		{
			return tips;
		}
		protected set
		{
			Set(ref tips, value, "Tips");
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

	public bool New
	{
		get
		{
			if (!RefreshNew)
			{
				return FreeNew;
			}
			return true;
		}
	}

	public int MainShopId
	{
		get
		{
			return mainShopId;
		}
		set
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

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public string EnglishName
	{
		get
		{
			return englishName;
		}
		set
		{
			Set(ref englishName, value, "EnglishName");
		}
	}

	public bool RefreshNew
	{
		get
		{
			return refreshNew;
		}
		private set
		{
			Set(ref refreshNew, value, "RefreshNew");
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

	public bool WaitRefresh => waitRefresh;

	public long RefreshEndTime
	{
		get
		{
			return refreshEndTime;
		}
		protected set
		{
			Set(ref refreshEndTime, value, "RefreshEndTime");
		}
	}

	public List<int> ConsumeItemIds => consumeItemIds;

	public List<int> ConsumeItemTypes => consumeItemTypes;

	public Dictionary<int, ShopExcData> ShopExcDatas => shopExcDatas;

	public static ShopInfoData Create(PbShopInfo shopInfo, bool refreshNew = false)
	{
		ShopInfoData data = new ShopInfoData
		{
			mainShopId = shopInfo.MainShopId,
			shopId = shopInfo.ShopId,
			consumeItemIds = shopInfo.ConsumeItemId.ToList(),
			consumeItemTypes = shopInfo.ConsumeItemType.ToList(),
			refreshEndTime = shopInfo.RefreshTime
		};
		data.name = shopInfo.ShopName;
		data.waitRefresh = data.RefreshEndTime >= 0;
		data.RefreshNew = refreshNew;
		shopInfo.ExchangeInfos?.ForEach(delegate(PbShopExchangeInfo p)
		{
			if (!data.shopExcDatas.ContainsKey(p.ExchangeId))
			{
				ShopExcData shopExcData = ShopExcData.Create(shopInfo.MainShopId, shopInfo.ShopId, p);
				if (shopExcData != null)
				{
					data.shopExcDatas.Add(p.ExchangeId, shopExcData);
				}
			}
		});
		DRExchangeShopList dataRow = GameEntry.DataTable.GetDataRow<DRExchangeShopList>(data.ShopId);
		data.sort = dataRow?.Sort ?? (-1);
		data.tips = dataRow?.Tips ?? string.Empty;
		data.UpdateFreeNew();
		return data;
	}

	public void SetExcDatas(Dictionary<int, ShopExcData> excDatas)
	{
		shopExcDatas = excDatas;
		UpdateFreeNew();
	}

	public void UpdateExcDatas(List<ShopExcData> excDatas)
	{
		if (excDatas == null)
		{
			return;
		}
		foreach (ShopExcData excData in excDatas)
		{
			if (shopExcDatas.ContainsKey(excData.ExcId))
			{
				shopExcDatas[excData.ExcId] = excData;
			}
			else
			{
				shopExcDatas.Add(excData.ExcId, excData);
			}
		}
		UpdateFreeNew();
	}

	public void UpdateExcDataLeftExc(int excId, int useCount)
	{
		if (shopExcDatas.ContainsKey(excId))
		{
			shopExcDatas[excId].ChangeLeftExc(useCount);
			UpdateFreeNew();
		}
	}

	protected void UpdateFreeNew()
	{
		bool flag = false;
		if (shopExcDatas != null)
		{
			foreach (ShopExcData value in shopExcDatas.Values)
			{
				if (value.FreeNew)
				{
					flag = true;
					break;
				}
			}
		}
		FreeNew = flag;
	}

	public void SetRefreshRed(bool red)
	{
		RefreshNew = red;
	}

	public void UpdateFreshTime(long refreshTime)
	{
		RefreshEndTime = refreshTime;
	}
}
