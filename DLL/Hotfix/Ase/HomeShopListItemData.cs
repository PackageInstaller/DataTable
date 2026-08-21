using System.Collections.Generic;

namespace Ase;

public class HomeShopListItemData : OptionBase
{
	private PlayerData playerData;

	private HomeShopInfoData shopInfoData;

	private string playerName;

	private string headIcon = "";

	private string headFrame = "";

	private bool isCurrentShop;

	private List<HomeShopExcData> goodsData = new List<HomeShopExcData>();

	public string PlayerName
	{
		get
		{
			return playerName;
		}
		set
		{
			Set(ref playerName, value, "PlayerName");
		}
	}

	public string HeadIcon
	{
		get
		{
			return headIcon;
		}
		set
		{
			Set(ref headIcon, value, "HeadIcon");
		}
	}

	public string HeadFrame
	{
		get
		{
			return headFrame;
		}
		set
		{
			Set(ref headFrame, value, "HeadFrame");
		}
	}

	public bool IsCurrentShop
	{
		get
		{
			return isCurrentShop;
		}
		set
		{
			Set(ref isCurrentShop, value, "IsCurrentShop");
		}
	}

	public PlayerData PlayerData => playerData;

	public HomeShopInfoData ShopInfoData => shopInfoData;

	public List<HomeShopExcData> GoodsData => goodsData;

	public HomeShopListItemData()
	{
	}

	public HomeShopListItemData(OptionBase parent, PlayerData playerData, HomeShopInfoData homeShopInfoData, bool isCurrentShop)
	{
		base.parent = parent;
		this.playerData = playerData;
		shopInfoData = homeShopInfoData;
		PlayerName = playerData.Name;
		HeadIcon = playerData.Icon;
		HeadFrame = $"HeadAdorn{playerData.IconFrame}";
		IsCurrentShop = isCurrentShop;
		foreach (ShopExcData item2 in homeShopInfoData.ShopExcDatas.Values.ToList())
		{
			if (item2.QuotaNum != 0 && item2 is HomeShopExcData item)
			{
				goodsData.Add(item);
			}
		}
	}

	public void OnBtnGoClick()
	{
		parent?.ItemOnClick(this);
	}
}
