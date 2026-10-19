using System;

namespace ACT.Config;

[Serializable]
public abstract class GuideStepCondition
{
	public abstract bool CheckCondition();
}
