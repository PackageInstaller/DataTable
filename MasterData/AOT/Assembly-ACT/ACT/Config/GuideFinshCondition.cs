using System;

namespace ACT.Config;

[Serializable]
public abstract class GuideFinshCondition
{
	public abstract bool CheckCondition();
}
