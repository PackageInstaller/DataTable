using System;

namespace ACT.Config;

[Serializable]
public class Season
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly long startTime;

	public readonly long endTime;

	public readonly int refreshType;

	public readonly int cycleMax;

	public readonly int shopId;

	public Season(int id, int name, int description, long startTime, long endTime, int refreshType, int cycleMax, int shopId)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.startTime = startTime;
		this.endTime = endTime;
		this.refreshType = refreshType;
		this.cycleMax = cycleMax;
		this.shopId = shopId;
	}
}
