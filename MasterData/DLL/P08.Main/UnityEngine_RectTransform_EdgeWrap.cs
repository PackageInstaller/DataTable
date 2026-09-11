using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RectTransform_EdgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(RectTransform.Edge));
		L.RegVar("Left", get_Left, null);
		L.RegVar("Right", get_Right, null);
		L.RegVar("Top", get_Top, null);
		L.RegVar("Bottom", get_Bottom, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<RectTransform.Edge>.Check = CheckType;
		StackTraits<RectTransform.Edge>.Push = Push;
	}

	private static void Push(IntPtr L, RectTransform.Edge arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(RectTransform.Edge), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Left(IntPtr L)
	{
		ToLua.Push(L, RectTransform.Edge.Left);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Right(IntPtr L)
	{
		ToLua.Push(L, RectTransform.Edge.Right);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Top(IntPtr L)
	{
		ToLua.Push(L, RectTransform.Edge.Top);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Bottom(IntPtr L)
	{
		ToLua.Push(L, RectTransform.Edge.Bottom);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		RectTransform.Edge edge = (RectTransform.Edge)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, edge);
		return 1;
	}
}
