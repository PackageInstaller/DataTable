using System;
using ACT.Model;

namespace ACT.Config;

[Serializable]
public abstract class GuideStepAction
{
	public abstract void Execute(GuideStepData data);
}
