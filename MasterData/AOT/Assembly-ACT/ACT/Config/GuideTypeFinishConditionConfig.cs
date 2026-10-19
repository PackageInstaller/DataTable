using ACT.Model;

namespace ACT.Config;

public class GuideTypeFinishConditionConfig : GuideStepFinishConditionConfig
{
	public GuideConsts.GuideType GuideType;

	public override RuntimeStepCondition CreateRuntimeStepFinishCondition()
	{
		return new RuntimeGuideTypeFinishCondition(this);
	}
}
