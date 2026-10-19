using System;

namespace ACT.Config;

[Serializable]
public class Range
{
	public readonly float min;

	public readonly float max;

	public Range(float min, float max)
	{
		this.min = min;
		this.max = max;
	}
}
