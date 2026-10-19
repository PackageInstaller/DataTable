using System;

namespace ACT.Config;

[Serializable]
public class MtyAvatar
{
	public readonly int id;

	public readonly int name;

	public readonly int iconID;

	public readonly int getWay;

	public readonly int[] duration = new int[0];

	public readonly int sort;

	public MtyAvatar(int id, int name, int iconID, int getWay, int[] duration, int sort)
	{
		this.id = id;
		this.name = name;
		this.iconID = iconID;
		this.getWay = getWay;
		this.duration = duration;
		this.sort = sort;
	}
}
