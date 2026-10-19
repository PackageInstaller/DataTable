using System;

namespace ACT.Config;

[Serializable]
public class GachaPool
{
	public readonly int id;

	public readonly int gachaId;

	public readonly int quality;

	public readonly int[] gachaItemIDs = new int[0];

	public GachaPool(int id, int gachaId, int quality, int[] gachaItemIDs)
	{
		this.id = id;
		this.gachaId = gachaId;
		this.quality = quality;
		this.gachaItemIDs = gachaItemIDs;
	}
}
