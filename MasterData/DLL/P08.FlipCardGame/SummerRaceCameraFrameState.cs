public readonly struct SummerRaceCameraFrameState
{
	public float CenterX { get; }

	public float CenterY { get; }

	public float OrthoSize { get; }

	public float VelocityX { get; }

	public float VelocityY { get; }

	public float OrthoVelocity { get; }

	public SummerRaceCameraFrameState(float centerX, float orthoSize, float velocityX, float orthoVelocity)
		: this(centerX, 0f, orthoSize, velocityX, 0f, orthoVelocity)
	{
	}

	public SummerRaceCameraFrameState(float centerX, float centerY, float orthoSize, float velocityX, float velocityY, float orthoVelocity)
	{
		CenterX = centerX;
		CenterY = centerY;
		OrthoSize = orthoSize;
		VelocityX = velocityX;
		VelocityY = velocityY;
		OrthoVelocity = orthoVelocity;
	}
}
