using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_TextAnchorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(TextAnchor));
		L.RegVar("UpperLeft", get_UpperLeft, null);
		L.RegVar("UpperCenter", get_UpperCenter, null);
		L.RegVar("UpperRight", get_UpperRight, null);
		L.RegVar("MiddleLeft", get_MiddleLeft, null);
		L.RegVar("MiddleCenter", get_MiddleCenter, null);
		L.RegVar("MiddleRight", get_MiddleRight, null);
		L.RegVar("LowerLeft", get_LowerLeft, null);
		L.RegVar("LowerCenter", get_LowerCenter, null);
		L.RegVar("LowerRight", get_LowerRight, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<TextAnchor>.Check = CheckType;
		StackTraits<TextAnchor>.Push = Push;
	}

	private static void Push(IntPtr L, TextAnchor arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(TextAnchor), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpperLeft(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.UpperLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpperCenter(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.UpperCenter);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpperRight(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.UpperRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MiddleLeft(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.MiddleLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MiddleCenter(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.MiddleCenter);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MiddleRight(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.MiddleRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LowerLeft(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.LowerLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LowerCenter(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.LowerCenter);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LowerRight(IntPtr L)
	{
		ToLua.Push(L, TextAnchor.LowerRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		TextAnchor textAnchor = (TextAnchor)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, textAnchor);
		return 1;
	}
}
