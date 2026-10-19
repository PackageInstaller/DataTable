using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class RaidTypeData
{
	public readonly int id;

	public readonly int raidType;

	public readonly int[] raidEntranceId = new int[0];

	public readonly int typeName;

	public readonly int raidBanner;

	public readonly int typeText;

	public readonly int showText;

	public readonly List<ItemKv> raidEntranUnlock;

	public readonly List<ItemKv> cost;

	public readonly long[] raidDatePara = new long[0];

	public readonly int cycleType;

	public readonly int[] cycleParm = new int[0];

	public readonly int rewardType;

	public readonly List<ItemKv> rewardPreview;

	public readonly int entranceNpc;

	public readonly int isShow;

	public readonly int titleText;

	public RaidTypeData(int id, int raidType, int[] raidEntranceId, int typeName, int raidBanner, int typeText, int showText, List<ItemKv> raidEntranUnlock, List<ItemKv> cost, long[] raidDatePara, int cycleType, int[] cycleParm, int rewardType, List<ItemKv> rewardPreview, int entranceNpc, int isShow, int titleText)
	{
		this.id = id;
		this.raidType = raidType;
		this.raidEntranceId = raidEntranceId;
		this.typeName = typeName;
		this.raidBanner = raidBanner;
		this.typeText = typeText;
		this.showText = showText;
		this.raidEntranUnlock = raidEntranUnlock;
		this.cost = cost;
		this.raidDatePara = raidDatePara;
		this.cycleType = cycleType;
		this.cycleParm = cycleParm;
		this.rewardType = rewardType;
		this.rewardPreview = rewardPreview;
		this.entranceNpc = entranceNpc;
		this.isShow = isShow;
		this.titleText = titleText;
	}
}
