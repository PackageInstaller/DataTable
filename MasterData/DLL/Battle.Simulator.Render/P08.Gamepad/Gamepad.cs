using System.Collections.Generic;

namespace P08.Gamepad;

public class Gamepad
{
	public const string KEYBOARD_LAYOUT_KEY = "KeyboardLayout";

	public const string KEYBOARD_PC_LAYOUT_NAME = "KeyboardPCLayout";

	public const string KEYBOARD_ANDROID_LAYOUT_NAME = "KeyboardAndroidLayout";

	public const string KEYBOARD_IOS_LAYOUT_NAME = "KeyboardIOSLayout";

	public const string KEYMOUSE_LAYOUT_KEY = "KeyMouseLayout";

	public const string KEYMOUSE_PC_LAYOUT_NAME = "KeyMousePCLayout";

	public const string KEYMOUSE_ANDROID_LAYOUT_NAME = "KeyMouseAndroidLayout";

	public const string KEYMOUSE_IOS_LAYOUT_NAME = "KeyMouseIOSLayout";

	public const string XBOX_ONE_LAYOUT_KEY = "XboxLayout";

	public const string XBOX_ONE_PC_LAYOUT_NAME = "XboxOnePCLayout";

	public const string XBOX_ONE_ANDROID_LAYOUT_NAME = "XboxOneAndroidLayout";

	public const string XBOX_ONE_IOS_LAYOUT_NAME = "XboxOneIOSLayout";

	public const string DUALSHOCK_4_LAYOUT_KEY = "PS4Layout";

	public const string DUALSHOCK_4_PC_LAYOUT_NAME = "Dualshock4PCLayout";

	public const string DUALSHOCK_4_ANDROID_LAYOUT_NAME = "Dualshock4AndroidLayout";

	public const string DUALSHOCK_4_IOS_LAYOUT_NAME = "Dualshock4IOSLayout";

	public const string OTHER_LAYOUT_KEY = "OtherLayout";

	public const string OTHER_ANDROID_LAYOUT_NAME = "OtherAndroidLayout";

	public const string OTHER_IOS_LAYOUT_NAME = "OtherIOSLayout";

	public const int CAMERA_SENSITIVITY_DEFAULT_VALUE = 50;

	public const int CURSOR_SENSITIVITY_DEFAULT_VALUE = 50;

	protected bool _init;

	private int _cameraSensitivity = 50;

	private int _cursorSensitivity = 50;

	private Dictionary<En_ButtonType, ButtonMap> _dictButtonMap = new Dictionary<En_ButtonType, ButtonMap>();

	public void CreateController()
	{
		ReloadLayoutFromConfig();
		_init = true;
	}

	public virtual void ReloadLayoutFromConfig()
	{
		string empty = string.Empty;
		LoadLayoutFromConfig("OtherLayout", empty);
	}

	public void LoadLayoutFromConfig(string pKey, string pDefaultFileName)
	{
		string layoutJsonFormConfig = GamepadLayout.GetLayoutJsonFormConfig(pKey, pDefaultFileName);
		LoadLayoutFromJson(layoutJsonFormConfig);
	}

	public void LoadLayoutFromJson(string pJson)
	{
		_dictButtonMap.Clear();
		GamepadLayout layout = GamepadLayout.GetLayout(pJson);
		if (layout == null)
		{
			return;
		}
		foreach (ButtonParameter buttonMapLayout in layout.m_buttonMapLayouts)
		{
			ButtonMap buttonMap = buttonMapLayout.GetButtonMap();
			_dictButtonMap.TryGetValue(buttonMap.m_buttonType, out var _);
			_dictButtonMap[buttonMap.m_buttonType] = buttonMap;
		}
		_cameraSensitivity = layout.m_cameraSensitivity;
		_cursorSensitivity = layout.m_cursorSensitivity;
	}

	public void Update()
	{
		if (!_init)
		{
			return;
		}
		foreach (KeyValuePair<En_ButtonType, ButtonMap> item in _dictButtonMap)
		{
			item.Deconstruct(out var _, out var value);
			value.UpadateStatus();
		}
	}

	public virtual void ResetSubStickController()
	{
	}

	public void Shutdown()
	{
		_init = false;
		_dictButtonMap.Clear();
	}

	private bool TryGetButtonMap(En_ButtonType buttonType, out ButtonMap buttonMap)
	{
		return _dictButtonMap.TryGetValue(buttonType, out buttonMap);
	}

	public bool GetKeyDownInternal(En_ButtonType pEn_ButtonType)
	{
		if (TryGetButtonMap(pEn_ButtonType, out var buttonMap))
		{
			return buttonMap.GetKeyDown();
		}
		return false;
	}

	public bool GetKeyUpInternal(En_ButtonType pEn_ButtonType)
	{
		if (TryGetButtonMap(pEn_ButtonType, out var buttonMap))
		{
			return buttonMap.GetKeyUp();
		}
		return false;
	}

	public bool GetKeyInternal(En_ButtonType pEn_ButtonType)
	{
		if (TryGetButtonMap(pEn_ButtonType, out var buttonMap))
		{
			return buttonMap.GetKey();
		}
		return false;
	}

	public virtual float GetKeyValueInternal(En_ButtonType pEn_ButtonType)
	{
		if (TryGetButtonMap(pEn_ButtonType, out var buttonMap))
		{
			return buttonMap.GetValue();
		}
		return 0f;
	}

	public string GetMappedKey(En_ButtonType pEn_ButtonType)
	{
		if (TryGetButtonMap(pEn_ButtonType, out var buttonMap))
		{
			if (buttonMap.m_listenType == En_ListenType.KeyCode)
			{
				return InputSettingListener.KeyCodeToString(buttonMap.m_keyCode);
			}
			return buttonMap.m_name;
		}
		return "";
	}

	public int GetCameraSensitivity()
	{
		return _cameraSensitivity;
	}

	public int GetCursorSensitivity()
	{
		return _cursorSensitivity;
	}

	public static bool GetKeyDown(En_ButtonType pEn_ButtonType)
	{
		return GamepadManager.Instance.GetKeyDown(pEn_ButtonType);
	}

	public static bool GetKeyUp(En_ButtonType pEn_ButtonType)
	{
		return GamepadManager.Instance.GetKeyUp(pEn_ButtonType);
	}

	public static bool GetKey(En_ButtonType pEn_ButtonType)
	{
		return GamepadManager.Instance.GetKey(pEn_ButtonType);
	}

	public static float GetKeyValue(En_ButtonType pEn_ButtonType)
	{
		return GamepadManager.Instance.GetKeyValue(pEn_ButtonType);
	}

	public void OnLostFocus()
	{
		if (!_init)
		{
			return;
		}
		foreach (KeyValuePair<En_ButtonType, ButtonMap> item in _dictButtonMap)
		{
			item.Deconstruct(out var _, out var value);
			value.LostFocus();
		}
	}
}
