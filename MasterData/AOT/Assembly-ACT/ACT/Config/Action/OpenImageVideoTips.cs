using ACT.Model;

namespace ACT.Config.Action;

public class OpenImageVideoTips : GuideStepAction
{
	public int tutorialId;

	public override void Execute(GuideStepData data)
	{
		Model<GuideModel>.Interface.OpenImageVideoTips(tutorialId);
	}
}
