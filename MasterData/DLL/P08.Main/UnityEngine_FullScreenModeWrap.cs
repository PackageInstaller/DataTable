using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_FullScreenModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(FullScreenMode));
		L.RegVar("ExclusiveFullScreen", get_ExclusiveFullScreen, null);
		L.RegVar("FullScreenWindow", get_FullScreenWindow, null);
		L.RegVar("MaximizedWindow", get_MaximizedWindow, null);
		L.RegVar("Windowed", get_Windowed, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<FullScreenMode>.Check = CheckType;
		StackTraits<FullScreenMode>.Push = Push;
	}

	private static void Push(IntPtr L, FullScreenMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(FullScreenMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ExclusiveFullScreen(IntPtr L)
	{
		ToLua.Push(L, FullScreenMode.ExclusiveFullScreen);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FullScreenWindow(IntPtr L)
	{
		ToLua.Push(L, FullScreenMode.FullScreenWindow);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MaximizedWindow(IntPtr L)
	{
		ToLua.Push(L, FullScreenMode.MaximizedWindow);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Windowed(IntPtr L)
	{
		ToLua.Push(L, FullScreenMode.Windowed);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		FullScreenMode fullScreenMode = (FullScreenMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, fullScreenMode);
		return 1;
	}
}
