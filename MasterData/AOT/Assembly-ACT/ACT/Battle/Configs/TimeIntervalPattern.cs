using System;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class TimeIntervalPattern
{
	public abstract float GetIntervalTime(ActionMemory memory, int index);
}
