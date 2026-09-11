using System;
using System.Collections.Generic;
using System.Linq;
using P08.Gamepad;
using UnityEngine;

public class LuaForGamepad
{
	[Serializable]
	private struct LayoutItemLuaData
	{
		public int buttonInt;

		public string buttonName;

		public string keyName;

		public string defKeyName;

		public bool hasKeyIcon;

		public bool hasDefKeyIcon;

		public bool invalid;
	}

	[Serializable]
	private struct ControlGroupLuaData(EControlType type)
	{
		public int controlType = (int)type;

		public int conflictGroup = 0;

		public List<LayoutItemLuaData> items = new List<LayoutItemLuaData>();
	}

	[Serializable]
	private struct LayoutControlGroupsLuaData
	{
		public List<ControlGroupLuaData> groups;
	}

	public static void SetGamePadType(int pGamepadType)
	{
		GamepadManager.Instance.SetGamepadType(pGamepadType);
	}

	public static int GetGamepadType()
	{
		return (int)GamepadManager.Instance.GetGamepadType();
	}

	public static string GetLayoutJson(string pKey, string pLayoutName)
	{
		return GamepadLayout.GetLayoutJsonFormConfig(pKey, pLayoutName);
	}

	public static void SaveLayoutJson(string pKey, string pJson)
	{
		GamepadLayout.SaveLayoutJson(pKey, pJson);
	}

	public static void DeleteLayoutJson(string pKey)
	{
		GamepadLayout.DeleteLayoutJson(pKey);
	}

	public static void ReloadLayout()
	{
		GamepadManager.Instance.ReloadLayout();
	}

	public static void LoadLayoutFromJson(string pJson)
	{
		GamepadManager.Instance.LoadLayoutFromJson(pJson);
	}

	public static string GetFirstInputValue()
	{
		return GamepadManager.Instance.GetFirstInputValue();
	}

	public static string GetLastInputValue()
	{
		return GamepadManager.Instance.GetLastInputValue();
	}

	public static string GetFirstDeltaInputValue()
	{
		return GamepadManager.Instance.GetFirstDeltaInputValue();
	}

	public static void DisableListenerEnable()
	{
		GamepadManager.Instance.DisableListenerEnable();
	}

	public static void ClearInputValue()
	{
		GamepadManager.Instance.ClearAllInputResult();
	}

	public static string GetInputListString()
	{
		return GamepadManager.Instance.GetInputListString();
	}

	public static string GetAllInputResultJson()
	{
		return GamepadManager.Instance.GetAllInputResultJson();
	}

	public static void SetLayoutItem(string pKey, string pLayoutName, int pButtonType, string pValue)
	{
		string layoutJson = GetLayoutJson(pKey, pLayoutName);
		GamepadLayout gamepadLayout = GamepadLayout.GetLayout(layoutJson);
		if (gamepadLayout == null)
		{
			gamepadLayout = new GamepadLayout();
			gamepadLayout.m_buttonMapLayouts = new List<ButtonParameter>();
		}
		En_ButtonType buttonType = (En_ButtonType)pButtonType;
		ControlGroup controlGroup = InputManager.controlGroups.Find((ControlGroup g) => g.keys.Contains(buttonType));
		bool flag = false;
		foreach (ButtonParameter buttonMapLayout in gamepadLayout.m_buttonMapLayouts)
		{
			if (buttonMapLayout.m_value == pValue && buttonMapLayout.m_buttonType != buttonType && controlGroup != null && controlGroup.keys.Contains(buttonMapLayout.m_buttonType))
			{
				buttonMapLayout.m_value = string.Empty;
			}
			if (buttonMapLayout.m_buttonType == buttonType)
			{
				buttonMapLayout.m_value = pValue;
				flag = true;
			}
		}
		if (!flag)
		{
			ButtonParameter item = new ButtonParameter
			{
				m_buttonType = buttonType,
				m_value = pValue
			};
			gamepadLayout.m_buttonMapLayouts.Add(item);
		}
		layoutJson = JsonUtility.ToJson(gamepadLayout);
		SaveLayoutJson(pKey, layoutJson);
		GamepadManager.Instance.ReloadLayout();
	}

	private static bool IsSubJoytstick(En_ButtonType pButtonType)
	{
		if (pButtonType != En_ButtonType.SubJoystickUp && pButtonType != En_ButtonType.SubJoystickDown && pButtonType != En_ButtonType.SubJoystickLeft)
		{
			return pButtonType == En_ButtonType.SubJoystickRight;
		}
		return true;
	}

	public static string GetDefaultLayoutFileName(string pKey)
	{
		return GamepadLayout.GetDefaultLayoutFileName(pKey);
	}

	public static string ConvertName(string pValue)
	{
		if (GamepadLayout.m_halfAixsNames.contains(pValue))
		{
			return pValue;
		}
		if (int.TryParse(pValue, out var result))
		{
			KeyCode keyCode = (KeyCode)result;
			return keyCode.ToString();
		}
		return pValue;
	}

	public static int GetCameraSensitivity()
	{
		return GamepadManager.Instance.GetCameraSensitivity();
	}

	public static void SetCameraSensitivity(string pKey, string pLayoutName, int value)
	{
		string layoutJson = GetLayoutJson(pKey, pLayoutName);
		GamepadLayout gamepadLayout = GamepadLayout.GetLayout(layoutJson);
		if (gamepadLayout == null)
		{
			gamepadLayout = new GamepadLayout();
			gamepadLayout.m_buttonMapLayouts = new List<ButtonParameter>();
		}
		gamepadLayout.m_cameraSensitivity = value;
		layoutJson = JsonUtility.ToJson(gamepadLayout);
		SaveLayoutJson(pKey, layoutJson);
		GamepadManager.Instance.ReloadLayout();
	}

	public static int GetCursorSensitivity(string pKey, string pLayoutName)
	{
		return GamepadLayout.GetLayout(GetLayoutJson(pKey, pLayoutName)).m_cursorSensitivity;
	}

	public static void SetCursorSensitivity(string pKey, string pLayoutName, int value)
	{
		string layoutJson = GetLayoutJson(pKey, pLayoutName);
		GamepadLayout gamepadLayout = GamepadLayout.GetLayout(layoutJson);
		if (gamepadLayout == null)
		{
			gamepadLayout = new GamepadLayout();
			gamepadLayout.m_buttonMapLayouts = new List<ButtonParameter>();
		}
		gamepadLayout.m_cursorSensitivity = value;
		layoutJson = JsonUtility.ToJson(gamepadLayout);
		SaveLayoutJson(pKey, layoutJson);
		GamepadManager.Instance.ReloadLayout();
	}

	public static string GetButtonTypeName(int buttonTypeInt)
	{
		En_ButtonType en_ButtonType = (En_ButtonType)buttonTypeInt;
		return en_ButtonType.ToString();
	}

	public static Sprite GetKeyIcon(string key, int gamepadType)
	{
		return HIDInputRemap.GetIcon(key, (En_GamepadType)gamepadType);
	}

	public static bool IsGamepadKey(string key)
	{
		if (GamepadLayout.m_halfAixsNames.Contains(key))
		{
			return true;
		}
		if (int.TryParse(key, out var result))
		{
			KeyCode keyCode = (KeyCode)result;
			if (keyCode >= KeyCode.JoystickButton0)
			{
				return keyCode <= KeyCode.Joystick8Button19;
			}
			return false;
		}
		return false;
	}

	private static void GetUserAndDefaultLayout(string key, out GamepadLayout userLayout, out GamepadLayout defaultLayout)
	{
		string defaultLayoutFileName = GetDefaultLayoutFileName(key);
		string layoutJsonFormConfig = GamepadLayout.GetLayoutJsonFormConfig(key, defaultLayoutFileName);
		string layoutJsonFromFile = GamepadLayout.GetLayoutJsonFromFile(defaultLayoutFileName);
		userLayout = GamepadLayout.GetLayout(layoutJsonFormConfig);
		defaultLayout = GamepadLayout.GetLayout(layoutJsonFromFile);
		if (userLayout == null)
		{
			userLayout = new GamepadLayout();
			userLayout.m_buttonMapLayouts = new List<ButtonParameter>();
		}
		if (defaultLayout == null)
		{
			defaultLayout = new GamepadLayout();
			defaultLayout.m_buttonMapLayouts = new List<ButtonParameter>();
		}
	}

	public static string GetLayoutItem(string key, int buttonTypeInt)
	{
		GetUserAndDefaultLayout(key, out var userLayout, out var defaultLayout);
		En_ButtonType buttonType = (En_ButtonType)buttonTypeInt;
		userLayout.m_buttonMapLayouts.Find((ButtonParameter item) => item.m_buttonType == buttonType);
		GetLayoutItemLuaData(userLayout, defaultLayout, buttonType, out var luaData);
		return JsonUtility.ToJson(luaData);
	}

	private static void GetLayoutItemLuaData(GamepadLayout userLayout, GamepadLayout defaultLayout, En_ButtonType buttonType, out LayoutItemLuaData luaData)
	{
		luaData = default(LayoutItemLuaData);
		ButtonParameter buttonParameter = userLayout.m_buttonMapLayouts.Find((ButtonParameter item) => item.m_buttonType == buttonType);
		ButtonParameter buttonParameter2 = defaultLayout.m_buttonMapLayouts.Find((ButtonParameter item) => item.m_buttonType == buttonType);
		if (buttonParameter == null || buttonParameter2 == null)
		{
			luaData.invalid = true;
			return;
		}
		luaData.buttonInt = (int)buttonType;
		luaData.buttonName = GetButtonTypeName((int)buttonType);
		luaData.keyName = ConvertName(buttonParameter.m_value);
		luaData.defKeyName = ConvertName(buttonParameter2.m_value);
	}

	public static string GetLayoutControlGroups(string key)
	{
		List<ControlGroup> controlGroups = InputManager.controlGroups;
		GetUserAndDefaultLayout(key, out var userLayout, out var defaultLayout);
		LayoutControlGroupsLuaData layoutControlGroupsLuaData = new LayoutControlGroupsLuaData
		{
			groups = new List<ControlGroupLuaData>()
		};
		foreach (ControlGroup item2 in controlGroups)
		{
			ControlGroupLuaData item = new ControlGroupLuaData(item2.controlType);
			item.conflictGroup = item2.conflictGroup;
			foreach (En_ButtonType key2 in item2.keys)
			{
				GetLayoutItemLuaData(userLayout, defaultLayout, key2, out var luaData);
				if (!luaData.invalid && luaData.defKeyName != "None")
				{
					item.items.Add(luaData);
				}
			}
			layoutControlGroupsLuaData.groups.Add(item);
		}
		return JsonUtility.ToJson(layoutControlGroupsLuaData);
	}

	public static int GetPlayerSelectJoystick()
	{
		return (int)GamepadManager.Instance.GetPlayerSelectJoystick();
	}

	public static void SetPlayerSelectJoystick(int gamepadType)
	{
		GamepadManager.Instance.SetPlayerSelectJoystick((En_GamepadType)gamepadType);
	}

	public static int GetPlayerSelectKeyboard()
	{
		return (int)GamepadManager.Instance.GetPlayerSelectKeyboard();
	}

	public static void SetPlayerSelectKeyboard(int gamepadType)
	{
		GamepadManager.Instance.SetPlayerSelectKeyboard((En_GamepadType)gamepadType);
	}

	public static void ForceSelectKeyboard(int gamepadType)
	{
		GamepadManager.Instance.ForceSelectKeyboard((En_GamepadType)gamepadType);
	}

	public static bool IsDeviceEnable(int gamepadType)
	{
		return GamepadManager.Instance.IsDeviceEnable((En_GamepadType)gamepadType);
	}

	public static void SetDeviceEnable(int gamepadType, bool val)
	{
		GamepadManager.Instance.SetDeviceEnable((En_GamepadType)gamepadType, val);
	}

	public static void SetNeedRemapNotice(int gamepadType, bool val)
	{
		HIDInputRemap.SetInputRemapPref((En_GamepadType)gamepadType, val);
	}

	public static bool GetNeedRemapNotice(int gamepadType)
	{
		return HIDInputRemap.GetInputRemapPrefCache((En_GamepadType)gamepadType);
	}
}
