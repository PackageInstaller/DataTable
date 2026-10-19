using System;

namespace ACT.Config;

[Serializable]
public abstract class GuideStepFinishConditionConfig
{
	public abstract RuntimeStepCondition CreateRuntimeStepFinishCondition();
}
