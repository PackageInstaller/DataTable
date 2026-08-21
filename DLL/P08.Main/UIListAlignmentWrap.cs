using System;
using LuaInterface;

public class UIListAlignmentWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(UIListAlignment));
		L.RegVar("Center", get_Center, null);
		L.RegVar("Center2", get_Center2, null);
		L.RegVar("Left", get_Left, null);
		L.RegVar("Right", get_Right, null);
		L.RegVar("Top", get_Top, null);
		L.RegVar("Bottom", get_Bottom, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<UIListAlignment>.Check = CheckType;
		StackTraits<UIListAlignment>.Push = Push;
	}

	private static void Push(IntPtr L, UIListAlignment arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(UIListAlignment), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Center(IntPtr L)
	{
		ToLua.Push(L, UIListAlignment.Center);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Center2(IntPtr L)
	{
		ToLua.Push(L, UIListAlignment.Center2);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Left(IntPtr L)
	{
		ToLua.Push(L, UIListAlignment.Left);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Right(IntPtr L)
	{
		ToLua.Push(L, UIListAlignment.Right);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Top(IntPtr L)
	{
		ToLua.Push(L, UIListAlignment.Top);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Bottom(IntPtr L)
	{
		ToLua.Push(L, UIListAlignment.Bottom);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		UIListAlignment uIListAlignment = (UIListAlignment)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, uIListAlignment);
		return 1;
	}
}
