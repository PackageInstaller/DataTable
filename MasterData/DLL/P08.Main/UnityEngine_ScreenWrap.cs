using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ScreenWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Screen");
		L.RegFunction("SetResolution", SetResolution);
		L.RegVar("width", get_width, null);
		L.RegVar("height", get_height, null);
		L.RegVar("dpi", get_dpi, null);
		L.RegVar("orientation", get_orientation, set_orientation);
		L.RegVar("sleepTimeout", get_sleepTimeout, set_sleepTimeout);
		L.RegVar("autorotateToPortrait", get_autorotateToPortrait, set_autorotateToPortrait);
		L.RegVar("autorotateToPortraitUpsideDown", get_autorotateToPortraitUpsideDown, set_autorotateToPortraitUpsideDown);
		L.RegVar("autorotateToLandscapeLeft", get_autorotateToLandscapeLeft, set_autorotateToLandscapeLeft);
		L.RegVar("autorotateToLandscapeRight", get_autorotateToLandscapeRight, set_autorotateToLandscapeRight);
		L.RegVar("currentResolution", get_currentResolution, null);
		L.RegVar("fullScreen", get_fullScreen, set_fullScreen);
		L.RegVar("fullScreenMode", get_fullScreenMode, set_fullScreenMode);
		L.RegVar("safeArea", get_safeArea, null);
		L.RegVar("resolutions", get_resolutions, null);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetResolution(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<bool>(L, 3))
			{
				int width = (int)LuaDLL.luaL_checknumber(L, 1);
				int height = (int)LuaDLL.luaL_checknumber(L, 2);
				bool fullscreen = LuaDLL.lua_toboolean(L, 3);
				Screen.SetResolution(width, height, fullscreen);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<FullScreenMode>(L, 3))
			{
				int width2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 2);
				FullScreenMode fullscreenMode = (FullScreenMode)ToLua.ToObject(L, 3);
				Screen.SetResolution(width2, height2, fullscreenMode);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<FullScreenMode, int>(L, 3))
			{
				int width3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height3 = (int)LuaDLL.luaL_checknumber(L, 2);
				FullScreenMode fullscreenMode2 = (FullScreenMode)ToLua.ToObject(L, 3);
				int preferredRefreshRate = (int)LuaDLL.lua_tonumber(L, 4);
				Screen.SetResolution(width3, height3, fullscreenMode2, preferredRefreshRate);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<bool, int>(L, 3))
			{
				int width4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height4 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool fullscreen2 = LuaDLL.lua_toboolean(L, 3);
				int preferredRefreshRate2 = (int)LuaDLL.lua_tonumber(L, 4);
				Screen.SetResolution(width4, height4, fullscreen2, preferredRefreshRate2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Screen.SetResolution");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_width(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Screen.width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Screen.height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dpi(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Screen.dpi);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_orientation(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Screen.orientation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sleepTimeout(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Screen.sleepTimeout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autorotateToPortrait(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Screen.autorotateToPortrait);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autorotateToPortraitUpsideDown(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Screen.autorotateToPortraitUpsideDown);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autorotateToLandscapeLeft(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Screen.autorotateToLandscapeLeft);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autorotateToLandscapeRight(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Screen.autorotateToLandscapeRight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentResolution(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Screen.currentResolution);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fullScreen(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Screen.fullScreen);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fullScreenMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Screen.fullScreenMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_safeArea(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Screen.safeArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resolutions(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Screen.resolutions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_orientation(IntPtr L)
	{
		try
		{
			Screen.orientation = (ScreenOrientation)ToLua.CheckObject(L, 2, typeof(ScreenOrientation));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sleepTimeout(IntPtr L)
	{
		try
		{
			Screen.sleepTimeout = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autorotateToPortrait(IntPtr L)
	{
		try
		{
			Screen.autorotateToPortrait = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autorotateToPortraitUpsideDown(IntPtr L)
	{
		try
		{
			Screen.autorotateToPortraitUpsideDown = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autorotateToLandscapeLeft(IntPtr L)
	{
		try
		{
			Screen.autorotateToLandscapeLeft = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autorotateToLandscapeRight(IntPtr L)
	{
		try
		{
			Screen.autorotateToLandscapeRight = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fullScreen(IntPtr L)
	{
		try
		{
			Screen.fullScreen = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fullScreenMode(IntPtr L)
	{
		try
		{
			Screen.fullScreenMode = (FullScreenMode)ToLua.CheckObject(L, 2, typeof(FullScreenMode));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
