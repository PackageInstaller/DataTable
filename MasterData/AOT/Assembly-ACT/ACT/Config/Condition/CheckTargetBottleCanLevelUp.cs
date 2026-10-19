using ACT.Core;
using ACT.Game;
using ACT.Model;
using UnityEngine;

namespace ACT.Config.Condition;

public class CheckTargetBottleCanLevelUp : GuideStepCondition
{
	public int bottleId;

	public override bool CheckCondition()
	{
		if (!Model<BloodBottleModel>.HasInstance())
		{
			return false;
		}
		BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(bottleId);
		if (bloodBottleById == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("检查血瓶能不能升级 引导条件填的 血瓶 在这个世界类型里不存在");
			}
			return false;
		}
		if (bloodBottleById.curLevel >= bloodBottleById.maxLevel)
		{
			return false;
		}
		int num = Mathf.Min(bloodBottleById.curLevel + 1, bloodBottleById.maxLevel);
		int[][] levelUpItem = CoreUtils.GetData(bottleId, RuntimeConfigs.data.potionDatas).levelUpItem;
		int[][] levelUpCost = CoreUtils.GetData(bottleId, RuntimeConfigs.data.potionDatas).levelUpCost;
		if (levelUpItem.Length == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("检查血瓶能不能升级,rogue的血瓶不能升级，你填成rogue血瓶Id了，检查一下");
			}
			return false;
		}
		if (levelUpItem.Length < num - 1)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"检查血瓶能不能升级.血瓶:{bottleId},没有这个等级对应的升级道具,先核对血瓶表，确定表没问题找程序");
			}
			return false;
		}
		for (int i = 0; i < levelUpItem[num - 2].Length; i++)
		{
			int itemId = levelUpItem[num - 2][i];
			int itemNeedCount = levelUpCost[num - 2][i];
			if (!CheckLevelUpNeedItemsIsEnough(itemId, itemNeedCount))
			{
				return false;
			}
		}
		return true;
	}

	private bool CheckLevelUpNeedItemsIsEnough(int itemId, int itemNeedCount)
	{
		return itemNeedCount <= G.localPlayer.Inventory.GetItemCount(itemId);
	}
}
