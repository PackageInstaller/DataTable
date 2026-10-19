using System;

namespace ACT.Config;

[Serializable]
public class NameCard
{
	public readonly int id;

	public readonly int iconID;

	public readonly int getWay;

	public readonly int channelType;

	public readonly int sort;

	public readonly int spName;

	public NameCard(int id, int iconID, int getWay, int channelType, int sort, int spName)
	{
		this.id = id;
		this.iconID = iconID;
		this.getWay = getWay;
		this.channelType = channelType;
		this.sort = sort;
		this.spName = spName;
	}
}
