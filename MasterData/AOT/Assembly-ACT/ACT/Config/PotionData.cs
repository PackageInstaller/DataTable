using System;

namespace ACT.Config;

[Serializable]
public class PotionData
{
	public readonly int id;

	public readonly int itemId;

	public readonly int[] availableSceneTypes = new int[0];

	public readonly int levelLimit;

	public readonly int[][] levelUpItem = new int[0][];

	public readonly int[][] levelUpCost = new int[0][];

	public readonly int healSkillId;

	public readonly int wearSkillId;

	public readonly int useExtraSkillId;

	public readonly int[] usageLimit = new int[0];

	public readonly int[] capacityLimit = new int[0];

	public readonly int[][] capacitytype = new int[0][];

	public readonly int unlockTaxt;

	public PotionData(int id, int itemId, int[] availableSceneTypes, int levelLimit, int[][] levelUpItem, int[][] levelUpCost, int healSkillId, int wearSkillId, int useExtraSkillId, int[] usageLimit, int[] capacityLimit, int[][] capacitytype, int unlockTaxt)
	{
		this.id = id;
		this.itemId = itemId;
		this.availableSceneTypes = availableSceneTypes;
		this.levelLimit = levelLimit;
		this.levelUpItem = levelUpItem;
		this.levelUpCost = levelUpCost;
		this.healSkillId = healSkillId;
		this.wearSkillId = wearSkillId;
		this.useExtraSkillId = useExtraSkillId;
		this.usageLimit = usageLimit;
		this.capacityLimit = capacityLimit;
		this.capacitytype = capacitytype;
		this.unlockTaxt = unlockTaxt;
	}
}
