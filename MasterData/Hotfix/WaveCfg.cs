using System;
using TrueSync;

[Serializable]
public class WaveCfg
{
	public PosType posType;

	public DeterministicShape.ShapeType shapeType;

	public FP width;

	public FP length;

	public FP radius;

	public FP innerRadius;

	public FP angle;

	public FanDirType fanDirType;
}
