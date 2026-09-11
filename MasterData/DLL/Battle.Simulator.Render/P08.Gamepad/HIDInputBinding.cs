using UnityEngine;
using UnityEngine.UI;

namespace P08.Gamepad;

public class HIDInputBinding : MonoBehaviour
{
	private enum ShowStyle
	{
		Disable,
		TextOnly,
		KeyboardIcon,
		GamepadIcon
	}

	public Text actionText;

	public Text keyText;

	public Image keyImage;

	public Image bgImage;

	public Image gamepadKeyImage;

	private InputBinding inputBinding;

	private bool _hasKey;

	public void SetInputBinding(InputBinding binding)
	{
		inputBinding = binding;
		UpdateUI();
	}

	public InputBinding GetInputBinding()
	{
		return inputBinding;
	}

	public bool HasKey()
	{
		return _hasKey;
	}

	public void UpdateUI()
	{
		if (inputBinding == null)
		{
			SwitchShowStyle(ShowStyle.Disable);
			return;
		}
		string mappedKey = HIDInputRemap.GetMappedKey(inputBinding.buttonType);
		_hasKey = !string.IsNullOrEmpty(mappedKey);
		if (!_hasKey)
		{
			SwitchShowStyle(ShowStyle.Disable);
			return;
		}
		if (actionText != null)
		{
			actionText.text = HIDInputRemap.GetActionI18NText(inputBinding.actionName);
			LayoutRebuilder.ForceRebuildLayoutImmediate(actionText.rectTransform);
		}
		Sprite icon = HIDInputRemap.GetIcon(mappedKey, GamepadManager.Instance.GetGamepadType());
		if (icon != null)
		{
			bool flag = IsGamepadStyle();
			SwitchShowStyle(flag ? ShowStyle.GamepadIcon : ShowStyle.KeyboardIcon);
			if (flag)
			{
				gamepadKeyImage.sprite = icon;
			}
			else
			{
				keyImage.sprite = icon;
			}
		}
		else
		{
			SwitchShowStyle(ShowStyle.TextOnly);
			keyText.text = HIDInputRemap.GetKeyI18NText(mappedKey);
			LayoutRebuilder.ForceRebuildLayoutImmediate(keyText.rectTransform);
		}
	}

	private void Awake()
	{
		if (inputBinding == null)
		{
			base.gameObject.SetActive(value: false);
		}
		if (actionText != null)
		{
			actionText.maskable = false;
		}
		if (keyText != null)
		{
			keyText.maskable = false;
		}
		if (keyImage != null)
		{
			keyImage.maskable = false;
		}
		if (bgImage != null)
		{
			bgImage.maskable = false;
		}
		if (gamepadKeyImage != null)
		{
			gamepadKeyImage.maskable = false;
		}
	}

	private bool IsGamepadStyle()
	{
		En_GamepadType gamepadType = GamepadManager.Instance.GetGamepadType();
		if (gamepadType != En_GamepadType.Xbox)
		{
			return gamepadType == En_GamepadType.PS4;
		}
		return true;
	}

	private void SwitchShowStyle(ShowStyle style)
	{
		bool active = false;
		bool active2 = false;
		bool active3 = false;
		bool active4 = false;
		switch (style)
		{
		case ShowStyle.Disable:
			if (base.gameObject.activeSelf)
			{
				base.gameObject.SetActive(value: false);
			}
			return;
		case ShowStyle.TextOnly:
			active = true;
			active2 = true;
			break;
		case ShowStyle.KeyboardIcon:
			active = true;
			active3 = true;
			break;
		case ShowStyle.GamepadIcon:
			active4 = true;
			break;
		}
		if (!base.gameObject.activeSelf)
		{
			base.gameObject.SetActive(value: true);
		}
		bgImage?.gameObject.SetActive(active);
		keyText?.gameObject.SetActive(active2);
		keyImage?.gameObject.SetActive(active3);
		gamepadKeyImage?.gameObject.SetActive(active4);
	}
}
