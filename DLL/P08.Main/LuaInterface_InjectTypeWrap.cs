using System;
using LuaInterface;

public class LuaInterface_InjectTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(InjectType));
		L.RegVar("None", get_None, null);
		L.RegVar("After", get_After, null);
		L.RegVar("Before", get_Before, null);
		L.RegVar("Replace", get_Replace, null);
		L.RegVar("ReplaceWithPreInvokeBase", get_ReplaceWithPreInvokeBase, null);
		L.RegVar("ReplaceWithPostInvokeBase", get_ReplaceWithPostInvokeBase, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<InjectType>.Check = CheckType;
		StackTraits<InjectType>.Push = Push;
	}

	private static void Push(IntPtr L, InjectType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(InjectType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		ToLua.Push(L, InjectType.None);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_After(IntPtr L)
	{
		ToLua.Push(L, InjectType.After);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Before(IntPtr L)
	{
		ToLua.Push(L, InjectType.Before);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Replace(IntPtr L)
	{
		ToLua.Push(L, InjectType.Replace);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ReplaceWithPreInvokeBase(IntPtr L)
	{
		ToLua.Push(L, InjectType.ReplaceWithPreInvokeBase);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ReplaceWithPostInvokeBase(IntPtr L)
	{
		ToLua.Push(L, InjectType.ReplaceWithPostInvokeBase);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		InjectType injectType = (InjectType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, injectType);
		return 1;
	}
}
