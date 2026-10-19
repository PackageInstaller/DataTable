using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Battle;

[CreateAssetMenu(fileName = "NewGamepadRumbleCurve", menuName = "ACT/GamepadRumbleCurvePreset")]
public class GamepadRumbleCurvePreset : ScriptableObject
{
	[Range(0f, 100f)]
	public int priority;

	public float duration = 0.2f;

	[FormerlySerializedAs("leftLow")]
	public MotorChannelConfig xBoxLeftLow = MotorChannelConfig.CreateDefault();

	[FormerlySerializedAs("rightHigh")]
	public MotorChannelConfig xBoxRightHigh = MotorChannelConfig.CreateDefault();

	[FormerlySerializedAs("leftTrigger")]
	public MotorChannelConfig xBoxLeftTrigger = MotorChannelConfig.CreateDisabled();

	[FormerlySerializedAs("rightTrigger")]
	public MotorChannelConfig xBoxRightTrigger = MotorChannelConfig.CreateDisabled();

	public MotorChannelConfig ps5LeftLow = MotorChannelConfig.CreateDefault();

	public MotorChannelConfig ps5RightHigh = MotorChannelConfig.CreateDefault();

	public MotorChannelConfig ps5LeftTrigger = MotorChannelConfig.CreateDisabled();

	public MotorChannelConfig ps5RightTrigger = MotorChannelConfig.CreateDisabled();

	public MotorIntensities EvaluateAll(float normalizedTime, bool usePS5 = false)
	{
		if (usePS5)
		{
			return new MotorIntensities(ps5LeftLow.Evaluate(normalizedTime), ps5RightHigh.Evaluate(normalizedTime), ps5LeftTrigger.Evaluate(normalizedTime), ps5RightTrigger.Evaluate(normalizedTime));
		}
		return new MotorIntensities(xBoxLeftLow.Evaluate(normalizedTime), xBoxRightHigh.Evaluate(normalizedTime), xBoxLeftTrigger.Evaluate(normalizedTime), xBoxRightTrigger.Evaluate(normalizedTime));
	}
}
