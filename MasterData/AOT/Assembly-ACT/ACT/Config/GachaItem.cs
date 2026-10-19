using System;

namespace ACT.Config;

[Serializable]
public class GachaItem
{
	public readonly int id;

	public readonly int gachaPoolId;

	public readonly int quality;

	public readonly int itemId;

	public readonly int itemQuantity;

	public readonly int baseWeight;

	public readonly int prdIncreaseWeight;

	public readonly bool isFeatured;

	public GachaItem(int id, int gachaPoolId, int quality, int itemId, int itemQuantity, int baseWeight, int prdIncreaseWeight, bool isFeatured)
	{
		this.id = id;
		this.gachaPoolId = gachaPoolId;
		this.quality = quality;
		this.itemId = itemId;
		this.itemQuantity = itemQuantity;
		this.baseWeight = baseWeight;
		this.prdIncreaseWeight = prdIncreaseWeight;
		this.isFeatured = isFeatured;
	}
}
