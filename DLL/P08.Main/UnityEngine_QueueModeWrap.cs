using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_QueueModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(QueueMode));
		L.RegVar("CompleteOthers", get_CompleteOthers, null);
		L.RegVar("PlayNow", get_PlayNow, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<QueueMode>.Check = CheckType;
		StackTraits<QueueMode>.Push = Push;
	}

	private static void Push(IntPtr L, QueueMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(QueueMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CompleteOthers(IntPtr L)
	{
		ToLua.Push(L, QueueMode.CompleteOthers);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayNow(IntPtr L)
	{
		ToLua.Push(L, QueueMode.PlayNow);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		QueueMode queueMode = (QueueMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, queueMode);
		return 1;
	}
}
