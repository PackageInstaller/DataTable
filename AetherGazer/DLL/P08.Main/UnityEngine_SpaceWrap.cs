using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SpaceWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(Space));
		L.RegVar("World", get_World, null);
		L.RegVar("Self", get_Self, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<Space>.Check = CheckType;
		StackTraits<Space>.Push = Push;
	}

	private static void Push(IntPtr L, Space arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(Space), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_World(IntPtr L)
	{
		ToLua.Push(L, Space.World);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Self(IntPtr L)
	{
		ToLua.Push(L, Space.Self);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		Space space = (Space)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, space);
		return 1;
	}
}
