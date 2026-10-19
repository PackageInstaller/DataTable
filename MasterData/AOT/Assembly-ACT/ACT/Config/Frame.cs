using System;

namespace ACT.Config;

[Serializable]
public class Frame
{
	public readonly int id;

	public readonly int name;

	public readonly int iconID;

	public readonly int getWay;

	public readonly int channelType;

	public readonly int[] duration = new int[0];

	public readonly int sort;

	public Frame(int id, int name, int iconID, int getWay, int channelType, int[] duration, int sort)
	{
		this.id = id;
		this.name = name;
		this.iconID = iconID;
		this.getWay = getWay;
		this.channelType = channelType;
		this.duration = duration;
		this.sort = sort;
	}
}
