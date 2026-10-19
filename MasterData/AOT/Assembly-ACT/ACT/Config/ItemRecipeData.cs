using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemRecipeData
{
	public readonly int id;

	public readonly int moduleLevelNeeded;

	public readonly List<ItemKv> itemNeeded;

	public readonly List<ItemKv> itemGiven;

	public readonly int recipeType;

	public readonly bool repeatable;

	public readonly int moneyNeeded;

	public ItemRecipeData(int id, int moduleLevelNeeded, List<ItemKv> itemNeeded, List<ItemKv> itemGiven, int recipeType, bool repeatable, int moneyNeeded)
	{
		this.id = id;
		this.moduleLevelNeeded = moduleLevelNeeded;
		this.itemNeeded = itemNeeded;
		this.itemGiven = itemGiven;
		this.recipeType = recipeType;
		this.repeatable = repeatable;
		this.moneyNeeded = moneyNeeded;
	}
}
