using System;

namespace DG.Tweening.Core.Easing;

public static class EaseManager
{
	private const float _PiOver2 = (float)Math.PI / 2f;

	private const float _TwoPi = (float)Math.PI * 2f;

	public static float Evaluate(Tween t, float time, float duration, float overshootOrAmplitude, float period)
	{
		return Evaluate(t.easeType, t.customEase, time, duration, overshootOrAmplitude, period);
	}

	public static float Evaluate(Ease easeType, EaseFunction customEase, float time, float duration, float overshootOrAmplitude, float period)
	{
		switch (easeType)
		{
		case Ease.Linear:
			return time / duration;
		case Ease.InSine:
			return 0f - (float)Math.Cos(time / duration * ((float)Math.PI / 2f)) + 1f;
		case Ease.OutSine:
			return (float)Math.Sin(time / duration * ((float)Math.PI / 2f));
		case Ease.InOutSine:
			return -0.5f * ((float)Math.Cos((float)Math.PI * time / duration) - 1f);
		case Ease.InQuad:
			return (time /= duration) * time;
		case Ease.OutQuad:
			return (0f - (time /= duration)) * (time - 2f);
		case Ease.InOutQuad:
			if ((time /= duration * 0.5f) < 1f)
			{
				return 0.5f * time * time;
			}
			return -0.5f * (--time * (time - 2f) - 1f);
		case Ease.InCubic:
			return (time /= duration) * time * time;
		case Ease.OutCubic:
			return (time = time / duration - 1f) * time * time + 1f;
		case Ease.InOutCubic:
			if ((time /= duration * 0.5f) < 1f)
			{
				return 0.5f * time * time * time;
			}
			return 0.5f * ((time -= 2f) * time * time + 2f);
		case Ease.InQuart:
			return (time /= duration) * time * time * time;
		case Ease.OutQuart:
			return 0f - ((time = time / duration - 1f) * time * time * time - 1f);
		case Ease.InOutQuart:
			if ((time /= duration * 0.5f) < 1f)
			{
				return 0.5f * time * time * time * time;
			}
			return -0.5f * ((time -= 2f) * time * time * time - 2f);
		case Ease.InQuint:
			return (time /= duration) * time * time * time * time;
		case Ease.OutQuint:
			return (time = time / duration - 1f) * time * time * time * time + 1f;
		case Ease.InOutQuint:
			if ((time /= duration * 0.5f) < 1f)
			{
				return 0.5f * time * time * time * time * time;
			}
			return 0.5f * ((time -= 2f) * time * time * time * time + 2f);
		case Ease.InExpo:
			if (time != 0f)
			{
				return (float)Math.Pow(2.0, 10f * (time / duration - 1f));
			}
			return 0f;
		case Ease.OutExpo:
			if (time == duration)
			{
				return 1f;
			}
			return 0f - (float)Math.Pow(2.0, -10f * time / duration) + 1f;
		case Ease.InOutExpo:
			if (time == 0f)
			{
				return 0f;
			}
			if (time == duration)
			{
				return 1f;
			}
			if ((time /= duration * 0.5f) < 1f)
			{
				return 0.5f * (float)Math.Pow(2.0, 10f * (time - 1f));
			}
			return 0.5f * (0f - (float)Math.Pow(2.0, -10f * --time) + 2f);
		case Ease.InCirc:
			return 0f - ((float)Math.Sqrt(1f - (time /= duration) * time) - 1f);
		case Ease.OutCirc:
			return (float)Math.Sqrt(1f - (time = time / duration - 1f) * time);
		case Ease.InOutCirc:
			if ((time /= duration * 0.5f) < 1f)
			{
				return -0.5f * ((float)Math.Sqrt(1f - time * time) - 1f);
			}
			return 0.5f * ((float)Math.Sqrt(1f - (time -= 2f) * time) + 1f);
		case Ease.InElastic:
		{
			if (time == 0f)
			{
				return 0f;
			}
			if ((time /= duration) == 1f)
			{
				return 1f;
			}
			if (period == 0f)
			{
				period = duration * 0.3f;
			}
			float num3;
			if (overshootOrAmplitude < 1f)
			{
				overshootOrAmplitude = 1f;
				num3 = period / 4f;
			}
			else
			{
				num3 = period / ((float)Math.PI * 2f) * (float)Math.Asin(1f / overshootOrAmplitude);
			}
			return 0f - overshootOrAmplitude * (float)Math.Pow(2.0, 10f * --time) * (float)Math.Sin((time * duration - num3) * ((float)Math.PI * 2f) / period);
		}
		case Ease.OutElastic:
		{
			if (time == 0f)
			{
				return 0f;
			}
			if ((time /= duration) == 1f)
			{
				return 1f;
			}
			if (period == 0f)
			{
				period = duration * 0.3f;
			}
			float num2;
			if (overshootOrAmplitude < 1f)
			{
				overshootOrAmplitude = 1f;
				num2 = period / 4f;
			}
			else
			{
				num2 = period / ((float)Math.PI * 2f) * (float)Math.Asin(1f / overshootOrAmplitude);
			}
			return overshootOrAmplitude * (float)Math.Pow(2.0, -10f * time) * (float)Math.Sin((time * duration - num2) * ((float)Math.PI * 2f) / period) + 1f;
		}
		case Ease.InOutElastic:
		{
			if (time == 0f)
			{
				return 0f;
			}
			if ((time /= duration * 0.5f) == 2f)
			{
				return 1f;
			}
			if (period == 0f)
			{
				period = duration * 0.45000002f;
			}
			float num;
			if (overshootOrAmplitude < 1f)
			{
				overshootOrAmplitude = 1f;
				num = period / 4f;
			}
			else
			{
				num = period / ((float)Math.PI * 2f) * (float)Math.Asin(1f / overshootOrAmplitude);
			}
			if (time < 1f)
			{
				return -0.5f * (overshootOrAmplitude * (float)Math.Pow(2.0, 10f * --time) * (float)Math.Sin((time * duration - num) * ((float)Math.PI * 2f) / period));
			}
			return overshootOrAmplitude * (float)Math.Pow(2.0, -10f * --time) * (float)Math.Sin((time * duration - num) * ((float)Math.PI * 2f) / period) * 0.5f + 1f;
		}
		case Ease.InBack:
			return (time /= duration) * time * ((overshootOrAmplitude + 1f) * time - overshootOrAmplitude);
		case Ease.OutBack:
			return (time = time / duration - 1f) * time * ((overshootOrAmplitude + 1f) * time + overshootOrAmplitude) + 1f;
		case Ease.InOutBack:
			if ((time /= duration * 0.5f) < 1f)
			{
				return 0.5f * (time * time * (((overshootOrAmplitude *= 1.525f) + 1f) * time - overshootOrAmplitude));
			}
			return 0.5f * ((time -= 2f) * time * (((overshootOrAmplitude *= 1.525f) + 1f) * time + overshootOrAmplitude) + 2f);
		case Ease.InBounce:
			return Bounce.EaseIn(time, duration, overshootOrAmplitude, period);
		case Ease.OutBounce:
			return Bounce.EaseOut(time, duration, overshootOrAmplitude, period);
		case Ease.InOutBounce:
			return Bounce.EaseInOut(time, duration, overshootOrAmplitude, period);
		case Ease.INTERNAL_Custom:
			return customEase(time, duration, overshootOrAmplitude, period);
		case Ease.INTERNAL_Zero:
			return 1f;
		case Ease.Flash:
			return Flash.Ease(time, duration, overshootOrAmplitude, period);
		case Ease.InFlash:
			return Flash.EaseIn(time, duration, overshootOrAmplitude, period);
		case Ease.OutFlash:
			return Flash.EaseOut(time, duration, overshootOrAmplitude, period);
		case Ease.InOutFlash:
			return Flash.EaseInOut(time, duration, overshootOrAmplitude, period);
		default:
			return (0f - (time /= duration)) * (time - 2f);
		}
	}

	public static EaseFunction ToEaseFunction(Ease ease)
	{
		return ease switch
		{
			Ease.Linear => (float time, float duration, float overshootOrAmplitude, float period) => time / duration, 
			Ease.InSine => (float time, float duration, float overshootOrAmplitude, float period) => 0f - (float)Math.Cos(time / duration * ((float)Math.PI / 2f)) + 1f, 
			Ease.OutSine => (float time, float duration, float overshootOrAmplitude, float period) => (float)Math.Sin(time / duration * ((float)Math.PI / 2f)), 
			Ease.InOutSine => (float time, float duration, float overshootOrAmplitude, float period) => -0.5f * ((float)Math.Cos((float)Math.PI * time / duration) - 1f), 
			Ease.InQuad => (float time, float duration, float overshootOrAmplitude, float period) => (time /= duration) * time, 
			Ease.OutQuad => (float time, float duration, float overshootOrAmplitude, float period) => (0f - (time /= duration)) * (time - 2f), 
			Ease.InOutQuad => (float time, float duration, float overshootOrAmplitude, float period) => ((time /= duration * 0.5f) < 1f) ? (0.5f * time * time) : (-0.5f * (--time * (time - 2f) - 1f)), 
			Ease.InCubic => (float time, float duration, float overshootOrAmplitude, float period) => (time /= duration) * time * time, 
			Ease.OutCubic => (float time, float duration, float overshootOrAmplitude, float period) => (time = time / duration - 1f) * time * time + 1f, 
			Ease.InOutCubic => (float time, float duration, float overshootOrAmplitude, float period) => ((time /= duration * 0.5f) < 1f) ? (0.5f * time * time * time) : (0.5f * ((time -= 2f) * time * time + 2f)), 
			Ease.InQuart => (float time, float duration, float overshootOrAmplitude, float period) => (time /= duration) * time * time * time, 
			Ease.OutQuart => (float time, float duration, float overshootOrAmplitude, float period) => 0f - ((time = time / duration - 1f) * time * time * time - 1f), 
			Ease.InOutQuart => (float time, float duration, float overshootOrAmplitude, float period) => ((time /= duration * 0.5f) < 1f) ? (0.5f * time * time * time * time) : (-0.5f * ((time -= 2f) * time * time * time - 2f)), 
			Ease.InQuint => (float time, float duration, float overshootOrAmplitude, float period) => (time /= duration) * time * time * time * time, 
			Ease.OutQuint => (float time, float duration, float overshootOrAmplitude, float period) => (time = time / duration - 1f) * time * time * time * time + 1f, 
			Ease.InOutQuint => (float time, float duration, float overshootOrAmplitude, float period) => ((time /= duration * 0.5f) < 1f) ? (0.5f * time * time * time * time * time) : (0.5f * ((time -= 2f) * time * time * time * time + 2f)), 
			Ease.InExpo => (float time, float duration, float overshootOrAmplitude, float period) => (time != 0f) ? ((float)Math.Pow(2.0, 10f * (time / duration - 1f))) : 0f, 
			Ease.OutExpo => (float time, float duration, float overshootOrAmplitude, float period) => (time == duration) ? 1f : (0f - (float)Math.Pow(2.0, -10f * time / duration) + 1f), 
			Ease.InOutExpo => delegate(float time, float duration, float overshootOrAmplitude, float period)
			{
				if (time == 0f)
				{
					return 0f;
				}
				if (time == duration)
				{
					return 1f;
				}
				return ((time /= duration * 0.5f) < 1f) ? (0.5f * (float)Math.Pow(2.0, 10f * (time - 1f))) : (0.5f * (0f - (float)Math.Pow(2.0, -10f * --time) + 2f));
			}, 
			Ease.InCirc => (float time, float duration, float overshootOrAmplitude, float period) => 0f - ((float)Math.Sqrt(1f - (time /= duration) * time) - 1f), 
			Ease.OutCirc => (float time, float duration, float overshootOrAmplitude, float period) => (float)Math.Sqrt(1f - (time = time / duration - 1f) * time), 
			Ease.InOutCirc => (float time, float duration, float overshootOrAmplitude, float period) => ((time /= duration * 0.5f) < 1f) ? (-0.5f * ((float)Math.Sqrt(1f - time * time) - 1f)) : (0.5f * ((float)Math.Sqrt(1f - (time -= 2f) * time) + 1f)), 
			Ease.InElastic => delegate(float time, float duration, float overshootOrAmplitude, float period)
			{
				if (time == 0f)
				{
					return 0f;
				}
				if ((time /= duration) == 1f)
				{
					return 1f;
				}
				if (period == 0f)
				{
					period = duration * 0.3f;
				}
				float num;
				if (overshootOrAmplitude < 1f)
				{
					overshootOrAmplitude = 1f;
					num = period / 4f;
				}
				else
				{
					num = period / ((float)Math.PI * 2f) * (float)Math.Asin(1f / overshootOrAmplitude);
				}
				return 0f - overshootOrAmplitude * (float)Math.Pow(2.0, 10f * --time) * (float)Math.Sin((time * duration - num) * ((float)Math.PI * 2f) / period);
			}, 
			Ease.OutElastic => delegate(float time, float duration, float overshootOrAmplitude, float period)
			{
				if (time == 0f)
				{
					return 0f;
				}
				if ((time /= duration) == 1f)
				{
					return 1f;
				}
				if (period == 0f)
				{
					period = duration * 0.3f;
				}
				float num;
				if (overshootOrAmplitude < 1f)
				{
					overshootOrAmplitude = 1f;
					num = period / 4f;
				}
				else
				{
					num = period / ((float)Math.PI * 2f) * (float)Math.Asin(1f / overshootOrAmplitude);
				}
				return overshootOrAmplitude * (float)Math.Pow(2.0, -10f * time) * (float)Math.Sin((time * duration - num) * ((float)Math.PI * 2f) / period) + 1f;
			}, 
			Ease.InOutElastic => delegate(float time, float duration, float overshootOrAmplitude, float period)
			{
				if (time == 0f)
				{
					return 0f;
				}
				if ((time /= duration * 0.5f) == 2f)
				{
					return 1f;
				}
				if (period == 0f)
				{
					period = duration * 0.45000002f;
				}
				float num;
				if (overshootOrAmplitude < 1f)
				{
					overshootOrAmplitude = 1f;
					num = period / 4f;
				}
				else
				{
					num = period / ((float)Math.PI * 2f) * (float)Math.Asin(1f / overshootOrAmplitude);
				}
				return (time < 1f) ? (-0.5f * (overshootOrAmplitude * (float)Math.Pow(2.0, 10f * --time) * (float)Math.Sin((time * duration - num) * ((float)Math.PI * 2f) / period))) : (overshootOrAmplitude * (float)Math.Pow(2.0, -10f * --time) * (float)Math.Sin((time * duration - num) * ((float)Math.PI * 2f) / period) * 0.5f + 1f);
			}, 
			Ease.InBack => (float time, float duration, float overshootOrAmplitude, float period) => (time /= duration) * time * ((overshootOrAmplitude + 1f) * time - overshootOrAmplitude), 
			Ease.OutBack => (float time, float duration, float overshootOrAmplitude, float period) => (time = time / duration - 1f) * time * ((overshootOrAmplitude + 1f) * time + overshootOrAmplitude) + 1f, 
			Ease.InOutBack => (float time, float duration, float overshootOrAmplitude, float period) => ((time /= duration * 0.5f) < 1f) ? (0.5f * (time * time * (((overshootOrAmplitude *= 1.525f) + 1f) * time - overshootOrAmplitude))) : (0.5f * ((time -= 2f) * time * (((overshootOrAmplitude *= 1.525f) + 1f) * time + overshootOrAmplitude) + 2f)), 
			Ease.InBounce => (float time, float duration, float overshootOrAmplitude, float period) => Bounce.EaseIn(time, duration, overshootOrAmplitude, period), 
			Ease.OutBounce => (float time, float duration, float overshootOrAmplitude, float period) => Bounce.EaseOut(time, duration, overshootOrAmplitude, period), 
			Ease.InOutBounce => (float time, float duration, float overshootOrAmplitude, float period) => Bounce.EaseInOut(time, duration, overshootOrAmplitude, period), 
			Ease.Flash => (float time, float duration, float overshootOrAmplitude, float period) => Flash.Ease(time, duration, overshootOrAmplitude, period), 
			Ease.InFlash => (float time, float duration, float overshootOrAmplitude, float period) => Flash.EaseIn(time, duration, overshootOrAmplitude, period), 
			Ease.OutFlash => (float time, float duration, float overshootOrAmplitude, float period) => Flash.EaseOut(time, duration, overshootOrAmplitude, period), 
			Ease.InOutFlash => (float time, float duration, float overshootOrAmplitude, float period) => Flash.EaseInOut(time, duration, overshootOrAmplitude, period), 
			_ => (float time, float duration, float overshootOrAmplitude, float period) => (0f - (time /= duration)) * (time - 2f), 
		};
	}

	internal static bool IsFlashEase(Ease ease)
	{
		if ((uint)(ease - 32) <= 3u)
		{
			return true;
		}
		return false;
	}
}
