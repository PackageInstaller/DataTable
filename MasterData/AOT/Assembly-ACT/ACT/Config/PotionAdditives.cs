using System;

namespace ACT.Config;

[Serializable]
public class PotionAdditives
{
	public readonly int id;

	public readonly int itemId;

	public readonly int useAbilityName;

	public readonly int type;

	public readonly int wearAbilityName;

	public readonly int skillDesc;

	public readonly int usageLimit;

	public readonly int freeMealChance;

	public PotionAdditives(int id, int itemId, int useAbilityName, int type, int wearAbilityName, int skillDesc, int usageLimit, int freeMealChance)
	{
		this.id = id;
		this.itemId = itemId;
		this.useAbilityName = useAbilityName;
		this.type = type;
		this.wearAbilityName = wearAbilityName;
		this.skillDesc = skillDesc;
		this.usageLimit = usageLimit;
		this.freeMealChance = freeMealChance;
	}
}
