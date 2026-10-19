using ACT.Drama;

namespace ACT.Config;

public class InteractStateConditionConfig : GuideStepFinishConditionConfig
{
	public InteractState interactStates;

	public override RuntimeStepCondition CreateRuntimeStepFinishCondition()
	{
		return new RuntimeInteractStateCondition(this);
	}
}
