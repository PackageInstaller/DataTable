using System;
using LuaInterface;

public class LoadingUITypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(LoadingUIType));
		L.RegVar("Default", get_Default, null);
		L.RegVar("GameStart", get_GameStart, null);
		L.RegVar("Main", get_Main, null);
		L.RegVar("Battle", get_Battle, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<LoadingUIType>.Check = CheckType;
		StackTraits<LoadingUIType>.Push = Push;
	}

	private static void Push(IntPtr L, LoadingUIType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(LoadingUIType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Default(IntPtr L)
	{
		ToLua.Push(L, LoadingUIType.Default);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GameStart(IntPtr L)
	{
		ToLua.Push(L, LoadingUIType.GameStart);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Main(IntPtr L)
	{
		ToLua.Push(L, LoadingUIType.Main);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Battle(IntPtr L)
	{
		ToLua.Push(L, LoadingUIType.Battle);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		LoadingUIType loadingUIType = (LoadingUIType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, loadingUIType);
		return 1;
	}
}
