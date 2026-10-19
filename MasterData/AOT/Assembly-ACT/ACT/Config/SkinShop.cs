using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class SkinShop
{
	public readonly int id;

	public readonly int skinid;

	public readonly string productid = "";

	public readonly int type;

	public readonly int quality;

	public readonly int bundlename;

	public readonly int bundledetail;

	public readonly int limitCount;

	public readonly int limitRefreshType;

	public readonly int[] tag = new int[0];

	public readonly int paytype;

	public readonly List<ItemKv> itemNeed;

	public readonly int preprice;

	public readonly int price;

	public readonly string tier = "";

	public readonly List<ItemKv> item;

	public SkinShop(int id, int skinid, string productid, int type, int quality, int bundlename, int bundledetail, int limitCount, int limitRefreshType, int[] tag, int paytype, List<ItemKv> itemNeed, int preprice, int price, string tier, List<ItemKv> item)
	{
		this.id = id;
		this.skinid = skinid;
		this.productid = productid;
		this.type = type;
		this.quality = quality;
		this.bundlename = bundlename;
		this.bundledetail = bundledetail;
		this.limitCount = limitCount;
		this.limitRefreshType = limitRefreshType;
		this.tag = tag;
		this.paytype = paytype;
		this.itemNeed = itemNeed;
		this.preprice = preprice;
		this.price = price;
		this.tier = tier;
		this.item = item;
	}
}
