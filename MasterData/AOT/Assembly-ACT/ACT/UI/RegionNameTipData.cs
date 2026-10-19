using ACT.Sound;

namespace ACT.UI;

public class RegionNameTipData : BaseTipData
{
	public readonly string mapName;

	public readonly string areaName;

	public readonly string areaTips;

	public readonly AudioEventReference regionSound;

	public readonly int colorDefine;

	public RegionNameTipData(string mapName, string areaName, string areaTips, AudioEventReference regionSound, int colorDefine)
	{
		this.mapName = mapName;
		this.areaName = areaName;
		this.areaTips = areaTips;
		this.regionSound = regionSound;
		this.colorDefine = colorDefine;
	}
}
