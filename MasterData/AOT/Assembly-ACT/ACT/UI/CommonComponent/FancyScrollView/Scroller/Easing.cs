using System;
using UnityEngine;

namespace ACT.UI.CommonComponent.FancyScrollView.Scroller;

public static class Easing
{
	public static EasingFunction Get(Ease type)
	{
		return type switch
		{
			Ease.Linear => (EasingFunction)linear, 
			Ease.InBack => inBack, 
			Ease.InBounce => inBounce, 
			Ease.InCirc => inCirc, 
			Ease.InCubic => inCubic, 
			Ease.InElastic => inElastic, 
			Ease.InExpo => inExpo, 
			Ease.InQuad => inQuad, 
			Ease.InQuart => inQuart, 
			Ease.InQuint => inQuint, 
			Ease.InSine => inSine, 
			Ease.OutBack => outBack, 
			Ease.OutBounce => outBounce, 
			Ease.OutCirc => outCirc, 
			Ease.OutCubic => outCubic, 
			Ease.OutElastic => outElastic, 
			Ease.OutExpo => outExpo, 
			Ease.OutQuad => outQuad, 
			Ease.OutQuart => outQuart, 
			Ease.OutQuint => outQuint, 
			Ease.OutSine => outSine, 
			Ease.InOutBack => inOutBack, 
			Ease.InOutBounce => inOutBounce, 
			Ease.InOutCirc => inOutCirc, 
			Ease.InOutCubic => inOutCubic, 
			Ease.InOutElastic => inOutElastic, 
			Ease.InOutExpo => inOutExpo, 
			Ease.InOutQuad => inOutQuad, 
			Ease.InOutQuart => inOutQuart, 
			Ease.InOutQuint => inOutQuint, 
			Ease.InOutSine => inOutSine, 
			_ => linear, 
		};
		static float inBack(float t)
		{
			return t * t * t - t * Mathf.Sin(t * MathF.PI);
		}
		static float inBounce(float t)
		{
			return 1f - outBounce(1f - t);
		}
		static float inCirc(float t)
		{
			return 1f - Mathf.Sqrt(1f - t * t);
		}
		static float inCubic(float t)
		{
			return t * t * t;
		}
		static float inElastic(float t)
		{
			return Mathf.Sin(20.420353f * t) * Mathf.Pow(2f, 10f * (t - 1f));
		}
		static float inExpo(float t)
		{
			if (!Mathf.Approximately(0f, t))
			{
				return Mathf.Pow(2f, 10f * (t - 1f));
			}
			return t;
		}
		static float inOutBack(float t)
		{
			if (!(t < 0.5f))
			{
				return 0.5f * outBack(2f * t - 1f) + 0.5f;
			}
			return 0.5f * inBack(2f * t);
		}
		static float inOutBounce(float t)
		{
			if (!(t < 0.5f))
			{
				return 0.5f * outBounce(2f * t - 1f) + 0.5f;
			}
			return 0.5f * inBounce(2f * t);
		}
		static float inOutCirc(float t)
		{
			if (!(t < 0.5f))
			{
				return 0.5f * (Mathf.Sqrt((0f - (2f * t - 3f)) * (2f * t - 1f)) + 1f);
			}
			return 0.5f * (1f - Mathf.Sqrt(1f - 4f * (t * t)));
		}
		static float inOutCubic(float t)
		{
			if (!(t < 0.5f))
			{
				return 0.5f * inCubic(2f * t - 2f) + 1f;
			}
			return 4f * t * t * t;
		}
		static float inOutElastic(float t)
		{
			if (!(t < 0.5f))
			{
				return 0.5f * (Mathf.Sin(-20.420353f * (2f * t - 1f + 1f)) * Mathf.Pow(2f, -10f * (2f * t - 1f)) + 2f);
			}
			return 0.5f * Mathf.Sin(20.420353f * (2f * t)) * Mathf.Pow(2f, 10f * (2f * t - 1f));
		}
		static float inOutExpo(float v)
		{
			if (!Mathf.Approximately(0f, v) && !Mathf.Approximately(1f, v))
			{
				if (!(v < 0.5f))
				{
					return -0.5f * Mathf.Pow(2f, -20f * v + 10f) + 1f;
				}
				return 0.5f * Mathf.Pow(2f, 20f * v - 10f);
			}
			return v;
		}
		static float inOutQuad(float t)
		{
			if (!(t < 0.5f))
			{
				return -2f * t * t + 4f * t - 1f;
			}
			return 2f * t * t;
		}
		static float inOutQuart(float t)
		{
			if (!(t < 0.5f))
			{
				return -8f * inQuart(t - 1f) + 1f;
			}
			return 8f * inQuart(t);
		}
		static float inOutQuint(float t)
		{
			if (!(t < 0.5f))
			{
				return 0.5f * inQuint(2f * t - 2f) + 1f;
			}
			return 16f * inQuint(t);
		}
		static float inOutSine(float t)
		{
			return 0.5f * (1f - Mathf.Cos(t * MathF.PI));
		}
		static float inQuad(float t)
		{
			return t * t;
		}
		static float inQuart(float t)
		{
			return t * t * t * t;
		}
		static float inQuint(float t)
		{
			return t * t * t * t * t;
		}
		static float inSine(float t)
		{
			return Mathf.Sin((t - 1f) * (MathF.PI / 2f)) + 1f;
		}
		static float linear(float t)
		{
			return t;
		}
		static float outBack(float t)
		{
			return 1f - inBack(1f - t);
		}
		static float outBounce(float t)
		{
			if (!(t < 372f / 1023f))
			{
				if (!(t < 744f / 1023f))
				{
					if (!(t < 0.9f))
					{
						return 10.8f * t * t - 20.52f * t + 10.72f;
					}
					return 12.066482f * t * t - 19.635458f * t + 8.898061f;
				}
				return 9.075f * t * t - 9.9f * t + 3.4f;
			}
			return 121f * t * t / 16f;
		}
		static float outCirc(float t)
		{
			return Mathf.Sqrt((2f - t) * t);
		}
		static float outCubic(float t)
		{
			return inCubic(t - 1f) + 1f;
		}
		static float outElastic(float t)
		{
			return Mathf.Sin(-20.420353f * (t + 1f)) * Mathf.Pow(2f, -10f * t) + 1f;
		}
		static float outExpo(float t)
		{
			if (!Mathf.Approximately(1f, t))
			{
				return 1f - Mathf.Pow(2f, -10f * t);
			}
			return t;
		}
		static float outQuad(float t)
		{
			return (0f - t) * (t - 2f);
		}
		static float outQuart(float t)
		{
			float num = t - 1f;
			return num * num * num * (1f - t) + 1f;
		}
		static float outQuint(float t)
		{
			return inQuint(t - 1f) + 1f;
		}
		static float outSine(float t)
		{
			return Mathf.Sin(t * (MathF.PI / 2f));
		}
	}
}
