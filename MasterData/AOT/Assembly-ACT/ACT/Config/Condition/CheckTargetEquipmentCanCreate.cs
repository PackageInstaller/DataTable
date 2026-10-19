using ACT.Core;
using ACT.Game;
using ACT.Model;

namespace ACT.Config.Condition;

public class CheckTargetEquipmentCanCreate : GuideStepCondition
{
	public int equipId;

	public override bool CheckCondition()
	{
		if (!Model<EquipModel>.HasInstance())
		{
			return false;
		}
		if (!RuntimeConfigs.data.equipDatas.TryGetValue(equipId, out var value) || !RuntimeConfigs.data.equipCreatMaterialDatas.TryGetValue(value.CreatmaterialListID, out var value2))
		{
			return false;
		}
		if (G.localPlayer.Inventory.GetItemCount(2) < value2.coinEach)
		{
			return false;
		}
		foreach (ItemKv item in value2.equipMaterialItem)
		{
			if (G.localPlayer.Inventory.GetItemCount(item.id) < item.count)
			{
				return false;
			}
		}
		return true;
	}
}
