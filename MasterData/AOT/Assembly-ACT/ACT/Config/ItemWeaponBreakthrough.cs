using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemWeaponBreakthrough
{
	public readonly int id;

	public readonly int weaponID;

	public readonly int weaponStage;

	public readonly int maxLevel;

	public readonly List<ItemKv> breakRequirement;

	public readonly int breakCoin;

	public ItemWeaponBreakthrough(int id, int weaponID, int weaponStage, int maxLevel, List<ItemKv> breakRequirement, int breakCoin)
	{
		this.id = id;
		this.weaponID = weaponID;
		this.weaponStage = weaponStage;
		this.maxLevel = maxLevel;
		this.breakRequirement = breakRequirement;
		this.breakCoin = breakCoin;
	}
}
