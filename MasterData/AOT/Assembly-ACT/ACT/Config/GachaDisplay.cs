using System;

namespace ACT.Config;

[Serializable]
public class GachaDisplay
{
	public readonly int id;

	public readonly int bannerPic;

	public readonly string poster = "";

	public readonly int[] up4StarCharacterIds = new int[0];

	public readonly int checkDes;

	public GachaDisplay(int id, int bannerPic, string poster, int[] up4StarCharacterIds, int checkDes)
	{
		this.id = id;
		this.bannerPic = bannerPic;
		this.poster = poster;
		this.up4StarCharacterIds = up4StarCharacterIds;
		this.checkDes = checkDes;
	}
}
