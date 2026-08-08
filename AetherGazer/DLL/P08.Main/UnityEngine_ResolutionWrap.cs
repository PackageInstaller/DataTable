using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ResolutionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Resolution), null);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateUnityEngine_Resolution);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("width", get_width, set_width);
		L.RegVar("height", get_height, set_height);
		L.RegVar("refreshRate", get_refreshRate, set_refreshRate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Resolution(IntPtr L)
	{
		ToLua.PushValue(L, default(Resolution));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((Resolution)ToLua.CheckObject(L, 1, typeof(Resolution))/*cast due to constrained. prefix*/).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int width = ((Resolution)obj).width;
			LuaDLL.lua_pushinteger(L, width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int height = ((Resolution)obj).height;
			LuaDLL.lua_pushinteger(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_refreshRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int refreshRate = ((Resolution)obj).refreshRate;
			LuaDLL.lua_pushinteger(L, refreshRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index refreshRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Resolution resolution = (Resolution)obj;
			int width = (int)LuaDLL.luaL_checknumber(L, 2);
			resolution.width = width;
			ToLua.SetBack(L, 1, resolution);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Resolution resolution = (Resolution)obj;
			int height = (int)LuaDLL.luaL_checknumber(L, 2);
			resolution.height = height;
			ToLua.SetBack(L, 1, resolution);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_refreshRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Resolution resolution = (Resolution)obj;
			int refreshRate = (int)LuaDLL.luaL_checknumber(L, 2);
			resolution.refreshRate = refreshRate;
			ToLua.SetBack(L, 1, resolution);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index refreshRate on a nil value");
		}
	}
}
