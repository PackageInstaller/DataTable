using System;
using ACT.Model;

namespace ACT.Config.Condition;

[Serializable]
public class CheckTargetBottleLevelGreaterThanOne : GuideFinshCondition
{
	public int BottleId;

	public override bool CheckCondition()
	{
		if (!Model<BloodBottleModel>.HasInstance())
		{
			return false;
		}
		BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(BottleId);
		if (bloodBottleById != null)
		{
			return bloodBottleById.curLevel > 1;
		}
		return false;
	}
}
