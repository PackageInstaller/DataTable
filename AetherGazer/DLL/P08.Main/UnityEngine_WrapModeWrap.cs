using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_WrapModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(WrapMode));
		L.RegVar("Once", get_Once, null);
		L.RegVar("Loop", get_Loop, null);
		L.RegVar("PingPong", get_PingPong, null);
		L.RegVar("Default", get_Default, null);
		L.RegVar("ClampForever", get_ClampForever, null);
		L.RegVar("Clamp", get_Clamp, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<WrapMode>.Check = CheckType;
		StackTraits<WrapMode>.Push = Push;
	}

	private static void Push(IntPtr L, WrapMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(WrapMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Once(IntPtr L)
	{
		ToLua.Push(L, WrapMode.Once);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Loop(IntPtr L)
	{
		ToLua.Push(L, WrapMode.Loop);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PingPong(IntPtr L)
	{
		ToLua.Push(L, WrapMode.PingPong);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Default(IntPtr L)
	{
		ToLua.Push(L, WrapMode.Default);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ClampForever(IntPtr L)
	{
		ToLua.Push(L, WrapMode.ClampForever);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Clamp(IntPtr L)
	{
		ToLua.Push(L, WrapMode.Once);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		WrapMode wrapMode = (WrapMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, wrapMode);
		return 1;
	}
}
