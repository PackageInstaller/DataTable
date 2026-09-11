using System;

namespace Pinball.Runtime;

[Serializable]
public class RandomPolygon
{
	public PolygonType type;

	public float weight = 0.2f;

	public RandomPolygon(PolygonType type, float weight)
	{
		this.type = type;
		this.weight = weight;
	}

	public RandomPolygon(PolygonType type)
	{
		this.type = type;
	}
}
