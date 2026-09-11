using System;
using LuaInterface;

public class UIRedPointStyleWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(UIRedPointStyle));
		L.RegVar("None", get_None, null);
		L.RegVar("Normal", get_Normal, null);
		L.RegVar("New", get_New, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<UIRedPointStyle>.Check = CheckType;
		StackTraits<UIRedPointStyle>.Push = Push;
	}

	private static void Push(IntPtr L, UIRedPointStyle arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(UIRedPointStyle), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		ToLua.Push(L, UIRedPointStyle.None);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Normal(IntPtr L)
	{
		ToLua.Push(L, UIRedPointStyle.Normal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_New(IntPtr L)
	{
		ToLua.Push(L, UIRedPointStyle.New);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		UIRedPointStyle uIRedPointStyle = (UIRedPointStyle)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, uIRedPointStyle);
		return 1;
	}
}
