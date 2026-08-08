using System;
using LuaInterface;
using UnityEngine.UI;

public class UnityEngine_UI_ContentSizeFitter_FitModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(ContentSizeFitter.FitMode));
		L.RegVar("Unconstrained", get_Unconstrained, null);
		L.RegVar("MinSize", get_MinSize, null);
		L.RegVar("PreferredSize", get_PreferredSize, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<ContentSizeFitter.FitMode>.Check = CheckType;
		StackTraits<ContentSizeFitter.FitMode>.Push = Push;
	}

	private static void Push(IntPtr L, ContentSizeFitter.FitMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(ContentSizeFitter.FitMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Unconstrained(IntPtr L)
	{
		ToLua.Push(L, ContentSizeFitter.FitMode.Unconstrained);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MinSize(IntPtr L)
	{
		ToLua.Push(L, ContentSizeFitter.FitMode.MinSize);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PreferredSize(IntPtr L)
	{
		ToLua.Push(L, ContentSizeFitter.FitMode.PreferredSize);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		ContentSizeFitter.FitMode fitMode = (ContentSizeFitter.FitMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, fitMode);
		return 1;
	}
}
