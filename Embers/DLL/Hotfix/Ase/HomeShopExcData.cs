using System.Collections.Generic;

namespace Ase;

public class HomeShopExcData : ShopExcData
{
	private int configId;

	public int ConfigId
	{
		get
		{
			return configId;
		}
		private set
		{
			Set(ref configId, value, "ConfigId");
		}
	}

	public static HomeShopExcData Create(int shopId, int gridId, int configId, int boughtCount, bool selfBuy)
	{
		DRHomeLandShopGoodsGroup dataRow = GameEntry.DataTable.GetDataRow<DRHomeLandShopGoodsGroup>(configId);
		if (dataRow == null)
		{
			return new HomeShopExcData();
		}
		int num = (selfBuy ? dataRow.SelfBuyLimit : dataRow.FriendBuyLimit);
		HomeShopExcData obj = new HomeShopExcData
		{
			ShopId = shopId,
			ExcId = gridId,
			ConfigId = configId,
			Prop = PropDataBase.CreateByType(dataRow.ItemType, dataRow.ItemId, dataRow.EachCount),
			QuotaNum = num,
			LeftExc = num - boughtCount,
			IsUnlock = true,
			SoldOutShow = true
		};
		RefreshConsumeSchemes(obj, dataRow.PriceType, dataRow.Price);
		return obj;
	}

	private static void RefreshConsumeSchemes(HomeShopExcData exchangeData, int consumeId, int consumeCount)
	{
		exchangeData.ConsumeSchemes.Clear();
		PropDataBase propDataBase = PropDataBase.CreateByType(PropTypeEnum.Coin, consumeId, consumeCount);
		propDataBase.MaxCount = consumeCount;
		exchangeData.ConsumeSchemes.Add(new List<PropDataBase> { propDataBase });
		exchangeData.UpdateFreeNew();
	}
}
