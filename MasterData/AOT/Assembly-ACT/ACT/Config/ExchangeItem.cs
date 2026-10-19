using System;

namespace ACT.Config;

[Serializable]
public class ExchangeItem
{
	public readonly int id;

	public readonly int itemId;

	public readonly int ExchangeCount;

	public readonly int raidEntranceId;

	public readonly int xchangeSequen;

	public ExchangeItem(int id, int itemId, int ExchangeCount, int raidEntranceId, int xchangeSequen)
	{
		this.id = id;
		this.itemId = itemId;
		this.ExchangeCount = ExchangeCount;
		this.raidEntranceId = raidEntranceId;
		this.xchangeSequen = xchangeSequen;
	}
}
