using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Bundle
{
	public readonly int id;

	public readonly string productid = "";

	public readonly int type;

	public readonly int bundlename;

	public readonly int bundledetail;

	public readonly int limitCount;

	public readonly int limitRefreshType;

	public readonly int specialrefreshId;

	public readonly int versionRefresh;

	public readonly int[] bundletag = new int[0];

	public readonly int bundleoff;

	public readonly int preprice;

	public readonly int quality;

	public readonly int missionGroupId;

	public readonly int paytype;

	public readonly List<ItemKv> itemNeed;

	public readonly int price;

	public readonly string tier = "";

	public readonly List<ItemKv> bundleitem;

	public readonly int prebundle;

	public readonly int selectnum;

	public readonly List<ItemKv> selectitem;

	public readonly List<ItemKv> multiitem;

	public readonly int offerday;

	public readonly int automail;

	public readonly int value;

	public readonly int icon;

	public Bundle(int id, string productid, int type, int bundlename, int bundledetail, int limitCount, int limitRefreshType, int specialrefreshId, int versionRefresh, int[] bundletag, int bundleoff, int preprice, int quality, int missionGroupId, int paytype, List<ItemKv> itemNeed, int price, string tier, List<ItemKv> bundleitem, int prebundle, int selectnum, List<ItemKv> selectitem, List<ItemKv> multiitem, int offerday, int automail, int value, int icon)
	{
		this.id = id;
		this.productid = productid;
		this.type = type;
		this.bundlename = bundlename;
		this.bundledetail = bundledetail;
		this.limitCount = limitCount;
		this.limitRefreshType = limitRefreshType;
		this.specialrefreshId = specialrefreshId;
		this.versionRefresh = versionRefresh;
		this.bundletag = bundletag;
		this.bundleoff = bundleoff;
		this.preprice = preprice;
		this.quality = quality;
		this.missionGroupId = missionGroupId;
		this.paytype = paytype;
		this.itemNeed = itemNeed;
		this.price = price;
		this.tier = tier;
		this.bundleitem = bundleitem;
		this.prebundle = prebundle;
		this.selectnum = selectnum;
		this.selectitem = selectitem;
		this.multiitem = multiitem;
		this.offerday = offerday;
		this.automail = automail;
		this.value = value;
		this.icon = icon;
	}
}
