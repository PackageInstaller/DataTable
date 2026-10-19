using System;

namespace ACT.Battle.Configs;

[Serializable]
public class AverageInterval : TimeIntervalPattern
{
	public float interval;

	public ConfigFunction<float> functionFloat;

	public override float GetIntervalTime(ActionMemory memory, int index)
	{
		return functionFloat?.Return(memory) ?? interval;
	}
}
