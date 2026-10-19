using System;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public struct MotorChannelConfig
{
	public bool enabled;

	public AnimationCurve curve;

	public float Evaluate(float normalizedTime)
	{
		if (!enabled || curve == null)
		{
			return 0f;
		}
		return curve.Evaluate(normalizedTime);
	}

	public static MotorChannelConfig CreateDefault(float defaultAmplitude = 0.5f)
	{
		return new MotorChannelConfig
		{
			enabled = true,
			curve = AnimationCurve.EaseInOut(0f, 1f, 1f, 0f)
		};
	}

	public static MotorChannelConfig CreateDisabled()
	{
		return new MotorChannelConfig
		{
			enabled = false,
			curve = AnimationCurve.EaseInOut(0f, 1f, 1f, 0f)
		};
	}
}
