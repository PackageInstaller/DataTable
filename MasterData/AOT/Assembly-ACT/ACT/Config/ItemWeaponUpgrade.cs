using System;

namespace ACT.Config;

[Serializable]
public class ItemWeaponUpgrade
{
	public readonly int id;

	public readonly int upgradeType;

	public readonly int level;

	public readonly int totalEXPRequired;

	public readonly int xpEachLv;

	public readonly int totalCoinRequired;

	public readonly int coinEachLv;

	public ItemWeaponUpgrade(int id, int upgradeType, int level, int totalEXPRequired, int xpEachLv, int totalCoinRequired, int coinEachLv)
	{
		this.id = id;
		this.upgradeType = upgradeType;
		this.level = level;
		this.totalEXPRequired = totalEXPRequired;
		this.xpEachLv = xpEachLv;
		this.totalCoinRequired = totalCoinRequired;
		this.coinEachLv = coinEachLv;
	}
}
