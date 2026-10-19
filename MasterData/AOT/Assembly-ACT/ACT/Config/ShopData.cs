using System;

namespace ACT.Config;

[Serializable]
public class ShopData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly long shopStartTs;

	public readonly long shopEndTs;

	public readonly int[] subshopIds = new int[0];

	public readonly bool skipJumpTraverse;

	public ShopData(int id, int nameLocal, long shopStartTs, long shopEndTs, int[] subshopIds, bool skipJumpTraverse)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.shopStartTs = shopStartTs;
		this.shopEndTs = shopEndTs;
		this.subshopIds = subshopIds;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
