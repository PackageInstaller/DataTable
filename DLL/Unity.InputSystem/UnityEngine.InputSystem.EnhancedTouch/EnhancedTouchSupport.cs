using System;
using System.Diagnostics;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.EnhancedTouch;

public static class EnhancedTouchSupport
{
	private static int s_Enabled;

	private static InputSettings.UpdateMode s_UpdateMode;

	public static bool enabled => s_Enabled > 0;

	public static void Enable()
	{
		s_Enabled++;
		if (s_Enabled <= 1)
		{
			InputSystem.onDeviceChange += OnDeviceChange;
			InputSystem.onBeforeUpdate += Touch.BeginUpdate;
			InputSystem.onSettingsChange += OnSettingsChange;
			SetUpState();
		}
	}

	public static void Disable()
	{
		if (enabled)
		{
			s_Enabled--;
			if (s_Enabled <= 0)
			{
				InputSystem.onDeviceChange -= OnDeviceChange;
				InputSystem.onBeforeUpdate -= Touch.BeginUpdate;
				InputSystem.onSettingsChange -= OnSettingsChange;
				TearDownState();
			}
		}
	}

	internal static void Reset()
	{
		Touch.s_GlobalState.touchscreens = default(InlinedArray<Touchscreen>);
		Touch.s_GlobalState.playerState.Destroy();
		Touch.s_GlobalState.playerState = default(Touch.FingerAndTouchState);
		s_Enabled = 0;
	}

	private static void SetUpState()
	{
		Touch.s_GlobalState.playerState.updateMask = InputUpdateType.Dynamic | InputUpdateType.Fixed | InputUpdateType.Manual;
		s_UpdateMode = InputSystem.settings.updateMode;
		foreach (InputDevice device in InputSystem.devices)
		{
			OnDeviceChange(device, InputDeviceChange.Added);
		}
	}

	internal static void TearDownState()
	{
		foreach (InputDevice device in InputSystem.devices)
		{
			OnDeviceChange(device, InputDeviceChange.Removed);
		}
		Touch.s_GlobalState.playerState.Destroy();
		Touch.s_GlobalState.playerState = default(Touch.FingerAndTouchState);
	}

	private static void OnDeviceChange(InputDevice device, InputDeviceChange change)
	{
		switch (change)
		{
		case InputDeviceChange.Added:
			if (device is Touchscreen screen2)
			{
				Touch.AddTouchscreen(screen2);
			}
			break;
		case InputDeviceChange.Removed:
			if (device is Touchscreen screen)
			{
				Touch.RemoveTouchscreen(screen);
			}
			break;
		}
	}

	private static void OnSettingsChange()
	{
		InputSettings.UpdateMode updateMode = InputSystem.settings.updateMode;
		if (s_UpdateMode != updateMode)
		{
			TearDownState();
			SetUpState();
		}
	}

	[Conditional("UNITY_EDITOR")]
	[Conditional("DEVELOPMENT_BUILD")]
	internal static void CheckEnabled()
	{
		if (!enabled)
		{
			throw new InvalidOperationException("EnhancedTouch API is not enabled; call EnhancedTouchSupport.Enable()");
		}
	}
}
