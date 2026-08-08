using System;
using LuaInterface;

public class ViewAnimationManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ViewAnimationManager), typeof(object));
		L.RegFunction("Register", _Register);
		L.RegFunction("GetIsFirstEnter", GetIsFirstEnter);
		L.RegFunction("GetIsReturnFromBattle", GetIsReturnFromBattle);
		L.RegFunction("SetIsReturnFromBattle", SetIsReturnFromBattle);
		L.RegFunction("GetIsReturnFromSubView", GetIsReturnFromSubView);
		L.RegFunction("SetIsReturnFromSubView", SetIsReturnFromSubView);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("instance", get_instance, null);
		L.RegVar("isReturnFromBattle", get_isReturnFromBattle, set_isReturnFromBattle);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _Register(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ViewAnimationManager.Register(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsFirstEnter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool isFirstEnter = ViewAnimationManager.GetIsFirstEnter(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, isFirstEnter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsReturnFromBattle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool isReturnFromBattle = ViewAnimationManager.GetIsReturnFromBattle(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, isReturnFromBattle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIsReturnFromBattle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string viewName = ToLua.CheckString(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			ViewAnimationManager.SetIsReturnFromBattle(viewName, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsReturnFromSubView(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool isReturnFromSubView = ViewAnimationManager.GetIsReturnFromSubView(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, isReturnFromSubView);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIsReturnFromSubView(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string viewName = ToLua.CheckString(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			ViewAnimationManager.SetIsReturnFromSubView(viewName, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_instance(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, ViewAnimationManager.instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isReturnFromBattle(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, ViewAnimationManager.isReturnFromBattle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isReturnFromBattle(IntPtr L)
	{
		try
		{
			ViewAnimationManager.isReturnFromBattle = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
