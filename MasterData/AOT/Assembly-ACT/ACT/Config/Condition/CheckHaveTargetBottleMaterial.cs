using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.Model;

namespace ACT.Config.Condition;

public class CheckHaveTargetBottleMaterial : GuideStepCondition
{
	public int TargetBottleId;

	public override bool CheckCondition()
	{
		if (Model<BloodBottleModel>.HasInstance() && Model<BloodBottleModel>.Interface.alreadyHaveBottles.Any((BloodBottleData b) => b.uid == TargetBottleId))
		{
			int[] array = CoreUtils.GetData(TargetBottleId, RuntimeConfigs.data.potionDatas).capacitytype[0];
			foreach (int type in array)
			{
				if (Model<BloodBottleModel>.Interface.bottleMaterials.Any((KeyValuePair<int, BloodBottleMaterial> m) => m.Value.type == type))
				{
					return true;
				}
			}
		}
		return false;
	}
}
