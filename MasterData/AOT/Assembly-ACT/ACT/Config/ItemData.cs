using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemData
{
	public readonly int id;

	public readonly int iconAddress;

	public readonly int nameLocal;

	public readonly int type;

	public readonly int typeLocal;

	public readonly int descLocal;

	public readonly int quality;

	public readonly string address = "";

	public readonly int canBeDeplay;

	public readonly List<ItemKv> canBeTransited;

	public readonly int stackLimit;

	public readonly int ItemDateType;

	public readonly long ItemDatePara;

	public readonly bool canBeDelete;

	public readonly List<ItemKv> deleteCompensate;

	public readonly bool canBeUse;

	public readonly int useType;

	public readonly int Use;

	public readonly bool autoUseEnabled;

	public readonly bool canAutoPick;

	public readonly bool isNeedNewTip;

	public readonly bool isNeedRareTip;

	public readonly int jumpType;

	public readonly int[] navigation = new int[0];

	public readonly List<ItemKv> itemCrafting;

	public readonly bool overStackDontSendEmail;

	public ItemData(int id, int iconAddress, int nameLocal, int type, int typeLocal, int descLocal, int quality, string address, int canBeDeplay, List<ItemKv> canBeTransited, int stackLimit, int ItemDateType, long ItemDatePara, bool canBeDelete, List<ItemKv> deleteCompensate, bool canBeUse, int useType, int Use, bool autoUseEnabled, bool canAutoPick, bool isNeedNewTip, bool isNeedRareTip, int jumpType, int[] navigation, List<ItemKv> itemCrafting, bool overStackDontSendEmail)
	{
		this.id = id;
		this.iconAddress = iconAddress;
		this.nameLocal = nameLocal;
		this.type = type;
		this.typeLocal = typeLocal;
		this.descLocal = descLocal;
		this.quality = quality;
		this.address = address;
		this.canBeDeplay = canBeDeplay;
		this.canBeTransited = canBeTransited;
		this.stackLimit = stackLimit;
		this.ItemDateType = ItemDateType;
		this.ItemDatePara = ItemDatePara;
		this.canBeDelete = canBeDelete;
		this.deleteCompensate = deleteCompensate;
		this.canBeUse = canBeUse;
		this.useType = useType;
		this.Use = Use;
		this.autoUseEnabled = autoUseEnabled;
		this.canAutoPick = canAutoPick;
		this.isNeedNewTip = isNeedNewTip;
		this.isNeedRareTip = isNeedRareTip;
		this.jumpType = jumpType;
		this.navigation = navigation;
		this.itemCrafting = itemCrafting;
		this.overStackDontSendEmail = overStackDontSendEmail;
	}
}
