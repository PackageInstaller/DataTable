using ACT.Model;

namespace ACT.Config.Condition;

public class CheckGuideIsFinsh : GuideStepCondition
{
	public int GuideId;

	public override bool CheckCondition()
	{
		return Model<GuideModel>.Interface.GuideHasTriggeredAndFinsh(GuideId);
	}
}
