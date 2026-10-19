using System;

namespace ACT.Config;

[Serializable]
public class ItemChipLvUpData
{
	public readonly int id;

	public readonly int exp;

	public readonly int baseEXP;

	public readonly bool isUpdata;

	public ItemChipLvUpData(int id, int exp, int baseEXP, bool isUpdata)
	{
		this.id = id;
		this.exp = exp;
		this.baseEXP = baseEXP;
		this.isUpdata = isUpdata;
	}
}
