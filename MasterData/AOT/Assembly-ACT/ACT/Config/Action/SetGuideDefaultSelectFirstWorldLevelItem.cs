using ACT.Model;

namespace ACT.Config.Action;

public class SetGuideDefaultSelectFirstWorldLevelItem : GuideStepAction, IActionUninit
{
	public override void Execute(GuideStepData data)
	{
		Model<WorldLevelModel>.Interface.SetGuideDefaultSelectFirstWorldLevelItem();
	}

	public void UnInit()
	{
		Model<WorldLevelModel>.Interface.ResetGuideDefaultSelectFirstWorldLevelItem();
	}
}
