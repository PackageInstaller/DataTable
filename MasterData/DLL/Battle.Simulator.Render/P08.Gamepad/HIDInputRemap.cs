using UnityEngine;

namespace P08.Gamepad;

public class HIDInputRemap
{
	private const string INPUT_REMAP_NOTICE_ENABLE_LIST = "InputRemapNoticeEnableList";

	private static int _hidInputRemapCache = GetInputRemapPref();

	public static string GetActionI18NText(string actionName)
	{
		string text = "PAGE_ACTION_" + actionName.ToUpper();
		string result = text;
		object[] array = LuaHelper.CallFunction("GetTips", text);
		if (array != null && array.Length != 0)
		{
			result = (string)array[0];
		}
		return result;
	}

	public static string GetKeyI18NText(string keyName)
	{
		string result = keyName;
		object[] array = LuaHelper.CallFunction("GetKeyCodeMappedName", keyName);
		if (array != null && array.Length != 0)
		{
			result = (string)array[0];
		}
		return result;
	}

	public static bool IsNeedRemapNotice()
	{
		En_GamepadType gamepadType = GetGamepadType();
		bool inputRemapPrefCache = GetInputRemapPrefCache(gamepadType);
		bool flag = gamepadType != En_GamepadType.None;
		return inputRemapPrefCache & flag;
	}

	public static string GetMappedKey(En_ButtonType control)
	{
		return GamepadManager.Instance.GetMappedKey(control);
	}

	public static Sprite GetDefaultIcon()
	{
		if (!InputManager.iconBindings.bindingMap.TryGetValue("KeyBackground", out var value))
		{
			return null;
		}
		return value;
	}

	public static Sprite GetIcon(string key, En_GamepadType gamepadType)
	{
		if (InputManager.iconBindings.bindingMap.TryGetValue(key, out var value))
		{
			return value;
		}
		string remapKeyIconName = GetRemapKeyIconName(gamepadType, key);
		if (InputManager.iconBindings.bindingMap.TryGetValue(remapKeyIconName, out value))
		{
			return value;
		}
		return null;
	}

	private static string GetRemapKeyIconName(En_GamepadType gamepadType, string key)
	{
		return gamepadType switch
		{
			En_GamepadType.Xbox => "Xbox_" + key, 
			En_GamepadType.PS4 => "PS_" + key, 
			_ => key, 
		};
	}

	private static int GetInputRemapPref()
	{
		return PlayerPrefs.GetInt("InputRemapNoticeEnableList", -1);
	}

	private static En_GamepadType GetGamepadType()
	{
		return GamepadManager.Instance.GetGamepadType();
	}

	public static void SetInputRemapPref(En_GamepadType gamepadType, bool val)
	{
		int inputRemapPref = GetInputRemapPref();
		int num = 1 << (int)gamepadType;
		inputRemapPref = (val ? (inputRemapPref | num) : (inputRemapPref & ~num));
		PlayerPrefs.SetInt("InputRemapNoticeEnableList", inputRemapPref);
		_hidInputRemapCache = inputRemapPref;
	}

	public static bool GetInputRemapPrefCache(En_GamepadType gamepadType)
	{
		int num = 1 << (int)gamepadType;
		return (_hidInputRemapCache & num) != 0;
	}
}
