using System.Linq;
using ACT.Model;

namespace ACT.Config.Condition;

public class CheckHasTargetBottle : GuideStepCondition
{
	public int BottleId;

	public override bool CheckCondition()
	{
		if (Model<BloodBottleModel>.HasInstance() && Model<BloodBottleModel>.Interface.alreadyHaveBottles.Any((BloodBottleData b) => b.uid == BottleId))
		{
			return true;
		}
		return false;
	}
}
