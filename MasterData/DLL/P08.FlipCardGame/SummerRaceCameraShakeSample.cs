public readonly struct SummerRaceCameraShakeSample(SummerRaceCameraShakeState state, float verticalOffset)
{
	public SummerRaceCameraShakeState State { get; } = state;

	public float VerticalOffset { get; } = verticalOffset;
}
