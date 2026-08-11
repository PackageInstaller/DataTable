using System;
using System.Collections.Generic;

namespace Ase;

public class HomeShopInfoData : ShopInfoData
{
	private long friendAddTime;

	public bool GetFriendOpenState()
	{
		if (friendAddTime <= 0)
		{
			return true;
		}
		TimeSpan ts = new TimeSpan(TimeHelper.GetLocalDateTime(friendAddTime).Ticks);
		TimeSpan timeSpan = new TimeSpan(DateTime.Now.Ticks);
		return timeSpan.Subtract(ts).Duration().TotalDays >= 1.0;
	}

	public static HomeShopInfoData Create(int shopId, List<PbHomeLandShopItem> goods, bool selfShop, long friendAddTime = 0L)
	{
		HomeShopInfoData data = new HomeShopInfoData
		{
			ShopId = shopId,
			friendAddTime = friendAddTime
		};
		goods?.ForEach(delegate(PbHomeLandShopItem p)
		{
			HomeShopExcData homeShopExcData2 = HomeShopExcData.Create(shopId, p.GridId, p.ConfigId, p.BoughtCount, selfShop);
			if (homeShopExcData2.ShopId > 0)
			{
				data.shopExcDatas.Add(p.GridId, homeShopExcData2);
			}
		});
		data.consumeItemIds = new List<int>();
		data.consumeItemTypes = new List<int>();
		Dictionary<int, ShopExcData>.Enumerator enumerator = data.shopExcDatas.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator.Current.Value is HomeShopExcData homeShopExcData)
			{
				DRHomeLandShopGoodsGroup dataRow = GameEntry.DataTable.GetDataRow<DRHomeLandShopGoodsGroup>(homeShopExcData.ConfigId);
				if (dataRow != null && !data.consumeItemIds.Contains(dataRow.PriceType))
				{
					data.consumeItemIds.Add(dataRow.PriceType);
					data.consumeItemTypes.Add(3);
				}
			}
		}
		enumerator.Dispose();
		data.UpdateFreeNew();
		return data;
	}

	public void UpdateExcDatas(List<HomeShopExcData> excDatas)
	{
		if (excDatas == null)
		{
			return;
		}
		foreach (HomeShopExcData excData in excDatas)
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
}
