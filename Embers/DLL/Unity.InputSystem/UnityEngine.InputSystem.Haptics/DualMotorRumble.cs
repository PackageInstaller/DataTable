using System;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Haptics;

internal struct DualMotorRumble
{
	public float lowFrequencyMotorSpeed { get; private set; }

	public float highFrequencyMotorSpeed { get; private set; }

	public bool isRumbling
	{
		get
		{
			if (Mathf.Approximately(lowFrequencyMotorSpeed, 0f))
			{
				return !Mathf.Approximately(highFrequencyMotorSpeed, 0f);
			}
			return true;
		}
	}

	public void PauseHaptics(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (isRumbling)
		{
			DualMotorRumbleCommand command = DualMotorRumbleCommand.Create(0f, 0f);
			device.ExecuteCommand(ref command);
		}
	}

	public void ResumeHaptics(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (isRumbling)
		{
			SetMotorSpeeds(device, lowFrequencyMotorSpeed, highFrequencyMotorSpeed);
		}
	}

	public void ResetHaptics(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (isRumbling)
		{
			SetMotorSpeeds(device, 0f, 0f);
		}
	}

	public void SetMotorSpeeds(InputDevice device, float lowFrequency, float highFrequency)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		lowFrequencyMotorSpeed = Mathf.Clamp(lowFrequency, 0f, 1f);
		highFrequencyMotorSpeed = Mathf.Clamp(highFrequency, 0f, 1f);
		DualMotorRumbleCommand command = DualMotorRumbleCommand.Create(lowFrequencyMotorSpeed, highFrequencyMotorSpeed);
		device.ExecuteCommand(ref command);
	}
}
