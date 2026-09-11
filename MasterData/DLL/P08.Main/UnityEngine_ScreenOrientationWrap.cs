using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ScreenOrientationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(ScreenOrientation));
		L.RegVar("Unknown", get_Unknown, null);
		L.RegVar("Portrait", get_Portrait, null);
		L.RegVar("PortraitUpsideDown", get_PortraitUpsideDown, null);
		L.RegVar("LandscapeLeft", get_LandscapeLeft, null);
		L.RegVar("LandscapeRight", get_LandscapeRight, null);
		L.RegVar("AutoRotation", get_AutoRotation, null);
		L.RegVar("Landscape", get_Landscape, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<ScreenOrientation>.Check = CheckType;
		StackTraits<ScreenOrientation>.Push = Push;
	}

	private static void Push(IntPtr L, ScreenOrientation arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(ScreenOrientation), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Unknown(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.Unknown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Portrait(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.Portrait);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PortraitUpsideDown(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.PortraitUpsideDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LandscapeLeft(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.LandscapeLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LandscapeRight(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.LandscapeRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AutoRotation(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.AutoRotation);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Landscape(IntPtr L)
	{
		ToLua.Push(L, ScreenOrientation.LandscapeLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		ScreenOrientation screenOrientation = (ScreenOrientation)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, screenOrientation);
		return 1;
	}
}
