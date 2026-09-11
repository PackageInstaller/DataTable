using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_ToggleGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ToggleGroup), typeof(UIBehaviour));
		L.RegFunction("NotifyToggleOn", NotifyToggleOn);
		L.RegFunction("UnregisterToggle", UnregisterToggle);
		L.RegFunction("RegisterToggle", RegisterToggle);
		L.RegFunction("EnsureValidState", EnsureValidState);
		L.RegFunction("AnyTogglesOn", AnyTogglesOn);
		L.RegFunction("ActiveToggles", ActiveToggles);
		L.RegFunction("GetFirstActiveToggle", GetFirstActiveToggle);
		L.RegFunction("SetAllTogglesOff", SetAllTogglesOff);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("allowSwitchOff", get_allowSwitchOff, set_allowSwitchOff);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NotifyToggleOn(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ToggleGroup obj2 = (ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1);
				Toggle toggle2 = (Toggle)ToLua.CheckObject<Toggle>(L, 2);
				obj2.NotifyToggleOn(toggle2);
				return 0;
			}
			case 3:
			{
				ToggleGroup obj = (ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1);
				Toggle toggle = (Toggle)ToLua.CheckObject<Toggle>(L, 2);
				bool sendCallback = LuaDLL.luaL_checkboolean(L, 3);
				obj.NotifyToggleOn(toggle, sendCallback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.ToggleGroup.NotifyToggleOn");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnregisterToggle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ToggleGroup obj = (ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1);
			Toggle toggle = (Toggle)ToLua.CheckObject<Toggle>(L, 2);
			obj.UnregisterToggle(toggle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RegisterToggle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ToggleGroup obj = (ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1);
			Toggle toggle = (Toggle)ToLua.CheckObject<Toggle>(L, 2);
			obj.RegisterToggle(toggle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnsureValidState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1)).EnsureValidState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AnyTogglesOn(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1)).AnyTogglesOn();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ActiveToggles(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerable<Toggle> o = ((ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1)).ActiveToggles();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFirstActiveToggle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Toggle firstActiveToggle = ((ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1)).GetFirstActiveToggle();
			ToLua.Push(L, firstActiveToggle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAllTogglesOff(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1)).SetAllTogglesOff();
				return 0;
			case 2:
			{
				ToggleGroup obj = (ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 1);
				bool allTogglesOff = LuaDLL.luaL_checkboolean(L, 2);
				obj.SetAllTogglesOff(allTogglesOff);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.ToggleGroup.SetAllTogglesOff");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowSwitchOff(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowSwitchOff = ((ToggleGroup)obj).allowSwitchOff;
			LuaDLL.lua_pushboolean(L, allowSwitchOff);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowSwitchOff on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowSwitchOff(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ToggleGroup obj2 = (ToggleGroup)obj;
			bool allowSwitchOff = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowSwitchOff = allowSwitchOff;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowSwitchOff on a nil value");
		}
	}
}
