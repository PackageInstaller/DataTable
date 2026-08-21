using System;
using LuaInterface;

public class UIScrollerOrientationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(UIScrollerOrientation));
		L.RegVar("SingleHorizontal", get_SingleHorizontal, null);
		L.RegVar("SingleVertical", get_SingleVertical, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<UIScrollerOrientation>.Check = CheckType;
		StackTraits<UIScrollerOrientation>.Push = Push;
	}

	private static void Push(IntPtr L, UIScrollerOrientation arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(UIScrollerOrientation), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SingleHorizontal(IntPtr L)
	{
		ToLua.Push(L, UIScrollerOrientation.SingleHorizontal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SingleVertical(IntPtr L)
	{
		ToLua.Push(L, UIScrollerOrientation.SingleVertical);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		UIScrollerOrientation uIScrollerOrientation = (UIScrollerOrientation)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, uIScrollerOrientation);
		return 1;
	}
}
