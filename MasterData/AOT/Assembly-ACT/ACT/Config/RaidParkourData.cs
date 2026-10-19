using System;

namespace ACT.Config;

[Serializable]
public class RaidParkourData
{
	public readonly int id;

	public readonly int total;

	public readonly int defaultLimit;

	public RaidParkourData(int id, int total, int defaultLimit)
	{
		this.id = id;
		this.total = total;
		this.defaultLimit = defaultLimit;
	}
}
