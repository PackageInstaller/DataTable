using ACT.Model;

namespace ACT.Config.Condition;

public class CheckGaChaPoolIsUnlock : GuideStepCondition
{
	public int GaChaPoolId;

	public override bool CheckCondition()
	{
		return Model<CardDrawModel>.Interface.CheckGachaPoolInTimeRange(GaChaPoolId);
	}
}
