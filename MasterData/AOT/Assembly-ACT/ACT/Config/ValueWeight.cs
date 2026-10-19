using System;

namespace ACT.Config;

[Serializable]
public class ValueWeight
{
	public readonly float v;

	public readonly int weight;

	public ValueWeight(float v, int weight)
	{
		this.v = v;
		this.weight = weight;
	}
}
