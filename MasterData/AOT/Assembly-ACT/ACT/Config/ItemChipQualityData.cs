using System;

namespace ACT.Config;

[Serializable]
public class ItemChipQualityData
{
	public readonly int id;

	public readonly int maxEnchantLv;

	public readonly int baseMinNum;

	public readonly int baseMaxNum;

	public readonly int maxNum;

	public readonly int affordEXP;

	public ItemChipQualityData(int id, int maxEnchantLv, int baseMinNum, int baseMaxNum, int maxNum, int affordEXP)
	{
		this.id = id;
		this.maxEnchantLv = maxEnchantLv;
		this.baseMinNum = baseMinNum;
		this.baseMaxNum = baseMaxNum;
		this.maxNum = maxNum;
		this.affordEXP = affordEXP;
	}
}
