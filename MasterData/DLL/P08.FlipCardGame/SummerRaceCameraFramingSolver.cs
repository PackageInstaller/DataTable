using UnityEngine;

public static class SummerRaceCameraFramingSolver
{
	private const float DefaultAspect = 1.7777778f;

	public static SummerRaceCameraFrameTarget ResolveTarget(SummerRaceCameraFramingConfig config, SummerRaceCameraFrameState state, float playerX, float enemyMinX, float enemyMaxX, bool hasEnemy, bool battleActive)
	{
		SummerRaceCameraFramingConfig config2 = SanitizeConfig(config);
		return ResolveTarget(config2, state, playerX, playerX, config2.ArenaCenterY, config2.ArenaCenterY, enemyMinX, enemyMaxX, config2.ArenaCenterY, config2.ArenaCenterY, hasEnemy, battleActive);
	}

	public static SummerRaceCameraFrameTarget ResolveTarget(SummerRaceCameraFramingConfig config, SummerRaceCameraFrameState state, float playerMinX, float playerMaxX, float enemyMinX, float enemyMaxX, bool hasEnemy, bool battleActive)
	{
		SummerRaceCameraFramingConfig config2 = SanitizeConfig(config);
		return ResolveTarget(config2, state, playerMinX, playerMaxX, config2.ArenaCenterY, config2.ArenaCenterY, enemyMinX, enemyMaxX, config2.ArenaCenterY, config2.ArenaCenterY, hasEnemy, battleActive);
	}

	public static SummerRaceCameraFrameTarget ResolveTarget(SummerRaceCameraFramingConfig config, SummerRaceCameraFrameState state, float playerMinX, float playerMaxX, float playerMinY, float playerMaxY, float enemyMinX, float enemyMaxX, float enemyMinY, float enemyMaxY, bool hasEnemy, bool battleActive)
	{
		SummerRaceCameraFramingConfig config2 = SanitizeConfig(config);
		if (!battleActive || !hasEnemy)
		{
			float centerX = ClampCenterXToWorldBounds(config2, config2.ArenaCenterX, config2.OverviewOrthoSize);
			float centerY = config2.ArenaCenterY;
			float orthoSize = config2.OverviewOrthoSize;
			ResolveVerticalSafeTarget(config2, ref centerY, ref orthoSize);
			return new SummerRaceCameraFrameTarget(centerX, centerY, orthoSize);
		}
		float num = Mathf.Min(playerMinX, playerMaxX, enemyMinX, enemyMaxX);
		float num2 = Mathf.Max(playerMinX, playerMaxX, enemyMinX, enemyMaxX);
		float centerX2 = (num + num2) * 0.5f;
		float num3 = Mathf.Max(0f, (num2 - num) * 0.5f + config2.VehiclePadding) / (config2.CameraAspect * config2.HorizontalSafeZoneRatio);
		float b = Mathf.Clamp(num3, config2.MinBattleOrthoSize, config2.OverviewOrthoSize);
		float num4 = Mathf.Clamp(state.OrthoSize, config2.MinBattleOrthoSize, config2.OverviewOrthoSize);
		float orthoSize2 = ((num3 >= num4 - 0.05f) ? Mathf.Max(num4, b) : Mathf.Min(num4, b));
		float num5 = Mathf.Min(playerMinY, playerMaxY, enemyMinY, enemyMaxY);
		float num6 = Mathf.Max(playerMinY, playerMaxY, enemyMinY, enemyMaxY);
		float centerY2 = (num5 + num6) * 0.5f + config2.VehicleCenterYOffset;
		ResolveVerticalSafeTarget(config2, ref centerY2, ref orthoSize2);
		centerX2 = ClampCenterXToWorldBounds(config2, centerX2, orthoSize2);
		return new SummerRaceCameraFrameTarget(centerX2, centerY2, orthoSize2);
	}

	public static SummerRaceCameraFrameSample IntegrateFrame(SummerRaceCameraFramingConfig config, SummerRaceCameraFrameState state, SummerRaceCameraFrameTarget target, float deltaTime, float smoothTime)
	{
		SummerRaceCameraFramingConfig summerRaceCameraFramingConfig = SanitizeConfig(config);
		float deltaTime2 = Mathf.Max(0f, deltaTime);
		if (Mathf.Abs(target.CenterX - summerRaceCameraFramingConfig.ArenaCenterX) <= 0.0001f && Mathf.Abs(target.CenterY - summerRaceCameraFramingConfig.ArenaCenterY) <= 0.0001f && Mathf.Abs(target.OrthoSize - summerRaceCameraFramingConfig.OverviewOrthoSize) <= 0.0001f)
		{
			return new SummerRaceCameraFrameSample(new SummerRaceCameraFrameState(summerRaceCameraFramingConfig.ArenaCenterX, summerRaceCameraFramingConfig.ArenaCenterY, summerRaceCameraFramingConfig.OverviewOrthoSize, 0f, 0f, 0f), target);
		}
		float smoothTime2 = Mathf.Max(0.01f, smoothTime);
		float currentVelocity = state.VelocityX;
		float currentVelocity2 = state.VelocityY;
		float currentVelocity3 = state.OrthoVelocity;
		float centerX = Mathf.SmoothDamp(state.CenterX, target.CenterX, ref currentVelocity, smoothTime2, float.PositiveInfinity, deltaTime2);
		float centerY = Mathf.SmoothDamp(state.CenterY, target.CenterY, ref currentVelocity2, smoothTime2, float.PositiveInfinity, deltaTime2);
		float orthoSize = Mathf.Clamp(Mathf.SmoothDamp(maxSpeed: (target.OrthoSize > state.OrthoSize) ? summerRaceCameraFramingConfig.PullStepPerSecond : summerRaceCameraFramingConfig.PushStepPerSecond, current: state.OrthoSize, target: target.OrthoSize, currentVelocity: ref currentVelocity3, smoothTime: smoothTime2, deltaTime: deltaTime2), summerRaceCameraFramingConfig.MinBattleOrthoSize, summerRaceCameraFramingConfig.OverviewOrthoSize);
		return new SummerRaceCameraFrameSample(new SummerRaceCameraFrameState(centerX, centerY, orthoSize, currentVelocity, currentVelocity2, currentVelocity3), target);
	}

	public static SummerRaceCameraShakeState StartShake(SummerRaceCameraShakeState current, float amplitude, float duration)
	{
		float amplitude2 = Mathf.Max(current.Amplitude, Mathf.Max(0f, amplitude));
		float duration2 = Mathf.Max(current.Duration - current.Timer, Mathf.Max(0f, duration));
		return new SummerRaceCameraShakeState(0f, duration2, amplitude2);
	}

	public static SummerRaceCameraShakeSample IntegrateShake(SummerRaceCameraShakeState state, float deltaTime)
	{
		if (!state.IsActive)
		{
			return new SummerRaceCameraShakeSample(SummerRaceCameraShakeState.None, 0f);
		}
		float num = Mathf.Min(state.Duration, state.Timer + Mathf.Max(0f, deltaTime));
		if (num >= state.Duration)
		{
			return new SummerRaceCameraShakeSample(SummerRaceCameraShakeState.None, 0f);
		}
		float num2 = Mathf.Clamp01(num / state.Duration);
		float num3 = 1f - num2;
		float verticalOffset = Mathf.Sin(num * 72f) * state.Amplitude * num3;
		return new SummerRaceCameraShakeSample(new SummerRaceCameraShakeState(num, state.Duration, state.Amplitude), verticalOffset);
	}

	private static float ClampCenterXToWorldBounds(SummerRaceCameraFramingConfig config, float centerX, float orthoSize)
	{
		if (!config.ClampCenterXToWorldBounds || config.WorldMaxX <= config.WorldMinX)
		{
			return centerX;
		}
		float num = Mathf.Max(0f, orthoSize) * config.CameraAspect;
		float num2 = config.WorldMinX + num;
		float num3 = config.WorldMaxX - num;
		if (num2 > num3)
		{
			return (config.WorldMinX + config.WorldMaxX) * 0.5f;
		}
		return Mathf.Clamp(centerX, num2, num3);
	}

	private static void ResolveVerticalSafeTarget(SummerRaceCameraFramingConfig config, ref float centerY, ref float orthoSize)
	{
		bool clampBottomEdgeToWorldBounds = config.ClampBottomEdgeToWorldBounds;
		bool clampTopEdgeToWorldBounds = config.ClampTopEdgeToWorldBounds;
		if (!clampBottomEdgeToWorldBounds && !clampTopEdgeToWorldBounds)
		{
			return;
		}
		float num = config.WorldMinY + config.BottomSafePadding;
		float num2 = config.WorldMaxY - config.TopSafePadding;
		if ((clampBottomEdgeToWorldBounds & clampTopEdgeToWorldBounds) && num2 > num)
		{
			float b = Mathf.Clamp((num2 - num) * 0.5f, config.MinBattleOrthoSize, config.OverviewOrthoSize);
			orthoSize = Mathf.Min(orthoSize, b);
			float num3 = num + orthoSize;
			float num4 = num2 - orthoSize;
			centerY = ((num3 <= num4) ? Mathf.Clamp(centerY, num3, num4) : ((num + num2) * 0.5f));
			return;
		}
		if (clampBottomEdgeToWorldBounds)
		{
			float num5 = centerY - num;
			if (num5 > 0f)
			{
				orthoSize = Mathf.Min(orthoSize, Mathf.Clamp(num5, config.MinBattleOrthoSize, config.OverviewOrthoSize));
			}
			centerY = Mathf.Max(centerY, num + orthoSize);
		}
		if (clampTopEdgeToWorldBounds)
		{
			float num6 = num2 - centerY;
			if (num6 > 0f)
			{
				orthoSize = Mathf.Min(orthoSize, Mathf.Clamp(num6, config.MinBattleOrthoSize, config.OverviewOrthoSize));
			}
			centerY = Mathf.Min(centerY, num2 - orthoSize);
		}
	}

	private static SummerRaceCameraFramingConfig SanitizeConfig(SummerRaceCameraFramingConfig config)
	{
		float num = Mathf.Max(0.1f, config.MinBattleOrthoSize);
		float overviewOrthoSize = Mathf.Max(num, config.OverviewOrthoSize);
		config.MinBattleOrthoSize = num;
		config.OverviewOrthoSize = overviewOrthoSize;
		config.HorizontalSafeZoneRatio = Mathf.Clamp(config.HorizontalSafeZoneRatio, 0.1f, 1f);
		config.VehiclePadding = Mathf.Max(0f, config.VehiclePadding);
		config.BottomSafePadding = Mathf.Max(0f, config.BottomSafePadding);
		config.TopSafePadding = Mathf.Max(0f, config.TopSafePadding);
		config.CameraAspect = ((config.CameraAspect > 0.01f) ? config.CameraAspect : 1.7777778f);
		config.PushStepPerSecond = Mathf.Max(0.01f, config.PushStepPerSecond);
		config.PullStepPerSecond = Mathf.Max(0.01f, config.PullStepPerSecond);
		return config;
	}
}
