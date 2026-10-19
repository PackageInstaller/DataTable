using System;

namespace ACT.Config;

[Serializable]
public class WildBossUse
{
	public readonly int id;

	public readonly int monsterID;

	public readonly int monsterBannerID;

	public readonly int monsterBgID;

	public readonly int[] refreshTime = new int[0];

	public readonly int[] rewards = new int[0];

	public readonly int bossMessage;

	public WildBossUse(int id, int monsterID, int monsterBannerID, int monsterBgID, int[] refreshTime, int[] rewards, int bossMessage)
	{
		this.id = id;
		this.monsterID = monsterID;
		this.monsterBannerID = monsterBannerID;
		this.monsterBgID = monsterBgID;
		this.refreshTime = refreshTime;
		this.rewards = rewards;
		this.bossMessage = bossMessage;
	}
}
