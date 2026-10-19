using ACT.Battle;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.UI;

namespace ACT.UI;

public class GampadKeyPrompt : MonoBehaviour
{
	[SerializeField]
	private string _keyBinding;

	[SerializeField]
	private bool _hideWhenKeyboardInput;

	[SerializeField]
	private Image _icon;

	private static readonly Gamepad CommonGamepad = new Gamepad();

	public static InputDevice ActivePromptDevice
	{
		get
		{
			if (!(MonoECS.instance.activeInputDevice is DualShockGamepad))
			{
				return CommonGamepad;
			}
			return MonoECS.instance.activeInputDevice;
		}
	}

	public void ResetKeyBinding(string value)
	{
		_keyBinding = value;
	}

	public void UpdateDeviceKeyIcon()
	{
		MonoECS.instance.GetKeyIconAsync(_keyBinding, ActivePromptDevice, OnKeyIconLoaded);
	}

	private void OnKeyIconLoaded(bool success, Sprite sprite, InputDevice device)
	{
		if (!success)
		{
			gameObject.SetActive(value: false);
			return;
		}
		gameObject.SetActive(value: true);
		_icon.sprite = sprite;
	}
}
