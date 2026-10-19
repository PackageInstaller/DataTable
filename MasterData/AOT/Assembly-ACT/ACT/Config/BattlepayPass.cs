using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class BattlepayPass
{
	public readonly int id;

	public readonly string productid = "";

	public readonly int type;

	public readonly int bundlename;

	public readonly int bundledetail;

	public readonly int limitCount;

	public readonly int[] bundletag = new int[0];

	public readonly int bundleoff;

	public readonly int preprice;

	public readonly int paytype;

	public readonly int price;

	public readonly string tier = "";

	public readonly List<ItemKv> bundleitem;

	public readonly List<ItemKv> bundlediffitem;

	public readonly int bplevelup;

	public readonly int value;

	public readonly int icon;

	public BattlepayPass(int id, string productid, int type, int bundlename, int bundledetail, int limitCount, int[] bundletag, int bundleoff, int preprice, int paytype, int price, string tier, List<ItemKv> bundleitem, List<ItemKv> bundlediffitem, int bplevelup, int value, int icon)
	{
		this.id = id;
		this.productid = productid;
		this.type = type;
		this.bundlename = bundlename;
		this.bundledetail = bundledetail;
		this.limitCount = limitCount;
		this.bundletag = bundletag;
		this.bundleoff = bundleoff;
		this.preprice = preprice;
		this.paytype = paytype;
		this.price = price;
		this.tier = tier;
		this.bundleitem = bundleitem;
		this.bundlediffitem = bundlediffitem;
		this.bplevelup = bplevelup;
		this.value = value;
		this.icon = icon;
	}
}
