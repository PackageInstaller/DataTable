using System;
using LuaInterface;

public class UIScrollerAppearTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(UIScrollerAppearType));
		L.RegVar("All", get_All, null);
		L.RegVar("One", get_One, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<UIScrollerAppearType>.Check = CheckType;
		StackTraits<UIScrollerAppearType>.Push = Push;
	}

	private static void Push(IntPtr L, UIScrollerAppearType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(UIScrollerAppearType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_All(IntPtr L)
	{
		ToLua.Push(L, UIScrollerAppearType.All);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_One(IntPtr L)
	{
		ToLua.Push(L, UIScrollerAppearType.One);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		UIScrollerAppearType uIScrollerAppearType = (UIScrollerAppearType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, uIScrollerAppearType);
		return 1;
	}
}
