using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_TimeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Time");
		L.RegVar("time", get_time, null);
		L.RegVar("timeSinceLevelLoad", get_timeSinceLevelLoad, null);
		L.RegVar("deltaTime", get_deltaTime, null);
		L.RegVar("fixedTime", get_fixedTime, null);
		L.RegVar("unscaledTime", get_unscaledTime, null);
		L.RegVar("fixedUnscaledTime", get_fixedUnscaledTime, null);
		L.RegVar("unscaledDeltaTime", get_unscaledDeltaTime, null);
		L.RegVar("fixedUnscaledDeltaTime", get_fixedUnscaledDeltaTime, null);
		L.RegVar("fixedDeltaTime", get_fixedDeltaTime, set_fixedDeltaTime);
		L.RegVar("maximumDeltaTime", get_maximumDeltaTime, set_maximumDeltaTime);
		L.RegVar("smoothDeltaTime", get_smoothDeltaTime, null);
		L.RegVar("maximumParticleDeltaTime", get_maximumParticleDeltaTime, set_maximumParticleDeltaTime);
		L.RegVar("timeScale", get_timeScale, set_timeScale);
		L.RegVar("frameCount", get_frameCount, null);
		L.RegVar("renderedFrameCount", get_renderedFrameCount, null);
		L.RegVar("realtimeSinceStartup", get_realtimeSinceStartup, null);
		L.RegVar("captureFramerate", get_captureFramerate, set_captureFramerate);
		L.RegVar("inFixedTimeStep", get_inFixedTimeStep, null);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeSinceLevelLoad(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.timeSinceLevelLoad);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.deltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixedTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.fixedTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_unscaledTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.unscaledTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixedUnscaledTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.fixedUnscaledTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_unscaledDeltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.unscaledDeltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixedUnscaledDeltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.fixedUnscaledDeltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixedDeltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.fixedDeltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maximumDeltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.maximumDeltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_smoothDeltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.smoothDeltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maximumParticleDeltaTime(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.maximumParticleDeltaTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeScale(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.timeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Time.frameCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderedFrameCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Time.renderedFrameCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realtimeSinceStartup(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Time.realtimeSinceStartup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_captureFramerate(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Time.captureFramerate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inFixedTimeStep(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Time.inFixedTimeStep);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fixedDeltaTime(IntPtr L)
	{
		try
		{
			Time.fixedDeltaTime = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maximumDeltaTime(IntPtr L)
	{
		try
		{
			Time.maximumDeltaTime = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maximumParticleDeltaTime(IntPtr L)
	{
		try
		{
			Time.maximumParticleDeltaTime = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeScale(IntPtr L)
	{
		try
		{
			Time.timeScale = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_captureFramerate(IntPtr L)
	{
		try
		{
			Time.captureFramerate = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
