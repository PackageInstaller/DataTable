using System;
using LuaInterface;

public class TimeUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("TimeUtil");
		L.RegFunction("NewUnityTimer", NewUnityTimer);
		L.RegFunction("DescLeftTime", DescLeftTime);
		L.RegFunction("GetSystemTime", GetSystemTime);
		L.RegFunction("TickToMilliSec", TickToMilliSec);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NewUnityTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TimerCenter o = TimeUtil.NewUnityTimer();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DescLeftTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = TimeUtil.DescLeftTime((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSystemTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			uint systemTime = TimeUtil.GetSystemTime();
			LuaDLL.lua_pushnumber(L, systemTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TickToMilliSec(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			long n = TimeUtil.TickToMilliSec(LuaDLL.tolua_checkint64(L, 1));
			LuaDLL.tolua_pushint64(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
