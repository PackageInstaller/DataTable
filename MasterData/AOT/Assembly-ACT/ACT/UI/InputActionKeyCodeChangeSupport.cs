using System.Collections.Generic;
using UnityEngine.InputSystem;

namespace ACT.UI;

public static class InputActionKeyCodeChangeSupport
{
	private const string AnyGamepadInput = "<Gamepad>";

	private const string AnyKeyboardInput = "<Keyboard>";

	private const string AnyMouseInput = "<Mouse>";

	public static readonly Dictionary<string, string> GamepadModifierModeSupports = new Dictionary<string, string>
	{
		{ "<Gamepad>/buttonWest", "gamepad/west" },
		{ "<Gamepad>/buttonNorth", "gamepad/north" },
		{ "<Gamepad>/buttonSouth", "gamepad/south" },
		{ "<Gamepad>/buttonEast", "gamepad/east" },
		{ "<Gamepad>/dpad/right", "gamepad/dpad/right" },
		{ "<Gamepad>/dpad/up", "gamepad/dpad/up" },
		{ "<Gamepad>/dpad/left", "gamepad/dpad/left" },
		{ "<Gamepad>/dpad/down", "gamepad/dpad/down" }
	};

	public static readonly HashSet<string> GamepadNormalModeSupports = new HashSet<string>
	{
		"<Gamepad>/dpad/right", "<Gamepad>/dpad/up", "<Gamepad>/dpad/left", "<Gamepad>/dpad/down", "<Gamepad>/buttonNorth", "<Gamepad>/buttonSouth", "<Gamepad>/buttonWest", "<Gamepad>/buttonEast", "<Gamepad>/rightShoulder", "<Gamepad>/leftTrigger",
		"<Gamepad>/rightTrigger", "<Gamepad>/leftStickPress", "<Gamepad>/rightStickPress", "<Gamepad>/select", "<Gamepad>/start"
	};

	internal static InputActionRebindingExtensions.RebindingOperation GetKeyboardRebindOperation(InputAction inputAction, int bindingIndex)
	{
		return inputAction.PerformInteractiveRebinding(bindingIndex).WithControlsHavingToMatchPath("<Keyboard>").WithControlsHavingToMatchPath("<Mouse>")
			.WithControlsHavingToMatchPath("<Gamepad>")
			.WithCancelingThrough(string.Empty)
			.OnMatchWaitForAnother(0.1f);
	}

	internal static InputActionRebindingExtensions.RebindingOperation GetGampepadRebindOperation(bool modifierMode, InputAction inputAction, int bindingIndex)
	{
		return inputAction.PerformInteractiveRebinding(bindingIndex).WithControlsHavingToMatchPath("<Gamepad>").WithControlsHavingToMatchPath("<Keyboard>")
			.WithCancelingThrough(string.Empty)
			.OnMatchWaitForAnother(0.1f);
	}

	public static bool IsValidKeyCode(bool modifierMode, string newBindingEffectPath)
	{
		if (!newBindingEffectPath.StartsWith("<Gamepad>"))
		{
			return false;
		}
		if (!modifierMode)
		{
			return GamepadNormalModeSupports.Contains(newBindingEffectPath);
		}
		return GamepadModifierModeSupports.ContainsKey(newBindingEffectPath);
	}
}
