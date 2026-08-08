public readonly struct SummerRaceCameraFrameSample(SummerRaceCameraFrameState state, SummerRaceCameraFrameTarget target)
{
	public SummerRaceCameraFrameState State { get; } = state;

	public SummerRaceCameraFrameTarget Target { get; } = target;
}
