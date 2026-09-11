using System;
using System.Collections.Generic;
using LuaInterface;

public class LuaProfilerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("LuaProfiler");
		L.RegFunction("Clear", Clear);
		L.RegFunction("GetID", GetID);
		L.RegFunction("BeginSample", BeginSample);
		L.RegFunction("EndSample", EndSample);
		L.RegVar("list", get_list, set_list);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaProfiler.Clear();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int iD = LuaProfiler.GetID(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushinteger(L, iD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BeginSample(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaProfiler.BeginSample((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndSample(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaProfiler.EndSample();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_list(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, LuaProfiler.list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_list(IntPtr L)
	{
		try
		{
			LuaProfiler.list = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
