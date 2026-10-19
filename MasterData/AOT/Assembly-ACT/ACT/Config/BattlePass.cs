using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class BattlePass
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly long shopStartTs;

	public readonly long shopEndTs;

	public readonly string productid = "";

	public readonly List<ItemKv> payitem;

	public readonly List<ItemKv> payupitem;

	public readonly int[] gemitem = new int[0];

	public readonly int[] quest = new int[0];

	public readonly int battlePassLevelMax;

	public readonly int stage;

	public readonly int stageNum;

	public readonly int shopJump;

	public readonly int bpShop;

	public readonly int expirationReminderEmail;

	public readonly int expirationReminderDaysBefore;

	public readonly bool skipJumpTraverse;

	public BattlePass(int id, int nameLocal, long shopStartTs, long shopEndTs, string productid, List<ItemKv> payitem, List<ItemKv> payupitem, int[] gemitem, int[] quest, int battlePassLevelMax, int stage, int stageNum, int shopJump, int bpShop, int expirationReminderEmail, int expirationReminderDaysBefore, bool skipJumpTraverse)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.shopStartTs = shopStartTs;
		this.shopEndTs = shopEndTs;
		this.productid = productid;
		this.payitem = payitem;
		this.payupitem = payupitem;
		this.gemitem = gemitem;
		this.quest = quest;
		this.battlePassLevelMax = battlePassLevelMax;
		this.stage = stage;
		this.stageNum = stageNum;
		this.shopJump = shopJump;
		this.bpShop = bpShop;
		this.expirationReminderEmail = expirationReminderEmail;
		this.expirationReminderDaysBefore = expirationReminderDaysBefore;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
