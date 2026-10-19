using System;

namespace ACT.Battle;

[Serializable]
public struct MotorIntensities(float leftLow, float rightHigh, float leftTrigger, float rightTrigger)
{
	public float leftLow = leftLow;

	public float rightHigh = rightHigh;

	public float leftTrigger = leftTrigger;

	public float rightTrigger = rightTrigger;

	public static readonly MotorIntensities Zero = new MotorIntensities(0f, 0f, 0f, 0f);

	public MotorIntensities Scale(float multiplier)
	{
		return new MotorIntensities(leftLow * multiplier, rightHigh * multiplier, leftTrigger * multiplier, rightTrigger * multiplier);
	}
}
