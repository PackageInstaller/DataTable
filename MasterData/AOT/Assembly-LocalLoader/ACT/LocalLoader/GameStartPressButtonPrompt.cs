using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.UI;

namespace ACT.LocalLoader;

public class GameStartPressButtonPrompt : MonoBehaviour
{
	[SerializeField]
	private Sprite _psIcon;

	[SerializeField]
	private Sprite _xboxIcon;

	[SerializeField]
	private Image _icon;

	public void UpdateDevice(InputDevice device)
	{
		if (device is Gamepad)
		{
			gameObject.SetActive(value: true);
			Sprite sprite = ((device is DualShockGamepad) ? _psIcon : _xboxIcon);
			_icon.sprite = sprite;
			_icon.SetNativeSize();
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}
}
