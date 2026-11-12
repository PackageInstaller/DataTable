using System;
using TrueSync;

[Serializable]
public struct DeterministicShape
{
	public enum ShapeType
	{
		Rectangle,
		Circle,
		Fan
	}

	public ShapeType shapeType;

	public FP width;

	public FP length;

	public FP radius;

	public FP innerRadius;

	public FP angle;

	public TSVector2 position;

	public FP rotation;
}
