using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class RogueShop
{
	public readonly int id;

	public readonly int[] cardList = new int[0];

	public readonly List<ItemKv> effectNumList;

	public RogueShop(int id, int[] cardList, List<ItemKv> effectNumList)
	{
		this.id = id;
		this.cardList = cardList;
		this.effectNumList = effectNumList;
	}
}
