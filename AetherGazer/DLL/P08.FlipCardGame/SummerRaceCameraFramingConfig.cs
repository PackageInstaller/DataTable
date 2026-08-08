public struct SummerRaceCameraFramingConfig
{
	public float ArenaCenterX;

	public float ArenaCenterY;

	public float MinBattleOrthoSize;

	public float OverviewOrthoSize;

	public float HorizontalSafeZoneRatio;

	public float VehiclePadding;

	public float VehicleCenterYOffset;

	public bool ClampCenterXToWorldBounds;

	public bool ClampBottomEdgeToWorldBounds;

	public bool ClampTopEdgeToWorldBounds;

	public float WorldMinX;

	public float WorldMaxX;

	public float WorldMinY;

	public float WorldMaxY;

	public float BottomSafePadding;

	public float TopSafePadding;

	public float CameraAspect;

	public float PushStepPerSecond;

	public float PullStepPerSecond;

	public static SummerRaceCameraFramingConfig Default => new SummerRaceCameraFramingConfig
	{
		ArenaCenterX = 0f,
		ArenaCenterY = 0f,
		MinBattleOrthoSize = 4.2f,
		OverviewOrthoSize = 6.5f,
		HorizontalSafeZoneRatio = 0.72f,
		VehiclePadding = 0.75f,
		VehicleCenterYOffset = 0f,
		ClampCenterXToWorldBounds = false,
		ClampBottomEdgeToWorldBounds = false,
		ClampTopEdgeToWorldBounds = false,
		WorldMinX = 0f,
		WorldMaxX = 0f,
		WorldMinY = 0f,
		WorldMaxY = 0f,
		BottomSafePadding = 0f,
		TopSafePadding = 0f,
		CameraAspect = 1.7777778f,
		PushStepPerSecond = 1.5f,
		PullStepPerSecond = 3.5f
	};
}
