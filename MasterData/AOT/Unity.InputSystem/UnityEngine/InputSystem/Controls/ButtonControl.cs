using System.Runtime.CompilerServices;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Controls;

public class ButtonControl : AxisControl
{
	private bool m_NeedsToCheckFramePress;

	private uint m_UpdateCountLastPressed = uint.MaxValue;

	private uint m_UpdateCountLastReleased = uint.MaxValue;

	private bool m_LastUpdateWasPress;

	public float pressPoint = -1f;

	internal static float s_GlobalDefaultButtonPressPoint;

	internal static float s_GlobalDefaultButtonReleaseThreshold;

	internal const float kMinButtonPressPoint = 0.0001f;

	internal bool needsToCheckFramePress { get; private set; }

	public float pressPointOrDefault
	{
		get
		{
			if (!(pressPoint > 0f))
			{
				return s_GlobalDefaultButtonPressPoint;
			}
			return pressPoint;
		}
	}

	public bool isPressed
	{
		get
		{
			if (!needsToCheckFramePress)
			{
				return IsValueConsideredPressed(value);
			}
			return m_LastUpdateWasPress;
		}
	}

	public bool wasPressedThisFrame
	{
		get
		{
			if (!needsToCheckFramePress)
			{
				bool flag = IsValueConsideredPressed(value);
				bool flag2 = IsValueConsideredPressed(ReadValueFromPreviousFrame());
				BeginTestingForFramePresses(flag, flag2);
				if (device.wasUpdatedThisFrame & flag)
				{
					return !flag2;
				}
				return false;
			}
			return InputUpdate.s_UpdateStepCount == m_UpdateCountLastPressed;
		}
	}

	public bool wasReleasedThisFrame
	{
		get
		{
			if (!needsToCheckFramePress)
			{
				bool flag = IsValueConsideredPressed(value);
				bool flag2 = IsValueConsideredPressed(ReadValueFromPreviousFrame());
				BeginTestingForFramePresses(flag, flag2);
				return (device.wasUpdatedThisFrame && !flag) & flag2;
			}
			return InputUpdate.s_UpdateStepCount == m_UpdateCountLastReleased;
		}
	}

	public ButtonControl()
	{
		m_StateBlock.format = InputStateBlock.FormatBit;
		m_MinValue = 0f;
		m_MaxValue = 1f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public new bool IsValueConsideredPressed(float value)
	{
		return value >= pressPointOrDefault;
	}

	private void BeginTestingForFramePresses(bool currentlyPressed, bool pressedLastFrame)
	{
		needsToCheckFramePress = true;
		device.m_ButtonControlsCheckingPressState.Add(this);
		m_LastUpdateWasPress = currentlyPressed;
		if (currentlyPressed && !pressedLastFrame)
		{
			m_UpdateCountLastPressed = device.m_CurrentUpdateStepCount;
		}
		else if (pressedLastFrame && !currentlyPressed)
		{
			m_UpdateCountLastReleased = device.m_CurrentUpdateStepCount;
		}
	}

	internal void UpdateWasPressed()
	{
		bool flag = IsValueConsideredPressed(value);
		if (m_LastUpdateWasPress != flag)
		{
			if (flag)
			{
				m_UpdateCountLastPressed = device.m_CurrentUpdateStepCount;
			}
			else
			{
				m_UpdateCountLastReleased = device.m_CurrentUpdateStepCount;
			}
			m_LastUpdateWasPress = flag;
		}
	}
}
