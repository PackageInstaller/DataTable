using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ShopViewModel : ViewModelBase
{
	private Dictionary<int, Dictionary<int, ShopInfoData>> allShopDatas = new Dictionary<int, Dictionary<int, ShopInfoData>>();

	public void InitShopDatas(Dictionary<int, Dictionary<int, ShopInfoData>> datas)
	{
		allShopDatas = datas;
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.GoodsInitialized);
	}

	public void UpdateMainShopData(int mainShopId, List<ShopInfoData> shopList)
	{
		if (!allShopDatas.ContainsKey(mainShopId))
		{
			allShopDatas.Add(mainShopId, new Dictionary<int, ShopInfoData>());
		}
		Dictionary<int, ShopInfoData> dictionary = new Dictionary<int, ShopInfoData>();
		foreach (ShopInfoData shop in shopList)
		{
			if (shop != null)
			{
				if (allShopDatas[mainShopId].ContainsKey(shop.ShopId) && allShopDatas[mainShopId][shop.ShopId].RefreshNew)
				{
					shop.SetRefreshRed(red: true);
				}
				dictionary.Add(shop.ShopId, shop);
			}
		}
		allShopDatas[mainShopId] = dictionary;
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
	}

	public void UpdateShopDatas(List<ShopInfoData> shops)
	{
		if (shops == null)
		{
			return;
		}
		foreach (ShopInfoData shop in shops)
		{
			UpdateShopData(shop, publish: false);
		}
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
	}

	public void UpdateShopData(ShopInfoData shop, bool publish = true)
	{
		if (shop == null)
		{
			return;
		}
		if (!allShopDatas.ContainsKey(shop.MainShopId))
		{
			allShopDatas.Add(shop.MainShopId, new Dictionary<int, ShopInfoData>());
		}
		if (allShopDatas[shop.MainShopId].ContainsKey(shop.ShopId))
		{
			if (allShopDatas[shop.MainShopId][shop.ShopId].RefreshNew)
			{
				shop.SetRefreshRed(red: true);
			}
			allShopDatas[shop.MainShopId][shop.ShopId] = shop;
		}
		else
		{
			allShopDatas[shop.MainShopId].Add(shop.ShopId, shop);
		}
		if (publish)
		{
			Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
		}
	}

	public void UpdateShopExcData(int mainShopId, int shopId, List<ShopExcData> excDatas)
	{
		if (excDatas != null && allShopDatas.ContainsKey(mainShopId) && allShopDatas[mainShopId].ContainsKey(shopId))
		{
			allShopDatas[mainShopId][shopId].UpdateExcDatas(excDatas);
			Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
		}
	}

	public void SetRead(int shopId)
	{
		foreach (Dictionary<int, ShopInfoData> value in allShopDatas.Values)
		{
			foreach (ShopInfoData value2 in value.Values)
			{
				if (value2.ShopId == shopId)
				{
					value2.SetRefreshRed(red: false);
					Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
					return;
				}
			}
		}
	}

	public Dictionary<int, Dictionary<int, ShopInfoData>> GetAllShopDatas()
	{
		return allShopDatas;
	}

	public Dictionary<int, Dictionary<int, ShopInfoData>> GetMainShopDatas(ShopGoodItemData.ShopPosition position)
	{
		Dictionary<int, Dictionary<int, ShopInfoData>> dictionary = new Dictionary<int, Dictionary<int, ShopInfoData>>();
		if (allShopDatas == null)
		{
			return dictionary;
		}
		foreach (int key in allShopDatas.Keys)
		{
			DRMainShopList dataRow = GameEntry.DataTable.GetDataRow<DRMainShopList>(key);
			if (dataRow != null && dataRow.ShopPosition == (int)position)
			{
				dictionary.Add(key, allShopDatas[key]);
			}
		}
		return dictionary;
	}

	public Dictionary<int, ShopInfoData> GetShopDatas(int mainShopId)
	{
		Dictionary<int, ShopInfoData> result = new Dictionary<int, ShopInfoData>();
		if (allShopDatas.ContainsKey(mainShopId) && allShopDatas[mainShopId] != null)
		{
			result = allShopDatas[mainShopId];
		}
		return result;
	}

	public ShopInfoData GetShopData(int mainShopId, int shopId)
	{
		if (allShopDatas.TryGetValue(mainShopId, out var value) && value.TryGetValue(shopId, out var value2))
		{
			return value2;
		}
		return null;
	}

	public ShopExcData GetGoods(int excId)
	{
		if (allShopDatas == null)
		{
			return null;
		}
		foreach (Dictionary<int, ShopInfoData> value in allShopDatas.Values)
		{
			if (value == null)
			{
				continue;
			}
			foreach (ShopInfoData value2 in value.Values)
			{
				ShopExcData shopExcData = value2?.ShopExcDatas.Values.ToList().Find((ShopExcData p) => p.ExcId == excId);
				if (shopExcData != null)
				{
					return shopExcData;
				}
			}
		}
		return null;
	}

	public void UpdateExcResult(int mainId, int shopId, int excId, int count)
	{
		if (allShopDatas.ContainsKey(mainId) && allShopDatas[mainId].ContainsKey(shopId))
		{
			allShopDatas[mainId][shopId].UpdateExcDataLeftExc(excId, count);
		}
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().PublishMessage(ShopMessageEnum.UpdateRed);
	}
}
