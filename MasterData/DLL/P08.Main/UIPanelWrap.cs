using System;
using LuaInterface;
using UnityEngine;

public class UIPanelWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIPanel), typeof(MonoBehaviour));
		L.RegFunction("GetActive", GetActive);
		L.RegFunction("SetActive", SetActive);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("defaultActive", get_defaultActive, set_defaultActive);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool active = ((UIPanel)ToLua.CheckObject<UIPanel>(L, 1)).GetActive();
			LuaDLL.lua_pushboolean(L, active);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActive(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				UIPanel obj2 = (UIPanel)ToLua.CheckObject<UIPanel>(L, 1);
				bool value2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.SetActive(value2);
				return 0;
			}
			case 3:
			{
				UIPanel obj = (UIPanel)ToLua.CheckObject<UIPanel>(L, 1);
				bool value = LuaDLL.luaL_checkboolean(L, 2);
				bool isInit = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetActive(value, isInit);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIPanel.SetActive");
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
	private static int get_defaultActive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool defaultActive = ((UIPanel)obj).defaultActive;
			LuaDLL.lua_pushboolean(L, defaultActive);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultActive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultActive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIPanel obj2 = (UIPanel)obj;
			bool defaultActive = LuaDLL.luaL_checkboolean(L, 2);
			obj2.defaultActive = defaultActive;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultActive on a nil value");
		}
	}
}
