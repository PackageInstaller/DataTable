using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class MonthlyPass
{
	public readonly int id;

	public readonly int monthlyitemid;

	public readonly string productid = "";

	public readonly int type;

	public readonly int bundlename;

	public readonly int bundledetail;

	public readonly int limitday;

	public readonly int[] mptag = new int[0];

	public readonly int missionGroupId;

	public readonly int paytype;

	public readonly List<ItemKv> itemNeed;

	public readonly int price;

	public readonly string tier = "";

	public readonly List<ItemKv> item;

	public readonly List<ItemKv> itemdaily;

	public readonly int offerday;

	public readonly int value;

	public readonly int icon;

	public readonly int expirationReminderEmail;

	public readonly int expirationReminderDaysBefore;

	public MonthlyPass(int id, int monthlyitemid, string productid, int type, int bundlename, int bundledetail, int limitday, int[] mptag, int missionGroupId, int paytype, List<ItemKv> itemNeed, int price, string tier, List<ItemKv> item, List<ItemKv> itemdaily, int offerday, int value, int icon, int expirationReminderEmail, int expirationReminderDaysBefore)
	{
		this.id = id;
		this.monthlyitemid = monthlyitemid;
		this.productid = productid;
		this.type = type;
		this.bundlename = bundlename;
		this.bundledetail = bundledetail;
		this.limitday = limitday;
		this.mptag = mptag;
		this.missionGroupId = missionGroupId;
		this.paytype = paytype;
		this.itemNeed = itemNeed;
		this.price = price;
		this.tier = tier;
		this.item = item;
		this.itemdaily = itemdaily;
		this.offerday = offerday;
		this.value = value;
		this.icon = icon;
		this.expirationReminderEmail = expirationReminderEmail;
		this.expirationReminderDaysBefore = expirationReminderDaysBefore;
	}
}
