using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Recharge
{
	public readonly int id;

	public readonly string productid = "";

	public readonly string productname = "";

	public readonly int type;

	public readonly int price;

	public readonly string tier = "";

	public readonly int limitCount;

	public readonly List<ItemKv> item;

	public readonly int quantity;

	public readonly int firstPay;

	public readonly int normalPay;

	public readonly string icon = "";

	public readonly int tag;

	public readonly int dec;

	public readonly int sort;

	public Recharge(int id, string productid, string productname, int type, int price, string tier, int limitCount, List<ItemKv> item, int quantity, int firstPay, int normalPay, string icon, int tag, int dec, int sort)
	{
		this.id = id;
		this.productid = productid;
		this.productname = productname;
		this.type = type;
		this.price = price;
		this.tier = tier;
		this.limitCount = limitCount;
		this.item = item;
		this.quantity = quantity;
		this.firstPay = firstPay;
		this.normalPay = normalPay;
		this.icon = icon;
		this.tag = tag;
		this.dec = dec;
		this.sort = sort;
	}
}
