using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class GachaPoolNotice
{
	public readonly int id;

	public readonly int quality;

	public readonly float baseRate10000;

	public readonly float finalRate10000;

	public readonly List<ItemKv> gachaItemUpList;

	public GachaPoolNotice(int id, int quality, float baseRate10000, float finalRate10000, List<ItemKv> gachaItemUpList)
	{
		this.id = id;
		this.quality = quality;
		this.baseRate10000 = baseRate10000;
		this.finalRate10000 = finalRate10000;
		this.gachaItemUpList = gachaItemUpList;
	}
}
