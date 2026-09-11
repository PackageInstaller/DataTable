using System;
using LuaInterface;
using UnityEngine;

public class LuaForGamepadWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaForGamepad), typeof(object));
		L.RegFunction("SetGamePadType", SetGamePadType);
		L.RegFunction("GetGamepadType", GetGamepadType);
		L.RegFunction("GetLayoutJson", GetLayoutJson);
		L.RegFunction("SaveLayoutJson", SaveLayoutJson);
		L.RegFunction("DeleteLayoutJson", DeleteLayoutJson);
		L.RegFunction("ReloadLayout", ReloadLayout);
		L.RegFunction("LoadLayoutFromJson", LoadLayoutFromJson);
		L.RegFunction("GetFirstInputValue", GetFirstInputValue);
		L.RegFunction("GetLastInputValue", GetLastInputValue);
		L.RegFunction("GetFirstDeltaInputValue", GetFirstDeltaInputValue);
		L.RegFunction("DisableListenerEnable", DisableListenerEnable);
		L.RegFunction("ClearInputValue", ClearInputValue);
		L.RegFunction("GetInputListString", GetInputListString);
		L.RegFunction("GetAllInputResultJson", GetAllInputResultJson);
		L.RegFunction("SetLayoutItem", SetLayoutItem);
		L.RegFunction("GetDefaultLayoutFileName", GetDefaultLayoutFileName);
		L.RegFunction("ConvertName", ConvertName);
		L.RegFunction("GetCameraSensitivity", GetCameraSensitivity);
		L.RegFunction("SetCameraSensitivity", SetCameraSensitivity);
		L.RegFunction("GetCursorSensitivity", GetCursorSensitivity);
		L.RegFunction("SetCursorSensitivity", SetCursorSensitivity);
		L.RegFunction("GetButtonTypeName", GetButtonTypeName);
		L.RegFunction("GetKeyIcon", GetKeyIcon);
		L.RegFunction("IsGamepadKey", IsGamepadKey);
		L.RegFunction("GetLayoutItem", GetLayoutItem);
		L.RegFunction("GetLayoutControlGroups", GetLayoutControlGroups);
		L.RegFunction("GetPlayerSelectJoystick", GetPlayerSelectJoystick);
		L.RegFunction("SetPlayerSelectJoystick", SetPlayerSelectJoystick);
		L.RegFunction("GetPlayerSelectKeyboard", GetPlayerSelectKeyboard);
		L.RegFunction("SetPlayerSelectKeyboard", SetPlayerSelectKeyboard);
		L.RegFunction("ForceSelectKeyboard", ForceSelectKeyboard);
		L.RegFunction("IsDeviceEnable", IsDeviceEnable);
		L.RegFunction("SetDeviceEnable", SetDeviceEnable);
		L.RegFunction("SetNeedRemapNotice", SetNeedRemapNotice);
		L.RegFunction("GetNeedRemapNotice", GetNeedRemapNotice);
		L.RegFunction("New", _CreateLuaForGamepad);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLuaForGamepad(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LuaForGamepad o = new LuaForGamepad();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaForGamepad.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGamePadType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForGamepad.SetGamePadType((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGamepadType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int gamepadType = LuaForGamepad.GetGamepadType();
			LuaDLL.lua_pushinteger(L, gamepadType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayoutJson(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string pKey = ToLua.CheckString(L, 1);
			string pLayoutName = ToLua.CheckString(L, 2);
			string layoutJson = LuaForGamepad.GetLayoutJson(pKey, pLayoutName);
			LuaDLL.lua_pushstring(L, layoutJson);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveLayoutJson(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string pKey = ToLua.CheckString(L, 1);
			string pJson = ToLua.CheckString(L, 2);
			LuaForGamepad.SaveLayoutJson(pKey, pJson);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteLayoutJson(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForGamepad.DeleteLayoutJson(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReloadLayout(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForGamepad.ReloadLayout();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadLayoutFromJson(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForGamepad.LoadLayoutFromJson(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFirstInputValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string firstInputValue = LuaForGamepad.GetFirstInputValue();
			LuaDLL.lua_pushstring(L, firstInputValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLastInputValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string lastInputValue = LuaForGamepad.GetLastInputValue();
			LuaDLL.lua_pushstring(L, lastInputValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFirstDeltaInputValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string firstDeltaInputValue = LuaForGamepad.GetFirstDeltaInputValue();
			LuaDLL.lua_pushstring(L, firstDeltaInputValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisableListenerEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForGamepad.DisableListenerEnable();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearInputValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForGamepad.ClearInputValue();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInputListString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string inputListString = LuaForGamepad.GetInputListString();
			LuaDLL.lua_pushstring(L, inputListString);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllInputResultJson(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string allInputResultJson = LuaForGamepad.GetAllInputResultJson();
			LuaDLL.lua_pushstring(L, allInputResultJson);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			string pKey = ToLua.CheckString(L, 1);
			string pLayoutName = ToLua.CheckString(L, 2);
			int pButtonType = (int)LuaDLL.luaL_checknumber(L, 3);
			string pValue = ToLua.CheckString(L, 4);
			LuaForGamepad.SetLayoutItem(pKey, pLayoutName, pButtonType, pValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDefaultLayoutFileName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string defaultLayoutFileName = LuaForGamepad.GetDefaultLayoutFileName(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, defaultLayoutFileName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConvertName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = LuaForGamepad.ConvertName(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCameraSensitivity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int cameraSensitivity = LuaForGamepad.GetCameraSensitivity();
			LuaDLL.lua_pushinteger(L, cameraSensitivity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraSensitivity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string pKey = ToLua.CheckString(L, 1);
			string pLayoutName = ToLua.CheckString(L, 2);
			int value = (int)LuaDLL.luaL_checknumber(L, 3);
			LuaForGamepad.SetCameraSensitivity(pKey, pLayoutName, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCursorSensitivity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string pKey = ToLua.CheckString(L, 1);
			string pLayoutName = ToLua.CheckString(L, 2);
			int cursorSensitivity = LuaForGamepad.GetCursorSensitivity(pKey, pLayoutName);
			LuaDLL.lua_pushinteger(L, cursorSensitivity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCursorSensitivity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string pKey = ToLua.CheckString(L, 1);
			string pLayoutName = ToLua.CheckString(L, 2);
			int value = (int)LuaDLL.luaL_checknumber(L, 3);
			LuaForGamepad.SetCursorSensitivity(pKey, pLayoutName, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetButtonTypeName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string buttonTypeName = LuaForGamepad.GetButtonTypeName((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushstring(L, buttonTypeName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetKeyIcon(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string key = ToLua.CheckString(L, 1);
			int gamepadType = (int)LuaDLL.luaL_checknumber(L, 2);
			Sprite keyIcon = LuaForGamepad.GetKeyIcon(key, gamepadType);
			ToLua.PushSealed(L, keyIcon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsGamepadKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = LuaForGamepad.IsGamepadKey(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayoutItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string key = ToLua.CheckString(L, 1);
			int buttonTypeInt = (int)LuaDLL.luaL_checknumber(L, 2);
			string layoutItem = LuaForGamepad.GetLayoutItem(key, buttonTypeInt);
			LuaDLL.lua_pushstring(L, layoutItem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayoutControlGroups(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string layoutControlGroups = LuaForGamepad.GetLayoutControlGroups(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, layoutControlGroups);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayerSelectJoystick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int playerSelectJoystick = LuaForGamepad.GetPlayerSelectJoystick();
			LuaDLL.lua_pushinteger(L, playerSelectJoystick);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerSelectJoystick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForGamepad.SetPlayerSelectJoystick((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayerSelectKeyboard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int playerSelectKeyboard = LuaForGamepad.GetPlayerSelectKeyboard();
			LuaDLL.lua_pushinteger(L, playerSelectKeyboard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerSelectKeyboard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForGamepad.SetPlayerSelectKeyboard((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceSelectKeyboard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForGamepad.ForceSelectKeyboard((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDeviceEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = LuaForGamepad.IsDeviceEnable((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDeviceEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int gamepadType = (int)LuaDLL.luaL_checknumber(L, 1);
			bool val = LuaDLL.luaL_checkboolean(L, 2);
			LuaForGamepad.SetDeviceEnable(gamepadType, val);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNeedRemapNotice(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int gamepadType = (int)LuaDLL.luaL_checknumber(L, 1);
			bool val = LuaDLL.luaL_checkboolean(L, 2);
			LuaForGamepad.SetNeedRemapNotice(gamepadType, val);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNeedRemapNotice(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool needRemapNotice = LuaForGamepad.GetNeedRemapNotice((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, needRemapNotice);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
