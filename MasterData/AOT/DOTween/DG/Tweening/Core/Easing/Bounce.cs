namespace DG.Tweening.Core.Easing;

public static class Bounce
{
	public static float EaseIn(float time, float duration, float unusedOvershootOrAmplitude, float unusedPeriod)
	{
		return 1f - EaseOut(duration - time, duration, -1f, -1f);
	}

	public static float EaseOut(float time, float duration, float unusedOvershootOrAmplitude, float unusedPeriod)
	{
		if ((time /= duration) < 372f / 1023f)
		{
			return 7.5625f * time * time;
		}
		if (time < 744f / 1023f)
		{
			return 7.5625f * (time -= 558f / 1023f) * time + 0.75f;
		}
		if (time < 930f / 1023f)
		{
			return 7.5625f * (time -= 837f / 1023f) * time + 0.9375f;
		}
		return 7.5625f * (time -= 21f / 22f) * time + 63f / 64f;
	}

	public static float EaseInOut(float time, float duration, float unusedOvershootOrAmplitude, float unusedPeriod)
	{
		if (time < duration * 0.5f)
		{
			return EaseIn(time * 2f, duration, -1f, -1f) * 0.5f;
		}
		return EaseOut(time * 2f - duration, duration, -1f, -1f) * 0.5f + 0.5f;
	}
}
