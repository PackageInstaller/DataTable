public readonly struct SummerRaceCameraFrameTarget
{
	public float CenterX { get; }

	public float CenterY { get; }

	public float OrthoSize { get; }

	public SummerRaceCameraFrameTarget(float centerX, float orthoSize)
		: this(centerX, 0f, orthoSize)
	{
	}

	public SummerRaceCameraFrameTarget(float centerX, float centerY, float orthoSize)
	{
		CenterX = centerX;
		CenterY = centerY;
		OrthoSize = orthoSize;
	}
}
