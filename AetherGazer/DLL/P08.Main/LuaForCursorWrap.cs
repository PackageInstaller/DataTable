using System;
using LuaInterface;
using UnityEngine;

public class LuaForCursorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaForCursor), typeof(object));
		L.RegFunction("UseSystemCursor", UseSystemCursor);
		L.RegFunction("SwitchCursor", SwitchCursor);
		L.RegFunction("SetCanMove", SetCanMove);
		L.RegFunction("SetFullscreenScrollObject", SetFullscreenScrollObject);
		L.RegFunction("SetKeyboardAutoHide", SetKeyboardAutoHide);
		L.RegFunction("GetKeyboardAutoHide", GetKeyboardAutoHide);
		L.RegFunction("SetBattleShowCursor", SetBattleShowCursor);
		L.RegFunction("GetBattleShowCursor", GetBattleShowCursor);
		L.RegFunction("ResizeCursor", ResizeCursor);
		L.RegFunction("New", _CreateLuaForCursor);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLuaForCursor(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LuaForCursor o = new LuaForCursor();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaForCursor.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UseSystemCursor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForCursor.UseSystemCursor(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SwitchCursor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForCursor.SwitchCursor(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCanMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForCursor.SetCanMove(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFullscreenScrollObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForCursor.SetFullscreenScrollObject((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetKeyboardAutoHide(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForCursor.SetKeyboardAutoHide(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetKeyboardAutoHide(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool keyboardAutoHide = LuaForCursor.GetKeyboardAutoHide();
			LuaDLL.lua_pushboolean(L, keyboardAutoHide);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBattleShowCursor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForCursor.SetBattleShowCursor(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBattleShowCursor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool battleShowCursor = LuaForCursor.GetBattleShowCursor();
			LuaDLL.lua_pushboolean(L, battleShowCursor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResizeCursor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = LuaForCursor.ResizeCursor((float)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
