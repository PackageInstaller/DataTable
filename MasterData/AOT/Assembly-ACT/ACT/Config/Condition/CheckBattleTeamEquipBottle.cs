using ACT.Model;

namespace ACT.Config.Condition;

public class CheckBattleTeamEquipBottle : GuideStepCondition
{
	public override bool CheckCondition()
	{
		if (Model<BloodBottleModel>.HasInstance() && Model<BloodBottleModel>.Interface.CurTeamEquipBottle != null)
		{
			return true;
		}
		return false;
	}
}
