using ACT.Model;

namespace ACT.Config.Action;

public class SetGuideDefaultSelectBloodBottle : GuideStepAction
{
	public int DefaultSelectBottleId;

	public override void Execute(GuideStepData data)
	{
		Model<BloodBottleModel>.Interface.SetGuideDefaultSelectBloodBottle(DefaultSelectBottleId);
	}
}
