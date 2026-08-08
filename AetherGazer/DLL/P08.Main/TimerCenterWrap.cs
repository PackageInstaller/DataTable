using System;
using LuaInterface;

public class TimerCenterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TimerCenter), typeof(object));
		L.RegFunction("SetTimer", SetTimer);
		L.RegFunction("GetTimer", GetTimer);
		L.RegFunction("DeleteTimer", DeleteTimer);
		L.RegFunction("Schedule", Schedule);
		L.RegFunction("Pause", Pause);
		L.RegFunction("Resume", Resume);
		L.RegFunction("New", _CreateTimerCenter);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTimerCenter(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				TimerCenter o = new TimerCenter((Func<long>)ToLua.CheckDelegate<Func<long>>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: TimerCenter.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			TimerCenter obj = (TimerCenter)ToLua.CheckObject<TimerCenter>(L, 1);
			string name = ToLua.CheckString(L, 2);
			float delay = (float)LuaDLL.luaL_checknumber(L, 3);
			int duration = (int)LuaDLL.luaL_checknumber(L, 4);
			Action onTimer = (Action)ToLua.CheckDelegate<Action>(L, 5);
			int n = obj.SetTimer(name, delay, duration, onTimer);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimerCenter obj = (TimerCenter)ToLua.CheckObject<TimerCenter>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			bool timer = obj.GetTimer(timerId);
			LuaDLL.lua_pushboolean(L, timer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimerCenter obj = (TimerCenter)ToLua.CheckObject<TimerCenter>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.DeleteTimer(timerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Schedule(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TimerCenter)ToLua.CheckObject<TimerCenter>(L, 1)).Schedule();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Pause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TimerCenter)ToLua.CheckObject<TimerCenter>(L, 1)).Pause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Resume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TimerCenter)ToLua.CheckObject<TimerCenter>(L, 1)).Resume();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
