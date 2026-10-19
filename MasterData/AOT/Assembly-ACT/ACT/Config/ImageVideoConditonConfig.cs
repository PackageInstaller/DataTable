namespace ACT.Config;

public class ImageVideoConditonConfig : GuideStepFinishConditionConfig
{
	public int tutorialId;

	public override RuntimeStepCondition CreateRuntimeStepFinishCondition()
	{
		return new RuntimeImageVideoConditon(this);
	}
}
