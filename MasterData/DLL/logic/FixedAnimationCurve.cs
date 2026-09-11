using Config;

public struct FixedAnimationCurve(int id)
{
	public FixedCurve XCurve = default(FixedCurve);

	public FixedCurve YCurve = default(FixedCurve);

	public FixedCurve ZCurve = default(FixedCurve);

	public int TimelineID = id;

	public Int3 LastPosition = Int3.zero;

	public Int3 Evalue(int time)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(TimelineID);
		if (config == null)
		{
			return Int3.zero;
		}
		RuntimelineAnimationCurve animationKeyframe = config.AnimationKeyframe;
		Int3 result = default(Int3);
		result.x = XCurve.Evalue(time, animationKeyframe.XCurve);
		result.y = YCurve.Evalue(time, animationKeyframe.YCurve);
		result.z = ZCurve.Evalue(time, animationKeyframe.ZCurve);
		return result;
	}

	public Int3 EvalueDistanceWithLast(int time)
	{
		Int3 @int = Evalue(time);
		Int3 lastPosition = LastPosition;
		LastPosition = @int;
		return @int - lastPosition;
	}
}
