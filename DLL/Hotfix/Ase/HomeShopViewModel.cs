using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HomeShopViewModel : OptionBase
{
	private HomeShopInfoData homeShopData;

	private Dictionary<long, HomeShopInfoData> friendHomeShopDatas = new Dictionary<long, HomeShopInfoData>();

	public int TodayBoughtCountInShop;

	public int TodayBuyLimitInShop;

	public void InitShopData(HomeShopInfoData data)
	{
		homeShopData = data;
	}

	public void InitFriendShopData(Dictionary<long, HomeShopInfoData> dic)
	{
		friendHomeShopDatas = dic;
	}

	public HomeShopInfoData GetShopData()
	{
		return homeShopData;
	}

	public HomeShopInfoData GetFriendSingleShopData(long shopId)
	{
		if (friendHomeShopDatas.TryGetValue(shopId, out var value))
		{
			return value;
		}
		return null;
	}

	public Dictionary<long, HomeShopInfoData> GetAllFriendShopDatas()
	{
		return friendHomeShopDatas;
	}

	public void RefreshSingleFriendShopData(long shopId, HomeShopInfoData data)
	{
		if (friendHomeShopDatas.ContainsKey(shopId))
		{
			friendHomeShopDatas[shopId] = data;
		}
		else
		{
			friendHomeShopDatas.Add(shopId, data);
		}
	}

	public void ApplyBuyResult(int gridId, int buyCount)
	{
		homeShopData.UpdateExcDataLeftExc(gridId, buyCount);
	}

	public void ApplyFriendBuyResult(long friendId, int gridId, int buyCount)
	{
		if (friendHomeShopDatas.TryGetValue(friendId, out var value))
		{
			value.UpdateExcDataLeftExc(gridId, buyCount);
		}
		TodayBoughtCountInShop += buyCount;
	}

	private string GetLocalRedKey(string prefix = "")
	{
		long valueOrDefault = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.Uid).GetValueOrDefault();
		return $"{prefix}HomelandShopRefresh_{valueOrDefault}";
	}

	private string GetCurServerTimeString()
	{
		ITimeService service = Singleton<ServiceSystem>.Instance.GetService<ITimeService>();
		if (service == null)
		{
			return string.Empty;
		}
		return service.GetCurServerDateTime().ToString("yyyy-MM-dd");
	}

	public bool GetHomeShopRefreshRed()
	{
		string curServerTimeString = GetCurServerTimeString();
		if (string.IsNullOrEmpty(curServerTimeString))
		{
			return false;
		}
		string value = PlayerPrefs.GetString(GetLocalRedKey(), string.Empty);
		return !curServerTimeString.Equals(value);
	}

	public bool GetFriendHomeShopRefreshRed()
	{
		string curServerTimeString = GetCurServerTimeString();
		if (string.IsNullOrEmpty(curServerTimeString))
		{
			return false;
		}
		string value = PlayerPrefs.GetString(GetLocalRedKey("Friend"), string.Empty);
		return !curServerTimeString.Equals(value);
	}

	public bool CheckFriendHomeShopOpened()
	{
		if (friendHomeShopDatas != null && friendHomeShopDatas.Count > 0)
		{
			return friendHomeShopDatas.Values.ToList().Exists((HomeShopInfoData p) => p.GetFriendOpenState());
		}
		return false;
	}

	public void SetHomeShopRefreshRead()
	{
		string curServerTimeString = GetCurServerTimeString();
		PlayerPrefs.SetString(GetLocalRedKey(), curServerTimeString);
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new HomelandMsg(this, HomelandMsgType.ShopRefreshRed));
	}

	public void SetFriendHomeShopRefreshRead()
	{
		string curServerTimeString = GetCurServerTimeString();
		PlayerPrefs.SetString(GetLocalRedKey("Friend"), curServerTimeString);
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new HomelandMsg(this, HomelandMsgType.FriendShopRefreshRed));
	}
}
